Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B671E73E0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 05:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgE2DuA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 23:50:00 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:15968
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388337AbgE2Dt7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 23:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds4hDDwtMKsttj7300WyNXgrdqDbt2zFyaAxL04gZrLenFA48K/Mt87z8VGdfARgM/E7YlqEpn+1VmPg4SN49lUNLcq8UNUygba4W6ro1h6v9dENtgdxGSpIz+YgN+8Uifm+a97PaRUqJ0qaqycU04HLHSjesiNTZnf/MUlDuB50lNr0hJBMt1pQ9o6mmN0R9hAWEW4HtcNq/2gblsDKryvJNq3S5W2wHn4XIy7HPdJvx5QpEscEutz7RkbwfsReg2PzolMWUC3UM+hO6GjTqWnRKRiUG6iYwaEqC4pLNeT0qJK0Km9dLeuwGmokfK0xkeaUkw8MEuDV7EihrBjJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjXysJpyqauXrvqsetGXjctQpRVyWajdSX322wBmyrw=;
 b=j/Xza+I754wOPGCl9+TFJ+KZ2+koix8Uz8/YeFMp8NZZR7alJoeofOj5ITFXm2ZBf4AdFwwhVLQ4s7jJiu+b7r3SbsNBr7rsXbnjOpoPDvRcH7QHk0ysaoen52kni7QbX/vJ128xjbtE+/F5pmJkOHhM0eLCJuolu5258qHKA7TIrXlCFvkfGXUctDmkrw83HG4ki0i+ZQGKma9p0MydXDeSo154vbAVf+r9Ap5SMZgAqSLyspo5IaxuzpPE9e3A2PNwDdXSFQWcpVeG+nypAceypNxgeVtAMdNI7msl4QkLbKSqXUngOkGbQ/l2UFacIZs5lH+jVmJSVj1QKLg9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjXysJpyqauXrvqsetGXjctQpRVyWajdSX322wBmyrw=;
 b=ZI9P+G+YUuyjuBZ9uSUBL11elkgeCpndbyolXm0MQcximvUbpXODYf+P1kGG8vDMiKUDnHc+H/1oDivD1YfztovMnOR/RxWRru+PdX2i4xUo1n3cZ15I4vkC0P0jbJV+d1K8GDIQXsdemec0RqVgzrO/Wm2jxHTUa9/ErHICoCU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4839.namprd06.prod.outlook.com (2603:10b6:a03:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25; Fri, 29 May
 2020 03:49:50 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:49:50 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 4/5] brcmfmac: fix 43455 CRC error under SDIO 3.0 SDR104 mode
Date:   Thu, 28 May 2020 22:49:37 -0500
Message-Id: <20200529034938.124533-5-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 03:49:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 244e8657-d7f7-48d4-d424-08d80383569f
X-MS-TrafficTypeDiagnostic: BYAPR06MB4839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB48399257F7576C7F92C6A8B4BB8F0@BYAPR06MB4839.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfOOIn+ky57cf4ZS2Sy+cUls85OjzqGRyWCeIjW5CpcrtIn5KRbkN6FEHL19J1h++bdp2JgnXPTbvRJ1pwLwnjRqKinNsIp90qZCmf+KyPeumhAX+cizqwu5kZnGB7NoH+LJ3dm0Pes5KpM0U5QVr8picc2EKuicP8qVDQurcoJUHEYuCaowMJ7WIFQjPmVJOAWOT84ZNkfHoqaZel64/dNAirC/z/Rs2HiGMbWDEW1SldkVIbMqMlMs4DoGeRj0zZoObX3ruL1eYoYE7dZMoVQMNJIIamVmKP/UxwY3W4BaLVqb1BhRVhuv6/yZU8WvPBE4vY2d+gkv42JwhkIMBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(66476007)(2906002)(66946007)(52116002)(16526019)(7696005)(26005)(186003)(36756003)(83380400001)(5660300002)(478600001)(6916009)(2616005)(956004)(66556008)(8676002)(6486002)(4326008)(107886003)(86362001)(54906003)(316002)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZAjwYocAPOojm+HbA5h771MjMju7A9Y2h5s8Mc6MiEuENguhuNk0qcjcNLAjSQuul/tOmYntWjyuBiFbMLdvxuubXGUpN7zd8DRwsh8c2uzgnb2pwzBvcdOga4/eCUf9nVuV2/Hz/ukJGRCBdvecRlKw8xu31akRFGS4Dgjom1tsQBLIpImtzPZ1Gb6svN3DHQDIl/t+K4m6gCQtXGUf+/3h6rFJ+0PEFa4tUnF6re1NcKgXSHgkQ6rNzWc9UccIF8ivT+ZNy4Lx+Onm0imleDJ1vTT5ZSlUC7W6X/oJGjwZptrYOUsUSTFuS5kuu6mRXgGEzrPUquWdCp+ln7mN70haL40mP3LewMU5+nokJUJf2HcryZqohJvvoz1v6nVKgFtYxlDy4yGSRSDfHYGqmyMEH6CWDWhhwm0lPuV3Oyx9Ax5OiGWWKFjIVBdC8FBmhpbT9q88jEg0qQEPJSbcn3yW/QEhshXqJBnBJjtM+KOZJELDvC5woaRuY2pSkLrC
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244e8657-d7f7-48d4-d424-08d80383569f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 03:49:50.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0p3ow1u9ut2KvEbWwuf0g76dPIgKA9eATlW6gXLBPpJXOATaYzI5RJtkG9mxh1F1ZcRjBGR1GzHb5cvIPl7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4839
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

This patch fixes 43455 CRC error while running throughput test with
suspend/resume stress test.

The continuous failure messages before system crash:
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 25600 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 24576 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/sdio.c         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 037a4efef924..58d9f0b90ad3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -47,9 +47,14 @@
 #define CY_4339_MES_WATERMARK	80
 #define CY_4339_MESBUSYCTRL	(CY_4339_MES_WATERMARK | \
 				 SBSDIO_MESBUSYCTRL_ENAB)
+#define CY_43455_F2_WATERMARK	0x60
+#define CY_43455_MES_WATERMARK	0x50
+#define CY_43455_MESBUSYCTRL	(CY_43455_MES_WATERMARK | \
+				 SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_435X_F2_WATERMARK	0x40
 #define CY_435X_F1_MESBUSYCTRL	(CY_435X_F2_WATERMARK | \
 				 SBSDIO_MESBUSYCTRL_ENAB)
+
 #ifdef DEBUG
 
 #define BRCMF_TRAP_INFO_SIZE	80
@@ -4226,6 +4231,19 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
 					   CY_4339_MESBUSYCTRL, &err);
 			break;
+		case SDIO_DEVICE_ID_BROADCOM_43455:
+			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes for 43455\n",
+				  CY_43455_F2_WATERMARK);
+			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+					   CY_43455_F2_WATERMARK, &err);
+			devctl = brcmf_sdiod_readb(sdiod, SBSDIO_DEVICE_CTL,
+						   &err);
+			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
+			brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
+					   &err);
+			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+					   CY_43455_MESBUSYCTRL, &err);
+			break;
 		case SDIO_DEVICE_ID_BROADCOM_4359:
 			/* fallthrough */
 		case SDIO_DEVICE_ID_BROADCOM_4354:
-- 
2.25.0

