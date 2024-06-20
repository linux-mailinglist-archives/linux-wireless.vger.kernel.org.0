Return-Path: <linux-wireless+bounces-9326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757D91107B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B681C24681
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446B1BE238;
	Thu, 20 Jun 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TrMdy504"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B41B4C52
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906544; cv=none; b=d9XC/CMXKVzkyjQ8mrPntHACjKl2I961WPhpHkFpjVaSPJfCG/9MPxdZsmdGaUb/5rijN3LrXQ06+jI7nEjaIuhw4gz97IZqD+pykzJo+/vvv4jv1LPCMBovretOZT7jk2Zowu8j8JV5pIcY3Dgwn3GvKNs3uUocLRWdB5Xbej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906544; c=relaxed/simple;
	bh=9OYNE5YcPJoW+cycciShcyXeb0c1OGto8YDuhiLt/9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sz2P5YCB9kL29JZGbjh2XRkfrQ59OhCXn/mNkt8JodcDsHhBX2aLXCdvd8E7xkKv125CGV0Nn94/03vVH3wPEP9l1P6+lWjeHWm/qaDtlajpH5Ig7Tb6BwSlpRcbbNVYFaBLnU8D+1e/IrJaq9nL1kbK4kPkWt/AFtAt4yMjJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TrMdy504; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id KIKasX5REAidIKM73sliQ6; Thu, 20 Jun 2024 18:02:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KM72shYDUuv6XKM72sXdOV; Thu, 20 Jun 2024 18:02:21 +0000
X-Authority-Analysis: v=2.4 cv=YbZ25BRf c=1 sm=1 tr=0 ts=66746ead
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10
 a=u8_TST9jJ4tMlxaXhdEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HfKKts8lHZEV18StgAl0ALsIpFvYHBbDUnFqCEnAdRs=; b=TrMdy504Ugni0jbv4PFKWfje9V
	ClDtpMDCuWWJYypILr/vUVFwgQ/jrR+7jbKpafdafiTG9H7OM1a3m9tzMpVVr214sbB+bt1ntOyb1
	xiMj3rY77gU+N4r5nY8MjIkcEOCmA4HQk/vClwkCo4znDagw7v4zOnJwLuJCkRCBUwnHUyBPUiw7v
	MaFluSrchhPqDq47wjsWQlasAIZs6+wmbHsUfpbCs3sjwHV2/CTnA97IusGBwIO6dBYknoLP1IsOL
	nzSwiGdSiDZga4EWSU9yQtcOSSHGVr0P+QjUk9E09rkG0Tnk1bL+745mR2hnq1JJtS0DMJ1PGairJ
	t/UW1t/g==;
Received: from [201.172.173.139] (port=42268 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sKM70-003e3c-2m;
	Thu, 20 Jun 2024 13:02:18 -0500
Message-ID: <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
Date: Thu, 20 Jun 2024 12:02:13 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
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
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
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
X-Exim-ID: 1sKM70-003e3c-2m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:42268
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPcv1+1uyMVJb5FYy28v/be37qntSW8LxRDBlLb6TE7fsEPp4j0dK4HpIrkk2Cxq/ObzkRfQcgFWbIOwwgwn8c3bV+HUhdrgQsDRJ8eg3YNDfE/WOrH2
 GjzBECF3UoBk3716kthHMl6F0+T+DIZnX9214eY4bYR70GDCoeR1Lah5HG12SBZyLrOXBPEGAasXVPSzbtCE/wNxPY85S0M25xc2VsKjoxEwrFk7gu5VHE0X


> My understanding is that 'match', is allocated by :
>      match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);
> 
> So match->n_channels is *0* when iwl_mvm_query_set_freqs() is called.

n_channels is updated in the line before calling kzalloc():

n_channels = iwl_mvm_query_num_match_chans(mvm, d3_data->nd_results, i);

match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);

--
Gustavo

