Return-Path: <linux-wireless+bounces-11231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EFE94D642
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 20:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CEC2828C3
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB44DA04;
	Fri,  9 Aug 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="myLNDJp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685F321A3
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227941; cv=none; b=izjKJ9RNMi1BnS/OWhAHysFdQDRFDuyh2c8ly6SLVWJ+JZq1+lj4MtM2klmwewv8OqWkRbWROCxtZeicaQw13hHX2RS9y3zGpXtPHALQlrqmi+kAIxOaN0FTheTJngOHJLhri8Fs3/euAJCRPzalTp1jJCBlheKFcr5VNYjoYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227941; c=relaxed/simple;
	bh=E5yWKcgLheANY4YMhWs9pqSOYa3FUapj7gaVFNwqgUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S91OeD4ged6kT1swIW4KDtI6JBmuk3vpGJpH/v5AnbAS9ma5aD19iQ3HtlMMia03lITD7w5Q/imCSL+qdZsM+1rfIyjCmuLQMfBtzLd65rUfA0caJUUIrwHFLvmNsMPjTQSZyzLTv29oHdGw2iPdyNGZXCbwbfqZApu3mKm+lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=myLNDJp5; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9DBB7A80061;
	Fri,  9 Aug 2024 18:25:30 +0000 (UTC)
Received: from [192.168.0.11] (c-98-247-188-21.hsd1.wa.comcast.net [98.247.188.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id C566813C2B0;
	Fri,  9 Aug 2024 11:25:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C566813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1723227929;
	bh=E5yWKcgLheANY4YMhWs9pqSOYa3FUapj7gaVFNwqgUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=myLNDJp5CR2fzHpvrp8i7xFieSdmB12vvH6DJYNxMBJTUW0h8dmTpnb++ErFtMS6Z
	 AfSGeeysw9H88Ezh7o6h2hBNf11JZijlykgMfEGjY79dU/amJHFWjPfFZMh4Ygyi/f
	 NN3K5i6reeIMwzrBbXwqqJg6z2T0gclbc+vnfhJw=
Message-ID: <ea1eeb13-c568-4381-812a-dec4246a440e@candelatech.com>
Date: Fri, 9 Aug 2024 11:25:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] wifi: iwlwifi: mvm: handle TPE advertised by AP
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Mukesh Sisodiya <mukesh.sisodiya@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
 <20240527190228.32f1e2e1447c.I58ac91c38585362aa42bb4a8a59c7d88e67bc40b@changeid>
Content-Language: en-US
From: Rory Little <rory@candelatech.com>
In-Reply-To: <20240527190228.32f1e2e1447c.I58ac91c38585362aa42bb4a8a59c7d88e67bc40b@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1723227931-X8lzWAqcQvYM
X-MDID-O:
 us5;ut7;1723227931;X8lzWAqcQvYM;<rory@candelatech.com>;4795e16813503716592b0d896134c7a6

Hi,

We noticed that our transmit throughput dropped by ~20-30% and bisected 
the issue to this patch. We will dig around a bit more to investigate 
why this seems to be happening...

- Rory

On 5/27/24 09:06, Miri Korenblit wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> 6 GHz BSS SP client shall respect TX power limits advertised
> by the AP in TPE elements, send the data to the firmware using
> the AP_TX_POWER_CONSTRAINTS_CMD command, so do that.
> 
> Co-developed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++++
>   .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 55 ++++++++++++++++---
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++
>   3 files changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> index 752fdb6a783f..88bc0baabf7e 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -2768,6 +2768,13 @@ iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
>   
>   	if (changes & BSS_CHANGED_BANDWIDTH)
>   		iwl_mvm_update_link_smps(vif, link_conf);
> +
> +	if (changes & BSS_CHANGED_TPE) {
> +		IWL_DEBUG_CALIB(mvm, "Changing TPE\n");
> +		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
> +							link_conf,
> +							false);
> +	}
>   }
>   
>   static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
> @@ -5122,6 +5129,10 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
>   		}
>   
>   		iwl_mvm_update_quotas(mvm, false, NULL);
> +
> +		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
> +							link_conf,
> +							false);
>   	}
>   
>   	goto out;
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
> index 00433d1c8564..b2b6dbdcc44f 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
> @@ -345,6 +345,11 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
>   		rcu_read_unlock();
>   	}
>   
> +	if (vif->type == NL80211_IFTYPE_STATION)
> +		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
> +							link_conf,
> +							false);
> +
>   	/* then activate */
>   	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
>   				   LINK_CONTEXT_MODIFY_ACTIVE |
> @@ -524,9 +529,37 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
>   }
>   
>   static void
> +iwl_mvm_tpe_sta_cmd_data(struct iwl_txpower_constraints_cmd *cmd,
> +			 const struct ieee80211_bss_conf *bss_info)
> +{
> +	u8 i;
> +
> +	/*
> +	 * NOTE: the 0 here is IEEE80211_TPE_CAT_6GHZ_DEFAULT,
> +	 * we fully ignore IEEE80211_TPE_CAT_6GHZ_SUBORDINATE
> +	 */
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(cmd->psd_pwr) !=
> +		     ARRAY_SIZE(bss_info->tpe.psd_local[0].power));
> +
> +	/* if not valid, mac80211 puts default (max value) */
> +	for (i = 0; i < ARRAY_SIZE(cmd->psd_pwr); i++)
> +		cmd->psd_pwr[i] = min(bss_info->tpe.psd_local[0].power[i],
> +				      bss_info->tpe.psd_reg_client[0].power[i]);
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(cmd->eirp_pwr) !=
> +		     ARRAY_SIZE(bss_info->tpe.max_local[0].power));
> +
> +	for (i = 0; i < ARRAY_SIZE(cmd->eirp_pwr); i++)
> +		cmd->eirp_pwr[i] = min(bss_info->tpe.max_local[0].power[i],
> +				       bss_info->tpe.max_reg_client[0].power[i]);
> +}
> +
> +void
>   iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
>   					struct ieee80211_vif *vif,
> -					struct ieee80211_bss_conf *bss_conf)
> +					struct ieee80211_bss_conf *bss_conf,
> +					bool is_ap)
>   {
>   	struct iwl_txpower_constraints_cmd cmd = {};
>   	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
> @@ -546,19 +579,22 @@ iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
>   	    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
>   		return;
>   
> -	if (bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ ||
> -	    bss_conf->chanreq.oper.chan->flags &
> -		    IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT)
> +	if (bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ)
>   		return;
>   
>   	cmd.link_id = cpu_to_le16(link_info->fw_link_id);
> -	/*
> -	 * Currently supporting VLP Soft AP only.
> -	 */
> -	cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
>   	memset(cmd.psd_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.psd_pwr));
>   	memset(cmd.eirp_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.eirp_pwr));
>   
> +	if (is_ap) {
> +		cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
> +	} else if (bss_conf->power_type == IEEE80211_REG_UNSET_AP) {
> +		return;
> +	} else {
> +		cmd.ap_type = cpu_to_le16(bss_conf->power_type - 1);
> +		iwl_mvm_tpe_sta_cmd_data(&cmd, bss_conf);
> +	}
> +
>   	ret = iwl_mvm_send_cmd_pdu(mvm,
>   				   WIDE_ID(PHY_OPS_GROUP,
>   					   AP_TX_POWER_CONSTRAINTS_CMD),
> @@ -580,7 +616,8 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
>   	guard(mvm)(mvm);
>   
>   	if (vif->type == NL80211_IFTYPE_AP)
> -		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif, link_conf);
> +		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
> +							link_conf, true);
>   
>   	/* Send the beacon template */
>   	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> index f3d9b8355c6b..9b939225990a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> @@ -2962,4 +2962,10 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct iwl_mvm *mvm,
>   				   bool primary);
>   int iwl_mvm_esr_non_bss_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
>   			     unsigned int link_id, bool active);
> +
> +void
> +iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
> +					struct ieee80211_vif *vif,
> +					struct ieee80211_bss_conf *bss_conf,
> +					bool is_ap);
>   #endif /* __IWL_MVM_H__ */

