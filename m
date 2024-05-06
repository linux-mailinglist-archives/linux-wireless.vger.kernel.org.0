Return-Path: <linux-wireless+bounces-7245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BD8BD5CD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EC4281195
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70315B12E;
	Mon,  6 May 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ABeasPvz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07515ECC5
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024745; cv=none; b=r+OFFX8r7OhPR+z0FJYufy28+rpelu+77HF8hPpIPKSGEh2r2jVDeCY3QE9Tq/m1NxY1+MglcMtTaskWU+Adl3xrl29zZNotDNuBAG9Ilr/PxHuDIM1ddjsYe0vGZl1GbPRtLb0P4vsSfTzXOqStZ88CSR4+UK+E72+ERzf3c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024745; c=relaxed/simple;
	bh=5XV7KdVBiNSbK0WG9hnG0E74wsDf7D+6ugKckx/lWNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/GjNA8HglUq0/gNcuSx43bA/ThwXQ+6YUV2yf5ybaAFTeyiFtYbcaT4ryBWqYUBvhth2teBBIABua2RE4s4zC8coSDveBtGrUUlzRz2mg9jmZB78O4F/VHvNkRcRGvCdeeANuGAsRR61d5klj9lxjg8n3MJoOgekDVDCdRSO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ABeasPvz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v9ClB8kwY2dSKYkitwg1u4yXJzp67rU3iPmdSk803V0=;
	t=1715024743; x=1716234343; b=ABeasPvzCwtDILwA1sYLdYFE7U/E2c85h5oEt0aDpQqJow3
	r2AFZ8n3uIjHs9TRl/lEQzpu6hRasmm+pQ8e310LovaLSgTbGNaxuztCzui1djO4Ybj+1a/xxxPTh
	XVkyeSzhDQ79wuI/eHMYOAdlFFvcgsx6BJK0R0Bdo2FNLTY9x1OyF1zuL5AiFUD5905fz20q+XJlP
	49pTDeR8NYIsezQmNou+ZxxRd8DJxULhbW70F84DNLgjWMrV+GcFiYQofRcSU9Ugfdn9loUb0y/Fr
	7rahNICVIUXRgCgHzmFQad9EmOVwNy3VCHRiYamgsthrI1ZW2Qyfq8gsg6plDY4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44HM-00000008C27-28oh;
	Mon, 06 May 2024 21:45:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] wifi: mac80211: update 6 GHz AP power type before association
Date: Mon,  6 May 2024 21:37:53 +0200
Message-ID: <20240506214536.310434f55f76.I6aca291ee06265e3f63e0f9024ba19a850b53a33@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506194536.102148-7-johannes@sipsolutions.net>
References: <20240506194536.102148-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

6 GHz AP power type details are required to set proper tx power
used to send frames.

Update AP power type received in beacon while preparing
for connection instead of after association so the frames
before association can use the correct tx power.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
---
 net/mac80211/mlme.c | 55 ++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f026623c057b..0a70d246cf71 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4453,40 +4453,12 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	if (elems->he_operation &&
 	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE &&
 	    elems->he_cap) {
-		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
-
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  elems->he_cap,
 						  elems->he_cap_len,
 						  elems->he_6ghz_capa,
 						  link_sta);
 
-		he_6ghz_oper = ieee80211_he_6ghz_oper(elems->he_operation);
-
-		if (is_6ghz && he_6ghz_oper) {
-			switch (u8_get_bits(he_6ghz_oper->control,
-					    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
-			case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
-			case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
-				bss_conf->power_type = IEEE80211_REG_LPI_AP;
-				break;
-			case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-			case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
-				bss_conf->power_type = IEEE80211_REG_SP_AP;
-				break;
-			case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
-				bss_conf->power_type = IEEE80211_REG_VLP_AP;
-				break;
-			default:
-				bss_conf->power_type = IEEE80211_REG_UNSET_AP;
-				break;
-			}
-		} else if (is_6ghz) {
-			link_info(link,
-				  "HE 6 GHz operation missing (on %d MHz), expect issues\n",
-				  bss_conf->chanreq.oper.chan->center_freq);
-		}
-
 		bss_conf->he_support = link_sta->pub->he_cap.has_he;
 		if (elems->rsnx && elems->rsnx_len &&
 		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
@@ -5028,6 +5000,23 @@ ieee80211_determine_our_sta_mode_assoc(struct ieee80211_sub_if_data *sdata,
 			       conn->bw_limit, tmp.bw_limit);
 }
 
+static enum ieee80211_ap_reg_power
+ieee80211_ap_power_type(u8 control)
+{
+	switch (u8_get_bits(control, IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
+		return IEEE80211_REG_LPI_AP;
+	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
+		return IEEE80211_REG_SP_AP;
+	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
+		return IEEE80211_REG_VLP_AP;
+	default:
+		return IEEE80211_REG_UNSET_AP;
+	}
+}
+
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
 				  int link_id,
@@ -5060,6 +5049,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (link && is_6ghz && conn->mode >= IEEE80211_CONN_MODE_HE) {
+		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
 		struct ieee80211_bss_conf *bss_conf;
 		u8 j = 0;
 
@@ -5080,6 +5070,15 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			       elems->tx_pwr_env_len[i]);
 			j++;
 		}
+
+		he_6ghz_oper = ieee80211_he_6ghz_oper(elems->he_operation);
+		if (he_6ghz_oper)
+			bss_conf->power_type =
+				ieee80211_ap_power_type(he_6ghz_oper->control);
+		else
+			link_info(link,
+				  "HE 6 GHz operation missing (on %d MHz), expect issues\n",
+				  cbss->channel->center_freq);
 	}
 	rcu_read_unlock();
 	/* the element data was RCU protected so no longer valid anyway */
-- 
2.44.0


