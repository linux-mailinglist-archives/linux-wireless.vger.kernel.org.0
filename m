Return-Path: <linux-wireless+bounces-5214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13188AB6B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA7D3231B4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74286AD8;
	Mon, 25 Mar 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX19eYhQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37C6FE19
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382836; cv=none; b=CbccTYsIV5+BUcuKru4i5eoiyVBnppiuwKhddCH8a5nZ3uq9a7wf2WLNGTS1oAbkn4swb1VXI/7wVVLmrqeqbxG8ayd5dUcsfO1fbzQsIaNyh4LLmeVL3b+5c62gDAw9arZPBu0K8+ANRDDqAT7YsTYf1A7wsk4JcN2ldC4QSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382836; c=relaxed/simple;
	bh=GBcH1gHlUXmRafory3kjw/LZOHwna/s3jBusQjwBPGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZKdgR7tar5aqSfbw2qQAQ5bk85bAJS3c4/bme4NJYO6VC2c02W8h5K6W4Ty7vX90Vu68TglhIhXIPeFmsYL0lNFSyzr7tx4B3CSGfLTQCzu6bFpa1bzDlfwgg5FhjxCHfz+zlp5YUOcKqCNO/DngDBmwKMp1KrKzdeRhm676kWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX19eYhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2EBC433C7;
	Mon, 25 Mar 2024 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382835;
	bh=GBcH1gHlUXmRafory3kjw/LZOHwna/s3jBusQjwBPGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fX19eYhQgJktjayIX3mJip7DwSBl98YGD2bR9Bt54PObSGgN5OY9V1uRP2tsITu2k
	 MLrHyTXusTolZ3InIDkyA81Ww3OFtXtyp/rDojqcpvnSeIG7LVrvhVs0IbtHCkIHpc
	 cTebwpRp7OnxSSPrcnsap1ylUIlGET9keVSBeOrqinn1na660HTS3JcTnhn+ek70PT
	 rIGTkOKCXUNkp8v/Kmhb4FZfwEi4xMF4dpEKKHO/R+67PLSmjU/MnKhZIDp2rjLHPj
	 vigMdenV5ly/ja+MPqVEnGOVJacwLKmoj2ST57yPPw2qK4G9O4e2uhj8D3jjkVLHDt
	 iKqozuauIdIpQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ADB7011A18A9; Mon, 25 Mar 2024 17:07:12 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, Miriam Rachel Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH] wifi: mac80211: use kvcalloc() for codel vars
In-Reply-To: <20240325150509.9195643699e4.I1b94b17abc809491080d6312f31ce6b5decdd446@changeid>
References: <20240325150509.9195643699e4.I1b94b17abc809491080d6312f31ce6b5decdd446@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 25 Mar 2024 17:07:12 +0100
Message-ID: <87y1a6b8i7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> This is a big array, but it's only used by software and
> need not be contiguous in memory. Use kvcalloc() since
> it's so big (order 5 allocation).
>
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

