Return-Path: <linux-wireless+bounces-12017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A396019A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E56F1C20DAD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 06:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4B14B06A;
	Tue, 27 Aug 2024 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7SCRrUw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A845146596;
	Tue, 27 Aug 2024 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740007; cv=none; b=GI10kAeiGKg7X86tcyZUNHA2hHGPivJUcMMKiA+e15EzdHwh3ZxltW8yQqCZ7KQWbdZ1TxDpBdcbzNCerDN1AK0LfARBTxzW9S5ZQD9NdA2UEjod+pdSqwH+mRS7KpoBdzsZsQN7zkXbSZXq3fv3PiQnEx+nv1TGof8JTIM+YtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740007; c=relaxed/simple;
	bh=jNfRUmdqKJgP/Ct4LLn/ZaSO+4IPIoj6zIdHnKM2eBQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aCpPeH/6WUT1kXfO48UUV5X/O6hzfFaxh+cvWCcwWZOqHPWhj4u98ay0flqYZYJcTRhB60rxFuUfUsXMVkf/b7uTBXq6B0zUsZysSCgI9pgzi7QQrCd5Dll7ToYGO4j+0Nb3DJiu/q+3ucg73NunQ3D90H11vjPI5+xij4G7s58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7SCRrUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14A7C567C7;
	Tue, 27 Aug 2024 06:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724740006;
	bh=jNfRUmdqKJgP/Ct4LLn/ZaSO+4IPIoj6zIdHnKM2eBQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=V7SCRrUwtwy+ws3yCqYXbc/TZBXIC3GnchjIHOT4mt7m7WB5wYmh8rqFXxMMJcHUo
	 RdL/xtlWBnh2vwOvNBTK/aYEgXB3wvo+zqmk5DVwRlSNh4CKe0V8uD3WiD/PjCvJep
	 oCHnEE50DJQH+gi+6CulY6RqgL4QFL6dUL61gGYUketYHEuEeXSzjvUn/yWGRviD4u
	 XiJjTWzm10pUs2ux9MUvzrl4josuGzu9Yj7bQxRwGPxjMY8kuONAFeSxC+SctT3iYq
	 KbfQkJaFSeBcOAwXiHoGNTFVp9bpB91u6zD2CKn10FtKl4NqfjMeGw6/C7T9IobWx4
	 AQc6CqLgTARcA==
From: Kalle Valo <kvalo@kernel.org>
To: David Wang <00107082@163.com>
Cc: miriam.rachel.korenblit@intel.com,  johannes.berg@intel.com,
  gregory.greenman@intel.com,  pagadala.yesu.anjaneyulu@intel.com,
  dan.carpenter@linaro.org,  daniel.gabay@intel.com,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: acpi/dsm: cache error retcode for
 iwl_acpi_get_dsm
References: <20240827005114.4950-1-00107082@163.com>
Date: Tue, 27 Aug 2024 09:26:42 +0300
In-Reply-To: <20240827005114.4950-1-00107082@163.com> (David Wang's message of
	"Tue, 27 Aug 2024 08:51:14 +0800")
Message-ID: <871q2afplp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Wang <00107082@163.com> writes:

> On some HW, acpi _DSM query would failed for iwlwifi device
> and everytime when network is reactiaved (boot,
> suspend/resume, manually restart network, etc.),
> bunch of kernel warning shows up together:
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
> since iwlwifi would make 8 acpi/dsm queries for lari config.
> But for iwlwifi, it is safe to cache the _DSM errors,
> since it is not possible to correct it without upgrading BIOS.
> With this patch, those kernel warnings would only show up once when
> booting the system and unnecessary acpi/dsm queries are avoid.
>
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> index 79774c8c7ff4..3f98f522daac 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> @@ -30,6 +30,8 @@ static const size_t acpi_dsm_size[DSM_FUNC_NUM_FUNCS] = {
>  	[DSM_FUNC_ENABLE_11BE] =		sizeof(u32),
>  };
>  
> +static int acpi_dsm_func_retcode[DSM_FUNC_NUM_FUNCS] = {0};
> +
>  static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
>  			       acpi_handle *ret_handle)
>  {
> @@ -169,6 +171,10 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
>  	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size)))
>  		return -EINVAL;
>  
> +	/* If HW return an error once, do not bother try again. */
> +	if (acpi_dsm_func_retcode[func])
> +		return acpi_dsm_func_retcode[func];

Static variables are usually avoided because they are problematic if
there are multiple iwlwifi devices on the same host. Should the error
message be just removed entirely?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

