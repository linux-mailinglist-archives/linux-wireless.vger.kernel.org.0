Return-Path: <linux-wireless+bounces-12523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D84A96CEB7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 07:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25730287C15
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 05:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF615623A;
	Thu,  5 Sep 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9H9buq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ADC15444E
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515204; cv=none; b=bcbDjfKNyKGjpJ+zj+yDt8BqfxEwauqcrp3vD6zCcFcbE/DlFgfx26DFCBPk+Qaxo1XvzcP7xrlrVS7MDHJJpM6gDi/m0GCwiCSqpJIbYs6fRyO+JhSSHrh/ll9cYJxrNmOkjIkD8Llb3pmpRH+lFXIMpsBeIpimgQixlxx/OMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515204; c=relaxed/simple;
	bh=I5la2qJUZmJh0tM0I6WdoHI7heSjPMrxJibOfF1doq4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aNu0JQs7lb4XQc/7wUGJlNyiarYDaJ+3cpgXYwsloVhrLNm/Dh4IOmSUn+s5M315jaCAZOVMQiesn+mzRyT7QoQhJiNT2FvKXGOmwn3id3MPRZ8GukrZQvpcjmiUptGiQIKPg73wBaojP4yd6mk86faYBFFAbKs7DpjxSyOshCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9H9buq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A0FC4CEC4;
	Thu,  5 Sep 2024 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725515203;
	bh=I5la2qJUZmJh0tM0I6WdoHI7heSjPMrxJibOfF1doq4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=l9H9buq9bJ567dD+7dZ0BTLwDQ5IEY0H5Ovh7nRvuHiwwijPaXnCLRH+JilHy8+bL
	 voW6wgtLZ+hlUvYOn7YurQOQVa8Qzt/drMyrq8vPVDc8PCTM7J31b8wN6CVG9uSONI
	 V0h+ENtN8i3Koi01aGNxsxrLgtn3Irflhor2+qM1jJLnORxsZuNZzpOYxKQI+HLgof
	 fpV50WLNElCrV3u/k1380GP8L0luElsLmQ4f+GNLHtay2P22IJvFGeozxMn7vTnbVs
	 WrmaGD9URC3wXntuMuJv2Lh8DbNCW31NwMFE2cNGCVTwBDVu31jEFfI8n/shDpC6UQ
	 8rF/cQsmx4TPw==
From: Kalle Valo <kvalo@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
  linux-wireless@vger.kernel.org,  toke@toke.dk,  nbd@nbd.name
Subject: Re: [PATCH] wireless: ath9k: eeprom: remove platform data
References: <20240903202713.471489-1-rosenp@gmail.com>
	<87jzfrkfn7.fsf@kernel.org>
	<0bab22f0-e5a4-49ac-8265-910ae9380add@quicinc.com>
	<CAKxU2N9QDRieOco0VRjTMQW2ywM-mOJp_vTyg+v_SKSBTPf+1g@mail.gmail.com>
	<CAKxU2N_VKU2cMpPS0y7JJkuCzAimUP=h885RA58WqCB1CZj8ag@mail.gmail.com>
Date: Thu, 05 Sep 2024 08:46:40 +0300
In-Reply-To: <CAKxU2N_VKU2cMpPS0y7JJkuCzAimUP=h885RA58WqCB1CZj8ag@mail.gmail.com>
	(Rosen Penev's message of "Wed, 4 Sep 2024 16:53:01 -0700")
Message-ID: <87bk12d54v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> On Wed, Sep 4, 2024 at 10:56=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wr=
ote:
>
>>
>> On Wed, Sep 4, 2024 at 7:53=E2=80=AFAM Jeff Johnson <quic_jjohnson@quici=
nc.com> wrote:
>> >
>> > On 9/4/2024 1:05 AM, Kalle Valo wrote:
>> > > Rosen Penev <rosenp@gmail.com> writes:
>> > >
>> > >> There are no more board files defining platform data for this drive=
r and
>> > >> eeprom support through NVMEM has already been implemented. No need =
to
>> > >> keep this old functionality around.
>> > >>
>> > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> > >> ---
>> > >>  As an aside, the last user of this functionality downstream in Ope=
nWrt
>> > >>  has been removed: https://github.com/openwrt/openwrt/commit/7ac827=
9bd
>> > >>
>> > >>  drivers/net/wireless/ath/ath9k/eeprom.c | 12 ------------
>> > >>  1 file changed, 12 deletions(-)
>> > >>
>> > >> diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/=
wireless/ath/ath9k/eeprom.c
>> > >> index efb7889142d4..df58dc02e104 100644
>> > >> --- a/drivers/net/wireless/ath/ath9k/eeprom.c
>> > >> +++ b/drivers/net/wireless/ath/ath9k/eeprom.c
>> > >> @@ -15,7 +15,6 @@
>> > >>   */
>> > >>
>> > >>  #include "hw.h"
>> > >> -#include <linux/ath9k_platform.h>
>> > >
>> > > What about the file include/linux/ath9k_platform.h? That should be a=
lso
>> > > removed, right?
>> >
>> > That file is still used by other functionality (see init.c, btcoex.c)
>> > But seems that at a minimum unused eeprom-related stuff should be remo=
ved from
>> > struct ath9k_platform_data.
>> That's why I kept my changes to a minimum. I don't yet want to axe the
>> other stuff. OpenWrt has a ton of non upstreamed patches for ath9k,
>> some probably relying on ath9k_platform_data. I need to do real
>> careful analysis to remove the rest.
>> >
>> > Please review that all of the platform-related code in init.c is still=
 needed,
>> > especially code related to eeprom support.
>
> That's handled with nvmem and OF (if applicable).
>
> Anyway, I split up the removal in 4 patches. of_init needs some extra
> functionality to match platform_device.
>
> Does Documentation need to go in its own commit?

I don't know what Documentation changes you are doing but usually it's
good to make changes to Documentation in separate patches.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

