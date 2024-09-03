Return-Path: <linux-wireless+bounces-12380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 997FD9699C2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E9A1F23853
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849019F409;
	Tue,  3 Sep 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP8uh5nj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E717C9B3
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358176; cv=none; b=Egb7GLV48tINxlv78HnPNl7Pz4mzOG/OUpyZEXiywO18m4ZO3DOt9mxdoRSEPC57rCrU7HMW5+1pOWcNeqAaCJ0Yvq/AF3UKv74DstfpiXiO48T7vwrzt1eWbSI3s8MpbbUy1Jd2Hyrqg2N/fN0TL9aynWlHXBbR8WAncwwI/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358176; c=relaxed/simple;
	bh=p/r5DqaUFcOB7OWIjOI7gSXaQQ65xVjhglSd+Mb6m9s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N/AyHmp/yaq/q7RlN/pfQXtz5yssrDrEkppkbBAMRSx4fIqCOZYS8l5VP5Ynt/NSHM4KDD5r5TJ04ZmM850Y2TeQNKf9Bdf0OZMBm1A/ynsD+PVuLolr1d6+hmoWacrLMKRzIvhYNAAKXOOYzHz9RU/hvIVZeQHQut02jc/T+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP8uh5nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A249CC4CEC4;
	Tue,  3 Sep 2024 10:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358175;
	bh=p/r5DqaUFcOB7OWIjOI7gSXaQQ65xVjhglSd+Mb6m9s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KP8uh5njvFEeq0IJTPzkDIt7XwxgQh3nRcWOfFhMQRDJVueA1d7kG0NTEVjSgmvtG
	 iVh8dIiYhIOd7kRhyAP5J/Z3TscyTzwzBRHeqsjNdJv1tmOKCkqiHXVCJ5uDKGySIV
	 nSpR6VlcSpicMvLLFTz8jjTwy9AeCkowHQG8RfOIOOVf68HB160j9SnVkQWpmOMWyr
	 u5au2g1ezNUd/mIk5lR1WdAg9t5iGBor4AhA2dhEu2qYwP0Es+gRtzM+9pBgEINcaZ
	 yYzp+7aqD1P6hXSO+fu1E4VdbFGacUPHpnt17HgHI+7R32eVkBZGBjTa8243VB1Cz8
	 u927RO9P6Frag==
From: Kalle Valo <kvalo@kernel.org>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc: david Atkins <david@3adesign.co.uk>,  Baochen Qiang
 <quic_bqiang@quicinc.com>,  "ath12k@lists.infradead.org"
 <ath12k@lists.infradead.org>,  linux-wireless@vger.kernel.org
Subject: Re: wcn7850 issues
References: <LO0P123MB4057D6C2F6FEFF335B30EE7CD6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<LO0P123MB4057122D4C7D07C7114F5ABED6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<be53813c-3edc-4734-b59d-83f43f14ea91@quicinc.com>
	<LO0P123MB4057C3085F445434F5E87B3AD6872@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<26bb8ec7-7170-4a09-ada3-c7c753c16e87@quicinc.com>
	<LO0P123MB40573F46A6D63145363C6B13D6812@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<cfe8e314-a28b-4ea3-85b2-9f5b4ac2db09@quicinc.com>
	<LO0P123MB405769E063E48B0F7AE18C5FD68C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<LO0P123MB4057E823BDB7B9ECCCD75840D6972@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<a6c609fc-150b-4779-b3f6-dddbd6ce93dc@quicinc.com>
	<LO0P123MB40578A6CEC43AEFE301F9ED8D6912@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<86bc1623-8845-43fa-9aad-a8a6066b1448@quicinc.com>
	<LO0P123MB4057266AFF389FA69FDC84B8D6922@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<fb455a66-b29b-4eb0-984c-254f9a1c5626@quicinc.com>
	<LO0P123MB40578B26075CD4C9C66D144BD6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<871q21kwk8.fsf@kernel.org>
	<CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
Date: Tue, 03 Sep 2024 13:09:32 +0300
In-Reply-To: <CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
	(Janusz Dziedzic's message of "Tue, 3 Sep 2024 11:57:35 +0200")
Message-ID: <87seuhjbfn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Janusz Dziedzic <janusz.dziedzic@gmail.com> writes:

> wt., 3 wrz 2024 o 09:47 Kalle Valo <kvalo@kernel.org> napisa=C5=82(a):
>>
>> + linux-wireless
>>
>> david Atkins <david@3adesign.co.uk> writes:
>>
>> > ...
>> >> >>>         Ext Tag: EHT Operation (802.11be D3.0)
>> >> >>>             Ext Tag length: 8 (Tag len: 9)
>> >> >>>             Ext Tag Number: EHT Operation (802.11be D3.0) (106)
>> >> >>>             EHT Operation Parameters: 0x01, EHT Operation Informa=
tion
>> >> Present
>> >> >>>                 .... ...1 =3D EHT Operation Information Present: =
True
>> >> >>>                 .... ..0. =3D Disabled Subchannel Bitmap Present:=
 False
>> >> >>>                 .... .0.. =3D EHT Default PE Duration: False
>> >> >>>                 .... 0... =3D Group Addressed BU Indication Limit=
: False
>> >> >>>                 ..00 .... =3D Group Addressed BU Indication Expon=
ent: 0
>> >> >>>                 00.. .... =3D Reserved: 0x0
>> >> >>>             Basic EHT-MCS And Nss Set: 0x44444444
>> >> >>>             Control: 0x02, Channel Width: 80 MHz EHT BSS bandwidth
>> >> >>>                 .... .010 =3D Channel Width: 80 MHz EHT BSS bandw=
idth (2)
>> >> >>>                 0000 0... =3D Reserved: 0x00
>> >> >>>
>> >> >>> Are you saying the ath12k driver does not support these features?=
 If
>> >> >>> not can
>> >> >> you clarify the issue so I can raise with the AP team.
>> >> >>>
>> >> >> ath12k/WCN7850 supports EHT, but with NSS only 2. Here the AP
>> >> >> requires NSS to be no less than 4, that is why EHT connection was =
disabled.
>> >> >
>> >> > Which field is requiring NSS of 4, I'm only seeing a maximum of 4, =
the
>> >> Qualcomm windows driver will connect to the same AP, we had assumed t=
hat
>> >> that ath12k would do the same.
>> >> Basic EHT-MCS And Nss Set: 0x44444444
>> >
>> > My understanding of the spec is that there are maximum numbers of
>> > streams though, are you saying the AP has to advertise 0x22222222
>> > which would then prevent a 4x4 client (say an extender) from
>> > connecting with 4 streams? I note that the Qualcomm windows driver for
>> > Hamilton works with the AP and an Intel BE200 also works both of which
>> > will be in at most 2x2
>>
>> Did you test Intel BE200 with the Windows driver? Johannes mentioned
>> that ieee80211_verify_sta_eht_mcs_support() in mac80211 checks this so I
>> would assume that iwlwifi also behaves like ath12k.
>
> Yes, this is AP issue - hostapd fix required - advertise 0x11111 ...
> In other case station  < 4nss will drop to HE only.

Thanks. And Johannes pointed out that you had even discussed about this
before:

https://lore.kernel.org/linux-wireless/CAFED-jk8pJheJEViESnE54f-K+JgRMiWoiC=
Sa0GBt=3DRKaCn7sw@mail.gmail.com/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
https://docs.kernel.org/process/submitting-patches.html

