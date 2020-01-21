Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F6144485
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 19:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAUSpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 13:45:05 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:42399 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSpF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 13:45:05 -0500
Received: by mail-qv1-f53.google.com with SMTP id dc14so1953612qvb.9
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2020 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=FeOFghGrmcA+YWk9xGzeEU37IWVrqXbmdpbExs/ASjI=;
        b=SQ36kL18YUHUZRrUgufKNNWAh0ZW+dNkqA15VEdK+O6monhuli3rGIHJYU7JV44Cxt
         Q9+D+9r3E9FGZ4g7wtWlLNpjzHUfu/QIBCXarrkl88G/hCBsoAhnLfttOlg0/0EzkYrK
         lwJVJ72r6vJ9VVfaApayYsxajzOAHuDODZO1N1fjr8xxZjMtKRuow6jd4zSdMLST2kv2
         j7l4gvOdbbpOPPFeS0cE/WpJ7usO4llBjN4rThR9sAeQyiYS8BYK0W7Vv5vU7ljKDlrD
         WKuknVrThHPmr9YoDI7WUbbXkXY2As5o6dhiMz7uRZ3DAGsRQ/b+DauzsxYPoXncthFS
         mXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=FeOFghGrmcA+YWk9xGzeEU37IWVrqXbmdpbExs/ASjI=;
        b=Urp4U/8Jl2fQP9XPcsgGppxvxkQBbKMq+WJ8v9VmwP4L5Toj2n13gsspeQWjwU9SE2
         IiJxE9FYfgo+hOkJ/wcrhsc6XjeFP6KjjxtpWzT0/eeIYvtOCi4D55uy/tPm4kDTOJsv
         9je8dEqJK9jwwuIUuhFyhUEi6wt5GSnmlcxzUDg9rCVEBWUNLJA/wx8IaRcW6I7bzyYt
         mc8LXGrHIDsRQGHNpUiWZoXdErfUKU9DD85SpGRhaz38iu9W8izNjNFI/iEl1fA8WxkQ
         9yoymGcV/AQwwhEtiYRYmUb+cwKTQQR2oknos6+YcNs1A4VAGpNHp7cuGSFutsLbLiC5
         P5+g==
X-Gm-Message-State: APjAAAX9me7oHlWbeHWJw0Ly/CMU66FBPKScf8MGj15uKwUuzS8mqDEZ
        wRI9HKpfyItE1fsLsBUkhsU47frc
X-Google-Smtp-Source: APXvYqxxWu8gsCH8xU/NsCtjYKDlk3H6/5+1S5b3+cgjmKJqtZyDvNG+CdIJYeTGvUUCKS2WZO0yKw==
X-Received: by 2002:a05:6214:94b:: with SMTP id dn11mr6171456qvb.12.1579632304071;
        Tue, 21 Jan 2020 10:45:04 -0800 (PST)
Received: from [192.168.0.10] (dhcp-108-168-58-21.cable.user.start.ca. [108.168.58.21])
        by smtp.gmail.com with ESMTPSA id b24sm19540670qto.71.2020.01.21.10.45.02
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 10:45:03 -0800 (PST)
Message-ID: <1579632300.17789.18.camel@gmail.com>
Subject: RT5370 performance issues
From:   Marlon Smith <marlon.smith10@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Tue, 21 Jan 2020 13:45:00 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi everyone,

I'm having some trouble with an RT5370 Wi-Fi module on an embedded
Linux system. With just one of these modules connected to an access
point, performance is around 30 Mbit/s. However, as soon as a second
module is connected to the access point, performance drops to about 3
Mbit/s.

With debug output enabled, there are many copies of this message:

wlan0: release an RX reorder frame due to timeout on earlier frames

which seems to be related to MDPU aggregation. So, I went into
rt2800lib.c in the function rt2800_ampdu_action and added the line
ret = -ENOTSUPP; to disable support for RX frame aggregation:

	switch (action) {
	case IEEE80211_AMPDU_RX_START:
	case IEEE80211_AMPDU_RX_STOP:
		ret = -ENOTSUPP;
	...

After that change, debug output shows:

wlan0: AddBA Req buf_size=64 for 00:ad:24:ff:6c:a0
wlan0: Rx A-MPDU request on 00:ad:24:ff:6c:a0 tid 0 result -524

and performance seems to be maybe slightly faster but not by much.

I'm using backports, and have tried with version 5.3-rc4 and 
4.14-rc2. I've also tried several versions of the device firmware
file rt2870.bin; 0.36, 0.33, and 0.22.

Many thanks for any ideas you can offer.

Marlon

