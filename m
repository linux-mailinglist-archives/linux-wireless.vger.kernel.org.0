Return-Path: <linux-wireless+bounces-5494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453BC890904
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750E01C21614
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD011136E13;
	Thu, 28 Mar 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="IwjaLNsI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA349137C27
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653617; cv=none; b=WT+B3geWAYYF7ysGmgkZDkCyCYaAPD5zsfuzHxUVuPTwjoLyTFBL/5REhVPXBj3NfwU+jS01Xc2MmN7fokH9zOChNh51raR+eOsel07lsT+aaBjMz6zDQfgFw8Gzjsw97ngbIm/hG8PcK0qUZ5EPoGJkQxFcIYOClMyCXKI2vFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653617; c=relaxed/simple;
	bh=jlKX/71Rl4LteIviSrCFAPH8SPdylApgi56PoMqwqis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM24KkTlhWDb3XlXQqpeDS6Rozhcco9J8G9EGMkKDNSB832EiHoGWdyNgVcE3ubKzZ4X3qNrsvSdRy2oI4IGpr1KvIpVoB9jHivKXRXhGehIoxOOwg/WxofYkmqMot6jfM2asMscVzRIv4Nx4WH1fHE+j9jURY7ZEmy1cLsbVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=IwjaLNsI; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id psCnrFfluuh6spvIHr9PU3; Thu, 28 Mar 2024 19:20:09 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pvIGrLwy03g73pvIGrFnAl; Thu, 28 Mar 2024 19:20:09 +0000
X-Authority-Analysis: v=2.4 cv=esUUzZpX c=1 sm=1 tr=0 ts=6605c2e9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=l-0SYlq0ot4ByQFz_X4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eT7vaZHHjEMxhRKG/6gsWxmfF8xNUtEbKXpbgQbV3qw=; b=IwjaLNsI6Y7EXjAPREVGB0BwxR
	/uuAa5Y+CvEpx0kpNiHwvmWF3IlM+6z1DF0j/a2yEDijMI1EiN5O5jwyXlBPqDDEym2TqEDSVyMpg
	YTCtYUabqYNXD0flDzstbAQUgMz0z1Uax5EfYnKVTDq2o0bhK1qthJDRs2xVRUVoNlj+jGooQBaTS
	/P7UvqyKzRNJO9uZ89ob/BESxZujmY9o+UUlCGVSlmKYvczBH9QEgbzjjZ0JFDRCqqfFQRLiBoOHZ
	KKVrPeuaspGWeF06Gmx3726VpOc1l0WS9oSR2qq4D73FeCHPY8Osy+j+OK7Q5WIjsIh1XdicIhAF1
	ZsYFAYHQ==;
Received: from [201.172.173.147] (port=37368 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpvIG-003u8l-0S;
	Thu, 28 Mar 2024 14:20:08 -0500
Message-ID: <5f91acad-23c5-4e0c-b468-8aab56b0ff7a@embeddedor.com>
Date: Thu, 28 Mar 2024 13:20:06 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: wil6210: Annotate struct
 wmi_set_link_monitor_cmd with __counted_by()
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgODZOB4fOBvKl7R@neat>
 <171163065000.129280.2362402378382558964.kvalo@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <171163065000.129280.2362402378382558964.kvalo@kernel.org>
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
X-Exim-ID: 1rpvIG-003u8l-0S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:37368
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNDB2w1Bzsk6JklYsXem3kFu6c5xql3U+bwkgu/J4ZWU+4o175OWHEcXEA+ghO0xl4nIgv0oD4DA6SDNF5sX/udVzWqoe/c0C+nTxhU/KRAvYNPSSjht
 qtshn1nEH7EI5BlFrklmKcaNs7v7jvhNUgwzPAPyj/tDSuQZ+EzMezT93+Xl8ehxMOkwztFkEN2SDdwJwGJHErFKi1OlZUqSL7pCuMQDn4vff5W6+rjh/uLW



On 3/28/24 06:57, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> I'm dropping this because it looks like you sent a different patch, but
> it's quite hard to know for sure.

Ah yes, sorry, this was replaced by the following patch:

https://lore.kernel.org/linux-hardening/ZgSTCmdP+omePvWg@neat/

Thanks!
--
Gustavo

