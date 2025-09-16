Return-Path: <linux-wireless+bounces-27357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1867CB7DAB1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4261916DCCD
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656482E2DF2;
	Tue, 16 Sep 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="BTvriaDH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567412D94B4
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061214; cv=none; b=KrutqYZngrxGEmNtWCvj0FHQieiIS6pft+AIygOKx5Ew24X+D6w4a5LpxZ4+hO9ENeidRNaK5TJ5u2Ll6NZGyRXBixzFzLPZv8mj375EUELkSX6ShaYz/iqmqnClDYEfd5sMTssdnNoSu58xA3/ypFAYSXHlzM90DRWDGcgeqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061214; c=relaxed/simple;
	bh=kUkJTn1FvdwL0/ga3JUhIhLtGQOAqhimuFrkzPhjnrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZPPxSgZ/UTsZt0IWVn81BtBRvsYYW9smiXm2fK4b0v7ZYYRPdF2PYMIC0k2OaJR5jvsgsYzPEaVyh5L5xIeccvTX93etkVznFudKuXNd7M47ANJZFHP4FZtBdg9yVS5cInrzS8d9RRd6ihnAZSQYLUYdK5GCfvMpbiALkacTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=BTvriaDH; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061211; x=1789597211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUkJTn1FvdwL0/ga3JUhIhLtGQOAqhimuFrkzPhjnrI=;
  b=BTvriaDHsersPFoyuswaug5uUUPJ6lo/4XMWmHBq2hIpwTM9GR7gTxig
   171pRckm4Xj5wd+thJ6OQ55qS9Gu6BRMdZC+D6D4Xf7AgQCqwd7bj6+OT
   sp9uhZVQT7fcY2539da/kszLYUoSixRJ1dXC83ltFYklK6375PQlwegux
   A=;
X-CSE-ConnectionGUID: GZOsTZGCRjCXr6Xcxy+tyA==
X-CSE-MsgGUID: uTxVTZ3nSfmiEamdgUh5ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093165"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093165"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:19:00 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:19:00 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:18:57 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 02/57] wifi: nl80211/cfg80211: add support to do WLAN Sensing operation using PMSR
Date: Wed, 17 Sep 2025 03:47:17 +0530
Message-ID: <20250916221821.4387-3-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
 MUCSE827.infineon.com (172.23.29.20)

Introduce a mechanism to initiate WLAN Sensing request to collect the
Channel State Information (CSI) from the WLAN device, by leveraging and
extending the existing Peer Measurement Request (PMSR) infrastructure.
PMSR so far was supporting only one type of peer measurement, which is FTM.

* Allow the driver to register/advertise the WLAN Sensing Measurement
Capabilities of the Device to the userspace through cfg80211.

* Add support to parse the WLAN Sensing Measurement Request params passed
by userspace and send it to the driver using the start_pmsr cfg8021_ops cb.
And let driver return the collected CSI raw data to the userspace using the
cfg80211_pmsr_report() notification.

* Also have a provision for passing vendor-specific params while initiating
the WLAN Sensing Mesaurement request to the driver.

* Add the corresponding nl80211 attributes, struct and enum definitions to
do the above mentioned operations.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 include/linux/ieee80211.h    |   5 ++
 include/net/cfg80211.h       |  84 +++++++++++++++++++-
 include/uapi/linux/nl80211.h | 119 +++++++++++++++++++++++++++++
 net/wireless/core.c          |  93 +++++++++++++++--------
 net/wireless/core.h          |   3 +
 net/wireless/nl80211.c       |  70 +++++++++++++++++
 net/wireless/pmsr.c          | 143 +++++++++++++++++++++++++++++++++++
 7 files changed, 485 insertions(+), 32 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index d350263f23f3..a3a2ac682fd4 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3499,6 +3499,11 @@ ieee80211_bandwidth_indication_size_ok(const u8 *data, u8 len)
 #define WLAN_ERP_USE_PROTECTION (1<<1)
 #define WLAN_ERP_BARKER_PREAMBLE (1<<2)
 
+/* IEEE Std 802.11bf, Sensing Capabilities */
+#define IEEE80211_SENSING_CAPA_MAX_LTF_REP              8
+#define IEEE80211_SENSING_CAPA_MAX_CHAINS               8
+#define IEEE80211_SENSING_CAPA_MAX_MEASUREMENT_INTERVAL 0x7FFFFF
+
 /* WLAN_ERP_BARKER_PREAMBLE values */
 enum {
 	WLAN_ERP_PREAMBLE_SHORT = 0,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d6145556fcf4..4a753d92c2e5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4178,6 +4178,19 @@ struct cfg80211_pmsr_ftm_result {
 	    dist_spread_valid:1;
 };
 
+/**
+ * struct cfg80211_pmsr_sensing_result - Sensing measurement report
+ * @seq_number: sequence number of the sensing measurement report
+ * @data_len: length of @data
+ * @data: raw data of the sensing measurement report whose format is
+ *	defined/parsed by user
+ */
+struct cfg80211_pmsr_sensing_result {
+	u16 seq_number;
+	u32 data_len;
+	u8 *data;
+};
+
 /**
  * struct cfg80211_pmsr_result - peer measurement result
  * @addr: address of the peer
@@ -4192,6 +4205,7 @@ struct cfg80211_pmsr_ftm_result {
  *	one type at a time, but you can report multiple results separately and
  *	they're all aggregated for userspace.
  * @ftm: FTM result
+ * @sensing: Sensing result
  */
 struct cfg80211_pmsr_result {
 	u64 host_time, ap_tsf;
@@ -4206,6 +4220,7 @@ struct cfg80211_pmsr_result {
 
 	union {
 		struct cfg80211_pmsr_ftm_result ftm;
+		struct cfg80211_pmsr_sensing_result sensing;
 	};
 };
 
@@ -4252,18 +4267,60 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 bss_color;
 };
 
+/**
+ * struct cfg80211_pmsr_sensing_request_peer - Sensing request data
+ * @associated: indicates device is in associated state
+ * @interval: interval between two consecutive sensing exchange
+ * @duration: duration of a sensing exchange
+ * @expiry_exp: measurement session expiry exponent
+ * @tx_ltf_rep: TX LTF Repetition
+ * @rx_ltf_rep: RX LTF Repetition
+ * @tx_sts: number of TX space-time streams
+ * @rx_sts: number of RX space-time streams
+ * @num_rx_chains: number of RX chains
+ * @min_interval: minimum measurement interval between two consecutive
+ *	non-TB sensing measurement exchanges
+ * @vendor_req_len: length of @vendor_req
+ *	works only if vendor_mode of sensing capabilities is set
+ * @vendor_req: vendor request block, interpreted by vendor implementation
+ *	works only if vendor_mode of sensing capabilities is set
+ *
+ * See also nl80211 for the respective attribute documentation
+ */
+struct cfg80211_pmsr_sensing_request_peer {
+	u8 associated:1;
+	u32 interval;
+	u16 duration;
+	u8 expiry_exp;
+	u8 tx_ltf_rep;
+	u8 rx_ltf_rep;
+	u8 tx_sts;
+	u8 rx_sts;
+	u8 num_rx_chains;
+	u32 min_interval;
+	u16 vendor_req_len;
+	u8 *vendor_req;
+};
+
 /**
  * struct cfg80211_pmsr_request_peer - peer data for a peer measurement request
  * @addr: MAC address
  * @chandef: channel to use
  * @report_ap_tsf: report the associated AP's TSF
+ * @type: type of peer measurement, see &enum nl80211_peer_measurement_type
  * @ftm: FTM data, see &struct cfg80211_pmsr_ftm_request_peer
+ * @sensing: sensing data, see &struct cfg80211_pmsr_sensing_request_peer
  */
 struct cfg80211_pmsr_request_peer {
 	u8 addr[ETH_ALEN];
 	struct cfg80211_chan_def chandef;
 	u8 report_ap_tsf:1;
-	struct cfg80211_pmsr_ftm_request_peer ftm;
+
+	enum nl80211_peer_measurement_type type;
+	union {
+		struct cfg80211_pmsr_ftm_request_peer ftm;
+		struct cfg80211_pmsr_sensing_request_peer sensing;
+	};
 };
 
 /**
@@ -5556,6 +5613,7 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @max_peers: maximum number of peers in a single measurement
  * @report_ap_tsf: can report assoc AP's TSF for radio resource measurement
  * @randomize_mac_addr: can randomize MAC address for measurement
+ *
  * @ftm: FTM measurement data
  * @ftm.supported: FTM measurement is supported
  * @ftm.asap: ASAP-mode is supported
@@ -5571,6 +5629,18 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	not limited)
  * @ftm.trigger_based: trigger based ranging measurement is supported
  * @ftm.non_trigger_based: non trigger based ranging measurement is supported
+ *
+ * @sensing.supported: Sensing measurement is supported
+ * @sensing.associated: support sensing under device associated
+ * @sensing.unassocaited: support sensing under device un-associated
+ * @sensing.vendor_mode: indicating vendor sensing measurement procedure
+ *	is adopted
+ * @sensing.bandwidths: bitmap of bandwidths supported (&enum nl80211_chan_width)
+ * @sensing.max_tx_ltf_rep: maximum number of TX LTF Repetition
+ * @sensing.max_rx_ltf_rep: maximum number of RX LTF Repetition
+ * @sensing.min_interval: minimum measurement interval between two consecutive
+ *	non-TB sensing measurement exchanges
+ * @sensing.max_rx_chains: maximum number of RX chains
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5590,6 +5660,18 @@ struct cfg80211_pmsr_capabilities {
 		   trigger_based:1,
 		   non_trigger_based:1;
 	} ftm;
+
+	struct {
+		u8 supported:1,
+		   associated:1,
+		   unassociated:1,
+		   vendor_mode:1;
+		u32 bandwidths;
+		u8 max_tx_ltf_rep;
+		u8 max_rx_ltf_rep;
+		u32 min_interval;
+		u8 max_rx_chains;
+	} sensing;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5599fb9d2f08..36152192e09b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7439,6 +7439,7 @@ enum nl80211_preamble {
  *	these numbers also for attributes
  *
  * @NL80211_PMSR_TYPE_FTM: flight time measurement
+ * @NL80211_PMSR_TYPE_SENSING: WLAN sensing measurement
  *
  * @NUM_NL80211_PMSR_TYPES: internal
  * @NL80211_PMSR_TYPE_MAX: highest type number
@@ -7447,6 +7448,7 @@ enum nl80211_peer_measurement_type {
 	NL80211_PMSR_TYPE_INVALID,
 
 	NL80211_PMSR_TYPE_FTM,
+	NL80211_PMSR_TYPE_SENSING,
 
 	NUM_NL80211_PMSR_TYPES,
 	NL80211_PMSR_TYPE_MAX = NUM_NL80211_PMSR_TYPES - 1
@@ -7831,6 +7833,123 @@ enum nl80211_peer_measurement_ftm_resp {
 	NL80211_PMSR_FTM_RESP_ATTR_MAX = NUM_NL80211_PMSR_FTM_RESP_ATTR - 1
 };
 
+/**
+ * enum nl80211_peer_measurement_sensing_capa - Sensing capabilities
+ * @__NL80211_PMSR_SENSING_CAPA_ATTR_INVALID: invalid
+ *
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_ASSOCIATED: flag attribute represents
+ *	supporting sensing under device associated
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_UNASSOCIATED: flag attribute represents
+ *	supporting sensing under device unassociated
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_VENDOR_MODE: flag attribute indicating
+ *	support vendor sensing measurement procedure
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_BANDWIDTHS: bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel
+ *	bandwidths for sensing
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_MAX_TX_LTF_REP: set to maximum number of
+ *	TX LTF Repetition minus 1 (u8, 0-7)
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_MAX_RX_LTF_REP: set to maximum number of
+ *	RX LTF Repetition minus 1 (u8, 0-7)
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_MIN_INTERVAL: indicating minimum
+ *	measurement interval between two consecutive non-TB sensing
+ *	measurement exchanges (u32, 100us, 0-8388607)
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_MAX_RX_CHAINS: set to maximum number of
+ *	RX chains minus 1 (u8, 0-7)
+ *
+ * @NUM_NL80211_PMSR_SENSING_CAPA_ATTR: internal
+ * @NL80211_PMSR_SENSING_CAPA_ATTR_MAX: highest attribute number
+ */
+enum nl80211_peer_measurement_sensing_capa {
+	__NL80211_PMSR_SENSING_CAPA_ATTR_INVALID,
+
+	NL80211_PMSR_SENSING_CAPA_ATTR_ASSOCIATED,
+	NL80211_PMSR_SENSING_CAPA_ATTR_UNASSOCIATED,
+	NL80211_PMSR_SENSING_CAPA_ATTR_VENDOR_MODE,
+	NL80211_PMSR_SENSING_CAPA_ATTR_BANDWIDTHS,
+	NL80211_PMSR_SENSING_CAPA_ATTR_MAX_TX_LTF_REP,
+	NL80211_PMSR_SENSING_CAPA_ATTR_MAX_RX_LTF_REP,
+	NL80211_PMSR_SENSING_CAPA_ATTR_MIN_INTERVAL,
+	NL80211_PMSR_SENSING_CAPA_ATTR_MAX_RX_CHAINS,
+
+	/* keep last */
+	NUM_NL80211_PMSR_SENSING_CAPA_ATTR,
+	NL80211_PMSR_SENSING_CAPA_ATTR_MAX = NUM_NL80211_PMSR_SENSING_CAPA_ATTR - 1
+};
+
+/**
+ * enum nl80211_peer_measurement_sensing_req - Sensing request attributes
+ * @__NL80211_PMSR_SENSING_REQ_ATTR_INVALID: invalid
+ *
+ * @NL80211_PMSR_SENSING_REQ_ATTR_ASSOCIATED: device is in associated state
+ *	(flag)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_INTERVAL: interval between two consecutive
+ *	sensing exchange (u32, optional, ms)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_DURATION: duration of a sensing exchange
+ *	(u16, optional, ms)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_EXPIRY_EXP: measurement session expiry
+ *	exponent (u8, 0-15)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_TX_LTF_REP: set to the number of LTF
+ *	repetitions minus 1 (u8, 0-7)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_RX_LTF_REP: set to the number of LTF
+ *	repetitions minus 1 (u8, 0-7)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_TX_STS: set to the number of TX space-time
+ *	streams minus 1 (u8, 0-7)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_RX_STS: set to the number of RX space-time
+ *	streams minus 1 (u8, 0-7)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_NUM_RX_CHAINS: requested number of RX chains
+ *	(u8, 0-7)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_MIN_INTERVAL: minimum measurement interval
+ *	between two consecutive non-TB sensing measurement exchanges
+ *	(u32, 100us, 0-8388607)
+ * @NL80211_PMSR_SENSING_REQ_ATTR_VENDOR_REQ: vendor request block if vendor
+ *	procedure is adopted (binary, optional)
+ *
+ * @NUM_NL80211_PMSR_SENSING_REQ_ATTR: internal
+ * @NL80211_PMSR_SENSING_REQ_ATTR_MAX: highest attribute number
+ */
+enum nl80211_peer_measurement_sensing_req {
+	__NL80211_PMSR_SENSING_REQ_ATTR_INVALID,
+
+	NL80211_PMSR_SENSING_REQ_ATTR_ASSOCIATED,
+	NL80211_PMSR_SENSING_REQ_ATTR_INTERVAL,
+	NL80211_PMSR_SENSING_REQ_ATTR_DURATION,
+	NL80211_PMSR_SENSING_REQ_ATTR_EXPIRY_EXP,
+	NL80211_PMSR_SENSING_REQ_ATTR_TX_LTF_REP,
+	NL80211_PMSR_SENSING_REQ_ATTR_RX_LTF_REP,
+	NL80211_PMSR_SENSING_REQ_ATTR_TX_STS,
+	NL80211_PMSR_SENSING_REQ_ATTR_RX_STS,
+	NL80211_PMSR_SENSING_REQ_ATTR_NUM_RX_CHAINS,
+	NL80211_PMSR_SENSING_REQ_ATTR_MIN_INTERVAL,
+	NL80211_PMSR_SENSING_REQ_ATTR_VENDOR_REQ,
+
+	/* keep last */
+	NUM_NL80211_PMSR_SENSING_REQ_ATTR,
+	NL80211_PMSR_SENSING_REQ_ATTR_MAX = NUM_NL80211_PMSR_SENSING_REQ_ATTR - 1
+};
+
+/**
+ * enum nl80211_peer_measurement_sensing_req - Sensing request attributes
+ * @__NL80211_PMSR_SENSING_RESP_ATTR_INVALID: invalid
+ *
+ * @NL80211_PMSR_SENSING_RESP_ATTR_REPORT_INDEX: index of the sensing measurement
+ *	report (u8)
+ * @NL80211_PMSR_SENSING_RESP_ATTR_DATA: raw data of the sensing measurement
+ *	report (binary)
+ *
+ * @NUM_NL80211_PMSR_SENSING_RESP_ATTR: internal
+ * @NL80211_PMSR_SENSING_RESP_ATTR_MAX: highest attribute number
+ */
+enum nl80211_peer_measurement_sensing_resp {
+	__NL80211_PMSR_SENSING_RESP_ATTR_INVALID,
+
+	NL80211_PMSR_SENSING_RESP_ATTR_REPORT_INDEX,
+	NL80211_PMSR_SENSING_RESP_ATTR_DATA,
+
+	/* keep last */
+	NUM_NL80211_PMSR_SENSING_RESP_ATTR,
+	NL80211_PMSR_SENSING_RESP_ATTR_MAX = NUM_NL80211_PMSR_SENSING_RESP_ATTR - 1
+};
+
 /**
  * enum nl80211_obss_pd_attributes - OBSS packet detection attributes
  * @__NL80211_HE_OBSS_PD_ATTR_INVALID: Invalid
diff --git a/net/wireless/core.c b/net/wireless/core.c
index a8e982ae8628..0692469dca60 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -786,39 +786,70 @@ int wiphy_register(struct wiphy *wiphy)
 	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
 		return -EINVAL;
 
-	if (WARN_ON(wiphy->pmsr_capa && !wiphy->pmsr_capa->ftm.supported))
+	if (WARN_ON(wiphy->pmsr_capa &&
+		    !(wiphy->pmsr_capa->ftm.supported ||
+		    wiphy->pmsr_capa->sensing.supported)))
 		return -EINVAL;
 
-	if (wiphy->pmsr_capa && wiphy->pmsr_capa->ftm.supported) {
-		if (WARN_ON(!wiphy->pmsr_capa->ftm.asap &&
-			    !wiphy->pmsr_capa->ftm.non_asap))
-			return -EINVAL;
-		if (WARN_ON(!wiphy->pmsr_capa->ftm.preambles ||
-			    !wiphy->pmsr_capa->ftm.bandwidths))
-			return -EINVAL;
-		if (WARN_ON(wiphy->pmsr_capa->ftm.preambles &
-				~(BIT(NL80211_PREAMBLE_LEGACY) |
-				  BIT(NL80211_PREAMBLE_HT) |
-				  BIT(NL80211_PREAMBLE_VHT) |
-				  BIT(NL80211_PREAMBLE_HE) |
-				  BIT(NL80211_PREAMBLE_DMG))))
-			return -EINVAL;
-		if (WARN_ON((wiphy->pmsr_capa->ftm.trigger_based ||
-			     wiphy->pmsr_capa->ftm.non_trigger_based) &&
-			    !(wiphy->pmsr_capa->ftm.preambles &
-			      BIT(NL80211_PREAMBLE_HE))))
-			return -EINVAL;
-		if (WARN_ON(wiphy->pmsr_capa->ftm.bandwidths &
-				~(BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-				  BIT(NL80211_CHAN_WIDTH_20) |
-				  BIT(NL80211_CHAN_WIDTH_40) |
-				  BIT(NL80211_CHAN_WIDTH_80) |
-				  BIT(NL80211_CHAN_WIDTH_80P80) |
-				  BIT(NL80211_CHAN_WIDTH_160) |
-				  BIT(NL80211_CHAN_WIDTH_320) |
-				  BIT(NL80211_CHAN_WIDTH_5) |
-				  BIT(NL80211_CHAN_WIDTH_10))))
-			return -EINVAL;
+	if (wiphy->pmsr_capa) {
+		if (wiphy->pmsr_capa->ftm.supported) {
+			if (WARN_ON(!wiphy->pmsr_capa->ftm.asap &&
+				    !wiphy->pmsr_capa->ftm.non_asap))
+				return -EINVAL;
+			if (WARN_ON(!wiphy->pmsr_capa->ftm.preambles ||
+				    !wiphy->pmsr_capa->ftm.bandwidths))
+				return -EINVAL;
+			if (WARN_ON(wiphy->pmsr_capa->ftm.preambles &
+					~(BIT(NL80211_PREAMBLE_LEGACY) |
+					  BIT(NL80211_PREAMBLE_HT) |
+					  BIT(NL80211_PREAMBLE_VHT) |
+					  BIT(NL80211_PREAMBLE_HE) |
+					  BIT(NL80211_PREAMBLE_DMG))))
+				return -EINVAL;
+			if (WARN_ON((wiphy->pmsr_capa->ftm.trigger_based ||
+				     wiphy->pmsr_capa->ftm.non_trigger_based) &&
+				    !(wiphy->pmsr_capa->ftm.preambles &
+				      BIT(NL80211_PREAMBLE_HE))))
+				return -EINVAL;
+			if (WARN_ON(wiphy->pmsr_capa->ftm.bandwidths &
+					~(BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+					  BIT(NL80211_CHAN_WIDTH_20) |
+					  BIT(NL80211_CHAN_WIDTH_40) |
+					  BIT(NL80211_CHAN_WIDTH_80) |
+					  BIT(NL80211_CHAN_WIDTH_80P80) |
+					  BIT(NL80211_CHAN_WIDTH_160) |
+					  BIT(NL80211_CHAN_WIDTH_320) |
+					  BIT(NL80211_CHAN_WIDTH_5) |
+					  BIT(NL80211_CHAN_WIDTH_10))))
+				return -EINVAL;
+		}
+
+		if (wiphy->pmsr_capa->sensing.supported) {
+			if (WARN_ON(!wiphy->pmsr_capa->sensing.associated &&
+				    !wiphy->pmsr_capa->sensing.unassociated))
+				return -EINVAL;
+			if (WARN_ON((wiphy->pmsr_capa->sensing.max_tx_ltf_rep >
+				     IEEE80211_SENSING_CAPA_MAX_LTF_REP - 1) ||
+				     (wiphy->pmsr_capa->sensing.max_rx_ltf_rep >
+				     IEEE80211_SENSING_CAPA_MAX_LTF_REP - 1) ||
+				     (wiphy->pmsr_capa->sensing.max_rx_chains >
+				     IEEE80211_SENSING_CAPA_MAX_CHAINS - 1)))
+				return -EINVAL;
+			if (WARN_ON(wiphy->pmsr_capa->sensing.min_interval >
+				    IEEE80211_SENSING_CAPA_MAX_MEASUREMENT_INTERVAL))
+				return -EINVAL;
+			if (WARN_ON(wiphy->pmsr_capa->sensing.bandwidths &
+					~(BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+					  BIT(NL80211_CHAN_WIDTH_20) |
+					  BIT(NL80211_CHAN_WIDTH_40) |
+					  BIT(NL80211_CHAN_WIDTH_80) |
+					  BIT(NL80211_CHAN_WIDTH_80P80) |
+					  BIT(NL80211_CHAN_WIDTH_160) |
+					  BIT(NL80211_CHAN_WIDTH_320) |
+					  BIT(NL80211_CHAN_WIDTH_5) |
+					  BIT(NL80211_CHAN_WIDTH_10))))
+				return -EINVAL;
+		}
 	}
 
 	if (WARN_ON((wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) &&
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b6bd7f4d6385..9ddf4075e969 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -544,6 +544,9 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
 
+void cfg80211_stop_wlan_sense(struct cfg80211_registered_device *rdev,
+			      struct wireless_dev *wdev);
+
 struct cfg80211_internal_bss *
 cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		    struct cfg80211_internal_bss *tmp,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 70717af1fbcd..5ce75034cf3c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -343,10 +343,28 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR] = { .type = NLA_U8 },
 };
 
+static const struct nla_policy
+nl80211_pmsr_sensing_req_attr_policy[NL80211_PMSR_SENSING_REQ_ATTR_MAX + 1] = {
+	[NL80211_PMSR_SENSING_REQ_ATTR_ASSOCIATED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_SENSING_REQ_ATTR_INTERVAL] = { .type = NLA_U32 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_DURATION] = { .type = NLA_U16 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_EXPIRY_EXP] = { .type = NLA_U8 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_TX_LTF_REP] = { .type = NLA_U8 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_RX_LTF_REP] = { .type = NLA_U8 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_TX_STS] = { .type = NLA_U8 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_RX_STS] = { .type = NLA_U8 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_NUM_RX_CHAINS] = { .type = NLA_U8 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_MIN_INTERVAL] = { .type = NLA_U32 },
+	[NL80211_PMSR_SENSING_REQ_ATTR_VENDOR_REQ] = { .type = NLA_BINARY,
+					.len = U8_MAX },
+};
+
 static const struct nla_policy
 nl80211_pmsr_req_data_policy[NL80211_PMSR_TYPE_MAX + 1] = {
 	[NL80211_PMSR_TYPE_FTM] =
 		NLA_POLICY_NESTED(nl80211_pmsr_ftm_req_attr_policy),
+	[NL80211_PMSR_TYPE_SENSING] =
+		NLA_POLICY_NESTED(nl80211_pmsr_sensing_req_attr_policy),
 };
 
 static const struct nla_policy
@@ -2267,6 +2285,55 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	return 0;
 }
 
+static int
+nl80211_send_pmsr_sensing_capa(const struct cfg80211_pmsr_capabilities *cap,
+			       struct sk_buff *msg)
+{
+	struct nlattr *sensing;
+
+	if (!cap->sensing.supported)
+		return 0;
+
+	sensing = nla_nest_start_noflag(msg, NL80211_PMSR_TYPE_SENSING);
+	if (!sensing)
+		return -ENOBUFS;
+
+	if (cap->sensing.associated &&
+	    nla_put_flag(msg, NL80211_PMSR_SENSING_CAPA_ATTR_ASSOCIATED))
+		return -ENOBUFS;
+
+	if (cap->sensing.unassociated &&
+	    nla_put_flag(msg, NL80211_PMSR_SENSING_CAPA_ATTR_UNASSOCIATED))
+		return -ENOBUFS;
+
+	if (cap->sensing.vendor_mode &&
+	    nla_put_flag(msg, NL80211_PMSR_SENSING_CAPA_ATTR_VENDOR_MODE))
+		return -ENOBUFS;
+
+	if (nla_put_u32(msg, NL80211_PMSR_SENSING_CAPA_ATTR_BANDWIDTHS,
+			cap->sensing.bandwidths))
+		return -ENOBUFS;
+
+	if (nla_put_u8(msg, NL80211_PMSR_SENSING_CAPA_ATTR_MAX_TX_LTF_REP,
+		       cap->sensing.max_tx_ltf_rep))
+		return -ENOBUFS;
+
+	if (nla_put_u8(msg, NL80211_PMSR_SENSING_CAPA_ATTR_MAX_RX_LTF_REP,
+		       cap->sensing.max_rx_ltf_rep))
+		return -ENOBUFS;
+
+	if (nla_put_u32(msg, NL80211_PMSR_SENSING_CAPA_ATTR_MIN_INTERVAL,
+			cap->sensing.min_interval))
+		return -ENOBUFS;
+
+	if (nla_put_u8(msg, NL80211_PMSR_SENSING_CAPA_ATTR_MAX_RX_CHAINS,
+		       cap->sensing.max_rx_chains))
+		return -ENOBUFS;
+
+	nla_nest_end(msg, sensing);
+	return 0;
+}
+
 static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 				  struct sk_buff *msg)
 {
@@ -2303,6 +2370,9 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 	if (nl80211_send_pmsr_ftm_capa(cap, msg))
 		return -ENOBUFS;
 
+	if (nl80211_send_pmsr_sensing_capa(cap, msg))
+		return -ENOBUFS;
+
 	nla_nest_end(msg, caps);
 	nla_nest_end(msg, pmsr);
 
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a117f5093ca2..6eddb7a75356 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -189,6 +189,114 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int pmsr_parse_sensing(struct cfg80211_registered_device *rdev,
+			      struct nlattr *sensingreq,
+			      struct cfg80211_pmsr_request_peer *out,
+			      struct genl_info *info)
+{
+	const struct cfg80211_pmsr_capabilities *capa = rdev->wiphy.pmsr_capa;
+	struct nlattr *tb[NL80211_PMSR_SENSING_REQ_ATTR_MAX + 1];
+
+	nla_parse_nested(tb, NL80211_PMSR_SENSING_REQ_ATTR_MAX,
+			 sensingreq, NULL, NULL);
+
+	out->sensing.associated = !!tb[NL80211_PMSR_SENSING_REQ_ATTR_ASSOCIATED];
+	if (out->sensing.associated && !capa->sensing.associated) {
+		NL_SET_ERR_MSG(info->extack, "SENSING: associated mode not supported");
+		return -EINVAL;
+	}
+	if (!out->sensing.associated && !capa->sensing.unassociated) {
+		NL_SET_ERR_MSG(info->extack, "SENSING: unassociated mode not supported");
+		return -EINVAL;
+	}
+
+	out->sensing.interval = 10;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_INTERVAL])
+		out->sensing.interval = nla_get_u32(tb[NL80211_PMSR_SENSING_REQ_ATTR_INTERVAL]);
+
+	out->sensing.duration = 10;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_DURATION])
+		out->sensing.duration = nla_get_u16(tb[NL80211_PMSR_SENSING_REQ_ATTR_DURATION]);
+
+	out->sensing.expiry_exp = 0;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_EXPIRY_EXP])
+		out->sensing.expiry_exp = nla_get_u8(tb[NL80211_PMSR_SENSING_REQ_ATTR_EXPIRY_EXP]);
+	if (out->sensing.expiry_exp > 15) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_SENSING_REQ_ATTR_EXPIRY_EXP],
+				    "SENSING: invalid Session Expiry Exponent");
+		return -EINVAL;
+	}
+
+	out->sensing.tx_ltf_rep = 0;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_TX_LTF_REP])
+		out->sensing.tx_ltf_rep = nla_get_u8(tb[NL80211_PMSR_SENSING_REQ_ATTR_TX_LTF_REP]);
+	if (out->sensing.tx_ltf_rep > capa->sensing.max_tx_ltf_rep) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_SENSING_REQ_ATTR_TX_LTF_REP],
+				    "SENSING: invalid TX LTF Repetition");
+		return -EINVAL;
+	}
+
+	out->sensing.rx_ltf_rep = 0;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_RX_LTF_REP])
+		out->sensing.rx_ltf_rep = nla_get_u8(tb[NL80211_PMSR_SENSING_REQ_ATTR_RX_LTF_REP]);
+	if (out->sensing.rx_ltf_rep > capa->sensing.max_rx_ltf_rep) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_SENSING_REQ_ATTR_RX_LTF_REP],
+				    "SENSING: invalid RX LTF Repetition");
+		return -EINVAL;
+	}
+
+	out->sensing.tx_sts = 0;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_TX_STS])
+		out->sensing.tx_sts = nla_get_u8(tb[NL80211_PMSR_SENSING_REQ_ATTR_TX_STS]);
+	if (out->sensing.tx_sts > 7) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_SENSING_REQ_ATTR_TX_STS],
+				    "SENSING: invalid TX STS");
+		return -EINVAL;
+	}
+
+	out->sensing.rx_sts = 0;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_RX_STS])
+		out->sensing.rx_sts = nla_get_u8(tb[NL80211_PMSR_SENSING_REQ_ATTR_RX_STS]);
+	if (out->sensing.rx_sts > 7) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_SENSING_REQ_ATTR_RX_STS],
+				    "SENSING: invalid RX STS");
+		return -EINVAL;
+	}
+
+	out->sensing.num_rx_chains = 0;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_NUM_RX_CHAINS])
+		out->sensing.num_rx_chains =
+			nla_get_u8(tb[NL80211_PMSR_SENSING_REQ_ATTR_NUM_RX_CHAINS]);
+	if (out->sensing.num_rx_chains > capa->sensing.max_rx_chains) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_SENSING_REQ_ATTR_NUM_RX_CHAINS],
+				    "SENSING: invalid number of RX Chains");
+		return -EINVAL;
+	}
+
+	out->sensing.min_interval = 0;
+	if (tb[NL80211_PMSR_SENSING_REQ_ATTR_MIN_INTERVAL])
+		out->sensing.min_interval =
+			nla_get_u32(tb[NL80211_PMSR_SENSING_REQ_ATTR_MIN_INTERVAL]);
+	if (out->sensing.min_interval > capa->sensing.min_interval) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_SENSING_REQ_ATTR_MIN_INTERVAL],
+				    "SENSING: invalid min Measurement Interval");
+		return -EINVAL;
+	}
+
+	if (capa->sensing.vendor_mode) {
+		out->sensing.vendor_req = nla_data(tb[NL80211_PMSR_SENSING_REQ_ATTR_VENDOR_REQ]);
+		out->sensing.vendor_req_len = nla_len(tb[NL80211_PMSR_SENSING_REQ_ATTR_VENDOR_REQ]);
+	}
+	return 0;
+}
+
 static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 			   struct nlattr *peer,
 			   struct cfg80211_pmsr_request_peer *out,
@@ -250,8 +358,13 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 	nla_for_each_nested(treq, req[NL80211_PMSR_REQ_ATTR_DATA], rem) {
 		switch (nla_type(treq)) {
 		case NL80211_PMSR_TYPE_FTM:
+			out->type = NL80211_PMSR_TYPE_FTM;
 			err = pmsr_parse_ftm(rdev, treq, out, info);
 			break;
+		case NL80211_PMSR_TYPE_SENSING:
+			out->type = NL80211_PMSR_TYPE_SENSING;
+			err = pmsr_parse_sensing(rdev, treq, out, info);
+			break;
 		default:
 			NL_SET_ERR_MSG_ATTR(info->extack, treq,
 					    "unsupported measurement type");
@@ -328,6 +441,15 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 		err = pmsr_parse_peer(rdev, peer, &req->peers[idx], info);
 		if (err)
 			goto out_err;
+
+		/*
+		 * Sensing operation is restricted to run in sense interface only,
+		 * so it will not mix with normal data
+		 */
+		if (req->peers[idx].type == NL80211_PMSR_TYPE_SENSING &&
+		    wdev->iftype != NL80211_IFTYPE_WLAN_SENSE)
+			goto out_err;
+
 		idx++;
 	}
 	req->cookie = cfg80211_assign_cookie(rdev);
@@ -399,6 +521,23 @@ void cfg80211_pmsr_complete(struct wireless_dev *wdev,
 }
 EXPORT_SYMBOL_GPL(cfg80211_pmsr_complete);
 
+static int nl80211_pmsr_send_sensing_res(struct sk_buff *msg,
+					 struct cfg80211_pmsr_result *res)
+{
+	if (nla_put_u16(msg, NL80211_PMSR_SENSING_RESP_ATTR_REPORT_INDEX,
+			res->sensing.seq_number))
+		goto error;
+
+	if (res->sensing.data_len && res->sensing.data)
+		if ((nla_put(msg, NL80211_PMSR_SENSING_RESP_ATTR_DATA,
+			     res->sensing.data_len, res->sensing.data)))
+			goto error;
+
+	return 0;
+error:
+	return -ENOSPC;
+}
+
 static int nl80211_pmsr_send_ftm_res(struct sk_buff *msg,
 				     struct cfg80211_pmsr_result *res)
 {
@@ -537,6 +676,10 @@ static int nl80211_pmsr_send_result(struct sk_buff *msg,
 		if (nl80211_pmsr_send_ftm_res(msg, res))
 			goto error;
 		break;
+	case NL80211_PMSR_TYPE_SENSING:
+		if (nl80211_pmsr_send_sensing_res(msg, res))
+			goto error;
+		break;
 	default:
 		WARN_ON(1);
 	}
-- 
2.25.1


