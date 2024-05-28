Return-Path: <linux-wireless+bounces-8183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091838D1773
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7E1F2125D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3016A397;
	Tue, 28 May 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMwVSLqF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB971743
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889471; cv=none; b=bt78HPv3Hy0NU8rnEnif+goZHZVKtHBctmtrCHaJRAVR411UTMZwVXBNSSZdy5vJLS8Qg1XHNNcjWCLTpzZnXvv8LQXRChrB/Tiib4OQ9UYILua4evPKY+uaRnT8U47suK2lyRoGGiRZSo6LpURX1ubFtnYfQRi9w8QQPw1aRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889471; c=relaxed/simple;
	bh=6CG8idZx1kAWpDyLQ9RXYYmnFnPter6b200vAweFLh4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SBmuhx7ckyvhbeWP2qMyG45YuK7oR+M30kWrx2r/o5x3gGgAwhRcwkjbkqtzmtbjDlDICPS2wqebjEGV9thB/WDVVf8vrfYApZlgisqMNmhVaDrvp1gkqCpu7khxVkd38itBWvJiA8ymclfdNsRpXEW4Weqlbnz2wU69oiRnRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMwVSLqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B870C32781;
	Tue, 28 May 2024 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716889470;
	bh=6CG8idZx1kAWpDyLQ9RXYYmnFnPter6b200vAweFLh4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FMwVSLqFy4Ji58Z774/D8YyJW51A1MvWlptvZaibGvDBGNFGmqat+TTDaO0Wkx6Sy
	 SX4b3Rbzuqn6+jM02SIlu+MIQj/tkMx2WgGD8xnom6iBoDGR3fHStbmwGdnuMZtLQo
	 m+TlhFB18Hiii9VBjyPRQbEclER0sHNkFcC0Rnr976VZZXKImyVtwUYqVAMF49AQYt
	 4GUDfkDhMBrbTC07wGT4OGdlYaAK2hM0FY431BQIAcF8am4r/EK8pkwivbTBEQpcSp
	 Ckv33t/8yfo4lamivOklI1DE99HQZfvV3zskfz5Z2iox1Ur7ESdmO+CerGiuUYBFbF
	 FMljS2hzEOktw==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
  linux-wireless@vger.kernel.org,  "Ajay.Kathat"
 <Ajay.Kathat@microchip.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [bug report] wifi: wilc1000: convert list management to RCU
References: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
	<0a9c592d-7db3-454e-a83f-901b1865b414@bootlin.com>
Date: Tue, 28 May 2024 12:44:27 +0300
In-Reply-To: <0a9c592d-7db3-454e-a83f-901b1865b414@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Tue, 28 May 2024 11:31:16 +0200")
Message-ID: <878qzu8e4k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> Hello,
>
> On 5/9/24 15:24, Dan Carpenter wrote:
>> Hello Alexis Lothor=C3=A9,
>>=20
>> Commit f236464f1db7 ("wifi: wilc1000: convert list management to
>> RCU") from Apr 10, 2024 (linux-next), leads to the following Smatch
>> static checker warning:
>>=20
>> 	drivers/net/wireless/microchip/wilc1000/mon.c:236
>> wilc_wfi_init_mon_interface()
>> 	warn: sleeping in atomic context
>
> My bad for the extensive delay to fix this. I have been in fact scratchin=
g my
> head quite a lot around it. Adding Kalle and Ajay to keep them updated, a=
nd
> possibly to get opinions.
>
> This issue is indeed due to my recent series converting back SRCU to RCU =
in wilc
> driver (submitted because at this time, there was no obvious reason nor
> documentation about why SRCU was needed). By checking further the consequ=
ence, I
> find in fact three issues, and I suspect those to be the original reason =
for
> SRCU usage in the driver instead of classical RCU. All of them are reprod=
ucible
> with runtime checkers enabled regarding RCU and sleeps in atomic sections,
> either by triggering some heavy traffic for the first one, or raising an =
access
> points for the two others:
>
>   - one issue is in wilc_wfi_init_mon_interface (the initial warning rais=
ed by
> Dan). This one:
>     - parses the vif list (under RCU) to perform some checks, possibly ca=
nceling
>     the interface registration
>     - then registers the monitoring interface (has sleeping calls, especi=
ally a
> register_netdevice call)
>     - then if registration is successful, updates appropriate vif to flag=
 it as
> monitoring interface (then leave RCU section)
>   I have a hotfix for this, but not a very satisfying one, which consists=
 in
> splitting the RCU section into two (first and third points), but addition=
ally
> using the vif list lock to make sure vif list has not been altered in-bet=
ween.
> IMHO this kind of fix just make things worse in the driver, just to tame =
RCU.
>
>   - one issue is in wilc_wlan_txq_filter_dup_tcp_ack (the second warning =
raised
> by Dan), which calls wait_for_completion_timeout while being in RCU criti=
cal
> read. The issue can be properly fixed by just counting the number of pack=
ets to
> be dropped inside the critical section, then effectively applying the mul=
tiple
> wait_for_completion_timeout _after_ the RCU section.
>
>   - finally, there is an issue in set_channel ops (cfg80211.c), which fet=
ches
> the first vif (under RCU), and then uses this vif to send appropriate cha=
nnel
> configuration command (which sleeps at some point). Since used vif here c=
omes
> from the vif list, I don't think it is safe to leave earlier RCU section =
(vif
> pointer needs to remain valid until command is sent to chip).
>
> Because of the second point which would bring a not-so-clean fix, and the=
 third
> one for which I still don't have a proper fix, I am considering to submit=
 a
> revert for my RCU conversion series, to come back to SRCU. I don=C2=B4t k=
now if those
> issues do or do not make SRCU usage more legitimate, but at least I feel =
like
> really fixing it need slightly larger rework. I will still search for bet=
ter
> options, but if I do not find any, I will submit the revert.

Thanks for the good summary.Maybe it's easier just to revert the commit
immediately so that you don't have to waste more time on this?
Especially if Ajay is missing.

But if would be nice if you could also include a separate patch which
documents in the code why SRCU is needed. Just to avoid duplicate work
later :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

