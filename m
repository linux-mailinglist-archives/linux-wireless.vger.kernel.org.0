Return-Path: <linux-wireless+bounces-24406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8EDAE5D69
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2116B1B67667
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909D335BA;
	Tue, 24 Jun 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="LUoJH1BV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA27462
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748864; cv=none; b=O7C+tGVFvUBvjvZD8rbtz6iVTt44I2imBu3NqJWO7l+AVxDKqUZvtjZLxLS4nuCdBrzuMwzIKRpkHD+1P5FjxZE3CjONcYSnVNH4ze2+E+3zulqCOYzuwjXmWkkP6bSuw3pJSv7n/8Y5DzoYs8uCvaNhQ26gORIyH4qcdcZGcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748864; c=relaxed/simple;
	bh=zn0+28QSwM99HZPgBoeBgrkOO34qwHN4nmccAgiDlpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hqr0jaAok3ORL1hOwdlqyynxC8UATl+pwEExIjjp1Zfku2NpAFp0VMEsFC9V/UmuNH6LKzeusL0GrvKPGJ0F7IsCNiSwckkmnJstxy0L95XfxAQOsmRlbd4j1G//aHpvwDGcXvKrNZywEsHHhdbx0/Xq2+YDPAHFSD/ARkPlV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=LUoJH1BV; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D6D3283F94;
	Tue, 24 Jun 2025 09:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1750748859; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JG5XBsRIe/hdPT8na/1Iyan+X7DIJOCHIM0KmdvhdQk=;
	b=LUoJH1BV9it3RA/dtBzdaziGBNGkrcUEXbwIZWvhxNWl8HUCCDG69SS8qd4w5/rjMEsLAc
	BiLZywSN7g7Tc7MYK25f/Mk1LDPSeAnnnuOzgj6AwUaek7aiboFAI7wPWXyOYtBRtcWDLV
	HoWVknRsm3Jr44Zm+SLvA7pYZX8Tsk0qXDY/ntWMA8T4kF9+TIO44Tl1YORwjeBqenNHgz
	o2Ah5NIR1/ddMi3sxkFaqx1m7sI0DWkqvBiKgLh/38a1IM7i4+ppr4JWABJSmyo4g9mwaN
	vli+Vm6r5HgT6VUszIE8HvS2JlA9/lMCddZQtz5q+yR5k3Do+tJ9UN0ZfbRT7g==
Message-ID: <d52fae5e-b543-4a13-acbb-114b95bed50a@cachyos.org>
Date: Tue, 24 Jun 2025 14:07:28 +0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwlwifi-fixes v3] wifi: iwlwifi: mvm: assume '1' as the
 default mac_config_cmd version
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org
References: <20250624063503.2628269-1-miriam.rachel.korenblit@intel.com>
Content-Language: en-US
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <20250624063503.2628269-1-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Miri,

On 6/24/25 13:35, Miri Korenblit wrote:
> Unfortunately, FWs of some devices don't have the version of the
> iwl_mac_config_cmd defined in the TLVs. We send 0 as the 'def argument
> to  iwl_fw_lookup_cmd_ver, so for such FWs, the return value will be 0,
> leading to a warning, and to not sending the command.
> 
> Fix this by assuming that the default version is 1.
> 
> Fixes: df6146a0296e ("wifi: iwlwifi: Add a new version for mac config command")
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Should the fixes tag be for 83f3ac2848b4 instead since that is the commit that introduced breakage without this commit. See: https://lore.kernel.org/1b3f2387-e27f-4b74-99b7-0596a9331a1e@cachyos.org/

-- 
Regards,
  Eric

> ---
> v2: removed the check if the ver is smaller than 1, as it can't happen
> now.
> v3: added a Fixes tag
> 
>  drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
> index 3c255ae916c8..3f8b840871d3 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
> @@ -32,9 +32,9 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
>  	unsigned int link_id;
>  	int cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
>  					    WIDE_ID(MAC_CONF_GROUP,
> -						    MAC_CONFIG_CMD), 0);
> +						    MAC_CONFIG_CMD), 1);
>  
> -	if (WARN_ON(cmd_ver < 1 || cmd_ver > 3))
> +	if (WARN_ON(cmd_ver > 3))
>  		return;
>  
>  	cmd->id_and_color = cpu_to_le32(mvmvif->id);

