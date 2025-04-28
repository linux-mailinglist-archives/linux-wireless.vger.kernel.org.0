Return-Path: <linux-wireless+bounces-22158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50292A9FC8F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 23:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2323A2E8B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592D1EE7BE;
	Mon, 28 Apr 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="VNnSOA2l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAD13AC1;
	Mon, 28 Apr 2025 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877025; cv=none; b=mc9x3rqY7NZPReZv+x5SqeHlA3jyUMG+7qvXtOh3zbqxqUSXNg4mJ5G5y2t1czf5YYH1egCWd5aGekm7VhQtwLCcVFmPGolQ6/VFlDo76QdXiUy2VDFQHSdPbVokjqwB84SIpXzlFllnSq43luQn6sK52T2KId2lwgq2TVXUhqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877025; c=relaxed/simple;
	bh=dbmaV3E3h4lzYFk8d0epf+uHNQ3tGXBVp5Kd2F8iQCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf90yA9C1DY7Mv0pl6DTfd3BXNGBD5eNOt6I42xBa3Bz5O1+j/TmoIPWDTn53DchtJk6EjKOA/vHSF1EkWRINneTFddl5KPFj8GItusUn2TIDNc0LLj233vutuk6g+bxC47kse6Ozlgmo3zMaUtSr67DfZmPK5yhPtNnAdkMm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=VNnSOA2l; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745877011; bh=dbmaV3E3h4lzYFk8d0epf+uHNQ3tGXBVp5Kd2F8iQCU=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=VNnSOA2lZO0jE+UwRY8bmtnEdtevhYdm6cwD8sWmMISfl0nb4ZRlOfdFiAVo4kwOo
	 qcxilVFRjK+Xn2KxF6x1AUlEJtJ7uT6xm57OPPQ4mTN/aPNMI2qpoJIYpU/A95s4Z5
	 HRnUI5ibuuxOAHvw/4WGSHzsPCx35OtBUqtbfuNc=
Date: Mon, 28 Apr 2025 23:50:11 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: Fix inadverent sharing of struct
 ieee80211_supported_band data
Message-ID: <yurmw275hyo3zwstdwfqyepan3mj3anqavnpv6hu2742h4ofgx@c56eohg3s6ue>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Ping-Ke Shih <pkshih@realtek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250427002414.410791-1-megi@xff.cz>
 <d3c6e149a2794551ba4570bdd7f1b7e7@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3c6e149a2794551ba4570bdd7f1b7e7@realtek.com>

Hello,

On Mon, Apr 28, 2025 at 01:53:44AM +0000, Ping-Ke Shih wrote:
> Ondřej Jirman <megi@xff.cz> wrote:
> > 
> > Internally wiphy writes to individual channels in this structure,
> > so we must not share one static definition of channel list between
> > multiple device instances, because that causes hard to debug
> > breakage.
> > 
> > For example, with two rtw89 driven devices in the system, channel
> > information may get incoherent, preventing channel use.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> > 
> > This patch relates to this report of mine:
> > 
> > 
> > https://lore.kernel.org/linux-wireless/2goskmst4na36v42p2bs47uernp6kh3gzpadhr3u3r2yvyoxlg@bfprgq2qae7p
> > /T/#u
> > 
> >  drivers/net/wireless/realtek/rtw89/core.c | 48 ++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> > index cc9b014457ac..ae22954f5f5c 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > @@ -4398,16 +4398,44 @@ static void rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
> >         _ieee80211_set_sband_iftype_data(sband, iftype_data, idx);
> >  }
> > 
> > +static struct ieee80211_supported_band *rtw89_copy_sband(const struct ieee80211_supported_band *sband)
> 
> prefer naming rtw89_core_sband_dup().
> 
> > +{
> > +       struct ieee80211_supported_band *copy = kmemdup(sband, sizeof(*sband), GFP_KERNEL);
> 
> Then, '*dup'. 
> 
> > +
> > +       copy->channels = kmemdup(sband->channels, sizeof(struct ieee80211_channel) * sband->n_channels,
> > GFP_KERNEL);
> 
> I'm planning to use devm_ series to manage sband data, so we don't need to
> free them one by one. Do you interest to adjust that along with this patchset? 
> I mean adding additional patches to adjust the code before this patch, and
> make them as a patchset. 

Yes.

> For kmemdup, the corresponding one is devm_kmemdup. 
> 
> The line is too long. Less than 80 characters is preferred. 
> 
> > +       if (!copy->channels) {
> > +               kfree(copy);
> > +               return NULL;
> > +       }
> > +
> > +       copy->bitrates = kmemdup(sband->bitrates, sizeof(struct ieee80211_rate) * sband->n_bitrates,
> > GFP_KERNEL);
> 
> Since you have duplicated arrays of channels and bitrate, we should add const
> to them, like:
> 
>   static const struct ieee80211_channel rtw89_channels_{2ghz,5ghz,6ghz}[]
>   static const struct ieee80211_rate rtw89_bitrates[]

That will produce:

  initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

warnings, because  struct ieee80211_supported_band doesn't have these fields
as const. The discarding of const qualifiers is apparently safe in this case,
so I can either cast the pointers to non-const when assigned here:

 270 static const struct ieee80211_supported_band rtw89_sband_2ghz = {
 271         .band           = NL80211_BAND_2GHZ,
 272         .channels       = rtw89_channels_2ghz,
 273         .n_channels     = ARRAY_SIZE(rtw89_channels_2ghz),
 274         .bitrates       = rtw89_bitrates,
 275         .n_bitrates     = ARRAY_SIZE(rtw89_bitrates),
 276         .ht_cap         = {0},
 277         .vht_cap        = {0},
 278 };

Or the code would have to get quite a bit less readable in
rtw89_core_set_supported_band() to duplicate and assign copies of bitrates and
channels there for each supported band individually instead of relying on
a common implementation in rtw89_core_sband_dup() function, and remove
assignments from const ieee80211_supported_band definitions.

Do you have a preference?

kind regards,
	o.

> 
> > +       if (!copy->bitrates) {
> > +               kfree(copy->channels);
> > +               kfree(copy);
> > +               return NULL;
> > +       }
> > +
> > +       return copy;
> > +}
> > +
> > +static void rtw89_free_sband(const struct ieee80211_supported_band *sband)
> > +{
> > +       if (sband) {
> > +               kfree(sband->bitrates);
> > +               kfree(sband->channels);
> > +               kfree(sband);
> > +       }
> > +}
> > +
> >  static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
> >  {
> >         struct ieee80211_hw *hw = rtwdev->hw;
> >         struct ieee80211_supported_band *sband_2ghz = NULL, *sband_5ghz = NULL;
> >         struct ieee80211_supported_band *sband_6ghz = NULL;
> > -       u32 size = sizeof(struct ieee80211_supported_band);
> >         u8 support_bands = rtwdev->chip->support_bands;
> > 
> >         if (support_bands & BIT(NL80211_BAND_2GHZ)) {
> > -               sband_2ghz = kmemdup(&rtw89_sband_2ghz, size, GFP_KERNEL);
> > +               sband_2ghz = rtw89_copy_sband(&rtw89_sband_2ghz);
> >                 if (!sband_2ghz)
> >                         goto err;
> >                 rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
> > @@ -4416,7 +4444,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
> >         }
> > 
> >         if (support_bands & BIT(NL80211_BAND_5GHZ)) {
> > -               sband_5ghz = kmemdup(&rtw89_sband_5ghz, size, GFP_KERNEL);
> > +               sband_5ghz = rtw89_copy_sband(&rtw89_sband_5ghz);
> >                 if (!sband_5ghz)
> >                         goto err;
> >                 rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
> > @@ -4426,7 +4454,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
> >         }
> > 
> >         if (support_bands & BIT(NL80211_BAND_6GHZ)) {
> > -               sband_6ghz = kmemdup(&rtw89_sband_6ghz, size, GFP_KERNEL);
> > +               sband_6ghz = rtw89_copy_sband(&rtw89_sband_6ghz);
> >                 if (!sband_6ghz)
> >                         goto err;
> >                 rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_6GHZ, sband_6ghz);
> > @@ -4445,9 +4473,9 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
> >                 kfree((__force void *)sband_5ghz->iftype_data);
> >         if (sband_6ghz)
> >                 kfree((__force void *)sband_6ghz->iftype_data);
> > -       kfree(sband_2ghz);
> > -       kfree(sband_5ghz);
> > -       kfree(sband_6ghz);
> > +       rtw89_free_sband(sband_2ghz);
> > +       rtw89_free_sband(sband_5ghz);
> > +       rtw89_free_sband(sband_6ghz);
> >         return -ENOMEM;
> >  }
> > 
> > @@ -4461,9 +4489,9 @@ static void rtw89_core_clr_supported_band(struct rtw89_dev *rtwdev)
> >                 kfree((__force void *)hw->wiphy->bands[NL80211_BAND_5GHZ]->iftype_data);
> >         if (hw->wiphy->bands[NL80211_BAND_6GHZ])
> >                 kfree((__force void *)hw->wiphy->bands[NL80211_BAND_6GHZ]->iftype_data);
> > -       kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
> > -       kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
> > -       kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]);
> > +       rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_2GHZ]);
> > +       rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_5GHZ]);
> > +       rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_6GHZ]);
> >         hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
> >         hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
> >         hw->wiphy->bands[NL80211_BAND_6GHZ] = NULL;
> 
> Like I mentioned above, with devm_ series, I suppose this function can be
> removed entirely. 
> 
> 

