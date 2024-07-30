Return-Path: <linux-wireless+bounces-10671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45B5940C2B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 10:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80668288313
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FA18EFE4;
	Tue, 30 Jul 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbcB6YLB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6C43152;
	Tue, 30 Jul 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329299; cv=none; b=WOMXGZSyQdnSCsyZ+Lp2bquxm3W19S+wMddqlrim1Ux0AMATjVZegAG3XqjT1QhSyATqRN88h3XuTWKLzcJBEPnaC9Vnl0DMwLtVVgbKRrw8EjL/lGLiXheEbnYPhTSO9JZEChyOG93h9SBqwRGk4lIFzhh3JpWBV1EvBis/780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329299; c=relaxed/simple;
	bh=2ed6FnghtNjFIlxxsxnvwh86CKxY7CD4v+Yuh554HAw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=St7pmAovLNlbNsynzFpUAQkrrUzJSqbxca5IdPqJOwTcfcZRKVFtQ8FptJDIkuUzs3nVvBITRp2ZlgteD6O1jjup1sSqZdqPY1V3zbEWrTma+V8v8XNP/Kfwri+UaGNWInG5QVLzgO+RODsCyyP10utvTiTb70aaJTJps1vXpho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbcB6YLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F139C32782;
	Tue, 30 Jul 2024 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722329298;
	bh=2ed6FnghtNjFIlxxsxnvwh86CKxY7CD4v+Yuh554HAw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LbcB6YLBBxlQfe9lMCGIrIdZCQ1dPiKY5SKgEABJ03oSBab9Uu4Bai+Y2NLzep6td
	 9QCcffLHeMfi9F2n9qsd8yj1vFfZsPNVa2pebUO3b9s81reFsXNL252kK3guhuSium
	 K06myIIh7WAB6TcxP+oCZSJ9hhUMrysUDX+mtINQ/iujrOme0RBnUNc1N7PN2Jsw6N
	 jBCi5prb0RL8Idcic08AzrOd4lBHAniwB1mDiHZUayPCE5vNW1fxDO/UXmexIw7+bz
	 +Cn54kaMPHD5ApgBnuNxwoAIaR5/43LasZWm5CKQquMbs2pQzhpa98pTPQxYwmA550
	 846LUOjYN+emA==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,  Brian Norris <briannorris@chromium.org>,
  Francesco Dolcini <francesco@dolcini.it>,
  linux-wireless@vger.kernel.org,  David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
	<ZpY4-PpxgMOH0wQB@pengutronix.de>
Date: Tue, 30 Jul 2024 11:48:15 +0300
In-Reply-To: <ZpY4-PpxgMOH0wQB@pengutronix.de> (Sascha Hauer's message of
	"Tue, 16 Jul 2024 11:10:16 +0200")
Message-ID: <87bk2f9sfk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> On Thu, May 30, 2024 at 03:01:56PM +0200, Sascha Hauer wrote:
>> The maximum number of AKM suites will be set to two if not specified by
>> the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
>> specify up to ten AKM suites in the akm_suites array.
>> 
>> Without only the first two AKM suites will be used, further ones are
>> ignored.
>> 
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>> 
>> Current wpa_supplicant/hostapd only put a maximum of two into the
>> akm_suites array as well, a patch changing this can be found here:
>> http://lists.infradead.org/pipermail/hostap/2024-May/042720.html
>
> This was recently merged:
> http://lists.infradead.org/pipermail/hostap/2024-July/042802.html
>
> Kalle, given that userspace now would be able to make use of a bigger
> AKM suites array, can we merge this patch for the kernel as well?

I changed the state to New now so it's back in my queue.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

