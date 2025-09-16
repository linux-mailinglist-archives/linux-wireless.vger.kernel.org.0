Return-Path: <linux-wireless+bounces-27399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B68B7ED2B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58C07A5315
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC6A323F5A;
	Tue, 16 Sep 2025 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="bHznNbsF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3D2D8763
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061726; cv=none; b=fkbtYybwswuPOUwMHyNBijwllqlsT+vcyeI/Qms4oG6Jc3ulyMxUA2XXsg4pPbGhXU3e13X1bYtelSLY9EcmbAf59Ym2irL/GMRq89tfCd4d4ssKE4wvqCeXvFG/rBkcGyIYV5TTj6ulWh7s7icefeZrHKPjTlhfAoLe5J9eaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061726; c=relaxed/simple;
	bh=ro3sCWobs82Ug3qnhNFo9ejVbC63KzwMdhq+aUbrywU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z75YEJZAhvcbiZcngdEu1Vv2YPmEMIuZo3e36ZPZZPzskluhtOqbTfA2lvbLzoU9mvOi6MZgdIHnKBth/Yt2ArXZ2x4aLDCdWs9g3r6wGQJ6Cmt95Y9IkWbr6u4B8Hg0/sM7C6bSmog4Erqp/R5KYHMEw6Ya+gR3qCu1yLO5VJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=bHznNbsF; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061721; x=1789597721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ro3sCWobs82Ug3qnhNFo9ejVbC63KzwMdhq+aUbrywU=;
  b=bHznNbsFseFPdqzoqbZoHJPYKt/fanQ/0LOPRT+H6GFpAjHxe4P6zjL+
   NF/cou8wHWT+i6wB53H3mLLJnOpKvxnzXx+aQk/8FKy8BBtoQhWQeGnFQ
   BC84dujpmkiMRLI3pB7piJCpeZKxXcvI2Gu2QTZLzOzAiiV7o8j4fSJXy
   o=;
X-CSE-ConnectionGUID: n+xHpqFQTR62mipYmdrJfQ==
X-CSE-MsgGUID: /ZoHzzwKRcyLUo0+IdRJqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093802"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093802"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:28:41 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:28:40 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:28:37 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 44/57] wifi: inffmac: add core.c/h
Date: Wed, 17 Sep 2025 03:48:04 +0530
Message-ID: <20250916221821.4387-50-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
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

Driver implementation of network stack related operations and other
core functionalities of the driver.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/core.c | 2326 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/core.h |  355 +++
 2 files changed, 2681 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/core.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/core.h

diff --git a/drivers/net/wireless/infineon/inffmac/core.c b/drivers/net/wireless/infineon/inffmac/core.c
new file mode 100644
index 000000000000..0ddb16072a9d
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/core.c
@@ -0,0 +1,2326 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/module.h>
+#include <linux/inetdevice.h>
+#include <linux/property.h>
+#include <net/cfg80211.h>
+#include <net/rtnetlink.h>
+#include <net/addrconf.h>
+#include <net/ieee80211_radiotap.h>
+#include <net/ipv6.h>
+
+#include "utils.h"
+#include "defs.h"
+#include "chanspec.h"
+#include "core.h"
+#include "bus.h"
+#include "debug.h"
+#include "fwil_types.h"
+#include "p2p.h"
+#include "pno.h"
+#include "cfg80211.h"
+#include "fwil.h"
+#include "feature.h"
+#include "proto.h"
+#include "pcie.h"
+#include "common.h"
+#include "twt.h"
+#include "bt_shared_sdio.h"
+#include "sdio.h"
+#include "offload.h"
+#include "pmsr.h"
+#include "xdp.h"
+#include "logger.h"
+#include "dfu.h"
+
+#define MAX_WAIT_FOR_8021X_TX			msecs_to_jiffies(950)
+
+#define INFF_BSSIDX_INVALID			-1
+
+#define	RXS_PBPRES				BIT(2)
+
+#define	D11_PHY_HDR_LEN				6
+
+#define WL_CNT_XTLV_SLICE_IDX		256
+
+#define IOVAR_XTLV_BEGIN		4
+
+#define XTLV_TYPE_SIZE		2
+
+#define XTLV_TYPE_LEN_SIZE		4
+
+#define WL_CNT_IOV_BUF		2048
+
+#define CNT_VER_6	6
+#define CNT_VER_10	10
+#define CNT_VER_30	30
+
+/* Macro to calculate packing factor with scalar 4 in a xTLV */
+#define PACKING_FACTOR(args)	({ \
+	typeof(args) _args = (args); \
+	((_args) % 4 == 0 ? 0 : (4 - ((_args) % 4))); \
+	})
+
+struct d11rxhdr_le {
+	__le16 rx_frame_size;
+	u16 PAD;
+	__le16 phy_rx_status_0;
+	__le16 phy_rx_status_1;
+	__le16 phy_rx_status_2;
+	__le16 phy_rx_status_3;
+	__le16 phy_rx_status_4;
+	__le16 phy_rx_status_5;
+	__le16 rx_status_1;
+	__le16 rx_status_2;
+	__le16 rx_tsf_time;
+	__le16 rx_chan;
+	u8 unknown[12];
+} __packed;
+
+struct wlc_d11rxhdr {
+	struct d11rxhdr_le rxhdr;
+	__le32 tsf_l;
+	s8 rssi;
+	s8 rxpwr0;
+	s8 rxpwr1;
+	s8 do_rssi_ma;
+	s8 rxpwr[4];
+} __packed;
+
+static const char fmac_ethtool_string_stats_v6[][ETH_GSTRING_LEN] = {
+	"txbyte", "txerror", "txprshort", "txnobuf", "txrunt", "txcmiss", "txphyerr",
+	"rxframe", "rxerror", "rxnobuf", "rxbadds", "rxfragerr",
+	"rxgiant", "rxbadproto", "rxbadda", "rxoflo", "d11cnt_rxcrc_off", "dmade",
+	"dmape", "tbtt", "pkt_callback_reg_fail", "txackfrm", "txbcnfrm", "rxtoolate",
+	"txtplunfl", "rxinvmachdr", "rxbadplcp", "rxstrt", "rxmfrmucastmbss",
+	"rxrtsucast", "rxackucast", "rxmfrmocast", "rxrtsocast", "rxdfrmmcast",
+	"rxcfrmmcast", "rxdfrmucastobss", "rxrsptmout", "rxf0ovfl", "rxf2ovfl", "pmqovfl",
+	"frmscons", "rxback", "txfrag", "txfail", "txretrie", "txrts", "txnoack", "rxmulti",
+
+	"txfrmsnt", "tkipmicfaill", "tkipreplay", "ccmpreplay", "fourwayfail", "wepicverr",
+	"tkipicverr", "tkipmicfaill_mcst", "tkipreplay_mcst", "ccmpreplay_mcst",
+	"fourwayfail_mcst", "wepicverr_mcst", "tkipicverr_mcst", "txexptime", "phywatchdog",
+	"prq_undirected_entries", "atim_suppress_count", "bcn_template_not_ready_done",
+
+	"rx1mbps", "rx5mbps5", "rx9mbps", "rx12mbps", "rx24mbps", "rx48mbps",
+	"rx108mbps", "rx216mbps", "rx324mbps", "rx432mbps", "rx540mbps",
+	"pktengrxdmcast", "bphy_txmpdu_sgi", "txmpdu_stbc", "rxdrop20s",
+};
+
+static const char fmac_ethtool_string_stats_v10[][ETH_GSTRING_LEN] = {
+	"txframe", "txbyte", "txretrans", "txerror", "txctl", "txprshort",
+	"txserr", "txnobuf", "txnoassoc", "txrunt",
+	"txchit", "txcmiss", "txphyerr", "txphycrs", "rxframe", "rxbyte",
+	"rxerror", "rxctl", "rxnobuf", "rxnondata",
+	"rxbadds", "rxbadcm", "rxfragerr", "rxrunt", "rxgiant", "rxnoscb",
+	"rxbadprot", "rxbadsrcma", "rxbadda", "rxfilter",
+	"rxoflo", "rxuflo[0]", "rxuflo[1]", "rxuflo[2]", "rxuflo[3]",
+	"rxuflo[4]", "rxuflo[5]", "d11cnt_rxcrc_off", "d11cnt_txnocts_off",
+	"dmade", "dmada", "dmape", "reset", "tbtt", "txdmawar",
+	"pkt_callback_reg_fail", "txallfrm", "txrtsfrm", "txctsfrm",
+	"txackfrm", "txdnlfrm", "txbcnfrm", "txfunfl[0]", "txfunfl[1]",
+	"txfunfl[2]", "txfunfl[3]", "txfunfl[4]", "txfunfl[5]", "rxtoolate",
+	"txfbw", "txtplunfl", "txphyerror", "rxfrmtoolong", "rxfrmtooshrt",
+	"rxinvmachdr", "rxbadfcs", "rxbadplcp", "rxcrsglitch",
+	"rxstrt", "rxdfrmucastmbss", "rxmfrmucastmbss", "rxcfrmucast",
+	"rxrtsucast", "rxctsucast", "rxackucast",
+	"rxdfrmocast", "rxmfrmocast", "rxcfrmocast", "rxrtsocast",
+	"rxctsocast", "rxdfrmmcast", "rxmfrmmcast", "rxcfrmmcast",
+	"rxbeaconmbss", "rxdfrmucastobss", "rxbeaconobss", "rxrsptmout",
+	"bcntxcancl", "rxf0ovfl", "rxf1ovfl", "rxf2ovfl", "txsfovfl",
+	"pmqovfl", "rxcgprqfrm", "rxcgprsqovfl", "txcgprsfail", "txcgprssuc", "prs_timeout",
+	"rxnack", "frmscons", "txnack", "rxback", "txback", "txfrag", "txmulti", "txfail",
+	"txretry", "txretrie", "rxdup", "txrts", "txnocts", "txnoack", "rxfrag", "rxmulti",
+	"rxcrc", "txfrmsnt", "rxundec", "tkipmicfaill", "tkipcntrmsr", "tkipreplay", "ccmpfmterr",
+	"ccmpreplay", "ccmpundec", "fourwayfail", "wepundec", "wepicverr", "decsuccess",
+	"tkipicverr", "wepexcluded", "psmwds", "phywatchdog", "prq_entries_handled",
+	"prq_undirected_entries", "prq_bad_entries", "atim_suppress_count",
+	"bcn_template_not_ready", "bcn_template_not_ready_done", "late_tbtt_dpc",
+	"rx1mbps", "rx2mbps", "rx5mbps5", "rx6mbps", "rx9mbps", "rx11mbps", "rx12mbps", "rx18mbps",
+	"rx24mbps", "rx36mbps", "rx48mbps", "rx54mbps", "rx108mbps", "rx162mbps",
+	"rx216mbps", "rx270mbps", "rx324mbps", "rx378mbps", "rx432mbps", "rx486mbps", "rx540mbps",
+	"pktengrxducast", "pktengrxdmcast", "bphy_rxcrsglitch", "bphy_b", "txexptime",
+	"rxmpdu_sgi", "txmpdu_stbc", "rxmpdu_stbc", "tkipmicfaill_mcst", "tkipcntrmsr_mcst",
+	"tkipreplay_mcst", "ccmpfmterr_mcst", "ccmpreplay_mcst", "ccmpundec_mcst",
+	"fourwayfail_mcst", "wepundec_mcst", "wepicverr_mcst", "decsuccess_mcst",
+	"tkipicverr_mcst", "wepexcluded_mcst", "reinit", "pstatxnoassoc",
+	"pstarxucast", "pstarxbcmc", "pstatxbcmc", "cso_normal", "chained",
+	"chainedsz1", "unchained", "maxchainsz", "currchainsz", "rxdrop20s",
+	"pciereset", "cfgrestore", "reinitreason[0]", "reinitreason[1]",
+	"reinitreason[2]", "reinitreason[3]", "reinitreason[4]",
+	"reinitreason[5]", "reinitreason[6]", "reinitreason[7]", "rxrtry",
+};
+
+static const char fmac_ethtool_string_stats_v30[][ETH_GSTRING_LEN] = {
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
+#define INFF_IF_STA_LIST_LOCK_INIT(ifp) spin_lock_init(&(ifp)->sta_list_lock)
+#define INFF_IF_STA_LIST_LOCK(ifp, flags) \
+	spin_lock_irqsave(&(ifp)->sta_list_lock, (flags))
+#define INFF_IF_STA_LIST_UNLOCK(ifp, flags) \
+	spin_unlock_irqrestore(&(ifp)->sta_list_lock, (flags))
+
+#define INFF_STA_NULL ((struct inff_sta *)NULL)
+
+/* dscp exception format {dscp hex, up}  */
+struct cfg80211_dscp_exception dscp_excpt[] = {
+{DSCP_EF, 6}, {DSCP_CS4, 5}, {DSCP_AF41, 5}, {DSCP_CS3, 4} };
+
+/* dscp range : up[0 ~ 7] */
+struct cfg80211_dscp_range dscp_range[8] = {
+{0, 7}, {8, 15}, {16, 23}, {24, 31},
+{32, 39}, {40, 47}, {48, 55}, {56, 63} };
+
+char *inff_ifname(struct inff_if *ifp)
+{
+	if (!ifp)
+		return "<if_null>";
+
+	if (ifp->ndev)
+		return ifp->ndev->name;
+
+	return "<if_none>";
+}
+
+struct inff_if *inff_get_ifp(struct inff_pub *drvr, int ifidx)
+{
+	struct inff_if *ifp;
+	s32 bsscfgidx;
+
+	if (ifidx < 0 || ifidx >= INFF_MAX_IFS) {
+		iphy_err(drvr, "ifidx %d out of range\n", ifidx);
+		return NULL;
+	}
+
+	ifp = NULL;
+	bsscfgidx = drvr->if2bss[ifidx];
+	if (bsscfgidx >= 0)
+		ifp = drvr->iflist[bsscfgidx];
+
+	return ifp;
+}
+
+static void _inff_set_multicast_list(struct work_struct *work)
+{
+	struct inff_if *ifp = container_of(work, struct inff_if,
+					    multicast_work);
+	struct inff_pub *drvr = ifp->drvr;
+	struct net_device *ndev;
+	struct netdev_hw_addr *ha;
+	u32 cmd_value, cnt;
+	__le32 cnt_le;
+	char *buf, *bufp;
+	u32 buflen;
+	s32 err;
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
+
+	ndev = ifp->ndev;
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
+	err = inff_fil_iovar_data_set(ifp, "mcast_list", buf, buflen);
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
+	err = inff_fil_iovar_int_set(ifp, "allmulti", cmd_value);
+	if (err < 0)
+		iphy_err(drvr, "Setting allmulti failed, %d\n", err);
+
+	/*Finally, pick up the PROMISC flag */
+	cmd_value = (ndev->flags & IFF_PROMISC) ? true : false;
+	err = inff_fil_cmd_int_set(ifp, INFF_C_SET_PROMISC, cmd_value);
+	if (err < 0) {
+		/* PROMISC unsupported by firmware of older chips */
+		if (err == -EBADE)
+			iphy_info_once(drvr, "INFF_C_SET_PROMISC unsupported\n");
+		else
+			iphy_err(drvr, "Setting INFF_C_SET_PROMISC failed, err=%d\n",
+				 err);
+	}
+	inff_offload_configure_arp_nd(ifp, !cmd_value);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void inff_update_ipv6_addr(struct work_struct *work)
+{
+	struct inff_if *ifp = container_of(work, struct inff_if,
+					    ndoffload_work);
+	struct inff_pub *drvr = ifp->drvr;
+	int i, ret;
+	struct ipv6_addr addr = {0};
+
+	/* clear the table in firmware */
+
+	if (inff_cfg80211_get_iftype(ifp) == NL80211_IFTYPE_STATION &&
+	    inff_feat_is_enabled(ifp, INFF_FEAT_OFFLOADS))
+		ret = inff_offload_host_ipv6_update(ifp, INFF_OFFLOAD_ICMP | INFF_OFFLOAD_ND,
+						    &addr, 1, false);
+	else
+		ret = inff_fil_iovar_data_set(ifp, "nd_hostip_clear", NULL, 0);
+
+	if (ret) {
+		inff_dbg(TRACE, "fail to clear nd ip table err:%d\n", ret);
+		return;
+	}
+
+	for (i = 0; i < ifp->ipv6addr_idx; i++) {
+		if (inff_cfg80211_get_iftype(ifp) == NL80211_IFTYPE_STATION &&
+		    inff_feat_is_enabled(ifp, INFF_FEAT_OFFLOADS))
+			ret = inff_offload_host_ipv6_update(ifp, INFF_OFFLOAD_ICMP |
+								 INFF_OFFLOAD_ND,
+							    &ifp->ipv6_addr_tbl[i], 0, true);
+		else
+			ret = inff_fil_iovar_data_set(ifp, "nd_hostip",
+						      &ifp->ipv6_addr_tbl[i],
+						      sizeof(struct in6_addr));
+		if (ret)
+			iphy_err(drvr, "add nd ip err %d\n", ret);
+	}
+}
+#else
+static void inff_update_ipv6_addr(struct work_struct *work)
+{
+}
+#endif
+
+static int inff_netdev_set_mac_address(struct net_device *ndev, void *addr)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct sockaddr *sa = (struct sockaddr *)addr;
+	int err;
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
+
+	err = inff_c_set_cur_etheraddr(ifp, sa->sa_data);
+	if (err >= 0) {
+		inff_dbg(TRACE, "updated to %pM\n", sa->sa_data);
+		memcpy(ifp->mac_addr, sa->sa_data, ETH_ALEN);
+		eth_hw_addr_set(ifp->ndev, ifp->mac_addr);
+	}
+	return err;
+}
+
+static void inff_netdev_set_multicast_list(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+
+	schedule_work(&ifp->multicast_work);
+}
+
+/**
+ * inff_skb_is_iapp - checks if skb is an IAPP packet
+ *
+ * @skb: skb to check
+ */
+static bool inff_skb_is_iapp(struct sk_buff *skb)
+{
+	static const u8 iapp_l2_update_packet[6] __aligned(2) = {
+		0x00, 0x01, 0xaf, 0x81, 0x01, 0x00,
+	};
+	unsigned char *eth_data;
+#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+	const u16 *a, *b;
+#endif
+
+	if (skb->len - skb->mac_len != 6 ||
+	    !is_multicast_ether_addr(eth_hdr(skb)->h_dest))
+		return false;
+
+	eth_data = skb_mac_header(skb) + ETH_HLEN;
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+	return !(((*(const u32 *)eth_data) ^ (*(const u32 *)iapp_l2_update_packet)) |
+		 ((*(const u16 *)(eth_data + 4)) ^ (*(const u16 *)(iapp_l2_update_packet + 4))));
+#else
+	a = (const u16 *)eth_data;
+	b = (const u16 *)iapp_l2_update_packet;
+
+	return !((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2]));
+#endif
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
+	inff_dbg(DATA, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
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
+	/* Some recent firmwares disassociate STA when they receive
+	 * an 802.11f ADD frame. This behavior can lead to a local DoS security
+	 * issue. Attacker may trigger disassociation of any STA by sending a
+	 * proper Ethernet frame to the wireless interface.
+	 *
+	 * Moreover this feature may break AP interfaces in some specific
+	 * setups. This applies e.g. to the bridge with hairpin mode enabled and
+	 * IFLA_BRPORT_MCAST_TO_UCAST set. IAPP packet generated by a firmware
+	 * will get passed back to the wireless interface and cause immediate
+	 * disassociation of a just-connected STA.
+	 */
+	if (!drvr->settings->iapp && inff_skb_is_iapp(skb)) {
+		dev_kfree_skb(skb);
+		ret = -EINVAL;
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
+	/* Look into dscp to WMM UP mapping with cfg80211_qos_map */
+	if (drvr->settings->pkt_prio) {
+		skb->priority = cfg80211_classify8021d(skb, drvr->qos_map);
+	/* determine the priority */
+	} else if ((skb->priority == 0) || (skb->priority > 7)) {
+		skb->priority = cfg80211_classify8021d(skb, NULL);
+	}
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
+void inff_txflowblock_if(struct inff_if *ifp,
+			 enum inff_netif_stop_reason reason, bool state)
+{
+	unsigned long flags;
+
+	if (!ifp || !ifp->ndev)
+		return;
+
+	inff_dbg(TRACE, "enter: bsscfgidx=%d stop=0x%X reason=%d state=%d\n",
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
+void inff_netif_rx(struct inff_if *ifp, struct sk_buff *skb, bool inirq)
+{
+	/* Most firmwares send 802.11f ADD frame every time a new
+	 * STA connects to the AP interface. This is an obsoleted standard most
+	 * users don't use, so don't pass these frames up unless requested.
+	 */
+	if (!ifp->drvr->settings->iapp && inff_skb_is_iapp(skb)) {
+		inff_pkt_buf_free_skb(skb);
+		return;
+	}
+
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
+	if (ifp->drvr->settings->napi_enable && ifp->napi.poll && ifp->napi_gro)
+		napi_gro_receive(&ifp->napi, skb);
+	else
+		netif_rx(skb);
+}
+
+void inff_netif_mon_rx(struct inff_if *ifp, struct sk_buff *skb)
+{
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_MONITOR_FMT_RADIOTAP)) {
+		/* Do nothing */
+	} else if (inff_feat_is_enabled(ifp, INFF_FEAT_MONITOR_FMT_HW_RX_HDR)) {
+		struct wlc_d11rxhdr *wlc_rxhdr = (struct wlc_d11rxhdr *)skb->data;
+		struct ieee80211_radiotap_header *radiotap;
+		unsigned int offset;
+		u16 rx_status_1;
+
+		rx_status_1 = le16_to_cpu(wlc_rxhdr->rxhdr.rx_status_1);
+
+		offset = sizeof(struct wlc_d11rxhdr);
+		/* MAC inserts 2 pad bytes for a4 headers or QoS or A-MSDU
+		 * subframes
+		 */
+		if (rx_status_1 & RXS_PBPRES)
+			offset += 2;
+		offset += D11_PHY_HDR_LEN;
+
+		skb_pull(skb, offset);
+
+		/* TODO: use RX header to fill some radiotap data */
+		radiotap = skb_push(skb, sizeof(*radiotap));
+		memset(radiotap, 0, sizeof(*radiotap));
+		radiotap->it_len = cpu_to_le16(sizeof(*radiotap));
+
+		/* TODO: 4 bytes with receive status? */
+		skb->len -= 4;
+	} else {
+		struct ieee80211_radiotap_header *radiotap;
+
+		/* TODO: use RX status to fill some radiotap data */
+		radiotap = skb_push(skb, sizeof(*radiotap));
+		memset(radiotap, 0, sizeof(*radiotap));
+		radiotap->it_len = cpu_to_le16(sizeof(*radiotap));
+
+		/* TODO: 4 bytes with receive status? */
+		skb->len -= 4;
+	}
+
+	skb->dev = ifp->ndev;
+	skb_reset_mac_header(skb);
+	skb->pkt_type = PACKET_OTHERHOST;
+	skb->protocol = htons(ETH_P_802_2);
+	/* NAPI disable or NAPI without gro will use skb_queue_tail() */
+	if (ifp->drvr->settings->napi_enable)
+		inff_netif_rx(ifp, skb, false);
+}
+
+static int inff_rx_hdrpull(struct inff_pub *drvr, struct sk_buff *skb,
+			   struct inff_if **ifp)
+{
+	int ret;
+
+	/* process and remove protocol-specific header */
+	ret = inff_proto_hdrpull(drvr, true, skb, ifp);
+
+	if (ret || !(*ifp) || !(*ifp)->ndev) {
+		if (ret != -ENODATA && *ifp && (*ifp)->ndev)
+			(*ifp)->ndev->stats.rx_errors++;
+		inff_pkt_buf_free_skb(skb);
+		return -ENODATA;
+	}
+
+	skb->protocol = eth_type_trans(skb, (*ifp)->ndev);
+	inff_dbg(DATA, "protocol: 0x%04X\n", skb->protocol);
+
+	return 0;
+}
+
+struct sk_buff *inff_rx_frame(struct device *dev, struct sk_buff *skb, bool handle_event,
+			      bool inirq)
+{
+	struct inff_if *ifp;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	inff_dbg(DATA, "Enter: %s: rxp=%p\n", dev_name(dev), skb);
+
+	if (inff_rx_hdrpull(drvr, skb, &ifp))
+		return NULL;
+
+	if (inff_proto_is_reorder_skb(skb)) {
+		inff_proto_rxreorder(ifp, skb, inirq);
+	} else {
+		/* Process special event packets */
+		if (handle_event) {
+			gfp_t gfp = inirq ? GFP_ATOMIC : GFP_KERNEL;
+
+			inff_fweh_process_skb(ifp->drvr, skb,
+					      INFILCP_SUBTYPE_VENDOR_LONG, gfp);
+		}
+
+		/* if sdio_rxf_in_kthread, enqueue it and process it later. */
+		if (inff_feat_is_sdio_rxf_in_kthread(drvr))
+			return skb;
+
+		inff_netif_rx(ifp, skb, inirq);
+	}
+	return NULL;
+}
+
+void inff_rx_event(struct device *dev, struct sk_buff *skb)
+{
+	struct inff_if *ifp;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	inff_dbg(EVENT, "Enter: %s: rxp=%p\n", dev_name(dev), skb);
+
+	if (inff_rx_hdrpull(drvr, skb, &ifp))
+		return;
+
+	inff_fweh_process_skb(ifp->drvr, skb, 0, GFP_KERNEL);
+	inff_pkt_buf_free_skb(skb);
+}
+
+void inff_txfinalize(struct inff_if *ifp, struct sk_buff *txp, bool success)
+{
+	struct ethhdr *eh;
+	u16 type;
+
+	if (!ifp) {
+		inff_pkt_buf_free_skb(txp);
+		return;
+	}
+
+	eh = (struct ethhdr *)(txp->data);
+	type = ntohs(eh->h_proto);
+
+	if (type == ETH_P_PAE) {
+		atomic_dec(&ifp->pend_8021x_cnt);
+		/* check is there any 8021x under waiting */
+		if (waitqueue_active(&ifp->pend_8021x_wait))
+			wake_up(&ifp->pend_8021x_wait);
+	}
+
+	if (!success && ifp->ndev)
+		ifp->ndev->stats.tx_errors++;
+
+	inff_pkt_buf_free_skb(txp);
+}
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
+	if (!drvr->cnt_ver) {
+		int ret;
+		u8 *iovar_out;
+
+		iovar_out = kzalloc(WL_CNT_IOV_BUF, GFP_KERNEL);
+		if (!iovar_out)
+			return;
+		ret = inff_fil_iovar_data_get(ifp, "counters", iovar_out, WL_CNT_IOV_BUF);
+		if (ret) {
+			inff_err("Failed to get counters, code :%d\n", ret);
+			goto done;
+		}
+		memcpy(&drvr->cnt_ver, iovar_out, sizeof(drvr->cnt_ver));
+done:
+	kfree(iovar_out);
+	iovar_out = NULL;
+	}
+}
+
+static void inff_et_get_strings(struct net_device *net_dev,
+				u32 sset, u8 *strings)
+{
+	struct inff_if *ifp = netdev_priv(net_dev);
+	struct inff_pub *drvr = ifp->drvr;
+
+	if (sset == ETH_SS_STATS) {
+		switch (drvr->cnt_ver) {
+		case CNT_VER_6:
+			memcpy(strings, fmac_ethtool_string_stats_v6,
+			       sizeof(fmac_ethtool_string_stats_v6));
+			break;
+		case CNT_VER_10:
+			memcpy(strings, fmac_ethtool_string_stats_v10,
+			       sizeof(fmac_ethtool_string_stats_v10));
+			break;
+		case CNT_VER_30:
+			memcpy(strings, fmac_ethtool_string_stats_v30,
+			       sizeof(fmac_ethtool_string_stats_v30));
+			break;
+		default:
+			inff_err("Unsupported counters version\n");
+		}
+	}
+}
+
+static int inff_find_wlc_cntr_tlv(u8 *src, u16 *len)
+{
+	u16 tlv_id, data_len;
+	u16 packing_offset, cur_tlv = IOVAR_XTLV_BEGIN;
+
+	while (cur_tlv < *len) {
+		memcpy(&tlv_id, (src + cur_tlv), sizeof(*len));
+		memcpy(&data_len, (src + cur_tlv + XTLV_TYPE_SIZE), sizeof(*len));
+		if (tlv_id == WL_CNT_XTLV_SLICE_IDX) {
+			*len = data_len;
+			return cur_tlv;
+		}
+		/* xTLV data has 4 bytes packing. So caclculate the packing offset using the data */
+		packing_offset = PACKING_FACTOR(data_len);
+		cur_tlv += XTLV_TYPE_LEN_SIZE + data_len + packing_offset;
+	}
+	return -EINVAL;
+}
+
+static void inff_et_get_stats(struct net_device *netdev,
+			      struct ethtool_stats *et_stats, u64 *results_buf)
+{
+	struct inff_if *ifp = netdev_priv(netdev);
+	u8 *iovar_out, *src, ret;
+	u16 version, len, xtlv_wl_cnt_offset = 0;
+	u16 soffset = 0, idx = 0;
+
+	iovar_out = kzalloc(WL_CNT_IOV_BUF, GFP_KERNEL);
+
+	if (!iovar_out)
+		return;
+
+	ret = inff_fil_iovar_data_get(ifp, "counters", iovar_out, WL_CNT_IOV_BUF);
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
+	if (version >= CNT_VER_30) {
+		xtlv_wl_cnt_offset = inff_find_wlc_cntr_tlv(src, &len);
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
+static int inff_et_get_scount(struct net_device *dev, int sset)
+{
+	u16 array_size;
+	struct inff_if *ifp = netdev_priv(dev);
+	struct inff_pub *drvr = ifp->drvr;
+
+	if (sset == ETH_SS_STATS) {
+		switch (drvr->cnt_ver) {
+		case CNT_VER_6:
+			array_size = ARRAY_SIZE(fmac_ethtool_string_stats_v6);
+			break;
+		case CNT_VER_10:
+			array_size = ARRAY_SIZE(fmac_ethtool_string_stats_v10);
+			break;
+		case CNT_VER_30:
+			array_size = ARRAY_SIZE(fmac_ethtool_string_stats_v30);
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
+	.get_strings		= inff_et_get_strings,
+	.get_ethtool_stats	= inff_et_get_stats,
+	.get_sset_count		= inff_et_get_scount,
+};
+
+static int inff_netdev_stop(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
+
+	inff_cfg80211_down(ndev);
+
+	inff_net_setcarrier(ifp, false);
+
+	return 0;
+}
+
+static int inff_netdev_open(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_bus *bus_if = drvr->bus_if;
+	u32 toe_ol;
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
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
+	if (inff_fil_iovar_int_get(ifp, "toe_ol", &toe_ol) >= 0 &&
+	    (toe_ol & TOE_TX_CSUM_OL) != 0)
+		ndev->features |= NETIF_F_IP_CSUM;
+	else
+		ndev->features &= ~NETIF_F_IP_CSUM;
+
+	if (inff_cfg80211_up(ndev)) {
+		iphy_err(drvr, "failed to bring up cfg80211\n");
+		return -EIO;
+	}
+
+	/* Clear, carrier, set when connected or AP mode. */
+	netif_carrier_off(ndev);
+	return 0;
+}
+
+#ifdef CONFIG_INFFMAC_PCIE
+static int inff_netdev_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
+{
+	return inff_xdp_bpf_cmd(ndev, bpf);
+}
+#endif /* CONFIG_INFFMAC_PCIE */
+
+static const struct net_device_ops inff_netdev_ops_pri = {
+	.ndo_open = inff_netdev_open,
+	.ndo_stop = inff_netdev_stop,
+	.ndo_start_xmit = inff_netdev_start_xmit,
+	.ndo_set_mac_address = inff_netdev_set_mac_address,
+	.ndo_set_rx_mode = inff_netdev_set_multicast_list,
+#ifdef CONFIG_INFFMAC_PCIE
+	.ndo_bpf = inff_netdev_bpf,
+#endif /* CONFIG_INFFMAC_PCIE */
+};
+
+int inff_net_attach(struct inff_if *ifp, bool locked)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct net_device *ndev;
+	s32 err;
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d mac=%pM\n", ifp->bsscfgidx,
+		 ifp->mac_addr);
+	ndev = ifp->ndev;
+
+	/* set appropriate operations */
+	ndev->netdev_ops = &inff_netdev_ops_pri;
+
+	ndev->needed_headroom += drvr->hdrlen;
+	ndev->ethtool_ops = &inff_ethtool_ops;
+
+	/* set the mac address & netns */
+	eth_hw_addr_set(ndev, ifp->mac_addr);
+	dev_net_set(ndev, wiphy_net(cfg_to_wiphy(drvr->config)));
+
+	INIT_WORK(&ifp->multicast_work, _inff_set_multicast_list);
+	INIT_WORK(&ifp->ndoffload_work, inff_update_ipv6_addr);
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
+	ndev->priv_destructor = inff_cfg80211_free_netdev;
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
+		inff_cfg80211_free_netdev(ndev);
+		free_netdev(ndev);
+	}
+}
+
+static int inff_net_mon_open(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	u32 monitor;
+	int err;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	err = inff_fil_cmd_int_get(ifp, INFF_C_GET_MONITOR, &monitor);
+	if (err) {
+		iphy_err(drvr, "INFF_C_GET_MONITOR error (%d)\n", err);
+		return err;
+	} else if (monitor) {
+		iphy_err(drvr, "Monitor mode is already enabled\n");
+		return -EEXIST;
+	}
+
+	monitor = 3;
+	err = inff_fil_cmd_int_set(ifp, INFF_C_SET_MONITOR, monitor);
+	if (err)
+		iphy_err(drvr, "INFF_C_SET_MONITOR error (%d)\n", err);
+
+	return err;
+}
+
+static int inff_net_mon_stop(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	u32 monitor;
+	int err;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	monitor = 0;
+	err = inff_fil_cmd_int_set(ifp, INFF_C_SET_MONITOR, monitor);
+	if (err)
+		iphy_err(drvr, "INFF_C_SET_MONITOR error (%d)\n", err);
+
+	return err;
+}
+
+static netdev_tx_t inff_net_mon_start_xmit(struct sk_buff *skb,
+					   struct net_device *ndev)
+{
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops inff_netdev_ops_mon = {
+	.ndo_open = inff_net_mon_open,
+	.ndo_stop = inff_net_mon_stop,
+	.ndo_start_xmit = inff_net_mon_start_xmit,
+};
+
+int inff_net_mon_attach(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct net_device *ndev;
+	int err;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	ndev = ifp->ndev;
+	ndev->netdev_ops = &inff_netdev_ops_mon;
+
+	err = cfg80211_register_netdevice(ndev);
+	if (err)
+		iphy_err(drvr, "Failed to register %s device\n", ndev->name);
+
+	return err;
+}
+
+void inff_net_setcarrier(struct inff_if *ifp, bool on)
+{
+	struct net_device *ndev;
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d carrier=%d\n", ifp->bsscfgidx,
+		 on);
+
+	ndev = ifp->ndev;
+	inff_txflowblock_if(ifp, INFF_NETIF_STOP_REASON_DISCONNECTED, !on);
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
+static int inff_net_p2p_open(struct net_device *ndev)
+{
+	inff_dbg(TRACE, "Enter\n");
+
+	return inff_cfg80211_up(ndev);
+}
+
+static int inff_net_p2p_stop(struct net_device *ndev)
+{
+	inff_dbg(TRACE, "Enter\n");
+
+	return inff_cfg80211_down(ndev);
+}
+
+static netdev_tx_t inff_net_p2p_start_xmit(struct sk_buff *skb,
+					   struct net_device *ndev)
+{
+	if (skb)
+		dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops inff_netdev_ops_p2p = {
+	.ndo_open = inff_net_p2p_open,
+	.ndo_stop = inff_net_p2p_stop,
+	.ndo_start_xmit = inff_net_p2p_start_xmit
+};
+
+static int inff_net_p2p_attach(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct net_device *ndev;
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d mac=%pM\n", ifp->bsscfgidx,
+		 ifp->mac_addr);
+	ndev = ifp->ndev;
+
+	ndev->netdev_ops = &inff_netdev_ops_p2p;
+
+	/* set the mac address */
+	eth_hw_addr_set(ndev, ifp->mac_addr);
+
+	if (register_netdev(ndev) != 0) {
+		iphy_err(drvr, "couldn't register the p2p net device\n");
+		goto fail;
+	}
+
+	inff_dbg(INFO, "%s: Infineon Dongle Host Driver\n", ndev->name);
+
+	return 0;
+
+fail:
+	ifp->drvr->iflist[ifp->bsscfgidx] = NULL;
+	ndev->netdev_ops = NULL;
+	return -EBADE;
+}
+
+struct inff_if *inff_add_if(struct inff_pub *drvr, s32 bsscfgidx, s32 ifidx,
+			    const char *name, u8 *mac_addr, bool is_p2pdev,
+			    bool is_wlan_sensedev)
+{
+	struct inff_if *ifp;
+	struct net_device *ndev;
+
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d, ifidx=%d\n", bsscfgidx, ifidx);
+
+	ifp = drvr->iflist[bsscfgidx];
+	/*
+	 * Delete the existing interface before overwriting it
+	 * in case we missed the INFF_E_IF_DEL event.
+	 */
+	if (ifp) {
+		if (ifidx) {
+			iphy_err(drvr, "ERROR: netdev:%s already exists\n",
+				 ifp->ndev->name);
+			netif_stop_queue(ifp->ndev);
+			inff_net_detach(ifp->ndev, false);
+			drvr->iflist[bsscfgidx] = NULL;
+		} else {
+			inff_dbg(INFO, "netdev:%s ignore IF event\n",
+				 ifp->ndev->name);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	if ((!drvr->settings->p2p_enable && is_p2pdev) ||
+	    is_wlan_sensedev) {
+		/* this is a P2P/WLAN Sense device interface */
+		inff_dbg(INFO, "allocate non-netdev interface\n");
+		ifp = kzalloc(sizeof(*ifp), GFP_KERNEL);
+		if (!ifp)
+			return ERR_PTR(-ENOMEM);
+	} else {
+		inff_dbg(INFO, "allocate netdev interface\n");
+		/* Allocate netdev, including space for private structure */
+		ndev = alloc_netdev(sizeof(*ifp), is_p2pdev ? "p2p%d" : name,
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
+	}
+
+	ifp->drvr = drvr;
+	drvr->iflist[bsscfgidx] = ifp;
+	ifp->ifidx = ifidx;
+	ifp->bsscfgidx = bsscfgidx;
+
+	init_waitqueue_head(&ifp->pend_8021x_wait);
+	spin_lock_init(&ifp->netif_stop_lock);
+	INFF_IF_STA_LIST_LOCK_INIT(ifp);
+	 /* Initialize STA info list */
+	INIT_LIST_HEAD(&ifp->sta_list);
+
+	spin_lock_init(&ifp->twt_sess_list_lock);
+	 /* Initialize TWT Session list */
+	INIT_LIST_HEAD(&ifp->twt_sess_list);
+	/* Setup the aperiodic TWT Session cleanup activity */
+	timer_setup(&ifp->twt_evt_timeout, inff_twt_event_timeout_handler, 0);
+
+	if (mac_addr)
+		memcpy(ifp->mac_addr, mac_addr, ETH_ALEN);
+
+	inff_dbg(TRACE, " ==== pid:%x, if:%s (%pM) created ===\n",
+		 current->pid, name, ifp->mac_addr);
+
+	return ifp;
+}
+
+static void inff_del_if(struct inff_pub *drvr, s32 bsscfgidx,
+			bool locked)
+{
+	struct inff_if *ifp;
+	int ifidx;
+
+	ifp = drvr->iflist[bsscfgidx];
+	if (!ifp) {
+		iphy_err(drvr, "Null interface, bsscfgidx=%d\n", bsscfgidx);
+		return;
+	}
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d, ifidx=%d\n", bsscfgidx,
+		 ifp->ifidx);
+	ifidx = ifp->ifidx;
+
+	/* Stop the aperiodic TWT Session cleanup activity */
+	if (timer_pending(&ifp->twt_evt_timeout))
+		timer_delete_sync(&ifp->twt_evt_timeout);
+
+	if (ifp->ndev) {
+		if (bsscfgidx == 0) {
+			if (ifp->ndev->netdev_ops == &inff_netdev_ops_pri) {
+				rtnl_lock();
+				inff_netdev_stop(ifp->ndev);
+				rtnl_unlock();
+			}
+		} else {
+			netif_stop_queue(ifp->ndev);
+		}
+
+		if (ifp->ndev->netdev_ops == &inff_netdev_ops_pri) {
+			cancel_work_sync(&ifp->multicast_work);
+			cancel_work_sync(&ifp->ndoffload_work);
+		}
+		inff_net_detach(ifp->ndev, locked);
+	} else {
+		switch (ifp->vif->wdev.iftype) {
+		case NL80211_IFTYPE_P2P_DEVICE:
+			/* Only p2p device interfaces which get dynamically created
+			 * end up here. In this case the p2p module should be informed
+			 * about the removal of the interface within the firmware. If
+			 * not then p2p commands towards the firmware will cause some
+			 * serious troublesome side effects. The p2p module will clean
+			 * up the ifp if needed.
+			 */
+			inff_p2p_ifp_removed(ifp, locked);
+			break;
+		case NL80211_IFTYPE_WLAN_SENSE:
+			inff_wlan_sense_ifp_removed(ifp, locked);
+			break;
+		default:
+			inff_dbg(TRACE, "Unknown wdev iface type");
+		}
+
+		kfree(ifp);
+	}
+
+	drvr->iflist[bsscfgidx] = NULL;
+	if (drvr->if2bss[ifidx] == bsscfgidx)
+		drvr->if2bss[ifidx] = INFF_BSSIDX_INVALID;
+}
+
+void inff_remove_interface(struct inff_if *ifp, bool locked)
+{
+	if (!ifp || !(ifp->drvr) || WARN_ON(ifp->drvr->iflist[ifp->bsscfgidx] != ifp)) {
+		inff_err("Invalid interface or driver\n");
+		return;
+	}
+	inff_dbg(TRACE, "Enter, bsscfgidx=%d, ifidx=%d\n", ifp->bsscfgidx, ifp->ifidx);
+	inff_proto_del_if(ifp->drvr, ifp);
+	inff_del_if(ifp->drvr, ifp->bsscfgidx, locked);
+}
+
+static int inff_psm_watchdog_notify(struct inff_if *ifp,
+				    const struct inff_event_msg *evtmsg,
+				     void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int err;
+
+	inff_dbg(TRACE, "enter: bsscfgidx=%d\n", ifp->bsscfgidx);
+
+	iphy_err(drvr, "PSM's watchdog has fired!\n");
+
+	err = inff_debug_create_memdump(ifp->drvr->bus_if, data,
+					evtmsg->datalen);
+	if (err)
+		iphy_err(drvr, "Failed to get memory dump, %d\n", err);
+
+	return err;
+}
+
+#ifdef CONFIG_INET
+#define ARPOL_MAX_ENTRIES	8
+static int inff_inetaddr_changed(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct inff_pub *drvr = container_of(nb, struct inff_pub,
+					     inetaddr_notifier);
+	struct in_ifaddr *ifa = data;
+	struct net_device *ndev = ifa->ifa_dev->dev;
+	struct inff_if *ifp;
+	int idx, i = 0, ret;
+	u32 val;
+	__be32 addr_table[ARPOL_MAX_ENTRIES] = {0};
+
+	/* Find out if the notification is meant for us */
+	for (idx = 0; idx < INFF_MAX_IFS; idx++) {
+		ifp = drvr->iflist[idx];
+		if (ifp && ifp->ndev == ndev)
+			break;
+		if (idx == INFF_MAX_IFS - 1)
+			return NOTIFY_DONE;
+	}
+
+	if (!inff_feat_is_enabled(ifp, INFF_FEAT_OFFLOADS)) {
+		/* check if arp offload is supported */
+		ret = inff_fil_iovar_int_get(ifp, "arpoe", &val);
+		if (ret)
+			return NOTIFY_OK;
+
+		/* old version only support primary index */
+		ret = inff_fil_iovar_int_get(ifp, "arp_version", &val);
+		if (ret)
+			val = 1;
+		if (val == 1)
+			ifp = drvr->iflist[0];
+
+		/* retrieve the table from firmware */
+		ret = inff_fil_iovar_data_get(ifp, "arp_hostip", addr_table,
+					      sizeof(addr_table));
+		if (ret) {
+			iphy_err(drvr, "fail to get arp ip table err:%d\n", ret);
+			return NOTIFY_OK;
+		}
+
+		for (i = 0; i < ARPOL_MAX_ENTRIES; i++)
+			if (ifa->ifa_address == addr_table[i])
+				break;
+	}
+
+	switch (action) {
+	case NETDEV_UP:
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_OFFLOADS)) {
+			inff_offload_host_ipv4_update(ifp, INFF_OFFLOAD_ARP | INFF_OFFLOAD_ICMP,
+						      ifa->ifa_address, true);
+		} else {
+			if (i == ARPOL_MAX_ENTRIES) {
+				inff_dbg(TRACE, "add %pI4 to arp table\n",
+					 &ifa->ifa_address);
+				/* set it directly */
+				ret = inff_fil_iovar_data_set(ifp, "arp_hostip",
+							      &ifa->ifa_address,
+							      sizeof(ifa->ifa_address));
+				if (ret)
+					iphy_err(drvr, "add arp ip err %d\n", ret);
+			}
+		}
+		break;
+	case NETDEV_DOWN:
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_OFFLOADS)) {
+			inff_offload_host_ipv4_update(ifp, INFF_OFFLOAD_ARP | INFF_OFFLOAD_ICMP,
+						      ifa->ifa_address, false);
+		} else {
+			if (i < ARPOL_MAX_ENTRIES) {
+				addr_table[i] = 0;
+				inff_dbg(TRACE, "remove %pI4 from arp table\n",
+					 &ifa->ifa_address);
+				/* clear the table in firmware */
+				ret = inff_fil_iovar_data_set(ifp, "arp_hostip_clear",
+							      NULL, 0);
+				if (ret) {
+					iphy_err(drvr, "fail to clear arp ip table err:%d\n",
+						 ret);
+					return NOTIFY_OK;
+				}
+				for (i = 0; i < ARPOL_MAX_ENTRIES; i++) {
+					if (addr_table[i] == 0)
+						continue;
+					ret = inff_fil_iovar_data_set(ifp, "arp_hostip",
+								      &addr_table[i],
+								      sizeof(addr_table[i]));
+					if (ret)
+						iphy_err(drvr, "add arp ip err %d\n",
+							 ret);
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int inff_inet6addr_changed(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct inff_pub *drvr = container_of(nb, struct inff_pub,
+					     inet6addr_notifier);
+	struct inet6_ifaddr *ifa = data;
+	struct inff_if *ifp;
+	int i;
+	struct in6_addr *table;
+
+	/* Only handle primary interface */
+	ifp = drvr->iflist[0];
+	if (!ifp)
+		return NOTIFY_DONE;
+	if (ifp->ndev != ifa->idev->dev)
+		return NOTIFY_DONE;
+
+	table = ifp->ipv6_addr_tbl;
+	for (i = 0; i < NDOL_MAX_ENTRIES; i++)
+		if (ipv6_addr_equal(&ifa->addr, &table[i]))
+			break;
+
+	switch (action) {
+	case NETDEV_UP:
+		if (i == NDOL_MAX_ENTRIES) {
+			if (ifp->ipv6addr_idx < NDOL_MAX_ENTRIES) {
+				table[ifp->ipv6addr_idx++] = ifa->addr;
+			} else {
+				for (i = 0; i < NDOL_MAX_ENTRIES - 1; i++)
+					table[i] = table[i + 1];
+				table[NDOL_MAX_ENTRIES - 1] = ifa->addr;
+			}
+		}
+		break;
+	case NETDEV_DOWN:
+		if (i < NDOL_MAX_ENTRIES) {
+			for (; i < ifp->ipv6addr_idx - 1; i++)
+				table[i] = table[i + 1];
+			memset(&table[i], 0, sizeof(table[i]));
+			ifp->ipv6addr_idx--;
+		}
+		break;
+	default:
+		break;
+	}
+
+	schedule_work(&ifp->ndoffload_work);
+
+	return NOTIFY_OK;
+}
+#endif
+
+int inff_fwlog_attach(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	return inff_debug_fwlog_init(drvr);
+}
+
+static int inff_revinfo_read(struct seq_file *s, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(s->private);
+	struct inff_rev_info *ri = &bus_if->drvr->revinfo;
+	char drev[INFF_DOTREV_LEN];
+	char brev[INFF_BOARDREV_LEN];
+
+	seq_printf(s, "vendorid: 0x%04x\n", ri->vendorid);
+	seq_printf(s, "deviceid: 0x%04x\n", ri->deviceid);
+	seq_printf(s, "radiorev: %s\n", inff_dotrev_str(ri->radiorev, drev));
+	seq_printf(s, "chip: %s\n", ri->chipname);
+	seq_printf(s, "chippkg: %u\n", ri->chippkg);
+	seq_printf(s, "corerev: %u\n", ri->corerev);
+	seq_printf(s, "boardid: 0x%04x\n", ri->boardid);
+	seq_printf(s, "boardvendor: 0x%04x\n", ri->boardvendor);
+	seq_printf(s, "boardrev: %s\n", inff_boardrev_str(ri->boardrev, brev));
+	seq_printf(s, "driverrev: %s\n", inff_dotrev_str(ri->driverrev, drev));
+	seq_printf(s, "ucoderev: %u\n", ri->ucoderev);
+	seq_printf(s, "bus: %u\n", ri->bus);
+	seq_printf(s, "phytype: %u\n", ri->phytype);
+	seq_printf(s, "phyrev: %u\n", ri->phyrev);
+	seq_printf(s, "anarev: %u\n", ri->anarev);
+	seq_printf(s, "nvramrev: %08x\n", ri->nvramrev);
+
+	seq_printf(s, "clmver: %s\n", bus_if->drvr->clmver);
+
+	return 0;
+}
+
+static void inff_core_bus_reset(struct work_struct *work)
+{
+	struct inff_pub *drvr = container_of(work, struct inff_pub,
+					     bus_reset);
+
+	inff_bus_reset(drvr->bus_if);
+}
+
+static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct inff_pub *drvr = file->private_data;
+	u8 value;
+
+	if (kstrtou8_from_user(user_buf, count, 0, &value))
+		return -EINVAL;
+
+	if (value != 1)
+		return -EINVAL;
+
+	schedule_work(&drvr->bus_reset);
+
+	return count;
+}
+
+static const struct file_operations bus_reset_fops = {
+	.open	= simple_open,
+	.write	= bus_reset_write,
+};
+
+static int inff_bus_started(struct inff_pub *drvr, struct cfg80211_ops *ops)
+{
+	int ret = -1;
+	struct inff_bus *bus_if = drvr->bus_if;
+	struct inff_if *ifp;
+	struct inff_if *p2p_ifp;
+	int i, num;
+
+	inff_dbg(TRACE, "\n");
+
+	/* add primary networking interface */
+	ifp = inff_add_if(drvr, 0, 0, "wlan%d",
+			  is_valid_ether_addr(drvr->settings->mac) ?
+			  drvr->settings->mac : NULL, false, false);
+	if (IS_ERR(ifp))
+		return PTR_ERR(ifp);
+
+	p2p_ifp = NULL;
+
+	/* signal bus ready */
+	inff_bus_change_state(bus_if, INFF_BUS_UP);
+
+	/* do bus specific preinit here */
+	ret = inff_bus_preinit(bus_if);
+	if (ret < 0)
+		goto fail;
+
+	/* Bus is ready, do any initialization */
+	ret = inff_c_preinit_dcmds(ifp);
+	if (ret < 0)
+		goto fail;
+
+	inff_feat_attach(drvr);
+	ret = inff_bus_set_fcmode(bus_if);
+	/* Set fcmode = 0 for PCIe */
+	if (ret < 0)
+		drvr->settings->fcmode = 0;
+
+	ret = inff_proto_init_done(drvr);
+	if (ret < 0)
+		goto fail;
+
+	inff_proto_add_if(drvr, ifp);
+
+	drvr->config = inff_cfg80211_attach(drvr, ops,
+					    drvr->settings->p2p_enable);
+	if (!drvr->config) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	/* update custom DSCP to PRIO mapping */
+	if (drvr->settings->pkt_prio) {
+		drvr->qos_map = kzalloc(sizeof(*drvr->qos_map), GFP_KERNEL);
+		if (!drvr->qos_map) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+		num = sizeof(dscp_excpt) / (sizeof(struct cfg80211_dscp_exception));
+		drvr->qos_map->num_des = num;
+		for (i = 0; i < num; i++) {
+			drvr->qos_map->dscp_exception[i].dscp = dscp_excpt[i].dscp;
+			drvr->qos_map->dscp_exception[i].up = dscp_excpt[i].up;
+		}
+		memcpy(drvr->qos_map->up, dscp_range, sizeof(dscp_range[8]));
+	}
+
+	ret = inff_net_attach(ifp, false);
+
+	if (!ret && drvr->settings->p2p_enable) {
+		p2p_ifp = drvr->iflist[1];
+		if (p2p_ifp)
+			ret = inff_net_p2p_attach(p2p_ifp);
+	}
+
+	if (ret)
+		goto fail;
+
+#ifdef CONFIG_INET
+	drvr->inetaddr_notifier.notifier_call = inff_inetaddr_changed;
+	ret = register_inetaddr_notifier(&drvr->inetaddr_notifier);
+	if (ret)
+		goto fail;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	drvr->inet6addr_notifier.notifier_call = inff_inet6addr_changed;
+	ret = register_inet6addr_notifier(&drvr->inet6addr_notifier);
+	if (ret) {
+		unregister_inetaddr_notifier(&drvr->inetaddr_notifier);
+		goto fail;
+	}
+#endif
+#endif /* CONFIG_INET */
+
+	INIT_WORK(&drvr->bus_reset, inff_core_bus_reset);
+
+	/* populate debugfs */
+	inff_debugfs_add_entry(drvr, "revinfo", inff_revinfo_read);
+	inff_debugfs_add_entry(drvr, "parameter", inff_debugfs_param_read);
+	debugfs_create_file("reset", 0600, inff_debugfs_get_devdir(drvr), drvr,
+			    &bus_reset_fops);
+	inff_feat_debugfs_create(drvr);
+	inff_proto_debugfs_create(drvr);
+	inff_bus_debugfs_create(bus_if);
+	inff_twt_debugfs_create(drvr);
+	inff_pmsr_debugfs_create(drvr);
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+	inff_btsdio_debugfs_create(drvr);
+#endif
+	return 0;
+
+fail:
+	iphy_err(drvr, "failed: %d\n", ret);
+	if (drvr->config) {
+		inff_cfg80211_detach(drvr->config);
+		drvr->config = NULL;
+	}
+	inff_net_detach(ifp->ndev, false);
+	if (p2p_ifp)
+		inff_net_detach(p2p_ifp->ndev, false);
+	drvr->iflist[0] = NULL;
+	drvr->iflist[1] = NULL;
+	if (drvr->settings->ignore_probe_fail)
+		ret = 0;
+
+	return ret;
+}
+
+int inff_alloc(struct device *dev, struct inff_mp_device *settings)
+{
+	struct wiphy *wiphy;
+	struct cfg80211_ops *ops;
+	struct inff_pub *drvr = NULL;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	ops = inff_cfg80211_get_ops(settings);
+	if (!ops)
+		return -ENOMEM;
+
+	wiphy = wiphy_new(ops, sizeof(*drvr));
+	if (!wiphy) {
+		kfree(ops);
+		return -ENOMEM;
+	}
+
+	set_wiphy_dev(wiphy, dev);
+	drvr = wiphy_priv(wiphy);
+	drvr->wiphy = wiphy;
+	drvr->ops = ops;
+	drvr->bus_if = dev_get_drvdata(dev);
+	drvr->bus_if->drvr = drvr;
+	drvr->settings = settings;
+
+	return 0;
+}
+
+int inff_attach(struct device *dev, bool start_bus)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	int ret = 0;
+	int i;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	/* Initialize logger */
+	ret = inff_logger_attach(drvr, drvr->settings->logger_level,
+				 drvr->settings->logring_depth);
+	if (ret != 0)
+		goto fail;
+
+	for (i = 0; i < ARRAY_SIZE(drvr->if2bss); i++)
+		drvr->if2bss[i] = INFF_BSSIDX_INVALID;
+
+	mutex_init(&drvr->proto_block);
+
+	/* Link to bus module */
+	drvr->hdrlen = 0;
+
+	drvr->req_mpc = 1;
+	/* Attach and link in the protocol */
+	ret = inff_proto_attach(drvr);
+	if (ret != 0) {
+		iphy_err(drvr, "inff_prot_attach failed\n");
+		goto fail;
+	}
+
+	/* Attach to events important for core code */
+	inff_fweh_register(drvr, INFF_E_PSM_WATCHDOG,
+			   inff_psm_watchdog_notify);
+
+	/* attach firmware event handler */
+	inff_fweh_attach(drvr);
+
+	if (start_bus) {
+		ret = inff_bus_started(drvr, drvr->ops);
+		if (ret != 0) {
+			iphy_err(drvr, "dongle is not responding: err=%d\n",
+				 ret);
+			goto fail;
+		}
+	}
+
+	/* Initialize XDP */
+	ret = inff_proto_xdp_init(drvr, inff_get_ifp(drvr, 0));
+	if (ret != 0)
+		goto fail;
+#ifdef CONFIG_INFFMAC_SDIO
+	/* Initialize DFU */
+	ret = inff_dfu_attach(drvr);
+	if (ret != 0)
+		goto fail;
+#endif /* CONFIG_INFFMAC_SDIO */
+	return 0;
+fail:
+	inff_detach(dev);
+
+	return ret;
+}
+
+void inff_bus_add_txhdrlen(struct device *dev, uint len)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	if (drvr)
+		drvr->hdrlen += len;
+}
+
+void inff_dev_reset(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	if (!drvr)
+		return;
+
+	if (drvr->iflist[0])
+		inff_fil_cmd_int_set(drvr->iflist[0], INFF_C_TERMINATED, 1);
+}
+
+void inff_dev_coredump(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+
+	if (inff_debug_create_memdump(bus_if, NULL, 0) < 0)
+		inff_dbg(TRACE, "failed to create coredump\n");
+}
+
+void inff_fw_crashed(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	iphy_err(drvr, "Firmware has halted or crashed\n");
+
+	inff_dev_coredump(dev);
+
+	if (drvr->bus_reset.func)
+		schedule_work(&drvr->bus_reset);
+}
+
+void inff_detach(struct device *dev)
+{
+	s32 i;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	if (!drvr)
+		return;
+
+#ifdef CONFIG_INET
+	unregister_inetaddr_notifier(&drvr->inetaddr_notifier);
+#endif
+
+#if IS_ENABLED(CONFIG_IPV6)
+	unregister_inet6addr_notifier(&drvr->inet6addr_notifier);
+#endif
+#ifdef CONFIG_INFFMAC_SDIO
+	inff_dfu_detach(drvr);
+#endif /* CONFIG_INFFMAC_SDIO */
+	inff_bus_change_state(bus_if, INFF_BUS_DOWN);
+	/* make sure primary interface removed last */
+	for (i = INFF_MAX_IFS - 1; i > -1; i--) {
+		if (drvr->iflist[i])
+			inff_remove_interface(drvr->iflist[i], false);
+	}
+	inff_bus_stop(drvr->bus_if);
+
+	if (drvr->settings->pkt_prio) {
+		kfree(drvr->qos_map);
+		drvr->qos_map = NULL;
+	}
+
+	inff_proto_xdp_deinit(drvr);
+	inff_fweh_detach(drvr);
+	inff_proto_detach(drvr);
+	inff_logger_detach(drvr);
+
+	if (drvr->mon_if) {
+		inff_net_detach(drvr->mon_if->ndev, false);
+		drvr->mon_if = NULL;
+	}
+
+	if (drvr->config) {
+		kfree(drvr->config->pfn_data.network_blob_data);
+		inff_p2p_detach(&drvr->config->p2p);
+		inff_cfg80211_detach(drvr->config);
+		drvr->config = NULL;
+	}
+}
+
+void inff_free(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	if (!drvr)
+		return;
+
+	bus_if->drvr = NULL;
+
+	kfree(drvr->ops);
+
+	wiphy_free(drvr->wiphy);
+}
+
+s32 inff_iovar_data_set(struct device *dev, char *name, void *data, u32 len)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_if *ifp = bus_if->drvr->iflist[0];
+
+	return inff_fil_iovar_data_set(ifp, name, data, len);
+}
+
+static int inff_get_pend_8021x_cnt(struct inff_if *ifp)
+{
+	return atomic_read(&ifp->pend_8021x_cnt);
+}
+
+int inff_netdev_wait_pend8021x(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int err;
+
+	err = wait_event_timeout(ifp->pend_8021x_wait,
+				 !inff_get_pend_8021x_cnt(ifp),
+				 MAX_WAIT_FOR_8021X_TX);
+
+	if (!err) {
+		iphy_err(drvr, "Timed out waiting for no pending 802.1x packets\n");
+		atomic_set(&ifp->pend_8021x_cnt, 0);
+	}
+
+	return !err;
+}
+
+void inff_bus_change_state(struct inff_bus *bus, enum inff_bus_state state)
+{
+	struct inff_pub *drvr = bus->drvr;
+	struct net_device *ndev;
+	int ifidx;
+
+	inff_dbg(TRACE, "%d -> %d\n", bus->state, state);
+
+	if (!drvr) {
+		inff_dbg(INFO, "ignoring transition, bus not attached yet\n");
+		return;
+	}
+
+	bus->state = state;
+
+	if (state == INFF_BUS_UP) {
+		for (ifidx = 0; ifidx < INFF_MAX_IFS; ifidx++) {
+			if (drvr->iflist[ifidx] &&
+			    drvr->iflist[ifidx]->ndev) {
+				ndev = drvr->iflist[ifidx]->ndev;
+				if (netif_queue_stopped(ndev))
+					netif_wake_queue(ndev);
+			}
+		}
+	}
+}
+
+int __init inff_core_init(void)
+{
+	int err;
+
+	err = inff_sdio_register();
+	if (err)
+		return err;
+
+	err = inff_pcie_register();
+	if (err)
+		goto error_pcie_register;
+	return 0;
+
+error_pcie_register:
+	inff_sdio_exit();
+	return err;
+}
+
+void inff_core_exit(void)
+{
+	inff_sdio_exit();
+	inff_pcie_exit();
+}
+
+int
+inff_pktfilter_add_remove(struct net_device *ndev, int filter_num, bool add)
+{
+	struct inff_if *ifp =  netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_pkt_filter_le *pkt_filter;
+	int filter_fixed_len = offsetof(struct inff_pkt_filter_le, u);
+	int pattern_fixed_len = offsetof(struct inff_pkt_filter_pattern_le,
+				  mask_and_pattern);
+	u16 mask_and_pattern[MAX_PKTFILTER_PATTERN_SIZE];
+	int buflen = 0;
+	int ret = 0;
+
+	inff_dbg(INFO, "%s packet filter number %d\n",
+		 (add ? "add" : "remove"), filter_num);
+
+	pkt_filter = kzalloc(sizeof(*pkt_filter) +
+			(MAX_PKTFILTER_PATTERN_FILL_SIZE), GFP_ATOMIC);
+	if (!pkt_filter)
+		return -ENOMEM;
+
+	switch (filter_num) {
+	case INFF_UNICAST_FILTER_NUM:
+		pkt_filter->id = 100;
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = 1;
+		mask_and_pattern[0] = 0x0001;
+		break;
+	case INFF_BROADCAST_FILTER_NUM:
+		//filter_pattern = "101 0 0 0 0xFFFFFFFFFFFF 0xFFFFFFFFFFFF";
+		pkt_filter->id = 101;
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = 6;
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0xFFFF;
+		mask_and_pattern[2] = 0xFFFF;
+		mask_and_pattern[3] = 0xFFFF;
+		mask_and_pattern[4] = 0xFFFF;
+		mask_and_pattern[5] = 0xFFFF;
+		break;
+	case INFF_MULTICAST4_FILTER_NUM:
+		//filter_pattern = "102 0 0 0 0xFFFFFF 0x01005E";
+		pkt_filter->id = 102;
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = 3;
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0x01FF;
+		mask_and_pattern[2] = 0x5E00;
+		break;
+	case INFF_MULTICAST6_FILTER_NUM:
+		//filter_pattern = "103 0 0 0 0xFFFF 0x3333";
+		pkt_filter->id = 103;
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = 2;
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0x3333;
+		break;
+	case INFF_MDNS_FILTER_NUM:
+		//filter_pattern = "104 0 0 0 0xFFFFFFFFFFFF 0x01005E0000FB";
+		pkt_filter->id = 104;
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = 6;
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0xFFFF;
+		mask_and_pattern[2] = 0xFFFF;
+		mask_and_pattern[3] = 0x0001;
+		mask_and_pattern[4] = 0x005E;
+		mask_and_pattern[5] = 0xFB00;
+		break;
+	case INFF_ARP_FILTER_NUM:
+		//filter_pattern = "105 0 0 12 0xFFFF 0x0806";
+		pkt_filter->id = 105;
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 12;
+		pkt_filter->u.pattern.size_bytes = 2;
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0x0608;
+		break;
+	case INFF_BROADCAST_ARP_FILTER_NUM:
+		//filter_pattern = "106 0 0 0
+		//0xFFFFFFFFFFFF0000000000000806
+		//0xFFFFFFFFFFFF0000000000000806";
+		pkt_filter->id = 106;
+		pkt_filter->type = 0;
+		pkt_filter->negate_match = 0;
+		pkt_filter->u.pattern.offset = 0;
+		pkt_filter->u.pattern.size_bytes = 14;
+		mask_and_pattern[0] = 0xFFFF;
+		mask_and_pattern[1] = 0xFFFF;
+		mask_and_pattern[2] = 0xFFFF;
+		mask_and_pattern[3] = 0x0000;
+		mask_and_pattern[4] = 0x0000;
+		mask_and_pattern[5] = 0x0000;
+		mask_and_pattern[6] = 0x0608;
+		mask_and_pattern[7] = 0xFFFF;
+		mask_and_pattern[8] = 0xFFFF;
+		mask_and_pattern[9] = 0xFFFF;
+		mask_and_pattern[10] = 0x0000;
+		mask_and_pattern[11] = 0x0000;
+		mask_and_pattern[12] = 0x0000;
+		mask_and_pattern[13] = 0x0608;
+		break;
+	default:
+		ret = -EINVAL;
+		goto failed;
+	}
+	memcpy(pkt_filter->u.pattern.mask_and_pattern, mask_and_pattern,
+	       pkt_filter->u.pattern.size_bytes * 2);
+	buflen = filter_fixed_len + pattern_fixed_len +
+		  pkt_filter->u.pattern.size_bytes * 2;
+
+	if (add) {
+		/* Add filter */
+		ifp->fwil_fwerr = true;
+		ret = inff_fil_iovar_data_set(ifp, "pkt_filter_add",
+					      pkt_filter, buflen);
+		ifp->fwil_fwerr = false;
+		if (ret)
+			goto failed;
+		drvr->pkt_filter[filter_num].id = pkt_filter->id;
+		drvr->pkt_filter[filter_num].enable  = 0;
+
+	} else {
+		/* Delete filter */
+		ifp->fwil_fwerr = true;
+		ret = inff_fil_iovar_int_set(ifp, "pkt_filter_delete",
+					     pkt_filter->id);
+		ifp->fwil_fwerr = false;
+		if (ret == -INFF_FW_BADARG)
+			ret = 0;
+		if (ret)
+			goto failed;
+
+		drvr->pkt_filter[filter_num].id = 0;
+		drvr->pkt_filter[filter_num].enable  = 0;
+	}
+failed:
+	if (ret)
+		inff_err("%s packet filter failed, ret=%d\n",
+			 (add ? "add" : "remove"), ret);
+
+	kfree(pkt_filter);
+	return ret;
+}
+
+int inff_pktfilter_enable(struct net_device *ndev, bool enable)
+{
+	struct inff_if *ifp =  netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	int ret = 0;
+	int idx = 0;
+
+	for (idx = 0; idx < MAX_PKT_FILTER_COUNT; ++idx) {
+		if (drvr->pkt_filter[idx].id != 0) {
+			drvr->pkt_filter[idx].enable = enable;
+			ret = inff_fil_iovar_data_set(ifp, "pkt_filter_enable",
+						      &drvr->pkt_filter[idx],
+				sizeof(struct inff_pkt_filter_enable_le));
+			if (ret) {
+				inff_err("%s packet filter id(%d) failed, ret=%d\n",
+					 (enable ? "enable" : "disable"),
+					 drvr->pkt_filter[idx].id, ret);
+			}
+		}
+	}
+	return ret;
+}
+
+/** Find STA with MAC address ea in an interface's STA list. */
+struct inff_sta *
+inff_find_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta  *sta;
+	unsigned long flags;
+
+	INFF_IF_STA_LIST_LOCK(ifp, flags);
+	list_for_each_entry(sta, &ifp->sta_list, list) {
+		if (!memcmp(sta->ea.octet, ea, ETH_ALEN)) {
+			inff_dbg(INFO, "Found STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x into sta list\n",
+				 sta->ea.octet[0], sta->ea.octet[1],
+				 sta->ea.octet[2], sta->ea.octet[3],
+				 sta->ea.octet[4], sta->ea.octet[5]);
+			INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+			return sta;
+		}
+	}
+	INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+
+	return INFF_STA_NULL;
+}
+
+/** Add STA into the interface's STA list. */
+static struct inff_sta *
+inff_add_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta *sta;
+	unsigned long flags;
+
+	sta =  kzalloc(sizeof(*sta), GFP_KERNEL);
+	if (sta == INFF_STA_NULL) {
+		inff_err("Alloc failed\n");
+		return INFF_STA_NULL;
+	}
+	memcpy(sta->ea.octet, ea, ETH_ALEN);
+	inff_dbg(INFO, "Add STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x into sta list\n",
+		 sta->ea.octet[0], sta->ea.octet[1],
+		 sta->ea.octet[2], sta->ea.octet[3],
+		 sta->ea.octet[4], sta->ea.octet[5]);
+
+	/* link the sta and the inff_if interface */
+	sta->ifp = ifp;
+	INIT_LIST_HEAD(&sta->list);
+
+	INFF_IF_STA_LIST_LOCK(ifp, flags);
+
+	list_add_tail(&sta->list, &ifp->sta_list);
+
+	INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+	return sta;
+}
+
+/** Delete STA from the interface's STA list. */
+void
+inff_del_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta *sta, *next;
+	unsigned long flags;
+
+	INFF_IF_STA_LIST_LOCK(ifp, flags);
+	list_for_each_entry_safe(sta, next, &ifp->sta_list, list) {
+		if (!memcmp(sta->ea.octet, ea, ETH_ALEN)) {
+			inff_dbg(INFO, "del STA: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x from sta list\n",
+				 ea[0], ea[1], ea[2], ea[3],
+				 ea[4], ea[5]);
+			list_del(&sta->list);
+			kfree(sta);
+		}
+	}
+
+	INFF_IF_STA_LIST_UNLOCK(ifp, flags);
+}
+
+/** Add STA if it doesn't exist. Not reentrant. */
+struct inff_sta*
+inff_findadd_sta(struct inff_if *ifp, const u8 *ea)
+{
+	struct inff_sta *sta = NULL;
+
+	sta = inff_find_sta(ifp, ea);
+
+	if (!sta) {
+		/* Add entry */
+		sta = inff_add_sta(ifp, ea);
+	}
+	return sta;
+}
+
+s32
+inff_set_channel(struct inff_cfg80211_info *cfg, struct ieee80211_channel *chan)
+{
+	u16 chspec = 0;
+	int err = 0;
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+
+	if (chan->flags & IEEE80211_CHAN_DISABLED)
+		return -EINVAL;
+
+	/* set_channel */
+	chspec = channel_to_chanspec(&cfg->d11inf, chan);
+	if (chspec != INVCHANSPEC) {
+		err = inff_fil_iovar_int_set(ifp, "chanspec", chspec);
+		if (err) {
+			inff_err("set chanspec 0x%04x fail, reason %d\n", chspec, err);
+			err = -EINVAL;
+		}
+	} else {
+		inff_err("failed to convert host chanspec to fw chanspec\n");
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+s32 inff_mchan_config(struct inff_cfg80211_info *cfg)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp;
+	int ifidx = 0;
+	s32 err = 0;
+	struct inff_assoclist_le assoclist = {0};
+	u8 mac_addr[ETH_ALEN] = {0}, mac_null[ETH_ALEN] = {0};
+	u32 mchan_arg = 0;
+	bool staif_connected = false, apif_connected = false;
+
+	if (!inff_feat_is_enabled(drvr->iflist[0], INFF_FEAT_MCHAN_CONFIG))
+		return 0;
+
+	for (ifidx = 0; ifidx < INFF_MAX_IFS; ifidx++) {
+		ifp = drvr->iflist[ifidx];
+		if (ifp && ifp->vif) {
+			if (ifp->vif->wdev.iftype == NL80211_IFTYPE_STATION) {
+				err = inff_fil_cmd_data_get(ifp, INFF_C_GET_BSSID, &mac_addr,
+							    sizeof(mac_addr));
+				if (err)
+					iphy_err(drvr, "INFF_C_GET_BSSID fail (%d)\n", err);
+				else if (memcmp(mac_null, mac_addr, ETH_ALEN))
+					staif_connected = true;
+			} else if (ifp->vif->wdev.iftype == NL80211_IFTYPE_AP) {
+				memset(&assoclist, 0, sizeof(assoclist));
+				assoclist.count = cpu_to_le32(INFF_MAX_ASSOCLIST);
+				err = inff_fil_cmd_data_get(ifp, INFF_C_GET_ASSOCLIST,
+							    &assoclist,
+							    sizeof(assoclist));
+				if (err)
+					iphy_err(drvr, "INFF_C_GET_ASSOCLIST fail (%d)\n", err);
+				else if (assoclist.count > 0)
+					apif_connected = true;
+			}
+		}
+	}
+
+	if (staif_connected && apif_connected) {
+		inff_dbg(TRACE, "apsta case, set mchan config %d\n", cfg->mchan_conf);
+		switch (cfg->mchan_conf) {
+		case INFF_MCHAN_CONF_DEFAULT:
+			mchan_arg = INFF_MCHAN_SI_ALGO;
+			err = inff_fil_iovar_data_set(drvr->iflist[0], "mchan_algo",
+						      &mchan_arg, sizeof(mchan_arg));
+			break;
+		case INFF_MCHAN_CONF_VEDIO:
+			mchan_arg = INFF_MCHAN_ASYMMETRIC_SI_ALGO;
+			err = inff_fil_iovar_data_set(drvr->iflist[0], "mchan_algo",
+						      &mchan_arg, sizeof(mchan_arg));
+			break;
+		case INFF_MCHAN_CONF_AUDIO:
+			mchan_arg = INFF_MCHAN_BANDWIDTH_ALGO;
+			err = inff_fil_iovar_data_set(drvr->iflist[0], "mchan_algo",
+						      &mchan_arg, sizeof(mchan_arg));
+			if (err)
+				goto cmd_fail;
+			mchan_arg = INFF_MCHAN_BANDWIDTH_VAL;
+			err = inff_fil_iovar_data_set(drvr->iflist[0], "mchan_bw",
+						      &mchan_arg, sizeof(mchan_arg));
+			break;
+		default:
+			inff_dbg(TRACE, "unexpected mchan conf %d\n", cfg->mchan_conf);
+			break;
+		}
+cmd_fail:
+		if (err)
+			iphy_err(drvr, "cmd fail while set mchan config (%d)\n", err);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/core.h b/drivers/net/wireless/infineon/inffmac/core.h
new file mode 100644
index 000000000000..a1707ebc69dd
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/core.h
@@ -0,0 +1,355 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_CORE_H
+#define INFF_CORE_H
+
+#include <linux/types.h>
+#include <net/cfg80211.h>
+#include "fweh.h"
+#include "fwil_types.h"
+#include "feature.h"
+#include "logger.h"
+
+/*
+ * Priority definitions according 802.1D
+ */
+#define	PRIO_8021D_NONE		2
+#define	PRIO_8021D_BK		1
+#define	PRIO_8021D_BE		0
+#define	PRIO_8021D_EE		3
+#define	PRIO_8021D_CL		4
+#define	PRIO_8021D_VI		5
+#define	PRIO_8021D_VO		6
+#define	PRIO_8021D_NC		7
+
+#define	MAXPRIO			7
+#define NUMPRIO			(MAXPRIO + 1)
+
+/* DSCP type definitions for RFC4594 */
+/* DF: Standard (RFC2474) */
+#define DSCP_DF		0x00u
+/* AF1x: High-Throughput Data (RFC2597) */
+#define DSCP_AF11	0x0Au
+#define DSCP_AF12	0x0Cu
+#define DSCP_AF13	0x0Eu
+/* CS1: Low-Priority Data (RFC3662) */
+#define DSCP_CS1	0x08u
+/* AF2x: Low-Latency Data (RFC2597) */
+#define DSCP_AF21	0x12u
+#define DSCP_AF22	0x14u
+#define DSCP_AF23	0x16u
+/* CS2: OAM (RFC2474) */
+#define DSCP_CS2	0x10u
+/* AF3x: Multimedia Streaming (RFC2597) */
+#define DSCP_AF31	0x1Au
+#define DSCP_AF32	0x1Cu
+#define DSCP_AF33	0x1Eu
+/* CS3: Broadcast Video (RFC2474) */
+#define DSCP_CS3	0x18u
+/* AF4x: Multimedia Conferencing (RFC2597) */
+#define DSCP_AF41	0x22u
+#define DSCP_AF42	0x24u
+#define DSCP_AF43	0x26u
+/* CS4: Real-Time Interactive (RFC2474) */
+#define DSCP_CS4	0x20u
+/* CS5: Signaling (RFC2474) */
+#define DSCP_CS5	0x28u
+/* VA: VOCIE-ADMIT (RFC5865) */
+#define DSCP_VA		0x2Cu
+/* EF: Telephony (RFC3246) */
+#define DSCP_EF		0x2Eu
+/* CS6: Network Control (RFC2474) */
+#define DSCP_CS6	0x30u
+/* CS7: Network Control (RFC2474) */
+#define DSCP_CS7	0x38u
+
+/* Bit masks for radio disabled status - returned by WL_GET_RADIO */
+
+#define WL_RADIO_SW_DISABLE       BIT(0)
+#define WL_RADIO_HW_DISABLE       BIT(1)
+/* some countries don't support any channel */
+#define WL_RADIO_COUNTRY_DISABLE  BIT(3)
+
+/* Override bit for SET_TXPWR.  if set, ignore other level limits */
+#define WL_TXPWR_OVERRIDE         BIT(31)
+
+/* Values for PM */
+#define PM_OFF	0
+#define PM_MAX	1
+#define PM_FAST 2
+
+/*
+ * Sonics Configuration Space Registers.
+ */
+
+/* core sbconfig regs are top 256bytes of regs */
+#define	SBCONFIGOFF		0xf00
+
+#define TOE_TX_CSUM_OL		0x00000001
+#define TOE_RX_CSUM_OL		0x00000002
+
+/* For supporting multiple interfaces */
+#define INFF_MAX_IFS	16
+
+/* Small, medium and maximum buffer size for dcmd
+ */
+#define INFF_DCMD_SMLEN	256
+#define INFF_DCMD_MEDLEN	1536
+#define INFF_DCMD_MAXLEN	8192
+
+/* IOCTL from host to device are limited in length. A device can only handle
+ * ethernet frame size. This limitation is to be applied by protocol layer.
+ */
+#define INFF_TX_IOCTL_MAX_MSG_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN)
+
+#define INFF_AMPDU_RX_REORDER_MAXFLOWS		256
+
+/* Length of firmware version string stored for
+ * ethtool driver info which uses 32 bytes as well.
+ */
+#define INFF_DRIVER_FIRMWARE_VERSION_LEN	32
+
+#define NDOL_MAX_ENTRIES	8
+
+/**
+ * struct inff_ampdu_rx_reorder - AMPDU receive reorder info
+ *
+ * @flow_id: AMPDU flow identifier.
+ * @cur_idx: last AMPDU index from firmware.
+ * @exp_idx: expected next AMPDU index.
+ * @max_idx: maximum amount of packets per AMPDU.
+ * @pend_pkts: number of packets currently in @pktslots.
+ * @pktslots: array for ordering AMPDU packets.
+ */
+struct inff_ampdu_rx_reorder {
+	u8 flow_id;
+	u8 cur_idx;
+	u8 exp_idx;
+	u8 max_idx;
+	u8 pend_pkts;
+	struct sk_buff *pktslots[];
+};
+
+/* Forward decls for struct inff_pub (see below) */
+struct inff_proto;	/* device communication protocol info */
+struct inff_fws_info;	/* firmware signalling info */
+struct inff_mp_device;	/* module parameters, device specific */
+
+/*
+ * struct inff_rev_info
+ *
+ * The result field stores the error code of the
+ * revision info request from firmware. For the
+ * other fields see struct inff_rev_info_le in
+ * fwil_types.h
+ */
+struct inff_rev_info {
+	int result;
+	u32 vendorid;
+	u32 deviceid;
+	u32 radiorev;
+	u32 corerev;
+	u32 boardid;
+	u32 boardvendor;
+	u32 boardrev;
+	u32 driverrev;
+	u32 ucoderev;
+	u32 bus;
+	char chipname[12];
+	u32 phytype;
+	u32 phyrev;
+	u32 anarev;
+	u32 chippkg;
+	u32 nvramrev;
+};
+
+/** wlc interface version */
+struct inff_wlc_version {
+	/* wlc interface version numbers */
+	u16	wlc_ver_major;		/**< wlc interface major version number */
+	u16	wlc_ver_minor;		/**< wlc interface minor version number */
+};
+
+/* Common structure for module and instance linkage */
+struct inff_pub {
+	/* Linkage ponters */
+	struct inff_bus *bus_if;
+	struct inff_proto *proto;
+	struct wiphy *wiphy;
+	struct cfg80211_ops *ops;
+	struct inff_cfg80211_info *config;
+
+	/* Internal inff items */
+	uint hdrlen;		/* Total INFF header length (proto + bus) */
+
+	/* Dongle media info */
+	char fwver[INFF_DRIVER_FIRMWARE_VERSION_LEN];
+	u8 mac[ETH_ALEN];		/* MAC address obtained from dongle */
+
+	struct mac_address addresses[INFF_MAX_IFS];
+
+	struct inff_if *iflist[INFF_MAX_IFS];
+	s32 if2bss[INFF_MAX_IFS];
+	struct inff_if *mon_if;
+
+	struct mutex proto_block;	/* used to protect proto resource */
+	unsigned char proto_buf[INFF_DCMD_MAXLEN];
+
+	struct inff_fweh_info fweh;
+
+	struct inff_ampdu_rx_reorder
+		*reorder_flows[INFF_AMPDU_RX_REORDER_MAXFLOWS];
+
+	u8 feat_flags[DIV_ROUND_UP(INFF_FEAT_LAST, 8)];
+	u32 chip_quirks;
+	int req_mpc;
+
+	struct inff_rev_info revinfo;
+	struct inff_wlc_version wlc_ver;
+#ifdef DEBUG
+	struct dentry *dbgfs_dir;
+#endif
+
+	struct notifier_block inetaddr_notifier;
+	struct notifier_block inet6addr_notifier;
+	struct inff_mp_device *settings;
+
+	struct work_struct bus_reset;
+
+	u8 clmver[INFF_DCMD_SMLEN];
+	u8 sta_mac_idx;
+	struct inff_pkt_filter_enable_le pkt_filter[MAX_PKT_FILTER_COUNT];
+	u16 cnt_ver;
+
+	struct cfg80211_qos_map *qos_map;
+	struct inff_logger *logger;
+	struct inff_dfu *dfu;
+};
+
+/* forward declarations */
+struct inff_cfg80211_vif;
+struct inff_fws_mac_descriptor;
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
+/**
+ * struct inff_if - interface control information.
+ *
+ * @drvr: points to device related information.
+ * @vif: points to cfg80211 specific interface information.
+ * @ndev: associated network device.
+ * @multicast_work: worker object for multicast provisioning.
+ * @ndoffload_work: worker object for neighbor discovery offload configuration.
+ * @fws_desc: interface specific firmware-signalling descriptor.
+ * @ifidx: interface index in device firmware.
+ * @bsscfgidx: index of bss associated with this interface.
+ * @mac_addr: assigned mac address.
+ * @netif_stop: bitmap indicates reason why netif queues are stopped.
+ * @netif_stop_lock: spinlock for update netif_stop from multiple sources.
+ * @pend_8021x_cnt: tracks outstanding number of 802.1x frames.
+ * @pend_8021x_wait: used for signalling change in count.
+ * @fwil_fwerr: flag indicating fwil layer should return firmware error codes.
+ * @sta_list: dll of associated stations.
+ * @sta_list_lock: station list lock.
+ * @twt_sess_list: dll of TWT sessions.
+ * @twt_sess_list_lock: TWT session list lock.
+ * @twt_evt_timeout: TWT firmware event timeout.
+ * @fmac_pkt_fwd_en: Driver packet forward enabled for AP Mode.
+ * @napi: NAPI structure for handling the RX packets received on this interface.
+ * @napi_gro: NAPI GRO Receive enabled flag.
+ * @xdp_prog: XDP Program attached to the netdev for native mode execution.
+ */
+struct inff_if {
+	struct inff_pub *drvr;
+	struct inff_cfg80211_vif *vif;
+	struct net_device *ndev;
+	struct work_struct multicast_work;
+	struct work_struct ndoffload_work;
+	struct inff_fws_mac_descriptor *fws_desc;
+	int ifidx;
+	s32 bsscfgidx;
+	bool isap;
+	u8 mac_addr[ETH_ALEN];
+	u8 netif_stop;
+	spinlock_t netif_stop_lock;	/* used to protect netif_stop resource */
+	atomic_t pend_8021x_cnt;
+	wait_queue_head_t pend_8021x_wait;
+	struct in6_addr ipv6_addr_tbl[NDOL_MAX_ENTRIES];
+	u8 ipv6addr_idx;
+	bool fwil_fwerr;
+	struct list_head sta_list;
+	spinlock_t sta_list_lock;	/* used to protect STA list */
+	struct list_head twt_sess_list;
+	spinlock_t twt_sess_list_lock;	/* used to protect TWT session list */
+	struct timer_list twt_evt_timeout;
+	bool fmac_pkt_fwd_en;
+	struct napi_struct napi;
+	bool napi_gro;
+	struct bpf_prog *xdp_prog;
+};
+
+struct ether_addr {
+	u8 octet[ETH_ALEN];
+};
+
+/*
+ * struct inff_sta - Per STA param.
+ *
+ * @ifp: associated inff_if pointer.
+ * @ea: station ethernet MAC address.
+ * @list: link to inff_if::sta_list.
+ */
+struct inff_sta {
+	void *ifp;
+	struct ether_addr ea;
+	struct list_head list;
+};
+
+int inff_netdev_wait_pend8021x(struct inff_if *ifp);
+
+/* Return pointer to interface name */
+char *inff_ifname(struct inff_if *ifp);
+struct inff_if *inff_get_ifp(struct inff_pub *drvr, int ifidx);
+int inff_net_attach(struct inff_if *ifp, bool locked);
+struct inff_if *inff_add_if(struct inff_pub *drvr, s32 bsscfgidx, s32 ifidx,
+			    const char *name, u8 *mac_addr, bool is_p2pdev,
+			    bool is_wlan_sensedev);
+void inff_remove_interface(struct inff_if *ifp, bool locked);
+void inff_txflowblock_if(struct inff_if *ifp,
+			 enum inff_netif_stop_reason reason, bool state);
+void inff_txfinalize(struct inff_if *ifp, struct sk_buff *txp, bool success);
+void inff_netif_rx(struct inff_if *ifp, struct sk_buff *skb, bool inirq);
+void inff_netif_mon_rx(struct inff_if *ifp, struct sk_buff *skb);
+void inff_net_detach(struct net_device *ndev, bool locked);
+int inff_net_mon_attach(struct inff_if *ifp);
+void inff_net_setcarrier(struct inff_if *ifp, bool on);
+int __init inff_core_init(void);
+void inff_core_exit(void);
+int inff_pktfilter_add_remove(struct net_device *ndev, int filter_num,
+			      bool add);
+int inff_pktfilter_enable(struct net_device *ndev, bool enable);
+void inff_del_sta(struct inff_if *ifp, const u8 *ea);
+struct inff_sta *inff_find_sta(struct inff_if *ifp, const u8 *ea);
+struct inff_sta *inff_findadd_sta(struct inff_if *ifp, const u8 *ea);
+
+#endif /* INFF_CORE_H */
-- 
2.25.1


