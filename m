Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7E533E2A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 15:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbiEYNp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiEYNpZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 09:45:25 -0400
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 06:45:22 PDT
Received: from mail.tintel.eu (mail.tintel.eu [IPv6:2001:41d0:a:6e77:0:ff:fe5c:6a54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED060D86
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 06:45:22 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id 386914541E35;
        Wed, 25 May 2022 15:36:11 +0200 (CEST)
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HyB9O654vDmE; Wed, 25 May 2022 15:36:10 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
        by mail.tintel.eu (Postfix) with ESMTP id A6DC64541E34;
        Wed, 25 May 2022 15:36:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu A6DC64541E34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
        s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1653485770;
        bh=h45dum25SYcDiIOd9Ov43qD2SBgSfhB7rTLuBrPU0GU=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=rICKj1208hKZ99EaJ/CAjWnmTJOE4heTuSNEUHfX3+PApYf2jYPVVREm0kB8l2CGR
         S26d3WFCADezCOZgWoa/mLMPJBiw9cC25K3VuyAYZMCVcp0xN47jNy32OLbYqGh5+c
         QiLcdDwL2RK9zqjlZcpk9xdFhXielRuD2ZQNN2e4=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
        by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 3hIdCskuyHuq; Wed, 25 May 2022 15:36:10 +0200 (CEST)
Received: from taz.sof.bg.adlevio.net (unknown [IPv6:2001:67c:21bc:20::10])
        by mail.tintel.eu (Postfix) with ESMTPS id 6641E4541E30;
        Wed, 25 May 2022 15:36:10 +0200 (CEST)
From:   Stijn Tintel <stijn@linux-ipv6.be>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Petko Bordjukov <bordjukov@gmail.com>
Subject: [PATCH] wireless-regdb: update regulatory rules for Bulgaria (BG) on 6GHz
Date:   Wed, 25 May 2022 16:36:09 +0300
Message-Id: <20220525133609.1740457-1-stijn@linux-ipv6.be>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Rspamd-Queue-Id: 6641E4541E30
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: IP_WHITELIST
X-Spamd-Result: default: False [0.00 / 15.00];
        IP_WHITELIST(0.00)[2001:67c:21bc:20::10];
        ASN(0.00)[asn:200533, ipnet:2001:67c:21bc::/48, country:BG]
X-Rspamd-Server: skulls
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reviewed-by: Petko Bordjukov <bordjukov@gmail.com>
Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
---
 db.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/db.txt b/db.txt
index fcdc74a..0d24e96 100644
--- a/db.txt
+++ b/db.txt
@@ -219,6 +219,10 @@ country BF: DFS-FCC
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/downloa=
d/25c41779-cd6e/Rec7003e.pdf
 # BG: https://crc.bg/files/_en/Electronic_Communications_Revised_EN1.pdf
 # BG: acceptance of 2006/771/EC https://crc.bg/files/Pravila_06_12_2018.=
pdf
+#
+# Amendment of the rules for free use of radio frequency spectrum
+# (=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8 =D0=B4=D0=
=BE=D0=BF=D1=8A=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D0=9F=D1=
=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=B0=D1=82=D0=B0 =D0=B7=D0=B0 =D1=81=D0=B2=D0=
=BE=D0=B1=D0=BE=D0=B4=D0=BD=D0=BE =D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=
=B2=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D1=80=D0=B0=D0=B4=D0=B8=D0=BE=D1=87=D0=
=B5=D1=81=D1=82=D0=BE=D1=82=D0=BD=D0=B8=D1=8F =D1=81=D0=BF=D0=B5=D0=BA=D1=
=82=D1=8A=D1=80)
+# https://dv.parliament.bg/DVWeb/showMaterialDV.jsp?idMat=3D168250
 country BG: DFS-ETSI
 	# Wideband data transmission systems (WDTS) in the 2.4GHz ISM band, ref=
:
 	# I.22 of the List, BDS EN 300 328
@@ -232,6 +236,8 @@ country BG: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	# I.43 of the List, BDS EN 300 440-2, BDS EN 300 440-1
 	(5725 - 5875 @ 80), (25 mW)
+	# WiFi 6E
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=3DETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	# II.H03 of the List, BDS EN 302 567-2
 	(57000 - 66000 @ 2160), (40)
--=20
2.35.1

