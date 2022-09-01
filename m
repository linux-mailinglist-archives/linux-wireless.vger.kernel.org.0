Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24F65AA3BA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 01:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiIAX2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 19:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiIAX2T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 19:28:19 -0400
Received: from hm1480-21.locaweb.com.br (hm1480-21.locaweb.com.br [201.76.49.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C8FA9F8F9
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 16:28:14 -0700 (PDT)
Received: from mcbain0012.email.locaweb.com.br (189.126.112.16) by hm1480-1.locaweb.com.br id h25002169rkl for <linux-wireless@vger.kernel.org>; Thu, 1 Sep 2022 20:27:57 -0300 (envelope-from <cesarb@cesarb.eti.br>)
Received: from proxy.email-ssl.com.br (unknown [10.31.120.206])
        by mcbain0012.email.locaweb.com.br (Postfix) with ESMTP id 0954B8C0650;
        Thu,  1 Sep 2022 20:27:57 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsBccBy-sK1GKJJtfXkGS-BkLtr8QRYnS2DQTmGk0SwbIC6wtHJEN1piX0PmzVXvHPH2_2eY3-TnZEuAM3pmes8My8zaFiS8J8y3j8gc_vOSA== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsBccBy-sK1GKJJtfXkGS-BkLtr8QRYnS2DQTmGk0SwbIC6wtHJEN1piX0PmzVXvHPH2_2eY3-TnZEuAM3pmes8My8zaFiS8J8y3j8gc_vOSA== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsBccBy-sK1GKJJtfXkGS-BkLtr8QRYnS2DQTmGk0SwbIC6wtHJEN1piX0PmzVXvHPH2_2eY3-TnZEuAM3pmes8My8zaFiS8J8y3j8gc_vOSA== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOsBccBy-sK1GKJJtfXkGS-BkLtr8QRYnS2DQTmGk0SwbIC6wtHJEN1piX0PmzVXvHPH2_2eY3-TnZEuAM3pmes8My8zaFiS8J8y3j8gc_vOSA== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from cesarb-5490.home.cesarb.net (unknown [200.187.114.14])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id 91A555C08A0;
        Thu,  1 Sep 2022 20:28:03 -0300 (-03)
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR)
Date:   Thu,  1 Sep 2022 20:27:34 -0300
Message-Id: <20220901232734.5488-1-cesarb@cesarb.eti.br>
X-Mailer: git-send-email 2.37.2
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
 db.txt | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 07cdf4a..c887557 100644
--- a/db.txt
+++ b/db.txt
@@ -279,12 +279,25 @@ country BO: DFS-JP
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
+	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
+	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
+	# requirements, we can extend the range by 5 MHz to make the kernel
+	# happy and be able to use channel 144.
+	(5470 - 5730 @ 160), (27), DFS
+	(5730 - 5850 @ 80), (30)
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	# EIRP=40dBm (43dBm peak)
+	(57000 - 71000 @ 2160), (40)
 
 country BS: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.37.2

