Return-Path: <linux-wireless+bounces-16333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130409EFC7F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608241890ACD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13530188713;
	Thu, 12 Dec 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="T8rLBdjb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E1168497
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031768; cv=none; b=tY4K9friWeJhU9qaUbrAWb+Q+8Jd+kxznQMV6oORuXqBW0ZPkXcIYYt3UIVzVanNlG72Ko04KfeL5iorhT3ChP4Y/Ar1Z3UwAUc4AOaGkZsutzwcLl6W5NekayNXw4tYndvxv5GUa2Sq3WacerJs6P2hfKF0A0CCQz0AEb/UQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031768; c=relaxed/simple;
	bh=EccZC2QhZtm+bhoIax/bOFa7puOom5YIzC1+XYEgQJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oVwGVmEcvor5K65X/Yl3sTuOhH/yN8mhHEHEq7KLHy+Vn/7u/OlshBNgmP5NLdKW6Xy+iuIa88jRyZZxhh2PQkM/USRxxHbJDE/SXfF6j5wc1aTpeCppM8YsnI0aYfh/5sV7R4O95yX+YSxATGMbWiQapGrkYMlQSL/VpuJAwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=T8rLBdjb; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C5394A800AD
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 19:29:23 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 640ED13C2B0
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 11:29:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 640ED13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734031762;
	bh=EccZC2QhZtm+bhoIax/bOFa7puOom5YIzC1+XYEgQJY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=T8rLBdjbhc4bQo7Km4zSkoz/Gj6e5W2ZpcwfeqIXmQUGD47dBTZ68EqardlXkQ1vy
	 zJtSAVLLGSEobMXA3WAvH8bYTAETuzLzLpU/94c/++VnK5qiHVC0M/osG5QvJzHRFr
	 O65E+Mdz3gNoOaCmTaCXBGxErWhrye2IP0yQlSxo=
Message-ID: <0b0af4eb-855c-8c01-71e3-c4d18b6b3d61@candelatech.com>
Date: Thu, 12 Dec 2024 11:29:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: iwlwifi: Fix survey dump for be200 radios.
Content-Language: en-US
To: linux-wireless@vger.kernel.org
References: <20241212044522.922351-1-greearb@candelatech.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20241212044522.922351-1-greearb@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1734031764-zXmPx0jAkJTy
X-MDID-O:
 us5;ut7;1734031764;zXmPx0jAkJTy;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

On 12/11/24 20:45, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> The old code did not assign channel, so survey dump was always
> empty.  Instead, return the info from the phy ctxts since we
> can at least fake out the channel busy time with that.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 +++++++++++++++++++
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++++
>   drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 18 ++++++++++++++++++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> index fb341d8e8cdb..ec01350bbb34 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -6080,6 +6080,25 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
>   
>   	memset(survey, 0, sizeof(*survey));
>   
> +	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ) {
> +		/* None of the code below this if clause appears to work
> +		 * on be200 radios, primarily because 'channel' is not assigned.
> +		 * So special case this to do something useful on be200
> +		 * radio:  Return channel and busy-time for the first 3
> +		 * phy contexts.
> +		 */

I later realized that I need to skip contexts that have zero 'ref',
so at the least that needs changing.

However, I'd like to know if there are other comments before I send
a v2...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



