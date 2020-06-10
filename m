Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2B1F57A0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgFJPVa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 11:21:30 -0400
Received: from mail-eopbgr750110.outbound.protection.outlook.com ([40.107.75.110]:38746
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbgFJPV3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDX7GWlT9fTnraaCodr13+SYXRlEHxI0mdIXMGrKg1ZC1BeKKiE70e/uPxj1ayvJ4h96HiLsvSNF8w3hg6LPaU+tCG9+snsz++qyt9l53MscbSQ38ad+a4JvsRWQqRez1Su/zN4gwEy5Mpuf3fdhce4J8Pkk04Th5O7Df0QX8vlZSgZCqcifFLEzX8ae6fiMwx1lV3HpOTiwif8thiGI7paGZ+b/9C99SAZiqO9+O1Vw4qaEaQKbV1nZSpoQ/zXwQ0gLlCgBRPBA2Pj9R1FDzaFove/YUAF48XUY3/8ftv8W88kocEovD+r+ucK/6KhA11TqOotAStNpPrfJb8TU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqvVsvBdTd4F2vCiN7cyq4Nhx8dKj4yLYoitzKtPBi0=;
 b=Pzybi6oZ9Xifq4213hMNGYw18U4mp7VwCN4xLHGW3n7ARrVVJuqZIdSyYDBSWQ+OWdhX8VsCPKrVWBxsHH2hxZLns/pG1lzQm+ocNL3/xEKQnaKgoCPCT2f/WeiL36SAU06QfvyAZVrx3LGs9y6GMwmTpnpjBgYLKhHqI2YzmAb4i020FWuFZncDzhfKr0vJhXQ6pzcCdJfBj1yR5bUthBv3YaTjv2G+fvohJC5s+IEmRvlXSjGStP8K7RHZft48v/KXMkT0cekROkyj2K28acJr6c3xF352gZeUapak8vNysHx8KNixcL3NqCeCH010Ga4lmSy7AkOBSi5krytmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqvVsvBdTd4F2vCiN7cyq4Nhx8dKj4yLYoitzKtPBi0=;
 b=CH9OBDju80Jy4C2OkTBEEB/1p686ppm7l+gHs921HKh61hYKYn1rqNobUj9Fy63SFl5uIZvIHlamVdwggeS/ISW4ZSg8lBwGhy2xTjQ3koCh3PR5ELzWtHyS0Xb75HgU0jGYqE7cRROhXqi22FuHJmaO4/p+aB3SLQD+37zZVGg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5621.namprd06.prod.outlook.com (2603:10b6:a03:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Wed, 10 Jun
 2020 15:21:22 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 15:21:22 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control path
Date:   Wed, 10 Jun 2020 10:21:03 -0500
Message-Id: <20200610152106.175257-4-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 15:21:20 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a64db2f3-8d9a-44ae-b6a8-08d80d51ee70
X-MS-TrafficTypeDiagnostic: BYAPR06MB5621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5621288C47D7058155B3D5F9BB830@BYAPR06MB5621.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1rsuWUhYljGNN2Wl0rS7RfY88KCyLbcdXyXaqrsToxkNvAsabcyhGk7bBVIgmOnpGb3o1EgYFuKgio6q0+230mlTtXLPFiSQFmlj2vYuWzjxoeEcMSZGNjU7Bj4c5s4+S2H07R/G7/iChBtiAylG4j1RpsDoFzVbl1nj2oEipC2AaNc4AVI4eerERN/gxztAM/94Cq4+sfuLsOel4oS4IeZTifI88tmIQBXLoVM/MIgyxQh/azocVcaGIFGT40K+YLGCtcdm2dkcZOp9qfIVO4/f5iI+N2cMQDmfRK2c40duzlythC/Xz8IdvVyeZHe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(16526019)(107886003)(2616005)(956004)(8936002)(26005)(1076003)(6916009)(316002)(6486002)(186003)(6666004)(2906002)(8676002)(7696005)(86362001)(66556008)(4326008)(36756003)(52116002)(54906003)(66476007)(5660300002)(478600001)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 52t2ye4kC9Fdl6Zrk/j5P857HfsXrC4Qln/NC1J4PaIB6zr59AlKlNpfEhO4EGTdFZ8T2dYWwn0y85utLAL2aadfa15rZC9gbD8ef2+jsdUpIS2BpwUsJVNu4PSemvT6fTCyiIVNDQG9ooh8uq9LBjmjxpr08lBUlQoNPHmmZDO2MjGFEXW6EfvM0APe0ecq4UoiJ5Cvi3NZTZJEGfV4L5y+OATzg4UZ8ykHQqzwxDw3KtdJQbT8qV38PISZ6xNKfv2MuM8rXPKd7hGXRTTPDuvUEy+fDODpG+3NZFvtGM7O8hMT9HHOtUGhKPNTnQur09yPUmrOlPUjMF4/4nqA4mbS/3BqZyhGLQMP8jApC8qInd0Npl3gS+cbT8kIuHBWBMaQtF4N3V2Cu3CIsFet+yR0WYUH0TgNaqEqjBUqPkiU3HQAQYzWlohIAwGV48Gb4WyyrLGwaBVgz1/IfilFTeoAZvncVgqGDlGjHw1t+ZPdC8rUiyXwNsn7p9MrbilN
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64db2f3-8d9a-44ae-b6a8-08d80d51ee70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:21:22.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43paNZXugn2bbwaMwCoqYYY/X5wY7MaBMHczPq3k3fJCBiredLR4YbW4DnhB9m+QQDFOIeADlsymszJOZiUxBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5621
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Amar Shankar <amsr@cypress.com>

It is observed that sometimes when sdiod is low in tx credits in low
rssi scenarios, the data path consumes all sdiod rx all credits and
there is no sdiod rx credit available for control path causing host
and card to go out of sync resulting in link loss between host and
card. So in order to prevent it some credits are reserved for control
path.

Note that TXCTL_CREDITS can't be larger than the firmware default
credit update threshold 2; otherwise there will be a deadlock for both
side waiting for each other.

Signed-off-by: Amar Shankar <amsr@cypress.com>
Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ce6f15284277..4da40436b4ab 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -635,6 +635,8 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012)
 };
 
+#define TXCTL_CREDITS	2
+
 static void pkt_align(struct sk_buff *p, int len, int align)
 {
 	uint datalign;
@@ -648,8 +650,16 @@ static void pkt_align(struct sk_buff *p, int len, int align)
 /* To check if there's window offered */
 static bool data_ok(struct brcmf_sdio *bus)
 {
-	return (u8)(bus->tx_max - bus->tx_seq) != 0 &&
-	       ((u8)(bus->tx_max - bus->tx_seq) & 0x80) == 0;
+	/* Reserve TXCTL_CREDITS credits for txctl */
+	return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
+	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
+}
+
+/* To check if there's window offered */
+static bool txctl_ok(struct brcmf_sdio *bus)
+{
+	return (bus->tx_max - bus->tx_seq) != 0 &&
+	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
 }
 
 static int
@@ -2655,7 +2665,7 @@ static void brcmf_sdio_dpc(struct brcmf_sdio *bus)
 	brcmf_sdio_clrintr(bus);
 
 	if (bus->ctrl_frame_stat && (bus->clkstate == CLK_AVAIL) &&
-	    data_ok(bus)) {
+	    txctl_ok(bus)) {
 		sdio_claim_host(bus->sdiodev->func1);
 		if (bus->ctrl_frame_stat) {
 			err = brcmf_sdio_tx_ctrlframe(bus,  bus->ctrl_frame_buf,
@@ -2663,6 +2673,9 @@ static void brcmf_sdio_dpc(struct brcmf_sdio *bus)
 			bus->ctrl_frame_err = err;
 			wmb();
 			bus->ctrl_frame_stat = false;
+			if (err)
+				brcmf_err("sdio ctrlframe tx failed err=%d\n",
+					  err);
 		}
 		sdio_release_host(bus->sdiodev->func1);
 		brcmf_sdio_wait_event_wakeup(bus);
-- 
2.25.0

