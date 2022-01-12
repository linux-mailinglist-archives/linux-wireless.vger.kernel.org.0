Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59F48C0F9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiALJ1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 04:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiALJ1a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 04:27:30 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49AC06173F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 01:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZAILcBl9MFCqNF5xo+TSUrpyTgN3z6lwe32mDarWH/A=;
        t=1641979650; x=1643189250; b=wRt7XYTzhlxG7aHhJTLacfsHhra2kvNXzXUYNDvcZ3CW2Kj
        5co6u+BdxnxvLTbQK+LGvjZ4kH/tFuvvP4MtLXAMY6+66QtapXLipvdAfYplnhxSw8oCdQsF23nyx
        kwqKOxhCOgX0ZTmJjyR2v2baECHm6FAE39CEdojNJ7PP/jfREl21aTnm4yAEYNBW+fjK4JNI1e2pN
        ykRZSvAQ1qLAAu0sy2xhbJeZitnJTLEciYBKyd1Iod35Ywq0R7Ug2DhdP3Z878Paw8r/XZpnhbnEC
        fYgQ218o+WG3enbq1Vg4CtrqL/s9SlY7k2AY/l33iej+BHO0z2Wx9sHSHv6kOEtA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n7Zud-004jvy-G8;
        Wed, 12 Jan 2022 10:27:23 +0100
Message-ID: <ab9e48ae8dad3187d206d46fc1d997245ecbc3ef.camel@sipsolutions.net>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 12 Jan 2022 10:27:22 +0100
In-Reply-To: <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
         <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 863fec150e53..f13825185094 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -834,6 +834,9 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
>                      offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, ops) !=
>                      offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, ops));
>  
> +       if (!iwl_sar_geo_support(&mvm->fwrt))
> +               return -EOPNOTSUPP;
> +
>         /* the ops field is at the same spot for all versions, so set in v1 */
>         cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);

I was going to say it should probably return 0, but the caller looks a
bit fishy too?

        ret = iwl_mvm_sar_init(mvm);
        if (ret == 0)
                ret = iwl_mvm_sar_geo_init(mvm);
        else if (ret < 0)
                goto error;

        ret = iwl_mvm_sgom_init(mvm);

should that "else" be removed?

johannes
