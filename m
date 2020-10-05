Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34236283600
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJENBc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 09:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJENBc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67632C0613B8
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 06:01:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l24so9209127edj.8
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+L2aZyvxl4W8khmOuNAlUi/cVzcrgmy9s9w3VWgBV8I=;
        b=AxhWCAo09E6pqESoPistNy4SDg2FO9APYl38SqOCh5AV0H9XuOvenVZfsrreNQy8q+
         /Ux6VVOlE8d8LOn193QsvYski1+pdBxIe+pcD3/93MCLZ+QMOvMfi+Dqnm9U0LOqEggq
         NOR3b5902hm9+AlyFYXZT5zX845k4f92AA3W4vcG4Nf7PNv46HjZsoM56vHmzxyRESUq
         eUbCpKPPWwypL+dWPM6hlsv27SSupPasGUjTZF59nKTURjsneXS8XCK6mlAM3akdB6jz
         Yb8AMPaJrgpzusSwNTt9gDOxQ8SRZJHhGHvhhTpyD5UxBMJ6jk7dm8Gg2LdWRQosNCQ6
         Xjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+L2aZyvxl4W8khmOuNAlUi/cVzcrgmy9s9w3VWgBV8I=;
        b=fqite8d8IbVZ4qebx9VbHI204IfMOQd2jkPxF1R90hkvFvmaERPm1S04mY0gs15+bN
         uH2hJxruSXZTYDuO1nRy9mGp8insIJJRb7eR+cbF/xt6cobF1O/U6FvJ5BVw+ruJ/ZCE
         HV6MVWDi8wJdSW4ZXklpGD/esWvU668iUR37YdB4IZx6wPv+sRZl23VOsdgthJH8qUAR
         DYqQHEENfqhcVdTcSYyIt6tlo8OAjWXdb9HYpH/YBJG54BkCLw4SEPkcGyJg+9hOnHRR
         295UBthXEbFqipP78jSpURkmwtMyzPrDW8V7A2GFFiOENV+XeN+BkTKKQkfWhQ68/ZLs
         gBmg==
X-Gm-Message-State: AOAM533NC/f9NsP/MqM2GszblEVLSvXpJSQIR70gW5zHHfB6Acbqmiwh
        JemQtklfWteXU2jppGcx9RA=
X-Google-Smtp-Source: ABdhPJwxOlJhQ4VkFh0fTPQadR8wrdlSgKA6YtHNkOSADBvlx5GXlZ4Ao/tW/UcVRhS0t2BJ8pYMnw==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr17379911edu.156.1601902890994;
        Mon, 05 Oct 2020 06:01:30 -0700 (PDT)
Received: from localhost (catv-86-101-16-255.catv.broadband.hu. [86.101.16.255])
        by smtp.gmail.com with ESMTPSA id p24sm3489966edq.35.2020.10.05.06.01.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 06:01:28 -0700 (PDT)
Sender: Thomas Nagy <bkil.hu@gmail.com>
From:   bkil <b.K.il.h.u+tigbuh@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: restore channel 12 & 13 limitation in the US
Date:   Mon,  5 Oct 2020 15:01:22 +0200
Message-Id: <840438bf70c72d2ab933aee9ae5aa6985b6c1531.1601902881.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The precisely allowed transmission power on channel 12 & 13 is not clear.

I did some fact checking and document reviews in the past, but still
failed to come up with an exact reference or calculation regarding what TX
power should be allowed in general to reduce interference in the
neighboring restricted band 2483.5-2500 MHz and whether indoor vs. outdoor
and b/g/n modulation would make a difference (probably yes).

Existing documents that discuss this are vague and pretty much out of date:
https://en.wikipedia.org/wiki/List_of_WLAN_channels#endnote_B

Following these guidelines, I failed to come up with an approximate
formula that would prohibit usage of channel 12 & 13, but still allow
usage of channel 11 with full power, hence at least part of the argument
for prohibiting channel 12 & 13 needs to be refined.

Until further research, just to stay safe, I propose that we restore the
previous limitation of disabling channel 12 & 13 as before. We should
work towards finding a safe transmission power to use on both and specify
that (like 50mW on channel 13 and 100mW on channel 12?).

I've also started a discussion for investigation on Wikipedia:
https://en.wikipedia.org/wiki/Talk:List_of_WLAN_channels#Should_the_2.4GHz_=
channel_12_and_13_in_the_USA_need_updating?

Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
---
 db.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index ac32483..68613cf 100644
--- a/db.txt
+++ b/db.txt
@@ -1568,8 +1568,12 @@ country UG: DFS-FCC
=20
 # https://www.ecfr.gov/cgi-bin/text-idx?SID=3Deed706a2c49fd9271106c3228b06=
15f3&mc=3Dtrue&node=3Dpt47.1.15&rgn=3Ddiv5
 # Title 47 Part 15 - Radio Frequency Devices, April 2, 2020
+# Channels 12 and 13 are not forbidden, but are not normally used with full
+# power in order to avoid any potential interference in the adjacent restr=
icted
+# frequency band, 2,483.5=E2=80=932,500 MHz which is subject to strict emi=
ssion limits
+# set out in 47 CFR =C2=A7 15.205. TODO: reenable and specify a safe TX po=
wer here.
 country US: DFS-FCC
-	(2400 - 2483.5 @ 40), (30)
+	(2400 - 2472 @ 40), (30)
 	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
 	(5150 - 5250 @ 80), (23), AUTO-BW
 	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
