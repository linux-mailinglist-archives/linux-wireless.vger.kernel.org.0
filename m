Return-Path: <linux-wireless+bounces-4753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E187C0FA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA70C1C21013
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144007350F;
	Thu, 14 Mar 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCJW8QaW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33726FE3D
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432491; cv=none; b=mjeBQRjqr3OvEv9WA4qSSFEWS8OXA3lu7LCkG5j7KANpovQIqGhKZE2aiQX58Gh6o85c1dumXUxgRFyhvLlQvaz8LdavffLo0jy7D956NASLCbbS9MXfU+cEVBX2iDyQ8w5Bc/PB1GljPyEbyaV/caKjGx88LPPUZqIzNovcE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432491; c=relaxed/simple;
	bh=WsyEV6gDeA3xHpPD52WprrFr/fBZYtp17xNX05bGtMQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZMI35BWsG9C/l/NfNvpwxpEB9HX+i0zPV2eDhGjKfUOh2awsv1ZmA58Li6+Ppc8575MOggeD0bhTwl91MpFtvEvC9l8wLSiBAa3bncPLxkqNHRBlXpvMJsncPZu96jdjcywYYTzkL9HoC1Dw7y9jaAi7sXaouZKyDBKZslFEytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCJW8QaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F06BC433C7;
	Thu, 14 Mar 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710432490;
	bh=WsyEV6gDeA3xHpPD52WprrFr/fBZYtp17xNX05bGtMQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aCJW8QaWjfycEKtLdynk0qYQ16q449zRW/x2/kZP6iLqT7oSTvPjrdmpREUKyWz4X
	 6Ke4lPybdUtvnETixqMkuKWWf7j1xIDN7ZV3pXuJpg6PdXZ5igYudacWDP7blM6sBw
	 fZp9kk2T/tAIl1lZxRuutwmKQlUluOBFIxOpLzLCj4jKHYFNGitSJEM1rzZbSt7fWT
	 HparpP6mJGRvoKO2CZnnc3mQ4KkCo3C3YOcL8L34qWzPmNBp+TJyC6XBPzFG0KOCYV
	 u13GNKclin5e4u1IkdHzPqqFmv+DDWYY/UseoMdU/Ev6vQy47NstqfpfkTZDkkFULp
	 4U/2/Ue2L/CPQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Johannes Berg
 <johannes.berg@intel.com>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,
    ath12k@lists.infradead.org
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
References: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
	<20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
Date: Thu, 14 Mar 2024 18:08:07 +0200
In-Reply-To: <20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
	(Johannes Berg's message of "Thu, 14 Mar 2024 11:09:52 +0100")
Message-ID: <87bk7g4x08.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+ ath12k

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> MLO ended up not really fully stable yet, we want to make
> sure it works well with the ecosystem before enabling it.
> Thus, remove the flag, but set WIPHY_FLAG_DISABLE_WEXT so
> we don't get wireless extensions back until we enable MLO
> for this hardware.
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> index 1935630d3def..69227954e281 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -360,7 +360,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
>  	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
>  	    !iwlwifi_mod_params.disable_11ax &&
>  	    !iwlwifi_mod_params.disable_11be)
> -		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
> +		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;

I think we should add the same for ath12k, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

