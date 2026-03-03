Return-Path: <linux-wireless+bounces-32410-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFBbEdPypmkzawAAu9opvQ
	(envelope-from <linux-wireless+bounces-32410-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:40:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B51F1A65
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E5DF30BD82A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591F439019;
	Tue,  3 Mar 2026 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uBR8P/xf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B93E556D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548486; cv=none; b=Hn104M7Inc0mVOw/2h6Hr7WaW7E+kWVzGsvowwcdOluodHecSZC7qEuvC2H3hErAWaoOBejC1tef+oHIgtT4iX1AI4+kINjDWSBftt4zCNH/KUpKm9ZCk3KKHGc3ErrPndergbASKfDZJL3ostZp67cwv0ltjEF+OHAm9yvYfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548486; c=relaxed/simple;
	bh=y15QiD50l1TBeiMNX09qj+0zmdNm49dBp/yAF9cVq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnJVQrzyKCIip/zCnk/L67Os8ZoZKhEr1Ru4I+boKD/Fgyi5gySv/X/x6EB7x9bR7Nk5RHkTmAzLOsrDR8L0JKmMIs1aLH1U9UexcrfnWdFUD+ZMQ9tmcaxMBNLsvBBebH9fhdMuSoldhpxKdfrwKoFm5/W0VQJvUXMjds/n+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uBR8P/xf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RGWt5liNSNIpv7ICmTZmrlBi+zoRGS7mxNJpqIrM+YI=;
	t=1772548485; x=1773758085; b=uBR8P/xfZCsUkMGvDrreSvF6IfXFXttxnvLlT5d3aRCwU2U
	dxtNKIe75iTKv1CFFAxmKD8ldBIcWEZSCaZx57Z1OyVRZxnCcO6C5D72A7Ii/NC56oz/LFI+Oz0N4
	baUj7IRj3Ijycj70s7/mkmu+tTAuLqCWBTOQJppEXIcifnADQrzIMZXQXiECdeS142zUKm+CZ/0hk
	EcUH/gS+unG/mDJEiezJJjOooxosOmCIrXsCf1qocmc+ydWePZr6WDHPqkuSU6UuJtNnZIl7ISd4t
	oWV8ZelDPC16I2nXsp26XXtXmndPSfxPOZGd5FbRxN8Zl5JFCryzoXXxE0/jF0lg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQpf-00000007A1T-06U4;
	Tue, 03 Mar 2026 15:34:43 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 8/8] wifi: mac80211: set AP NPCA parameters in bss_conf
Date: Tue,  3 Mar 2026 15:27:03 +0100
Message-ID: <20260303153435.75b65c3144b6.I3db62b48d6afefd23b50fd14663f863e6f9974ca@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303143434.273141-10-johannes@sipsolutions.net>
References: <20260303143434.273141-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB5B51F1A65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32410-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Set the parameters advertised in the beacon in the BSS
configuration as well.

Note this is incomplete since it doesn't track updates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a1691b9bfceb..e12686b1e569 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1605,10 +1605,42 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (params->uhr_oper) {
+		const struct ieee80211_uhr_npca_info *npca;
+		struct ieee80211_bss_npca_params npca_params = {};
+
 		if (!link_conf->eht_support)
 			return -EOPNOTSUPP;
 
 		link_conf->uhr_support = true;
+
+		npca = ieee80211_uhr_npca_info(params->uhr_oper);
+		if (!npca) {
+			chanreq.oper.npca_chan = NULL;
+			chanreq.oper.npca_punctured = 0;
+		} else {
+			npca_params.min_dur_thresh =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH);
+			npca_params.switch_delay =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY);
+			npca_params.switch_back_delay =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY);
+			npca_params.init_qsrc =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC);
+			npca_params.moplen =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_MOPLEN);
+			npca_params.enabled = true;
+		}
+
+		if (memcmp(&npca_params, &link->conf->npca,
+			   sizeof(npca_params))) {
+			link->conf->npca = npca_params;
+			changed |= BSS_CHANGED_NPCA;
+		}
 	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
-- 
2.53.0


