Return-Path: <linux-wireless+bounces-214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7787FD5A3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171F2B20EC2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF841C6BC;
	Wed, 29 Nov 2023 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q44/QKj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE7101E1;
	Wed, 29 Nov 2023 11:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775FAC433C7;
	Wed, 29 Nov 2023 11:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701257294;
	bh=joqrS32XswqG+vdfwGQq1R1sy9R+ce2w4Zv2Sanz8BU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Q44/QKj5gAVm7sCFTy/pO4mK/fDd6RRvG9f0HR0Gp03d/2iiEhIwoq5NrLOXV/0Fq
	 2M2+31+k3B8g4d4BwmeIB28guStAL5qoZeoO3puzzfowOb7z8JLUr5sXM2rGGZQqTJ
	 8ZrhQsPyw4TzDxf1MVQOoscZUnBJnLGIzjrsDxkF9EOUJ14XGjrT0075A72yDsnqFx
	 18O4AcegJFnx2OXAuOm52Dp6LtEk8LD3jQ3LyGyzmmy9XpRvfg0+Pic20RWGmAnQfy
	 zZdF/InDWJhigmAWvkgD1mm/kNaEFPkHtkq9sZMXpd3NSGEuqw26Dqq7GhASWNB67H
	 JIzonJ0EcqhDg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 wireless-next 9/9] wifi: ath9k: Remove unnecessary
 (void*)
 conversions
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919045226.524544-1-yunchuan@nfschina.com>
References: <20230919045226.524544-1-yunchuan@nfschina.com>
To: Wu Yunchuan <yunchuan@nfschina.com>
Cc: toke@toke.dk, afaerber@suse.de, mani@kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Wu Yunchuan <yunchuan@nfschina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170125729061.1070846.16035596415965812911.kvalo@kernel.org>
Date: Wed, 29 Nov 2023 11:28:12 +0000 (UTC)

Wu Yunchuan <yunchuan@nfschina.com> wrote:

> No need cast (void *) to (struct owl_ctx *), (struct ath_hw *),
> (struct cmd_buf *) or other types.
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d6e71dd1e49e wifi: ath9k: Remove unnecessary (void*) conversions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919045226.524544-1-yunchuan@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


