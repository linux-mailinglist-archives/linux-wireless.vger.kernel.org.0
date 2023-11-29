Return-Path: <linux-wireless+bounces-211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5FB7FD595
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F86B214F6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C3C1C696;
	Wed, 29 Nov 2023 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETzaw47H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B41C2A3
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 11:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786F8C433C8;
	Wed, 29 Nov 2023 11:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701257134;
	bh=F+9v9LLNj1awnfWNnJpo+JkTxdVjKF3UpuwF3iKr6Z8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ETzaw47H0DbLolrD92bF+kOP0Fift7mPmFTXj2UJ0YBu1kR3lfuwbrehZLge0Fo7O
	 HZEPBOQr+AXjwPlwZEE/HkLsAH0Xc+CEfuB8EzY/40CebWrm4yJXbNWfMyE7u4zLnV
	 w2ariTLoKMc3nf8ZtGLChM4OPvkudMVOIaIdATZMIsP6rQVK3Xy9sJk5iti3RjwpT0
	 RLTm+3l1WXunbR3toND7NY5dgyJCuU/CVsQTF4M3LfoB+BwhegfxOGrdGwJAbc3xTD
	 CWi8v0hgqj+u/2snlbdSnJm22ogKZmVxjEftY5xQG+D1Did9gUVYrqdOKr5fNhAS17
	 FENHDCZViCWCw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231113153544.282461-1-prestwoj@gmail.com>
References: <20231113153544.282461-1-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org, James Prestwood <prestwoj@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170125713119.1070846.1984574884804716810.kvalo@kernel.org>
Date: Wed, 29 Nov 2023 11:25:33 +0000 (UTC)

James Prestwood <prestwoj@gmail.com> wrote:

> Let ath11k select this option automatically which makes building
> more intuitive if the user enables this driver (rather than the
> driver not building unless CRYPTO_MICHAEL_MIC is explicitly enabled).
> 
> Further investigation shows that ath11k and ath12k are the only who use
> 'depends on' with CRYPTO_MICHAEL_MIC:
> 
> ./drivers/net/wireless/intel/ipw2x00/Kconfig:   select CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/intersil/hostap/Kconfig: select CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/intersil/orinoco/Kconfig:        select CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/ath/ath11k/Kconfig:      depends on CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/ath/ath12k/Kconfig:      depends on CRYPTO_MICHAEL_MIC
> ./drivers/staging/rtl8192e/Kconfig:     select CRYPTO_MICHAEL_MIC
> ./drivers/staging/ks7010/Kconfig:       select CRYPTO_MICHAEL_MIC
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

a466027abe4a wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
c7b4f54112e1 wifi: ath12k: use select for CRYPTO_MICHAEL_MIC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231113153544.282461-1-prestwoj@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


