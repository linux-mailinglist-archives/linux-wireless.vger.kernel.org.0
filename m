Return-Path: <linux-wireless+bounces-35476-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIp5Gpd/8GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35476-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:36:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A864818DD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747643143623
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6E39903E;
	Tue, 28 Apr 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HKrpsFZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188A38F24C
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368444; cv=none; b=Nq5flNgKy4AiTvTtLYKu3v4DS0mmFF153yuJjH8UshsN/Wyo/POo1ySiNzqcgqvS9/6vx/LLcB0wFXiU5yFNHBkUILKYMMrroDbGNeJ5/29W9+P5fTV8pYq9KJfxriJFE1oAhEzrjDR25UinkjRS9OtVPArja6Yvq3rmxHvctSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368444; c=relaxed/simple;
	bh=1k0HtjKe8+zDYP8BHJAF0TCTt4iZ+4dXwEH/hai3jPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDtCakE4gcDFg4J6p9uZgyeWb30N2oU3jfp1WaHg2USmjuoqDePdGjm2M1cy9ys7XLvJIUCHGwjOfUQKkSLsrnw0+qpKYOIAVGCLubq+bk3UCxb5aVD3ot1Mb8lTfd76yD3T08sEjPSWCqHnDPbIHJ5bMQw1U618Jjx2rfTJ5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HKrpsFZA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Znr69R3ZqTYgnIPhGmxoZEQFkyr0Y2jafiz2DspZ1BA=;
	t=1777368443; x=1778578043; b=HKrpsFZAVTH6DNFFK2Ix4E8TbuXs64uCpxuWXU6xQAcxnhZ
	1denzrRW+0qX5e6SqiivhF80UiVDsBdA1iMz5rK6vlwepPCKVL1e7DH8WhBJ48JFUH1W2l1gDkf+i
	Y/jNdD6nVbCt4NY3p5bXyT4yFxVHRzizk09Rk5kk2Z20dxiqCsF4qJu54AQZ3uXkrwj03B0iouoM5
	Hm1YLNwsTkk1jr4qGBXrwaVpf9qlcdEsXDLh9HV5HlhwmXU/srRUoZVc3kbTvHb/nkbLOHAjk6ada
	RHMF6wOVLiqUC00dM9obvzgMYHdsSiMGdK2+F03dXKiGkDZyCUR6vOSg96C1DSBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeiv-0000000HLwg-0fzs;
	Tue, 28 Apr 2026 11:27:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/14] wifi: mac80211: set AP NPCA parameters in bss_conf
Date: Tue, 28 Apr 2026 11:25:39 +0200
Message-ID: <20260428112708.311609f2eedb.I3db62b48d6afefd23b50fd14663f863e6f9974ca@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428092708.71740-16-johannes@sipsolutions.net>
References: <20260428092708.71740-16-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1A864818DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35476-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]

From: Johannes Berg <johannes.berg@intel.com>

Set the parameters advertised in the beacon in the BSS
configuration as well.

Note this is incomplete since it doesn't track updates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8f8d860944a8..9f24a5fa5e75 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1724,10 +1724,42 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (params->beacon.uhr_oper) {
+		const struct ieee80211_uhr_npca_info *npca;
+		struct ieee80211_bss_npca_params npca_params = {};
+
 		if (!link_conf->eht_support)
 			return -EOPNOTSUPP;
 
 		link_conf->uhr_support = true;
+
+		npca = ieee80211_uhr_npca_info(params->beacon.uhr_oper);
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


