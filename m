Return-Path: <linux-wireless+bounces-13447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904E98EAEC
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 09:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5CBB24AE5
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5812C81F;
	Thu,  3 Oct 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="hLcfCkuD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C412C7FB
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942306; cv=none; b=upuzxGw8ENAEVkNS0/XYNov3XU84B9NQnwtQDU5aCOZ/fwNkeSEKvxVShJiwp47Y1KyxgDf7s3ejhkb+Vyj+0kXwm0axfEB992fVlqasofNxPHkIG6zhRMeDfY3DXGsIowrWeHJHJQ7ZPB4a7mE/rd/X+kqq+OdV4EsPCyOvWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942306; c=relaxed/simple;
	bh=f5R/zk2Ad4Z9vn5oqS4B93z+tE/meUVUTTgWK0X70d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1KgPAL1qj8uGB8RDRuDlK6K965cle3kBBGf1EN8SJp3TjMp+ZscD2J8DquTxZ4qlI5FxFLugzIRdWbDLoyEwsFSRo0QOMsL2lbG8/FoZ8rujdXIC/0OCgbqkTr7809ZehPxQhEyHXDUDN2bQ36NoBqeo229Wz/nMW3W8M5B3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=hLcfCkuD; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HMREsktTjCWYGxrmPAaUNBwes3G+pzjn93Qy+wWj2fw=; b=hLcfCkuDSmSpNSul3555EP30vz
	zkGFsHKnJkQ9J72gSc0QnpCGet+6zsO8z2bRgdPeWTMWmJqIUBFdMhdEgh2I3omSRIgwtQxmgcOFf
	0gdHl97UDTTG/M6fPR32Qmz172wR0bfhFQJOncdIkXHemHc5Pl7VEJ3D85U5Y52mCvWc=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swGj7-004Jgh-1g;
	Thu, 03 Oct 2024 09:58:21 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v2 05/11] wifi: mac80211: remove status->ampdu_delimiter_crc
Date: Thu,  3 Oct 2024 09:58:13 +0200
Message-ID: <25fb453c8ef836c6ade5b3ecad50d80477241851.1727942154.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.debd54967c43dd95013c56efa390ea6117062373.1727942154.git-series.nbd@nbd.name>
References: <cover.debd54967c43dd95013c56efa390ea6117062373.1727942154.git-series.nbd@nbd.name>
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

