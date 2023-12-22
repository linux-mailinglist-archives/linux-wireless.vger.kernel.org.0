Return-Path: <linux-wireless+bounces-1197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918F681C3B6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 04:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C494F1C24889
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 03:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971053A8;
	Fri, 22 Dec 2023 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG9t7kI0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4D53A4
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 03:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E2FC433C7
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703217478;
	bh=4gFPeOCAMesn1NlrBwarB04PMIaol9Lci2GAUf+VOa8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=eG9t7kI0hKQdTTku/pbYgD/VJelBVec4HG9oJMd3HPX4cq0YAHLbHApMJd6ER2qIS
	 CE3odjvBVF9mJA3MJiWJPludYzzZewZq+IWyYQfNGReWEjT9LrLx8voKkH41hqncFT
	 wDUVRvxa1x5f9isP2HjgdpFkOlkv89BKeFX5nMPQLzA2phetxTbtFRjRbDhdQheSwj
	 lfkQUtXqdMa/bDRRLGze/NIHnnp4kWZsoY5YmhgHwlCVYBSKeoyxvTJ5nRuYOmnp9Z
	 H+MXvb9Sg6+7XYNnlhZvf8tBtYsVm6qfMhKZniEKx/1WR6jOzq/aJ6tAb9v1zANwGL
	 nq23uzYk2tYTw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2041c292da8so904863fac.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 19:57:58 -0800 (PST)
X-Gm-Message-State: AOJu0YywEMkanu38ClJcMxHgvS8NtK5GQJyUmQqKEU1o1OgaAtNd9hmE
	LpZ8vQRAonWL0BoylXNNqNTk8Y5Sttq9KMv/WXY=
X-Google-Smtp-Source: AGHT+IGxo3lwHna/VlB+n8WhrB+emS5+bMFz8m74UAplvKSOAyRTG6iz4nTM2PCNU0I7xcLXbEXcb970m8+pWGr7dwc=
X-Received: by 2002:a05:6870:71c8:b0:204:437f:af80 with SMTP id
 p8-20020a05687071c800b00204437faf80mr657294oag.85.1703217477597; Thu, 21 Dec
 2023 19:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <20230315132904.31779-3-quic_adisi@quicinc.com> <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
 <46343a69-5f27-4ffa-bbd8-5b5e7616dbbf@quicinc.com>
In-Reply-To: <46343a69-5f27-4ffa-bbd8-5b5e7616dbbf@quicinc.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 22 Dec 2023 11:57:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v66gfifO4oSt7R=EZYNjEOZtovaOLeJPCUZPkyJP1shbeQ@mail.gmail.com>
Message-ID: <CAGb2v66gfifO4oSt7R=EZYNjEOZtovaOLeJPCUZPkyJP1shbeQ@mail.gmail.com>
Subject: Re: [wireless-regdb] [PATCH v3 2/9] wifi: cfg80211: save Power
 Spectral Density (PSD) of the regulatory rule
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 11:15=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
>
> On 9/13/2023 7:58 AM, Johannes Berg wrote:
> > So I'd say we shouldn't touch any of the code under #ifdef
> > CONFIG_CFG80211_CRDA_SUPPORT any more since CRDA will not continue to
> > developed with any updates here.
>
> On a related note, what will happen to ongoing wireless-regdb support
> now that Seth has stepped down as maintainer? Have enough vendors moved
> to self-managed such that regdb is obsolete?

I've picked up maintainership for wireless-regdb.

ChenYu

