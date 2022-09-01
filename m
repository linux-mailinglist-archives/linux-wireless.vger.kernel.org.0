Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762D95A9F4B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiIASny (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiIASnm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 14:43:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35D564DE
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 11:43:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id se27so28817330ejb.8
        for <linux-wireless@vger.kernel.org>; Thu, 01 Sep 2022 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CE0aq5vl12GeraWb6mZlCh2WVq+/pdvTUkvRubs/onU=;
        b=Zwi4JrXHsdsF1mVUIqbIo10uFhIN7cdQ5fF8s3TQRTyviRuWIG0+Ddmz6RhyCAp6fV
         oOYfD+uQ0STpJcSX1msoFBoEwWMGuhsgA/sH32RfwibFEnoxg2toA8xUsdVIqyq2UYES
         AaK95nrsN+BuZrPUOsm4UAdud7rS8RvEjAOX3n9q5QWaSTaDr+9R9frImRwQLZdOhHXn
         rd5/dS7ZNXZXAg6qlVGgIBCM0Lh8r/uCnbsvPqeEl5WdTF9xDWL3BlB2DVE/SPAo5hib
         6rECZ7+mh6G80pZLGYWDUytPNvlUe8sltgspUGavqxNSE3hoi/Ka1Afp/4XR3qrVz3Wy
         +/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CE0aq5vl12GeraWb6mZlCh2WVq+/pdvTUkvRubs/onU=;
        b=LYyhInX1WSweEmS+yDY0JHzA8EOP77pQLSAym+8L+qlpam632ZxOBgvkaQzaB6DoCN
         3MUF521f778XuSsVYe9AMWch9cwrVKXXJxn9IHC1m2BfrQhq+YnaQTy+zINSuLC04VZS
         oCtmf7FgJxChvMDhBCZ41gV8zZs7hS9fyn5iRFGPDoT3Kb59F2g/VpT+O4XA8Id1vH2E
         Vukh8kmHcWqGWx+ilKwOJ/G9tSejWF/CJBo/rjphUequTiQbaBK6MLLo0T9zMlV52yEl
         yW1+GRy8mMwKXqq2GdgUF2KIn50b4TnCy+SicTwJddDPs7i/T3lWV/M3fRPMO+0MjsbL
         KQhA==
X-Gm-Message-State: ACgBeo3nWMil7ACjDXom1Bi6hRiWrQApaJ+YIRFIj05a7YGyxzF4KHAZ
        yeuxsteH5LKW1oATm9gvFmQgzpO9Xqb/Gp6IUZ0ZyyeU/hs=
X-Google-Smtp-Source: AA6agR6jPAt1r52i5/5lca9NFXKf3rKQmiSngguLV5vN2z22qZq+QUlc19YVSOrrNzp3eyomUCWNiDJft1h6Dagufhk=
X-Received: by 2002:a17:907:1dec:b0:741:44ca:131a with SMTP id
 og44-20020a1709071dec00b0074144ca131amr17684306ejc.695.1662057818706; Thu, 01
 Sep 2022 11:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200424154818.2657602-1-luca@coelho.fi> <iwlwifi.20200424182644.674a325b008b.Ifc925ca84500fb76c7b6f926a24a34ca777b4192@changeid>
In-Reply-To: <iwlwifi.20200424182644.674a325b008b.Ifc925ca84500fb76c7b6f926a24a34ca777b4192@changeid>
From:   Mathy Vanhoef <vanhoefm@gmail.com>
Date:   Thu, 1 Sep 2022 20:43:27 +0200
Message-ID: <CAFXAJYy0iocmw6EuvzrhhG=Yq0w=6u++69Q28OQUVNe34kSLpQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] iwlwifi: mvm: stop supporting swcrypto and
 bt_coex_active module parameters
To:     Luca Coelho <luca@coelho.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some of my scripts to detect WPA2 key reinstallations rely on
disabling hardware encryption/decryption to detect IV reuse (with a
virtual interface in monitor mode). Otherwise the hardware may strip
away the Packet Number meaning nonce reuse can't be detected. I
realize this may not be used often in practice, but in general it
would still be very useful to have the swcrypto parameter, it's very
useful when doing Wi-Fi experiments.

Mathy

Op vr 24 apr. 2020 om 17:50 schreef Luca Coelho <luca@coelho.fi>:
>
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> Leave them active for iwldvm. We do not test this configuration
> and there is no reason nowadays to allow this.
>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  7 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 31 ++++++--------
>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 42 ++++++++-----------
>  3 files changed, 33 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
> index 3d2abbc5c76c..5ae22cd7ecdb 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
> @@ -5,7 +5,7 @@
>   *
>   * GPL LICENSE SUMMARY
>   *
> - * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
> + * Copyright(c) 2013 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
>   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -26,7 +26,7 @@
>   *
>   * BSD LICENSE
>   *
> - * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
> + * Copyright(c) 2013 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
>   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
>   * All rights reserved.
>   *
> @@ -216,8 +216,7 @@ int iwl_mvm_send_bt_init_conf(struct iwl_mvm *mvm)
>                 goto send_cmd;
>         }
>
> -       mode = iwlwifi_mod_params.bt_coex_active ? BT_COEX_NW : BT_COEX_DISABLE;
> -       bt_cmd.mode = cpu_to_le32(mode);
> +       bt_cmd.mode = cpu_to_le32(BT_COEX_NW);
>
>         if (IWL_MVM_BT_COEX_SYNC2SCO)
>                 bt_cmd.enabled_modules |=
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index 222775714859..89096bcb053e 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -5,10 +5,9 @@
>   *
>   * GPL LICENSE SUMMARY
>   *
> - * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
> + * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
>   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
>   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> - * Copyright(c) 2018 - 2019 Intel Corporation
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of version 2 of the GNU General Public License as
> @@ -28,10 +27,9 @@
>   *
>   * BSD LICENSE
>   *
> - * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
> + * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
>   * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
>   * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
> - * Copyright(c) 2018 - 2019 Intel Corporation
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> @@ -80,9 +78,6 @@ void iwl_mvm_set_rekey_data(struct ieee80211_hw *hw,
>         struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
>         struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>
> -       if (iwlwifi_mod_params.swcrypto)
> -               return;
> -
>         mutex_lock(&mvm->mutex);
>
>         memcpy(mvmvif->rekey_data.kek, data->kek, NL80211_KEK_LEN);
> @@ -843,18 +838,16 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
>                         return ret;
>         }
>
> -       if (!iwlwifi_mod_params.swcrypto) {
> -               /*
> -                * This needs to be unlocked due to lock ordering
> -                * constraints. Since we're in the suspend path
> -                * that isn't really a problem though.
> -                */
> -               mutex_unlock(&mvm->mutex);
> -               ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
> -               mutex_lock(&mvm->mutex);
> -               if (ret)
> -                       return ret;
> -       }
> +       /*
> +        * This needs to be unlocked due to lock ordering
> +        * constraints. Since we're in the suspend path
> +        * that isn't really a problem though.
> +        */
> +       mutex_unlock(&mvm->mutex);
> +       ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
> +       mutex_lock(&mvm->mutex);
> +       if (ret)
> +               return ret;
>
>         ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, 0,
>                                    sizeof(*wowlan_config_cmd),
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> index 853ba7b8bf3f..ee3d2ff432f7 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -475,23 +475,23 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
>                 hw->wiphy->n_cipher_suites++;
>         }
>
> -       /* Enable 11w if software crypto is not enabled (as the
> -        * firmware will interpret some mgmt packets, so enabling it
> -        * with software crypto isn't safe).
> -        */
> -       if (!iwlwifi_mod_params.swcrypto) {
> -               ieee80211_hw_set(hw, MFP_CAPABLE);
> +       if (iwlwifi_mod_params.swcrypto)
> +               IWL_ERR(mvm,
> +                       "iwlmvm doesn't allow to disable HW crypto, check swcrypto module parameter\n");
> +       if (!iwlwifi_mod_params.bt_coex_active)
> +               IWL_ERR(mvm,
> +                       "iwlmvm doesn't allow to disable BT Coex, check bt_coex_active module parameter\n");
> +
> +       ieee80211_hw_set(hw, MFP_CAPABLE);
> +       mvm->ciphers[hw->wiphy->n_cipher_suites] = WLAN_CIPHER_SUITE_AES_CMAC;
> +       hw->wiphy->n_cipher_suites++;
> +       if (iwl_mvm_has_new_rx_api(mvm)) {
>                 mvm->ciphers[hw->wiphy->n_cipher_suites] =
> -                       WLAN_CIPHER_SUITE_AES_CMAC;
> +                       WLAN_CIPHER_SUITE_BIP_GMAC_128;
> +               hw->wiphy->n_cipher_suites++;
> +               mvm->ciphers[hw->wiphy->n_cipher_suites] =
> +                       WLAN_CIPHER_SUITE_BIP_GMAC_256;
>                 hw->wiphy->n_cipher_suites++;
> -               if (iwl_mvm_has_new_rx_api(mvm)) {
> -                       mvm->ciphers[hw->wiphy->n_cipher_suites] =
> -                               WLAN_CIPHER_SUITE_BIP_GMAC_128;
> -                       hw->wiphy->n_cipher_suites++;
> -                       mvm->ciphers[hw->wiphy->n_cipher_suites] =
> -                               WLAN_CIPHER_SUITE_BIP_GMAC_256;
> -                       hw->wiphy->n_cipher_suites++;
> -               }
>         }
>
>         /* currently FW API supports only one optional cipher scheme */
> @@ -697,10 +697,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
>                                      WIPHY_WOWLAN_EAP_IDENTITY_REQ |
>                                      WIPHY_WOWLAN_RFKILL_RELEASE |
>                                      WIPHY_WOWLAN_NET_DETECT;
> -               if (!iwlwifi_mod_params.swcrypto)
> -                       mvm->wowlan.flags |= WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
> -                                            WIPHY_WOWLAN_GTK_REKEY_FAILURE |
> -                                            WIPHY_WOWLAN_4WAY_HANDSHAKE;
> +               mvm->wowlan.flags |= WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
> +                                    WIPHY_WOWLAN_GTK_REKEY_FAILURE |
> +                                    WIPHY_WOWLAN_4WAY_HANDSHAKE;
>
>                 mvm->wowlan.n_patterns = IWL_WOWLAN_MAX_PATTERNS;
>                 mvm->wowlan.pattern_min_len = IWL_WOWLAN_MIN_PATTERN_LEN;
> @@ -3366,11 +3365,6 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
>         int ret, i;
>         u8 key_offset;
>
> -       if (iwlwifi_mod_params.swcrypto) {
> -               IWL_DEBUG_MAC80211(mvm, "leave - hwcrypto disabled\n");
> -               return -EOPNOTSUPP;
> -       }
> -
>         switch (key->cipher) {
>         case WLAN_CIPHER_SUITE_TKIP:
>                 if (!mvm->trans->trans_cfg->gen2) {
> --
> 2.26.2
>
