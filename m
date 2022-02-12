Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12664B3664
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 17:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiBLQaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 11:30:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiBLQaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 11:30:15 -0500
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 08:30:12 PST
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF4181
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 08:30:12 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 993815C005F;
        Sat, 12 Feb 2022 11:30:11 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Sat, 12 Feb 2022 11:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=dD1XsyZbVAyi6dQ5L80b0IK56l3bPlcF+G8zq6
        hJkYs=; b=R881m7JgyKvESqLV6WT8piSrjtm/aCudcI3/TxMEB1th6wU+Pgkd4e
        BlqvBMT5VIpk0J5P4Qv2gXp3avKKaYrhixMp2dcbJRwGw+MitOquwLU93MLE5Dqc
        4HnJNJjWcxPRLd0tjeOz4q0Elg4aKdWf7fK207RnW9ajPOa6dRyon+UIfBn6e+dC
        p/qgxH43kYvosiOOLPnQLTQ/Lp9wbQtih+g7+gn1NBOy2E6BqGgwq/4ulV2ipOQQ
        hkYlS+gxMndWi5r6ffVD0aV/lcOkSvG33bv/Qf1dLSQGwvUP/Wp4BvFM0t+TAwbe
        zditszrg2NV3j11kjdeg/kjBrviPHp1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dD1Xsy
        ZbVAyi6dQ5L80b0IK56l3bPlcF+G8zq6hJkYs=; b=CobB5a2G3G6SLcT9PqgE3I
        ZQhpsE4ThmlelvNo/Y4m+WYiiLB/Ii7C43XIBwMxc+5i+aLi59Vp7ch423LONwHz
        GyP8eDtliGFIJzB5R/hKRedGzusEOEMCMkfVCxHgvbW800kCXy6w9EohHMeN14lG
        az9kg8hvhb2nI44+nOj8k5wb0QlpVYgDGkch4yqtBC0dzrDRO7JMiJTHjDI6BweP
        i0/+juKFl8aV6s+U9MBaU9W0j25Ov3T2OE6MqrFJ4eqk/fk7RV8Vuyhm9jwwVynU
        kcOPeChVl6PAEWX9fzPiU4tq5VI/R1CQ1lepiTyMKg9zGAxZAjUmuWzpW7K3nxng
        ==
X-ME-Sender: <xms:k-AHYlTxHRdFRKP6gl5cmEseH8-Skp6zK4q0DX1p7HeLDcsf36tAcg>
    <xme:k-AHYuxU91cGed7WdYyna-1oQsqSIKdIRChxr2C1L6T2BfaFKruavXAM_0tyE8pTj
    zsuUr4H052iVIhUGq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieehgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgrgihu
    nhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfevieevteehudfgjeeftdefledtteejfeejffegledugffh
    vdevjeekjeeiueenucffohhmrghinhepmhhiihhtrdhgohhvrdgtnhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:k-AHYq2Ii5MNaMCkQ3_fg3CqAM7WNkVyTQnW8QX9d1ZEbkWcrj49RA>
    <xmx:k-AHYtALlHkrTIjMJ-chGJhTT_tWzxhbJafeQz4LEVgPTPZtj61onQ>
    <xmx:k-AHYuirqUb1MEWwuuj7Ipv2T_X0b7LrDYrzqtqHRlJwAyr7K5ZnQw>
    <xmx:k-AHYmIuLgsxUpYl94rdbMDrZS58mpxNf9wz5vo8PRQHI5iiCeRhMg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6BB9BFA0AA7; Sat, 12 Feb 2022 11:30:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4748-g31a5b5f50e-fm-cal2020-20220204.001-g31a5b5f5
Mime-Version: 1.0
Message-Id: <ae43589a-6ca4-4856-8f7f-b631ce44993b@www.fastmail.com>
Date:   Sat, 12 Feb 2022 16:29:50 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Seth Forshee" <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for China (CN)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

China had updated regulations on ISM frequencies by
"=E5=B7=A5=E4=BF=A1=E9=83=A8=E6=97=A0=E3=80=942021=E3=80=95129=E5=8F=B7".

The new regulation effectives from Jan 1 2022.

Update regdb accroading to it's attachment "2400MHz=E3=80=815100MHz
=E5=92=8C 5800MHz =E9=A2=91=E6=AE=B5=E6=97=A0=E7=BA=BF=E7=94=B5=E5=8F=91=
=E5=B0=84=E8=AE=BE=E5=A4=87=E5=B0=84=E9=A2=91=E6=8A=80=E6=9C=AF=E8=A6=81=
=E6=B1=82".

Announcement: https://wap.miit.gov.cn/zwgk/zcwj/wjfb/tz/art/2021/art_e4a=
e71252eab42928daf0ea620976e4e.html
Attachment: https://wap.miit.gov.cn/cms_files/filemanager/1226211233/att=
ach/20219/d125301b13454551b698ff5afa49ca28.pdf

Those documents are only available in Chinese.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Reduce 3dBm for 5150-5350 MHz due to TPC restriction
---
 db.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 6dbda3c..89b0b17 100644
--- a/db.txt
+++ b/db.txt
@@ -346,11 +346,13 @@ country CL: DFS-JP
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5735 - 5835 @ 80), (20)
=20
+# Source:
+# https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219=
/d125301b13454551b698ff5afa49ca28.pdf
+# Note: The transmit power for 5150-5350MHz bands can be raised by 3dBm=
 when TPC is implemented
 country CN: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5350 @ 80), (20), DFS, AUTO-BW
+	(5725 - 5850 @ 80), (33)
 	# 60 GHz band channels 1,4: 28dBm, channels 2,3: 44dBm
 	# ref: http://www.miit.gov.cn/n11293472/n11505629/n11506593/n11960250/=
n11960606/n11960700/n12330791.files/n12330790.pdf
 	(57240 - 59400 @ 2160), (28)
--=20
2.34.1.windows.1
