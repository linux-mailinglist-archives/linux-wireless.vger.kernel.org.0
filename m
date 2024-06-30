Return-Path: <linux-wireless+bounces-9709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA8291D068
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910101C20A44
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE4B41C6D;
	Sun, 30 Jun 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="VstYNoxz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3783374CC
	for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733867; cv=none; b=jhXXFeYiqVQJsSNYRGQUTgG7Rf0HevZaN29JCALVVndJMvs/w6JFDDL8RhE0I3abz3qKiD/Km86eN+rr1gCMYffxBOxZjL7jM6pD/FrsBLEpX8UGGrjff/BiWUZCS9sQ+dWpiMOsx3ZCK9ojnotW4BcdTbbBFA06MD39U8+QC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733867; c=relaxed/simple;
	bh=Z/5Wj9zxj6QB78a/GMR++JkrL7xw1yHNwIKLdp/RvBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY7dnI4AbBOl5GDLEHIpRDCrVD8d29rfDjsrdMlzdXvfgUDTNtDaBjsQQwSCanDM0AidZyQHQ64ZLHuY9jUIHuUzRE6cXlMatEwkgNNYD9q2AoryCvX7Tr/zvMPNndLnMgyfeTozXK7Ox9jw0SyVL7i/vyExBowBb/MN9QovhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=VstYNoxz; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=P0RMwgxafFAIFQ7IqdZ+CFX/ATG6+5qe4zV5bKL0Hgs=; b=VstYNoxzqBwd9su+FanoLfbRw1
	dJBkPBMeaYlIjvcJPtfJ8iL5QTieKgF2mivChdaG9Wag2C99ExbheIhraf9q4a45PIjv2mW2pjD0g
	AlOw53fWV+limw9Ov0bRzvI2wfjzfQBlgPiPADTWAxTjB7L3+gIRvoh1Hpzfxp4Rva9A=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sNpKp-000sh7-1e;
	Sun, 30 Jun 2024 09:50:55 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v2 04/10] wifi: cfg80211: add helper for checking if a chandef is valid on a radio
Date: Sun, 30 Jun 2024 09:50:47 +0200
Message-ID: <69a300358f9dbc33ecdde0258d527a23f9094417.1719733819.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
References: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if the full channel width is in the radio's frequency range.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h |  9 +++++++++
 net/wireless/util.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 111eda169728..bd739c8d426e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6506,6 +6506,15 @@ static inline bool cfg80211_channel_is_psc(struct ieee80211_channel *chan)
 }
 
 /**
+ * cfg80211_radio_chandef_valid - Check if the radio supports the chandef
+ *
+ * @radio: wiphy radio
+ * @chandef: chandef for current channel
+ */
+bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
+				  const struct cfg80211_chan_def *chandef);
+
+/**
  * ieee80211_get_response_rate - get basic rate for a given rate
  *
  * @sband: the band to look for rates in
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2492f259621f..9a7c3adc8a3b 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2886,3 +2886,38 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type)
 	return NULL;
 }
 EXPORT_SYMBOL(cfg80211_get_iftype_ext_capa);
+
+static bool
+ieee80211_radio_freq_range_valid(const struct wiphy_radio *radio,
+				 u32 freq, u32 width)
+{
+	const struct wiphy_radio_freq_range *r;
+	int i;
+
+	for (i = 0; i < radio->n_freq_range; i++) {
+		r = &radio->freq_range[i];
+		if (freq - width / 2 >= r->start_freq &&
+		    freq + width / 2 <= r->end_freq)
+			return true;
+	}
+
+	return false;
+}
+
+bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
+				  const struct cfg80211_chan_def *chandef)
+{
+	u32 freq, width;
+
+	freq = ieee80211_chandef_to_khz(chandef);
+	width = nl80211_chan_width_to_mhz(chandef->width);
+	if (!ieee80211_radio_freq_range_valid(radio, freq, width))
+		return false;
+
+	freq = MHZ_TO_KHZ(chandef->center_freq2);
+	if (freq && !ieee80211_radio_freq_range_valid(radio, freq, width))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(cfg80211_radio_chandef_valid);
-- 
git-series 0.9.1

