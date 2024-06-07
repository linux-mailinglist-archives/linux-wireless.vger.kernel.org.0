Return-Path: <linux-wireless+bounces-8709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9149009F9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4492F1C2332E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634719AA63;
	Fri,  7 Jun 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="BLKaVbIN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC4199E8D
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776358; cv=none; b=MTXMbawXbUzZpoHBXPXZ6tC0NCNLWfcAByJlsyCQh8224lPhPA8rAbjBPrETvHgDwXtBM6vl7rgNkc2XcvN78hTBk7AZ3N97v1EK3it/PkGESUeua+eyGY83Y0nExHF9/Gyt2Tz5Hy0qivEzR3/IXJmAjUcPIlFrUyhRWMjxyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776358; c=relaxed/simple;
	bh=aPs1l6oNVH7KsBAgFiXbDsImKn/+fCorSfl9c5lbpBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2ZXgeE4Wf3urnMqh4K7zgQJx3fqpQTeUQN8eBJOFjd21KIPfAhc8wUs7ZxQUx8JWJUcB/G9yI/xOpNB5Dsem5k2rsNhbqu9j9iQqcStpWOpYecfJKkC8mmwMmzE6dOYl5wMuGNpiSHe03yjG0gnu9qz0NpMWpMAWZBrPQxHIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=BLKaVbIN; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z8GPMQ3+e8e1LRdC4JDZxr/6CKNOR5J/wAjrc6pDDYw=; b=BLKaVbINDfgTuffRdx2V4DWgI/
	PIFnNebtJQAC173OMtQljM7AMpvvbqavmJjiIfFu/JKWksUHYTcYsLCKjq1NJo2q9mmreW/mQDm1d
	mrXaq9UKuFJs2zIXdAq7T955lzl/L4IWmwlFsQOVsp0/HB+cFLtky8ROrUuTSvDbob80=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFc6A-008xPc-2g;
	Fri, 07 Jun 2024 18:05:50 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v4 4/9] wifi: cfg80211: add helper for checking if a chandef is valid on a radio
Date: Fri,  7 Jun 2024 18:05:43 +0200
Message-ID: <2b6364366796642a1018272fc63ee69a56339c17.1717776325.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
References: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
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
index 307b77e166c1..6ecc7f914bae 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6488,6 +6488,15 @@ static inline bool cfg80211_channel_is_psc(struct ieee80211_channel *chan)
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
index 3da04ceb6054..a0bbb76be502 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2879,3 +2879,38 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type)
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

