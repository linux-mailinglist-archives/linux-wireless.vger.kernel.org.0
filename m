Return-Path: <linux-wireless+bounces-22963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2FAB781C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D97B651D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D748221FC0;
	Wed, 14 May 2025 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhijWoAy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EB221F35;
	Wed, 14 May 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258953; cv=none; b=Kx96Po81wQcebc2Ybti7X+7AtWEyEeEWcnBnDBuLc4AhIjFGV9kxXBkMe67ogG+P/NorTcsvZ/MOUlSGCTRYm+oxTGoYu2Tg7Uh0iqbhXdQsNxdUVdaKYluq9xqWVUfZhsPu4+YO/tgpqmX0xe7TjboPTR6CpPHOnE3fUkMR0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258953; c=relaxed/simple;
	bh=TasTW5iZCDuPstVF8wJUlKJ9vaBQQ1wm4aP4Dzf3XPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BQHt+gP3O8qRnLBK+APpNf/2Lq2xpbmyJNTRBAxF6TrcJxgk/iIuDyzy7tVum9nMtEDBhIDx4SV4h0PKYH7++/wYbP3VJDbvjvVOmjZRoVXKw0IroFOGx3yJ5ZTUJYT3N1B+BqFagYska993qSpJmGbdZ7jM9e95p94LbfOn1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhijWoAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F158DC4CEE3;
	Wed, 14 May 2025 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747258953;
	bh=TasTW5iZCDuPstVF8wJUlKJ9vaBQQ1wm4aP4Dzf3XPM=;
	h=Date:From:To:Cc:Subject:From;
	b=qhijWoAyAjAF/hRTtKYyCog7hVOuPqhfGN1rwXLTEiw4JKiOoDnRFJHGxyncUFubS
	 fHStjRJ1rsQfd+suHaOIto4lEQgHOwuNXdP2USXAAS6eWUcEbsS6JzjzDYhU+u8loN
	 o6NX2WCw59OFbVTDOrPGW8h0+04hXz0joXUGyPwy/NKFzDjPoFjsZKarJUDF8KDoT3
	 ON2I9MMfbXVCvbpg298I/z4YFw1ZLyhc5mRnWRiDWCxcW7yCX+Rb4Zlcm6pCmHBUf0
	 rhRwATsNsxmvHf6J7+A3T/nRpTK7H0Is8roTCFsHXe0f47Y27B5PwXl4/5ZlRZ78Bb
	 QRtsgT+MOU+YA==
Date: Wed, 14 May 2025 15:42:27 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v3][next] wifi: iwlwifi: mvm/fw: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <aCUOQ6wdD1jQjO36@kspp>
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
helper to create a new tagged `struct iwl_tx_cmd_v6_hdr`. This
structure groups together all the members of the flexible `struct
iwl_tx_cmd_v6` except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct iwl_tx_cmd_v6` to `struct iwl_tx_cmd_v6_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct iwl_tx_cmd_v6_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

Also, as part of the refactoring required to use `__struct_group()`,
remove unused flex array `payload`.

So, with these changes, fix the following warnings:

drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Rebase on top of commit e4248670c0ae ("wifi: iwlwifi: use normal versioning convention for iwl_tx_cmd")

Changes in v2:
 - Update changelog text - mention removal of flex array `payload`.
   (Kees)
 - Fix kernel-doc block. (Johannes).
 - Add RB tag.
 - Link: https://lore.kernel.org/linux-hardening/aAv7RiLsmXq5d0ge@kspp/

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-9G-GHufhXKeYft@kspp/

 .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 63 ++++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 10 +--
 4 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
index 58d5a6ef633e..84cb7faac647 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
@@ -50,7 +50,7 @@ struct iwl_tdls_channel_switch_timing {
  */
 struct iwl_tdls_channel_switch_frame {
 	__le32 switch_time_offset;
-	struct iwl_tx_cmd_v6 tx_cmd;
+	struct iwl_tx_cmd_v6_hdr tx_cmd;
 	u8 data[IWL_TDLS_CH_SW_FRAME_MAX_SIZE];
 } __packed; /* TDLS_STA_CHANNEL_SWITCH_FRAME_API_S_VER_1 */
 
@@ -131,7 +131,7 @@ struct iwl_tdls_config_cmd {
 	struct iwl_tdls_sta_info sta_info[IWL_TDLS_STA_COUNT];
 
 	__le32 pti_req_data_offset;
-	struct iwl_tx_cmd_v6 pti_req_tx_cmd;
+	struct iwl_tx_cmd_v6_hdr pti_req_tx_cmd;
 	u8 pti_req_template[];
 } __packed; /* TDLS_CONFIG_CMD_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 557832563f89..05860687aba0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -205,8 +205,7 @@ enum iwl_tx_offload_assist_flags_pos {
  * @tid_tspec: TID/tspec
  * @pm_frame_timeout: PM TX frame timeout
  * @reserved4: reserved
- * @payload: payload (same as @hdr)
- * @hdr: 802.11 header (same as @payload)
+ * @hdr: 802.11 header
  *
  * The byte count (both len and next_frame_len) includes MAC header
  * (24/26/30/32 bytes)
@@ -222,34 +221,36 @@ enum iwl_tx_offload_assist_flags_pos {
  * and then the actial payload.
  */
 struct iwl_tx_cmd_v6 {
-	__le16 len;
-	__le16 offload_assist;
-	__le32 tx_flags;
-	struct {
-		u8 try_cnt;
-		u8 btkill_cnt;
-		__le16 reserved;
-	} scratch; /* DRAM_SCRATCH_API_U_VER_1 */
-	__le32 rate_n_flags;
-	u8 sta_id;
-	u8 sec_ctl;
-	u8 initial_rate_index;
-	u8 reserved2;
-	u8 key[16];
-	__le32 reserved3;
-	__le32 life_time;
-	__le32 dram_lsb_ptr;
-	u8 dram_msb_ptr;
-	u8 rts_retry_limit;
-	u8 data_retry_limit;
-	u8 tid_tspec;
-	__le16 pm_frame_timeout;
-	__le16 reserved4;
-	union {
-		DECLARE_FLEX_ARRAY(u8, payload);
-		DECLARE_FLEX_ARRAY(struct ieee80211_hdr, hdr);
-	};
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(iwl_tx_cmd_v6_hdr, __hdr, __packed,
+		__le16 len;
+		__le16 offload_assist;
+		__le32 tx_flags;
+		struct {
+			u8 try_cnt;
+			u8 btkill_cnt;
+			__le16 reserved;
+		} scratch; /* DRAM_SCRATCH_API_U_VER_1 */
+		__le32 rate_n_flags;
+		u8 sta_id;
+		u8 sec_ctl;
+		u8 initial_rate_index;
+		u8 reserved2;
+		u8 key[16];
+		__le32 reserved3;
+		__le32 life_time;
+		__le32 dram_lsb_ptr;
+		u8 dram_msb_ptr;
+		u8 rts_retry_limit;
+		u8 data_retry_limit;
+		u8 tid_tspec;
+		__le16 pm_frame_timeout;
+		__le16 reserved4;
+	);
+	struct ieee80211_hdr hdr[];
 } __packed; /* TX_CMD_API_S_VER_6 */
+static_assert(offsetof(struct iwl_tx_cmd_v6, hdr) == sizeof(struct iwl_tx_cmd_v6_hdr),
+	      "struct member likely outside of __struct_group()");
 
 struct iwl_dram_sec_info {
 	__le32 pn_low;
@@ -748,7 +749,7 @@ struct iwl_compressed_ba_notif {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v6 {
-	struct iwl_tx_cmd_v6 tx;
+	struct iwl_tx_cmd_v6_hdr tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
@@ -767,7 +768,7 @@ struct iwl_mac_beacon_cmd_v6 {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v7 {
-	struct iwl_tx_cmd_v6 tx;
+	struct iwl_tx_cmd_v6_hdr tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 9098a36530cc..67139f704e2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1039,7 +1039,9 @@ static int iwl_mvm_mac_ctxt_send_beacon_v6(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mac_beacon_cmd_v6 beacon_cmd = {};
 
-	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
+	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon,
+				container_of(&beacon_cmd.tx,
+					     struct iwl_tx_cmd_v6, __hdr));
 
 	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
 
@@ -1059,7 +1061,9 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mac_beacon_cmd_v7 beacon_cmd = {};
 
-	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
+	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon,
+				container_of(&beacon_cmd.tx,
+					     struct iwl_tx_cmd_v6, __hdr));
 
 	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 36379b738de1..d475a2fb9c59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -342,6 +342,8 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 	struct iwl_tdls_channel_switch_cmd_tail *tail =
 		iwl_mvm_chan_info_cmd_tail(mvm, &cmd.ci);
 	u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
+	struct iwl_tx_cmd_v6 *tx_cmd =
+		container_of(&tail->frame.tx_cmd, struct iwl_tx_cmd_v6, __hdr);
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -410,14 +412,12 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 			ret = -EINVAL;
 			goto out;
 		}
-		iwl_mvm_set_tx_cmd_ccmp(info, &tail->frame.tx_cmd);
+		iwl_mvm_set_tx_cmd_ccmp(info, tx_cmd);
 	}
 
-	iwl_mvm_set_tx_cmd(mvm, skb, &tail->frame.tx_cmd, info,
-			   mvmsta->deflink.sta_id);
+	iwl_mvm_set_tx_cmd(mvm, skb, tx_cmd, info, mvmsta->deflink.sta_id);
 
-	iwl_mvm_set_tx_cmd_rate(mvm, &tail->frame.tx_cmd, info, sta,
-				hdr->frame_control);
+	iwl_mvm_set_tx_cmd_rate(mvm, tx_cmd, info, sta, hdr->frame_control);
 	rcu_read_unlock();
 
 	memcpy(tail->frame.data, skb->data, skb->len);
-- 
2.43.0


