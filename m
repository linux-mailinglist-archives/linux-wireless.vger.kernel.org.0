Return-Path: <linux-wireless+bounces-22926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D363AB5CFD
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 21:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76391B6117F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 19:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982232BF98C;
	Tue, 13 May 2025 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="uV8C6XTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D642A80
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747163660; cv=none; b=c1yfllLnt/p8v/9WUGudW1la88liEkonjILkI4bQV3X4VKeHzz8KSZWd+1dVM1GlD0zW8cgwlDbOoVbjKUOxCtqRDF21S33BmCH3a22F1SdjnSBdx0uupFPQDNlR91rwj1Kgy7P95/KxEqoHhUwDaTWBaXSlHjOzNXIBFHy5XjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747163660; c=relaxed/simple;
	bh=84AUyiseIrSXm+1CHXRjvjW5HCqOuFOAHLYDayKe/tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6hhevH6F+VekdfVHWIS6p4Xm42TM16ViO1v1BKt6IIJIh7Sh5u6UDvykuY7lQS8W+l2WUSyENdEOkz8O/I3/ddxxGjpCpeA0nfUzxIezF7qIqrn8E0nXZgZWnEhXSkYpsdxLuPuSoiLSkDh7fmopI0YQcs8XVIlhar7FzrJKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=uV8C6XTx; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id EmtguFxlNVkcREv4yuYyIH; Tue, 13 May 2025 19:14:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Ev4xuwPTfZ6h1Ev4xuSYvB; Tue, 13 May 2025 19:14:15 +0000
X-Authority-Analysis: v=2.4 cv=ergUzZpX c=1 sm=1 tr=0 ts=68239a07
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=2WyGJ_ah1ZAX_JhrdjoA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uCLttBLOu3aSbpDrlBobQP+5p7vrc/F5lCFNvtz1450=; b=uV8C6XTx1OCfRRlnj7B6m3s/ZS
	OWOcgFA653IV953+DDxHvueNLBMqDeV7sz0BeBYQyyLvtpriqSBeheUAIFVQqrFqKHk//i+Q14oGG
	c40ZJjo4e3+TgBXDWl2mVXAm/ZoVGold4lbTTm+P87JQxrgMX4CkkeH1yGE9kP+JjkjJUPzbQn9bt
	dN/kIXBAIn3PzmOJnR9nEA+cjqemyeN6M/eQkbq2QLpiJVg1fND0+Ds0d3nxlc83fwYtJPNtT38k5
	hp3ia1ew0RhPRyZq56zfCbt6LB4v71cqlzCtNzjdqdltXZGBe3VpRPY+wAorD2Hm4h4lqC0BnTfmr
	KXsY+ARQ==;
Received: from [177.238.17.151] (port=64196 helo=[192.168.0.103])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uEv4w-00000002NOS-2eKr;
	Tue, 13 May 2025 14:14:14 -0500
Message-ID: <1ef9857b-efdb-4142-b068-91cb453849ad@embeddedor.com>
Date: Tue, 13 May 2025 13:14:07 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: iwlwifi: mvm/fw: Avoid
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <aAv7RiLsmXq5d0ge@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aAv7RiLsmXq5d0ge@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uEv4w-00000002NOS-2eKr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.103]) [177.238.17.151]:64196
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGWdZeGYlI92PMCopo413+dAw4peiN6u7ewGTejhedcC1IX6HXDhbu6kT877yLlSnO7gTzYIYydDGh6cCZDivWRIAkq1/y1OdeoEM2hxDnk3hGse+LIn
 EOYh6wiFOoeKJhxwRS5BNfWemaXRK6DniwMC8gqv6k+OXMGj2D7vzXhMZOXwHn/kwvpcsIeyYHs6Zwka4EOCicPQ6vvsGWmXrCX4yKrB8tiwRAkgzHJDJwJJ

Hi all,

Friendly ping: who can take this, please? :)

Thanks!
-Gustavo

On 25/04/25 15:14, Gustavo A. R. Silva wrote:
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
> Also, as part of the refactoring required to use `__struct_group()`,
> remove unused flex array `payload`.
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
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Update changelog text - mention removal of flex array `payload`.
>     (Kees)
>   - Fix kernel-doc block. (Johannes).
>   - Add RB tag.
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/Z-9G-GHufhXKeYft@kspp/
> 
>   .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  4 +-
>   .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 63 ++++++++++---------
>   .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  8 ++-
>   drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 10 +--
>   4 files changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
> index cfa6532a3cdd..02198bc37f8c 100644
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
>   	struct iwl_tdls_sta_info sta_info[IWL_TDLS_STA_COUNT];
>   
>   	__le32 pti_req_data_offset;
> -	struct iwl_tx_cmd pti_req_tx_cmd;
> +	struct iwl_tx_cmd_hdr pti_req_tx_cmd;
>   	u8 pti_req_template[];
>   } __packed; /* TDLS_CONFIG_CMD_API_S_VER_1 */
>   
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> index 0a39e4b6eb62..dba18d898ea2 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> @@ -205,8 +205,7 @@ enum iwl_tx_offload_assist_flags_pos {
>    * @tid_tspec: TID/tspec
>    * @pm_frame_timeout: PM TX frame timeout
>    * @reserved4: reserved
> - * @payload: payload (same as @hdr)
> - * @hdr: 802.11 header (same as @payload)
> + * @hdr: 802.11 header
>    *
>    * The byte count (both len and next_frame_len) includes MAC header
>    * (24/26/30/32 bytes)
> @@ -222,34 +221,36 @@ enum iwl_tx_offload_assist_flags_pos {
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
> +	struct ieee80211_hdr hdr[];
>   } __packed; /* TX_CMD_API_S_VER_6 */
> +static_assert(offsetof(struct iwl_tx_cmd, hdr) == sizeof(struct iwl_tx_cmd_hdr),
> +	      "struct member likely outside of __struct_group()");
>   
>   struct iwl_dram_sec_info {
>   	__le32 pn_low;
> @@ -742,7 +743,7 @@ struct iwl_compressed_ba_notif {
>    * @frame: the template of the beacon frame
>    */
>   struct iwl_mac_beacon_cmd_v6 {
> -	struct iwl_tx_cmd tx;
> +	struct iwl_tx_cmd_hdr tx;
>   	__le32 template_id;
>   	__le32 tim_idx;
>   	__le32 tim_size;
> @@ -761,7 +762,7 @@ struct iwl_mac_beacon_cmd_v6 {
>    * @frame: the template of the beacon frame
>    */
>   struct iwl_mac_beacon_cmd_v7 {
> -	struct iwl_tx_cmd tx;
> +	struct iwl_tx_cmd_hdr tx;
>   	__le32 template_id;
>   	__le32 tim_idx;
>   	__le32 tim_size;
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> index bec18d197f31..f010e68b4a55 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> @@ -1032,7 +1032,9 @@ static int iwl_mvm_mac_ctxt_send_beacon_v6(struct iwl_mvm *mvm,
>   	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>   	struct iwl_mac_beacon_cmd_v6 beacon_cmd = {};
>   
> -	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
> +	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon,
> +				container_of(&beacon_cmd.tx,
> +					     struct iwl_tx_cmd, __hdr));
>   
>   	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
>   
> @@ -1052,7 +1054,9 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
>   	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>   	struct iwl_mac_beacon_cmd_v7 beacon_cmd = {};
>   
> -	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon, &beacon_cmd.tx);
> +	iwl_mvm_mac_ctxt_set_tx(mvm, vif, beacon,
> +				container_of(&beacon_cmd.tx,
> +					     struct iwl_tx_cmd, __hdr));
>   
>   	beacon_cmd.template_id = cpu_to_le32((u32)mvmvif->id);
>   
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> index 36379b738de1..bcfae05192ad 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
> @@ -342,6 +342,8 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
>   	struct iwl_tdls_channel_switch_cmd_tail *tail =
>   		iwl_mvm_chan_info_cmd_tail(mvm, &cmd.ci);
>   	u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
> +	struct iwl_tx_cmd *tx_cmd =
> +		container_of(&tail->frame.tx_cmd, struct iwl_tx_cmd, __hdr);
>   	int ret;
>   
>   	lockdep_assert_held(&mvm->mutex);
> @@ -410,14 +412,12 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
>   			ret = -EINVAL;
>   			goto out;
>   		}
> -		iwl_mvm_set_tx_cmd_ccmp(info, &tail->frame.tx_cmd);
> +		iwl_mvm_set_tx_cmd_ccmp(info, tx_cmd);
>   	}
>   
> -	iwl_mvm_set_tx_cmd(mvm, skb, &tail->frame.tx_cmd, info,
> -			   mvmsta->deflink.sta_id);
> +	iwl_mvm_set_tx_cmd(mvm, skb, tx_cmd, info, mvmsta->deflink.sta_id);
>   
> -	iwl_mvm_set_tx_cmd_rate(mvm, &tail->frame.tx_cmd, info, sta,
> -				hdr->frame_control);
> +	iwl_mvm_set_tx_cmd_rate(mvm, tx_cmd, info, sta, hdr->frame_control);
>   	rcu_read_unlock();
>   
>   	memcpy(tail->frame.data, skb->data, skb->len);


