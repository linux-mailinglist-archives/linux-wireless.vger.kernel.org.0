Return-Path: <linux-wireless+bounces-5098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBFC885B6C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 16:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBCC1F239EC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286008595C;
	Thu, 21 Mar 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhF4jUSr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AE85943;
	Thu, 21 Mar 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033777; cv=none; b=X2apdffCrs1yvSwrgeJ9X8GeWlGJJqE9J01Jq7nIAcx6srflqyleERwlL95jUe9qpPwB8YL7t6HCoN2YHHaAfs5YJRopsLIbc7VFT+vxZ1g8MF/zR+XuAtn0xO6THdODk7ZDW7pryi9pn8c6r2lcaJ4zbMk3JG8L/5EzuzNh2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033777; c=relaxed/simple;
	bh=G6NTJt7joh2QpS7GqQPcdEuL7u8Et9P+QNk32/jLYpU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=QF8olpmMttj89M+GKeuCaxJl56bM3Uh5yXaBecdE7MMfnLHd2zhjWyDHGA3k+/DCM1T2kVLxvFAB6qY+aXXxN6rQa94Dm2kyA1QMZpnNBLbyrCiVRAeqOC+WNRd66ikjJSHaA0DTR6OU7nkKoco9D4qNu9+Lrtn9fSnZLNN1Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhF4jUSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15787C433F1;
	Thu, 21 Mar 2024 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033776;
	bh=G6NTJt7joh2QpS7GqQPcdEuL7u8Et9P+QNk32/jLYpU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UhF4jUSrSYeHjbQJYC6o8CrUYZzhIXPYMqF2agwKGGPwKAvgjwXmg4k/3SP1aZY9y
	 M3UlBEyWsshsaL564wcKgUTrxx6Ogi+MudSF7fWrz37OcS3PZu4aF+sESH7h9tqJGX
	 sWP5NR2w4TZ7dquuQGjRTU/zaXSuE2OIaG+KP1tngGSsNc9Zn5ykSFiqXW0kVvtz8C
	 5CgasnTuVk7i0BlEsunY0mNWOQAktV0Kh5haPE8fI1Hya0ThYEi0QNtSB7OjbJ49ph
	 75AlOTMX307Py4sfpTUP0xlQy20SPjPcPUIlbt3uQ5hz3TzPS8UzP5cKsJ926NtKmJ
	 Ptuatsy0cm51A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: qtnfmac: allocate dummy net_device dynamically
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240319172634.894327-1-leitao@debian.org>
References: <20240319172634.894327-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, kuba@kernel.org,
 keescook@chromium.org,
 linux-wireless@vger.kernel.org (open list:QUANTENNA QTNFMAC WIRELESS DRIVER),
 linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171103377318.103792.6654245785464194890.kvalo@kernel.org>
Date: Thu, 21 Mar 2024 15:09:34 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct qtnf_bus by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at qtnf_pcie_probe(). The free of the device occurs at
> qtnf_pcie_remove().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Patch applied to wireless-next.git, thanks.

61cdb09ff760 wifi: qtnfmac: allocate dummy net_device dynamically

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240319172634.894327-1-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


