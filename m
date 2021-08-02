Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8953DDE37
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHBRJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 13:09:40 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:56918
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229737AbhHBRJj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 13:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2MZRT23MS+DoQyNHBgSk6KSUmvLdCJgpFdChWOjN/b3HcYPYgWBBhFb69rIJQzx3nk1iyPOmJ8+ytETwrEUv4KYqZcMfIk4x0fkQwTOii5MKwkSylJ5YpDW6ZhLuOOfIKT9ge5UbKuzgRPCC4A7uc6+n+7EDiFz+AwU30HcFRNCs96K6RgR0cKq6BW48p9cHwlqpfyacsgJDRfOkWJWjpBuK1gGxpVjmZBJV5vPT2GdmnB5uiPKuFhoiTVG7DW/L1Msjzgewka733HpS/HFVqGGdZ0qx855AT8kHq+GKdd1UA2bcJv7O4M93wAIJg8I5kl2Fyyxm0e/5/JL1/Aiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV9KL1vUqpxcAn86G8OlVgIPtly9V88/PnCNhXLvksE=;
 b=oMyo/SELO6UZHU9iFv88+bILUq1ogDPXChTwlJMkqJTfTNYhWxJcigGOTrpP+zH70/ol2ECvQEhiss/CD4yEekm6wk9xP+y2wLT9plpqim7j1iZF62l6d79FxnENJsKSZhURWYBMRWV1CzbTAVfPy2V7ghp+9w7IRDCx7F+PlXmDXFxxiUBMokQyDTapOEVeO9k0ytnmkMKQcge0Xl/rqvUjEKX7A4C6rLxnpVbngBan2qSvRfah/sxkcWHyp1ZpxQuz9bY6ie1sQdwHMIe0q8ULhv01MStKNOOFb0dTjBUHw0b/vYvml4AORKqm8Tx7GgDdGhQS96cM8/VlmLK2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV9KL1vUqpxcAn86G8OlVgIPtly9V88/PnCNhXLvksE=;
 b=ug2D0DyEdR2a8btLHPqg0GNE5cHQwOEz8ElfNgbpgaH/WrHQ2Lh/R7K2/Gatnrxi2sIr1mjDqVWJaod2Dvon8wCm2eawWdmKBZGbt5Ju5/w9gLPvtQpP4oIAFLY5pGh5EytF161l5xDB3he2vAlu6/iHLdXCVmhXNJ6xKEN/mRc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5579.eurprd03.prod.outlook.com (2603:10a6:10:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Mon, 2 Aug
 2021 17:09:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 17:09:26 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Tejun Heo <tj@kernel.org>, SHA-cyfmac-dev-list@infineon.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
Date:   Mon,  2 Aug 2021 13:09:04 -0400
Message-Id: <20210802170904.3116223-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::16) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:208:1a0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 17:09:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a869fce-3d36-49fe-b31e-08d955d8480d
X-MS-TrafficTypeDiagnostic: DB8PR03MB5579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB5579345E12EDFC0176D4F88596EF9@DB8PR03MB5579.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Bv7NI7jZBRqO1bKessG5DrSr13Kxdo9ynvuwK1naRwlpDajCae405SnL28n9Ozu1DoP1joD32o/SZHfv6RQJGAVVRg016Fphoit7/kX5QDwwaCZqrO3YBtWBq0fjXlJxIHm92Ymv6wJdUFyyfwQOGKNAEWG8D4ZFK2qyfkB/zM2rKc9wDkkmFx9AvWOCKc1YxAbWolivOCHFcHrBtg5BmOF4sVXTBqN7Ged56s08h3KaiSAQiN9y4G5vbzq5rEeuEayqVysBnLguE97I4T0FVLfY/7nTO5j5dEzyK5yImjMiFvnTc/V5J69VBvAaI6o4IaSp3rHq64LHBTdkf93ZDmYBytmEbWJwUoRfAWVvnDH9+I2Ge1NDJ347WodxY9dV8IZC0zHhSMPZDu8UDAq9sN1p4w7nTAU6ConEZWKEZ7Eencu/K7QO1iLu0DQPad95OORKwWlXCHB8dQjd8e+U8TTW/KVEHFHxWp/Xpo0Jx4T/6AfgOxVBqYPpfnBYVbb1v3xBk114Pu3V3DgmcQ608tG0hkd7c3SaYKNG54BcdCJCnm4Cjnx1MjPpNvpqPGbfatRkOCplzhuqziQfSkhj1Jc8/x/Pqi2QQUjKFBt4TldyeFfJkTSCuVmKc8LSIABm4W1nVhoufmlup91Z7Unp35MrzFyyhkHmZGN/f0h2XfCknzNJJSqxP4RsXEA5FKO/s1dYupwjzJCzuP2YB+f8IVGI/lr1nfw/5pcadHEwRvbBnHjZ6mkbcpnAdZoG8lTtFdO+5WKnz3ffJPcduxG9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(39830400003)(396003)(26005)(83380400001)(107886003)(186003)(1076003)(966005)(86362001)(478600001)(6512007)(4326008)(52116002)(2906002)(54906003)(44832011)(38350700002)(38100700002)(6666004)(66946007)(7416002)(66476007)(8936002)(956004)(66556008)(8676002)(5660300002)(2616005)(6506007)(6486002)(6916009)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3mhkGUiDMdf6+814YdXbNwGK3KkrBJR9J7WFYj5g+sOx3JMLwbw9Sl17WfLU?=
 =?us-ascii?Q?/2piK2DhU/art8jg7HlPQ4yWGKiEkbdArePUOtAhmGOHRCThstnZMcOWOARn?=
 =?us-ascii?Q?9NEBSDdsf5Z7bLFGopiOdXUPTgaeFlblBoSampuQ3L0LT/Lt55gpll6E1Op6?=
 =?us-ascii?Q?INn1dnZDuvhGRpdK3YvD3v/xqIl6Mow5KVlAtoAZgJyahgshu5/i9o74k0FY?=
 =?us-ascii?Q?sd43SbgG0hCxA2n1lVHyXSI8+CmXg6MWmndAa3dBJTGjRsogMo2UKucfQ+Wj?=
 =?us-ascii?Q?92vznUj4/mFzqHicVNVzZ/8N73s1VKsuStI5lIckdbLQvmv/k8oVGxTiNuZZ?=
 =?us-ascii?Q?wRDlX0lbhWV68XHz7SiW2Q8pJ7t+Fw9XPmFL47CuG+rFp80Pnnzx3k+2Iuya?=
 =?us-ascii?Q?BXwyWPkDgOrSD1831uoW8hoQ3QV84eSnMwHd7gXrvHZS38ldS4veBYlWvm9H?=
 =?us-ascii?Q?RoFDndkxqg5CWxiqCOE3MSGfFL4ZYobTL80Dvgf9hWl+hukj9wx0fzppAvzT?=
 =?us-ascii?Q?av1j3thdWGSIBocJQpvoNoMf86B93P5wsUwCx25s3nRI0vVMNq+99/WQYPCx?=
 =?us-ascii?Q?1jfF/FtA3iwGla4dpFx9DpVmsKG946HQ7hh0TzjdBb2RLccftRyQhcuufdzk?=
 =?us-ascii?Q?pDwsai9N43X/wzzrjwe1dMzQU2RkbXXVfTqdJhyqa/NirkUAVhDhjoGdWcur?=
 =?us-ascii?Q?6WRNfBKZ0dTAJd4UnHkstHXgR9eaKmsh+0YZpCrc4dqIczRJsJ1WrzF6PXAo?=
 =?us-ascii?Q?650PvSEJKxNe7/xUn/pIBDLIA9kAPZ90ZkZ4IiqMxMXt38auPs6h8KPqpJaX?=
 =?us-ascii?Q?R7GuKELbGIc6D9dRcdqjq2aJ51ONtuCvUIhE/dFYARimwby8PHra7RwpgJdl?=
 =?us-ascii?Q?DRyBPngQlhwU0ub4AekB7HociXisq5cLMD/vre7JERFv0hYso6SXA5gLs+2u?=
 =?us-ascii?Q?8BoaCvBxyIY7qYjNfiZXAI11CJpEtyXtp/LwYIBU5CuXruQAimwsOeUeFFZm?=
 =?us-ascii?Q?4ABirpcwhbc605b6GaBjF6ApHMN7QCExTiHWxvLFZC4poIrIh8UJazgMZRBv?=
 =?us-ascii?Q?Vq9axbWDviTZ/0SwePDGES9ClrIVXjkcS7KlWqGSlnkdyKDDzBAAylNMPgX8?=
 =?us-ascii?Q?zUF4CcOrYebB9eQ+wuxnr0vwHwZsStYxP6NYoefV5UF3XLqQOTb+VrEjBKm7?=
 =?us-ascii?Q?bJWgnRIiLpMP73qCai8wzRSueNloG4VYLsDqeA4U4QorB1k3kD4cVAQ3BLTD?=
 =?us-ascii?Q?xQCkDg0VCZqxVFcWF7DD/EQQ15CiXwOWgn1ApciLpgbDmPvgM/bRTmM2SESs?=
 =?us-ascii?Q?i04K4Ee0FifyKJfQWzLTEmWs?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a869fce-3d36-49fe-b31e-08d955d8480d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 17:09:26.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8B8NQEFfiliHa9lwkHb15h1jtm9YNEeNiiJbX8e304y5/7Uou+wRrn1EyNTdLolZYVyFxfdqL8fLzEzVGXJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5579
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This puts tasks submitted to the SDIO workqueue at the head of the queue
and runs them immediately. This gets higher RX throughput with the SDIO
bus.

This was originally submitted as [1]. The original author Wright Feng
reports

> throughput result with 43455(11ac) on 1 core 1.6 Ghz platform is
>     Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
>     With    WQ_HIGHPRI TX/RX: 293/321 (mbps)

I tested this with a 43364(11bgn) on a 1 core 800 MHz platform and got
    Without WQ_HIGHPRI TX/RX: 16/19 (Mbits/sec)
    With    WQ_HIGHPRI TX/RX: 24/20 (MBits/sec)

[1] https://lore.kernel.org/linux-wireless/1584604406-15452-4-git-send-email-wright.feng@cypress.com/

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 97ee9e2e2e35..5e10176c6c7e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4442,7 +4442,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->tx_seq = SDPCM_SEQ_WRAP - 1;
 
 	/* single-threaded workqueue */
-	wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
+	wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
-- 
2.25.1

