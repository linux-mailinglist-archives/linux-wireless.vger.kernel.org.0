Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF24A365D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 13:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347052AbiA3Mtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 07:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354807AbiA3Mti (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 07:49:38 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA4BC061714
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jan 2022 04:49:37 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Jmrcb4Hy0z9sTN;
        Sun, 30 Jan 2022 13:49:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1643546973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzXzlkaoOK5xu02ZaK3t0lcbzHgPPZLbGSEovmpiwXY=;
        b=cXQWQk6Hk095p56KH57f13GTjgX4JKaYDsbSKAea0jI+oGZzCo/Dz6CSadW02Tzr0tOQOB
        mj1RAMiVAMgFdb7Ii4f3yjiOZubiIJbvVg45jRaiIwUubPmNJHZ2O1LJn9XcxwMhP9XADV
        nDECR9c2CCZm0qt46+Wtkl9BbWWtW1MgijwodVIqJRIX8DoHNuM9+2UAWVWlEwkaqLkKqO
        g9AMRskUzuXHAa2SXEOwKdt8sSVWXFkIkO7KTamODNHnldeBNqKm0UflT9fUVyK02lKrAk
        7iCrsYlony76HeR420oiMKnYpvz2d/x1MqgIkZECdPi8iQVxEj3sZxWAkzDZxA==
From:   Sungbo Eo <mans0n@gorani.run>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH v4] wireless-regdb: Update regulatory rules for South Korea (KR)
Date:   Sun, 30 Jan 2022 21:49:07 +0900
Message-Id: <20220130124907.39224-1-mans0n@gorani.run>
In-Reply-To: <20211212152050.25962-1-mans0n@gorani.run>
References: <20211212152050.25962-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is based on MSIT Public Notification 2021-86 ("Unlicensed Radio
Equipment Established Without Notice"), officially announced on 2021-11-29.

The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
This leads to the following:
* 5230-5250 @ 20 -> 17 dBm
* 5210-5250 @ 40 -> 20 dBm
Here the power limit for >20 MHz bandwidth is also lowered to 17 dBm, as
it's not possible to set different power limits for different bandwidths
at the moment.

Extend the last 5 GHz frequency range to 5850 MHz.

Wi-Fi 6E is now allowed with the following restrictions:
* Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 2 dBm/MHz PSD
* Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25 mW EIRP
Here only the former entry is added.

And also update the regulatory source links.

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
---
v4:
* merge 5210-5230 MHz band rule
* revert back to "indoor only" 6E rule as its power limit is higher

v3:
* update regulatory source to newer revision
* replace "indoor only" 6E rule with "both indoor and outdoor" rule
  as "indoor only" rule limits PSD instead of EIRP

v2:
* split 5150-5250 MHz band rule to accommodate the PSD limit
* remove AUTO-BW flag from 6 GHz band rule
---
 db.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index b898799..9b02a2c 100644
--- a/db.txt
+++ b/db.txt
@@ -862,15 +862,21 @@ country KP: DFS-JP
 	(5490 - 5630 @ 20), (30), DFS
 	(5735 - 5815 @ 20), (30)
 
+# Source:
+# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205195
+# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205187
+# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000206568
 country KR: DFS-JP
-	# ref: https://www.rra.go.kr
 	(2400 - 2483.5 @ 40), (23)
-	(5150 - 5250 @ 80), (23), AUTO-BW
+	(5150 - 5230 @ 40), (23), AUTO-BW
+	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
+	(5230 - 5250 @ 20), (17), AUTO-BW
 	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
 	(5470 - 5725 @ 160), (20), DFS
-	(5725 - 5835 @ 80), (23)
-	# 60 GHz band channels 1-4,
-	# ref: http://www.law.go.kr/%ED%96%89%EC%A0%95%EA%B7%9C%EC%B9%99/%EB%AC%B4%EC%84%A0%EC%84%A4%EB%B9%84%EA%B7%9C%EC%B9%99
+	(5725 - 5850 @ 80), (23)
+	# 6 GHz band
+	(5925 - 7125 @ 160), (15), NO-OUTDOOR
+	# 60 GHz band channels 1-4
 	(57000 - 66000 @ 2160), (43)
 
 country KW: DFS-ETSI
-- 
2.35.0

