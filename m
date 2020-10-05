Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65428362B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJENEZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgJENEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5889C0613AF
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 05:56:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lw21so7770569ejb.6
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+L2aZyvxl4W8khmOuNAlUi/cVzcrgmy9s9w3VWgBV8I=;
        b=poDQ+3dDBBHHsnuLdAryprh10yZj22wwbBMijBWGVx4zvrSdvm7sfnCtNnAAtzPhU6
         4Ph36acOYz0iQfOqEuU3FQzeDVOT8dsEOEodkIMFyn40TdsPzUeRuuvShO7RQ1eYAkbS
         ZUg4iGMiHCZdcsrfVFx5Z3nFhdpKruCbs3H1QDSqK/p+UynA5QGc5kjengWnlvYh3bFr
         HsYHdGEmASM+nlJwMoezB+cWRDzuzUH/ywrutVLstAW/sPKR1S1rCykJIfi1jGEiyjI4
         7RzOYJ81tHXkzc5VmdJs8VfGDZ4+CPnJce/memitQFtfKMJqJSq7WNp8kycyQpn96WxQ
         gpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+L2aZyvxl4W8khmOuNAlUi/cVzcrgmy9s9w3VWgBV8I=;
        b=sNnyc4QmIjO5PenvlBeTMv66q5FlIoMS9kgUqUXGyxqFvbjG++tbPTgee8TiMoRuCe
         nFuCeaC9PJZ6FDUcsHfAEyc4XBdg8UZhhWAKr0BXQrW2pB22G5mUljKL4a51LE0Dke12
         6yhPJTLY2jeHC0dw4XfMNwyg9f/NFyysnuWlg8hKGRCjXMBtbzRmHzGWubxqoQGHJuVM
         gh3bo9XjFbnaKERN25rgisatQI4Ad7mIsgN+zTr3t4RF4hjQFNiSfV6f1dhw+uNu3RtB
         ZVwCpjfPXJjzA7Qy+NnY7MonUwFSstZv8son24HKOWGcWbsyjg/tan9CTFAFFS8eFUrb
         tZVw==
X-Gm-Message-State: AOAM533by5IgkazAndFBSmcsvH9l+8O5ZvWukVaPHeBD+GFHkH9lC85p
        5egrFQMq1Zmqq/QTwtzqDNs=
X-Google-Smtp-Source: ABdhPJwyHF9oMb4acoT86AJApwwKs1GKVpyalexHqUxVgGazPBhbpbTcl+UzYey9bKrLEa19095Bfg==
X-Received: by 2002:a17:906:a1d4:: with SMTP id bx20mr15233015ejb.262.1601902609082;
        Mon, 05 Oct 2020 05:56:49 -0700 (PDT)
Received: from localhost (catv-86-101-16-255.catv.broadband.hu. [86.101.16.255])
        by smtp.gmail.com with ESMTPSA id g9sm5816200edv.81.2020.10.05.05.56.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 05:56:48 -0700 (PDT)
Sender: Thomas Nagy <bkil.hu@gmail.com>
From:   bkil <b.K.il.h.u+tigbuh@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: restore channel 12 & 13 limitation in the US
Date:   Mon,  5 Oct 2020 14:56:38 +0200
Message-Id: <840438bf70c72d2ab933aee9ae5aa6985b6c1531.1601902597.git.b.K.il.h.u+tigbuh@gmail.com>
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
