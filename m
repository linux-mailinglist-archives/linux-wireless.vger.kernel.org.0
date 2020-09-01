Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8B258843
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 08:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIAGdG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 02:33:06 -0400
Received: from mail-eopbgr770138.outbound.protection.outlook.com ([40.107.77.138]:31540
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgIAGdF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 02:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ1s6zCdkkMRattZmIgNbthBZ5JQBk+JAvoTL3VqIdJpYutxohzf5uLLgUkfIK6hWL8lyFhOVGV3W2kFPkkwaRrzLeoPcvTDqNLOpeIMS/IaP4DHHh8PEEGTTDDWt+yHicO8QK5jUVyr5cZy2RrzDzLwUCvzhVxfeZeVKNyODXIceYj1VDh7m3mcTXe14iUuxzYfDYC1lC8azn3FDTgkHjyEIEsbnM+uOnE4yWuDMKD02puiNf46Tfk1g01Yfr39hq3sbz5upqlIe4hzwh0cu3NhDVEG7F42HLKHjoLemE/79IwzYU5o0QtXnaJm02OOaIQRd9c1/DbCJbCtFZ3FWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElzIp0heVVNd7qk4UbjQ2bmDUtDQerDq+LKT/4y23Qc=;
 b=E6BBi5klMvqWFrKtOnPy4inGU4d9M6kk+qqwAwhubQCvu4bPKYvUulNYGHnmfjtFBTaqHNKhpjyegRBOItSVmJj9paIoKz26k0T6l1eqGQPTP2wZlr3zvSLH53qalO76eYrfWc5VMmMjJzzJAU5T9MAHkJTQJs55J8bNbhJScGY91Oj/JLPqDb7U9uBD9nPP/UMDpNtru3sHktjHTbRouPPGBornTrKNVOgw9mNH5SkLCvucO9DUsbKBT4ZldfKH67i476kqSPKi4IFy7p6s0flbHXukXAzJBL/KQWVJu1WfCLnX31jgFPFHbT2o8vpSm7REFfRHAQT7t+bVv+InkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElzIp0heVVNd7qk4UbjQ2bmDUtDQerDq+LKT/4y23Qc=;
 b=PsDsZbDB8/XUfSElEWK9ClQsBbIcdAj158OtBLUyCbcNqwPxWMaGIvMJiqoM7Gpj1495/MNUvnCI3DZ+D8L08M4RE5/pru1liNNlmtEqwRdeUyuaCHXLQpbmwdqEh2o4DNG6buadUg/QweIyvw4gm5dZd2jvyob7rluYirgLRNM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3155.namprd06.prod.outlook.com (2603:10b6:405:3d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 06:33:01 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 06:33:00 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Ting-Ying Li <tingying.li@cypress.com>
Subject: [PATCH 4/4] brcmfmac: add a variable for packet forwarding condition
Date:   Tue,  1 Sep 2020 01:32:37 -0500
Message-Id: <20200901063237.15549-5-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200901063237.15549-1-wright.feng@cypress.com>
References: <20200901063237.15549-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 06:32:59 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c738bc93-ac5c-4fb8-89db-08d84e40df3c
X-MS-TrafficTypeDiagnostic: BN6PR06MB3155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB31552C57FFD97617EA1054F9FB2E0@BN6PR06MB3155.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHp4l/cgyOR7nx5mFd7bGVbOQmNMAwOMoM7n1VG1jtAkjfj8933LKynv4Y9RDhdauR9d7h+cc7OdIhuLOODmlG+M0WyPbtURiJ/W7uPY43EjzOaki7M0L+zhoQ5GorN4UQUy5k4ySR00kDQxBH5zySODshLECLBsRnQtVjTM6dzaaUHShXISIlGPkROBtqVFF0LqB0WuugIa1rLEg2n4Aop1RQONu4+Gp3KyVv5NFYakv5d4pSBHRNl9U/AVHMvvZlA1KZml8vy7RyxvcchtT4ThtMBut6YqxdFraT3nca9v0Pgz6UsvOPJ1oxfk3AQs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(956004)(26005)(6916009)(52116002)(66946007)(5660300002)(36756003)(6666004)(54906003)(4326008)(86362001)(316002)(16576012)(2906002)(66556008)(44832011)(83380400001)(2616005)(66476007)(107886003)(1076003)(8936002)(6486002)(478600001)(186003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: na6Psu6RdzJj+MmPZ3GtG2dn/4rp3Bink16v3Fvv541YshTWyf2S9TUYbtJFZfxweGtOgsqsVzZHdmaHuFzG5cxcTCPWiMpGnuJ9r4ica/U0z6Y1U9RtjwLwZ+HDqXr6OeWjtgmURfjYVUHlaMP0MQZPmmWem9XmxQ3RSiZfyWURZDrjOfsGfPsVNx6ZVAFsXx+ymfY7Y4y+DWicQA97wLfm0LvPuBcaY0wlEWFKvk/E8VyDzEjqpTaD4nPYeK7yvY1ZooEdkYjFl+OKRcxHT116oFRYXc16ud57VRsE7RcuVKqfb8boFUv7oDvEjSUte/0TmmOBi2YyN3U1xCipcTRmvb6ZsHfy3KTw4oPHJ/vPw7dW6bxuCsqCejhLHP1HOamc10Nj3gAudoZzveeY3z9BpW/qooNRNCVtiCPw6YziHpIh2CkvOqbwKfP2QF7/3nnZmL1S5bsLkB/OILZYcUMldWR5Or7EEyVNrbT1/Vfq6sH4wCOcJwl3TbCieJhkaSFG1nKCPIxLEp43Aanuir1we831gbsL3GsmX7oEM+8WGt7HqzoFNXMEN0onG1NsmgF1zo78G4bhhnIFUSploO6a/rSMedtbQezDHtX9A/VdAx7lrvBaMIuRVbMehdlXnTjJYrNN+0BrcDFzbcquew==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c738bc93-ac5c-4fb8-89db-08d84e40df3c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 06:33:00.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzoA457NeEA7RnP8LYfZvnSYgW6CeIZ8I6tKQvWg0wHszHIj14R7/Xl/72iYv1a0A0A8hT9uAkZuexZB1HhV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3155
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ting-Ying Li <tingying.li@cypress.com>

When the "ap_isolate" function is not set by the host,
host-based packet forwarding will be enabled if the packet
forwarding mechanism is not offloaded to the lower layer.

Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 ++++++++++++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/core.h |  1 +
 .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c   |  4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 8c7941f85715..ac0095989e43 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5447,7 +5447,7 @@ brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct brcmf_if *ifp;
 	int ret = 0;
-	u32 ap_isolate;
+	u32 ap_isolate, val;
 
 	brcmf_dbg(TRACE, "Enter\n");
 	ifp = netdev_priv(dev);
@@ -5458,6 +5458,17 @@ brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
 			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
 	}
 
+	/* Get ap_isolate value from firmware to detemine whether fmac */
+	/* driver supports packet forwarding. */
+	if (brcmf_fil_iovar_int_get(ifp, "ap_isolate", &val) == 0) {
+		ifp->fmac_pkt_fwd_en =
+			((params->ap_isolate == 0) && (val == 1)) ?
+			true : false;
+	} else {
+		brcmf_err("get ap_isolate iovar failed: ret=%d\n", ret);
+		ifp->fmac_pkt_fwd_en = false;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 3cf0b8c8d7b1..d5745f48e003 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -196,6 +196,7 @@ struct brcmf_if {
 	bool fwil_fwerr;
 	struct list_head sta_list;              /* sll of associated stations */
 	spinlock_t sta_list_lock;
+	bool fmac_pkt_fwd_en;
 };
 
 struct ether_addr {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index c53c3cf96f92..1c109257aefc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1190,8 +1190,8 @@ brcmf_msgbuf_process_rx_complete(struct brcmf_msgbuf *msgbuf, void *buf)
 		return;
 	}
 
-	eh = (struct ethhdr *)(skb->data);
-	if (ifp->isap) {
+	if (ifp->isap && ifp->fmac_pkt_fwd_en) {
+		eh = (struct ethhdr *)(skb->data);
 		skb_set_network_header(skb, sizeof(struct ethhdr));
 		skb->protocol = eh->h_proto;
 		skb->priority = cfg80211_classify8021d(skb, NULL);
-- 
2.25.0

