Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CD1E73DF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 05:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgE2Dt6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 23:49:58 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:15968
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388127AbgE2Dt4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 23:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMkJxReHZORecoyHGtS/mohj3/Gy/QiIV0gk38FXxuGkKUPBUhtUJOGPsRl/ddNPKZrud+JZ6NpPr79D4cAISA687gvAsN9fPFAp/mO/2CM/hxipBw256diptquAGTo4qH+0ALKpQPNOpFACQw/brDwHraFqLVGPtaa1K5WCuDMiX1dBBmzu8ly6Bx2q5itAz/Sq0EQF1DUALx/9TuxsWv/wM3N0NWp9X9+SApBHwmdOzU9ibMQ4brVw3a7rJIWoVGk/qIYkK/wKS1JeRlciYtgtMZNAKAxK7XBGxIWheBsbmcbM77t6uFLrPB/EIJK+JwfcKnTO2n8njT8R4AwNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0Dr/aBVqPha4YOTea4HTXrrfH9IfDVbbjn9gs0s1xQ=;
 b=KqTdwCK6XeSlRj15S+I04eujved1qa2MB+sqMRG0uUw7I2HkQNz/FqIVIvZWhtPUXvr8yAefut3rlUNGpyY0TGTZceMO3e56FIA04+3sjHWoAo6u97gac2xiRxr31YnXOIH4spY648vIvu30HC2tlzwuE5ogIn4FWPNenVfe4ZrdK+VCRqHiDnbTqyQxRWTKfUpkI/1D9SMKIV8Wy/q4zK4vN1f0FHa3PlBjtE/wtYTXSObOAATANp/39UiX3otto5Q6CyTPMBf1GHCkBwdIMxGwaO5GK/a7Ep3V+Ke8GJmLko0i6Qy8zTrt43AjUAIvsj9wguT3iBRzmlsa9WawXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0Dr/aBVqPha4YOTea4HTXrrfH9IfDVbbjn9gs0s1xQ=;
 b=N/lf4CH3df6wuYS1TYxXlXnTgmksO+vDJWNyeu+fjqWU7XJpZdIFKKn2b80bXJRaqHh6kcREijS48f6w+Nu3vT60H02juAAZmKO4oFCTqbqLI2VoaiyjUJvcngFUDLNmMfcqL3XQZMgQxtNNkiFuP1vmIVnbDlBHc0HtCk10c0M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4839.namprd06.prod.outlook.com (2603:10b6:a03:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25; Fri, 29 May
 2020 03:49:49 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:49:49 +0000
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
Subject: [PATCH V2 3/5] brcmfmac: set F2 blocksize and watermark for 4354/4356 SDIO
Date:   Thu, 28 May 2020 22:49:36 -0500
Message-Id: <20200529034938.124533-4-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 03:49:48 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0aa4ba31-e10f-46ad-0eca-08d803835603
X-MS-TrafficTypeDiagnostic: BYAPR06MB4839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4839873795FD697960FE0AE9BB8F0@BYAPR06MB4839.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mbyj+h7aOZubM94tjx2E9+yqe/q3UUefAkBA79ZN73nU/RfNhH7cduQCN7MW50f1f1qgU8b/4H2kF38ouGeOo0KAOMkUHHKN8ObtzBsU9W/BQxEXNMvyN/PI5+MuJC1/DNHaHiYGAUAQYIJhghSS9Ty37vv+gxX5prPUfUlz38CLoOiAeYE3Y/Pg8aM40jlc8mE7HJYRKZ94O1memFyMOOLrjFqIzcsdxQUGpXbjQSYr+eHyYNTR6fffZkHHel/RPMtUa9VwovoV45JtOcK6/Vrz2LlrkB27MNMLnVs4bC1mLTgOByPuY07fgSJyiHsxsX8yZEFXnAKSmyvrfno/uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(66476007)(2906002)(66946007)(52116002)(16526019)(7696005)(26005)(186003)(36756003)(83380400001)(5660300002)(478600001)(6916009)(2616005)(956004)(66556008)(8676002)(6486002)(4326008)(107886003)(86362001)(54906003)(316002)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: li8n84mPIvai7GGgZPkoKZ9L+dkso4A+B7E/eS+ITjP7IaZ2QfU/LRMbtxTMunzTn3JVkk9DOSFCkLiacRMCSqC5oFsEpUixqquBj8q7g9pL8w7ESsEmpg60C5FFc0w+SZN5enKqjpnZv7VHAtbb111IsOlEz/QdHBh805TRg/pV+RQWClpzK2nQv9rA98NXiO7tjJcEdI/u1PmatMA+zxUHELE9IlljMMAHZnZ6MlbPtAig62TtHhoABu9dRvchtHydZQAp8djQO6o54xgKomGZC+ita8xotQC7y647uAqrjTWm0VMvFmSiT+FID0slLoWCgyMBNoHOa2cPhqv7EHAxqeCe94R2RZXaGXmXwtW8rJCjth3H28VqZJjVd9WA/HVsxZ1atO9yY97mbU7rCLApltfAVw7SWRAqxSyigR+HHOA7713TMe43CTgXq5eznF9jIkzTr8Sba/p7gBtUhji9yX083/c8ygZopLhCGgdWbU0Wa7CgVNvH/v3QBM0Y
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa4ba31-e10f-46ad-0eca-08d803835603
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 03:49:49.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72NmDHiuiqC7Bmo1X8Dfo5jMq+OeBhRR8zlO4KpPlF09+nGfa4ceT3baAR5JVv8yI0oCaGTl6jYvSzOqq4GmWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4839
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

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index bb3196cba683..b1a66320ba54 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -44,7 +44,7 @@
 #define SDIO_FUNC1_BLOCKSIZE		64
 #define SDIO_FUNC2_BLOCKSIZE		512
 #define SDIO_4373_FUNC2_BLOCKSIZE	256
-#define SDIO_4359_FUNC2_BLOCKSIZE	256
+#define SDIO_435X_FUNC2_BLOCKSIZE	256
 /* Maximum milliseconds to wait for F2 to come up */
 #define SDIO_WAIT_F2RDY	3000
 
@@ -916,7 +916,11 @@ static int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
 		break;
 	case SDIO_DEVICE_ID_BROADCOM_4359:
-		f2_blksz = SDIO_4359_FUNC2_BLOCKSIZE;
+		/* fallthrough */
+	case SDIO_DEVICE_ID_BROADCOM_4354:
+		/* fallthrough */
+	case SDIO_DEVICE_ID_BROADCOM_4356:
+		f2_blksz = SDIO_435X_FUNC2_BLOCKSIZE;
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 491b635e72b1..037a4efef924 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -47,9 +47,9 @@
 #define CY_4339_MES_WATERMARK	80
 #define CY_4339_MESBUSYCTRL	(CY_4339_MES_WATERMARK | \
 				 SBSDIO_MESBUSYCTRL_ENAB)
-#define CY_4359_F2_WATERMARK	0x40
-#define CY_4359_F1_MESBUSYCTRL	(CY_4359_F2_WATERMARK | SBSDIO_MESBUSYCTRL_ENAB)
-
+#define CY_435X_F2_WATERMARK	0x40
+#define CY_435X_F1_MESBUSYCTRL	(CY_435X_F2_WATERMARK | \
+				 SBSDIO_MESBUSYCTRL_ENAB)
 #ifdef DEBUG
 
 #define BRCMF_TRAP_INFO_SIZE	80
@@ -4227,17 +4227,21 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 					   CY_4339_MESBUSYCTRL, &err);
 			break;
 		case SDIO_DEVICE_ID_BROADCOM_4359:
+			/* fallthrough */
+		case SDIO_DEVICE_ID_BROADCOM_4354:
+			/* fallthrough */
+		case SDIO_DEVICE_ID_BROADCOM_4356:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
-				  CY_4359_F2_WATERMARK);
+				  CY_435X_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
-					   CY_4359_F2_WATERMARK, &err);
+					   CY_435X_F2_WATERMARK, &err);
 			devctl = brcmf_sdiod_readb(sdiod, SBSDIO_DEVICE_CTL,
 						   &err);
 			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
 			brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
 					   &err);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
-					   CY_4359_F1_MESBUSYCTRL, &err);
+					   CY_435X_F1_MESBUSYCTRL, &err);
 			break;
 		default:
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
-- 
2.25.0

