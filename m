Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865191E5902
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 09:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgE1Hkk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgE1Hkk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 03:40:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DC2C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 00:40:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeD9Z-004iPB-SX; Thu, 28 May 2020 09:40:38 +0200
Message-ID: <ec74f39f6591249559f83895e0b1f6d33720f2f5.camel@sipsolutions.net>
Subject: Re: [PATCH v3 02/11] cfg80211: handle 6 GHz capability of new
 station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Date:   Thu, 28 May 2020 09:40:36 +0200
In-Reply-To: <17385b3a2fca16521858bf0956904698@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-2-git-send-email-rmanohar@codeaurora.org>
         <bf0f6c17c188901477c1d6aa61aab6143c4ac635.camel@sipsolutions.net>
         <17385b3a2fca16521858bf0956904698@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-27 at 16:24 -0700, Rajkumar Manoharan wrote:
> On 2020-05-27 07:00, Johannes Berg wrote:
> > On Wed, 2020-05-13 at 12:44 -0700, Rajkumar Manoharan wrote:
> > > Handle 6 GHz HE capability while adding new station. It will be used
> > > later in mac80211 station processing.
> > 
> > This doesn't compile without the next patch.
> > 
> My bad.. I must have overlooked while splitting the patch. :(

No worries. Looks like I'm reshuffling everything anyway :)


> > > +       const struct ieee80211_he_6ghz_band_cap *he_6ghz_capa;
> > 
> > This we made just an __le16, any particular reason to have the struct?
> > It does need to be a pointer for the "no changes" case, but the struct
> > seems a bit overkill?
> > 
> Initially I thought of splitting into two u8 for a_mpdu_params and info.
> Later changed to __le16 but retained struct. Nothing else :)

Right. I even saw that we're inconsistent - in mac80211 we used a struct
too, and in cfg80211 I just did __le16 ... I'll be consistent with a
struct, I guess.

> > > @@ -2998,6 +3003,7 @@ enum nl80211_attrs {
> > >  #define NL80211_HE_MAX_CAPABILITY_LEN           54
> > >  #define NL80211_MAX_NR_CIPHER_SUITES		5
> > >  #define NL80211_MAX_NR_AKM_SUITES		2
> > > +#define NL80211_HE_6GHZ_CAPABILITY_LEN		2
> > 
> > This not, we defined it just to be a U16.

And this should probably not be defined anyway since it comes from the
spec (and we now export the policy to userspace even!) and in the policy
we can then use sizeof(struct ...).

> > > +	[NL80211_ATTR_HE_6GHZ_CAPABILITY] = {
> > > +		.type = NLA_EXACT_LEN,
> > > +		.len = NL80211_HE_6GHZ_CAPABILITY_LEN,
> > > +	},
> > 
> > This no longer exists, but I guess I'll just take our patch for the U16
> > here.

Sorry, I was confused - of course this still exists. NLA_EXACT_LEN_WARN
no longer exists since my recent rework in this area.

> >                 /* HE requires WME */
> > -               if (params.he_capa_len)
> > +               if (params.he_capa_len || params.he_6ghz_capa)
> >                         return -EINVAL;
> >         }
> > 
> Fine. One more thing. Pradeep found that 6 GHz capability is not filled 
> in set_station.
> Please handle that in your series. I'm fine with rest of the changes you 
> mentioned.
> 
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -5893,6 +5893,10 @@ static int nl80211_set_station_tdls(struct
> genl_info *info,
>                          return -EINVAL;
>          }
> 
> +       if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
> +               params->he_6ghz_capa =
> +                       
> nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
> +

OK, thanks!

johannes

