Return-Path: <linux-wireless+bounces-12663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF92971957
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE7C281CA0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7C42048;
	Mon,  9 Sep 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7IpzCNX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB421E522;
	Mon,  9 Sep 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885063; cv=none; b=GxVoslaQHm74m2zwtmRq9F1XHnOX2pBI+LEYDU/+L6/P83ualioyhwFyB2mn28p1PQM5gK8GHwGFz5k3+5pDKeJxZIMX7CHZORuP2UKQvBGZ6XubdsvB1ieFC5/ZyPErGw4hg6iu2lXuvPugaWp9BhhhIfiINyNfQHKZFi5EEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885063; c=relaxed/simple;
	bh=l3Qw41g/LdHI5Dx7E5uUQi6js5WOTJmE2q/s1jrkDq8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jkwuY395wwyQBv5VoblgNzSXQGMzYB0qzUT+3VD4nt9tYuP+ot8cjwFdllnCQ/xa0zfyoTXhreZG9f7jI1t+uza+VMv36Mw/5GTsol1lK8FxtlfRxiJdjx4/hr3eivvT9IcQgnWFIzkVYYqF7o4VoQEEnKdc3x7kYxjnID4Vt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7IpzCNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EBEC4CEC5;
	Mon,  9 Sep 2024 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725885062;
	bh=l3Qw41g/LdHI5Dx7E5uUQi6js5WOTJmE2q/s1jrkDq8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=t7IpzCNXPH61gjJq3kptojZc9hXbtxSA0oqDoL2m4U/RCFIcrgXg7kYlCQM5U457o
	 8u+k4YgFDSH2kDzeZnXp+FBlHWq6IZEm93zxHaZ0hIcwNKzbZ9h0nV+cNRhkbo8kc/
	 6x6uJcqMWAEisN0LaO734WojkEEkgguIkt36g2twQD2SfQ2XHRhuh1macPlzFFD8Jv
	 g0biuaMNtOOv/pLi31/X2x5RVbniFdqLOm4wInVzlZH2vyFmGfaKXBV40JeNBHXfcY
	 QcWTL/BKmzrGVLBb5UG33r3a8/GSlWZ+DFPAnfVk4w+Ox5xcY9s5salorrf31FiRKP
	 cLDrhwZUNNpug==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rsi: Remove an unused field in struct rsi_debugfs
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <15b0609d7b1569ec6c500a175caef4c9189f33e2.1725394207.git.christophe.jaillet@wanadoo.fr>
References: 
 <15b0609d7b1569ec6c500a175caef4c9189f33e2.1725394207.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172588505901.2095526.16919940351663808564.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 12:31:00 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> dfs_get_ops has apparently never been used since its introduction by
> commit dad0d04fa7ba ("rsi: Add RS9113 wireless driver") in 2014-03.
> 
> More-over struct rsi_dbg_ops is not defined.
> 
> Remove the unused field from struct rsi_debugfs.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied to wireless-next.git, thanks.

eeccaa46cb6f wifi: rsi: Remove an unused field in struct rsi_debugfs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/15b0609d7b1569ec6c500a175caef4c9189f33e2.1725394207.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


