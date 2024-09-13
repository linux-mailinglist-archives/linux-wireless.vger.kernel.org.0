Return-Path: <linux-wireless+bounces-12832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DA977A8F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FED21F278CB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FE1BF322;
	Fri, 13 Sep 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="AI9viBmb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029651BE864
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214642; cv=none; b=pnixGbT3/5b35qHVruUgjkTVSiX6A/vH/KWzFDCw21j6gMCn7XNJMFDOaK+NV7AXPCF7VkotGWmDxUUSmYY1eqewivO3tpZJOAM4fIynckt/DIOqqhQXiX8KBDbSgHfkqR+sKraQ8QSwZ8fyPCeCtMzmr1L7e6taqs74tD3i0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214642; c=relaxed/simple;
	bh=pMbl/6FH+RsIUAoL48/tTYOyY2AwXx5OQCfVDXZIdpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpmahAL40x6HhJzInh6MLVO8GlqPTQnMbXYdeBwatzo8+sncFMGgIwa4gtxzTOb6DtJcS0z6+k0h1XqXCORuhOT0FllWtTa0MPxelLmTb7o4XKO02F0W8oSoe7C7UWBXlFdq+Fij68n9KM7qJKeaPPRGgebFZ1l8NTxBPH8GfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=AI9viBmb; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id ovycs8UeD1zuHp1Hcsw19w; Fri, 13 Sep 2024 08:04:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id p1HasluofChpEp1HbsPgjO; Fri, 13 Sep 2024 08:03:59 +0000
X-Authority-Analysis: v=2.4 cv=XdWPzp55 c=1 sm=1 tr=0 ts=66e3f1ef
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=VRFK7ttmmsBj0-VOgosA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XQUgST2hsoYMlW6hQha6OjD7pqx6B4iAGIMnvvwRLPs=; b=AI9viBmbhmxJm8FoCGNzYlt2vy
	DGQ8gORPXixu62Dy5PwLlXXy8s+1Wmw5BvjnU5VA/lCnrnIWENFeGS0ZRtHfi1dOP0FkfsbYC4+BL
	d4d+oo7oxxj7pfTklZfrJKRo0ncq7VTwsK3DARfAli/l6VqAI8UJuZEGXR8CrsfoAJvxAoaxyMjGT
	5vj3WAEdBNN1n5bxmIrCPM6ibz1pwFrlLtOiQYawzTyEy7iUSPfKqqXKuHy98xZFqEiABauEoCQv4
	cC5eqsjwv8gqNF+NJGRKX4UZipiWXTtT6NXsIY5+vLoeqqTy3p0ELLJRTXw+AsqHPnWjLSQ/JQZGp
	qnjthbZQ==;
Received: from [185.44.53.103] (port=47678 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sp1HZ-003eph-1s;
	Fri, 13 Sep 2024 03:03:58 -0500
Message-ID: <38e13999-b44d-40eb-96d9-01d4a3f4594e@embeddedor.com>
Date: Fri, 13 Sep 2024 10:03:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: iwlwifi: fw/mvm: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Zr5c2DVAp3mWVO6h@elsanto>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Zr5c2DVAp3mWVO6h@elsanto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sp1HZ-003eph-1s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:47678
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKHtQY8ScFC1OBZBpbxOooMj4cp0JMZoUt0NUOTeT4mIlvrxU0rO0nosY2Y3sBLf79LBGDvlJNhDGF+Y/ca7CNZZqj42rsYfTkcEnUKrgbnnXkLdBoFm
 WSBYiil59uGvG8+D0sRxvlqCxpJDJvKEPKJdc0LBaXg0SU69D13vvzs++HFnsO8qU3tAX/CaY0igZnxsCK3BkKlZJjpkScpTMp9O5h/aSbOY8qC3RbwsuSqo

Hi all,

Friendly ping: who can take this, please? 🙂

Thanks
-- 
Gustavo

On 15/08/24 21:54, Gustavo A. R. Silva wrote:
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
> Worth mentioning is that the union at the end of the flexible structure
> was replaced by a direct declaration of flexible-array member `hdr[]`
> as `payload` is unnecessary.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:764:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  4 +-
>   .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 61 ++++++++++---------
>   .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  8 ++-
>   drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  8 ++-
>   4 files changed, 45 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
> index 893438aadab0..0ea6c0e37750 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
> @@ -50,7 +50,7 @@ struct iwl_tdls_channel_switch_timing {
>    */
>   struct iwl_tdls_channel_switch_frame {
>   	__le32 switch_time_offset;
> -	struct iwl_tx_cmd tx_cmd;
> +	struct iwl_tx_cmd_hdr tx_cmd;
>   	u8 data[IWL_TDLS_CH_SW_FRAME_MAX_SIZE];
>   } __packed; /* TDLS_STA_CHANNEL_SWITCH_FRAME_API_S_VER_1 */
>   
> @@ -131,7 +131,7 @@ struct iwl_tdls_config_cmd {
>   	struct iwl_tdls_sta_info sta_info[IWL_MVM_TDLS_STA_COUNT];
>   
>   	__le32 pti_req_data_offset;
> -	struct iwl_tx_cmd pti_req_tx_cmd;
> +	struct iwl_tx_cmd_hdr pti_req_tx_cmd;
>   	u8 pti_req_template[];
>   } __packed; /* TDLS_CONFIG_CMD_API_S_VER_1 */
>   
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> index c5277e2f8cd4..903f0f7517e0 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> @@ -222,34 +222,37 @@ enum iwl_tx_offload_assist_flags_pos {
>    * and then the actial payload.
>    */
>   struct iwl_tx_cmd {
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
> +
> +	struct ieee80211_hdr hdr[];
>   } __packed; /* TX_CMD_API_S_VER_6 */
> +static_assert(offsetof(struct iwl_tx_cmd, hdr) == sizeof(struct iwl_tx_cmd_hdr),
> +	      "struct member likely outside of __struct_group()");
>   
>   struct iwl_dram_sec_info {
>   	__le32 pn_low;
> @@ -742,7 +745,7 @@ struct iwl_mvm_compressed_ba_notif {
>    * @frame: the template of the beacon frame
>    */
>   struct iwl_mac_beacon_cmd_v6 {
> -	struct iwl_tx_cmd tx;
> +	struct iwl_tx_cmd_hdr tx;
>   	__le32 template_id;
>   	__le32 tim_idx;
>   	__le32 tim_size;
> @@ -761,7 +764,7 @@ struct iwl_mac_beacon_cmd_v6 {
>    * @frame: the template of the beacon frame
>    */
>   struct iwl_mac_beacon_cmd_v7 {
> -	struct iwl_tx_cmd tx;
> +	struct iwl_tx_cmd_hdr tx;
>   	__le32 template_id;
>   	__le32 tim_idx;
>   	__le32 tim_size;
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> index dfcc96f18b4f..41e276f2fcf8 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> @@ -1053,8 +1053,10 @@ static int iwl_mvm_mac_ctxt_send_beacon_v6(struct iwl_mvm *mvm,
>   {
>   	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>   	struct iwl_mac_beacon_cmd_v6 beacon_cmd = {};
> +	struct iwl_tx_cmd *beacon_cmd_tx =
> +		container_of(&beacon_cmd.tx, struct iwl_tx_cmd, __hdr);
>   
> -	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
> +	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, beacon_cmd_tx);
>   
>   	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
>   
> @@ -1073,8 +1075,10 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
>   {
>   	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>   	struct iwl_mac_beacon_cmd_v7 beacon_cmd = {};
> +	struct iwl_tx_cmd *beacon_cmd_tx =
> +			container_of(&beacon_cmd.tx, struct iwl_tx_cmd, __hdr);
>   
> -	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
> +	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, beacon_cmd_tx);
>   
>   	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
>   
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> index 3d25ff5cd7e8..7e45445c3ce6 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> @@ -341,6 +341,8 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
>   	struct iwl_tdls_channel_switch_cmd cmd = {0};
>   	struct iwl_tdls_channel_switch_cmd_tail *tail =
>   		iwl_mvm_chan_info_cmd_tail(mvm, &cmd.ci);
> +	struct iwl_tx_cmd *tail_frame_tx_cmd =
> +		container_of(&tail->frame.tx_cmd, struct iwl_tx_cmd, __hdr);
>   	u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
>   	int ret;
>   
> @@ -410,13 +412,13 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
>   			ret = -EINVAL;
>   			goto out;
>   		}
> -		iwl_mvm_set_tx_cmd_ccmp(info, &tail->frame.tx_cmd);
> +		iwl_mvm_set_tx_cmd_ccmp(info, tail_frame_tx_cmd);
>   	}
>   
> -	iwl_mvm_set_tx_cmd(mvm, skb, &tail->frame.tx_cmd, info,
> +	iwl_mvm_set_tx_cmd(mvm, skb, tail_frame_tx_cmd, info,
>   			   mvmsta->deflink.sta_id);
>   
> -	iwl_mvm_set_tx_cmd_rate(mvm, &tail->frame.tx_cmd, info, sta,
> +	iwl_mvm_set_tx_cmd_rate(mvm, tail_frame_tx_cmd, info, sta,
>   				hdr->frame_control);
>   	rcu_read_unlock();
>   

