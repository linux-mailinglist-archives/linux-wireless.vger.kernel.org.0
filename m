Return-Path: <linux-wireless+bounces-11042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA3B949748
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 20:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0F2284AFC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981304594C;
	Tue,  6 Aug 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwIOFLNt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEA40875;
	Tue,  6 Aug 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967696; cv=none; b=WpLKuyg53hSS2SK8KYyY2pNCRtKH8byuzB9NtNqsUe1qRqmI1xarMnsFd5miXLHg9nAOGSzP2YnIUOiXGeog9JrEEAOsjNLpwxn1qGOQ2UmWGe6G+AXHrjDpudcevb9DwUCygqHcFXtx3DnUGN0aAo4c/G/MC+YqitKyOTHYD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967696; c=relaxed/simple;
	bh=Pio7eRsl6VoHHo6puRlzv4zHn+1CVPdub+C7U9Kagxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TaFVHU/aZp2FU6hd6Da6ulbjE8rqraLq43KQGeTS4lSw/wNfdmZobSuP3GYgP2uAdchab3w7jT5nI52KRfcsARsRFVr/LNLtGDWnQrFltHr/zrfiYUgaPPjUlO5RR4++a5E6QGd/rkTe9fnsXndHmJZBZ5qOvCzSiC/sz2O5SNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwIOFLNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6948C32786;
	Tue,  6 Aug 2024 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722967695;
	bh=Pio7eRsl6VoHHo6puRlzv4zHn+1CVPdub+C7U9Kagxk=;
	h=Date:From:To:Cc:Subject:From;
	b=XwIOFLNtUlDroHzZABNmcYxAgszzcVKJPvG8vl5YoRyX2QqXUdOpjoGVeo9O7D1Vz
	 FdI52FqxhlPMtT4XSdgSFS5xuhsGkFemJGPuxX1XETTbjiy3bNyYwJ8H//9xPpNwqC
	 m7uiiEwJ6gHbE5Hjtbq7YqY4ABpdCean6Vtoq76LQouWOT7AMvaEmKmsCJjKN57rWx
	 8e9/4tWMBFlGPSrN8g1Xhx4iJK7k/2q20k3CfKpx+b3w3Er9W8WHDmrsIcIUrbCem1
	 j/B7DfPmn8ObOK0PSZSkzgJVf0GabeLFbcK4sF+JD2U2smpJar1umAJB3JS4yCIKJw
	 gJkOhNKoP6dGw==
Date: Tue, 6 Aug 2024 12:08:12 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	libertas-dev@lists.infradead.org, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: radiotap: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZrJmjM4izqDqwIrc@cute>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `__struct_group()`
helper to create a new tagged `struct ieee80211_radiotap_header_hdr`.
This structure groups together all the members of the flexible
`struct ieee80211_radiotap_header` except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct ieee80211_radiotap_header` to `struct
ieee80211_radiotap_header_hdr`.

We also want to ensure that in case new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct ieee80211_radiotap_header_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

So, with these changes, fix the following warnings:
drivers/net/wireless/ath/wil6210/txrx.c:309:50: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/ipw2100.c:2521:50: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/ipw2200.h:1146:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/ipw2x00/libipw.h:595:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/marvell/libertas/radiotap.h:34:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/marvell/libertas/radiotap.h:5:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/microchip/wilc1000/mon.c:10:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/microchip/wilc1000/mon.c:15:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/virtual/mac80211_hwsim.c:758:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/virtual/mac80211_hwsim.c:767:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/wil6210/txrx.c       |  2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  |  2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.h  |  2 +-
 .../net/wireless/marvell/libertas/radiotap.h  |  4 +-
 drivers/net/wireless/microchip/wilc1000/mon.c |  4 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 +-
 include/net/ieee80211_radiotap.h              | 43 +++++++++++--------
 7 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index f29ac6de7139..b7cc29939d59 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -306,7 +306,7 @@ static void wil_rx_add_radiotap_header(struct wil6210_priv *wil,
 				       struct sk_buff *skb)
 {
 	struct wil6210_rtap {
-		struct ieee80211_radiotap_header rthdr;
+		struct ieee80211_radiotap_header_hdr rthdr;
 		/* fields should be in the order of bits in rthdr.it_present */
 		/* flags */
 		u8 flags;
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index b6636002c7d2..9d5524c8e95d 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -2518,7 +2518,7 @@ static void isr_rx_monitor(struct ipw2100_priv *priv, int i,
 	 * to build this manually element by element, we can write it much
 	 * more efficiently than we can parse it. ORDER MATTERS HERE */
 	struct ipw_rt_hdr {
-		struct ieee80211_radiotap_header rt_hdr;
+		struct ieee80211_radiotap_header_hdr rt_hdr;
 		s8 rt_dbmsignal; /* signal in dbM, kluged to signed */
 	} *ipw_rt;
 
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 8ebf09121e17..becdd3bc5235 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -1143,7 +1143,7 @@ struct ipw_prom_priv {
  * structure is provided regardless of any bits unset.
  */
 struct ipw_rt_hdr {
-	struct ieee80211_radiotap_header rt_hdr;
+	struct ieee80211_radiotap_header_hdr rt_hdr;
 	u64 rt_tsf;      /* TSF */	/* XXX */
 	u8 rt_flags;	/* radiotap packet flags */
 	u8 rt_rate;	/* rate in 500kb/s */
diff --git a/drivers/net/wireless/marvell/libertas/radiotap.h b/drivers/net/wireless/marvell/libertas/radiotap.h
index 1ed5608d353f..95b427196f5a 100644
--- a/drivers/net/wireless/marvell/libertas/radiotap.h
+++ b/drivers/net/wireless/marvell/libertas/radiotap.h
@@ -2,7 +2,7 @@
 #include <net/ieee80211_radiotap.h>
 
 struct tx_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_hdr hdr;
 	u8 rate;
 	u8 txpower;
 	u8 rts_retries;
@@ -31,7 +31,7 @@ struct tx_radiotap_hdr {
 #define IEEE80211_FC_DSTODS          0x0300
 
 struct rx_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_hdr hdr;
 	u8 flags;
 	u8 rate;
 	u8 antsignal;
diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wireless/microchip/wilc1000/mon.c
index 03b7229a0ff5..56cdc7a193dd 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -7,12 +7,12 @@
 #include "cfg80211.h"
 
 struct wilc_wfi_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_hdr hdr;
 	u8 rate;
 } __packed;
 
 struct wilc_wfi_radiotap_cb_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_hdr hdr;
 	u8 rate;
 	u8 dump;
 	u16 tx_flags;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index d86e6ff4523d..6ab0f3a6f26c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -763,7 +763,7 @@ static const struct rhashtable_params hwsim_rht_params = {
 };
 
 struct hwsim_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_hdr hdr;
 	__le64 rt_tsft;
 	u8 rt_flags;
 	u8 rt_rate;
@@ -772,7 +772,7 @@ struct hwsim_radiotap_hdr {
 } __packed;
 
 struct hwsim_radiotap_ack_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_hdr hdr;
 	u8 rt_flags;
 	u8 pad;
 	__le16 rt_channel;
diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 91762faecc13..029137023779 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -24,31 +24,36 @@
  * struct ieee80211_radiotap_header - base radiotap header
  */
 struct ieee80211_radiotap_header {
-	/**
-	 * @it_version: radiotap version, always 0
-	 */
-	uint8_t it_version;
-
-	/**
-	 * @it_pad: padding (or alignment)
-	 */
-	uint8_t it_pad;
-
-	/**
-	 * @it_len: overall radiotap header length
-	 */
-	__le16 it_len;
-
-	/**
-	 * @it_present: (first) present word
-	 */
-	__le32 it_present;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(ieee80211_radiotap_header_hdr, hdr, __packed,
+		/**
+		 * @it_version: radiotap version, always 0
+		 */
+		uint8_t it_version;
+
+		/**
+		 * @it_pad: padding (or alignment)
+		 */
+		uint8_t it_pad;
+
+		/**
+		 * @it_len: overall radiotap header length
+		 */
+		__le16 it_len;
+
+		/**
+		 * @it_present: (first) present word
+		 */
+		__le32 it_present;
+	);
 
 	/**
 	 * @it_optional: all remaining presence bitmaps
 	 */
 	__le32 it_optional[];
 } __packed;
+static_assert(offsetof(struct ieee80211_radiotap_header, it_optional) == sizeof(struct ieee80211_radiotap_header_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /* version is always 0 */
 #define PKTHDR_RADIOTAP_VERSION	0
-- 
2.34.1


