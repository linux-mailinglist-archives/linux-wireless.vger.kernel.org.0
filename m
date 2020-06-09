Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA091F38DC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFIK7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:59:38 -0400
Received: from mail-dm6nam10on2129.outbound.protection.outlook.com ([40.107.93.129]:26720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbgFIK7h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3++X2PSkjZEmXakfX2lnTFgxKX1dphOXaC6XzpmA8wy3ghmWHTLv95Zj45kb2fwn73NztfXdQVRtytbUQtNhIqId2BJuvgd8M0c7wegY/O4mcv9th0ERuUd/Atvzq9SQuuBqX9KrynGZL3+wS19D3GGp0DfhNdOLXO5dSqsIHy7K7y5I0iunnxrOUfDUAfNnHiEG1o8QE+rz0wgk5ABDwNV3Ra6Y8EsQAxVrx1nhVMOldYHybPmGrf6Q0yWlmGu6z8d5AwjypHGhQdlIt5ZJdOsRxIEz/c2qq+wVW9Vebpca0bEoY7tMyHwaFWQIdgCpXFBlG6QvApMupXzNeMjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8lxT92krDgpNqty38l6O5QguIUYJoY405Qj7PQ/Wh8=;
 b=S30pOrHtHAIirkjNqjTqtl+YhlVkp5F3qPMc1EBFdq7w4EhGxHow49+Le0U7VsYgQ2aL5wYCaAXscwc4Br27sOd9KcpI5ezT0g4hYbt9fuJg17Z28/1Wur9wrmj3xq+dDi/RoiSLw7+ot3bCpj6FZWJPbK421/0uYrPNQmCCYwkR6BRYtfwIwfVqUi/e1khjWSWRFSe6H8qOmFOn0qu8O+Rg6j89XfC3+CI7RqvSG6U9cOyq8gbLWdJ7PzudzwAlrutcjFtTXhg/5Sd6Jxv1ISNCKVsKjzLW9lFlTqTClS2lDeAOxK+U7KkmTL7IB7Mx6SBZbBrRo4yzeQfl7y0Mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8lxT92krDgpNqty38l6O5QguIUYJoY405Qj7PQ/Wh8=;
 b=hQCBMI/4Tk9oe49/N15QvWVNwG1BGNg15BX68hXyW4RjZUTngHda5MamjlyWLFmz/mpYFyYaaDDqI4o51Xa1K2I2Jug23LEJ3mc9qgKTYa8vr0rrQoX0zvcrU7U58FtmAMv2YHxy6fzLmxn/Zj3huL1D5nIdi8/4qDaxTRdPVIA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5064.namprd06.prod.outlook.com (2603:10b6:a03:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:59:30 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Tue, 9 Jun 2020
 10:59:30 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <saint.chuang@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 3/6] brcmfmac: reserve 2 credits for host tx control path
Date:   Tue,  9 Jun 2020 05:59:10 -0500
Message-Id: <20200609105913.163239-4-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
References: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:59:27 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aba03b57-f4f2-4c6f-0c78-08d80c642ea7
X-MS-TrafficTypeDiagnostic: BYAPR06MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB506440791B58F4B9891F1B1DBB820@BYAPR06MB5064.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFCTAmliTyEF6IMPDfOo1wS/QmZfQ4u5IAoAqPGnYqMzjaHluA23XOJHwSebIqeifxI69SWsHN7vh/6zl628ut9nhiR4kYCzpxsz8md7hPxl76vfHXPAPioru9QBmKR6k9Qe9cEptUKv02gmEsMBizqbuDWsrLO+j2aMClyWVPno72ejVGC2wh29Zj4nO6ehKo4XEI9qnaixUohVMRhESlCGNW6OaO+DP1k0fLMnPIyTQh+ybMhbrLNo5z+gZQoder21joCusEutbQfDa/7uJrC9VD1QowwCIWQECzM1In6uKsa6Qux+ASQCJaK+47Uh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(36756003)(316002)(2616005)(52116002)(66946007)(8936002)(956004)(83380400001)(16526019)(4326008)(2906002)(186003)(5660300002)(6916009)(7696005)(8676002)(66556008)(107886003)(478600001)(1076003)(26005)(86362001)(6486002)(54906003)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: j7LmCslkGZv8yKdXiYOZNBv+IiyfIUPfBUiJv+OyDG2FZKEnEcYBU+rX16S81ad3VNxQyMIRtQtvQA+y4zHdJpyezl3JSAz9SIzpm7+n6tRtYbCJbbFhDARG9ENgtX4Daa6/Lze1ctevJ062uN9TiF+kh/Z3zySuHw/gfIj+y8O/sVDGXAKTRuBvhOLqP0geKKEm6rrn7y3gHUJXLC4PDU39srvq7tOHaVSuWhvgf/aeppmbZWQA0mMOZobd1UNxIv3ObXPaSK08kwLBYZSKMTCGPPv8HZiKOYyvDbLC/LG2dK/FOspZlp1cJL7KhfyQDQY5BFBAjplnOlm7IhCV6lbz8VK4GJOD7/0fOR3N3FLuzAYjWdmgC3u8Fj0QYcXaNgZwUvqVj9s7+1tnkRAuQRANjUZGKe/6Dazcxpl4YAF9nmAzKanng9rMckIh+5neEyDJ3dCDn4KPICR+FZv7Z4J39Oa+dKH9TL7RS4u+nCaLi4vLgQVpI5RIGmbQ2/Ay
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba03b57-f4f2-4c6f-0c78-08d80c642ea7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:59:30.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5cymjAyeFcUteflDIP3ZxiSJKtFsJXzOxRaVVgzJt1dUXlPv4FfCOWoTk+o2RIRLK1h9QgQ2CTrCPHQIALBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5064
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
Signed-off-by: Jia-Shyr Chuang <saint.chuang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ce6f15284277..163bb7f41e44 100644
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
@@ -647,6 +649,14 @@ static void pkt_align(struct sk_buff *p, int len, int align)
 
 /* To check if there's window offered */
 static bool data_ok(struct brcmf_sdio *bus)
+{
+	/* Reserve TXCTL_CREDITS credits for txctl */
+	return (u8)(bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
+	       ((u8)(bus->tx_max - bus->tx_seq) & 0x80) == 0;
+}
+
+/* To check if there's window offered */
+static bool txctl_ok(struct brcmf_sdio *bus)
 {
 	return (u8)(bus->tx_max - bus->tx_seq) != 0 &&
 	       ((u8)(bus->tx_max - bus->tx_seq) & 0x80) == 0;
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

