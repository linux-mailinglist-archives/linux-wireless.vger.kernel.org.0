Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B11DC5E0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 05:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgEUDs4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 23:48:56 -0400
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:9153
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbgEUDsz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 23:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP/uAR3eQInCm+0/VnAIKTmYUnqaQO2JsTjE7sBicd8ZmtO+KdzLZysM+A0Wefxzt2SGNdDbzJa/KX0EdxyITxLORT/zVhmqjUM28KFwPsMJYF3UnWzLi7lpsguLj1nOQHp3lTONpmE1voItMwRnzxAFRrJ7fpoH5tkjsMfust0IgrFTxMdNP1ykCOEmkBBjsUD4XGy1VAMdD9ar+7Gl5RscEIjyhNIdiFKIbBp7lm+SR858XoND7h5TOTP4E2uZMvui3EILmly3f/WRBTryd/GouEGPwyjn+T5w3h9PI/NbEhLmipI/vPjXiZ+zv2jpTGzd1wImxvZvlyimUn6YlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gUzyH6QizgpGUFTU2B8t3Y1txxfAD1IRfn/nYuT7ho=;
 b=NechDzCSWmFXF25YaQf4UgF9RlnrJ0j9vYidg0jt0VqxXztAYmVwB8n0b4W0/ycDmMCXd/4EHQ4PpPocnoaHnzqaI59ioU6S8x2Xi6Pbl7ZWdvh5ajImparZiFQgugLRVZ5kUv/YOqYl1jl33giYUiCHoHyEZoSR8T3mXeubfR8ftftSz1PEXu+qlXJw3/KqTd97jlhCfuML+yes6F3MD+U81z95/sKH+2RHv8n/tACrZN0THTh5DGFcRXgj+yH2tQBcw5GIGZDwSmhI2QHXIGlWd4itRrGDjW3ISQ76ZuA/pPo0cMI9at0L01rvXZiazSmZ/8mnmf8dDtNI6tVcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gUzyH6QizgpGUFTU2B8t3Y1txxfAD1IRfn/nYuT7ho=;
 b=ancX1q05OY2IYPxk3PsRXu3teSTJlXw9L8Qx+U2n2ZPm5MAF0vCmkQTcPKJIZevO79wHVPVpOZ1Bv2By1+pU/0wDOwlm57pUB9dYSYBtYbVsV4RUYV5BuA1gdPD33nwe4JSGDe+qvVEmQjCIzBc5Uo5h7b2zOmUWW9USJmer+7c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4024.namprd06.prod.outlook.com (2603:10b6:a02:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 03:48:48 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:48:48 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 1/5] brcmfmac: set F2 blocksize for 4373
Date:   Wed, 20 May 2020 22:48:34 -0500
Message-Id: <20200521034838.57371-2-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 03:48:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9625517-394f-45a7-bd82-08d7fd39de47
X-MS-TrafficTypeDiagnostic: BYAPR06MB4024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB40248F9AE47AC5CB55F36810BBB70@BYAPR06MB4024.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fh6GRWwK3RDk38NTVP4zRPFoCLAGNRiwtzVPeMfED8ou/YH06ucW5/4EbH0HSaKPZ/ow+mVhi48mViDZY+dEjRzIP3Pef4LCbBH4mQnTtVipRc8tKY/2zC+tpr+gvZo83JW9e0NNteByUb7q7hWzfv5ZpF3ZLH3z0NtUx9VWUzuJVWJMc8+oeQNlB7PYOPnbF2JZWisKY5sJu//WiwxK2/HXK7iIXOuSMf3XhYk6wil3Tr3pGkohQW/Gg08s9dvhS4a7howmc0RBYfYIDFbQ/mwpJ5H/0WHBwF3EvmZvNHdBbv2NxTiOulHoi/wNqd14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(26005)(6666004)(107886003)(7696005)(1076003)(52116002)(86362001)(16526019)(956004)(5660300002)(66476007)(66556008)(66946007)(54906003)(2616005)(6486002)(316002)(36756003)(6916009)(8936002)(4326008)(478600001)(8676002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: p3IqEgklNTjaKDnsaXRozncJkSWvDO5J4xc9YtPyZ1Nab3oLFa1Z4pAg41hR8OOU1zRO06F/GOK5DZHtiAIKswOgagY3lXF0tTYfOsqXCJxA01O54Snppa+nLldEZUf/cZ93ColDR3WT7hGIO5bKGbSHWuLMng+dyFSzycJvBydCHbmZ3Qj2EtzO0DytPDgphsJM4djSOGu7WGfG+gcdlHywMmEPoYC9reOBsQT/35dKydaiRdTTroL4ky2pP+ccITtIsg9myAc+SFIVD08QuphU8KCXtYb7oaoailvAhVajb2zb7viXlmZE39a2pLxFa2VZC+Ctr9tJjEuKalgIyZsWQCqW3psTiX8LbBMnoy06rwwF4RIXGTHszgFOd3hCLoMuTjt9NS4Ic3K+gPDp2Lq6xCMxZBZO3WFRqVb3sfBHfi+TFuQEunX28n8Ynzn9yj35eWxdzw8ioVIqkEU6PPKOLkWM2NHnbEL3oA7QY4LrWBXwgG8RmkMEidtzA8W8
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9625517-394f-45a7-bd82-08d7fd39de47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:48:48.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUa+c6Xo4r7wkhSz0SAf8JGbhU2xNyWJbzKj+pSn9s7/ErKYF2sq+Plt4p2saUAZgOwEypat+Jqpsq3l54zjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4024
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

Set F2 blocksize to 256 bytes for 4373. It fixes DMA error while having
UDP bi-directional traffic. Also use a defined F1 MesBusyCtrl value.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  | 14 +++++++++++++-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 22a17ae09e94..bb3196cba683 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -43,6 +43,7 @@

 #define SDIO_FUNC1_BLOCKSIZE           64
 #define SDIO_FUNC2_BLOCKSIZE           512
+#define SDIO_4373_FUNC2_BLOCKSIZE      256
 #define SDIO_4359_FUNC2_BLOCKSIZE      256
 /* Maximum milliseconds to wait for F2 to come up */
 #define SDIO_WAIT_F2RDY        3000
@@ -910,13 +911,24 @@ static int brcmf_sdiod_probe(struct brcmf_sdio_dev *s=
diodev)
                sdio_release_host(sdiodev->func1);
                goto out;
        }
-       if (sdiodev->func2->device =3D=3D SDIO_DEVICE_ID_BROADCOM_4359)
+       switch (sdiodev->func2->device) {
+       case SDIO_DEVICE_ID_CYPRESS_4373:
+               f2_blksz =3D SDIO_4373_FUNC2_BLOCKSIZE;
+               break;
+       case SDIO_DEVICE_ID_BROADCOM_4359:
                f2_blksz =3D SDIO_4359_FUNC2_BLOCKSIZE;
+               break;
+       default:
+               break;
+       }
+
        ret =3D sdio_set_block_size(sdiodev->func2, f2_blksz);
        if (ret) {
                brcmf_err("Failed to set F2 blocksize\n");
                sdio_release_host(sdiodev->func1);
                goto out;
+       } else {
+               brcmf_dbg(SDIO, "set F2 blocksize to %d\n", f2_blksz);
        }

        /* increase F2 timeout */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ce6f15284277..dce22cd2279d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -41,6 +41,7 @@
 /* watermark expressed in number of words */
 #define DEFAULT_F2_WATERMARK    0x8
 #define CY_4373_F2_WATERMARK    0x40
+#define CY_4373_F1_MESBUSYCTRL  (CY_4373_F2_WATERMARK | SBSDIO_MESBUSYCTRL=
_ENAB)
 #define CY_43012_F2_WATERMARK    0x60
 #define CY_4359_F2_WATERMARK   0x40
 #define CY_4359_F1_MESBUSYCTRL (CY_4359_F2_WATERMARK | SBSDIO_MESBUSYCTRL_=
ENAB)
@@ -4195,8 +4196,7 @@ static void brcmf_sdio_firmware_callback(struct devic=
e *dev, int err,
                        brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl=
,
                                           &err);
                        brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
-                                          CY_4373_F2_WATERMARK |
-                                          SBSDIO_MESBUSYCTRL_ENAB, &err);
+                                          CY_4373_F1_MESBUSYCTRL, &err);
                        break;
                case SDIO_DEVICE_ID_CYPRESS_43012:
                        brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n=
",
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
