Return-Path: <linux-wireless+bounces-10131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6CF92C22F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB171C2326E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62AC17B026;
	Tue,  9 Jul 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="oUEpoqkm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB112C801
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545208; cv=none; b=kspQ6BFCVWllvJz60rpb8vtD2Ig/vdcZlrtgVGnjgo2r9hWActatRiISqw2YXiLJsMy0y5DH4QmG2em63svkNtrNDI7JANwV7SGQ+fk60cUoO+VyglTqjPLl3mDHl3k3zaM3LVmFFifLrn1Y059KBuDyOKcLMsXxpG8xvB+vUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545208; c=relaxed/simple;
	bh=EJx/yqqetD5yyeBUcvEhV8uo2kKUEDJMOUADxScKd3E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fXotk3p5LnMfPI9BwICG3mPtYN7+dLitKC1JQvLpUr00h6AJ+g2iSyBiKU75lhb/FTbub8RajqDwfyO5dTV1M8FaEgM/fHfHeVZUP1q9DmKPr0yjyPLpTMigFeE/D3Er9ASyImYhE/V7L7oVnqiAmWIdJuW8O0bxAr1oUwHkzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=oUEpoqkm; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AB643B00082
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 17:13:24 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 398DC13C2B0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 10:13:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 398DC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1720545204;
	bh=EJx/yqqetD5yyeBUcvEhV8uo2kKUEDJMOUADxScKd3E=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=oUEpoqkmvvH9vtrqv0RyVkZ6xJ95bQKyiBmH4r9sbyBy/X0lhU+Vb9H+AhyreXBdB
	 9P4wjOXxb1yE0X9+EY1SqmNjDNpLPs0azb4Y3SzG441brHutEYgkmEj+j1wHO/xoLd
	 X3sSr7HHyA7ZQ8kqA/Ucz4Jlu58zZ5BSj4IjoLE8=
Message-ID: <86a2a695-cdd8-41fd-f540-0bdb9e4e61e8@candelatech.com>
Date: Tue, 9 Jul 2024 10:13:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: MLO failing due to attempting wrong link-id
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
References: <6974c7b4-4915-d4c8-07c6-ee337005b50a@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <6974c7b4-4915-d4c8-07c6-ee337005b50a@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1720545205-H_wHtXJR4evy
X-MDID-O:
 us5;ut7;1720545205;H_wHtXJR4evy;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

On 7/9/24 08:55, Ben Greear wrote:
> Hello Johannes et al,
> 
> I have an AP that is advertising MLO link 1 and 2 (but not zero).  I'm using be200
> 6.10 ish kernel, be200 hacked to enable MLO.
> 
> I am seeing that the method below is failing because link_id is set to 0,
> and link and link_sta both end up at NULL.  When this happens, I see only
> one active link (and no dormant ones) when looking at those fields in debugfs,
> but there is a second link at least partially constructed and seen in debugfs.
> 
> I'm going to keep digging at this, but curious if this is already known
> issue and fixed by some of the pending 6.11 patches?

Maybe this...looks like it is time for me to pull in
another pile of patches:

wifi: mac80211: fix erroneous errors for STA changes

Thanks,
Ben

> 
> 
> static int sta_link_apply_parameters(struct ieee80211_local *local,
>                       struct sta_info *sta, bool new_link,
>                       struct link_station_parameters *params)
> {
>      int ret = 0;
>      struct ieee80211_supported_band *sband;
>      struct ieee80211_sub_if_data *sdata = sta->sdata;
>      u32 link_id = params->link_id < 0 ? 0 : params->link_id;
>      struct ieee80211_link_data *link =
>          sdata_dereference(sdata->link[link_id], sdata);
>      struct link_sta_info *link_sta =
>          rcu_dereference_protected(sta->link[link_id],
>                        lockdep_is_held(&local->hw.wiphy->mtx));
> 
>      /*
>       * If there are no changes, then accept a link that exist,
>       * unless it's a new link.
>       */
>      if (params->link_id >= 0 && !new_link &&
>          !params->link_mac && !params->txpwr_set &&
>          !params->supported_rates_len &&
>          !params->ht_capa && !params->vht_capa &&
>          !params->he_capa && !params->eht_capa &&
>          !params->opmode_notif_used)
>          return 0;
> 
>      if (!link || !link_sta) {
>          sdata_info(sdata, "sta-link-apply-parameters failed: link: %p  link_sta: %p link-id: %d new-link: %d\n",
>                 link, link_sta, link_id, new_link);
>          return -EINVAL;
>      }
> 
> Thanks,
> Ben
> 


