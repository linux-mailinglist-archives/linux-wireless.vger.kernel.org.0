Return-Path: <linux-wireless+bounces-31669-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BXiHdE3immhIQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31669-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 20:38:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF811142B5
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 20:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7150630074F5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECFF425CC0;
	Mon,  9 Feb 2026 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgdM45FL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085E3F23C3;
	Mon,  9 Feb 2026 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665930; cv=none; b=S8aRIsL4N0XSYN5iqEO8bNc7T5Gtzmim8je5pRX4T6/Iku1Thih9gNPdeCJYlqWch+GWzKQg8GlmhXeAcd+Erjw1IEaAmrtZRBs9QpsHHdXQDlhWe4Dz5QFV3jFgrFEMvPJjTcqsq92LWPUmClYKp8ljEc9hBZGVKb7WseYfNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665930; c=relaxed/simple;
	bh=bievALuSgn9dvP7F/aksHrAK3+JGgzx8RvdpU1TEr44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g/NWzJHnDJT8Mzqjj0VRktLkrmVYYWMiK4RNoVX1TgjLKrFORxW+2r8OGQLV7e0wt5qc3r6IROIWw2CyruSQU+StWWcprMbt2JlQFxwn21X0wEJWPBERxksFyP4IY6q92q/32Kfu+19ZRVwLDnPq7vx3NbO1MxI3y696LNE/NYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgdM45FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87429C116C6;
	Mon,  9 Feb 2026 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770665929;
	bh=bievALuSgn9dvP7F/aksHrAK3+JGgzx8RvdpU1TEr44=;
	h=Date:From:To:Cc:Subject:From;
	b=sgdM45FLO8ObgNA0IaU6Cs6L6RzqUubeVbfDXjXTotZ80pnv+wlkI3hVVHdoupFl0
	 tom/RdYpZ0R67fsEQA/eCVbVMNdD89g0qWPDTBMjoTIzGMjt4HTW5LDBAQY++yz7HF
	 cBrRr3Pz5UF0IFSkhdlxAoA6uQ4fsictVPh703Oij11B2oZraUqsjVVeCCnGHYbXv2
	 SkRMH1CA6sbVdoGnfCYVeNjMEZU8D4KAZ4d9HmQeQAr8OKa5P1T6bBfGyCuWhBG5e0
	 fA++jB/ohqKL6iDrkd9KEi1iAKzHOPjhD9C69NlDIzC0rbeq3uI9qdJtqPOw7XzS70
	 mBetGzziPRU6Q==
Date: Mon, 9 Feb 2026 13:38:15 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aYlkt2WP2oQ1TgeH@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31669-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[wp.pl,sipsolutions.net];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavoars@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DF811142B5
X-Rspamd-Action: no action

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declarations (which in a couple of cases happen
to be in a union, so the entire unions are moved) to the end of the
corresponding structures. Notice that `struct il_tx_beacon_cmd`,
`struct il4965_tx_resp`, and `struct il3945_tx_beacon_cmd` are flexible
structures, this is structures that contain a flexible-array member.

The case for struct il4965_beacon_notif is different. Since this
structure is defined by hardware, we use the struct_group() helper
to create the new `struct il4965_tx_resp_hdr` type. We then use this newly
created type to replace the obhect type of  causing trouble in
struct il4965_beacon_notif, namely `stryct il4965_tx_resp`.

In order to preserve the memory layout in struct il4965_beacon_notif,
add member `__le32 beacon_tx_status`, which was previously included
by `struct il4965_tx_resp` (as `__le32 status`), but it's not present
in the newly created type `struct il4965_tx_resp_hdr`.

Notice that after this changes, the size of struct il4965_beacon_notif
along with its member's offsets remain the same, hence the memory
layout doesn't change:

Before changes:
struct il4965_beacon_notif {
	struct il4965_tx_resp      beacon_notify_hdr;    /*     0    24 */
	__le32                     low_tsf;              /*    24     4 */
	__le32                     high_tsf;             /*    28     4 */
	__le32                     ibss_mgr_status;      /*    32     4 */

	/* size: 36, cachelines: 1, members: 4 */
	/* last cacheline: 36 bytes */
};

After changes:
struct il4965_beacon_notif {
	struct il4965_tx_resp_hdr  beacon_notify_hdr;    /*     0    20 */
	__le32                     beacon_tx_status;     /*    20     4 */
	__le32                     low_tsf;              /*    24     4 */
	__le32                     high_tsf;             /*    28     4 */
	__le32                     ibss_mgr_status;      /*    32     4 */

	/* size: 36, cachelines: 1, members: 5 */
	/* last cacheline: 36 bytes */
};

We also want to ensure that when new members are added to the flexible
structure `struct il4965_tx_resp` (if any), they are always included
within the newly created struct type. To enforce this, we use
`static_assert()` (which is intentionally placed right after the struct,
this is, no blank line in between). This ensures that the memory layout
of both the flexible structure and the new `struct il4965_tx_resp_hdr`
type remains consistent after any changes.

Lastly, refactor the rest of the code, accordingly.

With these changes fix the following warnings:

11 drivers/net/wireless/intel/iwlegacy/common.h:526:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
11 drivers/net/wireless/intel/iwlegacy/commands.h:2667:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
4 drivers/net/wireless/intel/iwlegacy/3945.h:131:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use the struct_group() helper, and update the conflicting type
   (struct il4965_tx_resp -> struct il4965_tx_resp_hdr) in
   struct il4965_beacon_notif.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aR2CtqZI3atH0HmE@kspp/

 drivers/net/wireless/intel/iwlegacy/3945.h    |  4 +-
 .../net/wireless/intel/iwlegacy/4965-mac.c    |  2 +-
 .../net/wireless/intel/iwlegacy/commands.h    | 41 +++++++++++--------
 drivers/net/wireless/intel/iwlegacy/common.h  |  4 +-
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945.h b/drivers/net/wireless/intel/iwlegacy/3945.h
index fb1e33c89d0e..ed63b31fee9a 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.h
+++ b/drivers/net/wireless/intel/iwlegacy/3945.h
@@ -123,13 +123,15 @@ enum il3945_antenna {
 #define IEEE80211_FRAME_LEN             (IEEE80211_DATA_LEN + IEEE80211_HLEN)
 
 struct il3945_frame {
+	struct list_head list;
+
+	/* Must be last as it ends in a flexible-array member. */
 	union {
 		struct ieee80211_hdr frame;
 		struct il3945_tx_beacon_cmd beacon;
 		u8 raw[IEEE80211_FRAME_LEN];
 		u8 cmd[360];
 	} u;
-	struct list_head list;
 };
 
 #define SUP_RATE_11A_MAX_NUM_CHANNELS  8
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 57fa866efd9f..f5a99a2ee95a 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -4076,7 +4076,7 @@ il4965_hdl_beacon(struct il_priv *il, struct il_rx_buf *rxb)
 	u8 rate = il4965_hw_get_rate(beacon->beacon_notify_hdr.rate_n_flags);
 
 	D_RX("beacon status %x retries %d iss %d tsf:0x%.8x%.8x rate %d\n",
-	     le32_to_cpu(beacon->beacon_notify_hdr.u.status) & TX_STATUS_MSK,
+	     le32_to_cpu(beacon->beacon_tx_status) & TX_STATUS_MSK,
 	     beacon->beacon_notify_hdr.failure_frame,
 	     le32_to_cpu(beacon->ibss_mgr_status),
 	     le32_to_cpu(beacon->high_tsf), le32_to_cpu(beacon->low_tsf), rate);
diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
index b61b8f377702..630bc12cd0d5 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -1691,22 +1691,25 @@ struct agg_tx_status {
 } __packed;
 
 struct il4965_tx_resp {
-	u8 frame_count;		/* 1 no aggregation, >1 aggregation */
-	u8 bt_kill_count;	/* # blocked by bluetooth (unused for agg) */
-	u8 failure_rts;		/* # failures due to unsuccessful RTS */
-	u8 failure_frame;	/* # failures due to no ACK (unused for agg) */
-
-	/* For non-agg:  Rate at which frame was successful.
-	 * For agg:  Rate at which all frames were transmitted. */
-	__le32 rate_n_flags;	/* RATE_MCS_*  */
-
-	/* For non-agg:  RTS + CTS + frame tx attempts time + ACK.
-	 * For agg:  RTS + CTS + aggregation tx time + block-ack time. */
-	__le16 wireless_media_time;	/* uSecs */
-
-	__le16 reserved;
-	__le32 pa_power1;	/* RF power amplifier measurement (not used) */
-	__le32 pa_power2;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(il4965_tx_resp_hdr, __hdr, __packed,
+		u8 frame_count;		/* 1 no aggregation, >1 aggregation */
+		u8 bt_kill_count;	/* # blocked by bluetooth (unused for agg) */
+		u8 failure_rts;		/* # failures due to unsuccessful RTS */
+		u8 failure_frame;	/* # failures due to no ACK (unused for agg) */
+
+		/* For non-agg:  Rate at which frame was successful.
+		 * For agg:  Rate at which all frames were transmitted. */
+		__le32 rate_n_flags;	/* RATE_MCS_*  */
+
+		/* For non-agg:  RTS + CTS + frame tx attempts time + ACK.
+		 * For agg:  RTS + CTS + aggregation tx time + block-ack time. */
+		__le16 wireless_media_time;	/* uSecs */
+
+		__le16 reserved;
+		__le32 pa_power1;	/* RF power amplifier measurement (not used) */
+		__le32 pa_power2;
+	);
 
 	/*
 	 * For non-agg:  frame status TX_STATUS_*
@@ -1726,6 +1729,9 @@ struct il4965_tx_resp {
 		DECLARE_FLEX_ARRAY(struct agg_tx_status, agg_status);	/* for each agg frame */
 	} u;
 } __packed;
+static_assert(offsetof(struct il4965_tx_resp, u.agg_status) ==
+	      sizeof(struct il4965_tx_resp_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /*
  * N_COMPRESSED_BA = 0xc5 (response only, not a command)
@@ -2664,7 +2670,8 @@ struct il3945_beacon_notif {
 } __packed;
 
 struct il4965_beacon_notif {
-	struct il4965_tx_resp beacon_notify_hdr;
+	struct il4965_tx_resp_hdr beacon_notify_hdr;
+	__le32 beacon_tx_status;
 	__le32 low_tsf;
 	__le32 high_tsf;
 	__le32 ibss_mgr_status;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 4c9836ab11dd..21f1c7702add 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -518,13 +518,15 @@ struct il_channel_info {
 #define IEEE80211_FRAME_LEN             (IEEE80211_DATA_LEN + IEEE80211_HLEN)
 
 struct il_frame {
+	struct list_head list;
+
+	/* Must be last as it ends in a flexible-array member. */
 	union {
 		struct ieee80211_hdr frame;
 		struct il_tx_beacon_cmd beacon;
 		u8 raw[IEEE80211_FRAME_LEN];
 		u8 cmd[360];
 	} u;
-	struct list_head list;
 };
 
 enum {
-- 
2.43.0


