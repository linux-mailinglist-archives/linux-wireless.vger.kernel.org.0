Return-Path: <linux-wireless+bounces-37284-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GkAN+N2HmpsjQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37284-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:23:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B882628EB0
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1532F3012E96
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 06:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D6930100E;
	Tue,  2 Jun 2026 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="mR+NzfOl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F433B6FB
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381355; cv=none; b=o15GHuovjDkNEZF8+hZmd2Ttj5KFWrmw+DAyLxjt/YJj1eTozA7wbc1hPGvOC9FmmnNo7dX/4tZ0kggImZewkbfaMAN6gEeZaGX2dcLSqgVW3/9AdE8l5op5ylkfA3gFeVXLqAldzAVyVmf3YiMFDGepGEAT/Oo148JN9Ktc3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381355; c=relaxed/simple;
	bh=RJ+c1B7tfZVUTuFpzf+rq1r+dJUTXoaBr7dx9P9+Uh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvcJWZ+nRuPnfzMr3AIPmFBizSJNy18SXVhOTvoMPXKQ/zycauvvTb9dtEdpGdeoZ0aWFpQXtIleJ8Hx0vouS10Vj80kkUV0+djT9VP/Vssh5qMzUK9cMm62CWmr6dtr2X99upYQZlobouHDQso6FbKcrFd5Tga03P8p0NV6zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=mR+NzfOl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8587427468so979010a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 23:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780381353; x=1780986153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BeVKuTip9J+2Ak/nyNFoRKIP9kVZjyLMmdxzlz4jC3A=;
        b=mR+NzfOl+9BP74tyKT+F0dKWWYuM9q5NewxDwhLYk6LIJP2ugqKxIsMDQgdOeN09DS
         tY4hRPBcDEqQklh/wdyxHrHGeMl/xbpB5vkmVxM6EGMSqtLYhnZyZIDpMTklpZQLLMa0
         xEAf2amCi7uF96PNhaklEeNwhKAdeEdpicZTHl+7OdLyjXQCbn54Np4Thxy/JHulYVNc
         +jBO/KADjkXzK/Rk/gGJr5u/hp8JSmGo4Ue3bTsXBN2nC4a4AlJcc3kwnrh43OJyqKGg
         QVXfuNHGKoIqUPsTj9S8yMNW3cpI3u3BVTT0eTC/qlW0o2juZe96DqKTa3vIuhmRubq+
         qDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381353; x=1780986153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeVKuTip9J+2Ak/nyNFoRKIP9kVZjyLMmdxzlz4jC3A=;
        b=NREn7QIbQs0fYHbywHcuY3KbT1NPJ/KWvEfCXlfBC5hshE5v3Z5BcB767QRcp/3meZ
         YRVnIPEeajSfPuz2tceqnuU6vuTQks8sTySAqxgwucICn/BznSUmlaZ9D7XIDk2qIFiQ
         AKdyPziClhOXEOiZ+nLEGmG3ZgUx4A9kD3AVwZC1YheWlj1NN8CXchOo8XLcpQmK/kr5
         JvKG3D3eF8gLqG0+s8fh49Orf3nN3SK1+D28mqeYqNlAdr7tZYVxBQVBYq+411Zm7Pqp
         LVXChT43IOo7IpgikICZakSi2+5//fk0r97WfEgLvp8WTRaFrhXO+ImtA+Ig6n5cQTCu
         KbfQ==
X-Gm-Message-State: AOJu0Yyhqpna7mYZgBWWZwmQ7NnHw3/TX6XSh+QwJwtCr8qt8U8W7Yso
	vxEQ+9X94L+30kR/g25t4ZVhkjPXCByhBv9d9e2kYXQxCqh8Wg61/GiOhIy0rmwij8Z3MrX9/af
	sJcrv
X-Gm-Gg: Acq92OEfTjpIAzWmWzzQ+Z3D2sMtJBRfz2Me0Kx//TuJQG/QtYIlBVtqkA2STEcm71I
	+fs16UooTApqHCNJmL5WwUrnt63aVUVPor+Go12eEZrfaWkdDAYcwZ11E9Z7MpTQprwI5J3ochQ
	WleZUJkQ46Z8CQbZWbV+jOxKf7o4Lnxy5sU8LG5TS1+CP8YMX4INe4Ih7TYyjH4dP734gxj04SX
	Te9QetoHgqKA+Zp93Xiwu5W9TLW0r3GImbLixyCYhJK5HtfJYesLjXbMBysSmem/sTSEszoEJzv
	gLUitxHQN5vmVvnOyzJCmuIkOm1j+9+cRzy7Z2r0UeDqo/vV6L5EdC8WAk6LLXx5CbAXbdC+J0K
	92Za2gs0a+wVbtXkNb//I+Ier050ZG7Z0nZG7X4XdFg49EeFonVz0DAP3aQF4nAwMgq8/wWWWU6
	HIWKRHy8PVbZp/+XJAoPByXIvdUF7NoxUOxTA7ivWp2Ph5KsqU+aAa64gUNhiD9F4DBj5BJt+xR
	3CQ+OdbuF4=
X-Received: by 2002:a05:6a20:3952:b0:39b:d5f1:4ff with SMTP id adf61e73a8af0-3b427ec917amr16647268637.20.1780381353152;
        Mon, 01 Jun 2026 23:22:33 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772df0fasm11301165a12.30.2026.06.01.23.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:22:32 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: mac80211: basic S1G rx rate reporting support
Date: Tue,  2 Jun 2026 16:22:24 +1000
Message-ID: <20260602062224.1792985-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37284-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3B882628EB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce basic rate encoding/decoding for S1G stas such that the
usermode rx reporting is relevant as it currently uses VHT calculations
which are obviously wildy different to S1G. Sample iw output (with the
associated iw patches applied):

Connected to 0c:bf:74:00:21:c4 (on wlan0)
        SSID: wifi_halow
        freq: 923.500
        RX: 7325230 bytes (4756 packets)
        TX: 190044 bytes (2238 packets)
        signal: -38 dBm
        rx bitrate: 43.3 MBit/s S1G-MCS 9 8MHz short GI S1G-NSS 1
        tx bitrate: 43.3 MBit/s S1G-MCS 9 8MHz short GI S1G-NSS 1
        bss flags:
        dtim period: 1
        beacon int: 100

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/net/mac80211.h  |  1 +
 net/mac80211/rx.c       |  8 ++++++++
 net/mac80211/sta_info.c |  7 +++++++
 net/mac80211/sta_info.h | 11 ++++++++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4fb579805e0f..7dd558f4025b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1704,6 +1704,7 @@ enum mac80211_rx_encoding {
 	RX_ENC_HE,
 	RX_ENC_EHT,
 	RX_ENC_UHR,
+	RX_ENC_S1G,
 };
 
 /**
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ef6086b183f7..91b4f6cbfce8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5621,6 +5621,14 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 				      status->rate_idx, status->nss))
 				goto drop;
 			break;
+		case RX_ENC_S1G:
+			if (WARN_ONCE(status->rate_idx > 12 ||
+				      !status->nss ||
+				      status->nss > 4,
+				      "Rate marked as an S1G rate but data is invalid: MCS: %d, NSS: %d\n",
+				      status->rate_idx, status->nss))
+				goto drop;
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			fallthrough;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0ea37016cd4f..9adda77f2679 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2605,6 +2605,13 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
 		if (STA_STATS_GET(UHR_IM, rate))
 			rinfo->flags |= RATE_INFO_FLAGS_UHR_IM;
 		break;
+	case STA_STATS_RATE_TYPE_S1G:
+		rinfo->flags = RATE_INFO_FLAGS_S1G_MCS;
+		rinfo->mcs = STA_STATS_GET(S1G_MCS, rate);
+		rinfo->nss = STA_STATS_GET(S1G_NSS, rate);
+		if (STA_STATS_GET(SGI, rate))
+			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
 	}
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 39608a0abbb5..e1837e986837 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -1042,7 +1042,7 @@ enum sta_stats_type {
 #define STA_STATS_FIELD_VHT_MCS		0x0000F000
 #define STA_STATS_FIELD_VHT_NSS		0x000F0000
 
-/* HT & VHT */
+/* HT, VHT & S1G */
 #define STA_STATS_FIELD_SGI		0x00100000
 
 /* STA_STATS_RATE_TYPE_HE */
@@ -1066,6 +1066,9 @@ enum sta_stats_type {
 #define STA_STATS_FIELD_UHR_ELR		0x08000000
 #define STA_STATS_FIELD_UHR_IM		0x10000000
 
+/* STA_STATS_RATE_TYPE_S1G */
+#define STA_STATS_FIELD_S1G_MCS		0x0000F000
+#define STA_STATS_FIELD_S1G_NSS		0x000F0000
 
 #define STA_STATS_FIELD(_n, _v)		FIELD_PREP(STA_STATS_FIELD_ ## _n, _v)
 #define STA_STATS_GET(_n, _v)		FIELD_GET(STA_STATS_FIELD_ ## _n, _v)
@@ -1081,6 +1084,7 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
 	switch (s->encoding) {
 	case RX_ENC_HT:
 	case RX_ENC_VHT:
+	case RX_ENC_S1G:
 		if (s->enc_flags & RX_ENC_FLAG_SHORT_GI)
 			r |= STA_STATS_FIELD(SGI, 1);
 		break;
@@ -1127,6 +1131,11 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
 		r |= STA_STATS_FIELD(UHR_ELR, s->uhr.elr);
 		r |= STA_STATS_FIELD(UHR_IM, s->uhr.im);
 		break;
+	case RX_ENC_S1G:
+		r |= STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_S1G);
+		r |= STA_STATS_FIELD(S1G_NSS, s->nss);
+		r |= STA_STATS_FIELD(S1G_MCS, s->rate_idx);
+		break;
 	default:
 		WARN_ON(1);
 		return STA_STATS_RATE_INVALID;
-- 
2.43.0


