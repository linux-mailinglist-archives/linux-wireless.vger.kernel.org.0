Return-Path: <linux-wireless+bounces-6769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131068B09BF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459AF1C240CA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AB2F52;
	Wed, 24 Apr 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hYguyXVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688871E528
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961949; cv=none; b=hu7ioS80MCCfB+Q+mgDzdOE+Zsx9i/bSSXjd5htgD2GFNzWhd81YCcxw0nFFD8LgWy8h2GnMVkUJJUL281Ud9d08eTmOk7wUliNSttlsAdGpq5qVRbfbxF+FAgGrzt38rQ5SOpIBbOs6OiXfmBS1FFrcM7CV2FYXRh6NTgKRy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961949; c=relaxed/simple;
	bh=LYEsWdL4GUnssBeOlDMCbFKVyTLdGrPhv3ZaXpKqbPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjIlekWp0qq1pSGu9B32BWFLuHAzcDAMDgljzSrS7yiW0L3M+PkeZ3fEZkUWU/FFJYutSNdlnmjP/RSeqIjtnj2EPO7YQilL2dnpVqn4Avj51sfC2fiBvF8sMEMqD7b7ZY+lRiRJ068kiVSW30kgQctKi7l2GaT1iPkQ38Y74l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hYguyXVC; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VPdWr2bjzz9spZ;
	Wed, 24 Apr 2024 14:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1713961592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocen2Pswahg44tyFdWzmonpZBfzUoCyyDptpctSisNc=;
	b=hYguyXVCMkevSlAI9zbuEYJT2RyA0TslxzTC/flPcZWcuUbMEJW+Sbav34bYwafr48j2FL
	WV7Al0nutqKdqxtqpZsQGxybVM2AKP/9XdL5oB+TYtUQZ2gY0IYhoEU8Rfq/Isz+fS/bYT
	FAJouDEMKWkj3htU0N2WccqnkPo8P6duFdbz/OMiMGPEAS76L2zrPmvs+qu+CkKDiqKrBu
	agb/NaO03WJw8bFTFI8Bxdu4ueBNAa0e8mbw03U8syOESqcvcAB9R5BWSgU/g0pgLuBJOB
	BPqye9UkYW//N4UsOHPUoJkQGZo2YyKB2F+sDMW547VUH00Jpqai7CMkWodS0g==
Message-ID: <d13260ee-e9f5-49fc-b8ea-78c9424c460e@mailbox.org>
Date: Wed, 24 Apr 2024 14:26:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: iwlwifi: mvm: fix link ID management
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240420154435.dce72db5d5e3.Ic40b454b24f1c7b380a1eedf67455d9cf2f58541@changeid>
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <20240420154435.dce72db5d5e3.Ic40b454b24f1c7b380a1eedf67455d9cf2f58541@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7em8th45ys7abjod6ifj95tzcnfndoqi
X-MBO-RS-ID: f0c7217f281fdc8d27e



On 4/20/24 15:44, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On older (pre-MLD API) devices, we started also calling
> iwl_mvm_set_link_mapping()/iwl_mvm_unset_link_mapping(),
> but of course not also iwl_mvm_remove_link(). Since the
> link ID was only released in iwl_mvm_remove_link() this
> causes us to run out of FW link IDs very quickly. Fix
> it by releasing the link ID correctly.
> 
> Fixes: a8b5d4809b50 ("wifi: iwlwifi: mvm: Configure the link mapping for non-MLD FW")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   drivers/net/wireless/intel/iwlwifi/mvm/link.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
> index 9f69e04594e4..fe5bba8561d0 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
> @@ -279,6 +279,7 @@ int iwl_mvm_unset_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
>   
>   	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
>   			 NULL);
> +	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
>   	return 0;
>   }
>   
> @@ -296,7 +297,6 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
>   		return 0;
>   
>   	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
> -	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
>   	link_info->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
>   	cmd.spec_link_id = link_conf->link_id;
>   	cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);


Hi,

this patch fixes the issue on my old ThinkPad with

   Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)

Tested-by: Tor Vic <torvic9@mailbox.org>

