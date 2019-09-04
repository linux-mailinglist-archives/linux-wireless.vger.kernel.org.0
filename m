Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B748CA7FE7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 12:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfIDKBQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 06:01:16 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:39487 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfIDKBQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 06:01:16 -0400
Received: by mail-lf1-f50.google.com with SMTP id l11so15405198lfk.6
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=V0Mf2ZXillY6hvYcBPK7m2UMkeRJi1VCx4kOhhDXxUM=;
        b=CKPYt6IvRnN1uxvZYA6XDithl1KDtG82stauZkdOL+dmcni3mNMg3Y3HOb3Q3HpvzH
         PUbq99k1lfUYOzAA2ZHAz5UYw7KV/c5f+OuwxTHb2d9CKXQk9PwtIAal3NR1+t9fIEnW
         4OvdD9+c/ej+wv3BhYqlpdgFb1nBegCubmGbq6ECo5ZSHSx9qXTyp731K6wNyXMFCxE0
         oVuTpqALc97yFBzZit5Spz4ITbGmuo5tD3YyyOBi0V3Ae0xeGIygkqrukptpIa/9PJG7
         W56TmqbTouuxiTzWLd3HOFRgLJpwxyWq9DHgWwzzvpGSZ+fQUknTSeNCkt382C88uiwB
         HOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=V0Mf2ZXillY6hvYcBPK7m2UMkeRJi1VCx4kOhhDXxUM=;
        b=YAxSECv8l5BcHSdEVnYn2Kg7sJaSsHMnarK+CrzUTqXLWTbfp0L5IShJ+T8bx4HGfX
         yHo2Gf+ubWZgfCJz20uEX277t0avega0gSuOBOzMR5nX+Bh7xmP663d1a4wDWpepvxwx
         cBZ3Uvv33pNOuC1X9E6kQt4e87zz9ZcazSxdpxZ2szsG9S8ONrRXHzc8qrd109uPy1Yg
         njYpLY3ts2qs/Mvlk0HPmztkQEYkn4c3AJ/bfyy86B6lMT22BwIzPMiGmWqWR9RE+Qe6
         3Gegt7JtD7nMU5weFiKBmwlDzee84xqv4TYWe37XLKpTAkyExt5k5dumaKj6CzbTFM8S
         987g==
X-Gm-Message-State: APjAAAU3AKQzURMM7ZnbY/ETUd4xJBnMjQmAPIX83RbPofnF0ej/jKFq
        pY3NeOq/74aUkOS02xfCrN4=
X-Google-Smtp-Source: APXvYqxLuWH/C72kaXEWeAamaMlL3HIHXMnLSuA0bm4ScDBIwnsAoKoqtf+AEs3mmUPkoaKgbcc9eg==
X-Received: by 2002:a19:9104:: with SMTP id t4mr22353895lfd.179.1567591274431;
        Wed, 04 Sep 2019 03:01:14 -0700 (PDT)
Received: from Timur-XPS ([185.252.118.68])
        by smtp.gmail.com with ESMTPSA id l23sm3236356lje.106.2019.09.04.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 03:01:13 -0700 (PDT)
Message-ID: <c74b5248ab0d5d5fa73226494c2179eeb767d725.camel@gmail.com>
Subject: QCA6174 ath10k firmware crash on kernel 5.x
From:   Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To:     ath10k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 04 Sep 2019 13:01:10 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've got a QCA6174 wireless device in my Dell XPS 13 9370. There is a
problematic AP, and every time I connect to this AP, the connection
only works for a couple of hours and then it stops working until I
disable and re-enable the wireless adapter.

Here is the dmesg log:
https://pastebin.com/CnbBSNg3

There is a firmware crash. Then the driver fails to read the firmware
dump.

Note that I've only seen the problem with this specific AP and not
others. Is there any way I can figure out what exactly is it with this
AP that triggers the problem?

Thanks & best regards,
Tim

ps. I'm not on the mailing list, please CC me on your replies.

