Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3564584D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 11:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLGK4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 05:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGK4S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 05:56:18 -0500
X-Greylist: delayed 146 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 02:56:14 PST
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB992F037
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 02:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670410561; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Y03ympbERghiku2OII6PhU30HxBtsyX9Wqe9SykU0vatn1zL+E5wrmMuIoA3vYOyUD+aFm0r5hZ1cRqjL+Fdmo5sij3sdBOwLJX63yxzG725pOgBSWA4ybphKIv+7yLGJ9Ojc6CEoSBU5nx94boG6OZlcY4u6mlx59yhwlNsK0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1670410561; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=27mX4Vxa84Q/vH0D2HA7DK/SXxiwCdpXDqEyWLB3wRc=; 
        b=OrwR8pBWnN33XGA595NflC1h1Q99Rgw4edekJSNsQtMIRyWmZoirxAtsVnHfH6fo72Qi8mutiIi/kEAOteA8CHQy4CJVbTLlvOi94drHOnHuP+iFD7XMjS+iRFCpId2HkX/NCR5b8XOIrJg8uTF7/R/AnJBQutbJZc5XMFeqf1I=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=hak.dog;
        spf=pass  smtp.mailfrom=kleo@hak.dog;
        dmarc=pass header.from=<kleo@hak.dog>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670410561;
        s=zmail; d=hak.dog; i=kleo@hak.dog;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-Id:Message-Id:Subject:Subject:MIME-Version:Content-Type:Reply-To;
        bh=27mX4Vxa84Q/vH0D2HA7DK/SXxiwCdpXDqEyWLB3wRc=;
        b=GqG3nLvlM6aRel4/aVbD3u8h4P77txAWNxj/WNV/urHMp/KJ8XwO/uWM5EAPiHZE
        2VainlA7zUs9QN+hmOHSZL+DZWkaKEmmH1o5nGsUpaBlLUxO0ZQ+PE7G/D2h7o39DM0
        sJU1QT8pBSIF1S8L1cZaF2PqNyLb/ZHRDvxH42fI=
Received: from mail.zoho.eu by mx.zoho.eu
        with SMTP id 1670410560532604.827231048834; Wed, 7 Dec 2022 11:56:00 +0100 (CET)
Date:   Wed, 07 Dec 2022 18:56:00 +0800
From:   kleo <kleo@hak.dog>
To:     "sforshee" <sforshee@kernel.org>
Cc:     "wireless-regdb" <wireless-regdb@lists.infradead.org>,
        "linux-wireless" <linux-wireless@vger.kernel.org>
Message-Id: <184ec3a63fe.d96b82f6427171.7593361304891506395@hak.dog>
Subject: wireless-regdb: Update regulatory rules for Philippines (PH)
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_1234383_1310708108.1670410560511"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Zoho-Virus-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

------=_Part_1234383_1310708108.1670410560511
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

diff --git a/db.txt b/db.txt
index 3f74194..fa9ffd7 100644
--- a/db.txt
+++ b/db.txt
@@ -1368,11 +1368,17 @@ country PG: DFS-FCC
        (5735 - 5835 @ 80), (30)
=20
 country PH: DFS-FCC
-       (2402 - 2482 @ 40), (20)
-       (5170 - 5250 @ 80), (17), AUTO-BW
-       (5250 - 5330 @ 80), (24), DFS, AUTO-BW
-       (5490 - 5730 @ 160), (24), DFS
-       (5735 - 5835 @ 80), (30)
+       # https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulation=
s/MemoCirculars/MC2003/MC-09-09-2003.pdf
+       # https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulation=
s/MemoCirculars/MC2013/MC-03-08-2013.pdf
+       # https://ntc.gov.ph/wp-content/uploads/2016/MC/Explanatory-MC-No-0=
1-01-2016.pdf
+       # https://ntc.gov.ph/wp-content/uploads/2022/mc/Memorandum_Cicurlar=
_No._002-09-2021.pdf
+       (915 - 918 @ 2), (30)
+       (2400 - 2483.5 @ 40), (24)
+       (5150 - 5250 @ 80), (24), AUTO-BW
+       (5250 - 5350 @ 80), (24), DFS, AUTO-BW
+       (5470 - 5730 @ 160), (24), DFS
+       (5730 - 5850 @ 80), (30)
+       (57000 - 66000 @ 2160), (40)
=20
 country PK: DFS-JP
        # https://fab.gov.pk/type-approval/

c5da72a2fef48891aceb3f3378afbb12a2778c83e9f053f5d23e589630536b61=C2=A0 coun=
try-ph.patch

kleo




------=_Part_1234383_1310708108.1670410560511
Content-Type: application/octet-stream; name=country-ph.patch
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 138896930253290500
Content-Disposition: attachment; filename=country-ph.patch

diff --git a/db.txt b/db.txt
index 3f74194..fa9ffd7 100644
--- a/db.txt
+++ b/db.txt
@@ -1368,11 +1368,17 @@ country PG: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 
 country PH: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (17), AUTO-BW
-	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (24), DFS
-	(5735 - 5835 @ 80), (30)
+	# https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2003/MC-09-09-2003.pdf
+	# https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2013/MC-03-08-2013.pdf
+	# https://ntc.gov.ph/wp-content/uploads/2016/MC/Explanatory-MC-No-01-01-2016.pdf
+	# https://ntc.gov.ph/wp-content/uploads/2022/mc/Memorandum_Cicurlar_No._002-09-2021.pdf
+	(915 - 918 @ 2), (30)
+	(2400 - 2483.5 @ 40), (24)
+	(5150 - 5250 @ 80), (24), AUTO-BW
+	(5250 - 5350 @ 80), (24), DFS, AUTO-BW
+	(5470 - 5730 @ 160), (24), DFS
+	(5730 - 5850 @ 80), (30)
+	(57000 - 66000 @ 2160), (40)
 
 country PK: DFS-JP
 	# https://fab.gov.pk/type-approval/

------=_Part_1234383_1310708108.1670410560511--

