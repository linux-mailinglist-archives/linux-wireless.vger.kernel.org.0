Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D073A2039E3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgFVOtE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:49:04 -0400
Received: from mail-bn7nam10on2126.outbound.protection.outlook.com ([40.107.92.126]:55392
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728504AbgFVOtE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ+DI5R0oOrPSVWQ+E2E+vBSkGTff82dD98omVDITQNajMHdZdZk7CwYbX+Lh+3NHOwYc3Txj8aHEu5+oFyHZy8fUtIMB4EnB6aBW6PyKL6NwZ0/2M3YZ+QZpE3ShPimc0MSnPzkjST5MRmO2FuT/OyKNtGtpwQ5DPlUEMHMYen4eKep3ZoShyxnRCQbcRHiKzolQx1Pe+lA2hhb86NfistQJIQA4B1+XLCh+X6RyBjCQyaDumnR3SaxmJP/rDapMYTggIA14UsQ1HxaNzyZKKuC4LLSXINenaoh4LX7wNpvksi+Xh9deLokYc2cTSjTDTjd1LJLek6BPvTHipeYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG3kYYUgO+urhfTCApVweNoa/yDftF2HJbxrOC2KObM=;
 b=iDjuQNlXNSWc7zSD7s0bgskB2ybNrj4EDuOBwG+2BmEE8eRJ1UhDmSz+RhT02nYirzQ5czp+Ws9tzN1ix3cOYRJR5C07NF3W4m3FzJ0URas/o2COdKrbERyv9KXjOrLACJFGlcywHD2j6cCnysv5U6UbytxW53x29a4A8pLC2G7rblvpSxElIDSNM8aXTpUVoxAUAJkBpSLJLLKCPGUrxoWxDwbcn4PKUKH5oj6Son+YsZslFP4aBcQacm5v7N8M596IPzLKs9IKFSYZAwJRKoP5Z/zZ57yfVlE8bkMa03t1JKQ16BqZfyl5NwzYEF7CU3y4JCNFdAZR44bdv46Mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG3kYYUgO+urhfTCApVweNoa/yDftF2HJbxrOC2KObM=;
 b=clvLJkAsQfwZ9llGXrOXQ5XWhL+TJfpLhWXPJuO32PB8joGxa9chZw+Uf8sJ1TXMVmSjkxJNL208blz3cZLjLfC4LzWMGh576Fnkl4PVW7uU9GS9nymV0oIJJiY5WNIijnBiRvrlK0clsv1QXqXTM6JXRILXSjAGmVJN7+koxo0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BY5PR06MB6513.namprd06.prod.outlook.com (2603:10b6:a03:234::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 14:49:01 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 14:49:01 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH] brcmfmac: reset SDIO bus on a firmware crash
Date:   Mon, 22 Jun 2020 09:48:51 -0500
Message-Id: <20200622144851.165248-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 14:48:59 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95cb6e5a-b23b-486d-1f69-08d816bb666c
X-MS-TrafficTypeDiagnostic: BY5PR06MB6513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR06MB65137572246AEC94F5CC03D5BB970@BY5PR06MB6513.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4ACS4a2FEKlj6G4loB2+ZVt0E/Lbl9wGt4S85j7SplN9/8WIxYz3vZSqjsoreN4OffUzoakxsUsc0wk4P8TEzP4vm6W68LeBwo8FqKjBi/yfb5tv3aoi76yh6chRJMTt+gv4F+rWwdhAlTDD9qNP3SEFkWQoFiSTCQjdwofczVbCPzQ2FuNGMm/7w6sBozewmCNkkgcIAu6WWS+b09O4pz3jnVvoxqyYmwKquw+MlOCVD8OvGmpz8eFCIL9rCP2y+kTxW4piOuC/iV2VmuH+I5O5cMIPyLlaCTdJiq3SR7sinDRGLYyFq2+mJm3Et1g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(8936002)(2906002)(107886003)(478600001)(316002)(1076003)(4326008)(2616005)(16526019)(956004)(6666004)(26005)(186003)(5660300002)(6486002)(83380400001)(8676002)(66556008)(66476007)(66946007)(36756003)(86362001)(7696005)(52116002)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: s921I3zuerEzsO43iE8uNHDA5qXHviwoJIP8UvjKUOAp0AwuXmbojz1YtYuzgyh0glaAiXUcSzesjxhoYyrKBBN3+eD9a3dTVlZHssSZyqE1jhhfJwCevVXaVzTz+/82D1UMO8US85pjVvTYapKoIFEhcnk2+fi9PzX21u9xkbluPRDmwtOhRkN/ualwFAEuUD3kNIhiDx9ok2IjooaqzOVnk6CC0PyuEck/pqVUwybZRWR5hpgxKyvQjqY23B/gTvB9mSYt+LZ/JTZU8ZbM1Yb/xZpxPKOF3aDpSolfa+TBwdCzzADrh4pEBhUZVYI/IHTk2EKqs17shdh9BdJn0ZaTFLftaEjgh+2A8NAPgycuxW4oRpIQvSgwYKCbl39TodP5uq1UWadqcPxwnl8Ou3w7ExlrAfiRyU3MVfXOtkAxQy6vdCrZXXkGQ5oYEX1lrfwB8U3FlNRsgjlCmxfHz5F0iLqMh72rbaAcbukw7aZsAet5ZDAF75EMdWQ+caAs
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb6e5a-b23b-486d-1f69-08d816bb666c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 14:49:00.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8TsiGlOw6hITyZLt+yS+CFFeZvlUFjbEaBySLarrhqy6ZtIBdmGRk5tmHfmfRuEGoM1VM5Bar3mEseOFqk10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6513
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

commit 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
adds a reset function to recover firmware trap for PCIe bus. This commit
adds an implementation for SDIO bus.

Upon SDIO firmware trap, do below:
 - Remove the device
 - Reset hardware
 - Probe the device again

Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +--
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 34 ++++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/sdio.h        |  3 ++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 22a17ae09e94..15ac4636cae9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -862,7 +862,7 @@ static void brcmf_sdiod_freezer_detach(struct brcmf_sdio_dev *sdiodev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev)
+int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev)
 {
 	sdiodev->state = BRCMF_SDIOD_DOWN;
 	if (sdiodev->bus) {
@@ -897,7 +897,7 @@ static void brcmf_sdiod_host_fixup(struct mmc_host *host)
 	host->caps |= MMC_CAP_NONREMOVABLE;
 }
 
-static int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
+int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 {
 	int ret = 0;
 	unsigned int f2_blksz = SDIO_FUNC2_BLOCKSIZE;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ce6f15284277..f1f397fc3185 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/core.h>
 #include <linux/semaphore.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
@@ -4096,6 +4097,36 @@ int brcmf_sdio_get_fwname(struct device *dev, const char *ext, u8 *fw_name)
 	return 0;
 }
 
+static int brcmf_sdio_bus_reset(struct device *dev)
+{
+	int ret = 0;
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+
+	brcmf_dbg(SDIO, "Enter\n");
+
+	/* start by unregistering irqs */
+	brcmf_sdiod_intr_unregister(sdiodev);
+
+	brcmf_sdiod_remove(sdiodev);
+
+	/* reset the adapter */
+	sdio_claim_host(sdiodev->func1);
+	mmc_hw_reset(sdiodev->func1->card->host);
+	sdio_release_host(sdiodev->func1);
+
+	brcmf_bus_change_state(sdiodev->bus_if, BRCMF_BUS_DOWN);
+
+	ret = brcmf_sdiod_probe(sdiodev);
+	if (ret) {
+		brcmf_err("Failed to probe after sdio device reset: ret %d\n",
+			  ret);
+		brcmf_sdiod_remove(sdiodev);
+	}
+
+	return ret;
+}
+
 static const struct brcmf_bus_ops brcmf_sdio_bus_ops = {
 	.stop = brcmf_sdio_bus_stop,
 	.preinit = brcmf_sdio_bus_preinit,
@@ -4107,7 +4138,8 @@ static const struct brcmf_bus_ops brcmf_sdio_bus_ops = {
 	.get_ramsize = brcmf_sdio_bus_get_ramsize,
 	.get_memdump = brcmf_sdio_bus_get_memdump,
 	.get_fwname = brcmf_sdio_get_fwname,
-	.debugfs_create = brcmf_sdio_debugfs_create
+	.debugfs_create = brcmf_sdio_debugfs_create,
+	.reset = brcmf_sdio_bus_reset
 };
 
 #define BRCMF_SDIO_FW_CODE	0
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index 163fd664780a..12108927fb50 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -367,6 +367,9 @@ static inline void brcmf_sdiod_freezer_uncount(struct brcmf_sdio_dev *sdiodev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev);
+int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev);
+
 struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
 void brcmf_sdio_remove(struct brcmf_sdio *bus);
 void brcmf_sdio_isr(struct brcmf_sdio *bus);
-- 
2.25.0

