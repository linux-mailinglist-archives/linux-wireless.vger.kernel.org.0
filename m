Return-Path: <linux-wireless+bounces-11390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8EC951360
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 06:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F86B20E73
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 04:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCBE381DF;
	Wed, 14 Aug 2024 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHNpVuk8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75286219EA
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608497; cv=none; b=MrsR96O1u4rkOBsxp+5u3XsUhmhIpVzIgIQaRbQI6w7AyvyelZJUcRPDAvYlmNGayhO2cvaepVWsrMtX+KxTcA6omvqKJbBkFgmJ/AO2Yb4LAdGQXECIWCv5Jq+NMrmglukjv+YAViraYWGwF+5yjl5MULbVkc/8y9dT1Jtgte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608497; c=relaxed/simple;
	bh=ASawuLe5EyRxXS19GAY6UAMtVRl7zGIcfSS1p8XpWxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDAGHhE64P2qXOir+sXd1pV+C0OlktbeOstDovab7GnqEQXdqVe0kSEW1+RD/E5nfOJg+78qZlJArQCLw71K2Cbi31OYrxK4EQwDM/L29yFBtt9y6tNBSOiGmyLwz2ejRrHbLkRHBVlkVJx7rwfsSZV1FnAcWkntZzQy4uvQssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHNpVuk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD93C4AF09
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 04:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723608496;
	bh=ASawuLe5EyRxXS19GAY6UAMtVRl7zGIcfSS1p8XpWxU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=YHNpVuk85RmKw2BFj4HC/SM9Dd89J6qsvYw3P1nZ6s2t4a4YpyqCJHzIzItGAJ/Uy
	 hIJJbmVbDxdkzibdFnqXtvJlQIxsN/H1aI9BoUhGJshGysUaiQepr34ieOMLYWCeuR
	 uj13Cw1JCbHLCvaE6xG4ir/qLhhTpbgyJwx0wUr0Tkrn5w9IsY51Yhi47I3Y0oMaHG
	 Y1crRH93eMbdaqfKpqGP1gnB0RQY3IirUEnadRrd2sgrrsg+0/rtIwRJQo4YD02T1f
	 K8u+d4dL3QMTY5K1pawbjZ+QyVkN3SOLSEzxjxRltvzoKCnCFbqO0MMr3xLJ3+AGhO
	 P9H1g/4jKtfEA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f189a2a841so59614731fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 21:08:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwX0ul+gXe7bXESgy90nZe/EHTKauv+UvBDriFiBblTqY4HQDz9
	ZkEj17SNZn3150QgJrdNmToAxJIu7izpZIWtc9HhvJqD1pv2HEYD35XRlkXhNX0EELTzcfgBw4X
	aLNDTt5MgJCn/rH5UmjrDnfYfpbk=
X-Google-Smtp-Source: AGHT+IEhP2rtAqsPPVcn6Uw3cSyEYB5Pc9Dyjg2H6IZy66zP2tObUWdLBW3tSzce8eJEr5+ggfhZHbJ+zxcdF1Zbh9E=
X-Received: by 2002:a2e:4a12:0:b0:2ef:18a2:9deb with SMTP id
 38308e7fff4ca-2f3aa1eba24mr6068461fa.16.1723608495008; Tue, 13 Aug 2024
 21:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfbfa8f1-3367-4bc9-b201-2faac3aa7581@quicinc.com>
In-Reply-To: <cfbfa8f1-3367-4bc9-b201-2faac3aa7581@quicinc.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 14 Aug 2024 12:08:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v658Pdgxtwy6wXFjYVAm9mD6NLUm9fZb9k4AQCVS==ZZBw@mail.gmail.com>
Message-ID: <CAGb2v658Pdgxtwy6wXFjYVAm9mD6NLUm9fZb9k4AQCVS==ZZBw@mail.gmail.com>
Subject: Re: Should the wireless-regdb wiki be updated?
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 2:44=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> In response to regdb e-mails showing up on linux-wireless but not
> wireless-regdb I went looking at the Wiki to see the current guidance:
>
> https://wireless.wiki.kernel.org/en/developers/regulatory/wireless-regdb
>
> I was surprise to see the following:
>
> Sending updates to the regulatory database
> Note: wireless-regdb is currently unmaintained, and patches or requests f=
or
> changes are likely to get no response.
>
> Elsewhere in the Wiki there are some outdated references to Seth, as well=
 as a
> reference to "signed with his RSA private key" without any indication who
> "his" is referring to.
>
> This seems like old information that should be updated!

Thanks for the report. Updating the wiki wasn't a priority when I took over
maintainership. I've updated the wiki just now.

ChenYu

> /jeff

