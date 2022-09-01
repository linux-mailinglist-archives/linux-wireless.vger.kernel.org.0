Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979095A9FFF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiIATbw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 15:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiIATbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 15:31:51 -0400
X-Greylist: delayed 1813 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 12:31:49 PDT
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B374E7C503
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 12:31:49 -0700 (PDT)
Received: from 91-155-254-206.elisa-laajakaista.fi ([91.155.254.206] helo=[192.168.100.239])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1oTpRL-0037QQ-U1;
        Thu, 01 Sep 2022 22:01:25 +0300
Message-ID: <69f6258259cfe2e71549cd2709105c2dd2f97c79.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Mathy Vanhoef <vanhoefm@gmail.com>, gregory.greenman@intel.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 01 Sep 2022 22:01:23 +0300
In-Reply-To: <CAFXAJYy0iocmw6EuvzrhhG=Yq0w=6u++69Q28OQUVNe34kSLpQ@mail.gmail.com>
References: <20200424154818.2657602-1-luca@coelho.fi>
         <iwlwifi.20200424182644.674a325b008b.Ifc925ca84500fb76c7b6f926a24a34ca777b4192@changeid>
         <CAFXAJYy0iocmw6EuvzrhhG=Yq0w=6u++69Q28OQUVNe34kSLpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH 07/12] iwlwifi: mvm: stop supporting swcrypto and
 bt_coex_active module parameters
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-09-01 at 20:43 +0200, Mathy Vanhoef wrote:
> Some of my scripts to detect WPA2 key reinstallations rely on
> disabling hardware encryption/decryption to detect IV reuse (with a
> virtual interface in monitor mode). Otherwise the hardware may strip
> away the Packet Number meaning nonce reuse can't be detected. I
> realize this may not be used often in practice, but in general it
> would still be very useful to have the swcrypto parameter, it's very
> useful when doing Wi-Fi experiments.
> 
> Mathy

Hi Mathy,

I'm not the maintainer of the iwlwifi driver anymore, so I'm CCing
Gregory here, who is the new maintainer.  He may be able to answer you.

--
Cheers,
Luca.


> Op vr 24 apr. 2020 om 17:50 schreef Luca Coelho <luca@coelho.fi>:
> > 
> > From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > 
> > Leave them active for iwldvm. We do not test this configuration
> > and there is no reason nowadays to allow this.
> > 
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  7 ++--
> >  drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 31 ++++++--------
> >  .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 42 ++++++++-----------
> >  3 files changed, 33 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
> > index 3d2abbc5c76c..5ae22cd7ecdb 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
> > @@ -5,7 +5,7 @@
> >   *
> >   * GPL LICENSE SUMMARY
> >   *
> > - * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2013 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
> >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> > @@ -26,7 +26,7 @@
> >   *
> >   * BSD LICENSE
> >   *
> > - * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2013 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
> >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> >   * All rights reserved.
> >   *
> > @@ -216,8 +216,7 @@ int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm)
> >                 goto send_cmd;
> >         }
> > 
> > -       mode = iwlwifi_mod_params.bt_coex_active ? BT_COEX_NW : BT_COEX_DISABLE;
> > -       bt_cmd.mode = cpu_to_le32(mode);
> > +       bt_cmd.mode = cpu_to_le32(BT_COEX_NW);
> > 
> >         if (IWL_MVM_BT_COEX_SYNC2SCO)
> >                 bt_cmd.enabled_modules |=
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> > index 222775714859..89096bcb053e 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> > @@ -5,10 +5,9 @@
> >   *
> >   * GPL LICENSE SUMMARY
> >   *
> > - * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
> >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> >   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> > - * Copyright(c) 2018 - 2019 Intel Corporation
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of version 2 of the GNU General Public License as
> > @@ -28,10 +27,9 @@
> >   *
> >   * BSD LICENSE
> >   *
> > - * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
> >   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
> >   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> > - * Copyright(c) 2018 - 2019 Intel Corporation
> >   * All rights reserved.
> >   *
> >   * Redistribution and use in source and binary forms, with or without
> > @@ -80,9 +78,6 @@ void iwl_mvm_set_rekey_data(struct ieee80211_hw *hw,
> >         struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
> >         struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
> > 
> > -       if (iwlwifi_mod_params.swcrypto)
> > -               return;
> > -
> >         mutex_lock(&mvm->mutex);
> > 
> >         memcpy(mvmvif->rekey_data.kek, data->kek, NL80211_KEK_LEN);
> > @@ -843,18 +838,16 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
> >                         return ret;
> >         }
> > 
> > -       if (!iwlwifi_mod_params.swcrypto) {
> > -               /*
> > -                * This needs to be unlocked due to lock ordering
> > -                * constraints. Since we're in the suspend path
> > -                * that isn't really a problem though.
> > -                */
> > -               mutex_unlock(&mvm->mutex);
> > -               ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
> > -               mutex_lock(&mvm->mutex);
> > -               if (ret)
> > -                       return ret;
> > -       }
> > +       /*
> > +        * This needs to be unlocked due to lock ordering
> > +        * constraints. Since we're in the suspend path
> > +        * that isn't really a problem though.
> > +        */
> > +       mutex_unlock(&mvm->mutex);
> > +       ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
> > +       mutex_lock(&mvm->mutex);
> > +       if (ret)
> > +               return ret;
> > 
> >         ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, 0,
> >                                    sizeof(*wowlan_config_cmd),
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> > index 853ba7b8bf3f..ee3d2ff432f7 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> > @@ -475,23 +475,23 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
> >                 hw->wiphy->n_cipher_suites++;
> >         }
> > 
> > -       /* Enable 11w if software crypto is not enabled (as the
> > -        * firmware will interpret some mgmt packets, so enabling it
> > -        * with software crypto isn't safe).
> > -        */
> > -       if (!iwlwifi_mod_params.swcrypto) {
> > -               ieee80211_hw_set(hw, MFP_CAPABLE);
> > +       if (iwlwifi_mod_params.swcrypto)
> > +               IWL_ERR(mvm,
> > +                       "iwlmvm doesn't allow to disable HW crypto, check swcrypto module parameter\n");
> > +       if (!iwlwifi_mod_params.bt_coex_active)
> > +               IWL_ERR(mvm,
> > +                       "iwlmvm doesn't allow to disable BT Coex, check bt_coex_active module parameter\n");
> > +
> > +       ieee80211_hw_set(hw, MFP_CAPABLE);
> > +       mvm->ciphers[hw->wiphy->n_cipher_suites] = WLAN_CIPHER_SUITE_AES_CMAC;
> > +       hw->wiphy->n_cipher_suites++;
> > +       if (iwl_mvm_has_new_rx_api(mvm)) {
> >                 mvm->ciphers[hw->wiphy->n_cipher_suites] =
> > -                       WLAN_CIPHER_SUITE_AES_CMAC;
> > +                       WLAN_CIPHER_SUITE_BIP_GMAC_128;
> > +               hw->wiphy->n_cipher_suites++;
> > +               mvm->ciphers[hw->wiphy->n_cipher_suites] =
> > +                       WLAN_CIPHER_SUITE_BIP_GMAC_256;
> >                 hw->wiphy->n_cipher_suites++;
> > -               if (iwl_mvm_has_new_rx_api(mvm)) {
> > -                       mvm->ciphers[hw->wiphy->n_cipher_suites] =
> > -                               WLAN_CIPHER_SUITE_BIP_GMAC_128;
> > -                       hw->wiphy->n_cipher_suites++;
> > -                       mvm->ciphers[hw->wiphy->n_cipher_suites] =
> > -                               WLAN_CIPHER_SUITE_BIP_GMAC_256;
> > -                       hw->wiphy->n_cipher_suites++;
> > -               }
> >         }
> > 
> >         /* currently FW API supports only one optional cipher scheme */
> > @@ -697,10 +697,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
> >                                      WIPHY_WOWLAN_EAP_IDENTITY_REQ |
> >                                      WIPHY_WOWLAN_RFKILL_RELEASE |
> >                                      WIPHY_WOWLAN_NET_DETECT;
> > -               if (!iwlwifi_mod_params.swcrypto)
> > -                       mvm->wowlan.flags |= WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
> > -                                            WIPHY_WOWLAN_GTK_REKEY_FAILURE |
> > -                                            WIPHY_WOWLAN_4WAY_HANDSHAKE;
> > +               mvm->wowlan.flags |= WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
> > +                                    WIPHY_WOWLAN_GTK_REKEY_FAILURE |
> > +                                    WIPHY_WOWLAN_4WAY_HANDSHAKE;
> > 
> >                 mvm->wowlan.n_patterns = IWL_WOWLAN_MAX_PATTERNS;
> >                 mvm->wowlan.pattern_min_len = IWL_WOWLAN_MIN_PATTERN_LEN;
> > @@ -3366,11 +3365,6 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
> >         int ret, i;
> >         u8 key_offset;
> > 
> > -       if (iwlwifi_mod_params.swcrypto) {
> > -               IWL_DEBUG_MAC80211(mvm, "leave - hwcrypto disabled\n");
> > -               return -EOPNOTSUPP;
> > -       }
> > -
> >         switch (key->cipher) {
> >         case WLAN_CIPHER_SUITE_TKIP:
> >                 if (!mvm->trans->trans_cfg->gen2) {
> > --
> > 2.26.2
> > 

