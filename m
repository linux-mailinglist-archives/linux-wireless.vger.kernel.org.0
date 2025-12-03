Return-Path: <linux-wireless+bounces-29470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E773C9E98A
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19E7B3468C2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABDE2E174B;
	Wed,  3 Dec 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkW0EByN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A02E091E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755589; cv=none; b=Vux9j3UZWXziCGUAA+vRx65nn8BMramO0sbnAbEvCNMopPmBDMHRWbaPpRHMj1GOiSUci1z1DqLae0PUxfNy/x8YxsPwTPN0b7c0nazFnboDkn2H38g5FL9BLBLrlfASOReJQTR2jVahb7lqO5i+bqGI328xen+rmNp4sf17xWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755589; c=relaxed/simple;
	bh=5TjroN6FejF0MJoMg6t+J1MuUplw8jEtJHG2JKVGQTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LquN5qi3Ngn0eUSg0mYWzlOZXwZRYD4WfmesREGQ+ctVCxhUz+PHg5gWo83reNleN7Cf+3B0FkL8OriBnq6PdHKSeqzKd+dmWjU7DpwC3ZoNtKQcOZuwaNR5wSLXbDLDp0MzKoP8r/XsCvvJFHbGnW+oAml6/Ke+jUqw+D7OorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkW0EByN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764755587; x=1796291587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5TjroN6FejF0MJoMg6t+J1MuUplw8jEtJHG2JKVGQTc=;
  b=hkW0EByN0YQTQpo1lvmcijFDAOIfs5IfiBfNf/V/VdG3q1mXflRs9XK9
   EF9hyUD/UcpgtitmkWl7d4/fTfwT3JWDi/hcQzFLJslvcNXGuOCx+lQic
   RnQPsAAMehZTsOxQRYhibcfYiftrfvLu0x68Sp2UnY+msvqXaBjnK6erA
   rYdTUh+Xn44rGlPjVB0EDySCHmvpR1GGBwjuy19SBvYis012dAiXuuw7G
   g7yjbJtCKkUxdFHUYR661/m+kKhSEjX3AiUnfJDt3FM+XN9edzrSo7VJh
   Mo9cZqdaZAIHRg0OttVyuHthkoI8ht6ZAaHFIMKkdplqVwm85mWdRbTFB
   w==;
X-CSE-ConnectionGUID: mRLoO5E5Q1mjFHUl0lyLFA==
X-CSE-MsgGUID: Q3lj/17FTQ2GvuLWkbgpvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65931530"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="65931530"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:06 -0800
X-CSE-ConnectionGUID: tiI421tgSRykyaBafpPDPQ==
X-CSE-MsgGUID: QzvU2YVPQD6/y+H+ojRgjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="193916160"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 4/4] wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request
Date: Wed,  3 Dec 2025 11:52:38 +0200
Message-Id: <20251203115155.58623d254632.Iae2d32783b8e7c4a29089fec0f4c6bce94d303cc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203095238.3121859-1-miriam.rachel.korenblit@intel.com>
References: <20251203095238.3121859-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add an option to operate as the RSTA in an FTM measurement request.
When requested, the device will dwell on the requested channel until
the peer starts the FTM negotiation. This option is only valid for
trigger-based/non trigger-based measurement with LMR feedback which
will allow the RSTA to receive the results of the measurement.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  7 ++++++-
 include/uapi/linux/nl80211.h | 12 ++++++++++++
 net/wireless/nl80211.c       |  4 ++++
 net/wireless/pmsr.c          | 15 +++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ddc579b5179c..9758cb7efd34 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4310,6 +4310,8 @@ struct cfg80211_pmsr_result {
  *		 EDCA based ranging will be used.
  * @lmr_feedback: negotiate for I2R LMR feedback. Only valid if either
  *		 @trigger_based or @non_trigger_based is set.
+ * @rsta: Operate as the RSTA in the measurement. Only valid if @lmr_feedback
+ *	and either @trigger_based or @non_trigger_based is set.
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
@@ -4325,7 +4327,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	   request_civicloc:1,
 	   trigger_based:1,
 	   non_trigger_based:1,
-	   lmr_feedback:1;
+	   lmr_feedback:1,
+	   rsta:1;
 	u8 num_bursts_exp;
 	u8 burst_duration;
 	u8 ftms_per_burst;
@@ -5656,6 +5659,7 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	(0 means unknown)
  * @ftm.max_total_ltf_rx: maximum total number of LTFs that can be received
  *	(0 means unknown)
+ * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5681,6 +5685,7 @@ struct cfg80211_pmsr_capabilities {
 		u8 max_rx_sts;
 		u8 max_total_ltf_tx;
 		u8 max_total_ltf_rx;
+		u8 support_rsta:1;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 44e3468cc985..969b5597ed17 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7788,6 +7788,8 @@ enum nl80211_peer_measurement_attrs {
  *	maximum total number of LTFs the device can receive. The total number
  *	of LTFs is (number of LTF repetitions) * (number of space-time streams).
  *	This limits the allowed combinations of LTF repetitions and STS.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT: flag attribute indicating the
+ *	device supports operating as the RSTA in PMSR FTM request
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7812,6 +7814,7 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_RX_STS,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_TX,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
+	NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
@@ -7864,6 +7867,14 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR: optional. The BSS color of the
  *	responder. Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
  *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_RSTA: optional. Request to perform the measurement
+ *	as the RSTA (flag). When set, the device is expected to dwell on the
+ *	channel specified in %NL80211_PMSR_PEER_ATTR_CHAN until it receives the
+ *	FTM request from the peer or the timeout specified by
+ *	%NL80211_ATTR_TIMEOUT has expired.
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK is set (so the
+ *	RSTA will have the measurement results to report back in the FTM
+ *	response).
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -7884,6 +7895,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
 	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
+	NL80211_PMSR_FTM_REQ_ATTR_RSTA,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 106db6991d97..8863bad40038 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -361,6 +361,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_REQ_ATTR_RSTA] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -2330,6 +2331,9 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
 			cap->ftm.max_total_ltf_rx))
 		return -ENOBUFS;
+	if (cap->ftm.support_rsta &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index d5077d320098..60e1e31c2185 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -187,6 +187,21 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR]);
 	}
 
+	out->ftm.rsta = !!tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA];
+	if (out->ftm.rsta && !capa->ftm.support_rsta) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
+				    "FTM: RSTA not supported by device");
+		return -EOPNOTSUPP;
+	}
+
+	if (out->ftm.rsta && !out->ftm.lmr_feedback) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
+				    "FTM: RSTA set without LMR feedback");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


