Return-Path: <linux-wireless+bounces-3490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F1852269
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB7E1C220B6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 23:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256624F5EA;
	Mon, 12 Feb 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="M1KZI0CE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DE47A53
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780437; cv=none; b=JQ7n5Lc8RDg0HQIaoeCKwuusJQSY+Um5wBnvVZmx//mwzO5/QoDaiIBqsezmh6xQMGQJklpI4UIOS1vUGAn+yVkY2GxAP/1QO50YANE+UlcITyvQfFV0oqcd2fPXRmSC2RSMFMze6m7pjCs8pVJNMobNiEpeqY+IDZJ+dmSO6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780437; c=relaxed/simple;
	bh=TxyCEuik1ztWi3prf2zOhMCf3maEHyPf/Khf5n1Gz8A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tJB6wE4t0iJ5nZw04D2JaCyEaEtYIG8RR6f5NjXqpw1i2R7KGMriIAefCT2c8T0URPPlRVxCcdNTcklsK7bTPHeJOeXjnaUvrZiuBlda+XEl1Fp5VgLVAeveTAgHv4LFFB2EH4X5S6LYKccWEw3cFgzFe/8CrfslRctVay17vvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=M1KZI0CE; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F2F8894007F
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 23:27:12 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 574CF13C2B0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 15:27:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 574CF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1707780432;
	bh=TxyCEuik1ztWi3prf2zOhMCf3maEHyPf/Khf5n1Gz8A=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=M1KZI0CESLy+UmlWCmywxUNtl3VCWubKaSmG2+Kc0PseHMmcpp63sY9bfoJDful+c
	 mOibIWNnUYVA2VpE0Rl15Ol8nHUeGyYmozebFw3XpMUNNE5s5Fc+6yOoWoVw+1uqJg
	 f5cviGh4sIWNz0CDKoFSrRkndJ7oK+/1bHjhcEuQ=
Message-ID: <ad6ae6b9-2ce1-e354-a151-98c3b33fd139@candelatech.com>
Date: Mon, 12 Feb 2024 15:27:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi RFC related to iwl_mvm_tx_reclaim
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
References: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1707780433-OpEaDhx5YZ6Z
X-MDID-O:
 us5;at1;1707780433;OpEaDhx5YZ6Z;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

On 2/12/24 15:22, Ben Greear wrote:
> Hello,
> 
> I'm seeing a crash due to accessing an 'sta' object in this method that is '-2' as integer.
> 
> It fails the initial check for null STA, but I'm thinking it might should check for IS_ERR(sta)
> as well.
> 
> (I have my own patch that references sta before the IS_ERR check later in the code, and this
> causes the crash I'm seeing.  I guess upstream will not crash in this situation.).
> 
> My question:  Is the patch below a preferred approach, or should I add special checks to where I
> access sta and only exit the method lower where it already has the IS_ERR(sta) check?
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> index 0567f4eefebc..bd3d2fe424cd 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> @@ -2337,7 +2337,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
>          sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
> 
>          /* Reclaiming frames for a station that has been deleted ? */
> -       if (WARN_ON_ONCE(!sta)) {
> +       if (IS_ERR(sta) || !sta) {
>                  rcu_read_unlock();
>                  return;
>          }

Or another idea came to mind:  Should this check above go away entirely, and check for null
down where it currently checks IS_ERR()?  From the comment about the IS_ERR check, I am thinking
that might be a better idea...

Thanks,
Ben

> 
> Thanks,
> Ben
> 


