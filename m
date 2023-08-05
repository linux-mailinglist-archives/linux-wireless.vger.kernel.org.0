Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB126770F07
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHEJRw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Aug 2023 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjHEJRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Aug 2023 05:17:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2078.outbound.protection.outlook.com [40.92.98.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA72E70
        for <linux-wireless@vger.kernel.org>; Sat,  5 Aug 2023 02:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjaYd+Y+pEx7b+38qv/+TjTr9zFYjo7OB9YmUO3NbGoGc753k97Fhogfy0VipAYBI7ZQSoc58n3vz95t6NSLadcazHtrqWkZFNSgEmpP1VBikVPhHzQ3Q80QCOj67Cd/fnSHOEoNFNn8IvyDfwUKj5aUrQHAy6BiKaGdfCKwQpn5faAy6Sd9HQU0R4AaopkJzamF2wAyJkuBEoa2PkMKZVCEDqLraT2d3YGT19MbE/HF4IwCPhwX5fB/hQe+Qp1ItFi9D/FJbW0+5OeR8jq8fIvG0bqvoWuebSTjKR4+KdHF2jFNgX7omqHpxa3BSiw6ZvAppK3TYhECFJRzkhw79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFf3yau7bKxqaoO70B4eNoG0yOCRBlmBDWDXfaS9Zb0=;
 b=m9HfAtOT3HSmnJu144ZLjM/dNKM1Yz+IIiBSbZ8m0zCUePkBYdt9t0F+lKe7uhXv0/MZKH34MVZWqTzkgzJcVKgmNFdTcPlAL/KW1wb3xMeLzKQj60nAEysdOZnJZbcE19Z/4tOCwD+N7dXWe6r6tKhex71EGx+5CuBtKv9fuEJyzYLyrfEjMG2b1yTxH1zSdJBWFr+e1MhumkT6lVQKDJbOiErgr6nqqfHC7I0CtpXuV7GHIqDpruvtjysugnxqpm1TfmIkDBWSo7dBGsTNl08Zic0X7xsjZ5LWWSWgm9l+0bUwcv2uzjkiYDxAuvjf30L4zSpcpg2jchgYTaFRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFf3yau7bKxqaoO70B4eNoG0yOCRBlmBDWDXfaS9Zb0=;
 b=d+zrFbIfLwqWES+iIE5u1hWKBXG/b11+gVAgCY20uHxCKTYeMhxNyGCnNo2qCqbb9S1X90QZwa+QURQUgu7B3p4IK3MYExRhZhdTKuuvm0SurzfmJFVB03RRRWCh+wx1njC5uDx6lcLHeZsBiboXQFp7ep68Vq5uAnm9tzT4XG9HsripLmpZ62eaXf6UkeRTSo62LLzhYLomARZEn9P+vnBW+vWUF4KlfGfO2k7h1ohtnU7uy3/sUWmrBo6I3VOzT9yKWbRZHRThKTl7Ex+Akv1OvXfYBYaLLpLE+xsJNsQvNdxkOLWOsi0TKcj+1V+6B3ddCMsQjgZ/BP5HZq6d6w==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYTP286MB3450.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 09:17:44 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f4c2:4b38:d074:f1e9%5]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 09:17:44 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: rt2x00: correct MAC_SYS_CTRL register RX mask in R-Calibration
Date:   Sat,  5 Aug 2023 17:17:28 +0800
Message-ID: <TYAP286MB03150B571B67B896A504AC34BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [uJ2IW0sbutGRYTcWs5dSIvZZmEkmhZmF5WNIeR/IplA=]
X-ClientProxiedBy: TYCP286CA0336.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::7) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230805091728.6332-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYTP286MB3450:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c9d2ee-1109-4485-ade6-08db9594d39c
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmqDXAFQI1bv+JXMVFoi/4FuFyMHTdzd1YIUFPoDCYp87aI14vVxxw/J5YcdLAPgSTRcRj5uSt0p83YJoyotkaIXPyePEPek8WACvF4DnkwC2a8vXwZouIMVEzJwWlYJAP8qeh+2Tg7qrNaSNzWSZ520Aj8xx1+huJas94iaD/o2FKyHPpO21V1A1V/XS6MfR8DhDA6NsTO7zK9aCGJBJZ+jzg1+XSkjDzKMC3iGGeThSrwEiWBjV6z+RyFNjpudHP1qHgMySCUuYtNcVRbT4IxIU/aEHTw2KIwnlYNEmtpaFOpQSkvJYNrBFPOUt/W41Ggcejc7OdRAObdSiA7Nt86nIIZCQ99UKRD2Qqpr0ijO/4a1OYXjK1uca1eL48fJRxeFpaFBoUT9F5+/nSfSY7lFgPxD3JCR6RG60ndoObD1W/cqK/yF4+ftNkr0QX3/oLfxdohFtzhSziGnfq66t52bDX7EglUBrtLSo4FrxClD9GJKjhA1Y9lMQliNZIsYOEfzpBSKOqPHwhbAVd/lwdrq/93B5ah8Vt+m+MHwboBZH65E7RYZufMGEetnS767Z8JlU53hVTovWV5A2znSiZ7bue7RQky/yuu3hNn3HOKQ0McYridhpie8FyA4JrMcsdfwRpZudjDZT8lytUe+l4nVh51zRsWgZltbuVMcSdpuSjaw65zHonuvVsAzFZEQZszOK6Ta/JZTrxnua6U7Z4Tbz9rx60P0gqrvzJceXu5mUqtrg7C7cf5yY+xHSMHmCGQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IGej/fb3+5+Pmf9JGopEfordOdrdGGS965UXbBLapdsIGDXld9TcRqHlOG0oTCnbQKLE/fpo0/WCO/PK0viyd3akmLCNyKAIKMvNwrgouZFOGoC+mtw09lPpeePa77Wtg2oachvTh82Kuqzk1YlxeVwgqzkGeYpKrDRy3u+BY3cuPNKiu3yGYHqjfxikjsGO/iFXZYVYRdsoovQ1ccG/hnTz5G8oqGOx9Ban/QI6rZSCqP7A6fBAIutmJjToxacwGOO7pfX/k32GVecDqKx8ZEBW/WMxW8/xEJzdRMCgOZSpfdKnxufhKpm34lsb1j2trauvoY9USLb2G1YgsOqYnXU26uONgQFNDeGDGD5pSCnB+rRvRyuDviJrgpnQBg0AvaPM3zUJZHFKiLKKcBgVsAlINohRTiLIIplLjPdsgblz286TnUvtwB53TTpj0fhvXr+aA2O/WT8vHpYi9vX4ACSjY0H9iPU7ZmAJynLTejrPF2CE6Z2Ieaj2rRB2oVIHvWkDR5Gj2NBSMlvz00bITpwh8IHCxsJa++PszVaLHL2r/ITt0JWvUbq+dBGQCGkNDAsbiAm35p8hI6Ai5/JXyxpKcUdBWFNNRX1tzvLAdw6oitna9gQ4IY6FF+BvmuK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P71p59VphsTsATRNZzDjPS/us+paJwzvDELNvH25JVzoENOWn7aL/TAxvG74?=
 =?us-ascii?Q?gdtMF/TbC91evDbQNKM/B44qI3TS3auNI8Vi4AoyAGKKKPBcQWS5zMxw2sZ+?=
 =?us-ascii?Q?xs0y+gw5u/GnWSUCWEppwDP+nyqjLyZPrby92mlLv190jOs/Wk/a1C+e2OPb?=
 =?us-ascii?Q?vlvhqvKPCQtbWzGqhZ+d6Nb5ZZXpQZRhrowMxhtqiSoGEVPnEIVhpirpz6EZ?=
 =?us-ascii?Q?ErqHVNZuTaqkzkJnBc5yWjJXHv5JbSkg9VDi0J9I0K+kucjh64sy91Igiq8Y?=
 =?us-ascii?Q?G5cvqbbPM4/uNr0TLtqrU4uSt/Znm4xIcumUbVUBv9CapXINmB+aqVFVziXq?=
 =?us-ascii?Q?ErIfqhpWD/Phr4dYGh+lf2koLqT27AyFNFqpNqzzRq/MDGLdjPoeQ0lvCLct?=
 =?us-ascii?Q?rhBXF30M3E/O2xXvbhIDjBaD59PEPwhBI1YkHE0htcaO8iB2PPGGY5FFY8c+?=
 =?us-ascii?Q?CHeHGRB2JSsCMU25SoHtpqxLvs+pky6WMqx95lQIBWSEfdCn0Wkn9EVYjrhd?=
 =?us-ascii?Q?EbD6OeVr6WowGVR+cbP+pTAUI0oU1IUVtPF/RvJplH19E+F2Du+fI/z5R9Pf?=
 =?us-ascii?Q?4fWm/99XLkD7SoQq9e9avuw10UHedNSzOpJwcHIftsDUEoy8+8IRB84TRlJN?=
 =?us-ascii?Q?A3sKQVfZS1j925eZuHYrFwhw4CmuPPw5G0U/g1OZEAlsxxvfVLhrsNuW5oJR?=
 =?us-ascii?Q?brd2PJJZSxjsG9l2MFeAZqaFcdx05Z0D7fWcSWMHw2FaGhK+/f/wwWuzDtp6?=
 =?us-ascii?Q?sIEIcMaLisTyGRIZcAOs3/qLd8vMWW3D2xq8hvcHHxqXYMDeYjr9WKqj7V6C?=
 =?us-ascii?Q?lcNpaZBzJfyYsu3MG8IsrV5Bh41mMxSi3l6Ta33dtGzcM7TwycPfU3VJyRoS?=
 =?us-ascii?Q?Cv/j5geuU9LH7MF1EKP/fUYicGtHgNDzEnXy+vCG4XB3tQIufywz9D6u/f6X?=
 =?us-ascii?Q?lZ3Gt+tqw4K/mF89SNOvG1BVTUEtyORIAFMg9CN9UX8Qjysf2MBXCFKbjRRg?=
 =?us-ascii?Q?JOEFKhtkJT5z0yszjxOWtMcq6i9tYBNyPkdcfXhoKQHG2jNe0yU8VhLKXL7u?=
 =?us-ascii?Q?TeVueFyumaCt8hhTsDDFzwanEjjS1dzYM9QPqVxFEPnrmMGqKPE6/aoLLndf?=
 =?us-ascii?Q?83VbuwVKmyv27qNE666tvtGFfP6L6s7ce6HsqLjyO50NPE2jmZ20f5vIVB8y?=
 =?us-ascii?Q?yq+a2LZUd2ZfcgI4lvHiXmgXPLr0luofipdtJbIN1dNMW0bzSRmVy889Rv4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c9d2ee-1109-4485-ade6-08db9594d39c
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 09:17:44.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3450
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For MAC_SYS_CTRL register, Bit[2] controls MAC_TX_EN and Bit[3]
controls MAC_RX_EN (Bit index starts from 0). Therefore, 0x08 is
the correct mask for RX.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index ff891353c..28d7b4ea4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8583,7 +8583,7 @@ static void rt2800_r_calibration(struct rt2x00_dev *rt2x00dev)
 		rt2x00_warn(rt2x00dev, "Wait MAC Tx Status to MAX !!!\n");
 
 	maccfg = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
-	maccfg &= (~0x04);
+	maccfg &= (~0x08);
 	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, maccfg);
 
 	if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_RX)))
-- 
2.39.2

