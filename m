Return-Path: <linux-wireless+bounces-26190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED6AB1CEE0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 00:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D30C18C65AD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04491207A18;
	Wed,  6 Aug 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSqyx08p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F101993B7;
	Wed,  6 Aug 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517707; cv=none; b=HrzbzY9s+1QBeJ7FYtSeSluK6TuyISghI/pZ4+uDYiw0zOkkyBb8lnWwaEFXGmSQq3Mz6GM+SwzTM0ZHWSvSOg4hUo1h7DXCwJBtFlqzVhXyho5wwYCp5UtNixcC/sRubem8TAWQ2i07PjoNpVpirIMehNVfHain7SRan8NgTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517707; c=relaxed/simple;
	bh=bqEANgtVHYBiWJjODjg0b94/tXX3NxqIOs4Fyw6rZzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxjImagtLatRg5mNuaRQvb6DR6YgE3JiqFTcFoeCXjwiUee56rkr/hR0BXwuidzS2M3Jp1NcxHwwVn+3xw61zMQbYMnp2Q9a6JNEoJi9QY3JyxwCb6FmTRXBLi1h5tjW3ubteK3dxsmCRcpzud4zsR86niWI8+VbmdGwiP9V4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSqyx08p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979C1C4CEE7;
	Wed,  6 Aug 2025 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754517707;
	bh=bqEANgtVHYBiWJjODjg0b94/tXX3NxqIOs4Fyw6rZzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSqyx08pXFpAV3mzDXwjaIlC3y0oohzuhT7jWxi36v0iN2oeqy6Hn7Ibgzwl/FAla
	 UYQxAdUd79P/uYX0Qi8q7rNAQtWW4eBYuTzUQfhnOk+gKS7UwWeH1iGNcU6Dtk7Shd
	 D9ipMkh9yytIJ4lG1MelnfjVj9A+rwMQk5zoMUpWpwkHs4mE7xrPXuqaIWiP7sJ1wZ
	 VrS6jXjV6/6NQgHTXe8yWBum/ntosaeAa2CInDIUK3G+pdVD1gHZtajVm16UyrMLlC
	 xA7E8VvMQOGm9lJihku7YvY3ZF/OEvoaMpLbBDVkvYoZn1iK2eAuIXWklHDj1tDZc4
	 DJHcwqpgusOhQ==
Date: Wed, 6 Aug 2025 15:01:45 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Dikshita Agarwal <quic_dikshita@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: qcom: mdt_loader: Fix check
 mdt_header_valid()
Message-ID: <wgpgwf2yq4awig5cztgkgm32h6zjtqzv4irpxd277gwjydofzu@f3zb6t4iyahc>
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>

On Wed, Aug 06, 2025 at 10:55:28PM +0530, Mukesh Ojha wrote:
> Firmware binaries may lack section headers, in which case
> the e_shentsize field in the ELF header can be zero.
> 
> Update mdt_header_valid() to correctly handle this scenario
> by adjusting the validation logic accordingly.
> 

As I replied earlier today on v1 (probably after you sent this), I've
applied the patch I sent out earlier for this problem.

Thanks,
Bjorn

> Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
> Changes in v2:
> - Make this patch as first patch of the series.
> - Added R-b tag
> 
>  drivers/soc/qcom/mdt_loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 0ca268bdf1f8..2a14ba9b0fb6 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -39,7 +39,7 @@ static bool mdt_header_valid(const struct firmware *fw)
>  	if (phend > fw->size)
>  		return false;
>  
> -	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
> +	if (ehdr->e_shentsize && ehdr->e_shentsize != sizeof(struct elf32_shdr))
>  		return false;
>  
>  	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
> -- 
> 2.50.1
> 

