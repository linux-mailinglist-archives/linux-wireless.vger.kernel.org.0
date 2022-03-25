Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611C4E79B0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiCYRNZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCYRNY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 13:13:24 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4990DC12CB
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 10:11:50 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.31])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E34C31C0095;
        Fri, 25 Mar 2022 17:11:32 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 959C26001C7;
        Fri, 25 Mar 2022 17:11:32 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D491713C2B0;
        Fri, 25 Mar 2022 10:11:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D491713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1648228291;
        bh=qTREhwqWwhwCUckUY7hqVF25Px13R4deVZiDynfBH20=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bwoLUpjaesVb9OWpyk0XdhL1X78wdN7fjmri9pfw0hHnMD1svB1opaxahLD6t4W/e
         GS8Y1rcPKfkH3WYVd68HZ70mCs3WgxTc+HyW9x+X1kbS4Qo34hJ+A9j4sUriQKnWWF
         FC2+3HU/AyHC9a0gbgNAJE7lEVBQPHMC775WFUh8=
Subject: Re: [PATCH 04/12] iwlwifi: mvm: Passively scan non PSC channels only
 when requested so
To:     Luca Coelho <luca@coelho.fi>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org
References: <20220204102511.606112-1-luca@coelho.fi>
 <iwlwifi.20220204122220.457da4cc95eb.Ic98472bab5f5475f1e102547644caaae89ce4c4a@changeid>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f18f11f2-b9b9-9d86-340e-d567247ef7bc@candelatech.com>
Date:   Fri, 25 Mar 2022 10:11:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20220204122220.457da4cc95eb.Ic98472bab5f5475f1e102547644caaae89ce4c4a@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1648228301-h8oVxPg7qFbV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/4/22 2:25 AM, Luca Coelho wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> Non PSC channels should generally be scanned based on information about
> collocated APs obtained during scan on legacy bands, and otherwise
> should not be scanned unless specifically requested so (as there are
> relatively many non PSC channels, scanning them passively is time consuming
> and interferes with regular data traffic).
> 
> Thus, modify the scan logic to avoid passively scanning PSC channels
> if there is no information about collocated APs and the scan is not
> a passive scan.

Hello,

This breaks association against a Cisco test AP on frequency 5995.

Here are logs of the previous commit working (scan takes longer, but SSID
is found), and at the bottom, scan with this commit, which fails to detect
the SSID.

# ethtool -i sta0000
driver: iwlwifi
version: 5.17.0+
firmware-version: 68.01d30b0c.0 ty-a0-gf-a0-68.uc
expansion-rom-version:
bus-info: 0000:05:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no

It breaks on version 71 firmware too.

2022-03-25 09:56:35.464  1.1:  sta0000 (phy #0): scan started
2022-03-25 09:56:42.095  1.1:  sta0000 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 
5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 
6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415 6435 6455 6475 6495 6515 6535 6555 6575 6595 6615 6635 6655 6675 6695 6715 6735 6755 6775 6795 6815 6835 
6855 6875 6895 6915 6935 6955 6975 6995 7015 7035 7055 7075 7095 7115, ""
2022-03-25 09:56:42.101  1.1:  IFNAME=sta0000 <3>SME: Trying to authenticate with 68:7d:b4:60:04:b8 (SSID=
2022-03-25 09:56:42.122  1.1:  sta0000: new station 68:7d:b4:60:04:b8
2022-03-25 09:56:42.252  1.1:  sta0000 (phy #0): auth 68:7d:b4:60:04:b8 -> a4:6b:b6:5a:b1:da status: 126: <unknown>
2022-03-25 09:56:42.254  1.1:  IFNAME=sta0000 <3>SME: Trying to authenticate with 68:7d:b4:60:04:b8 (SSID=
2022-03-25 09:56:42.310  1.1:  sta0000 (phy #0): auth 68:7d:b4:60:04:b8 -> a4:6b:b6:5a:b1:da status: 0: Successful
2022-03-25 09:56:42.310  1.1:  IFNAME=sta0000 <3>PMKSA-CACHE-ADDED 68:7d:b4:60:04:b8 0
2022-03-25 09:56:42.311  1.1:  IFNAME=sta0000 <3>Trying to associate with 68:7d:b4:60:04:b8 (SSID=
2022-03-25 09:56:42.312  1.1:  IFNAME=sta0000 <3>EAPOL-RX 68:7d:b4:60:04:b8 121
2022-03-25 09:56:42.313  1.1:  sta0000 (phy #0): assoc 68:7d:b4:60:04:b8 -> a4:6b:b6:5a:b1:da status: 0: Successful
2022-03-25 09:56:42.313  1.1:  IFNAME=sta0000 <3>Associated with 68:7d:b4:60:04:b8
2022-03-25 09:56:42.314  1.1:  IFNAME=sta0000 <3>EAPOL-RX 68:7d:b4:60:04:b8 121
2022-03-25 09:56:42.321  1.1:  IFNAME=sta0000 <3>CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
2022-03-25 09:56:42.322  1.1:  sta0000 (phy #0): ctrl. port TX status (cookie 1): acked
2022-03-25 09:56:42.323  1.1:  IFNAME=sta0000 <3>EAPOL-RX 68:7d:b4:60:04:b8 195
2022-03-25 09:56:42.328  1.1:  sta0000 (phy #0): ctrl. port TX status (cookie 2): acked
2022-03-25 09:56:42.364  1.1:  IFNAME=sta0000 <3>WPA: Key negotiation completed with 68:7d:b4:60:04:b8 [PTK=CCMP GTK=CCMP]
2022-03-25 09:56:42.403  1.1:  IFNAME=sta0000 <3>CTRL-EVENT-CONNECTED - Connection to 68:7d:b4:60:04:b8 completed [id=0 id_str=]
2022-03-25 09:56:42.403  1.1:  IFNAME=sta0000 <3>WPA: Key negotiation completed with 68:7d:b4:60:04:b8 [PTK=CCMP GTK=CCMP]



2022-03-25 10:05:52.416  1.1:  sta0000 (phy #7): scan started
2022-03-25 10:05:56.215  1.1:  sta0000 (phy #7): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 
5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825, ""
2022-03-25 10:05:56.215  1.1:  phy #7: regulatory domain change (phy): set to US by a driver request on phy7
2022-03-25 10:05:56.216  1.1:  IFNAME=sta0000 <3>CTRL-EVENT-NETWORK-NOT-FOUND
2022-03-25 10:05:56.216  1.1:  IFNAME=sta0000 <3>CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=US
2022-03-25 10:06:01.217  1.1:  IFNAME=sta0000 <3>CTRL-EVENT-SCAN-STARTED
2022-03-25 10:06:01.217  1.1:  sta0000 (phy #7): scan started
2022-03-25 10:06:02.739  1.1:  sta0000 (phy #7): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 
5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5955 5975 5995 6015 6035 6055 6075 6095 6115 6135 6155 6175 6195 
6215 6235 6255 6275 6295 6315 6335 6355 6375 6395 6415 6435 6455 6475 6495 6515 6535 6555 6575 6595 6615 6635 6655 6675 6695 6715 6735 6755 6775 6795 6815 6835 
6855 6875 6895 6915 6935 6955 6975 6995 7015 7035 7055 7075 7095 7115, ""

[ SSID is not found, sta never associates]

Thanks,
Ben

> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>   drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 42 ++++++++++++++-----
>   1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> index 8c7cb491330d..901df916baa4 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> @@ -1728,27 +1728,37 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
>   }
>   
>   /* TODO: this function can be merged with iwl_mvm_scan_umac_fill_ch_p_v6 */
> -static void
> -iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
> +static u32
> +iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
> +				     struct iwl_mvm_scan_params *params,
>   				     u32 n_channels,
>   				     struct iwl_scan_probe_params_v4 *pp,
>   				     struct iwl_scan_channel_params_v6 *cp,
>   				     enum nl80211_iftype vif_type)
>   {
> -	struct iwl_scan_channel_cfg_umac *channel_cfg = cp->channel_config;
>   	int i;
>   	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
>   		params->scan_6ghz_params;
> +	u32 ch_cnt;
>   
> -	for (i = 0; i < params->n_channels; i++) {
> +	for (i = 0, ch_cnt = 0; i < params->n_channels; i++) {
>   		struct iwl_scan_channel_cfg_umac *cfg =
> -			&cp->channel_config[i];
> +			&cp->channel_config[ch_cnt];
>   
>   		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
>   		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
>   		bool force_passive, found = false, allow_passive = true,
>   		     unsolicited_probe_on_chan = false, psc_no_listen = false;
>   
> +		/*
> +		 * Avoid performing passive scan on non PSC channels unless the
> +		 * scan is specifically a passive scan, i.e., no SSIDs
> +		 * configured in the scan command.
> +		 */
> +		if (!cfg80211_channel_is_psc(params->channels[i]) &&
> +		    !params->n_6ghz_params && params->n_ssids)
> +			continue;
> +
>   		cfg->v1.channel_num = params->channels[i]->hw_value;
>   		cfg->v2.band = 2;
>   		cfg->v2.iter_count = 1;
> @@ -1868,8 +1878,16 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
>   		else
>   			flags |= bssid_bitmap | (s_ssid_bitmap << 16);
>   
> -		channel_cfg[i].flags |= cpu_to_le32(flags);
> +		cfg->flags |= cpu_to_le32(flags);
> +		ch_cnt++;
>   	}
> +
> +	if (params->n_channels > ch_cnt)
> +		IWL_DEBUG_SCAN(mvm,
> +			       "6GHz: reducing number channels: (%u->%u)\n",
> +			       params->n_channels, ch_cnt);
> +
> +	return ch_cnt;
>   }
>   
>   static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
> @@ -2415,10 +2433,14 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
>   
>   	iwl_mvm_umac_scan_fill_6g_chan_list(mvm, params, pb);
>   
> -	iwl_mvm_umac_scan_cfg_channels_v6_6g(params,
> -					     params->n_channels,
> -					     pb, cp, vif->type);
> -	cp->count = params->n_channels;
> +	cp->count = iwl_mvm_umac_scan_cfg_channels_v6_6g(mvm, params,
> +							 params->n_channels,
> +							 pb, cp, vif->type);
> +	if (!cp->count) {
> +		mvm->scan_uid_status[uid] = 0;
> +		return -EINVAL;
> +	}
> +
>   	if (!params->n_ssids ||
>   	    (params->n_ssids == 1 && !params->ssids[0].ssid_len))
>   		cp->flags |= IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER;
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

