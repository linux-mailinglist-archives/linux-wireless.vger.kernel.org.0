Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3515C293313
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 04:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390598AbgJTC36 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 22:29:58 -0400
Received: from mail-eopbgr750098.outbound.protection.outlook.com ([40.107.75.98]:53075
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730463AbgJTC35 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 22:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKP+T/4pEEHYXX3kROsT+MQYFG/jU7I79Y82g5EVThS7S4SggTwsTnPTixxYHBYPPfFes52O83g/2QEQrKu/pca7kjgOD9OMbKnA2ExA8Bg7ClpNtCQjSGY5MvywDQEAgXXtQGdg7UtdxQEAGRWx0mUlQR2ebjh0SWi1peTCsNK1yfSBycYfEqZIRrhymxvn0POjtc3MXXbB5ZJr4kX6JdtP1n7qMb/pgWsG46ekLEM7UBOdxTzOXH2Qv/Hl1kCvSUggpHv7GJiu7GthgZpuwp0/mCQKcnMezkEFCLA3xPi5ucM6Yk03hw67Qb3abOfrO4LSlJ3b662OdDsSlBXgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1BBtAba9PZjemipg8kZygGw6Pm0+1dzcrra9YM5htU=;
 b=A6n0DAKea8THR0WI2TD6UQgnwgmczoWWZlMO70VMxK4WhwLiVmsO3kZp1lo1WDUSUP8Sh+eaHjX75CX8AjC9ECPPxQwW48eSwomBuJ62MKzCL57JvJBxgbRYJiDqxIw1QXLkJxmYJB0Yl64iwN0NGJF3e1YGD8yB11PJMfRM0lj4kfCsowE+sKKcV+7V/FCzQWadaWRKQcPVRUxpgOh95q9Bc5UbIRiyluEI2ZiJw+P0La5MwMxqdm03+79Ggfme2Ui/nhhu6ZiMpOvtuCDbziM0TsiCVi2mAlxs11xFqk706+y2ySR/2Vm0L16luDaRnAuywjqs77nfPu0+6ncWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1BBtAba9PZjemipg8kZygGw6Pm0+1dzcrra9YM5htU=;
 b=D+8xIijhyTqT0tnom7pOjKnYpR5tH/VJrEpGcqBN/t3LQ1Coyt23DbB6TZYaCSTOBA81aNhpCLBtES/epeqzjWj8JAycLjE3CnBZEKAmJ7rLGoKoSexXxI6C7dKCuyMGaAxtoR9vW/BtyTdw8axw336Wet65sfHlGdwz2xhhkpc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3251.namprd06.prod.outlook.com (2603:10b6:405:3e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 20 Oct
 2020 02:29:45 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 02:29:45 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>,
        Ting-Ying Li <tingying.li@cypress.com>
Subject: [PATCH v2 3/4] brcmfmac: support the forwarding packet
Date:   Mon, 19 Oct 2020 21:28:11 -0500
Message-Id: <20201020022812.37064-4-wright.feng@cypress.com>
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
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:208:1b4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 02:29:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54df91b1-59e2-44a3-3a56-08d874a001b7
X-MS-TrafficTypeDiagnostic: BN6PR06MB3251:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB3251669E4C7C30FC741A80D9FB1F0@BN6PR06MB3251.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsiJPe5Z0SMXeykEXHOz0gUinZbzwK3K8J9H6miCuUFNWh1BDJyO9UhU8l8E+Yl6qyI1b+cFTRQX2d1btkvsdPmAQLysn7zPysiN5MVeIiq5Xl/EGPqIVkFsa0MK8tIu9RPL1COGqTOOp5aJnri/7y3Si2bO9XLc1XvYaEEuM37wXwgOK556f3FEiL1ZK9c2xHsJQognAxi3EAg4+vgL5smwL7emjhTDEhg51Aa7L3mcAu+L4btx/K2lYZ+zYcx8HynVq8Q+89uQ7Ojr3h1gnejRcRe2m9uq2boepjPFNDGsKnXE1emOk/JzuvmGoYKSNuF+st8ixgNHKAAOrCQwoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(66556008)(66476007)(7696005)(52116002)(107886003)(6486002)(8676002)(186003)(16526019)(1076003)(316002)(44832011)(6666004)(478600001)(26005)(5660300002)(2906002)(86362001)(6636002)(54906003)(83380400001)(36756003)(8936002)(956004)(110136005)(2616005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: McKlRWz/OWsUraK76Gq4337hnXXdspc8EZtuiDa+c35e9rAIm8ur+p6PTQEW6pikXknlzfF0hP857/JRxCNyU9UFSc+jxmnkGiq4THV+SBM6IIzrc5xMlI+uvPOVdReXdUY05vihYTDHM55NowGC2FmT4MkdIjXEYxvZKI2L+TB+Haei2W8CxBFYGuiyI9BtZYMZpQahP6k0ItS0nR4vF+uau+RrzDsXgJ6e8FDHjTXKncTw2JVQuwovqKp0cSyo0AzbZkhCOmB2ZtwA8y5hPrznEftx2PmqGQB2tlE9nNT7kW4fEeo7VCGElf5ta6AKB3U8bhiGoCXltb3myXDmWrkZA0BiOPeQPkZUsh3zbIEz+ls4pakm64abxOlHEvH7GYrlGaaCo5Fi9UYFugp0IY9P47c9T1FOBvK662gdV3VwAEF1ryx5OMi4M6b2jkzboVV/wx3D2+pXwj8ZvjO6vv9hAUOs0O02fIo2hTj+wqmTGLkbWVnY1hkq3LxYkuyqbMXUblsYzEZ7akPN0V9JPnm83e6fzoZNdGbbTF7MhgxgIvZQrAocankVndKiq/EPlWVYdczv4qiPmSnpnewYSBVrU5wLXKbmm6vP4psZwgZWERZjRC4JsQfqhhpLmlbON4p01fj/OBI3D/WjYFQxhA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54df91b1-59e2-44a3-3a56-08d874a001b7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 02:29:44.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CGs8lRaOKrme6eXZE1mlGrd3OcSQOOXVwsucmHYsqWqWx0gu1sXL63XPvTN/v4gCfN/3MKjdi6Yn34gX86/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3251
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jia-Shyr Chuang <joseph.chuang@cypress.com>

Support packet forwarding mechanism for some special usages on PCIE,
and observed that packet only send BE when pumping iperf with VI.
we need to set priority before forwarding packet.

Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
v2: Fix sparse warning and remove the macro from the patch
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  12 +-
 .../broadcom/brcm80211/brcmfmac/core.c        | 112 +++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/core.h        |  17 ++-
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  31 ++++-
 4 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2f24222eb59c..5e49ac3d82b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -611,7 +611,7 @@ struct wireless_dev *brcmf_ap_add_vif(struct wiphy *wiphy, const char *name,
 	return ERR_PTR(err);
 }
 
-static bool brcmf_is_apmode(struct brcmf_cfg80211_vif *vif)
+bool brcmf_is_apmode(struct brcmf_cfg80211_vif *vif)
 {
 	enum nl80211_iftype iftype;
 
@@ -4812,7 +4812,6 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		err = -EINVAL;
 		goto exit;
 	}
-
 	/* Interface specific setup */
 	if (dev_role == NL80211_IFTYPE_AP) {
 		if ((brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MBSS)) && (!mbss))
@@ -4892,7 +4891,6 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 				 err);
 			goto exit;
 		}
-
 		brcmf_dbg(TRACE, "AP mode configuration complete\n");
 	} else if (dev_role == NL80211_IFTYPE_P2P_GO) {
 		err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
@@ -6086,6 +6084,14 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
 	}
 
 	if (brcmf_is_apmode(ifp->vif)) {
+		if (e->event_code == BRCMF_E_ASSOC_IND ||
+		    e->event_code == BRCMF_E_REASSOC_IND) {
+			brcmf_findadd_sta(ifp, e->addr);
+		} else if ((e->event_code == BRCMF_E_DISASSOC_IND) ||
+				(e->event_code == BRCMF_E_DEAUTH_IND) ||
+				(e->event_code == BRCMF_E_DEAUTH)) {
+			brcmf_del_sta(ifp, e->addr);
+		}
 		err = brcmf_notify_connect_status_ap(cfg, ndev, e, data);
 	} else if (brcmf_is_linkup(ifp->vif, e)) {
 		brcmf_dbg(CONN, "Linkup\n");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 043c9cbc6394..04c505482c5a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -903,7 +903,9 @@ struct brcmf_if *brcmf_add_if(struct brcmf_pub *drvr, s32 bsscfgidx, s32 ifidx,
 
 	init_waitqueue_head(&ifp->pend_8021x_wait);
 	spin_lock_init(&ifp->netif_stop_lock);
-
+	spin_lock_init(&(ifp)->sta_list_lock);
+	 /* Initialize STA info list */
+	INIT_LIST_HEAD(&ifp->sta_list);
 	if (mac_addr != NULL)
 		memcpy(ifp->mac_addr, mac_addr, ETH_ALEN);
 
@@ -1560,3 +1562,111 @@ void __exit brcmf_core_exit(void)
 #endif
 }
 
+/**
+ * brcmf_find_sta() - Find STA with MAC address ea in an interface's STA list
+ *
+ * @ifp: interface control information
+ * @ea:  mac address
+ */
+struct brcmf_sta *
+brcmf_find_sta(struct brcmf_if *ifp, const u8 *ea)
+{
+	struct brcmf_sta  *sta;
+	unsigned long flags;
+
+	spin_lock_irqsave(&(ifp)->sta_list_lock, (flags));
+	list_for_each_entry(sta, &ifp->sta_list, list) {
+		if (!memcmp(sta->ea.octet, ea, ETH_ALEN)) {
+			brcmf_dbg(INFO, "Found STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x into sta list\n",
+				  sta->ea.octet[0], sta->ea.octet[1],
+				  sta->ea.octet[2], sta->ea.octet[3],
+				  sta->ea.octet[4], sta->ea.octet[5]);
+			spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags));
+			return sta;
+		}
+	}
+	spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags));
+
+	return (struct brcmf_sta *)NULL;
+}
+
+/**
+ * brcmf_add_sta() - Add STA into the interface's STA list.
+ *
+ * @ifp: interface control information
+ * @ea:  mac address
+ */
+static struct brcmf_sta *
+brcmf_add_sta(struct brcmf_if *ifp, const u8 *ea)
+{
+	struct brcmf_sta *sta;
+	unsigned long flags;
+
+	sta =  kzalloc(sizeof(*sta), GFP_KERNEL);
+	if (sta == (struct brcmf_sta *)NULL) {
+		brcmf_err("Alloc failed\n");
+		return (struct brcmf_sta *)NULL;
+	}
+	memcpy(sta->ea.octet, ea, ETH_ALEN);
+	brcmf_dbg(INFO, "Add STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x into sta list\n",
+		  sta->ea.octet[0], sta->ea.octet[1],
+		  sta->ea.octet[2], sta->ea.octet[3],
+		  sta->ea.octet[4], sta->ea.octet[5]);
+
+	/* link the sta and the dhd interface */
+	sta->ifp = ifp;
+	INIT_LIST_HEAD(&sta->list);
+
+	spin_lock_irqsave(&(ifp)->sta_list_lock, (flags));
+
+	list_add_tail(&sta->list, &ifp->sta_list);
+
+	spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags));
+	return sta;
+}
+
+/**
+ * brcmf_del_sta() - Delete STA from the interface's STA list.
+ *
+ * @ifp: interface control information
+ * @ea:  mac address
+ */
+void
+brcmf_del_sta(struct brcmf_if *ifp, const u8 *ea)
+{
+	struct brcmf_sta *sta, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&(ifp)->sta_list_lock, (flags));
+	list_for_each_entry_safe(sta, next, &ifp->sta_list, list) {
+		if (!memcmp(sta->ea.octet, ea, ETH_ALEN)) {
+			brcmf_dbg(INFO, "del STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x from sta list\n",
+				  ea[0], ea[1], ea[2], ea[3],
+				  ea[4], ea[5]);
+			list_del(&sta->list);
+			kfree(sta);
+		}
+	}
+
+	spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags));
+}
+
+/**
+ * brcmf_findadd_sta() - Add STA if it doesn't exist. Not reentrant.
+ *
+ * @ifp: interface control information
+ * @ea:  mac address
+ */
+struct brcmf_sta*
+brcmf_findadd_sta(struct brcmf_if *ifp, const u8 *ea)
+{
+	struct brcmf_sta *sta = NULL;
+
+	sta = brcmf_find_sta(ifp, ea);
+
+	if (!sta) {
+		/* Add entry */
+		sta = brcmf_add_sta(ifp, ea);
+	}
+	return sta;
+}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 5767d665cee5..9ebafe0b2117 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -193,6 +193,18 @@ struct brcmf_if {
 	struct in6_addr ipv6_addr_tbl[NDOL_MAX_ENTRIES];
 	u8 ipv6addr_idx;
 	bool fwil_fwerr;
+	struct list_head sta_list;              /* sll of associated stations */
+	spinlock_t sta_list_lock;
+};
+
+struct ether_addr {
+	u8 octet[ETH_ALEN];
+};
+
+struct brcmf_sta {
+	void *ifp;             /* associated brcm_if */
+	struct ether_addr ea;   /* stations ethernet mac address */
+	struct list_head list;  /* link into brcmf_if::sta_list */
 };
 
 int brcmf_netdev_wait_pend8021x(struct brcmf_if *ifp);
@@ -215,5 +227,8 @@ int brcmf_net_mon_attach(struct brcmf_if *ifp);
 void brcmf_net_setcarrier(struct brcmf_if *ifp, bool on);
 int __init brcmf_core_init(void);
 void __exit brcmf_core_exit(void);
-
+void brcmf_del_sta(struct brcmf_if *ifp, const u8 *ea);
+struct brcmf_sta *brcmf_find_sta(struct brcmf_if *ifp, const u8 *ea);
+struct brcmf_sta *brcmf_findadd_sta(struct brcmf_if *ifp, const u8 *ea);
+bool brcmf_is_apmode(struct brcmf_cfg80211_vif *vif);
 #endif /* BRCMFMAC_CORE_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index 7c8e08ee8f0f..b98cf5e2d0a8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1141,7 +1141,8 @@ brcmf_msgbuf_process_rx_complete(struct brcmf_msgbuf *msgbuf, void *buf)
 {
 	struct brcmf_pub *drvr = msgbuf->drvr;
 	struct msgbuf_rx_complete *rx_complete;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *cpskb = NULL;
+	struct ethhdr *eh;
 	u16 data_offset;
 	u16 buflen;
 	u16 flags;
@@ -1190,6 +1191,34 @@ brcmf_msgbuf_process_rx_complete(struct brcmf_msgbuf *msgbuf, void *buf)
 		return;
 	}
 
+	eh = (struct ethhdr *)(skb->data);
+	if (brcmf_is_apmode(ifp->vif)) {
+		skb_set_network_header(skb, sizeof(struct ethhdr));
+		skb->protocol = eh->h_proto;
+		skb->priority = cfg80211_classify8021d(skb, NULL);
+		if (is_unicast_ether_addr(eh->h_dest)) {
+			if (brcmf_find_sta(ifp, eh->h_dest)) {
+				 /* determine the priority */
+				if (skb->priority == 0 || skb->priority > 7) {
+					skb->priority =
+						cfg80211_classify8021d(skb,
+								       NULL);
+				}
+				brcmf_proto_tx_queue_data(ifp->drvr,
+							  ifp->ifidx, skb);
+				return;
+			}
+		} else {
+			cpskb = pskb_copy(skb, GFP_ATOMIC);
+			if (cpskb) {
+				brcmf_proto_tx_queue_data(ifp->drvr,
+							  ifp->ifidx,
+							  cpskb);
+			} else {
+				brcmf_err("Unable to do skb copy\n");
+			}
+		}
+	}
 	skb->protocol = eth_type_trans(skb, ifp->ndev);
 	brcmf_netif_rx(ifp, skb, false);
 }
-- 
2.25.0

