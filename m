Return-Path: <linux-wireless+bounces-26185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE81B1CAD7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 19:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8667A4672
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861831F4CBE;
	Wed,  6 Aug 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNFh9BOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E801BCA07;
	Wed,  6 Aug 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501571; cv=none; b=ISuEoOpfxZ4lzcww98btAK4mJfrcUlQRDJ9ZiNBhRW9ujbrgqTdMUBRTnF3wfcix269KUnggZ3/ZRsQxcW3Ict9cAr9GC2NX9Gy6adrPcBGn7sK6ia8aPX86K/V9GNlNA9CfLnpju/u/imKTr7djA+YfWgDp2kXJiuev0pf9cDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501571; c=relaxed/simple;
	bh=UCmqwkbmo34ciLb7WfjGPXOM2nraMZwv7KO2zm6w+7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8ujKMA7ZtZS2Id4kHFwRpwexJoV2LpyD21oqucjUA126cM4v6HPqpl5g4TQDKrST6DHP8/DX7enQ0yODzVF7ppr37CM1PDccke521iORhjqfu3ZuDFP8p6CEywA9ZUv3eMxWN3aukBFNXV7lWwPrNjA0mpmoHr17zybFik7gIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNFh9BOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B936C4CEE7;
	Wed,  6 Aug 2025 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754501570;
	bh=UCmqwkbmo34ciLb7WfjGPXOM2nraMZwv7KO2zm6w+7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNFh9BOM3i71piPPEIEay1JN5rDPKJq6pR0Q29H19IoiGycKBtaRCN4XNRff3Pb+a
	 3Jxh6wsmnfTZYwHJ6BGfiKYeCgiN5z0UeE/VUmQFz2MSb2fEHiNxUmaHN+CJeC/+iR
	 wxxzz/RUVnNngBxWYds4hV3UL0ApNE3JPL8/mKLfwpjyl+GCQrJxmWNJppxCXCW9KQ
	 TGi1W16XqFpnL2mVh0dDbWrncwkYLgJkhe+6R6BuoTDzu0JssBdykDdVc5FIdiGSCS
	 gJ/r9Soe0yvjZ78emoK4LdZaHLP0X51KOu5GjJK9vBYof94XnJoz5D6bczc8T4gRJi
	 BW0ySyWSMM1Sw==
Date: Wed, 6 Aug 2025 10:32:45 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	linux-remoteproc@vger.kernel.org, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] soc: qcom: mdt_loader: Fix check mdt_header_valid()
Message-ID: <w7idutnucnkf2wodytpp6ozr4dxmm2qgjvbxsdz2pdlm4redhv@gfbtjzseonnw>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-3-5e74629a2241@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-mdtloader-changes-v1-3-5e74629a2241@oss.qualcomm.com>

On Mon, Aug 04, 2025 at 06:11:51PM +0530, Mukesh Ojha wrote:
> Firmware binaries may lack section headers, in which case
> the e_shentsize field in the ELF header can be zero.
> 
> Update mdt_header_valid() to correctly handle this scenario
> by adjusting the validation logic accordingly.
> 

Thanks for the fix, Mukesh.

I posted and now merged
https://lore.kernel.org/all/20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com/
for this.

As was mentioned, in the future, when you have a fix and some other
changes, put the fix first in the series (or send it separately when
possible) so that it can conveniently be picked up on its own by the
maintainers.

Regards,
Bjorn

> Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/mdt_loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 7522223835f5..8210fb3dd51a 100644
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
> 
> -- 
> 2.50.1
> 

