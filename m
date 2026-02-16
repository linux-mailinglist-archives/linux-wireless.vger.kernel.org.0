Return-Path: <linux-wireless+bounces-31916-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iRn9NJC1k2l17wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31916-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 01:25:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F631148424
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 01:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 599203019B94
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 00:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BA123BCED;
	Tue, 17 Feb 2026 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq/qYayK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA225776;
	Tue, 17 Feb 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771287948; cv=none; b=Y3Ou8lO9vgW5nc6jNy61fjgm8qFcKpij6t9T7Ml+U9CHY/R1e6XWiyHDEDmqrLxvpYU+7de2u+6LLX2Gf8LC97ExC1Zxu8g0IOO4/XFHmLxSD2/a/9tP3VuSmfiZ6MKlfP+7hy1L/Q2XliSPzj8k/Y0ZCVb+fI8K7s4gdYXf7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771287948; c=relaxed/simple;
	bh=rkO9TeYJjXaoRqDn1C2E/hz2Ji5SnWXXcrx0UOtXIHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j56MiLMY/AHu1E3CfZtTHj00IesZhZRcWZobE4dw5czgp5L0vIEATIWRaTJxRCD7rsSdZ2jux6//JX+W2+2ETN3Z2rk0+WO59e0ZnEkmQLsCkd1R6eUJQOFYwOIeVeAaQUmixhQ57//pjjaczIgYWhiZa9YcW9VmGlSVmypyMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq/qYayK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E8FC116C6;
	Tue, 17 Feb 2026 00:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771287947;
	bh=rkO9TeYJjXaoRqDn1C2E/hz2Ji5SnWXXcrx0UOtXIHc=;
	h=Date:From:To:Cc:Subject:From;
	b=gq/qYayKKSmXbrgnRUpAGxnKzybGJ01w77qP+V53ZzqJKicEc0HULJOHwBmDU/Huo
	 QKGnTGwFSND1mSIcIK8/I0KjVThykDdcddlSqxd1oOZjxKNc7NzgFmFVSBbQyWiWpq
	 SWUlGbiy3COwfUSRzgvKttnrkyfha/LBuO/CMnYMJ9q2AE9j9L2/9jOwG3PA43UUxu
	 wxJDGPlvKtoSIQCwE/Z5MCdlo74wwtKJj6AsAnGRhUS2kao6BlVZge+5rII9o+iSYY
	 JHtFvaHfoNmK+sYYDFzARAarNcxak61+OtElPSrxvDbb1Kas84+yXRaI9bS8adnrCQ
	 6UwgKKjccXNMw==
Date: Mon, 16 Feb 2026 18:25:14 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v4][next] wifi: iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aZLienEatf9KC6Rx@kspp>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[wp.pl,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-31916-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavoars@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F631148424
X-Rspamd-Action: no action

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declarations (which in a couple of cases happen
to be in a union, so the entire unions are moved) to the end of the
corresponding structures, struct il_frame, and struct il3945_frame.

Notice that `struct il_tx_beacon_cmd`, `struct il4965_tx_resp`, and
`struct il3945_tx_beacon_cmd` are flexible structures, this is
structures that contain a flexible-array member.

The case for struct il4965_beacon_notif is different. Since this
structure is defined by hardware, we create the new `struct
il4965_tx_resp_hdr` type. We then use this newly created type to
replace the object type causing trouble in struct il4965_beacon_notif,
namely `struct il4965_tx_resp`.

Also, once -fms-extensions is enabled, we can use transparent struct
members in struct il4965_tx_resp.

Notice that the newly created type does not contain the flex-array
member `agg_status`, which is the object causing the -Wfamnae warnings.
This object is currently in a union along with `__le32 status`, so
anything using struct il4965_beacon_notif needs to have its own view
of `status`. To preserve the memory layout, we therefore add member
`__le32 beacon_tx_status` to struct il4965_beacon_notif.

After these changes, the size of struct il4965_beacon_notif along
with its member's offsets remain the same, hence the memory layout
doesn't change:

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

Lastly, adjust the rest of the code, accordingly.

With these changes fix the following warnings:

11 drivers/net/wireless/intel/iwlegacy/common.h:526:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
11 drivers/net/wireless/intel/iwlegacy/commands.h:2667:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
4 drivers/net/wireless/intel/iwlegacy/3945.h:131:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v4:
 - (Aggh...) Fix a couple of typos in changelog text:
   		s/stryct/struct
   		s/il4965_beacon_notif/il4965_tx_resp.

Changes in v3:
 - Create new separate struct il4965_tx_resp_hdr, and use
   transparent struct members instead of __struct_group(). (Kees)
 - Update subject line - Add 'wifi:' prefix. (Stanislaw)
 - Link: https://lore.kernel.org/linux-hardening/aZLgfO6z1Gt8aiyc@kspp/

Changes in v2:
 - Use the struct_group() helper, and update the conflicting type
   (struct il4965_tx_resp -> struct il4965_tx_resp_hdr) in
   struct il4965_beacon_notif.
 - Link: https://lore.kernel.org/linux-hardening/aYlkt2WP2oQ1TgeH@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/aR2CtqZI3atH0HmE@kspp/

 drivers/net/wireless/intel/iwlegacy/3945.h     | 4 +++-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
 drivers/net/wireless/intel/iwlegacy/commands.h | 9 +++++++--
 drivers/net/wireless/intel/iwlegacy/common.h   | 4 +++-
 4 files changed, 14 insertions(+), 5 deletions(-)

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
index b61b8f377702..7aba84ac88a1 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -1690,7 +1690,7 @@ struct agg_tx_status {
 	__le16 sequence;
 } __packed;
 
-struct il4965_tx_resp {
+struct il4965_tx_resp_hdr {
 	u8 frame_count;		/* 1 no aggregation, >1 aggregation */
 	u8 bt_kill_count;	/* # blocked by bluetooth (unused for agg) */
 	u8 failure_rts;		/* # failures due to unsuccessful RTS */
@@ -1707,6 +1707,10 @@ struct il4965_tx_resp {
 	__le16 reserved;
 	__le32 pa_power1;	/* RF power amplifier measurement (not used) */
 	__le32 pa_power2;
+} __packed;
+
+struct il4965_tx_resp {
+	struct il4965_tx_resp_hdr;
 
 	/*
 	 * For non-agg:  frame status TX_STATUS_*
@@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
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


