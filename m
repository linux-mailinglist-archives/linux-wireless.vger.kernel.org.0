Return-Path: <linux-wireless+bounces-21215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC3A7EF45
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F32116899E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9149219A71;
	Mon,  7 Apr 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLsnVkVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB420B7EF;
	Mon,  7 Apr 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057516; cv=none; b=KV1feIYOynu5unIRHNxC7JF4Fqx/1Kn7dyE0cz7VqEvLhs0yAOGErDmCpSvBt1mYGD9gR5ulLpfCSv2QkCC88FhcN/oYP4pF8aX+YUzGvNW6ntjH2eZ1M9wbgH6/jr1pbbUWxrdDSEvFnO327wyiju5zDmioy1RaXo4xeFkaVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057516; c=relaxed/simple;
	bh=1hRdzwq5DQRdhDsh8FcA4PbamMpCO4g0hKWxcPWFHsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXt9QU/yOtP4IzQ41+54Kq9ja5sNhOxf3PXBaz2Xg1xgDawJgd+OF4klnIGqFigiKYWVX2KYnreP+FMdYE60YJnWpghW3PcMtxQTe/2ePlPtV+AmiJloiPIHogpl5/2ZIB79i6pZcA71QaC4IQFQoiZDGkvmsvW+06xWAzk3qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLsnVkVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A71C4CEDD;
	Mon,  7 Apr 2025 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744057516;
	bh=1hRdzwq5DQRdhDsh8FcA4PbamMpCO4g0hKWxcPWFHsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLsnVkVoYI7aUbOM+kQsa0XU7n5o1IfTmgUNU60hTC3kjUp8vDS03by/0pBKWqRBa
	 v5eW9Z20dhN7lm4KDaDe3/CASnH6qW0zhTqRO32ZuAnFeStZqAwfyVcKSL8yaV1gBy
	 Zwqv+2lsgs5Wyo+yg1KuVAP0N/cS3EJBwKQgIcb8Ck+WgNAkfcumai3T8elkLGFJMY
	 KNK/I4k9/mq+yctrCTKDxOhw7Ry2SFX97W53caic6nFt0UdowZriziCXvFgIG88t6Q
	 3+tNVTFjYU1CJEYANPeGv3lMZXO1c61wVxRbhfUVThHlvGoSkiolrGQrewcwjNj67D
	 Deo3Y1aWEiekQ==
Date: Mon, 7 Apr 2025 13:25:13 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: iwlwifi: mvm/fw: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504071317.934FD6915@keescook>
References: <Z-9G-GHufhXKeYft@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-9G-GHufhXKeYft@kspp>

On Thu, Apr 03, 2025 at 08:42:00PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create a new tagged `struct iwl_tx_cmd_hdr`. This structure
> groups together all the members of the flexible `struct iwl_tx_cmd`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct members currently causing
> trouble from `struct iwl_tx_cmd` to `struct iwl_tx_cmd_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct iwl_tx_cmd_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which we can access the flexible-array
> member, if necessary.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mld/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> This patch is quite similar to the following one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e74c0a7875cfec27c25f582f001cc4625a0f8c07
> 
> Thanks!
> 
>  .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  4 +-
>  .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 60 ++++++++++---------
>  .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  8 ++-
>  drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 10 ++--
>  4 files changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
> index cfa6532a3cdd..02198bc37f8c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
> @@ -50,7 +50,7 @@ struct iwl_tdls_channel_switch_timing {
>   */
>  struct iwl_tdls_channel_switch_frame {
>  	__le32 switch_time_offset;
> -	struct iwl_tx_cmd tx_cmd;
> +	struct iwl_tx_cmd_hdr tx_cmd;
>  	u8 data[IWL_TDLS_CH_SW_FRAME_MAX_SIZE];
>  } __packed; /* TDLS_STA_CHANNEL_SWITCH_FRAME_API_S_VER_1 */
>  
> @@ -131,7 +131,7 @@ struct iwl_tdls_config_cmd {
>  	struct iwl_tdls_sta_info sta_info[IWL_TDLS_STA_COUNT];
>  
>  	__le32 pti_req_data_offset;
> -	struct iwl_tx_cmd pti_req_tx_cmd;
> +	struct iwl_tx_cmd_hdr pti_req_tx_cmd;
>  	u8 pti_req_template[];
>  } __packed; /* TDLS_CONFIG_CMD_API_S_VER_1 */
>  
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> index 0a39e4b6eb62..5c0c7bac36d6 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> @@ -222,34 +222,36 @@ enum iwl_tx_offload_assist_flags_pos {
>   * and then the actial payload.
>   */
>  struct iwl_tx_cmd {
> -	__le16 len;
> -	__le16 offload_assist;
> -	__le32 tx_flags;
> -	struct {
> -		u8 try_cnt;
> -		u8 btkill_cnt;
> -		__le16 reserved;
> -	} scratch; /* DRAM_SCRATCH_API_U_VER_1 */
> -	__le32 rate_n_flags;
> -	u8 sta_id;
> -	u8 sec_ctl;
> -	u8 initial_rate_index;
> -	u8 reserved2;
> -	u8 key[16];
> -	__le32 reserved3;
> -	__le32 life_time;
> -	__le32 dram_lsb_ptr;
> -	u8 dram_msb_ptr;
> -	u8 rts_retry_limit;
> -	u8 data_retry_limit;
> -	u8 tid_tspec;
> -	__le16 pm_frame_timeout;
> -	__le16 reserved4;
> -	union {
> -		DECLARE_FLEX_ARRAY(u8, payload);
> -		DECLARE_FLEX_ARRAY(struct ieee80211_hdr, hdr);
> -	};

I see no mention in the commit log of the removal of this union (I assume
"payload" is never used?)

> +	/* New members MUST be added within the __struct_group() macro below. */
> +	__struct_group(iwl_tx_cmd_hdr, __hdr, __packed,
> +		__le16 len;
> +		__le16 offload_assist;
> +		__le32 tx_flags;
> +		struct {
> +			u8 try_cnt;
> +			u8 btkill_cnt;
> +			__le16 reserved;
> +		} scratch; /* DRAM_SCRATCH_API_U_VER_1 */
> +		__le32 rate_n_flags;
> +		u8 sta_id;
> +		u8 sec_ctl;
> +		u8 initial_rate_index;
> +		u8 reserved2;
> +		u8 key[16];
> +		__le32 reserved3;
> +		__le32 life_time;
> +		__le32 dram_lsb_ptr;
> +		u8 dram_msb_ptr;
> +		u8 rts_retry_limit;
> +		u8 data_retry_limit;
> +		u8 tid_tspec;
> +		__le16 pm_frame_timeout;
> +		__le16 reserved4;
> +	);
> +	struct ieee80211_hdr hdr[];
>  } __packed; /* TX_CMD_API_S_VER_6 */
> +static_assert(offsetof(struct iwl_tx_cmd, hdr) == sizeof(struct iwl_tx_cmd_hdr),
> +	      "struct member likely outside of __struct_group()");
>  
>  struct iwl_dram_sec_info {
>  	__le32 pn_low;
> @@ -742,7 +744,7 @@ struct iwl_compressed_ba_notif {
>   * @frame: the template of the beacon frame
>   */
>  struct iwl_mac_beacon_cmd_v6 {
> -	struct iwl_tx_cmd tx;
> +	struct iwl_tx_cmd_hdr tx;
>  	__le32 template_id;
>  	__le32 tim_idx;
>  	__le32 tim_size;
> @@ -761,7 +763,7 @@ struct iwl_mac_beacon_cmd_v6 {
>   * @frame: the template of the beacon frame
>   */
>  struct iwl_mac_beacon_cmd_v7 {
> -	struct iwl_tx_cmd tx;
> +	struct iwl_tx_cmd_hdr tx;
>  	__le32 template_id;
>  	__le32 tim_idx;
>  	__le32 tim_size;
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> index bec18d197f31..f010e68b4a55 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> @@ -1032,7 +1032,9 @@ static int iwl_mvm_mac_ctxt_send_beacon_v6(struct iwl_mvm *mvm,
>  	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>  	struct iwl_mac_beacon_cmd_v6 beacon_cmd = {};
>  
> -	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
> +	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon,
> +				container_of(&beacon_cmd.tx,
> +					     struct iwl_tx_cmd, __hdr));
>  
>  	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
>  
> @@ -1052,7 +1054,9 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
>  	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>  	struct iwl_mac_beacon_cmd_v7 beacon_cmd = {};
>  
> -	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
> +	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon,
> +				container_of(&beacon_cmd.tx,
> +					     struct iwl_tx_cmd, __hdr));
>  
>  	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
>  
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> index 36379b738de1..bcfae05192ad 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> @@ -342,6 +342,8 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
>  	struct iwl_tdls_channel_switch_cmd_tail *tail =
>  		iwl_mvm_chan_info_cmd_tail(mvm, &cmd.ci);
>  	u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
> +	struct iwl_tx_cmd *tx_cmd =
> +		container_of(&tail->frame.tx_cmd, struct iwl_tx_cmd, __hdr);
>  	int ret;
>  
>  	lockdep_assert_held(&mvm->mutex);
> @@ -410,14 +412,12 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		iwl_mvm_set_tx_cmd_ccmp(info, &tail->frame.tx_cmd);
> +		iwl_mvm_set_tx_cmd_ccmp(info, tx_cmd);
>  	}
>  
> -	iwl_mvm_set_tx_cmd(mvm, skb, &tail->frame.tx_cmd, info,
> -			   mvmsta->deflink.sta_id);
> +	iwl_mvm_set_tx_cmd(mvm, skb, tx_cmd, info, mvmsta->deflink.sta_id);
>  
> -	iwl_mvm_set_tx_cmd_rate(mvm, &tail->frame.tx_cmd, info, sta,
> -				hdr->frame_control);
> +	iwl_mvm_set_tx_cmd_rate(mvm, tx_cmd, info, sta, hdr->frame_control);
>  	rcu_read_unlock();
>  
>  	memcpy(tail->frame.data, skb->data, skb->len);

Otherwise looks good to me.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

