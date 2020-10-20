Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2965293317
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 04:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbgJTCaL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 22:30:11 -0400
Received: from mail-eopbgr750093.outbound.protection.outlook.com ([40.107.75.93]:23713
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390606AbgJTCaL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 22:30:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJqa/pnSlgHTmyPxZS9pG7CoX7q+TV1hB720shxdR7eVAWe/PAcXCybYI+Rc6qMORHzYOqKEpZ+/c4F7od9vZiJXlDYGv9PMfwLWCBgumRyulDkMBVFn+l+/FjUoMRpSUk7VQnCv1Y77iBHSIwNVV1mMGeTPF9+wCiYeqm8k5hpRBSsDDNizqxxH+InG+p8MWfZZGocobRe3G2SKqhOOcnPfMR8Z8NkAm38Sxnf6xqebjS6Y9sWBWV4gYH3HAQDbRs9woxXV7Xu3QX4uNb0LXuMSvog7hxuCchMjqTKqSQ9APqfporvKyO8r2OZzmmarUelJmuCiVD5DoIy55yjraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTsXrwW/NYTrBFtyya6O68hbSrBLAx9bJdVZNvE+IP8=;
 b=Zm4VGgOfey7ZUcCa2QQUZ3di7oO7CoPMz/Gf3UJxGEwQfp8CrRDAvXz3G8z4VWs9F7hZ4wmDmxlrv5QsrUP/3jrUyvicI04LYrTenb77lKCPQMi+t8ho8fDZgpNpcog5ile0J69ga5vuThCjnJyOsTGWUG5Cx335ZprOqFJdpBOs9BhG3pqyvx0KVGdypAWgHJ2QVSuwUn5U9mJG8sJRD3FLndow7x2eRRNbgAcY0vJDE7IJGxMzZM/SifyU4EcRp1aP9oPPd+DJb0D3yMkrEWqZt48/46IT+CJF7tJLUxJc86w1FNSXFh4q4x2Dk1B+XhDx6AWzaUXaSN/Eb+2huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTsXrwW/NYTrBFtyya6O68hbSrBLAx9bJdVZNvE+IP8=;
 b=oPqUH70o4RMMzqEC+2lQSJFURSiqLBURzFy2aEvysIEdgIl3e8Pgv0KHrLT5o//OVhszfxyM5CYqgMDj2EpRaztVzNefRrBO4gltGSM5AQJdS9RpjS31KMBWYDe3XZUK/STjoZFOlXajEcboRgB9duO89Emu4u7/XshCM0Kmxls=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3251.namprd06.prod.outlook.com (2603:10b6:405:3e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 20 Oct
 2020 02:30:01 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 02:30:01 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ting-Ying Li <tingying.li@cypress.com>
Subject: [PATCH v2 4/4] brcmfmac: add a variable for packet forwarding condition
Date:   Mon, 19 Oct 2020 21:28:12 -0500
Message-Id: <20201020022812.37064-5-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201020022812.37064-1-wright.feng@cypress.com>
References: <20201020022812.37064-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:208:1b4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 02:29:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 502b9895-f0b5-4c51-27d6-08d874a00b20
X-MS-TrafficTypeDiagnostic: BN6PR06MB3251:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB3251FE53758C70EEBDA3A4C5FB1F0@BN6PR06MB3251.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCaBPiy9fg9rYshnnpSuwWM+essvwE3za2u0k1RXv8sHETEkz41TPFFggxCdulVYzR6eNaMrLooRnt6VsSyf9VyJ8XPYy3VtEXSAEM4P/+zpYSmlNyESaLZeqEO1mMjYXecDeucXz+t80m8bQ6TcZm6h/4DH1lO152OeOYNuNKAVLdF5kKmkD/H4hO2d+dJ7UvciRj/sSqQ5mDNCFAqts06/O/vMIQImYHgEEmHMTUyjBFLF3X/ZyJ0J0/7qezf0MR2cVRC/NPdkZWHDQt175jkNlxHHOcC4IgKrwsVCNbi7hBV/iev85dbgNnCHMFU+AHEMrzk9bRDeSgF1uhbboQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(66556008)(66476007)(7696005)(52116002)(107886003)(6486002)(8676002)(186003)(16526019)(1076003)(316002)(44832011)(6666004)(478600001)(26005)(5660300002)(2906002)(86362001)(6636002)(54906003)(83380400001)(36756003)(8936002)(956004)(110136005)(2616005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3xsyAJpo4zaLAoQ++oJy5KrU05cpnFh6l9KZeTKG5eQeBmsaqmfAriyqLFTqqNe4qeYRRF+BLON5YmlrHAj4x9mTJ59FoMXNKP8vXkR+8OdKd+/QBMS7FICEvokNAVpp9IXtBelQmJ9FQA5GMcoLYlZKlmiz1uh2TiPbGHI1wy2XIJM6OxF+t8SHDPjBZvNzfPLmvMOPkxXBjJsib8yYOGIhytYXHFDyqoRfu3Iu2jpJSlXZXaXdRTbY6qsVR5E2XESrt7y26kevQ2ZCbNn5je+KT5lnZeYp03CjYwTsIDkIT28F4Bq5AjQTbHOwX0U+Va6dgu3n8VYlMK+aYY5ghzsbiHmLL/cldjpQwpGR2lbv16W6/Wa/g7jp6Pl+Afd7ph74XyZIcayFegVB8uQfyKcPLQ87RJ286Efq6MXPj6zPdYKCF7BMtFogW0isV+rt1VnAdWEPkc7+yFsXTYsBYF99GWLocxJukYhnvrh30CIubx+DLTIWGGawDy7fOr8J6gpXjFoFiob0wfJwkUg6K3LZmnzPpbAYBtiZgcZ0e4JKOWzV2/dL13rcWZgAFA93xaCjIKj1hxz+QNZsv1K+nEXqMUmfk25dJB69uq92s+NK98PNlBdiF5emvWsbS+d2A3Hw19PxWUnWb2zHH3h9eA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502b9895-f0b5-4c51-27d6-08d874a00b20
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 02:30:00.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhPoq0Q8tI+d8/8hg52ipKwuoijWpdS1ZjG4Dghu+276B4RNjFC59Hy9kj018mBgyBpfzzV03DvHKhK9UZdM/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3251
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ting-Ying Li <tingying.li@cypress.com>

When the "ap_isolate" function is not set by the host,
host-based packet forwarding will be enabled if the packet
forwarding mechanism is not offloaded to the lower layer.

Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
v4: Change conditional statements
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 +++++++++++++++--
 .../wireless/broadcom/brcm80211/brcmfmac/core.h |  1 +
 .../broadcom/brcm80211/brcmfmac/msgbuf.c        |  2 +-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5e49ac3d82b9..063cbb09d751 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5484,8 +5484,8 @@ brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
 			  struct bss_parameters *params)
 {
 	struct brcmf_if *ifp;
-	int ret = 0;
-	u32 ap_isolate;
+	int ret = 0, result = 0;
+	u32 ap_isolate, val;
 
 	brcmf_dbg(TRACE, "Enter\n");
 	ifp = netdev_priv(dev);
@@ -5496,6 +5496,19 @@ brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
 			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
 	}
 
+	/* Get ap_isolate value from firmware to detemine whether fmac */
+	/* driver enables packet forwarding. */
+	result = brcmf_fil_iovar_int_get(ifp, "ap_isolate", &val);
+	if (result == 0 &&
+	    params->ap_isolate == 0 &&
+	    val == 1) {
+		ifp->fmac_pkt_fwd_en = true;
+	} else {
+		if (result < 0)
+			brcmf_err("get ap_isolate iovar failed: result=%d\n", result);
+		ifp->fmac_pkt_fwd_en = false;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 9ebafe0b2117..30b29053d133 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -195,6 +195,7 @@ struct brcmf_if {
 	bool fwil_fwerr;
 	struct list_head sta_list;              /* sll of associated stations */
 	spinlock_t sta_list_lock;
+	bool fmac_pkt_fwd_en;
 };
 
 struct ether_addr {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index b98cf5e2d0a8..2d7e77097209 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1192,7 +1192,7 @@ brcmf_msgbuf_process_rx_complete(struct brcmf_msgbuf *msgbuf, void *buf)
 	}
 
 	eh = (struct ethhdr *)(skb->data);
-	if (brcmf_is_apmode(ifp->vif)) {
+	if (brcmf_is_apmode(ifp->vif) && ifp->fmac_pkt_fwd_en) {
 		skb_set_network_header(skb, sizeof(struct ethhdr));
 		skb->protocol = eh->h_proto;
 		skb->priority = cfg80211_classify8021d(skb, NULL);
-- 
2.25.0

