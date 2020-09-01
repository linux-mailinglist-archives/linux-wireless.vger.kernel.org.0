Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A705258845
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 08:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIAGdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 02:33:10 -0400
Received: from mail-bn8nam11on2136.outbound.protection.outlook.com ([40.107.236.136]:32243
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgIAGdJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 02:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rhs27fxYwBL5A5tYc/Xqffk9OPA0CxnkRkaLbSgJweunpTPxgZ4Ibz8FpCSSJOgMKpJVb7oJsKETDRiOL5LlXB1uFASlt6VzuQFt2cBdBH2IRDJuqN1YhFtfh2sM1i5Obuf1c2yTgs1U1dsF3ijtB5RlIb0K4Biqf5EM1fIL/tzWeqCS9byTPZH//sLDLrXcACwOBIlqXPrlmYt3l9t+T9T8sQmkb0BIbOrXvFxc6BFUvfzgnK60YuCPkATHXAetp4Bq5SByYR8OEGS3qxf3RkOdXXEYeQO2qgjcKksbTBqmBpUHeTnmYUyG8C0zkVquqNml2WCgpxlmn1fu5PyiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krM8iekJjyXH0Z22AFemtJNFgcGZkGTd91pUGGBaUnE=;
 b=VOvPdmjpwALZGyf5ECG/OUhPocpLM1mjJCxGUQnjN/hip1ZIExon7FzMOyfweNoebW+IwbZxL0MxWihnhXHO5u2eMZZHq3C/HAj4GdcURfNEBoG/A85gxHaxViqXUUKjlTlj6D/274Bd7RFJaNfxqX0dDCQBB01owlpHnI4CGSYi5SXHCmGuI9P8VPo/cyc07zR4aOZc7tXtoBAtMINxHTJ69Wk3Rt9UrKi9BL0/N5xhSvg3Bh9uZnbaLB4E+Y2zcoyWvjUzcs2DWQhTbUMTnF4eECvPzEI0xQefdSQ125EpD2iwXfzDWX1ucCQvPOw6GrX+2oUc2y33SDTVX2onWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krM8iekJjyXH0Z22AFemtJNFgcGZkGTd91pUGGBaUnE=;
 b=XudUduQoeaLCXuOFAdNFz5B457PVmoSLnCBukYh02Elhm9q/G548lpIpGjZ5ozBMYDPGr+OKfKJo2fDk9itSadbnueSm4b/qR/b8CadyDWttr4T73zsSHzeQ8gr4T9B+GYDiKRD5Ywnsu2ZWPvsyNC2xYUVCEepI90JZXoLfXVc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2867.namprd06.prod.outlook.com (2603:10b6:404:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 06:32:57 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 06:32:57 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>,
        Ting-Ying Li <tingying.li@cypress.com>
Subject: [PATCH 3/4] brcmfmac: support the forwarding packet
Date:   Tue,  1 Sep 2020 01:32:36 -0500
Message-Id: <20200901063237.15549-4-wright.feng@cypress.com>
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
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 06:32:56 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd0f08fc-e56a-4d4d-7c01-08d84e40dd3f
X-MS-TrafficTypeDiagnostic: BN6PR06MB2867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB2867C2485DDBD5346B562907FB2E0@BN6PR06MB2867.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7H0Ns1tPSADKnYXFkCWXntIdZ3LMk1GwKUH9d2JSojkS5xutNE8dw3nDlPV9KCEua+bR1igfPK+HZo36kKctsM7APXCuLo7JxDdCeHq/PrROw+qgEKfv1r+BjcrmpCe458xRtxYAhyCzoBXamGaGmWwH7C6nQopDT+ip4Ba+Ncll0pxKgMOPJKrbW4sj42uhBONpmUiRWZ2XsKoyVRjLIg1KGVT20ONGFzlMFAMPWCPI4bH3SiBnmfNETuc6GlKoeRjiikEtcCHGyumtrrOS0P0rhEh06O1+qrFfzaHLTPBShe45IQwnqu33IzhWBrhBukA/DHnGoiFPBIzJEU9m4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(54906003)(478600001)(5660300002)(66476007)(66946007)(52116002)(26005)(66556008)(107886003)(4326008)(6486002)(16576012)(316002)(186003)(36756003)(86362001)(1076003)(44832011)(6916009)(2906002)(6666004)(8676002)(8936002)(956004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tyCaB4qBBDQ040o9tDzRia3SYZkx1g50ToNcLCp7BUmmgHo+5u7i64HzMr3y/CvzrHM8OOirJwa2qko2fJsJdIk2j9GbcHj+L5vR8iEbNSNlmKbM7rMWOGk/Sd8OJzUsOB9y/7bIWS8AT5ITuG26SxcaQ5/2Le85LM9tgT1tjLCsJK35UCkNXq8GQ7Mmbpw+ZpSuOfHd8CtukQ0E/YhjCjoBp2d4qnqYf7Jc0D356TaPQ7qcfpcRBUijqf4lwgcgSfdh1aYaEfHd5PIMZ0EXxuIyhfc/dPp90RKsIML9PxwAXRsB32NIrDyKn7npF6G2qwHfmhQN9+v6sY1N7ILf4gH4pLKz7jAZWfzqFJiYaQcx7bSDDw2N5hXxM/WEwzpeVlVzwXkAkg0Nm+9kq7N8N2ZugAMh4wyNbiZ8VJbeYVX0JAEvo6q3/a2zKDF+aC0yoHpbjMxjcTlqPr27aoZwp5K2yLqOCC+jm1JhwxK+4RUZkWJhSQumCT+v+wC5kYJugWmth9pq9swmzNIyj/SJRWs0bfHIcRy94Ly7bRHNIO9NNz0QDZeCMb6RDiAYkXvWKqHZwM52E0cQAU7FQ4jKQsdVwh14ArDftfFvRMbmbSOZBJc9DkJsDK+9IhcF4pcXnqOH20eAD6tkEHyHogsM1w==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0f08fc-e56a-4d4d-7c01-08d84e40dd3f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 06:32:57.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jmiuvo4ZPzo4h8/bl0A+LvLn544p/ENKd+DSaM8zwg2Y0P5IuMzXSXsHk3YY/NMPE9bVuQTkSoyCa27wRIMkRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2867
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jia-Shyr Chuang <joseph.chuang@cypress.com>

Support packet forwarding mechanism for some special usages on PCIE,
and fix BE/VI priority issue when pumping iperf.

Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  13 ++-
 .../broadcom/brcm80211/brcmfmac/core.c        | 100 +++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/core.h        |  18 +++-
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  31 +++++-
 4 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index d6972420d426..8c7941f85715 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4799,7 +4799,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		err = -EINVAL;
 		goto exit;
 	}
-
+	ifp->isap = false;
 	/* Interface specific setup */
 	if (dev_role == NL80211_IFTYPE_AP) {
 		if ((brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MBSS)) && (!mbss))
@@ -4860,7 +4860,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 				 err);
 			goto exit;
 		}
-
+		ifp->isap = true;
 		brcmf_dbg(TRACE, "AP mode configuration complete\n");
 	} else if (dev_role == NL80211_IFTYPE_P2P_GO) {
 		err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
@@ -4892,6 +4892,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 			goto exit;
 		}
 
+		ifp->isap = true;
 		brcmf_dbg(TRACE, "GO mode configuration complete\n");
 	} else {
 		WARN_ON(1);
@@ -6045,6 +6046,14 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
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
index 20c510dca601..3257b784e019 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -62,6 +62,14 @@ struct wlc_d11rxhdr {
 	s8 rxpwr[4];
 } __packed;
 
+#define BRCMF_IF_STA_LIST_LOCK_INIT(ifp) spin_lock_init(&(ifp)->sta_list_lock)
+#define BRCMF_IF_STA_LIST_LOCK(ifp, flags) \
+	spin_lock_irqsave(&(ifp)->sta_list_lock, (flags))
+#define BRCMF_IF_STA_LIST_UNLOCK(ifp, flags) \
+	spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags))
+
+#define BRCMF_STA_NULL ((struct brcmf_sta *)NULL)
+
 char *brcmf_ifname(struct brcmf_if *ifp)
 {
 	if (!ifp)
@@ -899,7 +907,9 @@ struct brcmf_if *brcmf_add_if(struct brcmf_pub *drvr, s32 bsscfgidx, s32 ifidx,
 
 	init_waitqueue_head(&ifp->pend_8021x_wait);
 	spin_lock_init(&ifp->netif_stop_lock);
-
+	BRCMF_IF_STA_LIST_LOCK_INIT(ifp);
+	 /* Initialize STA info list */
+	INIT_LIST_HEAD(&ifp->sta_list);
 	if (mac_addr != NULL)
 		memcpy(ifp->mac_addr, mac_addr, ETH_ALEN);
 
@@ -1557,3 +1567,91 @@ void __exit brcmf_core_exit(void)
 #endif
 }
 
+/** Find STA with MAC address ea in an interface's STA list. */
+struct brcmf_sta *
+brcmf_find_sta(struct brcmf_if *ifp, const u8 *ea)
+{
+	struct brcmf_sta  *sta;
+	unsigned long flags;
+
+	BRCMF_IF_STA_LIST_LOCK(ifp, flags);
+	list_for_each_entry(sta, &ifp->sta_list, list) {
+		if (!memcmp(sta->ea.octet, ea, ETH_ALEN)) {
+			brcmf_dbg(INFO, "Found STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x into sta list\n",
+				  sta->ea.octet[0], sta->ea.octet[1],
+				  sta->ea.octet[2], sta->ea.octet[3],
+				  sta->ea.octet[4], sta->ea.octet[5]);
+			BRCMF_IF_STA_LIST_UNLOCK(ifp, flags);
+			return sta;
+		}
+	}
+	BRCMF_IF_STA_LIST_UNLOCK(ifp, flags);
+
+	return BRCMF_STA_NULL;
+}
+
+/** Add STA into the interface's STA list. */
+struct brcmf_sta *
+brcmf_add_sta(struct brcmf_if *ifp, const u8 *ea)
+{
+	struct brcmf_sta *sta;
+	unsigned long flags;
+
+	sta =  kzalloc(sizeof(*sta), GFP_KERNEL);
+	if (sta == BRCMF_STA_NULL) {
+		brcmf_err("Alloc failed\n");
+		return BRCMF_STA_NULL;
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
+	BRCMF_IF_STA_LIST_LOCK(ifp, flags);
+
+	list_add_tail(&sta->list, &ifp->sta_list);
+
+	BRCMF_IF_STA_LIST_UNLOCK(ifp, flags);
+	return sta;
+}
+
+/** Delete STA from the interface's STA list. */
+void
+brcmf_del_sta(struct brcmf_if *ifp, const u8 *ea)
+{
+	struct brcmf_sta *sta, *next;
+	unsigned long flags;
+
+	BRCMF_IF_STA_LIST_LOCK(ifp, flags);
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
+	BRCMF_IF_STA_LIST_UNLOCK(ifp, flags);
+}
+
+/** Add STA if it doesn't exist. Not reentrant. */
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
index 33b2ab3b54b0..3cf0b8c8d7b1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -185,6 +185,7 @@ struct brcmf_if {
 	struct brcmf_fws_mac_descriptor *fws_desc;
 	int ifidx;
 	s32 bsscfgidx;
+	bool isap;
 	u8 mac_addr[ETH_ALEN];
 	u8 netif_stop;
 	spinlock_t netif_stop_lock;
@@ -193,6 +194,19 @@ struct brcmf_if {
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
+/** Per STA params. A list of dhd_sta objects are managed in dhd_if */
+struct brcmf_sta {
+	void *ifp;             /* associated brcm_if */
+	struct ether_addr ea;   /* stations ethernet mac address */
+	struct list_head list;  /* link into brcmf_if::sta_list */
 };
 
 int brcmf_netdev_wait_pend8021x(struct brcmf_if *ifp);
@@ -215,5 +229,7 @@ int brcmf_net_mon_attach(struct brcmf_if *ifp);
 void brcmf_net_setcarrier(struct brcmf_if *ifp, bool on);
 int __init brcmf_core_init(void);
 void __exit brcmf_core_exit(void);
-
+void brcmf_del_sta(struct brcmf_if *ifp, const u8 *ea);
+struct brcmf_sta *brcmf_find_sta(struct brcmf_if *ifp, const u8 *ea);
+struct brcmf_sta *brcmf_findadd_sta(struct brcmf_if *ifp, const u8 *ea);
 #endif /* BRCMFMAC_CORE_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index f1a20db8daab..c53c3cf96f92 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1140,7 +1140,8 @@ brcmf_msgbuf_process_rx_complete(struct brcmf_msgbuf *msgbuf, void *buf)
 {
 	struct brcmf_pub *drvr = msgbuf->drvr;
 	struct msgbuf_rx_complete *rx_complete;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *cpskb = NULL;
+	struct ethhdr *eh;
 	u16 data_offset;
 	u16 buflen;
 	u16 flags;
@@ -1189,6 +1190,34 @@ brcmf_msgbuf_process_rx_complete(struct brcmf_msgbuf *msgbuf, void *buf)
 		return;
 	}
 
+	eh = (struct ethhdr *)(skb->data);
+	if (ifp->isap) {
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
 	brcmf_netif_rx(ifp, skb);
 }
-- 
2.25.0

