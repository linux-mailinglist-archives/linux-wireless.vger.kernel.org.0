Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD83588240
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 21:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiHBTGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiHBTGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 15:06:13 -0400
X-Greylist: delayed 932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 12:06:09 PDT
Received: from collins.uni-paderborn.de (collins.uni-paderborn.de [IPv6:2001:638:502:c003::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB9EDF7B
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7Dy+8eRkD0/fJnaZhEbNfVViajnuVZz+nkEkM5hVqVQ=; b=JGnHUoj1vw+UUVNBMePfee/jIt
        kRQXCtWsUGT2Qa9Gq5/Knd04WDw8m6ehfKgvm27rNlxFMYhbgMi35hGfYBKfb6FV4qHS2dTQuDtHf
        UTuJ7XEjKVi/D1nuvNeJVgVz0DBAIsBtQBd4562CK2EQW1zFldMueAxCebQM9oDZYYi8=;
Message-ID: <c09a353b-8e52-6d9d-a3c6-743e4e6f444b@mail.uni-paderborn.de>
Date:   Tue, 2 Aug 2022 20:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Dennis Baurichter <dennisba@mail.uni-paderborn.de>
Subject: Re: [PATCH] iwlwifi: Make missed beacon timeout configurable
To:     Zachary Michaels <mikezackles@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Troy Volin <tmvolin@gmail.com>
References: <20220226045047.643695-1-mikezackles@gmail.com>
Content-Language: en-GB-large
In-Reply-To: <20220226045047.643695-1-mikezackles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=88.76.124.175,fs=190799,da=147075298,mc=2,sc=0,hc=2,sp=0,fso=190799,re=0,sd=0,hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2022.8.2.183921, AntiVirus-Engine: 5.92.0, AntiVirus-Data: 2022.8.2.5920000
X-IMT-Authenticated-Sender: uid=dennisba,ou=People,o=upb,c=de
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

the below patch was sent to linux-wireless 5 months ago, but (as far as 
I can see on lore.kernel.org) didn't get a reply, so I guess it might 
have slipped through? May I ask to consider it for inclusion?

As stated below, this is a workaround for frequent wifi disconnects 
described in https://bugzilla.kernel.org/show_bug.cgi?id=203709. As an 
example, on one laptop with Intel Dual Band Wireless AC 3160 these 
disconnects occured sporadically initially, but later became very 
frequent, e.g. around 100 disconnects within 5 hours (with the laptop 1m 
from the wifi access point). Setting the beacon_timeout parameter 
provided by the patch allowed me to completely "fix" / work around the 
problem, with no disconnects anymore. Many more examples can be found in 
the linked bug report.

Regards,
Dennis

On 2022-02-26 at 05:50, Zachary Michaels wrote:
> Makes the beacon timeout a module parameter, allowing the original default (16
> missed beacons) to be kept while also enabling users that experience problems to
> increase the timeout.
> 
> For context, this patch has been in circulation for over a year as a workaround
> for unstable/unusable wifi, as documented in
> https://bugzilla.kernel.org/show_bug.cgi?id=203709
> The linked bug report has received nearly 300 comments in the nearly three years
> it has been open. During that time evidence has been presented indicating that
> this is likely to be a firmware bug, but no firmware fix has been documented on
> the tracker, and new issue reports continue to surface. This patch provides an
> escape hatch for users that are stuck.
> 
> Signed-off-by: Zachary Michaels <mikezackles@gmail.com>
> ---
>   drivers/net/wireless/intel/iwlwifi/iwl-drv.c       | 4 ++++
>   drivers/net/wireless/intel/iwlwifi/iwl-modparams.h | 2 ++
>   drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  | 3 ++-
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       | 1 -
>   4 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
> index 506d05953314..c5f5787da35c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
> @@ -1753,6 +1753,7 @@ struct iwl_mod_params iwlwifi_mod_params = {
>   	.power_level = IWL_POWER_INDEX_1,
>   	.uapsd_disable = IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT,
>   	.enable_ini = true,
> +	.beacon_timeout = 16,
>   	/* the rest are 0 by default */
>   };
>   IWL_EXPORT_SYMBOL(iwlwifi_mod_params);
> @@ -1868,6 +1869,9 @@ module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
>   		   bool, S_IRUGO | S_IWUSR);
>   MODULE_PARM_DESC(enable_ini,
>   		 "Enable debug INI TLV FW debug infrastructure (default: true");
> +module_param_named(beacon_timeout, iwlwifi_mod_params.beacon_timeout, uint, 0644);
> +MODULE_PARM_DESC(beacon_timeout,
> +		 "Number of missed beacons before disconnecting (default: 16)");
>   
>   /*
>    * set bt_coex_active to true, uCode will do kill/defer
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
> index 004ebdac4535..198c5ac2575b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
> @@ -62,6 +62,7 @@ enum iwl_uapsd_disable {
>    * @disable_11ac: disable VHT capabilities, default = false.
>    * @remove_when_gone: remove an inaccessible device from the PCIe bus.
>    * @enable_ini: enable new FW debug infratructure (INI TLVs)
> + * @beacon_timeout: number of missed beacons before disconnect, default = 16
>    */
>   struct iwl_mod_params {
>   	int swcrypto;
> @@ -84,6 +85,7 @@ struct iwl_mod_params {
>   	bool disable_11ax;
>   	bool remove_when_gone;
>   	bool enable_ini;
> +	u32 beacon_timeout;
>   };
>   
>   static inline bool iwl_enable_rx_ampdu(void)
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> index fd7d4abfb454..c3d13326a203 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
> @@ -8,6 +8,7 @@
>   #include <linux/crc32.h>
>   #include <net/mac80211.h>
>   #include "iwl-io.h"
> +#include "iwl-modparams.h"
>   #include "iwl-prph.h"
>   #include "fw-api.h"
>   #include "mvm.h"
> @@ -1420,7 +1421,7 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
>   	 * TODO: the threshold should be adjusted based on latency conditions,
>   	 * and/or in case of a CS flow on one of the other AP vifs.
>   	 */
> -	if (rx_missed_bcon > IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG)
> +	if (rx_missed_bcon > iwlwifi_mod_params.beacon_timeout)
>   		iwl_mvm_connection_loss(mvm, vif, "missed beacons");
>   	else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD)
>   		ieee80211_beacon_loss(vif);
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> index da8330b5e6d5..27ccfc94474f 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> @@ -38,7 +38,6 @@
>   /* RSSI offset for WkP */
>   #define IWL_RSSI_OFFSET 50
>   #define IWL_MVM_MISSED_BEACONS_THRESHOLD 8
> -#define IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG 16
>   
>   /* A TimeUnit is 1024 microsecond */
>   #define MSEC_TO_TU(_msec)	(_msec*1000/1024)
