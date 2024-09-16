Return-Path: <linux-wireless+bounces-12890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB14979F8C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E482E1C231FC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D814B94C;
	Mon, 16 Sep 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDPbopgt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B938DC7;
	Mon, 16 Sep 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483234; cv=none; b=SIO/2cgky2+6hMwYAW0xbHNyxYTWiyx7cIgeZ//D/M6r2tVzr7KPwA4jQln5yck4w1wkx60FmKxaIzjjlHJNIn4IoA4IWKldc1Lfa3dcqjwRqbw5xzXUhYqgPvi8nwyDHfV/SLi9byTPfEwmT9BSbbN77gA981FNdCzzc7ZYIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483234; c=relaxed/simple;
	bh=R/tv/PG/re9DMp/KexY3jtkuZR5gVexp5j+E1jOmrMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOnpijqrfODZlgt47ddyLnKivKTK5x57UWRO/vUrPVVYXAJCjJMR0APImd2hbrP3cerPF5XnROAyQhttQMMYcz0ujXqtXdis43zj6ltzUd+qTgqT7gLvguYzsnbVJ53nMrnUmAPXZRX+8i6nhlLnsvlk2Z+nslqKIXgUq9fGptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDPbopgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FF2C4CEC4;
	Mon, 16 Sep 2024 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726483233;
	bh=R/tv/PG/re9DMp/KexY3jtkuZR5gVexp5j+E1jOmrMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qDPbopgt8GBjtyPaX0myPcxshk8F6qoq61DGlrLm4+qfpVv6/JZLQOtIYTja2x+bD
	 d2UofwZadEuLQBaFfkgLQUt7DxEJAbsBeq8tIYBT3gulY3pBcq527JSEdJ6TlzG7kw
	 k+BOp4ayeGmfx+aJjJkpQu7lvt3Frfq885Gw9sdpiCPIis/L6R7NQtTfF0K1R/87Q3
	 AHLtAx2hfQG2mYGVUb7aRwi2Lc1aN2CzcDBdpfhHlvGQoDMYsSjWlVRiXRBrvz4qHp
	 tptWZifsckyXRYYKPdb3C1i+T2uHFYKNxWKEOdXMixCyMUENgGw6zYatFI4mRVuexZ
	 pUZ9Zq1MTRETw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so44678211fa.2;
        Mon, 16 Sep 2024 03:40:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpTe0nZesuTn3IrMoCy40dtMxEhHQoY+PbkjTo2hg1VMaHi0sqJO9lG51NOlj8IGq3036zFdplESmJYTWtX0E=@vger.kernel.org, AJvYcCVC/KwGr2HzcVaaTRApmmE2BYUsh6UH4bAgRBHEoBJfI1SKOlJX6dp9605mDvitpXStsrX56D+B@vger.kernel.org, AJvYcCWz//PO6cVtiUOElfps7irAov2BhrrpgGhjbZwgH/48HxlgM6Z80DBm1bR9qf6fO+Q1LjJXXysxOOb9uWit@vger.kernel.org, AJvYcCXHl9QlJGVNC1oeNiPkPN4Gj62JVD6ziCe6IIePQWgmnFH56VbMn2G51iCpz/yzf4LHRojy7jMCd1L/OLUOoSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9U2jRaON53grjp9a1jT7URC8x6AykAFDg/iULau2qstNkxTk
	zBmJUMSEEt5Xv+z4XwMdSDuOCkmanMORO1zy4JLvsyHBwQdGnSfJbDQVy+4DBA+rRvmD1LMuunw
	o1B2WB/ykUQ/C+2mptFZXfcq5iec=
X-Google-Smtp-Source: AGHT+IHci19v6eZ0KWibw+xJghDYZwwlDnzhLvraPYtksohn2YJy0L4iXMElJbEcseIs6dNQ418WSqyIYnSZTP2qqx4=
X-Received: by 2002:a05:651c:2111:b0:2f6:6202:bfd5 with SMTP id
 38308e7fff4ca-2f787f44772mr81255921fa.34.1726483232078; Mon, 16 Sep 2024
 03:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrZrNfUZtUIqvbUI@cute>
In-Reply-To: <ZrZrNfUZtUIqvbUI@cute>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 16 Sep 2024 12:40:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGWV-S6Wec8LpEj9kvMufpn_Gjgqdybudxq4rnwjg3a+Q@mail.gmail.com>
Message-ID: <CAMj1kXGWV-S6Wec8LpEj9kvMufpn_Gjgqdybudxq4rnwjg3a+Q@mail.gmail.com>
Subject: Re: [PATCH][next] wifi: iwlwifi: mvm: Use __counted_by() and avoid
 -Wfamnae warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 21:17, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>
> So, use the `DEFINE_FLEX()` helper for multiple on-stack definitions
> of flexible structures where the size of their flexible-array members
> are known at compile-time, and refactor the rest of the code,
> accordingly.
>
> In order to allow for the use of `DEFINE_FLEX()`, a couple of
> structures were annotated with the `__counted_by()` attribute.
>
> With these changes, fix the following warnings:
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:124:52: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2053:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2211:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  .../net/wireless/intel/iwlwifi/fw/api/sta.h   |   2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 126 ++++++++----------
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   2 +-
>  include/net/mac80211.h                        |   2 +-
>  4 files changed, 61 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
> index d7f8a276b683..fe6bd34fefa3 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
> @@ -479,7 +479,7 @@ struct iwl_mvm_wep_key_cmd {
>         u8 decryption_type;
>         u8 flags;
>         u8 reserved;
> -       struct iwl_mvm_wep_key wep_key[];
> +       struct iwl_mvm_wep_key wep_key[] __counted_by(num_keys);
>  } __packed; /* SEC_CURR_WEP_KEY_CMD_API_S_VER_2 */
>
>  /**
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index b4d650583ac2..b19579dd8de3 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -120,19 +120,15 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
>         switch (key->cipher) {
>         case WLAN_CIPHER_SUITE_WEP40:
>         case WLAN_CIPHER_SUITE_WEP104: { /* hack it for now */
> -               struct {
> -                       struct iwl_mvm_wep_key_cmd wep_key_cmd;
> -                       struct iwl_mvm_wep_key wep_key;
> -               } __packed wkc = {
> -                       .wep_key_cmd.mac_id_n_color =
> -                               cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
> -                                                               mvmvif->color)),
> -                       .wep_key_cmd.num_keys = 1,
> -                       /* firmware sets STA_KEY_FLG_WEP_13BYTES */
> -                       .wep_key_cmd.decryption_type = STA_KEY_FLG_WEP,
> -                       .wep_key.key_index = key->keyidx,
> -                       .wep_key.key_size = key->keylen,
> -               };
> +               DEFINE_FLEX(struct iwl_mvm_wep_key_cmd, wkc, wep_key, num_keys, 1);
> +
> +               wkc->mac_id_n_color =
> +                       cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
> +                                                       mvmvif->color));
> +               /* firmware sets STA_KEY_FLG_WEP_13BYTES */
> +               wkc->decryption_type = STA_KEY_FLG_WEP;
> +               wkc->wep_key[0].key_index = key->keyidx;
> +               wkc->wep_key[0].key_size = key->keylen;
>
>                 /*
>                  * This will fail -- the key functions don't set support
> @@ -142,18 +138,18 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
>                 if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
>                         break;
>
> -               memcpy(&wkc.wep_key.key[3], key->key, key->keylen);
> +               memcpy(&wkc->wep_key[0].key[3], key->key, key->keylen);
>                 if (key->keyidx == mvmvif->tx_key_idx) {
>                         /* TX key must be at offset 0 */
> -                       wkc.wep_key.key_offset = 0;
> +                       wkc->wep_key[0].key_offset = 0;
>                 } else {
>                         /* others start at 1 */
>                         data->wep_key_idx++;
> -                       wkc.wep_key.key_offset = data->wep_key_idx;
> +                       wkc->wep_key[0].key_offset = data->wep_key_idx;
>                 }
>
>                 mutex_lock(&mvm->mutex);
> -               ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0, sizeof(wkc), &wkc);
> +               ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0, __struct_size(wkc), wkc);
>                 data->error = ret != 0;
>
>                 mvm->ptk_ivlen = key->iv_len;
> @@ -2049,10 +2045,8 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>                 struct iwl_wowlan_mlo_gtk *mlo_key = &status->mlo_keys[i];
>                 struct ieee80211_key_conf *key, *old_key;
>                 struct ieee80211_key_seq seq;
> -               struct {
> -                       struct ieee80211_key_conf conf;
> -                       u8 key[32];
> -               } conf = {};
> +               DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
> +                           WOWLAN_KEY_MAX_SIZE);
>                 u16 flags = le16_to_cpu(mlo_key->flags);
>                 int j, link_id, key_id, key_type;
>
> @@ -2069,40 +2063,40 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>                             key_type >= WOWLAN_MLO_GTK_KEY_NUM_TYPES))
>                         continue;
>
> -               conf.conf.cipher = old_keys->cipher[link_id][key_type];
> +               conf->cipher = old_keys->cipher[link_id][key_type];
>                 /* WARN_ON? */
> -               if (!conf.conf.cipher)
> +               if (!conf->cipher)
>                         continue;
>
> -               conf.conf.keylen = 0;
> -               switch (conf.conf.cipher) {
> +               conf->keylen = 0;
> +               switch (conf->cipher) {
>                 case WLAN_CIPHER_SUITE_CCMP:
>                 case WLAN_CIPHER_SUITE_GCMP:
> -                       conf.conf.keylen = WLAN_KEY_LEN_CCMP;
> +                       conf->keylen = WLAN_KEY_LEN_CCMP;
>                         break;
>                 case WLAN_CIPHER_SUITE_GCMP_256:
> -                       conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
> +                       conf->keylen = WLAN_KEY_LEN_GCMP_256;
>                         break;
>                 case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> -                       conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
> +                       conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
>                         break;
>                 case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> -                       conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
> +                       conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
>                         break;
>                 case WLAN_CIPHER_SUITE_AES_CMAC:
> -                       conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
> +                       conf->keylen = WLAN_KEY_LEN_AES_CMAC;
>                         break;
>                 case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> -                       conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
> +                       conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
>                         break;
>                 }
>
> -               if (WARN_ON(!conf.conf.keylen ||
> -                           conf.conf.keylen > sizeof(conf.key)))
> +               if (WARN_ON(!conf->keylen ||
> +                           conf->keylen > WOWLAN_KEY_MAX_SIZE))
>                         continue;
>
> -               memcpy(conf.conf.key, mlo_key->key, conf.conf.keylen);
> -               conf.conf.keyidx = key_id;
> +               memcpy(conf->key, mlo_key->key, conf->keylen);
> +               conf->keyidx = key_id;
>
>                 old_key = old_keys->key[link_id][key_id];
>                 if (old_key) {
> @@ -2114,7 +2108,7 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>
>                 IWL_DEBUG_WOWLAN(mvm, "Add MLO key id %d, link id %d\n",
>                                  key_id, link_id);
> -               key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
> +               key = ieee80211_gtk_rekey_add(vif, conf, link_id);
>                 if (WARN_ON(IS_ERR(key))) {
>                         ret = false;
>                         goto out;
> @@ -2144,30 +2138,28 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
>  {
>         int i, j;
>         struct ieee80211_key_conf *key;
> -       struct {
> -               struct ieee80211_key_conf conf;
> -               u8 key[32];
> -       } conf = {
> -               .conf.cipher = gtk_cipher,
> -       };
> +       DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
> +                   WOWLAN_KEY_MAX_SIZE);
>         int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
>
> +       conf->cipher = gtk_cipher;
> +
>         BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
> -       BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
> -       BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
> -       BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
> -       BUILD_BUG_ON(sizeof(conf.key) < sizeof(status->gtk[0].key));
> +       BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
> +       BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
> +       BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_TKIP);
> +       BUILD_BUG_ON(conf->keylen < sizeof(status->gtk[0].key));
>

Even though the mystery re __ffs() has been solved, I wonder if these
BUILD_BUG()s still make sense: their purpose appears to have been to
ensure that the key[] member is of sufficient size, and this is now
guaranteed. So I think we should just drop them.

In the general case, using BUILD_BUG() on a value of a local variable
like this is always going to be fragile. Compilers are free to reorder
code, and some function calls are implicit, or have global side
effects that may prevent the compiler from making any assumptions
about these values at the point of the BUILD_BUG() invocation.

