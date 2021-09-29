Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8741CB15
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbhI2R32 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Sep 2021 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhI2R31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Sep 2021 13:29:27 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396D8C06161C
        for <linux-wireless@vger.kernel.org>; Wed, 29 Sep 2021 10:27:46 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HKNcH0TzwzQlY2;
        Wed, 29 Sep 2021 19:27:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1632936459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7ZEK4wMXeUW5bEV7sbycmhopEv9Vlw1asfyGKcNSuLs=;
        b=RPft8jbKpxBijxjjuCkPqWLkX5srkWUO8GavfP/mG+7ZB0TkkOuwb+aodEyZDwAvmonqN6
        Snsb4FkiWq0WRv4QMRSMTe6yHJ9sKouLOf79vpB+P2o6TIRv0HZ64a04Dsua4TXk2V2x+E
        aDmU9bteyczjoE45g/L+8XL8YXcNlEtDNXHYk3IwtRqobxJ8VHUo+MH336oBDkYAJs4Gc+
        zMrSm+w5di/DY0JDKsItkTziU37RtQ9EV10d6qLRzEHfHOFOB0QwXUUCakUd7wjyyaU58P
        jQX7Q3Qd7xdu3BZD+ZE7qXXvz/UFZRPNbN3HxdzbOnYFmiM1VFFuzeJpmnMBPw==
From:   Sungbo Eo <mans0n@gorani.run>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH] wireless-regdb: Update regulatory rules for South Korea (KR)
Date:   Thu, 30 Sep 2021 02:27:28 +0900
Message-Id: <20210929172728.7512-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEF5C1702
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
Equipment Established Without Notice"), officially announced on 2021-01-06.

Extend the last 5 GHz frequency range to 5850 MHz.

WiFi 6E is now allowed with the following restrictions:
* Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 250mW EIRP
* Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25mW EIRP
Here only the former entry is added.

And also update the regulatory source links.

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
---
I have two questions.

The regulation has one more restriction:
  The TX power should not exceed 2.5 mW/MHz
  when the frequency range includes the whole or a part of 5230-5250 MHz
  and the bandwidth is equal to or less than 40 MHz.
That leads to the followings:
  5230-5250 @ 20 -> 17 dBm
  5210-5250 @ 40 -> 20 dBm
  5170-5250 @ 80 -> 23 dBm
Is it possible to add this rule without lowering the TX power for 80 MHz bandwidth?

And do we need AUTO-BW for 6E channels? I thought it is for merging adjacent frequency ranges.
---
 db.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 6e8dbef..31052cf 100644
--- a/db.txt
+++ b/db.txt
@@ -862,15 +862,20 @@ country KP: DFS-JP
 	(5490 - 5630 @ 20), (30), DFS
 	(5735 - 5815 @ 20), (30)
 
+# Source:
+# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196972
+# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196973
+# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196974
 country KR: DFS-JP
 	# ref: https://www.rra.go.kr
 	(2400 - 2483.5 @ 40), (23)
 	(5150 - 5250 @ 80), (23), AUTO-BW
 	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
 	(5470 - 5725 @ 160), (20), DFS
-	(5725 - 5835 @ 80), (23)
-	# 60 GHz band channels 1-4,
-	# ref: http://www.law.go.kr/%ED%96%89%EC%A0%95%EA%B7%9C%EC%B9%99/%EB%AC%B4%EC%84%A0%EC%84%A4%EB%B9%84%EA%B7%9C%EC%B9%99
+	(5725 - 5850 @ 80), (23)
+	# 6 GHz band
+	(5925 - 7125 @ 160), (24), NO-OUTDOOR, AUTO-BW
+	# 60 GHz band channels 1-4
 	(57000 - 66000 @ 2160), (43)
 
 country KW: DFS-ETSI
-- 
2.33.0

