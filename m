Return-Path: <linux-wireless+bounces-9496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABBC914802
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0331C2201C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E76E135A7C;
	Mon, 24 Jun 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di7KGP6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF313A253;
	Mon, 24 Jun 2024 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227015; cv=none; b=TVgxMAwaCZVgIzFH4uOGXYPAK/Pb6yN6NlMS6PVyPKCb9MsRPWQp6F+QN/ktHNAo2/4F7cEmI9g5daBdjB4s/0scaUF7IbCCJ9CIDQckoLtafubF7cbKcnP4eu9AXS6GtHNRfmNxcd4q6ynSxpyRxvntCeKsIaq7h1gEXZlxKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227015; c=relaxed/simple;
	bh=sVp1DIE/wkrXkag6/P+ZbXz6P/RcvirkABhw1eZpHDk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=I+me7USm5JlHhpdDKtCfc82DxFjeWQuAE8od+1f0R60VQoMiMxTKuA25/BOS6TUXxpbyhy+NeeZjLTPGwPAidlo0havBI94UT5ubfZx/LkpURVXJuZAcEMRljqfekCojZWYzGpi1+u09fjumb++GU6/XjO8UQF5+4bwWfRlguAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di7KGP6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7454DC32781;
	Mon, 24 Jun 2024 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719227015;
	bh=sVp1DIE/wkrXkag6/P+ZbXz6P/RcvirkABhw1eZpHDk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Di7KGP6c7jFb72Zaf6N8uFCCqPQl9cZzbRgUgnrraqyAOidt356G9x59Zqpc/C0o6
	 f0ZqBz+M6sPvxTX05lskUU3nYhbrN+Lsc1/tWecUgjQvwnBrmBX+znbls6aQOWeWbz
	 75S6ZPGKd0EE1sdWdAAR8m0bF49bC9yItSteDNHiCBB4YY39d07IC09NeY4FX76CEc
	 NH6Ua8TTNHRC/6pBxYm++Met/dNh8y7aqhLZCqa2t1jNL/sYYKoZi5fn3w4ZpCHRcf
	 6oFroALkKjRP0lPxrtJ8TDjVXMDY5SMIyqsac/Tfhp0AtpvV19Sh9uTKquE9d7p53Z
	 onoIG+gt+93CQ==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: KeithG <ys3al35l@gmail.com>,  <linux-wireless@vger.kernel.org>,
  <brcm80211@lists.linux.dev>
Subject: Re: brcmfmac: how to setup SAE on RPi // Re: [PATCH] wifi:
 brcmsmac: advertise MFP_CAPABLE to enable WPA3
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
	<1903bdacb28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<CAG17S_MPxPms32e=s8szVOBHQk=tikN5sjO_pa8r1as0V2Q5ZA@mail.gmail.com>
	<19040403c70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Mon, 24 Jun 2024 14:03:32 +0300
In-Reply-To: <19040403c70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Sat, 22 Jun 2024 16:01:10 +0200")
Message-ID: <874j9iiovv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On June 21, 2024 9:44:00 PM KeithG <ys3al35l@gmail.com> wrote:
>
>> On Fri, Jun 21, 2024 at 12:32=E2=80=AFPM Arend Van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>>>
>>> On June 17, 2024 2:26:25 PM Arend van Spriel <arend.vanspriel@broadcom.=
com>
>>> wrote:
>>>
>>>> After being asked about support for WPA3 for BCM43224 chipset it
>>>> was found that all it takes is setting the MFP_CAPABLE flag and
>>>> mac80211 will take care of all that is needed [1].
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-wireless/20200526155909.5807-2-Larry.Fin=
ger@lwfinger.net/
>>>
>>> Tested-by: Reijer Boekhoff <reijerboekhoff@protonmail.com>
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>> ---
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>> I think I get what it is supposed to do, but am unsure of how to do it.
>
> Sorry, but I think we have hijacked this thread so changing the subject.
>
> @Kalle:
> Hope you are not too confused. My comment on my own patch was about
> adding a Tested-by: tag which I forgot to include.

I actually figured that out even on my own but thanks for clarifying :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

