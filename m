Return-Path: <linux-wireless+bounces-971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B58581838D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17830285A69
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BCB125C0;
	Tue, 19 Dec 2023 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecFQbw2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC511C9C
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975079; x=1734511079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiOJALF7j4rgUTg7bT6QoF5UoTLFe44maFPK0My+EFM=;
  b=ecFQbw2EkHAaI7P7t1l96j4oVV8bP6hLj7gnMzaUKAjwLEnq4Dr7rT1/
   ptgzJiq2o0PjyNenVyd7c3Pv7ucU54QZSrD5yGLJqXahD3p5wCQebXu76
   IF5KnWBrSiCx8MyRkPFIuRINNSx5nOUwVt4j/FQDZ3PlbqZDzy+nE8S81
   ZTqY57tR/zyL5vrDpBkMBsp3x9bwmJBurTBK7pB1KW/suLlOuU4hZv8s7
   FliOJG8jaWehLozqJjdvPeACU45ZCnq38yUUiFjxEMuhtwcOIkc2/lpI8
   tw/WhTCNSDlVrzfPR0ABdyAso9mAp3LmU0X6lIaVel4G5QcSiGz7tN426
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969217"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266380"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266380"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>, Berg@web.codeaurora.org,
	Benjamin <benjamin.berg@intel.com>
Subject: [PATCH 07/15] wifi: mac80211: allow 64-bit radiotap timestamps
Date: Wed, 20 Dec 2023 04:37:55 +0200
Message-Id: <20231220043149.27acc3ad9d81.Ie3ce5eae33cce88fa01178e7aea94661ded1ac24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When reporting the radiotap timestamp, the mactime field is
usually unused, we take the data from the device_timestamp.
However, there can be cases where the radiotap timestamp is
better reported as a 64-bit value, so since the mactime is
free, add a flag to support using the mactime as a 64-bit
radiotap timestamp.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Benjamin <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h |  7 ++++++-
 net/mac80211/rx.c      | 13 +++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 00274d1cdeeb..58328d0c1cf5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1374,6 +1374,11 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  *	(including FCS) was received.
  * @RX_FLAG_MACTIME_PLCP_START: The timestamp passed in the RX status (@mactime
  *	field) is valid and contains the time the SYNC preamble was received.
+ * @RX_FLAG_MACTIME_IS_RTAP_TS64: The timestamp passed in the RX status @mactime
+ *	is only for use in the radiotap timestamp header, not otherwise a valid
+ *	@mactime value. Note this is a separate flag so that we continue to see
+ *	%RX_FLAG_MACTIME as unset. Also note that in this case the timestamp is
+ *	reported to be 64 bits wide, not just 32.
  * @RX_FLAG_NO_SIGNAL_VAL: The signal strength value is not present.
  *	Valid only for data frames (mainly A-MPDU)
  * @RX_FLAG_AMPDU_DETAILS: A-MPDU details are known, in particular the reference
@@ -1449,7 +1454,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_IV_STRIPPED		= BIT(4),
 	RX_FLAG_FAILED_FCS_CRC		= BIT(5),
 	RX_FLAG_FAILED_PLCP_CRC 	= BIT(6),
-	/* one free bit at 7 */
+	RX_FLAG_MACTIME_IS_RTAP_TS64	= BIT(7),
 	RX_FLAG_NO_SIGNAL_VAL		= BIT(8),
 	RX_FLAG_AMPDU_DETAILS		= BIT(9),
 	RX_FLAG_PN_VALIDATED		= BIT(10),
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bbfdcb0ade72..a57c8272c1dc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -566,7 +566,8 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 
 	if (local->hw.radiotap_timestamp.units_pos >= 0) {
 		u16 accuracy = 0;
-		u8 flags = IEEE80211_RADIOTAP_TIMESTAMP_FLAG_32BIT;
+		u8 flags;
+		u64 ts;
 
 		rthdr->it_present |=
 			cpu_to_le32(BIT(IEEE80211_RADIOTAP_TIMESTAMP));
@@ -575,7 +576,15 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 		while ((pos - (u8 *)rthdr) & 7)
 			pos++;
 
-		put_unaligned_le64(status->device_timestamp, pos);
+		if (status->flag & RX_FLAG_MACTIME_IS_RTAP_TS64) {
+			flags = IEEE80211_RADIOTAP_TIMESTAMP_FLAG_64BIT;
+			ts = status->mactime;
+		} else {
+			flags = IEEE80211_RADIOTAP_TIMESTAMP_FLAG_32BIT;
+			ts = status->device_timestamp;
+		}
+
+		put_unaligned_le64(ts, pos);
 		pos += sizeof(u64);
 
 		if (local->hw.radiotap_timestamp.accuracy >= 0) {
-- 
2.34.1


