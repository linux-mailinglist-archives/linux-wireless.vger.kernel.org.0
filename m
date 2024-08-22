Return-Path: <linux-wireless+bounces-11782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3E95AE51
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 08:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C93285809
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 06:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BF316EBE8;
	Thu, 22 Aug 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTyZwpJ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DB16F271
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309900; cv=none; b=sqa6BqqMx0Q7enqNrZC+j8n/zZyj0rlWq1NAabJGHRj2DjFORNohedXxyY0pnAz0aRNZwEmQsvEIhEPXXSFuaV6IPsm0KmIGM0TVaUsIEGYTECQg0E9J6OwElR0XHiEcsJBIh4O696+R850ahflLh0FxgOnZogyQ01bfr7b14Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309900; c=relaxed/simple;
	bh=pDKUS1rB8+fWL5PTKKtIbYNMdB8MQobTGeAmWRJIOiQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=vDROsnjNWwOWMmwhkaXH05FxgTnQ1owLeAilbWD77mbuSzxOQvc5635OLfkt/Oin2Y4cjZ+AfJhLOTZTJcfjmk6TPP23UEb9W4ryeNCkKiQT5SBS/2ZmfoBLOIHDXR+wr/5LWCzubZsVRwXMfjfzBJ2nBepNwpzOhRwz3ocDBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTyZwpJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9033C4AF0B;
	Thu, 22 Aug 2024 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724309899;
	bh=pDKUS1rB8+fWL5PTKKtIbYNMdB8MQobTGeAmWRJIOiQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JTyZwpJ/6HzCeYxRrU4mvtM+CiBgf3Swr/M1w6G126uxKreeVbUQdw2jD+b233J5S
	 O9XVwZ81mo6qd2+7pQeR1q04giWFbGo3YQYhzdf9O/PkC8tIEwgEb5Y1FSeMl1kd3H
	 2INicOvV22GhYt3peEgtysJaCZnzNbVMhA4pBHobHFPFf4HHEEwYYrs0cJ5XL+eb0O
	 nxkb7xHF/L3JdNWIG3o8BdlDktZBg094UHZplS4ihSM1zOnpGqtCFw9WfozzYkcysR
	 lsk5TUjG8fZjeVJ0oSu37XyvpqW79ltHh6GTD2nHxDr/nMWHi9U/63G/PzeygEIfhn
	 ghYncevIPgIaw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
	<e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
	<6071028680d14afa8e0eed84821f51c6@realtek.com>
	<4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
	<840cb519e99047a5a8f3ca4a12a3fcee@realtek.com>
	<d06c7a5f-c773-45a6-98f2-30fb1d0dde94@gmail.com>
	<9456919959d94b548750f78a371f204e@realtek.com>
	<73accc26-15ee-43d9-bad2-061c42b76e0e@gmail.com>
	<423f1f602b52464499c38459bd19cc84@realtek.com>
Date: Thu, 22 Aug 2024 09:58:16 +0300
In-Reply-To: <423f1f602b52464499c38459bd19cc84@realtek.com> (Ping-Ke Shih's
	message of "Thu, 22 Aug 2024 00:33:29 +0000")
Message-ID: <875xrtgi2f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>
>> On 21/08/2024 03:31, Ping-Ke Shih wrote:
>> > Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> >> On 20/08/2024 04:10, Ping-Ke Shih wrote:
>> >>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> >>>> On 15/08/2024 09:14, Ping-Ke Shih wrote:
>> >>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> >>>>>> The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
>> >>>>>> Avoid the "invalid ra report c2h length" error.
>> >>>>>>
>> >>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> >>>>>> ---
>> >>>>>>  drivers/net/wireless/realtek/rtw88/fw.c       | 8 ++++++--
>> >>>>>>  drivers/net/wireless/realtek/rtw88/main.h     | 1 +
>> >>>>>>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
>> >>>>>>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
>> >>>>>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
>> >>>>>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
>> >>>>>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
>> >>>>>>  7 files changed, 12 insertions(+), 2 deletions(-)
>> >>>>>>
>> >>>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>> >>>>>> index 782f3776e0a0..ac53e3e30af0 100644
>> >>>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>> >>>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>> >>>>>> @@ -157,7 +157,10 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
>> >>>>>>
>> >>>>>>         rate = GET_RA_REPORT_RATE(ra_data->payload);
>> >>>>>>         sgi = GET_RA_REPORT_SGI(ra_data->payload);
>> >>>>>> -       bw = GET_RA_REPORT_BW(ra_data->payload);
>> >>>>>> +       if (si->rtwdev->chip->c2h_ra_report_size < 7)
>> >>>>>
>> >>>>> Explicitly specify '== 4' for the case of RTL8821AU and RTL8812AU.
>> >>>>>
>> >>>>>> +               bw = si->bw_mode;
>> >>>>>> +       else
>> >>>>>> +               bw = GET_RA_REPORT_BW(ra_data->payload);
>> >>>>>>
>> >>>>>
>> >>>>>
>> >>>>
>> >>>> Would that make sense? I check for less than 7 because the size
>> >>>> has to be at least 7 in order to access payload[6] (GET_RA_REPORT_BW).
>> >>>
>> >>> As you did "WARN(length < rtwdev->chip->c2h_ra_report_size)", I assume you
>> >>> expect "< 7" cases is only for coming chips RTL8821AU and RTL8812AU.
>> >>>
>> >>> Maybe explicitly specifying chips ID would be easier to understand:
>> >>>         if (chip == RTL8821A || chip == RTL8812A)
>> >>>                bw = si->bw_mode;
>> >>>         else
>> >>>                bw = GET_RA_REPORT_BW(ra_data->payload);
>> >>>
>> >>> That's why I want "== 4". (but it seems implicitly not explicitly though.)
>> >>>
>> >>
>> >> I just checked, the RA report size of RTL8814AU is 6.
>> >
>> > Could you also check if the report format is compatible?
>> > I mean definition of first 4 bytes are the same for all chips? and
>> > definition of first 6 bytes are the same for RTL8814AU and current
>> > exiting chips?
>> >
>> > By the way, I think we should struct with w0, w1, ... fields instead.
>> >     struct rtw_ra_report {
>> >         __le32 w0;
>> >         __le32 w1;
>> >         __le32 w2;
>> >         __le32 w3;
>> >         __le32 w4;
>> >         __le32 w5;
>> >         __le32 w6;
>> >     } __packed;
>> >
>> > Then, we can be easier to avoid accessing out of range. GET_RA_REPORT_BW()
>> > hides something, no help to read the code.
>> >
>> 
>> The report format looks compatible.
>> 
>> I'm not sure how a struct with __le32 members would help here.
>> I agree that the current macros hide things. We could access payload
>> directly. The variable names already make it clear what each byte is:
>> 
>>         mac_id = ra_data->payload[1];
>>         if (si->mac_id != mac_id)
>>                 return;
>> 
>>         si->ra_report.txrate.flags = 0;
>> 
>>         rate = u8_get_bits(ra_data->payload[0], GENMASK(6, 0));
>>         sgi = u8_get_bits(ra_data->payload[0], BIT(7));
>>         if (si->rtwdev->chip->c2h_ra_report_size >= 7)
>>                 bw = ra_data->payload[6];
>>         else
>>                 bw = si->bw_mode;
>
> Yes, this is also clear to me to avoid accessing out of range. 
> Another advantage of a struct is to explicitly tell us the total size of a
> C2H event.

Yeah, please avoid that payload[6] stuff for parsing firmware commands
and events. It just makes the code harder to read and more fragile.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

