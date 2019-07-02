Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD645D1B6
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGBOZk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 10:25:40 -0400
Received: from sitav-80046.hsr.ch ([152.96.80.46]:39158 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfGBOZk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 10:25:40 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 10:25:39 EDT
Received: from book.wlp.is (unknown [185.12.128.225])
        by mail.strongswan.org (Postfix) with ESMTPSA id 294FD40186;
        Tue,  2 Jul 2019 16:20:15 +0200 (CEST)
From:   Martin Willi <martin@strongswan.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Henrik Laxhuber <henrik@laxhuber.com>
Subject: [PATCH] wireless-regdb: Fix overlapping ranges for Switzerland and Liechtenstein
Date:   Tue,  2 Jul 2019 16:19:44 +0200
Message-Id: <20190702141944.25902-1-martin@strongswan.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The commit referenced below changes the 5GHz frequency range 5250-5330
to 5150-5330, making that range overlapping with the existing range
5170-5250. This imposes DFS limitations and a reduced maximum power
level for the range 5170-5250.

The change of the frequency range seems not intentional. Instead the
commit should have changed the 5170-5250 range to 5150-5250, and the
5250-5330 range to 5250-5350 (see [1]).

[1] https://www.ofcomnet.ch/api/rir/1010/05

Fixes: 957a7cff72a3 ("wireless-regdb: update regulatory rules for Switzerland (CH), and Liechtenstein (LI) on 5GHz")
Signed-off-by: Martin Willi <martin@strongswan.org>
---
 db.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index d47ab94c3aa5..37393e6a793e 100644
--- a/db.txt
+++ b/db.txt
@@ -271,8 +271,8 @@ country CF: DFS-FCC
 # transmitter power control is in use: 5250-5330@23db, 5490-5710@30db
 country CH: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5150 - 5330 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
@@ -747,8 +747,8 @@ country LC: DFS-ETSI
 # transmitter power control is in use: 5250-5330@23db, 5490-5710@30db
 country LI: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5150 - 5330 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
-- 
2.17.1

