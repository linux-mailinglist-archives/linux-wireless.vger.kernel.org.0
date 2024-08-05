Return-Path: <linux-wireless+bounces-10974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D7948242
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690711F23B4C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC216C436;
	Mon,  5 Aug 2024 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="oMyOJY++"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985F15B147
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885822; cv=none; b=N5C8tox71NLFiF25iRT/7eaSLDenP5MnUXG998N8rq7EnGQZak0UkiP9PcoR9vMCCwq+ObJxVBCnHgfhTiQKRoyHb47+GOkAIfRh68sZbSFFVGqmTn+csEPKyqKNYnfxC98BKXVIo+vUhmK6Zq+50sza+3SZRpEQeJt0mjdxK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885822; c=relaxed/simple;
	bh=5SSRo8amTotHNI2Nod0SFpVMkyJCCS85O9mFXw0ukJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om6N4yttWBhq7bWDQjRbyATpQm7Pr2S7tU7HD7f75bZoBuqHT8aHlU7QLmi04ilxii+nUR9UlHjyPs2t8Umcq364WhrTydun8fpACazhs7r8UYW0e4PLWBv65XAdJ6A4HmTvxDR6opvJrPKlkSTNqc+vW+oeBzSZdZtgfCkfl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=oMyOJY++; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ydhn9SJKBRYJwL3AnMkZw4ppg8boPegPYp+RFGyYnIU=; b=oMyOJY++BhZmPRKA3LrvYboLXH
	VwC/zmsdz5HBHxN3ABv0co47MHrsEvUK2pgLjRrNQ/Li+1fcw0S/O5veP2xD2DIyo1XAnDu8lvMoh
	fUJ9tbGtyobvSOf/+kOgNNOgz4ICAcU9NB34Pbzi0ZREv5Eh8dmSpD1mPbXDLhgv8MYY=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb3Iu-00EHlS-0c;
	Mon, 05 Aug 2024 21:23:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 2/6] wifi: mac80211: remove status->ampdu_delimiter_crc
Date: Mon,  5 Aug 2024 21:23:30 +0200
Message-ID: <c92c7f2b7b2e72f68aa7a50fd5ee20830a27a35f.1722885720.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
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
index 9311041f5c8d..9618c82262e3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1450,8 +1450,6 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  * @RX_FLAG_AMPDU_IS_LAST: this subframe is the last subframe of the A-MPDU
  * @RX_FLAG_AMPDU_DELIM_CRC_ERROR: A delimiter CRC error has been detected
  *	on this subframe
- * @RX_FLAG_AMPDU_DELIM_CRC_KNOWN: The delimiter CRC field is known (the CRC
- *	is stored in the @ampdu_delimiter_crc field)
  * @RX_FLAG_MIC_STRIPPED: The mic was stripped of this packet. Decryption was
  *	done by the hardware
  * @RX_FLAG_ONLY_MONITOR: Report frame only to monitor interfaces without
@@ -1523,7 +1521,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_AMPDU_LAST_KNOWN	= BIT(12),
 	RX_FLAG_AMPDU_IS_LAST		= BIT(13),
 	RX_FLAG_AMPDU_DELIM_CRC_ERROR	= BIT(14),
-	RX_FLAG_AMPDU_DELIM_CRC_KNOWN	= BIT(15),
+	/* one free bit at 15 */
 	RX_FLAG_MACTIME			= BIT(16) | BIT(17),
 	RX_FLAG_MACTIME_PLCP_START	= 1 << 16,
 	RX_FLAG_MACTIME_START		= 2 << 16,
@@ -1620,7 +1618,6 @@ enum mac80211_rx_encoding {
  * @rx_flags: internal RX flags for mac80211
  * @ampdu_reference: A-MPDU reference number, must be a different value for
  *	each A-MPDU but the same for each subframe within one A-MPDU
- * @ampdu_delimiter_crc: A-MPDU delimiter CRC
  * @zero_length_psdu_type: radiotap type of the 0-length PSDU
  * @link_valid: if the link which is identified by @link_id is valid. This flag
  *	is set only when connection is MLO.
@@ -1658,7 +1655,6 @@ struct ieee80211_rx_status {
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

