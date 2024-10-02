Return-Path: <linux-wireless+bounces-13418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E098D259
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82159B2230E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C5200134;
	Wed,  2 Oct 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="PB3Qr6qC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A511E5034
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869523; cv=none; b=M/MQQ/WxF4Rv1fWWNTb8ZcGLFIE8ZHdvZVIgjKpm+O3HJA9n+3Aa3U/UbeKFTVmXJw1xmu5EfXMf8PxzoN4TL/doDNi2mkSoNQ150p1z1uuQJz7FpccodVDX7ew1TyALQ9JrcZvhAvtpSfF4w93WQ4MAnKjgPO9vkDmmZjJdGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869523; c=relaxed/simple;
	bh=f5R/zk2Ad4Z9vn5oqS4B93z+tE/meUVUTTgWK0X70d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po+V2eK8H4GUhHDK0OtKTkJNA40cBdmxgWnUBFjT/H6kLGn5aKqoLhaTeXttSxGl7dzD1N8ctrvTiAdX01rErmnXoIsB3WqGek2cxDM6qy3cZa3xU21B99BDZoxQPkeBR3DQn6PkdnXRWNplR1YQddt4JA0C9gapkfp+9PhbOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=PB3Qr6qC; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HMREsktTjCWYGxrmPAaUNBwes3G+pzjn93Qy+wWj2fw=; b=PB3Qr6qCMvqzzNeRHGwLw80fso
	MldZQibBXVbdU06s9rb4hTM3dZYQOxkBaig8KnlQc0svbYq9ezdoSRvVP22PdEczHVe8U7h5E7IkU
	GEoxIPImegFSdb5Q8+6VuS5Copo7r/ladlP3+8JloP4EREUyiwMVLPrukfwbaVOvoUAo=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1svxnD-003vyr-0V;
	Wed, 02 Oct 2024 13:45:19 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 05/11] wifi: mac80211: remove status->ampdu_delimiter_crc
Date: Wed,  2 Oct 2024 13:45:11 +0200
Message-ID: <917d12e75ec0c6790cb29f2083f489647a44e2e0.1727869380.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
References: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was never used by any driver, so remove it to free up some space.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h | 6 +-----
 net/mac80211/rx.c      | 7 +------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 954dff901b69..be916e1e5e1d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1448,8 +1448,6 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  * @RX_FLAG_AMPDU_IS_LAST: this subframe is the last subframe of the A-MPDU
  * @RX_FLAG_AMPDU_DELIM_CRC_ERROR: A delimiter CRC error has been detected
  *	on this subframe
- * @RX_FLAG_AMPDU_DELIM_CRC_KNOWN: The delimiter CRC field is known (the CRC
- *	is stored in the @ampdu_delimiter_crc field)
  * @RX_FLAG_MIC_STRIPPED: The mic was stripped of this packet. Decryption was
  *	done by the hardware
  * @RX_FLAG_ONLY_MONITOR: Report frame only to monitor interfaces without
@@ -1521,7 +1519,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_AMPDU_LAST_KNOWN	= BIT(12),
 	RX_FLAG_AMPDU_IS_LAST		= BIT(13),
 	RX_FLAG_AMPDU_DELIM_CRC_ERROR	= BIT(14),
-	RX_FLAG_AMPDU_DELIM_CRC_KNOWN	= BIT(15),
+	/* one free bit at 15 */
 	RX_FLAG_MACTIME			= BIT(16) | BIT(17),
 	RX_FLAG_MACTIME_PLCP_START	= 1 << 16,
 	RX_FLAG_MACTIME_START		= 2 << 16,
@@ -1618,7 +1616,6 @@ enum mac80211_rx_encoding {
  * @rx_flags: internal RX flags for mac80211
  * @ampdu_reference: A-MPDU reference number, must be a different value for
  *	each A-MPDU but the same for each subframe within one A-MPDU
- * @ampdu_delimiter_crc: A-MPDU delimiter CRC
  * @zero_length_psdu_type: radiotap type of the 0-length PSDU
  * @link_valid: if the link which is identified by @link_id is valid. This flag
  *	is set only when connection is MLO.
@@ -1656,7 +1653,6 @@ struct ieee80211_rx_status {
 	s8 signal;
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
-	u8 ampdu_delimiter_crc;
 	u8 zero_length_psdu_type;
 	u8 link_valid:1, link_id:4;
 };
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 59ad24a71141..718f02f0a181 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -508,18 +508,13 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 			flags |= IEEE80211_RADIOTAP_AMPDU_IS_LAST;
 		if (status->flag & RX_FLAG_AMPDU_DELIM_CRC_ERROR)
 			flags |= IEEE80211_RADIOTAP_AMPDU_DELIM_CRC_ERR;
-		if (status->flag & RX_FLAG_AMPDU_DELIM_CRC_KNOWN)
-			flags |= IEEE80211_RADIOTAP_AMPDU_DELIM_CRC_KNOWN;
 		if (status->flag & RX_FLAG_AMPDU_EOF_BIT_KNOWN)
 			flags |= IEEE80211_RADIOTAP_AMPDU_EOF_KNOWN;
 		if (status->flag & RX_FLAG_AMPDU_EOF_BIT)
 			flags |= IEEE80211_RADIOTAP_AMPDU_EOF;
 		put_unaligned_le16(flags, pos);
 		pos += 2;
-		if (status->flag & RX_FLAG_AMPDU_DELIM_CRC_KNOWN)
-			*pos++ = status->ampdu_delimiter_crc;
-		else
-			*pos++ = 0;
+		*pos++ = 0;
 		*pos++ = 0;
 	}
 
-- 
git-series 0.9.1

