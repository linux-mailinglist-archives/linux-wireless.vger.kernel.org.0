Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B320641930B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhI0LYG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 07:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhI0LYF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 07:24:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86333C061575
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XphSQu6FESh2+jPkNi26+VZIRyCQpAwTinsGOYiLBDc=;
        t=1632741747; x=1633951347; b=Xk3hOXX9e8eUarHvJuTAFC2Hqqz9HECOm9kTVUb1zxBGzYy
        lPhUmUP8YSyb95W0bXlmK7ppXJhZJRYA/jcvi+iPc1waCRCIBOGqXDE9HqHkhL0tgxWj9WBPuHHC+
        DLnHDx4IUYhq9rrkahYHcyrxfisQoEL5hYyHdH/aRLDAYp/f3b9I+H7hvImwDZVzigmva1vLbvY5A
        lYkRb1xYWgbc6PGV+rVPxcvusroIT12CAkJTKBF7yy/q/vtFaqTNqzlmiZn4cSC7Kv4XYbklYVDCV
        +Ui3VKBrRVv5JX8YzvDxnR63pmy0ZHvOGF6mrvxm8LZxxPH2tMdDdaIjDa7CGYrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUoiE-00COWa-Gl;
        Mon, 27 Sep 2021 13:22:22 +0200
Message-ID: <1b1174270c05786228d3059b0f0664268f689204.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/6] mac80211: add parse regulatory info in 6 GHz
 operation information
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 27 Sep 2021 13:22:20 +0200
In-Reply-To: <20210924100052.32029-3-wgong@codeaurora.org>
References: <20210924100052.32029-1-wgong@codeaurora.org>
         <20210924100052.32029-3-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-09-24 at 06:00 -0400, Wen Gong wrote:
> This patch is to convert the regulatory info subfield in HE operation
> element to power type and save in struct cfg80211_chan_def.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  net/mac80211/util.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index ca8008ba9b1f..66e48f29495a 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -3385,6 +3385,7 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
>  	const struct ieee80211_sta_he_cap *he_cap;
>  	struct cfg80211_chan_def he_chandef = *chandef;
>  	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
> +	struct ieee80211_bss_conf *bss_conf;
>  	bool support_80_80, support_160;
>  	u8 he_phy_cap;
>  	u32 freq;
> @@ -3428,6 +3429,18 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
>  					      NL80211_BAND_6GHZ);
>  	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
>  
> 
> 
> 
> +	bss_conf = &sdata->vif.bss_conf;
> +
> +	switch (u8_get_bits(he_6ghz_oper->control,
> +			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
> +	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
> +		bss_conf->power_type = IEEE80211_REG_LPI_AP;
> +		break;
> +	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
> +		bss_conf->power_type = IEEE80211_REG_SP_AP;
> +		break;
> +	}

I added a default case here to set it to UNSET, so that if you
disconnect and reconnect etc. you don't get stale data.

johannes


