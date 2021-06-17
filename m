Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CC83AA97F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 05:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFQDZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Jun 2021 23:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhFQDZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Jun 2021 23:25:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B45C061574
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jun 2021 20:22:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k7so2944797pjf.5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jun 2021 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/r5ooZDhhLfZ1DxAdI7xi00/b7gD8uPD95BirZhzfSQ=;
        b=AypfzAPR3T++kLN1GaQh9r4/38MyZkb9oatGyAOxCNc/26PN4VAYQdfqPB3KqOzuKH
         2NG0EmfmIcx5anEsj/C4exw4GXZo+EdyfFFYa0ex7IL0EsQFkBIRFNuDNCAIWtLDFBh3
         mQIxC8agWgwYY+SqQkrUJ/3QAwUGwlkmd9RQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/r5ooZDhhLfZ1DxAdI7xi00/b7gD8uPD95BirZhzfSQ=;
        b=l6d+tPPHmW1IDA3qC3lMRsB32lmFl2vkxWbwOiw1BhOo64DWs8s/HhX4HsTdn9DOKE
         ZdWXfuXrrpcRqm3ZK3XWebQpHjAk3bFL4ruaFsKUT/ynYsH3d41NMGlFUl8jjwvnTI7C
         NgeLax460JedmI3w4WxH8VfKh8C0/cMTKTHpaO6S0OftcQVZ2VVzlgdBfqQH+tIeQ22/
         x4TcvF90xslj9yQJynXu3R5of0rqXaajxZ0OzKrlqYe8hEb+kRh5HhzGdzIAktwkroih
         9FniNmyuGjTdrBWTaJWYCGJ+7XR1mK1AIWMYrU4QjTpv/6A8eAWNaQu3V6+ixsbhKJ9C
         clxg==
X-Gm-Message-State: AOAM533TXb03sQkMusMW3z6rSPZDNqNA1Ckh9RHLbd8FiGOoj/p1iEE2
        NwlEv/0Ogu0og8EVzVQomXIgZA==
X-Google-Smtp-Source: ABdhPJzftp1MjNvohc+8a9WaJdSvhhUhW1bNaRZeFamEiS7UH+ZEG0G5QwymN2cpVOI2wWfCn2ISMg==
X-Received: by 2002:a17:90a:fa10:: with SMTP id cm16mr14664353pjb.175.1623900173863;
        Wed, 16 Jun 2021 20:22:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm3436533pfd.115.2021.06.16.20.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:22:53 -0700 (PDT)
Date:   Wed, 16 Jun 2021 20:22:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        wengjianfeng <wengjianfeng@yulong.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mwl8k: Avoid memcpy() over-reading of ETH_SS_STATS
Message-ID: <202106162022.F3DABCEDD@keescook>
References: <20210616195242.1231287-1-keescook@chromium.org>
 <YMpX0S/Xeis0kKoP@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMpX0S/Xeis0kKoP@lunn.ch>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 16, 2021 at 09:58:09PM +0200, Andrew Lunn wrote:
> On Wed, Jun 16, 2021 at 12:52:42PM -0700, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally reading across neighboring array fields. Use the
> > sub-structure address directly.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/net/wireless/marvell/mwl8k.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
> > index 84b32a5f01ee..3bf6571f4149 100644
> > --- a/drivers/net/wireless/marvell/mwl8k.c
> > +++ b/drivers/net/wireless/marvell/mwl8k.c
> > @@ -4552,7 +4552,7 @@ static int mwl8k_cmd_update_stadb_add(struct ieee80211_hw *hw,
> >  	else
> >  		rates = sta->supp_rates[NL80211_BAND_5GHZ] << 5;
> >  	legacy_rate_mask_to_array(p->legacy_rates, rates);
> > -	memcpy(p->ht_rates, sta->ht_cap.mcs.rx_mask, 16);
> > +	memcpy(p->ht_rates, &sta->ht_cap.mcs, 16);
> >  	p->interop = 1;
> >  	p->amsdu_enabled = 0;
> >  
> > @@ -5034,7 +5034,7 @@ mwl8k_bss_info_changed_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> >  			ap_legacy_rates =
> >  				ap->supp_rates[NL80211_BAND_5GHZ] << 5;
> >  		}
> > -		memcpy(ap_mcs_rates, ap->ht_cap.mcs.rx_mask, 16);
> > +		memcpy(ap_mcs_rates, &ap->ht_cap.mcs, 16);
> >  
> >  		rcu_read_unlock();
> 
> This does not appear to have anything to do with ETH_SS_STATS which is
> what the Subject: says.

Whoops! I was off-by-one in my Subject edits. I will respin.

-Kees

-- 
Kees Cook
