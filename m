Return-Path: <linux-wireless+bounces-14212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37569A3D80
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0751F21A97
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A779EA;
	Fri, 18 Oct 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYlqvUud"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714F6FB6;
	Fri, 18 Oct 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252188; cv=none; b=A3i1IUSXZT3PuIW4pgyvq1hti9M6cyUOANnvYS8s8n4YriOqLwBeEK2mVXvt7eFVwfO3NRMZIbfEyShExqXbt6VBdOG/ByifW8SB2oJB5s6323mhYTedsyCOLI5jPmEEYnfn0R3SCdF5zQmQXfxrcLWoHv2var10nBk20CsuPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252188; c=relaxed/simple;
	bh=mg5kdNfTdx14uiIW5ZvOxucA9flwjgHNLXYQdAdzvCY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ACwyvBpTwyMiPoZ2g/U6qEEEYgSQ+YgJl8M6pq7DV91cbPPxTv1rcCl0TBUrOn+VxFWTqisb78fNw0mxuQ5V7YkzzWU2DHQfx/1y7bZWfYmRKvrW0zwUiKZeWvn9ybLWonSGs4y6Jb36Uoox5aufTTDDjj0wW+YrpdB0UrMDd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYlqvUud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43925C4CED8;
	Fri, 18 Oct 2024 11:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729252187;
	bh=mg5kdNfTdx14uiIW5ZvOxucA9flwjgHNLXYQdAdzvCY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uYlqvUudWIHdF9iKbfGcEe1uzinnsFCyhj4NOSdyFKOtj4aZvRb1/aaj65KiaejQr
	 Ac74oiMgTC9qmdTiz4mOhH/ZRZZdGgvtw0FpL1kToHTvOJUb4flpe/ydNiQNqZZ3Dr
	 +qUp5a8nLW4ZEO5avdGIFshffwTPbfHvZauvijYgNlOud8bfA7pcn867LtRZCuTNRn
	 40Bq7byr0zsxrSymozy7xd21s6FtVzPmwJs87/1EIE2urb9NlihyWcuzsMqVpcrQQi
	 Kg96jH+m9Ar8Gre5rf4FZT4ZRaSZnYFAcnlV4FgFHNdWbVbwsi6HypcfP+L44+3nzZ
	 ++RKSk9IvUiUQ==
From: Kalle Valo <kvalo@kernel.org>
To: =?utf-8?Q?Pawe=C5=82?= Owoc <frut3k7@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Jeff Johnson
 <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
References: <20240801202359.794035-1-frut3k7@gmail.com>
	<20241009065051.51143-1-frut3k7@gmail.com>
	<b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com>
	<CAKEyCaDUfn4jtCdTt9JJ-Qe+CCudORPwcjj5i5=G28ANc+eCRg@mail.gmail.com>
Date: Fri, 18 Oct 2024 14:49:44 +0300
In-Reply-To: <CAKEyCaDUfn4jtCdTt9JJ-Qe+CCudORPwcjj5i5=G28ANc+eCRg@mail.gmail.com>
	(=?utf-8?Q?=22Pawe=C5=82?= Owoc"'s message of "Fri, 18 Oct 2024 00:51:59
 +0200")
Message-ID: <87ed4dr5pj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pawe=C5=82 Owoc <frut3k7@gmail.com> writes:

> On Fri, Oct 11, 2024 at 6:51=E2=80=AFPM Jeff Johnson <quic_jjohnson@quici=
nc.com> wrote:
>>
>> On 10/8/2024 11:49 PM, Pawe=C5=82 Owoc wrote:> Add support for channel 1=
77 (5885
>> MHz ) for the 5 GHz band.
>> >
>> > Tested-on: qca988x hw2.0 firmware ver 10.2.4-1.0-00047
>>
>> Can you elaborate on what was tested in your commit text? And more
>> importantly, what is the impact on existing devices, especially given th=
at
>> existing devices would not have calibration data for this channel in the=
 board
>> files? Does the QCA988x board file even have calibration data for this c=
hannel?
>>
> In the case of ath10k we use an external regulatory database.
> For the country "US" channels 169, 173 and 177 are marked as NO-IR and
> we cannot run AP on them.
> Even if channels are not disabled in the board files:
>             * 5845.0 MHz [169] (27.0 dBm) (no IR)
>             * 5865.0 MHz [173] (27.0 dBm) (no IR)
>             * 5885.0 MHz [177] (27.0 dBm) (no IR)
>
> I only tested the use as a client on channel 177:
> root@OpenWrt:~# iwinfo phy1 scan
> Cell 01 - Address: XX:XX:XX:XX:XX:XX
>           ESSID: "ch177"
>           Mode: Master  Frequency: 5.885 GHz  Band: 5 GHz  Channel: 177
>           Signal: -43 dBm  Quality: 67/70
>           Encryption: mixed WPA2/WPA3 PSK/SAE (CCMP)
>           HT Operation:
>                     Primary Channel: 177
>                     Secondary Channel Offset: no secondary
>                     Channel Width: 20 MHz

I wonder how this works with QCA6174, unfortunately I'm not able to test
that.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

