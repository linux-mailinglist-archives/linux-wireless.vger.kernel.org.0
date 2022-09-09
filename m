Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421E5B428E
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Sep 2022 00:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIIWkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 18:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIIWkQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 18:40:16 -0400
Received: from hm1831-33.locaweb.com.br (hm1831-33.locaweb.com.br [189.126.112.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 111FE37F85
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 15:40:10 -0700 (PDT)
Received: from mcbain0007.email.locaweb.com.br (189.126.112.75) by hm1831-n-113.locaweb.com.br id h3eus82n8lge for <linux-wireless@vger.kernel.org>; Fri, 9 Sep 2022 19:27:16 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.204])
        by mcbain0007.email.locaweb.com.br (Postfix) with ESMTP id 6CD562404AD;
        Fri,  9 Sep 2022 19:33:57 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOu9SY5A1ZjZLRt5vePnsW8byfVlCF4RF29Q_EA9IQedawVzAfXvdOjv8b36scucRrxP_nthYltdNHIxY8ITn0xSn54t97BdjRfPa0Tj7HU7zw== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from cesarb-5490.home.cesarb.net (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id 874354A0D47;
        Fri,  9 Sep 2022 19:40:02 -0300 (-03)
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        johannes@sipsolutions.net,
        Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Brazil (BR)
Date:   Fri,  9 Sep 2022 19:39:47 -0300
Message-Id: <20220909223947.27277-1-cesarb@cesarb.eti.br>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rules for Brazil in wireless-regdb have no comment indicating where
they came from, and haven't been updated in a long time. There have been
some changes to the legislation since then, including the addition of
the 6 GHz and 60 GHz ranges.

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.eti.br>
---
 db.txt | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 07cdf4a..132f6de 100644
--- a/db.txt
+++ b/db.txt
@@ -279,12 +279,21 @@ country BO: DFS-JP
 	(5250 - 5330 @ 80), (30), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
+# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
+# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
 country BR: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (17), AUTO-BW
-	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (24), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (30)
+	# The next three ranges have been reduced by 3dB, could be increased
+	# to 30dBm if TPC is implemented.
+	(5150 - 5250 @ 80), (27), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
+	(5470 - 5725 @ 160), (27), DFS, AUTO-BW
+	(5725 - 5850 @ 80), (30), AUTO-BW
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	# EIRP=40dBm (43dBm peak)
+	(57000 - 71000 @ 2160), (40)
 
 country BS: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.37.3

