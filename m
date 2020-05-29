Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763E11E73DD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 05:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbgE2Dtx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 23:49:53 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:15968
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388127AbgE2Dtw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 23:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHXE9JjcwnLO3dwPhFXmgu4v8WGiSjtcx06GNQp7pWEIicS/JC9sMdpzpRcc4EA8ypOQPZ9W6BMUR/D9tNmTiJRxUuQAjoG6LRsm9bmnlMOPcwE8zebJ9EHzZsMbwzoyPR7//QI5yKTHB8H0KI6hc/YCnMdZNTWlo565I5VlDKhArcsFoQWIkNKTuBjSERkr8GEm8uRwnyBiyP383ta6GulKnzoS+NOMmrvoDKG6dor3lWXW/DanySt0oCQ/DDA+uYWc+I2TDoTSm+7V8CJCkFzgVSw2tKCTjzXatfEKLJpyqjO5R/3hPKjhO0lWXCo/rS+zsIyTo34B6JF/knlLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT34NRo2N50gmbYudBerLBgw9vPCOSzmhxtvhmqQwPw=;
 b=AgOor8VDr2Sk8VZZZjEhEunwf1YxF3jK0iIG496GfKZ1PXKJvXEcOkB4UKopg43VZKT4WJF9+9Xh0FeZDPdCTaxTsOG6U1qLW1DokEnuRiI89fLcI9NgICQdmbP0+2iDvt9h2qK4h+G9Mx1w7VA/wRwjfmICUG4M0R4LFdTRU1aIkuJ9wX7r/5LarTJ1oWlITcQspClhXFflJ2SC0SLZrBCcq3BF4XNIOK98wfy2o5N8XJKiVVmMMxO9z5xQ50pkPhliciZDsSD1cd+y94DjbgalFdjl/cF/t+w/IuhTDUjZt1skDQMis5wTXzhDZ2QCxtlh+pizgLKpHj3xSsEgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT34NRo2N50gmbYudBerLBgw9vPCOSzmhxtvhmqQwPw=;
 b=Xba3LBhOO2x1sKm27JLlQdh8QNxtMvhfoWh0MEqCcWKVzdpoGp2QF0gxgFBSgxl7iOfTViS5eM0S8lxQlpDijgcNFm/RKKm98NmQ/nuccwugVSusiRHUwloPQoBAg3lKJWTcOOHB5DC90SKDNJKpDkgkuFmNdzz5FQxwK3dzSos=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4839.namprd06.prod.outlook.com (2603:10b6:a03:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25; Fri, 29 May
 2020 03:49:47 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:49:47 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 1/5] brcmfmac: set F2 blocksize for 4373
Date:   Thu, 28 May 2020 22:49:34 -0500
Message-Id: <20200529034938.124533-2-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200529034938.124533-1-chi-hsien.lin@cypress.com>
References: <20200529034938.124533-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 03:49:46 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fe1ba95-3388-40fc-ff94-08d8038354ac
X-MS-TrafficTypeDiagnostic: BYAPR06MB4839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB48394FB4D4374A2E11DB57F9BB8F0@BYAPR06MB4839.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYs5Z+VXBlJU6xgdqB1NDdb+ypwNGMDHPbPerzKDSbfy8F/0zBsONvHcCXm/00/hk9VLvzRznO/0V+dFuExsxO3nutB9eUeEBHNvcmSSSLB+O0zeARX3P3fsyaw3s2FbMoJU6cwuyMOawnj6m9d0yvnjES/bDaCrJELIMgXTMW4Wa+8oWG9Kv2QmnoHY4yn8e+PdWaQ6Luyzl5zRZJDzblEzlB23o/7X4jLF2oi4VKsIXFrsPsMiGI3eBniWtu12uN8DKSyN7Bp+aO/oW/1SsjDEj9LfLDJ35GjStw33w2q1ak+wOs0UvgAziNXPOlDn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(66476007)(2906002)(66946007)(52116002)(16526019)(7696005)(26005)(186003)(36756003)(83380400001)(5660300002)(478600001)(6916009)(2616005)(956004)(66556008)(8676002)(6486002)(4326008)(107886003)(86362001)(54906003)(316002)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OxBWMcxZTdGkp8Dhec6VecMGK7wkkocBK+GpE3EGA0o+Beo7ikjKezUmccDofvmUIQnpyLTtsKiiGWpJRCY8HHfP3hdzTG7cf8Kcq95Fsn2SFLObceuOa6sDkAj2b4/eH46dJFGYn4zA7UlnumcTGCXI6u2fUZUMCPP1yjhn384JVrewDeYd4wZmL6Fd38Ds1ZIgFhwpt9DVex2ISraUQturD/zcgVHVR8c5ENRVi7c42vAUsJc6zA43//8cwALPab8Z/bnttG3csljTilF48sGEa0YvgJRoH2SdnaEHzw34rxoHIvVCI51IGM1GuJVhk9CtiRaGw2bWTkrLw5UHvTrtszIbrmvR59JNrp0GMN3hKCjSLU2mg0OWVLw1c0WOz8NdCNJZ2mOYl/4QjcoO44oEjNvlT9LwwKzqZzA05Z5loRZHstXNNJ4WqROjfhA+FMvxbpVd+nvrny5G5v7oKQpsDkFwHCvIXaBoKMWIGThV0Ewuy7fQ/0i8AsXTL22g
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe1ba95-3388-40fc-ff94-08d8038354ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 03:49:47.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUiHEGC8KdwNhrXIto9WdhMWnKBy99CbMrGr8RDnH66+Jq2mdT7xWSXh2p7hu5iEltlRSHBGZaEaBWMTIsCA6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4839
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

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 22a17ae09e94..bb3196cba683 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -43,6 +43,7 @@
 
 #define SDIO_FUNC1_BLOCKSIZE		64
 #define SDIO_FUNC2_BLOCKSIZE		512
+#define SDIO_4373_FUNC2_BLOCKSIZE	256
 #define SDIO_4359_FUNC2_BLOCKSIZE	256
 /* Maximum milliseconds to wait for F2 to come up */
 #define SDIO_WAIT_F2RDY	3000
@@ -910,13 +911,24 @@ static int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		sdio_release_host(sdiodev->func1);
 		goto out;
 	}
-	if (sdiodev->func2->device == SDIO_DEVICE_ID_BROADCOM_4359)
+	switch (sdiodev->func2->device) {
+	case SDIO_DEVICE_ID_CYPRESS_4373:
+		f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
+		break;
+	case SDIO_DEVICE_ID_BROADCOM_4359:
 		f2_blksz = SDIO_4359_FUNC2_BLOCKSIZE;
+		break;
+	default:
+		break;
+	}
+
 	ret = sdio_set_block_size(sdiodev->func2, f2_blksz);
 	if (ret) {
 		brcmf_err("Failed to set F2 blocksize\n");
 		sdio_release_host(sdiodev->func1);
 		goto out;
+	} else {
+		brcmf_dbg(SDIO, "set F2 blocksize to %d\n", f2_blksz);
 	}
 
 	/* increase F2 timeout */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ce6f15284277..dce22cd2279d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -41,6 +41,7 @@
 /* watermark expressed in number of words */
 #define DEFAULT_F2_WATERMARK    0x8
 #define CY_4373_F2_WATERMARK    0x40
+#define CY_4373_F1_MESBUSYCTRL  (CY_4373_F2_WATERMARK | SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_43012_F2_WATERMARK    0x60
 #define CY_4359_F2_WATERMARK	0x40
 #define CY_4359_F1_MESBUSYCTRL	(CY_4359_F2_WATERMARK | SBSDIO_MESBUSYCTRL_ENAB)
@@ -4195,8 +4196,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 			brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
 					   &err);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
-					   CY_4373_F2_WATERMARK |
-					   SBSDIO_MESBUSYCTRL_ENAB, &err);
+					   CY_4373_F1_MESBUSYCTRL, &err);
 			break;
 		case SDIO_DEVICE_ID_CYPRESS_43012:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
-- 
2.25.0

