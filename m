Return-Path: <linux-wireless+bounces-12336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD296881D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 14:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4071C20AF2
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14019C54C;
	Mon,  2 Sep 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="mNJ/SgiZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F1185934;
	Mon,  2 Sep 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281961; cv=none; b=jayv97X43CW/LtaGG1fRaWcEpiCSc+GgiM4BexZMfSUPlDnMknZz2XuzjCJG+Ic15eaFt/yIaCgz0sxhLVwOuevs3mFN3FhhnAFtJmjfRQUW8CPlFH4kTA1lyV67fqiql2YnwoiPulyuPQy5Hpt51PufNrz5PzMKnfZrX+DXCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281961; c=relaxed/simple;
	bh=YJ7VIZEmz46M5dRUv7t5f4g1qetvGq1UdlVmjCDQYqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uabC4Pd1Zm/kSv/AEG+VtD74XHh6Fay5ZF5Bidba3w/6weUoGw7DvyHfZ8UaG1uuXWqWdLgyQMwRpQ5DvdDSJUjPqRppawUN/R9F3e8+2laRFR9WFXb0+XRUp47yOcc3hXRtWzb3Bj4fEL98Wx0Cu/5ekpdMVNkWQoEerc2EBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=mNJ/SgiZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=GTtbMh95g6gOixyB54pDlDSPHQiJhJS+ldBl3pUr+Kk=;
	t=1725281958; x=1725713958; b=mNJ/SgiZCy9jUliRniw0j3n4yLwdlI6v4+ZwZ0P0wPPcXLn
	XnU6XMrP+HZgKQ2vlypFDo2EcXxU4Csy+WA+w2z6g8xLc6S6edHDwpvSQfPeOZ7aS1LyOBf2jp+Ya
	yrhLN1c4yi3NWmM53VA3fEVRikJfO9SqcVTqP2fDuIv//mr3sVFbrqVvh4qLlh6mjuI51dGix3gTc
	L/db1LfV9wblczgpCPmWgUXXbXauI9QOYa5Lgxp9mcUpV1kjAl2RHDBPWwkRw//M1FaHGPKsDIf9I
	wQ6zoCrOb95w1P9+bLjRkjucsGDQpvfMczevccbITkaMg35xqpKsjN4fbK936aig==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sl6eI-0001T4-Ra; Mon, 02 Sep 2024 14:59:14 +0200
Message-ID: <57d28bcf-8f2b-4755-bf2a-7c9d316e6823@leemhuis.info>
Date: Mon, 2 Sep 2024 14:59:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] wifi: iwlwifi: mvm: handle TPE advertised by AP
To: Rory Little <rory@candelatech.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, johannes@sipsolutions.net
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
 <20240527190228.32f1e2e1447c.I58ac91c38585362aa42bb4a8a59c7d88e67bc40b@changeid>
 <ea1eeb13-c568-4381-812a-dec4246a440e@candelatech.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ea1eeb13-c568-4381-812a-dec4246a440e@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725281958;ec4f666d;
X-HE-SMSGID: 1sl6eI-0001T4-Ra

On 09.08.24 20:25, Rory Little wrote:
>
> We noticed that our transmit throughput dropped by ~20-30% and bisected
> the issue to this patch. We will dig around a bit more to investigate
> why this seems to be happening...

Rory Little: was this ever resolved? I noticed the patch you send to
which Johannes replied to stating a similar fix is already in -rc1. But
you reported this a few days after -rc1 was out, which makes me wonder
if this really is resolved.

If it is: apologies for the noise in advance.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

> On 5/27/24 09:06, Miri Korenblit wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> 6 GHz BSS SP client shall respect TX power limits advertised
>> by the AP in TPE elements, send the data to the firmware using
>> the AP_TX_POWER_CONSTRAINTS_CMD command, so do that.
>>
>> Co-developed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>> ---
>>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++++
>>   .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 55 ++++++++++++++++---
>>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++
>>   3 files changed, 63 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
>> b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
>> index 752fdb6a783f..88bc0baabf7e 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
>> @@ -2768,6 +2768,13 @@ iwl_mvm_bss_info_changed_station_common(struct
>> iwl_mvm *mvm,
>>         if (changes & BSS_CHANGED_BANDWIDTH)
>>           iwl_mvm_update_link_smps(vif, link_conf);
>> +
>> +    if (changes & BSS_CHANGED_TPE) {
>> +        IWL_DEBUG_CALIB(mvm, "Changing TPE\n");
>> +        iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
>> +                            link_conf,
>> +                            false);
>> +    }
>>   }
>>     static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
>> @@ -5122,6 +5129,10 @@ static int __iwl_mvm_assign_vif_chanctx(struct
>> iwl_mvm *mvm,
>>           }
>>             iwl_mvm_update_quotas(mvm, false, NULL);
>> +
>> +        iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
>> +                            link_conf,
>> +                            false);
>>       }
>>         goto out;
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
>> b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
>> index 00433d1c8564..b2b6dbdcc44f 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
>> @@ -345,6 +345,11 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm
>> *mvm,
>>           rcu_read_unlock();
>>       }
>>   +    if (vif->type == NL80211_IFTYPE_STATION)
>> +        iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
>> +                            link_conf,
>> +                            false);
>> +
>>       /* then activate */
>>       ret = iwl_mvm_link_changed(mvm, vif, link_conf,
>>                      LINK_CONTEXT_MODIFY_ACTIVE |
>> @@ -524,9 +529,37 @@ static void
>> iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
>>   }
>>     static void
>> +iwl_mvm_tpe_sta_cmd_data(struct iwl_txpower_constraints_cmd *cmd,
>> +             const struct ieee80211_bss_conf *bss_info)
>> +{
>> +    u8 i;
>> +
>> +    /*
>> +     * NOTE: the 0 here is IEEE80211_TPE_CAT_6GHZ_DEFAULT,
>> +     * we fully ignore IEEE80211_TPE_CAT_6GHZ_SUBORDINATE
>> +     */
>> +
>> +    BUILD_BUG_ON(ARRAY_SIZE(cmd->psd_pwr) !=
>> +             ARRAY_SIZE(bss_info->tpe.psd_local[0].power));
>> +
>> +    /* if not valid, mac80211 puts default (max value) */
>> +    for (i = 0; i < ARRAY_SIZE(cmd->psd_pwr); i++)
>> +        cmd->psd_pwr[i] = min(bss_info->tpe.psd_local[0].power[i],
>> +                      bss_info->tpe.psd_reg_client[0].power[i]);
>> +
>> +    BUILD_BUG_ON(ARRAY_SIZE(cmd->eirp_pwr) !=
>> +             ARRAY_SIZE(bss_info->tpe.max_local[0].power));
>> +
>> +    for (i = 0; i < ARRAY_SIZE(cmd->eirp_pwr); i++)
>> +        cmd->eirp_pwr[i] = min(bss_info->tpe.max_local[0].power[i],
>> +                       bss_info->tpe.max_reg_client[0].power[i]);
>> +}
>> +
>> +void
>>   iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
>>                       struct ieee80211_vif *vif,
>> -                    struct ieee80211_bss_conf *bss_conf)
>> +                    struct ieee80211_bss_conf *bss_conf,
>> +                    bool is_ap)
>>   {
>>       struct iwl_txpower_constraints_cmd cmd = {};
>>       struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>> @@ -546,19 +579,22 @@ iwl_mvm_send_ap_tx_power_constraint_cmd(struct
>> iwl_mvm *mvm,
>>           link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
>>           return;
>>   -    if (bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ ||
>> -        bss_conf->chanreq.oper.chan->flags &
>> -            IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT)
>> +    if (bss_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ)
>>           return;
>>         cmd.link_id = cpu_to_le16(link_info->fw_link_id);
>> -    /*
>> -     * Currently supporting VLP Soft AP only.
>> -     */
>> -    cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
>>       memset(cmd.psd_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.psd_pwr));
>>       memset(cmd.eirp_pwr, DEFAULT_TPE_TX_POWER, sizeof(cmd.eirp_pwr));
>>   +    if (is_ap) {
>> +        cmd.ap_type = cpu_to_le16(IWL_6GHZ_AP_TYPE_VLP);
>> +    } else if (bss_conf->power_type == IEEE80211_REG_UNSET_AP) {
>> +        return;
>> +    } else {
>> +        cmd.ap_type = cpu_to_le16(bss_conf->power_type - 1);
>> +        iwl_mvm_tpe_sta_cmd_data(&cmd, bss_conf);
>> +    }
>> +
>>       ret = iwl_mvm_send_cmd_pdu(mvm,
>>                      WIDE_ID(PHY_OPS_GROUP,
>>                          AP_TX_POWER_CONSTRAINTS_CMD),
>> @@ -580,7 +616,8 @@ static int iwl_mvm_mld_start_ap_ibss(struct
>> ieee80211_hw *hw,
>>       guard(mvm)(mvm);
>>         if (vif->type == NL80211_IFTYPE_AP)
>> -        iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif, link_conf);
>> +        iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif,
>> +                            link_conf, true);
>>         /* Send the beacon template */
>>       ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> index f3d9b8355c6b..9b939225990a 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> @@ -2962,4 +2962,10 @@ iwl_mvm_bt_coex_calculate_esr_mode(struct
>> iwl_mvm *mvm,
>>                      bool primary);
>>   int iwl_mvm_esr_non_bss_link(struct iwl_mvm *mvm, struct
>> ieee80211_vif *vif,
>>                    unsigned int link_id, bool active);
>> +
>> +void
>> +iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
>> +                    struct ieee80211_vif *vif,
>> +                    struct ieee80211_bss_conf *bss_conf,
>> +                    bool is_ap);
>>   #endif /* __IWL_MVM_H__ */
> 

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

