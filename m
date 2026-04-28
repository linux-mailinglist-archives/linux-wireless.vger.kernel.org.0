Return-Path: <linux-wireless+bounces-35471-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E1HJdB/8GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35471-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:37:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A4481980
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5ABA30BCEF2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59646394474;
	Tue, 28 Apr 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B3SHp9/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A638657A
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368442; cv=none; b=rhnqhv+m5GlRhasAyjK5GNdrNPD0uI+tmiR1HDuavorFs8qwB73YjXbf8z5IMYLPAtTE3iD6dlfpXOT3HsEE5uJgiHrYryYgjkK5HzRb9onphlYze/uNncvmlewoOtjBOSm7Pnzkyc8JB0Z6ib2gZiQHYMVdQfwlMnBcN9k7Q5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368442; c=relaxed/simple;
	bh=Xj39PN4ew4vu5LyqwFL8qG24/XPfX/H3FWqnrYhPnFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5MhQPnnxbNbb+YuQTO1PJYm3CFH3SYE9FneGYiXbL4Zqr3nk+BRlEldAIhqXaKK47KkxIVooz3TlT6oVLvV1b6vMOA2zqu5DpV1QBAbJf6EV8m3aZqzywyU4AOh8n6+7EDmVRKGla6EgryAZey5Dk1fxPC8JMetC4g3zFZtkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B3SHp9/r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G6cUAu2qyJTDPS3K8UU+zuGmhuNV03Vqqugz5lwV+yM=;
	t=1777368440; x=1778578040; b=B3SHp9/rGQqaDkC5Jqek3Jo0VFbN1WqKTFHGuNMU1cVh9Tl
	TnpYedVhoezkFzm35y1rY76uI3FYZjbpbVRGFgYaDWsGEvm8GPFllNDMMjSaDKRimgThVA49XEZrL
	zCUSkBv9bv/E4UqDDSKV9nPq7wgDab2iisbIcrAoyNFSkBEiaeCHD8Aj6hZ1MtOCzeVXLtr70c5s3
	WepPPBYFPRJtqMRJ+WGnWZDwc3pRPp6PK3Q0r300eTOdhxN7x1K91G/LBg8vOO8Q5C5yXvMgPXGv1
	dHl57nNjeMoryBVUJ2/oINvb44NWCYDuuXW2E+E1cYb+4tZXnRXPAGswbDnWn88g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeir-0000000HLwg-1pzX;
	Tue, 28 Apr 2026 11:27:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/14] wifi: mac80211: use NPCA in chandef for validation
Date: Tue, 28 Apr 2026 11:25:34 +0200
Message-ID: <20260428112708.418e86f9444c.I54430f3018e39a26b4252d71000d7bb7dd744331@changeid>
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
X-Rspamd-Queue-Id: 579A4481980
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
	TAGGED_FROM(0.00)[bounces-35471-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

Put the NPCA parameters into a chandef when parsing data from
the AP to validate them using the cfg80211 code, rather than
implementing that in mac80211 directly.

Note that the parameters are not applied yet, since mac80211
doesn't yet have NPCA support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0bf51774c155..247871c10615 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -402,44 +402,13 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 				       false)) {
 		struct cfg80211_chan_def npca_chandef = *chandef;
 		const struct ieee80211_uhr_npca_info *npca;
-		const __le16 *dis_subch_bmap;
-		u16 punct = chandef->punctured, npca_punct;
 
 		npca = ieee80211_uhr_npca_info(uhr_oper);
-		if (npca) {
-			int width = cfg80211_chandef_get_width(chandef);
-			u8 offs = le32_get_bits(npca->params,
-						IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN_OFFS);
-			u32 cf1 = chandef->center_freq1;
-			bool pri_upper, npca_upper;
 
-			pri_upper = chandef->chan->center_freq > cf1;
-			npca_upper = 20 * offs >= width / 2;
-
-			if (20 * offs >= cfg80211_chandef_get_width(chandef) ||
-			    pri_upper == npca_upper) {
-				sdata_info(sdata,
-					   "AP UHR NPCA primary channel invalid, disabling UHR\n");
-				return IEEE80211_CONN_MODE_EHT;
-			}
-		}
-
-		dis_subch_bmap = ieee80211_uhr_npca_dis_subch_bitmap(uhr_oper);
-
-		if (dis_subch_bmap) {
-			npca_punct = get_unaligned_le16(dis_subch_bmap);
-			npca_chandef.punctured = npca_punct;
-		}
-
-		/*
-		 * must be a valid puncturing pattern for this channel as
-		 * well as puncturing all subchannels that are already in
-		 * the disabled subchannel bitmap on the primary channel
-		 */
-		if (!cfg80211_chandef_valid(&npca_chandef) ||
-		    ((punct & npca_punct) != punct)) {
+		if (cfg80211_chandef_add_npca(sdata->local->hw.wiphy,
+					      &npca_chandef, npca)) {
 			sdata_info(sdata,
-				   "AP UHR NPCA disabled subchannel bitmap invalid, disabling UHR\n");
+				   "AP UHR NPCA settings invalid, disabling UHR\n");
 			return IEEE80211_CONN_MODE_EHT;
 		}
 	}
-- 
2.53.0


