Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8217B1E9EFC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 09:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgFAHVC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 03:21:02 -0400
Received: from mail-bn8nam11on2111.outbound.protection.outlook.com ([40.107.236.111]:48577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgFAHVB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 03:21:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daNbPrstdoJh7QCnWd4gAKELVFRiGO+BeEvUL++cP/2uG9MgUxZ9I8AZkb7weddaDC9A8m3XZnveqgrIM+DEUsoLwRX6eYEZd0zhpWFpn5PeAG61riff0NYlillXhWbU+MR87BcB/rV9E2xOEJFm2i6x2weHmJJyq+Xumn8J1yXOClKkOB5PYXloXOjKjGDHCX27t7kl+UCT47ta5x2NTUj+hUZYcXeZ3lx6lbSPgZZV2bCiDtl2O6dydw+s1VgrGxiyMpr58epczzxKWYb18BlTiLc1YB5nYMe+oRSom9QvxCLdIzIZ8mbfJCQnaSd1lsJf/e7XC17bSvyO7QjW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXW1dYlIpU3N+IiooStW+231FDUJf74Mcqp8d+lNAiw=;
 b=BUMxYM29r4d57o7LIXsnVa5nRP/ZyrfiHjEr95luMsu1D/D+HZj7nKb358MZh5fA/urhAgUoZ80276DENnFqfCqBp6SPSQlu+RsdcFZ3hRfeP20JMAqWZCz81l0iIyMPVufzQdCj32lmldVfGYGvX1B76WtgmQJRbbTIyQ1pMLyxs1p8RnPbpuztXOC72vCqVTRO5FB+Wc+1PgY/rcNNizLz4Lt45e6xMnE7LRSX3i5TOL49/o2KVqPQ99NA+w8BC0N0FI5VIALLDJiJN5mpNrzDb/R3axP9z+KsHlOl+X76FmE2NBBsYdKZ1bw3SEtlhz434p66oRmdgbSE3FmJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXW1dYlIpU3N+IiooStW+231FDUJf74Mcqp8d+lNAiw=;
 b=XiQGl4NU4RTc4KCrPa4xpd2NSObhT6Vk/RdjzwFTHX+XrdKT5aN1wEahdR5W9jxjKH4uiu6OxHDL882ZrSiwLhHRZfBlmEIK0vKz68Khsf5qiGd5nXbBtzZUvbAqz8XHzo9e8/raJ9OW7FhOAek0n1DA0A3smejL4wK1HMk+sXQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6074.namprd06.prod.outlook.com (2603:10b6:5:10f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Mon, 1 Jun 2020 07:20:58 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3045.018; Mon, 1 Jun 2020
 07:20:58 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>
Subject: [PATCH 5/5] brcmfmac: To fix Bss Info flag definition Bug
Date:   Mon,  1 Jun 2020 02:19:53 -0500
Message-Id: <20200601071953.23252-6-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200601071953.23252-1-wright.feng@cypress.com>
References: <20200601071953.23252-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 07:20:57 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d66dce3-b9c6-4d30-177b-08d805fc547f
X-MS-TrafficTypeDiagnostic: DM6PR06MB6074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB60740211BF1DDE769682D94BFB8A0@DM6PR06MB6074.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RziA3AdpsgVkooRie4Ja7oMEMgO6DPDeb6V+TchvFYjdg7TAUeyjo+Y5ABb+K8jN2n3TCVMon2OlM7Gs/LIXMghy9o+Fkfy31wz8RztblrH8XD2HX+/EfbZaSunOm1UMWH50z02VDsyLNfscLvezKmiaeOn5t6wRtIPlUJyUTDGx/jW0Osq8UNo7OR8oyLakZKC2RD5Ov8oiMx1OeTpuMKJDkL0FJq6aUYF8mA4XvWBQ5hQNVEedwOeeDTf3kYMnDFIv+QIJGRr4iN1Gvg4z17L9py/xSh95x4rfjt5ytMI/t9Kzq0QBC0UMWBobsjVU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(107886003)(6486002)(83380400001)(6666004)(66476007)(66556008)(66946007)(4326008)(316002)(54906003)(8676002)(8936002)(36756003)(7696005)(52116002)(5660300002)(6916009)(44832011)(186003)(16526019)(478600001)(86362001)(2616005)(26005)(1076003)(956004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: AoBg2niJQ/35zAAN3TRO8+9eDxHi37ie8N7w+7WXuL/M1AwJ6UQ1G/E9Cm23+YnBPUgUZE0nABUrwU1QvD8PhOnlgwJIVX0lTbxjUm2v3XNmW1uDfXJZg3Ms+kjbxfuJgUq8LIJkCyYCfrJIKxBPw9w9jZxxSjm36bIIumvS+Th0tR521dpDvi62xag4geJdsHmXFl3ZDLLwHqxhZ8tcTz/rduYqTUJXPl4ce8+javujxu3dcS+QeTAG3Lraq9bemPjHjzl+lAd0StaeUWkjES412fVZFm0QoUcSM3QK8FqRofejoZeYx1IsLtT/FQwfb86Z7CHTbzvnScJ8JRqwoBmgbwpPOT2khfG0DQcnaRy8UsXjUfTn4HVfM6rtwk7sNDaEzeO42FIf60FyaCLVR4yp8iJAWBV7DDy/uPg5vKMbh4UW1T5vyV7foawSCTb703YBK66Y6cv8HFSI156i6T0tMP/vnHchljKZ+bKXvwyLVv5HTgQuDT+PuwTXe0/0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d66dce3-b9c6-4d30-177b-08d805fc547f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:20:58.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i96WoVA/7Vfw86eVR8r4XNhyVt5MKNCBWsA/ukBwjjQu1hHkHXwcpW/RH4Rg3F6oL41XuQ+MufuS5W8U0B9QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6074
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>

Bss info flag definition need to be fixed from 0x2 to 0x4
This flag is for rssi info received on channel.
All Firmware branches defined as 0x4 and this is bug in brcmfmac.

Signed-off-by: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index de0ef1b545c4..2e31cc10c195 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -19,7 +19,7 @@
 #define BRCMF_ARP_OL_PEER_AUTO_REPLY	0x00000008
 
 #define	BRCMF_BSS_INFO_VERSION	109 /* curr ver of brcmf_bss_info_le struct */
-#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0002
+#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0004
 
 #define BRCMF_STA_BRCM			0x00000001	/* Running a Broadcom driver */
 #define BRCMF_STA_WME			0x00000002	/* WMM association */
-- 
2.25.0

