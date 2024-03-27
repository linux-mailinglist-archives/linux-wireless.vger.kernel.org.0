Return-Path: <linux-wireless+bounces-5404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6F88F09E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 22:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B035D1C2B0C5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE715351C;
	Wed, 27 Mar 2024 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="plXN80LV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694E15350C
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573586; cv=none; b=tcFsgSZWTC7OEvpXr35XyYxmpHnfbzMP5meWv2YtOEfsfGqbTmv0UyGpPAJhCGGMQ0x8Jy/sIJT88EHHmZow9x3SPn6Y4nzwX+5RHZiqheQvYmXPeNpRzxAWoki/lW8A0iTEmNcyvIVL1xIcaAr57lTuji0Vhz0dw+20xeqLZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573586; c=relaxed/simple;
	bh=Xx5MpaWvy5522jqTooimseYw/Jm8R5vpweYD4JwX7nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGJBneDet2L6PH91nfgZ6Q/8xlkoTM5e08yTWYgWeibWuiEzwaHLFX//Gx/UrE8ax649wR4KhYB/itXt8/GoGLo3zSB7x9y6PsyYy8sE+6iSSDwf3vxGck1wLqFwaoaKuEP16mGQNWON2jz/cMXBT5ux6nk03nVrvnU369CyWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=plXN80LV; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id p9arrcQTPDI6fpaTXrEKgI; Wed, 27 Mar 2024 21:06:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id paTWrxPlziKqRpaTWrXYUs; Wed, 27 Mar 2024 21:06:22 +0000
X-Authority-Analysis: v=2.4 cv=I9quR8gg c=1 sm=1 tr=0 ts=66048a4e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=1VVxQOVvkDxVd9r07kAA:9 a=QEXdDO2ut3YA:10 a=oeCWIyVaUf8A:10
 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0qCww4XnuD7HGbcNfioDP3N0BucgDEPTS/31Ql+x+hY=; b=plXN80LVUebjbHVxO2SjTlb2ZP
	djrrZWoC1bsw6SEGq6k3t9zjtKqgwNe/Ar5RJEb63BpWKG94ofEC1ykvpXutIVLCWNudFi93KhSPo
	e1gR0hIpWIhz1HAcu1yUhOAXVT4Ov0s3AN8SgLUMjwc6UOHF25Q8u9OJMQpC/haQXmFwZWxY+zt5X
	Ns9lq514ralTgD+uTDwdfGLN9IMU3pCOSCAKRuwBdAb5XAuRNqH/IA0WeiI08bzMGGQQ1dR1mt6TD
	+X+GLKIMb0E9G11nD9RGUtKs6W7lDwW7giEmnLVgwAnq77cp6Ub51D4HGZvNtIyt9sHNd1TiT2fR4
	VOxkTrbA==;
Received: from [201.172.173.147] (port=56048 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpaTW-001BZU-0M;
	Wed, 27 Mar 2024 16:06:22 -0500
Message-ID: <0abb2673-1c60-4374-8c88-b5f0eaa3be33@embeddedor.com>
Date: Wed, 27 Mar 2024 15:06:20 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: wil6210: wmi: Use __counted_by() in struct
 wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgRsn72WkHzfCUsa@neat>
 <dc556824-d499-430c-850e-fb0ca55dd5fe@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <dc556824-d499-430c-850e-fb0ca55dd5fe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpaTW-001BZU-0M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:56048
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ1Zyqfszm/q71ihbl29wZ/whMT0uL54IVLO+v5cLUZFrRAQzm8pEHugJqwTvosPybYDQ+eQRJOG+THhtBmWnG2NJMi4/8H+EH2qUy55cy9inTchQkX0
 Ks6zQAQmo6pGhkpyDD4AJqKKKlg7QlPKr+fe5XLB1a6LQzXr/sJOfNGImxG7p5EUfRjI/3JroWNA3YjVLfOLR3ioQH9pNxDdPFRMASa88Y8dOruSW7VatWvR


> That DEFINE_FLEX() macro takes a bit of time to understand! But I finally
> digested it so...
> 
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 

Thanks for your time and RB tag!

--
Gustavo

