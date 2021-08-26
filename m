Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79803F83AF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhHZIWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhHZIWd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 04:22:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D4C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 01:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=reGQwn0U0r6SOYBVaB3+nEcenBEIRLAq14E/8niIQIM=;
        t=1629966106; x=1631175706; b=DduSyHQW2ICum0R8TiCt+FcV2xUdcH0HUz0AYMbMdAgIvnA
        b5bROeFQ9KqG0tQRICJWrGseE2N7BEOqhyy2U6/qk3+mpghib6IdHdtFbaDrpeBWjkTu1TEsNaKrf
        w0gZtSLB66lJfx1YsVzmMlzRgdqqHZz8NLeyPIZQwIqOVGnnj20OHVoiD0/Kb6wFAAw2u1taGP+yY
        DF8Z9I4vOD2M05TLibdMjIcTKBmYkcKWEHsZyKlmCJNJvQo0gFkvI6IoV73PAuHvkoeI4zeCD0YpV
        6hMUk81Toi3zv50UmO8NTK6WRg3aOSb3qn4CAdAQRV2WYtXzgHT/yIZPsiphDtWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJAdq-00G4gh-7b; Thu, 26 Aug 2021 10:21:42 +0200
Message-ID: <57012b81620f7c176c405262f2caf8d497393cae.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/8] mac80211: add parse regulatory info in 6 GHz
 operation information
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 10:21:41 +0200
In-Reply-To: <20210820122041.12157-4-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-4-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-20 at 08:20 -0400, Wen Gong wrote:
> This patch is to convert the regulatory info subfield in HE operation
> element to power type and save in struct cfg80211_chan_def.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  net/mac80211/util.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 93d96a4f9c3e..cb1c35d8ef48 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -3395,6 +3395,16 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
>  					      NL80211_BAND_6GHZ);
>  	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
>  
> 
> +	switch (u8_get_bits(he_6ghz_oper->control,
> +			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
> +	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
> +		he_chandef.power_type = NL80211_REG_LPI_AP;
> +		break;
> +	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
> +		he_chandef.power_type = NL80211_REG_SP_AP;
> +		break;
> +	}

Now here you put it in the chandef, but don't propagate it anywhere if
channels are merged, etc. I don't think this can work correctly in all
but the most trivial use cases.

johannes

