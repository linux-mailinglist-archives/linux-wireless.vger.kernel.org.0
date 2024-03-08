Return-Path: <linux-wireless+bounces-4494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D34876704
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 16:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA001F223EB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2931539C;
	Fri,  8 Mar 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDkSlMMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF929524A
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910411; cv=none; b=DcORGGfgwbn1r1NnBrlhCB28WmCUE7MOZzxMrBgcMaUeAiPFdEAJtHKMpxWhhQj43/4c+oKVhj/VSY8nDAlrGpLkJISowkQbtCUEE2f5BfBxTp9PRpCBxa/l7Ld6gisJI8RCV+QJSI6HetehjcB/MmnfRb6smkIj/Jnp0wq4XpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910411; c=relaxed/simple;
	bh=7hPKA+WyRR2wPp58WUztimwXnR4OlEnInvhO2YFNqHI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=LrIRGAbWV4UTEoWRHZmw6YScNFFcjWxrvM9UwOAdRKXUXGnG3h+fHNE6vkRGzXmBNBSQf5NSVzJBqeobmKG2ppKEeVn09jASO5rq8+whZgptVpEBIp7CTgt/85ZX65081uGuqC/VluWlkDd8+PeKC9PemUbGTz/27wUyj9Ek2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDkSlMMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57542C43394;
	Fri,  8 Mar 2024 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709910411;
	bh=7hPKA+WyRR2wPp58WUztimwXnR4OlEnInvhO2YFNqHI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BDkSlMMe5tR2s4HlKT2gsr6FmIHpZSmGaD/YU0+SbP3XMALb0WdHeHYxZ64/Komz+
	 lLrhYRPxteYyuLWmNQzTvguxplAbbtSOsC58nlrwrZJL3vfmEjrRD8QeH9PXCioL0o
	 s+T1pf+33BFQG8PVRAg5StNZ9fYttLWDBtKA5mDMfjlXBwesoLLb8ARBJyLZ97/Zxw
	 ilX0thJlWazX2K/J2zmSXih3z3mMwX0/VgsexgpIdesSsCT/zKQwcmA+S5n4TF8iJ/
	 9mLWzYpVZ54CH3tLbjpdcPJI+D2HqOY+iOzMWeLZ4OVG34uC8yfg5JQrAjojZAs+3R
	 AczjgJ2TPumgg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: poll service ready message before
 failing
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240227030409.89702-1-quic_bqiang@quicinc.com>
References: <20240227030409.89702-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170991040833.1311983.10804124328210267048.kvalo@kernel.org>
Date: Fri,  8 Mar 2024 15:06:50 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently host relies on CE interrupts to get notified that
> the service ready message is ready. This results in timeout
> issue if the interrupt is not fired, due to some unknown
> reasons. See below logs:
> 
> [76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not received
> ...
> [76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110
> 
> And finally it causes WLAN interface bring up failure.
> 
> Change to give it one more chance here by polling CE rings,
> before failing directly.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros 802.11ac CQA98xx devices")
> Reported-by: James Prestwood <prestwoj@gmail.com>
> Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2
> Link: https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e57b7d62a1b2 wifi: ath10k: poll service ready message before failing

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240227030409.89702-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


