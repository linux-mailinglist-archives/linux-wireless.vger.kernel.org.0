Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113ECC1B78
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 08:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfI3Gal (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 02:30:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45624 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729521AbfI3Gak (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 02:30:40 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iEpCY-0008Pa-LD; Mon, 30 Sep 2019 09:30:36 +0300
Message-ID: <8223ddc8f648f7ed2073ddcc5f7812df224f2068.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Mon, 30 Sep 2019 09:30:29 +0300
In-Reply-To: <20190905212801.13404-1-greearb@candelatech.com>
References: <20190905212801.13404-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] iwl-mvm:  Report tx/rx antennas.
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-09-05 at 14:28 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This makes it easier for user-space to know how many antennas the
> radio has.  Seems to work with the AX200 radio, at least.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> index 964c7baabede..f90b003f154a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -440,10 +440,19 @@ const static struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
>  	},
>  };
>  
> +static int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
> +{
> +	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
> +	*tx_ant = iwl_mvm_get_valid_tx_ant(mvm);
> +	*rx_ant = iwl_mvm_get_valid_rx_ant(mvm);
> +	return 0;
> +}
> +
>  int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
>  {
>  	struct ieee80211_hw *hw = mvm->hw;
>  	int num_mac, ret, i;
> +	u32 tx_ant, rx_ant;
>  	static const u32 mvm_ciphers[] = {
>  		WLAN_CIPHER_SUITE_WEP40,
>  		WLAN_CIPHER_SUITE_WEP104,
> @@ -813,6 +822,10 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
>  		wiphy_ext_feature_set(hw->wiphy,
>  				      NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
>  
> +	iwl_mvm_op_get_antenna(hw, &tx_ant, &rx_ant);
> +	hw->wiphy->available_antennas_tx = tx_ant;
> +	hw->wiphy->available_antennas_rx = rx_ant;
> +

I changed this slightly so we call iwl_mvm_get_valid_tx/rx_ant() here
instead of calling the op function.  Then we don't need the local
variables and it's a bit clearer IMHO.


>  	ret = ieee80211_register_hw(mvm->hw);
>  	if (ret) {
>  		iwl_mvm_leds_exit(mvm);
> @@ -5167,6 +5180,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
>  	.tx = iwl_mvm_mac_tx,
>  	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
>  	.ampdu_action = iwl_mvm_mac_ampdu_action,
> +	.get_antenna = iwl_mvm_op_get_antenna,
>  	.start = iwl_mvm_mac_start,
>  	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
>  	.stop = iwl_mvm_mac_stop,

I've applied this (with the above-mentioned change) to our internal
tree and it should reach the mainline following our usual upstreaming
process.  Thanks!

--
Cheers,
Luca.

