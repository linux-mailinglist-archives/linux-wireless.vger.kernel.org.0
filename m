Return-Path: <linux-wireless+bounces-9329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC70911093
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FDE1C251A8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199471BF316;
	Thu, 20 Jun 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="IlHTP6Bg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F781BF30C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906896; cv=none; b=apMdKfweBhPj7ircI/6Eb3pzUo6Rg5lmblYvrP8S+aIyAdgBfzcYk9cJnA4qAoJAxhlKC5F9ZB7SiP4Rdd8I+gsU8lmGLcjkhCtBeZRMdfCWMffA68pBFgY8Ds5KjDHqlGRTs6s+n0u+nEx0Ro4ZBieIZAQgZT0zbJedypdpX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906896; c=relaxed/simple;
	bh=uB1apWJQ3OE6U+/LLsGbLd9fjmCXiikIAJ6C3moSk4U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mVJhKlrf65Oow1ZpNTIVZiClUqJ3BcymhRAjUsGEOWWAWF39++d116hAIf90HMColks2NBB0mRVIDnP7wd6xZY6rxoPZIRE6yN6c9aG1rZi4yMTYcS4LNbd8Evv4NYW/BMYQp2hrQGOmWUunPf68u2iY931CsD3YzhaDMjSyFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=IlHTP6Bg; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id KKNPs6OVKSLKxKMCesXfk3; Thu, 20 Jun 2024 18:08:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KMCdsQV5ziKqRKMCdseFla; Thu, 20 Jun 2024 18:08:07 +0000
X-Authority-Analysis: v=2.4 cv=I9quR8gg c=1 sm=1 tr=0 ts=66747007
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10
 a=x_dihBSuy5WN06TBF6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lZUL9jcxKTQlsQHFQ46DQVLaL8P8p8lX4a8jvUbOugI=; b=IlHTP6BgrVTNg3fJkdhOKtM0lu
	ftNDr7BNhZTWwf6y0RiYCFSImLlGDLImDF1tCSTskiTXZX07zXm4ybjfSDKCIBqg8D5kH/+tVh3df
	LxESga1cqCnOZb6wX0v+LVownAcUnuCzasRxK2oJWSg6xpC+r06qF8OS4Vwyz2ovPn1sVtzyyA9ji
	70BaS3w10yS1fqzKJHbG3Gn3m2Hm1bKCaS9Z7O1sYyCd8TeM0HdB2m/JwMCDTiPdjQfsCdzCIsXNo
	kgGrhVA63jlydWKcicUz/HwG+S5OhprZiuw6cTvfdaw9ckZCfNemJny2GJ1IurN7FD7F+Wg9eb4LY
	Al897pvA==;
Received: from [201.172.173.139] (port=42488 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sKMCb-003kD1-2n;
	Thu, 20 Jun 2024 13:08:05 -0500
Message-ID: <47a71c03-0306-4239-b77c-cb63a1760d19@embeddedor.com>
Date: Thu, 20 Jun 2024 12:08:04 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Kees Cook <kees@kernel.org>
Cc: benjamin.berg@intel.com, dmantipov@yandex.ru, gregory.greenman@intel.com,
 gustavoars@kernel.org, haim.dreyfuss@intel.com, johannes.berg@intel.com,
 kvalo@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 luciano.coelho@intel.com, miriam.rachel.korenblit@intel.com,
 shaul.triebitz@intel.com, yedidya.ben.shimol@intel.com
References: <20240619211233.work.355-kees@kernel.org>
 <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
 <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
Content-Language: en-US
In-Reply-To: <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sKMCb-003kD1-2n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:42488
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLemm04nDI/rTaAnFb9M66MQGL35Lc54cOah2v+BxkZj3NTdOMfoSQz9K6KgwElLxGwJKqyufCPW20USnsm9ZuZSpnYCE88phJwTkN0x3zh1iaQSwb1n
 ouMP/sfI0LXw8qjbv2wchSNGggLPrVRDdqay0cXPYsco5MpvaXHhsPssOk935oy84aXycrak3BeuWRJmBU4TimWNsbQ2p+d+FXMtubKk5YSTmQyXWbB9Mw8U



On 6/20/24 12:02, Gustavo A. R. Silva wrote:
> 
>> My understanding is that 'match', is allocated by :
>>      match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);
>>
>> So match->n_channels is *0* when iwl_mvm_query_set_freqs() is called.
> 
> n_channels is updated in the line before calling kzalloc():
> 
> n_channels = iwl_mvm_query_num_match_chans(mvm, d3_data->nd_results, i);
> 
> match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);

then match->n_channels updated here:

  		if (!match)
  			goto out_report_nd;
+		match->n_channels = n_channels;

Sorry about the split response, finger failure ugghh

--
Gustavo

