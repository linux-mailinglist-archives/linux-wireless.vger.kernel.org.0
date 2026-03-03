Return-Path: <linux-wireless+bounces-32406-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDSXMYfxpmnQagAAu9opvQ
	(envelope-from <linux-wireless+bounces-32406-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:34:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F51F190B
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2DA3300BBA9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226CB4301DE;
	Tue,  3 Mar 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PME7TtaE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A23B531A
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548483; cv=none; b=vD9VoPXN1COs2mspllZvP5hoSrP+dzfMR0qTCtLKX5/+7lbGSQlVdMuFagU94H/2T62D/PdQr52fmCcR1svB7kFq9aCkCtC6TEa4j49j6YudXXWyIa7mUkW8MWk6W2IjxGeKq7Dp3ce1uBhY4G1trTCrqBvdPQ3iN/V21rV3HqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548483; c=relaxed/simple;
	bh=/iaxn98j3vu8qEieoR6W/wRp7ks6whfqWEqHyNnJ/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAsU0TUMKLkj2hUPpMz18OpcZexcgRjqF90GTqdGihs62smB7UurnGPCsrIthKg31tNQHMsB3vN84jZlJLTv0EI0VN+9QLYmnJVpiB1CSWsnemx6PYHBOg1d0Q2k5O0i/40WFbXRwvkhrOx2PRiB4ShMkY+UQS/xz5pf/YncAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PME7TtaE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=n+TX202aG7KHbwKh4b1YLnSjFjW5NB2GWwtKoBqdMk4=;
	t=1772548481; x=1773758081; b=PME7TtaEDykGxUelHEYpbVud9YpCy18adgk1BXlgBZ92Sqn
	MbLbV6KSsRh2MIiZnIh9cyVYb/EbDcVkDnKZ67CskzvKtsaL0xqhXAhoU9HqNu93In1YdbtcRuEA8
	9Gy12AyG3uSwmr34iesGA3GuGjN7co10GIFlquwcBsRpOv/Fd/1GG98Csp8NYEwMKu5jpmF1ZUgrD
	ycM84ZDsvXXDgYX/LbtYUqrV0QfV+b8GLIjtBF3MqkaXetkjjQPOJIntAvVtiyt4/Kc456+rWZ/M2
	FuzJV3qtZA9af1FTCE+//WHK6iz+lTnp2FetwTkjo8MetsguBhdxOH9R3A0Zu9fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQpa-00000007A1T-2uTd;
	Tue, 03 Mar 2026 15:34:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 2/8] wifi: cfg80211: add helper for parsing NPCA to chandef
Date: Tue,  3 Mar 2026 15:26:57 +0100
Message-ID: <20260303153435.61ae6faef7f0.I95d396ac671da438f340b1afb735ebfe33164894@changeid>
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
X-Rspamd-Queue-Id: B27F51F190B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32406-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Add a cfg80211_chandef_add_npca() helper function that takes an
existing chandef without NPCA and sets the NPCA information from
the format used in UHR operation and UHR Parameters Update.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 13 ++++++++++++
 net/wireless/chan.c    | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 828d5cc84028..d09ec65514fc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1150,6 +1150,19 @@ int cfg80211_chandef_primary(const struct cfg80211_chan_def *chandef,
 			     enum nl80211_chan_width primary_chan_width,
 			     u16 *punctured);
 
+/**
+ * cfg80211_chandef_add_npca - parse and add NPCA information to chandef
+ * @wiphy: the wiphy this will be used for, for channel pointer lookup
+ * @chandef: the chandef to modify, must be a valid chandef without NPCA
+ * @npca: the NPCA information, can be %NULL
+ *
+ * Returns: 0 if the NPCA information was added and the resulting
+ *	chandef is valid, a negative error code on errors
+ */
+int cfg80211_chandef_add_npca(struct wiphy *wiphy,
+			      struct cfg80211_chan_def *chandef,
+			      const struct ieee80211_uhr_npca_info *npca);
+
 /**
  * nl80211_send_chandef - sends the channel definition.
  * @msg: the msg to send channel definition
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 7f6f4cfc3272..9d8c8ebf9644 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -546,6 +546,52 @@ int cfg80211_chandef_primary(const struct cfg80211_chan_def *c,
 }
 EXPORT_SYMBOL(cfg80211_chandef_primary);
 
+int cfg80211_chandef_add_npca(struct wiphy *wiphy,
+			      struct cfg80211_chan_def *chandef,
+			      const struct ieee80211_uhr_npca_info *npca)
+{
+	struct cfg80211_chan_def new_chandef = *chandef;
+	u32 width, npca_freq;
+	u8 offs;
+
+	if (chandef->npca_chan || chandef->npca_punctured)
+		return -EINVAL;
+
+	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
+		return -EINVAL;
+
+	if (!npca)
+		return 0;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_80:
+	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_320:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	offs = le32_get_bits(npca->params,
+			     IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN_OFFS);
+
+	width = cfg80211_chandef_get_width(chandef);
+	npca_freq = chandef->center_freq1 - width / 2 + 10 + 20 * offs;
+	new_chandef.npca_chan = ieee80211_get_channel(wiphy, npca_freq);
+	if (!new_chandef.npca_chan)
+		return -EINVAL;
+
+	if (npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES))
+		new_chandef.npca_punctured = le16_to_cpu(npca->dis_subch_bmap[0]);
+
+	if (!cfg80211_chandef_valid(&new_chandef))
+		return -EINVAL;
+
+	*chandef = new_chandef;
+	return 0;
+}
+EXPORT_SYMBOL(cfg80211_chandef_add_npca);
+
 static const struct cfg80211_chan_def *
 check_chandef_primary_compat(const struct cfg80211_chan_def *c1,
 			     const struct cfg80211_chan_def *c2,
-- 
2.53.0


