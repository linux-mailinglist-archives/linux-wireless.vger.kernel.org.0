Return-Path: <linux-wireless+bounces-7286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D78BE1B2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD94A1C220C7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E120156F22;
	Tue,  7 May 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZfie1WS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D9156864;
	Tue,  7 May 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083708; cv=none; b=ELDIbx14FSgZMA+v97L4wsyYqtk/bTn0Njud/aqDAVHtLH4mQxvf1gPPkcRqheiUXBoHQ6TD2ak5ajKFJIEr0NLr9P0HJ6XQSPyg9iP54FP2hBjImUWC38ToeGYmfFud30Q3maAuZMVbw5RMpitZBgi+2iSHGMRyGdNaUFNsDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083708; c=relaxed/simple;
	bh=r/iiWHA20dF8NmTwth/leMkONbX7J6hLFAP3jTNvNqE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=b8WUrKCL1pukMUFIGUwvFvdDt/6fGalcsQDbFWQ72Jkiwt6D/Ha9gkQp/rH6/O2R94QFEzLgUDUSrBwlSSM3HFLzphp7g+t1P5/5O2A3AdgJgXvSnvPd4VILjQ9/G4Uzn9aA2XRvk+kwckSQQIfQ65LpUWNuHaj/fmzxXL3uxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZfie1WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF2EC2BBFC;
	Tue,  7 May 2024 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715083707;
	bh=r/iiWHA20dF8NmTwth/leMkONbX7J6hLFAP3jTNvNqE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=eZfie1WSHZxOdOtv3eKO9ktleaEjiJoh7TmxPPwfOBDd67C5qLJMi0tsvnpf9Azkb
	 cAK+wTePFHiLKWGmbWc9Al26T8M9cnMKjOkpVHylxFgVTe4ZzavrebtltHIxRqouii
	 iNHWvuq40iJMBXJXRHLhAOQfSbmxRuwCRI6/AOg11fxAdohyer2tUe+7xaF8Vn/j4U
	 +lRPPmZ4qh/RumPPfz3DHXyHAb1MLjYE7WXrEcGMeoyQqdn7uQdZYMANZNxFMZsXPi
	 c2yS9hDDWEbt/giSFZHgAj0VSbwFNuws22DGhp41QryA4l/BD4k39XjWxSOhdBTAE2
	 Pacbvp2Rw1gVQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwl8k: initialize cmd->addr[] properly
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b788be9a-15f5-4cca-a3fe-79df4c8ce7b2@moroto.mountain>
References: <b788be9a-15f5-4cca-a3fe-79df4c8ce7b2@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes.berg@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171508370426.12731.13082451310329470582.kvalo@kernel.org>
Date: Tue,  7 May 2024 12:08:25 +0000 (UTC)

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> This loop is supposed to copy the mac address to cmd->addr but the
> i++ increment is missing so it copies everything to cmd->addr[0] and
> only the last address is recorded.
> 
> Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied to wireless-next.git, thanks.

1d60eabb8269 wifi: mwl8k: initialize cmd->addr[] properly

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b788be9a-15f5-4cca-a3fe-79df4c8ce7b2@moroto.mountain/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


