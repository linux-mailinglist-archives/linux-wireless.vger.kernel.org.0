Return-Path: <linux-wireless+bounces-30770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77BD1B3C9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C30C30057CF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B052C21C2;
	Tue, 13 Jan 2026 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="OP14Cw/t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFD276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336672; cv=none; b=iVQpe0pRIboQGEk385czCtqxkmqntGKaynvr3WsNDp47jhJsTIf7NN9D7FmU0NChU+uaQmVdzWYSyRedOW//i14A98RuQmG1NVloez+l3voQcwY1Tf6HTi/eiEH6xEb0gS1K2hqzJ2UgThkd4SlHYAnK0DKk6FOJsRnD4xT/Yy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336672; c=relaxed/simple;
	bh=qv5nnSzdelyNOuiETE1tHAbYQABuc5n/rJyMC9qTbyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Po2bbcD4Jy935ssrLCBXXf7BCotMkCl+BWDafSReNN2nJHv8/1D633S2XFMPuviXJ9moNig4kcgvKY+64i1F5SXYrvr4LcF/A8Hgs9Z6AMwsve/hs18IuR5hm4YgaLMPa0SJzgJQMGG2ZtzIVn3A5gpk7yCVpZxcK1GPlL5m9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=OP14Cw/t; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336670; x=1799872670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qv5nnSzdelyNOuiETE1tHAbYQABuc5n/rJyMC9qTbyM=;
  b=OP14Cw/t5jhRHOKtxlvKbpL7fgfdLPIfFt/NI50u44O4kHE+D0g2QdDy
   k9UDakapizGlgP6GdCBdfw63zaFeJ8B3lkAkXlYEWbgD0o0sFuQalG93Z
   yQWku02lCnCkPZN4cT2lxH9txliSt7vyyzKEgKm/iYtz/IdXLT+TajvDf
   I=;
X-CSE-ConnectionGUID: PRpLJDdWTKKuKZihCluEtg==
X-CSE-MsgGUID: fof3r14FRd6XMMxtBvQrgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="139541935"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="139541935"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:37:48 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:37:47 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:37:45 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 15/34] wifi: inffmac: add net.c/h
Date: Wed, 14 Jan 2026 02:03:28 +0530
Message-ID: <20260113203350.16734-16-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

Integrate the driver with kernel network stack for enabling
datapath communication using a netdev for WLAN interfaces.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/net.c | 695 ++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/net.h |  42 ++
 2 files changed, 737 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/net.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/net.h

diff --git a/drivers/net/wireless/infineon/inffmac/net.c b/drivers/net/wireless/infineon/inffmac/net.c
new file mode 100644
index 000000000000..e091d2890b32
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/net.c
@@ -0,0 +1,695 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <net/rtnetlink.h>
+#include <net/sock.h>
+
+#include "main.h"
+#include "net.h"
+#include "cfg80211.h"
+#include "interface.h"
+#include "utils.h"
+#include "bus_proto.h"
+#include "dev_cmd.h"
+#include "twt.h"
+
+#define INFF_WLC_CNT_VER_30		30
+#define INFF_WLC_CNT_IOV_BUF	2048
+
+static const char inff_wlc_counter_strs_v30[][32] = {
+	"txframe", "txbyte", "txretrans", "txerror", "txctl", "txprshort", "txserr", "txnobuf",
+	"txnoassoc", "txrunt", "txchit", "txcmiss", "txuflo", "txphyerr", "txphycrs",
+	"rxframe", "rxbyte", "rxerror", "rxctl", "rxnobuf", "rxnondata", "rxbadds", "rxbadcm",
+	"rxfragerr", "rxrunt", "rxgiant", "rxnoscb", "rxbadproto", "rxbadsrcmac",
+	"rxbadda", "rxfilter", "rxoflo", "rxuflo[0]", "rxuflo[1]",
+	"rxuflo[2]", "rxuflo[3]", "rxuflo[4]", "rxuflo[5]",
+
+	"d11cnt_txrts_off", "d11cnt_rxcrc_off", "d11cnt_txnocts_off", "dmade", "dmada",
+	"dmape", "reset", "tbtt", "txdmawar", "pkt_callback_reg_fail",
+	"txfrag", "txmulti", "txfail", "txretry",
+	"txretrie", "rxdup", "txrts", "txnocts", "txnoack", "rxfrag",
+	"rxmulti", "rxcrc", "txfrmsnt", "rxundec",
+	"tkipmicfaill", "tkipcntrmsr", "tkipreplay", "ccmpfmterr",
+	"ccmpreplay", "ccmpundec", "fourwayfail", "wepundec",
+	"wepicverr", "decsuccess", "tkipicverr", "wepexcluded",
+	"txchanrej", "psmwds", "phywatchdog",
+	"prq_entries_handled", "prq_undirected_entries", "prq_bad_entries",
+	"atim_suppress_count", "bcn_template_not_ready", "bcn_template_not_ready_done",
+	"late_tbtt_dpc",
+
+	"rx1mbps", "rx2mbps", "rx5mbps5", "rx6mbps", "rx9mbps",
+	"rx11mbps", "rx12mbps", "rx18mbps", "rx24mbps", "rx36mbps",
+	"rx48mbps", "rx54mbps", "rx108mbps", "rx162mbps", "rx216mbps",
+	"rx270mbps", "rx324mbps", "rx378mbps", "rx432mbps", "rx486mbps",
+	"rx540mbps", "rfdisable", "txexptime", "txmpdu_sgi", "rxmpdu_sgi",
+	"txmpdu_stbc", "rxmpdu_stbc", "rxundec_mcst",
+
+	"tkipmicfaill_mcst", "tkipcntrmsr_mcst", "tkipreplay_mcst",
+	"ccmpfmterr_mcst", "ccmpreplay_mcst", "ccmpundec_mcst",
+	"fourwayfail_mcst", "wepundec_mcst", "wepicverr_mcst",
+	"decsuccess_mcst", "tkipicverr_mcst", "wepexcluded_mcst",
+	"dma_hang", "reinit", "pstatxucast",
+	"pstatxnoassoc", "pstarxucast", "pstarxbcmc",
+	"pstatxbcmc", "cso_passthrough", "cso_normal",
+	"chained", "chainedsz1", "unchained",
+	"maxchainsz", "currchainsz", "pciereset",
+	"cfgrestore", "reinitreason[0]", "reinitreason[1]",
+	"reinitreason[2]", "reinitreason[3]", "reinitreason[4]",
+	"reinitreason[5]", "reinitreason[6]", "reinitreason[7]",
+	"rxrtry", "rxmpdu_mu",
+
+	"txbar", "rxbar", "txpspoll", "rxpspoll", "txnull",
+	"rxnull", "txqosnull", "rxqosnull", "txassocreq", "rxassocreq",
+	"txreassocreq", "rxreassocreq", "txdisassoc", "rxdisassoc",
+	"txassocrsp", "rxassocrsp", "txreassocrsp", "rxreassocrsp",
+	"txauth", "rxauth", "txdeauth", "rxdeauth", "txprobereq",
+	"rxprobereq", "txprobersp", "rxprobersp", "txaction",
+	"rxaction", "ampdu_wds", "txlost", "txdatamcast",
+	"txdatabcast", "psmxwds", "rxback", "txback",
+	"p2p_tbtt", "p2p_tbtt_miss", "txqueue_start", "txqueue_end",
+	"txbcast", "txdropped", "rxbcast", "rxdropped",
+	"txq_end_assoccb",
+};
+
+static void inff_ethtool_get_drvinfo(struct net_device *ndev,
+				     struct ethtool_drvinfo *info)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	char drev[INFF_DOTREV_LEN] = "n/a";
+
+	if (drvr->revinfo.result == 0)
+		inff_dotrev_str(drvr->revinfo.driverrev, drev);
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->version, drev, sizeof(info->version));
+	strscpy(info->fw_version, drvr->fwver, sizeof(info->fw_version));
+	strscpy(info->bus_info, dev_name(drvr->bus_if->dev),
+		sizeof(info->bus_info));
+
+	if (inff_socitype_is_ai(drvr->bus_if) &&
+	    !drvr->cnt_ver) {
+		int ret;
+		u8 *iovar_out;
+
+		iovar_out = kzalloc(INFF_WLC_CNT_IOV_BUF, GFP_KERNEL);
+		if (!iovar_out)
+			return;
+		ret = inff_fwcmd_iovar_data_get(ifp, "counters", iovar_out,
+						INFF_WLC_CNT_IOV_BUF);
+		if (ret) {
+			inff_err("Failed to get counters, code :%d\n", ret);
+			kfree(iovar_out);
+			iovar_out = NULL;
+		}
+		memcpy(&drvr->cnt_ver, iovar_out, sizeof(drvr->cnt_ver));
+	}
+	inff_err(" driver %s bus_info %s\n", info->driver, info->bus_info);
+}
+
+static void inff_ethtool_get_strings(struct net_device *net_dev,
+				     u32 sset, u8 *strings)
+{
+	struct inff_if *ifp = netdev_priv(net_dev);
+	struct inff_pub *drvr = ifp->drvr;
+
+	if (sset == ETH_SS_STATS) {
+		switch (drvr->cnt_ver) {
+		case INFF_WLC_CNT_VER_30:
+			memcpy(strings, inff_wlc_counter_strs_v30,
+			       sizeof(inff_wlc_counter_strs_v30));
+			break;
+		default:
+			inff_err("Unsupported counters version\n");
+		}
+	}
+}
+
+static void inff_ethtool_get_stats(struct net_device *netdev,
+				   struct ethtool_stats *et_stats, u64 *results_buf)
+{
+	struct inff_if *ifp = netdev_priv(netdev);
+	u8 *iovar_out, *src, ret;
+	u16 version, len, xtlv_wl_cnt_offset = 0;
+	u16 soffset = 0, idx = 0;
+
+	iovar_out = kzalloc(INFF_WLC_CNT_IOV_BUF, GFP_KERNEL);
+
+	if (!iovar_out)
+		return;
+
+	ret = inff_fwcmd_iovar_data_get(ifp, "counters", iovar_out,
+					INFF_WLC_CNT_IOV_BUF);
+	if (ret) {
+		inff_err("Failed to get counters, code :%d\n", ret);
+		goto done;
+	}
+	src = iovar_out;
+
+	memcpy(&version, src, sizeof(version));
+	soffset += sizeof(version);
+	memcpy(&len, (src + soffset), sizeof(len));
+	soffset += sizeof(len);
+
+	/* Check counters version and decide if its non-TLV or TLV (version>=30)*/
+	if (version >= INFF_WLC_CNT_VER_30) {
+		xtlv_wl_cnt_offset = inff_fwcmd_xtlv_find_wlc_cntr(src, &len);
+		len = (len / sizeof(u32));
+	} else {
+		len = (len / sizeof(u32)) - sizeof(u32);
+	}
+
+	src = src + soffset + xtlv_wl_cnt_offset;
+	while (idx < (len)) {
+		results_buf[idx++] = *((u32 *)src);
+		src += sizeof(u32);
+	}
+done:
+	kfree(iovar_out);
+	iovar_out = NULL;
+}
+
+static int inff_ethtool_get_scount(struct net_device *dev, int sset)
+{
+	u16 array_size;
+	struct inff_if *ifp = netdev_priv(dev);
+	struct inff_pub *drvr = ifp->drvr;
+
+	if (sset == ETH_SS_STATS) {
+		switch (drvr->cnt_ver) {
+		case INFF_WLC_CNT_VER_30:
+			array_size = ARRAY_SIZE(inff_wlc_counter_strs_v30);
+			break;
+		default:
+			inff_err("Unsupported counters version\n");
+			return -EOPNOTSUPP;
+		}
+	} else {
+		inff_dbg(INFO, "Does not support ethtool string set %d\n", sset);
+		return -EOPNOTSUPP;
+	}
+	return array_size;
+}
+
+static const struct ethtool_ops inff_ethtool_ops = {
+	.get_drvinfo = inff_ethtool_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
+	.get_strings = inff_ethtool_get_strings,
+	.get_ethtool_stats = inff_ethtool_get_stats,
+	.get_sset_count	= inff_ethtool_get_scount,
+};
+
+void inff_net_txflowblock(struct inff_if *ifp,
+			  enum inff_netif_stop_reason reason, bool state)
+{
+	unsigned long flags;
+
+	if (!ifp || !ifp->ndev)
+		return;
+
+	inff_dbg(TRACE, "bsscfgidx=%d stop=0x%X reason=%d state=%d\n",
+		 ifp->bsscfgidx, ifp->netif_stop, reason, state);
+
+	spin_lock_irqsave(&ifp->netif_stop_lock, flags);
+	if (state) {
+		if (!ifp->netif_stop)
+			netif_stop_queue(ifp->ndev);
+		ifp->netif_stop |= reason;
+	} else {
+		ifp->netif_stop &= ~reason;
+		if (!ifp->netif_stop)
+			netif_wake_queue(ifp->ndev);
+	}
+	spin_unlock_irqrestore(&ifp->netif_stop_lock, flags);
+}
+
+void inff_net_setcarrier(struct inff_if *ifp, bool on)
+{
+	struct net_device *ndev;
+
+	ndev = ifp->ndev;
+	inff_net_txflowblock(ifp, INFF_NETIF_STOP_REASON_DISCONNECTED, !on);
+	if (on) {
+		if (!netif_carrier_ok(ndev))
+			netif_carrier_on(ndev);
+
+	} else {
+		if (netif_carrier_ok(ndev))
+			netif_carrier_off(ndev);
+	}
+}
+
+void inff_net_rx(struct inff_if *ifp, struct sk_buff *skb, bool inirq)
+{
+	if (skb->pkt_type == PACKET_MULTICAST)
+		ifp->ndev->stats.multicast++;
+
+	if (!(ifp->ndev->flags & IFF_UP)) {
+		inff_pkt_buf_free_skb(skb);
+		return;
+	}
+
+	ifp->ndev->stats.rx_bytes += skb->len;
+	ifp->ndev->stats.rx_packets++;
+
+	inff_dbg(DATA, "rx proto=0x%X\n", ntohs(skb->protocol));
+	if (ifp->napi.poll && ifp->napi_gro)
+		napi_gro_receive(&ifp->napi, skb);
+	else
+		netif_rx(skb);
+}
+
+static int inff_netdev_open(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_bus *bus_if = drvr->bus_if;
+	u32 toe_ol = 0;
+	int ret;
+
+	/* If bus is not ready, can't continue */
+	if (bus_if->state != INFF_BUS_UP) {
+		iphy_err(drvr, "failed bus is not ready\n");
+		return -EAGAIN;
+	}
+
+	atomic_set(&ifp->pend_8021x_cnt, 0);
+
+	/* Get current TOE mode from dongle */
+	if (inff_fwcmd_iovar_int_get(ifp, "toe_ol", &toe_ol) >= 0 &&
+	    (toe_ol & TOE_TX_CSUM_OL) != 0)
+		ndev->features |= NETIF_F_IP_CSUM;
+	else
+		ndev->features &= ~NETIF_F_IP_CSUM;
+
+	wiphy_lock(drvr->wiphy);
+	ret = inff_cfg80211_up(ndev);
+	wiphy_unlock(drvr->wiphy);
+
+	if (ret) {
+		iphy_err(drvr, "failed to bring up cfg80211\n");
+		return -EIO;
+	}
+
+	/* Clear, carrier, set when connected or AP mode. */
+	netif_carrier_off(ndev);
+
+	return 0;
+}
+
+static int inff_netdev_stop(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+
+	wiphy_lock(drvr->wiphy);
+
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		inff_cfg80211_down(ndev);
+	} else if (inff_socitype_is_cp(drvr->bus_if)) {
+		inff_cp_cfg80211_link_down(ifp);
+		clear_bit(INFF_VIF_STATUS_READY, &ifp->vif->sme_state);
+	}
+
+	wiphy_unlock(drvr->wiphy);
+
+	inff_net_setcarrier(ifp, false);
+
+	return 0;
+}
+
+static netdev_tx_t inff_netdev_start_xmit(struct sk_buff *skb,
+					  struct net_device *ndev)
+{
+	int ret;
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	struct ethhdr *eh;
+	int head_delta;
+	unsigned int tx_bytes = skb->len;
+
+	/* Can the device send data? */
+	if (drvr->bus_if->state != INFF_BUS_UP) {
+		iphy_err(drvr, "xmit rejected state=%d\n", drvr->bus_if->state);
+		netif_stop_queue(ndev);
+		dev_kfree_skb(skb);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	/* Make sure there's enough writeable headroom */
+	if (skb_headroom(skb) < drvr->hdrlen || skb_header_cloned(skb)) {
+		head_delta = max_t(int, drvr->hdrlen - skb_headroom(skb), 0);
+
+		inff_dbg(INFO, "%s: %s headroom\n", inff_ifname(ifp),
+			 head_delta ? "insufficient" : "unmodifiable");
+		atomic_inc(&drvr->bus_if->stats.pktcowed);
+		ret = pskb_expand_head(skb, ALIGN(head_delta, NET_SKB_PAD), 0,
+				       GFP_ATOMIC);
+		if (ret < 0) {
+			iphy_err(drvr, "%s: failed to expand headroom\n",
+				 inff_ifname(ifp));
+			atomic_inc(&drvr->bus_if->stats.pktcow_failed);
+			dev_kfree_skb(skb);
+			goto done;
+		}
+	}
+
+	/* validate length for ether packet */
+	if (skb->len < sizeof(*eh)) {
+		ret = -EINVAL;
+		dev_kfree_skb(skb);
+		goto done;
+	}
+
+	eh = (struct ethhdr *)(skb->data);
+
+	if (eh->h_proto == htons(ETH_P_PAE))
+		atomic_inc(&ifp->pend_8021x_cnt);
+
+	/* determine the priority */
+	if (skb->priority == 0 || skb->priority > 7)
+		skb->priority = cfg80211_classify8021d(skb, NULL);
+
+	/* set pacing shift for packet aggregation */
+	sk_pacing_shift_update(skb->sk, 8);
+
+	ret = inff_proto_tx_queue_data(drvr, ifp->ifidx, skb);
+	if (ret < 0)
+		inff_txfinalize(ifp, skb, false);
+
+done:
+	if (ret) {
+		ndev->stats.tx_dropped++;
+	} else {
+		ndev->stats.tx_packets++;
+		ndev->stats.tx_bytes += tx_bytes;
+	}
+
+	/* Return ok: we always eat the packet */
+	return NETDEV_TX_OK;
+}
+
+static int inff_netdev_set_mac_address(struct net_device *ndev, void *addr)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct sockaddr *sa = (struct sockaddr *)addr;
+	int err = 0;
+
+	if (inff_socitype_is_ai(ifp->drvr->bus_if)) {
+		err = inff_set_cur_etheraddr(ifp, sa->sa_data);
+		if (err >= 0) {
+			inff_dbg(TRACE, "MAC Address updated to %pM\n", sa->sa_data);
+			memcpy(ifp->mac_addr, sa->sa_data, ETH_ALEN);
+			eth_hw_addr_set(ifp->ndev, ifp->mac_addr);
+		}
+	}
+
+	return err;
+}
+
+static void inff_net_set_multicast_list(struct wiphy *wiphy,
+					struct wiphy_work *work)
+{
+	struct inff_if *ifp = container_of(work, struct inff_if,
+					   multicast_work);
+	struct inff_pub *drvr = ifp->drvr;
+	struct net_device *ndev = ifp->ndev;
+	struct netdev_hw_addr *ha;
+	u32 cmd_value, cnt;
+	__le32 cnt_le;
+	char *buf, *bufp;
+	u32 buflen;
+	s32 err;
+
+	if (inff_socitype_is_cp(ifp->drvr->bus_if))
+		return;
+
+	/* Determine initial value of allmulti flag */
+	cmd_value = (ndev->flags & IFF_ALLMULTI) ? true : false;
+
+	/* Send down the multicast list first. */
+	cnt = netdev_mc_count(ndev);
+	buflen = sizeof(cnt) + (cnt * ETH_ALEN);
+	buf = kmalloc(buflen, GFP_KERNEL);
+	if (!buf)
+		return;
+	bufp = buf;
+
+	cnt_le = cpu_to_le32(cnt);
+	memcpy(bufp, &cnt_le, sizeof(cnt_le));
+	bufp += sizeof(cnt_le);
+
+	netdev_for_each_mc_addr(ha, ndev) {
+		if (!cnt)
+			break;
+		memcpy(bufp, ha->addr, ETH_ALEN);
+		bufp += ETH_ALEN;
+		cnt--;
+	}
+
+	err = inff_fwcmd_iovar_data_set(ifp, "mcast_list", buf, buflen);
+	if (err < 0) {
+		iphy_err(drvr, "Setting mcast_list failed, %d\n", err);
+		cmd_value = cnt ? true : cmd_value;
+	}
+
+	kfree(buf);
+
+	/*
+	 * Now send the allmulti setting.  This is based on the setting in the
+	 * net_device flags, but might be modified above to be turned on if we
+	 * were trying to set some addresses and dongle rejected it...
+	 */
+	err = inff_fwcmd_iovar_int_set(ifp, "allmulti", cmd_value);
+	if (err < 0)
+		iphy_err(drvr, "Setting allmulti failed, %d\n", err);
+
+	/*Finally, pick up the PROMISC flag */
+	cmd_value = (ndev->flags & IFF_PROMISC) ? true : false;
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_PROMISC, cmd_value);
+	if (err < 0) {
+		/* PROMISC unsupported by firmware of older chips */
+		if (err == -EBADE)
+			iphy_info_once(drvr, "INFF_C_SET_PROMISC unsupported\n");
+		else
+			iphy_err(drvr, "Setting INFF_C_SET_PROMISC failed, err=%d\n",
+				 err);
+	}
+}
+
+static void inff_netdev_set_multicast_list(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+
+	if (inff_socitype_is_ai(ifp->drvr->bus_if))
+		wiphy_work_queue(ifp->drvr->wiphy, &ifp->multicast_work);
+}
+
+static const struct net_device_ops inff_netdev_ops_pri = {
+	.ndo_open = inff_netdev_open,
+	.ndo_stop = inff_netdev_stop,
+	.ndo_start_xmit = inff_netdev_start_xmit,
+	.ndo_set_mac_address = inff_netdev_set_mac_address,
+	.ndo_set_rx_mode = inff_netdev_set_multicast_list,
+};
+
+int inff_net_attach(struct inff_if *ifp, bool locked)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct net_device *ndev = ifp->ndev;
+	s32 err;
+
+	if (!ndev)
+		return -EINVAL;
+
+	/* set appropriate operations */
+	ndev->netdev_ops = &inff_netdev_ops_pri;
+
+	ndev->needed_headroom += drvr->hdrlen;
+	ndev->ethtool_ops = &inff_ethtool_ops;
+
+	/* set the mac address & netns */
+	eth_hw_addr_set(ndev, ifp->mac_addr);
+	dev_net_set(ndev, wiphy_net(drvr->config->wiphy));
+
+	wiphy_work_init(&ifp->multicast_work, inff_net_set_multicast_list);
+
+	if (locked)
+		err = cfg80211_register_netdevice(ndev);
+	else
+		err = register_netdev(ndev);
+	if (err != 0) {
+		iphy_err(drvr, "couldn't register the net device\n");
+		goto fail;
+	}
+
+	netif_carrier_off(ndev);
+
+	ndev->priv_destructor = inff_cfg80211_free_netdev_priv;
+	inff_dbg(INFO, "%s: Infineon Dongle Host Driver\n", ndev->name);
+	return 0;
+
+fail:
+	drvr->iflist[ifp->bsscfgidx] = NULL;
+	ndev->netdev_ops = NULL;
+	return -EBADE;
+}
+
+void inff_net_detach(struct net_device *ndev, bool locked)
+{
+	if (ndev->reg_state == NETREG_REGISTERED) {
+		if (locked)
+			cfg80211_unregister_netdevice(ndev);
+		else
+			unregister_netdev(ndev);
+	} else {
+		inff_cfg80211_free_netdev_priv(ndev);
+		free_netdev(ndev);
+	}
+}
+
+struct inff_if *inff_net_add_if(struct inff_pub *drvr, s32 bsscfgidx, s32 ifidx,
+				const char *name, const u8 *mac_addr,
+				enum nl80211_iftype iftype)
+{
+	struct inff_if *ifp;
+	struct net_device *ndev;
+	int err;
+
+	inff_dbg(TRACE, "bsscfgidx=%d, ifidx=%d\n", bsscfgidx, ifidx);
+
+	switch (iftype) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_GO:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_CLIENT:
+		inff_dbg(INFO, "adding  netdev interface\n");
+		/* Allocate netdev, including space for private structure */
+		ndev = alloc_netdev(sizeof(*ifp), name,
+				    NET_NAME_UNKNOWN, ether_setup);
+		if (!ndev)
+			return ERR_PTR(-ENOMEM);
+
+		ndev->needs_free_netdev = true;
+		ifp = netdev_priv(ndev);
+		ifp->ndev = ndev;
+		/* store mapping ifidx to bsscfgidx */
+		if (drvr->if2bss[ifidx] == INFF_BSSIDX_INVALID)
+			drvr->if2bss[ifidx] = bsscfgidx;
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		inff_dbg(INFO, "adding non-netdev interface\n");
+		ifp = kzalloc(sizeof(*ifp), GFP_KERNEL);
+		if (!ifp)
+			return ERR_PTR(-ENOMEM);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	ifp->drvr = drvr;
+	drvr->iflist[bsscfgidx] = ifp;
+	ifp->ifidx = ifidx;
+	ifp->bsscfgidx = bsscfgidx;
+
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		init_waitqueue_head(&ifp->pend_8021x_wait);
+		spin_lock_init(&ifp->netif_stop_lock);
+		INFF_IF_STA_LIST_LOCK_INIT(ifp);
+		 /* Initialize STA info list */
+		INIT_LIST_HEAD(&ifp->sta_list);
+
+		spin_lock_init(&ifp->twt_sess_list_lock);
+		 /* Initialize TWT Session list */
+		INIT_LIST_HEAD(&ifp->twt_sess_list);
+		wiphy_delayed_work_init(&ifp->twt_timeout_work,
+					inff_twt_event_timeout_worker);
+	} else if (inff_socitype_is_cp(drvr->bus_if)) {
+		if (drvr->bus_if->state != INFF_BUS_UP)
+			inff_bus_change_state(drvr->bus_if, INFF_BUS_UP);
+
+		err = inff_cpcmd_data_get(ifp, INFF_CP_C_MAC, ifp->mac_addr, ETH_ALEN);
+		if (err) {
+			inff_err("Could not get MAC address (%d)\n", err);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	if (mac_addr)
+		memcpy(ifp->mac_addr, mac_addr, ETH_ALEN);
+
+	inff_dbg(TRACE, "%s (%pM) created by pid:%x\n",
+		 name, ifp->mac_addr, current->pid);
+
+	return ifp;
+}
+
+void inff_net_del_if(struct inff_pub *drvr, struct inff_if *ifp, bool locked)
+{
+	int ifidx;
+	s32 bsscfgidx;
+	enum nl80211_iftype iftype = NL80211_IFTYPE_UNSPECIFIED;
+
+	if (!drvr || !ifp) {
+		inff_err("NULL interface cannot be removed\n");
+		return;
+	}
+
+	ifidx = ifp->ifidx;
+	bsscfgidx = ifp->bsscfgidx;
+
+	if (ifp->vif)
+		iftype = ifp->vif->wdev.iftype;
+
+	inff_dbg(TRACE, "bsscfgidx=%d, ifidx=%d\n", bsscfgidx,
+		 ifp->ifidx);
+
+	inff_proto_del_if(drvr, ifp);
+
+	/* Stop the aperiodic TWT Session cleanup activity */
+	wiphy_delayed_work_cancel(ifp->drvr->wiphy, &ifp->twt_timeout_work);
+
+	switch (iftype) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_GO:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_CLIENT:
+		inff_dbg(INFO, "deleting netdev interface\n");
+		if (bsscfgidx == 0) {
+			rtnl_lock();
+			inff_netdev_stop(ifp->ndev);
+			rtnl_unlock();
+		} else {
+			netif_stop_queue(ifp->ndev);
+		}
+
+		wiphy_work_cancel(drvr->wiphy, &ifp->multicast_work);
+		inff_net_detach(ifp->ndev, locked);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		inff_dbg(INFO, "deleting non-netdev interface\n");
+		inff_p2p_detach_device(ifp, locked);
+		kfree(ifp);
+		break;
+	default:
+		inff_dbg(TRACE, "Unknown wdev iface type");
+		break;
+	}
+
+	drvr->iflist[bsscfgidx] = NULL;
+	if (drvr->if2bss[ifidx] == bsscfgidx)
+		drvr->if2bss[ifidx] = INFF_BSSIDX_INVALID;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/net.h b/drivers/net/wireless/infineon/inffmac/net.h
new file mode 100644
index 000000000000..3ed625e9f103
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/net.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_NET_H
+#define INFF_NET_H
+
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+/**
+ * enum inff_netif_stop_reason - reason for stopping netif queue.
+ *
+ * @INFF_NETIF_STOP_REASON_FWS_FC:
+ *	netif stopped due to firmware signalling flow control.
+ * @INFF_NETIF_STOP_REASON_FLOW:
+ *	netif stopped due to flowring full.
+ * @INFF_NETIF_STOP_REASON_DISCONNECTED:
+ *	netif stopped due to not being connected (STA mode).
+ */
+enum inff_netif_stop_reason {
+	INFF_NETIF_STOP_REASON_FWS_FC = BIT(0),
+	INFF_NETIF_STOP_REASON_FLOW = BIT(1),
+	INFF_NETIF_STOP_REASON_DISCONNECTED = BIT(2)
+};
+
+void inff_net_txflowblock(struct inff_if *ifp,
+			  enum inff_netif_stop_reason reason, bool state);
+void inff_net_setcarrier(struct inff_if *ifp, bool on);
+void inff_net_rx(struct inff_if *ifp, struct sk_buff *skb, bool inirq);
+int inff_net_attach(struct inff_if *ifp, bool locked);
+void inff_net_detach(struct net_device *ndev, bool locked);
+struct inff_if *inff_net_add_if(struct inff_pub *drvr, s32 bsscfgidx, s32 ifidx,
+				const char *name, const u8 *mac_addr,
+				enum nl80211_iftype iftype);
+void inff_net_del_if(struct inff_pub *drvr, struct inff_if *ifp, bool locked);
+
+#endif /* INFF_NET_H */
-- 
2.25.1


