Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17671DC5E7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 05:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEUDue (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 23:50:34 -0400
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:9153
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbgEUDue (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 23:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0LIcIxwHWLgegHZ1/j0fWuD9SIAXj0v1rTmX5BkOd/6X477Y2OBsG7i8NRCBDttqHxI8SkZ/dNE4dm9UpG+/Oo9cIu14BuEHXdoSuZC60P2h036xF1hT3QUsIBItDP8OJiWDSxDBbF1A51sdqyONjhoRnzq9hW8/S9VL0sHcctZ3dqRkDXo6JpSndOU9fnf97o/qCVq/5Vmhi5T7+RANHjvFYeEaDvfp8JO8Y5FHp/F2pg+uOqft9af+hopyhuxTK3CqcrKHuWOxA3zD5wAeDs3fogm3vnQt7iPVYnpk9PDHgwzuQHZ7V2SyS9gH/YsdbJzJgjLRHDu/52DhDdUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fop8C/fbQGNSlmWGRNnAeK1duiYVeCygwiUIjqnsydA=;
 b=NXg4MRDB0dAH825qd5bFHgZ6ZpqPy12sGstLAXhFn9mQbSdsm9Gq6/G1o4w5qjBhXVYn+nPLxBdl0qJeFqyPW0aoTTui17ulwqDRN8cSWU19m6SwAZsvi8ElI2Dd48zSnR01Zikus1BW1jSvDfyVgfWS7dRCaXz1zZGPrXga3bXtmG0uMdg0NRERDgwQl61yRcmWG548o5sMKhFYnJrp0CG+cRFMAuAebd0EKtqLPdwOLZznU7GH5Uu0Lb1URBMKbhtgZrMP0jc8qMp70oPr/IpaAvdjhBqJ/qb0OaarnM3WC/mj5dBPLx1t/zJCCf5cmPlhnsdPKC43BkGVFoOsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fop8C/fbQGNSlmWGRNnAeK1duiYVeCygwiUIjqnsydA=;
 b=diOWm7UvGButuYm7Am7+Ha4P7stjGcSiJH6fpF9Er97ZRyU5xfdUkFw9vo+BmV3vdECb5yH0cb4AyQ1vvPaPM4niVkaYNvrtufcM3CtjXLQdyVNjVVbxSB1ha/6d12SCRF4mEn1qMYOQtAohytvHnrPpdxeI8xydb1j2NudvELg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4024.namprd06.prod.outlook.com (2603:10b6:a02:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 03:48:50 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:48:50 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Frank Kao <frank.kao@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 3/5] brcmfmac: set F2 blocksize and watermark for 4354/4356 SDIO
Date:   Wed, 20 May 2020 22:48:36 -0500
Message-Id: <20200521034838.57371-4-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200521034838.57371-1-chi-hsien.lin@cypress.com>
References: <20200521034838.57371-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 03:48:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 297996ce-682d-4ca9-d38b-08d7fd39dfab
X-MS-TrafficTypeDiagnostic: BYAPR06MB4024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB402498A94F5564A1872819BABBB70@BYAPR06MB4024.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/oGLOtBzvTCWq971o053WqDTFlohr8k0UkCupsy8Eb5Mpjq8jXwrffc+E9uGnoqzjMXPXGeM37I3Sm1hcz2Viqvx1Y95qocQKnu0GUJXIAFjKyG28MrwFRydjO3UydohJw49g8SZDfSImPw9BssGOeTtu4d9M9CsLjnLAqcZa4Owf/z/DclvhCOf35CmhswisujkmpvwijhQT3PjZ0qMA9FlnPOt6RBfRW5WqmT0rV5soI7vWc4lizz8kDPkpW9FzD5109VO8D6mfpjZWM5DAgKQmqB22SDt4SlpL2Q/YoOlTjhWIbgQHAAehUvMar6JeRghLyYyy86H9D57gcdpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(26005)(6666004)(107886003)(7696005)(1076003)(52116002)(86362001)(16526019)(956004)(5660300002)(66476007)(66556008)(66946007)(54906003)(2616005)(6486002)(316002)(36756003)(6916009)(8936002)(4326008)(478600001)(8676002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9RHCtWWbJwHIu80YTw/OxnXMxgIdElWVeevIQprSrBo9XFRDubKfUykccRdgQR7YBUnmZWA9Fp3gicanvnFGXyPCsmup0rx3EmkxRUwQlzqqXssFwKwV8OQUpPaSPq5gcynltF6b4C7Vf8QZyrc0R216eriRutwy4qGwYDIxerwP7wQA+06hjrL+2vm0Oxznirrk/TQu4BhNvSbubWHmfQyAGJVj2NalItEhdwpAqjthZKjxQ2w7PU7wOkNHzeQ2l2xu35RMbXWQNjXsAkPaEDHy2SKLbec3pKJaDI7U68HuqN+O9qh9avIUHPZGP61M1Uqd/pmLu2IhWW9tY+kBlOlXQSrADpwXj8LmRlnoZ7s+ABz0Xy7myNpc5+yOui1xCn78LxXJSp761g7uXCkglgs+UonbhnP3B3J3ipdEebrjhOgJZY1WwbvDHId3KH/UsZt1scw57UPeh0TWlyn49I0Wp6sA3nVhBt4res2K4qGQKAJInFqOhfmsB/lay2V0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297996ce-682d-4ca9-d38b-08d7fd39dfab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:48:50.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEhBX0S1EJrfaeOWIYfc80zQpRcl3e2rli608K/ZyPV8TXviK9n7PJtO+7pJ8deZIsv+l1p8s3HOSbkA7daQuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4024
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Frank Kao <frank.kao@cypress.com>

Set F2 blocksize to 256 bytes and watermark to 0x40 for 4354/4356 SDIO.
Also enable and configure F1 MesBusyCtrl. It would resolve random driver
crash issue.

Signed-off-by: Frank Kao <frank.kao@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c         |  8 ++++++--
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 16 ++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index bb3196cba683..b1a66320ba54 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -44,7 +44,7 @@
 #define SDIO_FUNC1_BLOCKSIZE           64
 #define SDIO_FUNC2_BLOCKSIZE           512
 #define SDIO_4373_FUNC2_BLOCKSIZE      256
-#define SDIO_4359_FUNC2_BLOCKSIZE      256
+#define SDIO_435X_FUNC2_BLOCKSIZE      256
 /* Maximum milliseconds to wait for F2 to come up */
 #define SDIO_WAIT_F2RDY        3000

@@ -916,7 +916,11 @@ static int brcmf_sdiod_probe(struct brcmf_sdio_dev *sd=
iodev)
                f2_blksz =3D SDIO_4373_FUNC2_BLOCKSIZE;
                break;
        case SDIO_DEVICE_ID_BROADCOM_4359:
-               f2_blksz =3D SDIO_4359_FUNC2_BLOCKSIZE;
+               /* fallthrough */
+       case SDIO_DEVICE_ID_BROADCOM_4354:
+               /* fallthrough */
+       case SDIO_DEVICE_ID_BROADCOM_4356:
+               f2_blksz =3D SDIO_435X_FUNC2_BLOCKSIZE;
                break;
        default:
                break;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 491b635e72b1..037a4efef924 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -47,9 +47,9 @@
 #define CY_4339_MES_WATERMARK  80
 #define CY_4339_MESBUSYCTRL    (CY_4339_MES_WATERMARK | \
                                 SBSDIO_MESBUSYCTRL_ENAB)
-#define CY_4359_F2_WATERMARK   0x40
-#define CY_4359_F1_MESBUSYCTRL (CY_4359_F2_WATERMARK | SBSDIO_MESBUSYCTRL_=
ENAB)
-
+#define CY_435X_F2_WATERMARK   0x40
+#define CY_435X_F1_MESBUSYCTRL (CY_435X_F2_WATERMARK | \
+                                SBSDIO_MESBUSYCTRL_ENAB)
 #ifdef DEBUG

 #define BRCMF_TRAP_INFO_SIZE   80
@@ -4227,17 +4227,21 @@ static void brcmf_sdio_firmware_callback(struct dev=
ice *dev, int err,
                                           CY_4339_MESBUSYCTRL, &err);
                        break;
                case SDIO_DEVICE_ID_BROADCOM_4359:
+                       /* fallthrough */
+               case SDIO_DEVICE_ID_BROADCOM_4354:
+                       /* fallthrough */
+               case SDIO_DEVICE_ID_BROADCOM_4356:
                        brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n=
",
-                                 CY_4359_F2_WATERMARK);
+                                 CY_435X_F2_WATERMARK);
                        brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
-                                          CY_4359_F2_WATERMARK, &err);
+                                          CY_435X_F2_WATERMARK, &err);
                        devctl =3D brcmf_sdiod_readb(sdiod, SBSDIO_DEVICE_C=
TL,
                                                   &err);
                        devctl |=3D SBSDIO_DEVCTL_F2WM_ENAB;
                        brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl=
,
                                           &err);
                        brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
-                                          CY_4359_F1_MESBUSYCTRL, &err);
+                                          CY_435X_F1_MESBUSYCTRL, &err);
                        break;
                default:
                        brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
