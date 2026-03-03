Return-Path: <linux-wireless+bounces-32405-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAIHLanypmkzawAAu9opvQ
	(envelope-from <linux-wireless+bounces-32405-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:39:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 338671F1A46
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 604D93091A93
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402B4301D7;
	Tue,  3 Mar 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ETXGhGy2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93413ED5D9
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548483; cv=none; b=clZnZlEOEK/c29Vno+IvjJxl8ng15f5Npeb8DXGurlnBrNFO8m/1TNxmSvjS69I7Py0SGRzkCIL1utlnzmilS801G3Wta4kTZ1WoC2TNiDuyYuyCbSKmJOxOzC0+JcD/+KmLn4eJmWODc04sAwl7J1SZSS1bgpKGd2ykMRha+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548483; c=relaxed/simple;
	bh=926mDRtpkmxKZinYmDW2y8kE9xiyW05k12VprgWLR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLdyVby3+DqaumSYlngoFCNzE3vlZAgeXNwxE1epcjiyT/Sq0OoZzQIkQmVlf/UFfNqHVYNHPNFoBzgZfdkmVpzmmipVubeURx1e7uGYXuM96JB1FK1X9ZtaK2e6x7RJy+8XoDMnR3KpRxh/lONZ9zk5pvtpTs+uz5T9Vum0ZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ETXGhGy2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=B8uCZn3o+Tf14EsEZwSoyFGR9jG/xaIwbzByYFOHGfQ=;
	t=1772548481; x=1773758081; b=ETXGhGy2X8rq2UiMN9eRklZoMA/R7WMXUy0yWyMTp4F/SUG
	bR+lQNySY0JwE4avBBRnwbvVR0s/VJYXmJ6zPuE2k299xJeUzsiFjzlT86K3J91Ty1LcnN+Wp1Fi8
	OdAkW/2z+GPraROwtpNdLzCz4b864zaSe9Gp9KLKGwhodPVPF7pIRYItzs1zaNe7XXTY1Mr+qKKtE
	hAKAtJQr4xY2kL6cgCzxRrIaezXJFRSPF+7/jzWPhaqyhmRaPJEi3PvG76k32of80BFXaxTUw3SHi
	1RuLEMyBJ/FpsLjloXvzQ+WYxH3dg3EoYlHK727/DftrhoTvuhoepHkTbET3ySzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQpb-00000007A1T-1FKS;
	Tue, 03 Mar 2026 15:34:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 3/8] wifi: mac80211: use NPCA in chandef for validation
Date: Tue,  3 Mar 2026 15:26:58 +0100
Message-ID: <20260303153435.f043549c8fd7.I54430f3018e39a26b4252d71000d7bb7dd744331@changeid>
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
X-Rspamd-Queue-Id: 338671F1A46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32405-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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
index 170330d924a3..ecce6382e6cb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -357,44 +357,13 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
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


