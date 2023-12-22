Return-Path: <linux-wireless+bounces-1207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C429281C63A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 09:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F1D1C24FBD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14014F75;
	Fri, 22 Dec 2023 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGilFavi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC314F73
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 08:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705EBC433C8;
	Fri, 22 Dec 2023 08:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703232485;
	bh=WL/L6yV91Pcri6kImsWABDutafkXNQ13K7WcccGnUwM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fGilFavidWj48CYvAcePAKhwZFWgStw88m8+rV3KZ3EfhrNjp1Y3l7NLRIEgAexzf
	 p65VurpdPx9AMpDtpPYglfYNf5+TqTqMnggVbJ/5YzEjrxcglKTq7iCgQSbUpBqrkH
	 CTU29LoYtMo8deAxDewuMyrpEWnWpT1+2Y97zi+QSW2XFOMRFoD3wzObLE1DD2O3Dc
	 AWGGedwRsKRKE4N59QVb3O/FyyZ9IsruQ2cdfEp6t2BTimfFCGJBXf7sdOhbuzYqaq
	 70WoBkUHka19P3vBu1rXXofcj+xlAE31qAx8tM2zi3aSWs17zWPYNeHFR3xWbeUvO5
	 FOYze4R6+2LPg==
From: Kalle Valo <kvalo@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  linux-wireless@vger.kernel.org,
  wireless-regdb@lists.infradead.org
Subject: Re: [wireless-regdb] [PATCH v3 2/9] wifi: cfg80211: save Power
 Spectral Density (PSD) of the regulatory rule
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
	<20230315132904.31779-3-quic_adisi@quicinc.com>
	<4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
	<46343a69-5f27-4ffa-bbd8-5b5e7616dbbf@quicinc.com>
	<CAGb2v66gfifO4oSt7R=EZYNjEOZtovaOLeJPCUZPkyJP1shbeQ@mail.gmail.com>
Date: Fri, 22 Dec 2023 10:08:02 +0200
In-Reply-To: <CAGb2v66gfifO4oSt7R=EZYNjEOZtovaOLeJPCUZPkyJP1shbeQ@mail.gmail.com>
	(Chen-Yu Tsai's message of "Fri, 22 Dec 2023 11:57:46 +0800")
Message-ID: <87sf3u1wyl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> writes:

> On Thu, Sep 14, 2023 at 11:15=E2=80=AFAM Jeff Johnson <quic_jjohnson@quic=
inc.com> wrote:
>>
>> On 9/13/2023 7:58 AM, Johannes Berg wrote:
>> > So I'd say we shouldn't touch any of the code under #ifdef
>> > CONFIG_CFG80211_CRDA_SUPPORT any more since CRDA will not continue to
>> > developed with any updates here.
>>
>> On a related note, what will happen to ongoing wireless-regdb support
>> now that Seth has stepped down as maintainer? Have enough vendors moved
>> to self-managed such that regdb is obsolete?
>
> I've picked up maintainership for wireless-regdb.

Chen-Yu, sorry that I haven't been able to comment anything earlier but
I want to thank you for taking the role. And big thanks to Seth for
maintaining regdb for all these years!

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

