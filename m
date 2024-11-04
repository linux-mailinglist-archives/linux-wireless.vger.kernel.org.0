Return-Path: <linux-wireless+bounces-14861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832069BB196
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF81C21AF8
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0F1B4F08;
	Mon,  4 Nov 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkMozE8h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA661B21BE;
	Mon,  4 Nov 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717458; cv=none; b=huWzWGo8PyItqrQHdEwctUbbqZ+j6qJaDpeyChUBdjKCsi+mD5yIAqwSfVbxpd8ekyl5JwR0fgdy/BMbHZ2x2NucyfiEcfUfB7y5dlCZ/CY7jSz+Sf9sCdIqKtgf00/K7+ID99oCYU4zoQ7w0k9gBy5NdIVnyHQNKOpe8D8R204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717458; c=relaxed/simple;
	bh=OnlJrLERf88DH2l/8ZAe8lCpis5DgArRDiCCaz5bhns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrL/ZXg9nUjy38rxX2IJfvaBe1MO9kl+OluBsqAODWIgxBWD9EZSwwfdplptB5DhEY5qrh/xtSvxscOfrYKfiXCs42NZPw3EYk/1y64t5gKtvpl6P7GN4FogsIInd7FKJgVU7p+mDGpFq5zt3ZD9Xf63DQfxjDZ1iCXZ6ELyuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkMozE8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47253C4CED1;
	Mon,  4 Nov 2024 10:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717458;
	bh=OnlJrLERf88DH2l/8ZAe8lCpis5DgArRDiCCaz5bhns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkMozE8hLTavp8mBU6RcmLYBdbFuCAUFKobwyg9chddG0kRlfksyJbhzr2Fhs+P37
	 aYV3P6Icj2ZAv2/VrZ6zLnu8FtVi2a7n5E9omT+ILtrJvYE9+RWPp1SDp7mrVw7iTy
	 dT3cPDZnbjIDCFXmjsSxOoKLkXAZDwJVb4+neHNaYE27RXhNWSMSvWKDt6gHxxGhod
	 Pbr1p9Mwo4MTKhi6kNA/aDrZhE8UETp2Q3iAOyKc4POyP5BAaAweSASo4II9C1/xgh
	 p+9TfZbZjoYwfBrl0ZSqf/g1nmjd2cGP2cHvoiviDgBGZTkdfp03r9EBTTPaZNHGAG
	 yg7ITzAsFcWXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	stas.yakovlev@gmail.com,
	ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	libertas-dev@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 04/21] wifi: radiotap: Avoid -Wflex-array-member-not-at-end warnings
Date: Mon,  4 Nov 2024 05:49:40 -0500
Message-ID: <20241104105048.96444-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 57be3d3562ca4aa62b8047bc681028cc402af8ce ]

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `__struct_group()`
helper to create a new tagged `struct ieee80211_radiotap_header_fixed`.
This structure groups together all the members of the flexible
`struct ieee80211_radiotap_header` except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct ieee80211_radiotap_header` to `struct
ieee80211_radiotap_header_fixed`.

We also want to ensure that in case new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct ieee80211_radiotap_header_fixed`
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
Link: https://patch.msgid.link/ZwBMtBZKcrzwU7l4@kspp
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index f29ac6de71399..19702b6f09c32 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -306,7 +306,7 @@ static void wil_rx_add_radiotap_header(struct wil6210_priv *wil,
 				       struct sk_buff *skb)
 {
 	struct wil6210_rtap {
-		struct ieee80211_radiotap_header rthdr;
+		struct ieee80211_radiotap_header_fixed rthdr;
 		/* fields should be in the order of bits in rthdr.it_present */
 		/* flags */
 		u8 flags;
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index b6636002c7d22..fe75941c584d1 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -2518,7 +2518,7 @@ static void isr_rx_monitor(struct ipw2100_priv *priv, int i,
 	 * to build this manually element by element, we can write it much
 	 * more efficiently than we can parse it. ORDER MATTERS HERE */
 	struct ipw_rt_hdr {
-		struct ieee80211_radiotap_header rt_hdr;
+		struct ieee80211_radiotap_header_fixed rt_hdr;
 		s8 rt_dbmsignal; /* signal in dbM, kluged to signed */
 	} *ipw_rt;
 
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.h b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
index 8ebf09121e173..226286cb7eb82 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.h
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.h
@@ -1143,7 +1143,7 @@ struct ipw_prom_priv {
  * structure is provided regardless of any bits unset.
  */
 struct ipw_rt_hdr {
-	struct ieee80211_radiotap_header rt_hdr;
+	struct ieee80211_radiotap_header_fixed rt_hdr;
 	u64 rt_tsf;      /* TSF */	/* XXX */
 	u8 rt_flags;	/* radiotap packet flags */
 	u8 rt_rate;	/* rate in 500kb/s */
diff --git a/drivers/net/wireless/marvell/libertas/radiotap.h b/drivers/net/wireless/marvell/libertas/radiotap.h
index 1ed5608d353ff..d543bfe739dcb 100644
--- a/drivers/net/wireless/marvell/libertas/radiotap.h
+++ b/drivers/net/wireless/marvell/libertas/radiotap.h
@@ -2,7 +2,7 @@
 #include <net/ieee80211_radiotap.h>
 
 struct tx_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_fixed hdr;
 	u8 rate;
 	u8 txpower;
 	u8 rts_retries;
@@ -31,7 +31,7 @@ struct tx_radiotap_hdr {
 #define IEEE80211_FC_DSTODS          0x0300
 
 struct rx_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_fixed hdr;
 	u8 flags;
 	u8 rate;
 	u8 antsignal;
diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wireless/microchip/wilc1000/mon.c
index 03b7229a0ff5a..c3d27aaec2974 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -7,12 +7,12 @@
 #include "cfg80211.h"
 
 struct wilc_wfi_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_fixed hdr;
 	u8 rate;
 } __packed;
 
 struct wilc_wfi_radiotap_cb_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_fixed hdr;
 	u8 rate;
 	u8 dump;
 	u16 tx_flags;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 5fe9e4e261429..52468e16c3df6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -763,7 +763,7 @@ static const struct rhashtable_params hwsim_rht_params = {
 };
 
 struct hwsim_radiotap_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_fixed hdr;
 	__le64 rt_tsft;
 	u8 rt_flags;
 	u8 rt_rate;
@@ -772,7 +772,7 @@ struct hwsim_radiotap_hdr {
 } __packed;
 
 struct hwsim_radiotap_ack_hdr {
-	struct ieee80211_radiotap_header hdr;
+	struct ieee80211_radiotap_header_fixed hdr;
 	u8 rt_flags;
 	u8 pad;
 	__le16 rt_channel;
diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 91762faecc13d..1458d3695005a 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -24,25 +24,27 @@
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
+	__struct_group(ieee80211_radiotap_header_fixed, hdr, __packed,
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
@@ -50,6 +52,9 @@ struct ieee80211_radiotap_header {
 	__le32 it_optional[];
 } __packed;
 
+static_assert(offsetof(struct ieee80211_radiotap_header, it_optional) == sizeof(struct ieee80211_radiotap_header_fixed),
+	      "struct member likely outside of __struct_group()");
+
 /* version is always 0 */
 #define PKTHDR_RADIOTAP_VERSION	0
 
-- 
2.43.0


