Return-Path: <linux-wireless+bounces-11501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63F953B25
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3E7B25116
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50913C90F;
	Thu, 15 Aug 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G91gk2aX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104DD7E107;
	Thu, 15 Aug 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751644; cv=none; b=JccTYmAC7dtr95qCvezw7wrnUsWQGSRe7tcMFt7bUd4GmdLfPa8FD7lmaT6a6YQHTzf2V+R/nM5PwbHQp/dvsd934FFxcBWPIar2U6e43iJLMrUpgz9gZu9KZlco2qQwH7JOE5LALkybnL7lBYegEtB2SgJumf/zx42BS4lfwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751644; c=relaxed/simple;
	bh=/MSiDtu9Cn/LaWZWDf1KjZ7zd0cr9GbVv44CAZRY5BU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eEAXluOs1pMkH7Gh8Sship7R36b1czE4I9+17GdUgU5X8PaSNzVPv7gP2kg5PAc8CILgyqimVk3874v6rA+tkbRjXxv9KGnzr/IP6ZfNhXXUGJtKWpTaXphdcFqA4d6Nlf4jRFDlCZ+fUPXPlv2/afwWptUkZN36HIaJRdpap+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G91gk2aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21DEC32786;
	Thu, 15 Aug 2024 19:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723751643;
	bh=/MSiDtu9Cn/LaWZWDf1KjZ7zd0cr9GbVv44CAZRY5BU=;
	h=Date:From:To:Cc:Subject:From;
	b=G91gk2aXBRfqBIDH6Nk81EXG0SdWQ9rwasHahSggCmyPebdm0PdePYM5fdgD6Ngmv
	 tfdnbL/0s6L8pCCSLW1DBjYyQ153UN/Y6YvKLD3xva9tq/UjKm0hrbR1Rld76uxG+j
	 qhDjgdGRrf/8wka85YEki3wBnk1ydD5ms1s2Gify7BL1x2GN2KnfLM20RuMJJZ0BKD
	 E1ZScraaJFDBcURbz6SpaA+pcdz+jazVwqyAmGK9A1kLDkJy695/w8WAoJ5JAyFrIh
	 VT/8PzH/PATSwRrd2gw3vBb+d8JNj/FSOWFCeig0vlhqYkaFggl6G6MHRKyiZZaEUG
	 NYMXVvfoVT3QA==
Date: Thu, 15 Aug 2024 13:54:00 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: fw/mvm: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Zr5c2DVAp3mWVO6h@elsanto>
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
helper to create a new tagged `struct iwl_tx_cmd_hdr`. This structure
groups together all the members of the flexible `struct iwl_tx_cmd`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct iwl_tx_cmd` to `struct iwl_tx_cmd_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct iwl_tx_cmd_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

Worth mentioning is that the union at the end of the flexible structure
was replaced by a direct declaration of flexible-array member `hdr[]`
as `payload` is unnecessary.

So, with these changes, fix the following warnings:

drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 61 ++++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  8 ++-
 4 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
index 893438aadab0..0ea6c0e37750 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
@@ -50,7 +50,7 @@ struct iwl_tdls_channel_switch_timing {
  */
 struct iwl_tdls_channel_switch_frame {
 	__le32 switch_time_offset;
-	struct iwl_tx_cmd tx_cmd;
+	struct iwl_tx_cmd_hdr tx_cmd;
 	u8 data[IWL_TDLS_CH_SW_FRAME_MAX_SIZE];
 } __packed; /* TDLS_STA_CHANNEL_SWITCH_FRAME_API_S_VER_1 */
 
@@ -131,7 +131,7 @@ struct iwl_tdls_config_cmd {
 	struct iwl_tdls_sta_info sta_info[IWL_MVM_TDLS_STA_COUNT];
 
 	__le32 pti_req_data_offset;
-	struct iwl_tx_cmd pti_req_tx_cmd;
+	struct iwl_tx_cmd_hdr pti_req_tx_cmd;
 	u8 pti_req_template[];
 } __packed; /* TDLS_CONFIG_CMD_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index c5277e2f8cd4..903f0f7517e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -222,34 +222,37 @@ enum iwl_tx_offload_assist_flags_pos {
  * and then the actial payload.
  */
 struct iwl_tx_cmd {
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
+	__struct_group(iwl_tx_cmd_hdr, __hdr, __packed,
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
+
+	struct ieee80211_hdr hdr[];
 } __packed; /* TX_CMD_API_S_VER_6 */
+static_assert(offsetof(struct iwl_tx_cmd, hdr) == sizeof(struct iwl_tx_cmd_hdr),
+	      "struct member likely outside of __struct_group()");
 
 struct iwl_dram_sec_info {
 	__le32 pn_low;
@@ -742,7 +745,7 @@ struct iwl_mvm_compressed_ba_notif {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v6 {
-	struct iwl_tx_cmd tx;
+	struct iwl_tx_cmd_hdr tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
@@ -761,7 +764,7 @@ struct iwl_mac_beacon_cmd_v6 {
  * @frame: the template of the beacon frame
  */
 struct iwl_mac_beacon_cmd_v7 {
-	struct iwl_tx_cmd tx;
+	struct iwl_tx_cmd_hdr tx;
 	__le32 template_id;
 	__le32 tim_idx;
 	__le32 tim_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index dfcc96f18b4f..41e276f2fcf8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1053,8 +1053,10 @@ static int iwl_mvm_mac_ctxt_send_beacon_v6(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mac_beacon_cmd_v6 beacon_cmd = {};
+	struct iwl_tx_cmd *beacon_cmd_tx =
+		container_of(&beacon_cmd.tx, struct iwl_tx_cmd, __hdr);
 
-	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
+	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, beacon_cmd_tx);
 
 	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
 
@@ -1073,8 +1075,10 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mac_beacon_cmd_v7 beacon_cmd = {};
+	struct iwl_tx_cmd *beacon_cmd_tx =
+			container_of(&beacon_cmd.tx, struct iwl_tx_cmd, __hdr);
 
-	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
+	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, beacon_cmd_tx);
 
 	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 3d25ff5cd7e8..7e45445c3ce6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -341,6 +341,8 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 	struct iwl_tdls_channel_switch_cmd cmd = {0};
 	struct iwl_tdls_channel_switch_cmd_tail *tail =
 		iwl_mvm_chan_info_cmd_tail(mvm, &cmd.ci);
+	struct iwl_tx_cmd *tail_frame_tx_cmd =
+		container_of(&tail->frame.tx_cmd, struct iwl_tx_cmd, __hdr);
 	u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
 	int ret;
 
@@ -410,13 +412,13 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 			ret = -EINVAL;
 			goto out;
 		}
-		iwl_mvm_set_tx_cmd_ccmp(info, &tail->frame.tx_cmd);
+		iwl_mvm_set_tx_cmd_ccmp(info, tail_frame_tx_cmd);
 	}
 
-	iwl_mvm_set_tx_cmd(mvm, skb, &tail->frame.tx_cmd, info,
+	iwl_mvm_set_tx_cmd(mvm, skb, tail_frame_tx_cmd, info,
 			   mvmsta->deflink.sta_id);
 
-	iwl_mvm_set_tx_cmd_rate(mvm, &tail->frame.tx_cmd, info, sta,
+	iwl_mvm_set_tx_cmd_rate(mvm, tail_frame_tx_cmd, info, sta,
 				hdr->frame_control);
 	rcu_read_unlock();
 
-- 
2.34.1


