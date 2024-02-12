Return-Path: <linux-wireless+bounces-3431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD31850DFB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 08:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBA9283E62
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 07:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2E7468;
	Mon, 12 Feb 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs4VKluQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3217462
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722758; cv=none; b=lEevzYJMtO3sbqj0ssz/+J00wdA4FFfs35rzqR64HUb8aHgq3ZU90P2GpKf9/p93XZF3l3zNMEb4k5plXr0BOKj5QuUTgrBsFRlbHkU5nX0DQFXmozzb6f9RuoTAnquwNpo9JBF194RaWvvPD7Re39HmzivAYnBAtoG4/8+zOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722758; c=relaxed/simple;
	bh=hOnROUj77Gg4Hp/kDGdJmg1vFWWdhF0uAEGfH7prDt8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aBBiYYR4YzclmwRjxl2FEoj+TWbzs7K8CfklENTkb7LLXpSblSNvG5tvhSNZW/lFVSfhfaSnQNjM0tW5p3RQuK5kUbUuuRsTGUMfRO1zh+xl+Zq8Cxz4QSp0ghFJVYkeejl/4jwxDQIjDzqwYUA7omiY8uSsazjHS0H156gdruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs4VKluQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A34C433F1;
	Mon, 12 Feb 2024 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722757;
	bh=hOnROUj77Gg4Hp/kDGdJmg1vFWWdhF0uAEGfH7prDt8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cs4VKluQv2VfmHJ2Nb1VWtyjTtf7ajETWLpEFLXBjbGPyFW9p78DyMLvnnKHsp8G8
	 90gbHng9PR8a7rRksNBRhfKx1ylXt2yHY3sqlU1ahg3ORqUhgAAaRoH3SXMXVGlhEM
	 qQtV6anJVn4La3XvuqEf1xKV/9YlT0eJkV6QmMGy1CDzVP9rIeWuJWG6A0nY8kjgIF
	 FO3PdewzhzAeN9YgvnAtELHIacO6ADT/A6e5pUG1HP4xQkW+p08+A/imOeMGBQUYM7
	 m3dP6gcpsumdTjjMnQFby5GwW87Tc2iv2AQ/2gRmpqKEA4coHjflr1DMmt1EWplESE
	 hCfzH1Ac1r9lA==
From: Kalle Valo <kvalo@kernel.org>
To: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,
  jithu.jance@broadcom.com
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
Date: Mon, 12 Feb 2024 09:25:54 +0200
In-Reply-To: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	(Vinayak Yadawad's message of "Fri, 9 Feb 2024 19:20:43 +0530")
Message-ID: <87mss6f8jh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vinayak Yadawad <vinayak.yadawad@broadcom.com> writes:

> In case of SAE authentication offload, the driver would need
> the info of SAE DH groups for both STA connection and soft AP.
> In the current change we update the SAE DH group support info
> to driver in the order/priority as provided by the supplicant/
> upper layer.
>
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>

[...]

> @@ -1235,6 +1236,9 @@ struct survey_info {
>   *
>   *	NL80211_SAE_PWE_BOTH
>   *	  Allow either hunting-and-pecking loop or hash-to-element
> + *
> + * @sae_dh_groups: SAE DH groups in preference order.
> + * @n_sae_dhd_groups: No of SAE DH groups assigned.
>   */
>  struct cfg80211_crypto_settings {
>  	u32 wpa_versions;
> @@ -1252,6 +1256,8 @@ struct cfg80211_crypto_settings {
>  	const u8 *sae_pwd;
>  	u8 sae_pwd_len;
>  	enum nl80211_sae_pwe_mechanism sae_pwe;
> +	u32 sae_dh_groups[CFG80211_MAX_NUM_SAE_DH_GROUPS];
> +	u8 n_sae_dh_groups;
>  };

What driver is going to use these new crypto settings? Or is this for an
out-of-tree driver?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

