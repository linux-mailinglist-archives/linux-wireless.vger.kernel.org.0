Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA40A18ADA6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 08:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCSHx6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 03:53:58 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:45696
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbgCSHx5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 03:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN1xUzREBMJKd/PEMEjlkjiNjJbwgIcy9n/9m5Wq/BQIrsSUHfCYVsCljEPWfS4BNWQ2qe6xbctwajqXl0xoC8nzcYK10q7uJnQaKALDil/lz+1f+hTnj5ZZlbLstQ0CUnhb/JppgiqURi35ctS7p9WFBRkrR+85Nx4oKtU0jfnKMKqlPKctqK4Mkv4K1ork2YQFmJMjJeDBCdktsv2aMcRNE9nr6ejXxrNF/LF2pZXPUbsact/n+ZED3hjuNwySEBVzEuxyiqI+8ZKmAaTL2Imwfiusil/crc2VObItjiz4AV9XlFMBM/lsUc9Jp28I54rdOmdRJcAKxB+/J2qD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch9/7mkktcUdo2uQ6Is5BkuAASNurzPXKun22Pcok4k=;
 b=Tkr1x8ZTVKs71auZzi1zPdzgA2ZmdaWtsByfUTq3i7fQ3akqPzuzsKzX101WlLfhOZhF6LlZ7S7PLYmxVzCamt6kqzA7nq8cQSbunleexTpfNMKnNX7ASK/o2tysVjODrTNqW0EQzvTP31dY9IZE1YlYH6m/yByds58rhpaWDElyIjIyO6/LXEHliauwzjrYk4BtQcy81p2JSAlnOgYMSxTQ/PhnPJC04Y1Umc4eC3fqpLlLSwXS2YMJzYdlm+HVjz9mkrDG/S7VWPMDcUfqQgaQwz5/Lo+a5Yy9Y/F5zmisQfVkKcLM7OI/gZIOcKSsfqRhcWssD7WjmKvMrQkheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch9/7mkktcUdo2uQ6Is5BkuAASNurzPXKun22Pcok4k=;
 b=nIq8o9YAtaUasX1ZfupYKYvfe3DYoFwe458FP8CVFo+FvCA1qvPAAuzYAPKGbtrtMqyaemtVC/bzYEq7kqtZ7L+bMSGcemNj7I+KFcp4qjWwHJRO5u7h70eNoNAWZqYWS6peR3eJG3k5szZ7+Kr9KuFp8gaEnHFsrZiJKY2KViU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4585.namprd06.prod.outlook.com (2603:10b6:5:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.23; Thu, 19 Mar 2020 07:53:52 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2814.018; Thu, 19 Mar 2020
 07:53:52 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a module parameter
Date:   Thu, 19 Mar 2020 02:53:26 -0500
Message-Id: <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (12.110.209.245) by MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:53:51 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f83298f4-4671-4436-8680-08d7cbdaaad8
X-MS-TrafficTypeDiagnostic: DM6PR06MB4585:|DM6PR06MB4585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB4585C549D17936DD03B22073FBF40@DM6PR06MB4585.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(44832011)(52116002)(36756003)(8676002)(81156014)(81166006)(8936002)(6666004)(956004)(2616005)(316002)(16526019)(186003)(66476007)(478600001)(66946007)(6636002)(26005)(6486002)(7696005)(2906002)(4326008)(66556008)(5660300002)(86362001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4585;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/BUeUteEye06CAal7JSipT85a0xJUdWgbkGlqPBAADmW2PUbHmfYhgfGvMaE5LZ4doRL9BO3BxMpljEv95b/02v7TwjABRsix5DAJwE6EaeUZztrmTRWQ2gXeaJs5ri5qkA1PVMzaAVdGYRLGJH/CdGsGFNj3SkJtEphek6wvvobZZYY3ekJkfKs9Wo3s34iu/9+rQhts0NjDWJw79KYb7ySvPfY6c9R8wzwvVX3Ko4O0WgC+93md5sJA7z11qMZa+UXiTFryESe+nn56040mQdPeKoBTcVk7v5rK9Q9gVfCxDUMQGixpi+EGhZRnk9yxvu/GctwefE6+rgLL6k0rmUhM2WcZkaMX9sr1Z+V/VqscrkkntSOJcNzh299tmN3UsVKK4cquCP/sr17k8bCQ6RbtZXxjYzFzZ8hSPboX0SG9K5ON6lsXUnW4mOQt5TasRxX5a2NDXyEQkfJ74hPoolNFBoduLnFIDsFwGDbEYwPUcOfZ3tFRmIQifOqIfW
X-MS-Exchange-AntiSpam-MessageData: hmV0Ei+sq2en5Hy3U28i3ImqDq+JX4Hz7bSw31cdDk9IXZJ3ysvuvbWRzPRAS3X9Dpndh1z8913L/1ZLf+R1UWkd+eAKXC3W9pDUFVYdJetDk8heeGFvdhqtGWG3n8/q7x+itotdZ2oJDNCwTnj/7A==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83298f4-4671-4436-8680-08d7cbdaaad8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:53:52.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anZhjYyVxf8AN3lImTeRuDWb0byvHQ36CRbVd0lII6P0Xut0alpViOrQpWLbvVnvpu5VIB3h6jVSxr7RfFJRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4585
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With setting sdio_wq_highpri=1 in module parameters, tasks submitted to
SDIO workqueue will put at the head of the queue and run immediately.
This parameter is for getting higher TX/RX throughput with SDIO bus.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  5 +++++
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  |  2 ++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 ++++++++++++++--------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index cda6bef..3cf0e74 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -71,6 +71,10 @@ static int brcmf_eap_restrict;
 module_param_named(eap_restrict, brcmf_eap_restrict, int, 0400);
 MODULE_PARM_DESC(eap_restrict, "Block non-802.1X frames until auth finished");
 
+static int brcmf_sdio_wq_highpri;
+module_param_named(sdio_wq_highpri, brcmf_sdio_wq_highpri, int, 0);
+MODULE_PARM_DESC(sdio_wq_highpri, "Set SDIO workqueue to high priority");
+
 #ifdef DEBUG
 /* always succeed brcmf_bus_started() */
 static int brcmf_ignore_probe_fail;
@@ -418,6 +422,7 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	settings->roamoff = !!brcmf_roamoff;
 	settings->iapp = !!brcmf_iapp_enable;
 	settings->eap_restrict = !!brcmf_eap_restrict;
+	settings->sdio_wq_highpri = !!brcmf_sdio_wq_highpri;
 #ifdef DEBUG
 	settings->ignore_probe_fail = !!brcmf_ignore_probe_fail;
 #endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 059f09c..0cb39b6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -38,6 +38,7 @@ extern struct brcmf_mp_global_t brcmf_mp_global;
  * @fcmode: FWS flow control.
  * @roamoff: Firmware roaming off?
  * @eap_restrict: Not allow data tx/rx until 802.1X auth succeeds
+ * @sdio_wq_highpri: Tasks submitted to SDIO workqueue will run immediately.
  * @ignore_probe_fail: Ignore probe failure.
  * @country_codes: If available, pointer to struct for translating country codes
  * @bus: Bus specific platform data. Only SDIO at the mmoment.
@@ -49,6 +50,7 @@ struct brcmf_mp_device {
 	bool		roamoff;
 	bool		iapp;
 	bool		eap_restrict;
+	bool		sdio_wq_highpri;
 	bool		ignore_probe_fail;
 	struct brcmfmac_pd_cc *country_codes;
 	const char	*board_type;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 3a08252..885e8bd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4342,9 +4342,21 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->txminmax = BRCMF_TXMINMAX;
 	bus->tx_seq = SDPCM_SEQ_WRAP - 1;
 
+	/* attempt to attach to the dongle */
+	if (!(brcmf_sdio_probe_attach(bus))) {
+		brcmf_err("brcmf_sdio_probe_attach failed\n");
+		goto fail;
+	}
+
 	/* single-threaded workqueue */
-	wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
-				     dev_name(&sdiodev->func1->dev));
+	if (sdiodev->settings->sdio_wq_highpri) {
+		wq = alloc_workqueue("brcmf_wq/%s",
+				     WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND,
+				     1, dev_name(&sdiodev->func1->dev));
+	} else {
+		wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
+					     dev_name(&sdiodev->func1->dev));
+	}
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
 		goto fail;
@@ -4353,12 +4365,6 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	INIT_WORK(&bus->datawork, brcmf_sdio_dataworker);
 	bus->brcmf_wq = wq;
 
-	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
-		brcmf_err("brcmf_sdio_probe_attach failed\n");
-		goto fail;
-	}
-
 	spin_lock_init(&bus->rxctl_lock);
 	spin_lock_init(&bus->txq_lock);
 	init_waitqueue_head(&bus->ctrl_wait);
-- 
2.1.0

