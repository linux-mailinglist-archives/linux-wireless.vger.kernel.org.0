Return-Path: <linux-wireless+bounces-21502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB87A87BF2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 11:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40E17A3CF8
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409C825F96B;
	Mon, 14 Apr 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YTGl/SBg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D925A2BE
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623233; cv=none; b=fSLOFKA8TUuFDA4dnPLcYCUXV07Qwnnl2+t5OWW6+hc/EqcASTAEMCfebh/O/gIDVuWBD2ooFzBD+ZkpXuf8QWbyef+781L+PmTrYm5zC+92v7FV27BR5U5Cv5XB10mM7EUfv2Tcof8Mza1b6A68DIWHRTSbY1cnKrqMqyQXLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623233; c=relaxed/simple;
	bh=hSfiJO2SBbJcsGG+JV5wThJUsV2C6aLqJFuOykcCQL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmZlNZVo0eCNorpjzro5XmNCuAobCF5hwmZtbP0QgLyYtouUmkUh3UT7+FgoHUwC+k0T0HbpkDVtp7Qz70ngHxFFllSggIH59zCdcKIYhRTlIVSk2skRjpYo2ESW8gBYvz6/OWwrQBq910gx1EvZHFt6vH5lTAblrkoo/oms1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YTGl/SBg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72b82c8230aso1103545a34.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744623230; x=1745228030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6uB/gkWnDoGv7cmF5SStQjgivtiDOmfottp0OLL+PDc=;
        b=YTGl/SBg9IE579tAr0Jz7f1M+oNPNEtI7JGU9cJqCXPfqpH7yYtXJLj398W9kNPW+l
         frq3Ueu8ap1otdMJoT8kDjl2OUyG1J6dJVSgBipB1MiVp1pkRsLe8wZlpkpj1vloDorM
         hhkaAq+lDkEFR73X3c0Rl7EOBS2gCMUPpgpfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744623230; x=1745228030;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uB/gkWnDoGv7cmF5SStQjgivtiDOmfottp0OLL+PDc=;
        b=ZnGiezRNYZ34gFicZG9EftDoCUDsXue75hepXMjZOY6wNqtFZa7OZ0CA82aN6stY1Z
         p1h7t2e1ivN70QEzE+QZme7154aPq/kXuCEJo8XuuOzuCC7zU3N4jFMple90krO0Tord
         1W7qizDetkUNZ9pyEr7AnZrpKTKuTU0Y+8iEA1NWSzmx2c1SoH0Lvop/chCqBX8KM/eg
         jAGWnY6AGgUNG0u4NLAK0XS6umtYBugz71n1tdVre5UAGz6bP1XsfELSbJqSsMdJx/7r
         1AnH3DMJvEO9bGTA2Od4U7Wi8c1YrYigmrz9MDvXeOM9W3jUC7fH072aWhEUJ+EG0gD2
         hhGw==
X-Gm-Message-State: AOJu0Yy+/ckGIzi/LfETeZ/fadjRxUWxZEx5TAySAieoyABJXxt81JHV
	0F/uuB8VO1Edv7spteVrr4owR/YEZ0RqUJXhMstbqAjRulOrm829N3ItWU3xNVOA1KIaMMuiD06
	PoQ==
X-Gm-Gg: ASbGncsWlmSxTtpw7pAVEv3qrm9+Ntgsfr9/2RXz2wuozysxj1axKsHudLPQvpZWdtL
	20+ND+27gJE7OYr6MYZOMC0n6/KxoV/+H4DYJ2kOLfE6ATcLrvFtL/IGU20vcZ9AtlqhahxdJm7
	4tco6O5P+yXEliMlS3L9nBJ9xbiwAKYm/lreLb/Q+uJs5cuVhQoT839X8wPtA3Btgant9g6L6lt
	KBQXLg4clJS6qSkECgS42VJhFd6BVcFX1qnT8SELhec+p3doojkI1RtUAfk/uqBM+o5LWdXWovv
	UQg2+3pXOCpQY2eXIVOipvRxzE+PPlP9pCCq+GY+9JviJaIUSYoAeQUfW+g+urgAmLkjxcDlc4J
	5eg==
X-Google-Smtp-Source: AGHT+IGTbz8KVN8+3RpkEJt9eIMdTHZyKpOaL4Gz3mnJCmMnQY9u2JUEzMQsicf20hIjl2mwvGwYBA==
X-Received: by 2002:a05:6808:1528:b0:3f4:1c2:874a with SMTP id 5614622812f47-400850d59f7mr5665726b6e.24.1744623229743;
        Mon, 14 Apr 2025 02:33:49 -0700 (PDT)
Received: from [10.176.68.80] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40076282c6fsm1821345b6e.1.2025.04.14.02.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 02:33:48 -0700 (PDT)
Message-ID: <c7d7dd56-0aec-4808-a814-76995ea90916@broadcom.com>
Date: Mon, 14 Apr 2025 11:33:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brcm80211: fmac: Add error check for
 brcmf_usb_dlneeded()
To: Wentao Liang <vulab@iscas.ac.cn>, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20250414022853.1795-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250414022853.1795-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/2025 4:28 AM, Wentao Liang wrote:
> The function brcmf_usb_dlneeded() calls the function brcmf_usb_dl_cmd()
> but dose not check its return value. Though there is an error log in the
> brcmf_usb_dl_cmd(), it is not clear enough to describe the error state.
> 
> Add error handling in brcmf_usb_dlneeded() to log the error message if
> the brcmf_usb_dl_cmd() fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Remove redundant bailing out code.
> 
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 2821c27f317e..8e2b41cfe5cf 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -790,6 +790,7 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
>   {
>   	struct bootrom_id_le id;
>   	u32 chipid, chiprev;
> +	int err;
>   
>   	brcmf_dbg(USB, "Enter\n");
>   
> @@ -798,7 +799,9 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
>   
>   	/* Check if firmware downloaded already by querying runtime ID */
>   	id.chip = cpu_to_le32(0xDEAD);
> -	brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> +	err = brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> +	if (err)
> +		brcmf_err("DL_GETVER failed: err=%d\n", err);

Please move printing the error message inside brcmf_usb_dl_cmd() as I 
mentioned before. That way we also get an error message for all DL_* 
commands like DL_START (which came up in another patch).

Regards,
Arend

