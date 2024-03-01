Return-Path: <linux-wireless+bounces-4290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54586DCA4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 09:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7855D2825E6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7169D09;
	Fri,  1 Mar 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYXOROii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A367E6C;
	Fri,  1 Mar 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280083; cv=none; b=iEU6uWdnG4KLFdlf6q7nOEQV5EBILtazLZTe/SgWv8D+Z5a+M/0msBQV4raoQK1mVdCaS++Xe0wPXdBCVDIllpm7LARlS/jdx22F+lFNj3HLRxtNU5DFHTrO5niak1hiIJ12WYRKbLxUi1vBGQCyrxX56s2Gf/BCm7c6lnd48MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280083; c=relaxed/simple;
	bh=jMRWjjBb3WoG96heiGE+SbBHlPWqedM9ZSLpfueiMU8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WxwVmu/dG9MKnzTmMBt4fBd+39N6m7SVf1bsD5FBZ2N0RMuLDlEvpNFaBdYHT45gY3PihYDMSx1hKlbIbcR6hPWjo34Xz71rXVv+Lm4aCQEd1oR3xvIU9GweDZc9qaDlljAS7YPRkmcDvRGi7R0UPWNqWGOoBM3v78D8L++06TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYXOROii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06746C433C7;
	Fri,  1 Mar 2024 08:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709280082;
	bh=jMRWjjBb3WoG96heiGE+SbBHlPWqedM9ZSLpfueiMU8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NYXOROiiPwwVhYxx1fbNDxcpy1ncuwsxP3IJmfH3QY4e9lqXC5mcmHEFwLekftNje
	 HdPvpXFl6MuYkRR+Dfj6GtbgTEKlYB9UH3l/RbRuSX/0okn+jTeVDtHyODc8LX/3Gd
	 AMQelHir1f7Nh0yNghqmyI1UhM6pXRNUEqQPlumhjtthx8wh8D2LDcu0etWNaUhNnc
	 h/PYPpr43thxVRBRjuPZ0DgbPuDlNfDGqOdclU4s6Ikxm3oOULyAMLohqdtohzALz/
	 Yjb8O3lflw7vPwKeej6m09O5t2iFHNoHj8yLsi6swrrIwx6xZXLk/NUgtli0Yob3zp
	 GbGLT+UfGyS7A==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] wifi: ath10k: support board-specific firmware
 overrides
References: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
	<20240130-wcn3990-firmware-path-v1-2-826b93202964@linaro.org>
Date: Fri, 01 Mar 2024 10:01:17 +0200
In-Reply-To: <20240130-wcn3990-firmware-path-v1-2-826b93202964@linaro.org>
	(Dmitry Baryshkov's message of "Tue, 30 Jan 2024 18:38:38 +0200")
Message-ID: <87h6hq8joy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> Different Qualcomm platforms using WCN3990 WiFI chip use SoC-specific
> firmware versions with different features. For example firmware for
> SDM845 doesn't use single-chan-info-per-channel feature, while firmware
> for QRB2210 / QRB4210 requires that feature. Allow board DT files to
> override the subdir of the fw dir used to lookup the firmware-N.bin file
> decribing corresponding WiFi firmware.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Sorry for the delay, too many drivers... But this looks good to me, few
small comments.

In the commit message it would it would be good to have an example of
the new firmware path. And also mention that board file (board-2.bin)
handling is not affected, at least that's how understood from reading
the code.

> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -942,11 +942,20 @@ static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
>  	if (dir == NULL)
>  		dir = ".";
>  
> +	if (ar->board_name) {
> +		snprintf(filename, sizeof(filename), "%s/%s/%s",
> +			 dir, ar->board_name, file);
> +		ret = firmware_request_nowarn(&fw, filename, ar->dev);
> +		ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
> +			   filename, ret);
> +		if (!ret)
> +			return fw;
> +	}

So here you test if ar->board_name is NULL.

> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1337,6 +1337,9 @@ static void ath10k_snoc_quirks_init(struct ath10k *ar)
>  	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
>  	struct device *dev = &ar_snoc->dev->dev;
>  
> +	/* ignore errors, default to empty string */
> +	of_property_read_string(dev->of_node, "firmware-name", &ar->board_name);

What do you mean with empty string in this case, "\n" (with length of 1)
or NULL? Should we also test for strlen(0) in ath10k_fetch_fw_file()?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

