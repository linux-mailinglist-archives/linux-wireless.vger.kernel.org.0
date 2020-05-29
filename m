Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15E81E73DE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 05:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbgE2Dt5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 23:49:57 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:15968
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388037AbgE2Dty (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 23:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZgcBLOu777B5ZpaoAZ+8fITxY5Y/TMlMYbTRYNAWlA212uemzSjWN+TGLWPRCkEhydXNHvHKqsEbF/77Hn86E+TrepxPd1XuKQ/aN7d+vhZId7os0SgoZ5J+xL/0AmzT/dA/IBpoW0OuyLhl81kyTUqc/IRy5pdy+hZe83KoMvYI6KB+vc1ouOh4gFLDRO/PrLu5isvnybi7kq77J5Y8sPpVh4QJpZ3FXeOtlvHy9G9WC7zYqJIW/gE14YXJYaC8bMJVwbP2VqQz6PzMUj5Yq/VsmdxiYTdbImmsB/3OajpcV6MSh7g5fOKqVMOu9+k9gYE2nzm6RGtyyawy1MWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM/2HTVcpY6qXHj38f6p/B2+3120kRfxmM2StYpFC/U=;
 b=TvxiaQ6M2Ya9waXk84CnAjrPD88rd5ip0rByB++d2Fs3+rSKnywo+GqGcLAbdxIXKuqg7mo3mDcMjU3cCNV/gRZ+NtN0IKPAshfRq991KuingVVpuUvRK9gB3wKFBt5QmRpwgRo/rdASotjzkznnd9qAdgSqkbmdqyGiKmR5iZ8aaHdd2DFwNf+QZi+zgZnaf9CjQI3QLi/VQ4KVHgDxo2ItYIkWbFaj51UvjNArO7mB2N7PJeNKs1/wQ1KZ5+HyPYepJHTKHnxuJ6gHyVWzk2Bd9lDBzFbfqJDye06WME7RKvaivRaaQXykDWPIXGrZ2yQEaI7RBFS7Bk0NNKpOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM/2HTVcpY6qXHj38f6p/B2+3120kRfxmM2StYpFC/U=;
 b=p06NRDS4RmnkitY0P+3PfKcl8HHkvQMuCVgARvwx43mkjTsqwob6T/G33HgX+kD+WN9tSnThZ/QjbQMdM4wU3LVX9J7Pv43p+FxBiiL1H9sHQCPLA9d6BUyit/7I6EtV7fEZ4FK5SG9XLfG2xdCodwrf1TKxdrmbzOm7ZOU9R8U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4839.namprd06.prod.outlook.com (2603:10b6:a03:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25; Fri, 29 May
 2020 03:49:48 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:49:48 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <double.lo@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 2/5] brcmfmac: fix 4339 CRC error under SDIO 3.0 SDR104 mode
Date:   Thu, 28 May 2020 22:49:35 -0500
Message-Id: <20200529034938.124533-3-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 03:49:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e44e6d86-832b-4012-7593-08d80383555b
X-MS-TrafficTypeDiagnostic: BYAPR06MB4839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB483907F033C47142D5824227BB8F0@BYAPR06MB4839.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvWlnQ7uBCNLY7p3OWq7KdOwDm+rIM4I95TuqnDC7yRHfBm1eCJc4xY5Y6fUtbWcOW9fgtnlrqtvMrAMMn3cmcoEN5rEzi2whys/q+sH46tt5rBRE29tO36g/zHuV1oGDTKN5zwKHp/x/fTCJsm8WVLIUXseFdihjuVMUn4uHFwwsxhYQqVEIae+Ngv7dQOL76X2FcfYsBCfxJF5eNwbv2TYyffqFv/KD1m2i70UqAE1hyyf8jVKcDPLTq2Ui0nmElWcQIa+juUbaKmQPeHGzBBsoR2eQKu3NO9xy1lKtl28oPvlSh2fwWbRBX5zI4S1ZYyLAgpu5r8PPbwvVI9sCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(66476007)(2906002)(66946007)(52116002)(16526019)(7696005)(26005)(186003)(36756003)(83380400001)(5660300002)(478600001)(6916009)(2616005)(956004)(66556008)(8676002)(6486002)(4326008)(107886003)(86362001)(54906003)(316002)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nfUm5Gl1GtC7kPLdoQqPpDz8+v7WAy54wR50rUduqnl5uiZQiCfc2AssoDjizxMb1h5fYrtTNrkDNa2irwNv2BRbLMkzYw2uHcImdv7bptVtHH3VwpDUBkVN7IZgmU/c2YtTONIEmrCFKeoANcNKs7Ga2alH7k7HlDajWY0/lGosdu/aVyIkH0rxBIJ47xSLp0NANi+SWGIx1Op/8j6DHOeegcg2pxdPk3+gxrHkE4qOYCubEPtfjMpMa1WECAHD8+UBFyYXxt+L4oA9EZe5fedkXDV2LoHylH2V+Elh4yFgGS25y9rCdJskf2W0pliJmDCaZyadj4T7sriUmzipKCP5eqw0bo9wrxnhzQAgE6yh9OoSll7OCYT6XqyLaRw9N7VbiYW09vGoqjlmkN8bbBpw1FqVRRVR3nbWZnnOeKDA+E6ba9ReAjZu+0smfNmX8jonUB1k5fwADCmU54msN28LDNCJv4/KX/vEUS19FfHpc4D2/wQ7i2vYZB/Vjrrx
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44e6d86-832b-4012-7593-08d80383555b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 03:49:48.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +o+5PGX4j3ZwGKGIcAt+6nz0OZtPP6vY+q5O304m2GV/PJuhIWmxR+8abVA06h/1PSKlHfFD4tX4hlwcYDUK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4839
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

This patch fixes 4339 CRC error while running Tput test with
suspend/resume test script.

The continuous failure messages before system crash:
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 25600 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 24576 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index dce22cd2279d..491b635e72b1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -43,6 +43,10 @@
 #define CY_4373_F2_WATERMARK    0x40
 #define CY_4373_F1_MESBUSYCTRL  (CY_4373_F2_WATERMARK | SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_43012_F2_WATERMARK    0x60
+#define CY_4339_F2_WATERMARK    48
+#define CY_4339_MES_WATERMARK	80
+#define CY_4339_MESBUSYCTRL	(CY_4339_MES_WATERMARK | \
+				 SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_4359_F2_WATERMARK	0x40
 #define CY_4359_F1_MESBUSYCTRL	(CY_4359_F2_WATERMARK | SBSDIO_MESBUSYCTRL_ENAB)
 
@@ -4209,6 +4213,19 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 			brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
 					   &err);
 			break;
+		case SDIO_DEVICE_ID_BROADCOM_4339:
+			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes for 4339\n",
+				  CY_4339_F2_WATERMARK);
+			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+					   CY_4339_F2_WATERMARK, &err);
+			devctl = brcmf_sdiod_readb(sdiod, SBSDIO_DEVICE_CTL,
+						   &err);
+			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
+			brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
+					   &err);
+			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+					   CY_4339_MESBUSYCTRL, &err);
+			break;
 		case SDIO_DEVICE_ID_BROADCOM_4359:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4359_F2_WATERMARK);
-- 
2.25.0

