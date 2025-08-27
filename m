Return-Path: <linux-wireless+bounces-26682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DC3B37D93
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 10:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC865E3CE0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3713376A8;
	Wed, 27 Aug 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="z2vokcXL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D266335BAA
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282846; cv=none; b=Pz6cZmxtnQQc+4PfaBSSHaqsBZsh2LPxvapWes3M+EiGUglWh4+FpPiXhaBjDgjk6C5j1L5OmAqQeVBr+Db1RYn8H7lG42ddzXaa+PTKsPx1WAHj8NJibGw7+RA5pJlRGYxxTN81fn0AdLYpuPLNp0crsTsuLXYyfhBfkuP7wpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282846; c=relaxed/simple;
	bh=UliHWSvtVXsTHhis2aYGj1/++adNgRxl8RPmfpsSGHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI5MzkpTPXh6aPOsfxG3PGkJPc2yZrFgYmbq+g9EXEtjajNAVZfJqQ8Q1XNVaH/sp05DPY9Hpy+NJKC6oBS5InC8/equzB75zUgpJV8ttnQg9+QpLIF1yH01yLgdfO9KmWOw5Qjkrw/t/pnFiTvGL2kFalqpfoGmegpJbzs+J4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=z2vokcXL; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id r4YouDhtfMvnzrBOducRhy; Wed, 27 Aug 2025 08:20:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id rBOculLi4GtD7rBOcuXTz3; Wed, 27 Aug 2025 08:20:43 +0000
X-Authority-Analysis: v=2.4 cv=aKjwqa9m c=1 sm=1 tr=0 ts=68aebfdb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DR2cKC/DEnBA9KqqjaPhpA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10
 a=SY8t8FWu3FT3qhMuHm8A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0SN+wJGJIv9ujgFWvGNEsg1V7L+7eqSZIr1AkhiZfKU=; b=z2vokcXLuiV4oEhqwOOicVtWkg
	fO1l1DeNPc9YSm9PRK3t/WfvAd/wKwd9/fbws0iN9IivSAi3Dm7LVcRSDmz/HbJKPAwPj16mJR9LH
	bcn4nhemzX+wKMIABPrMlB3eq5jn3CMgPSM/0x9U6zI1N1uh40Z5R+usU4tdAuWOpr7Ut4Cnp51Ms
	MTSMI8v2irYXaABHe4S7Cjwzwcuq0eqfv1Q5FMTv0pMediVDLl4nHwx2EQQMuK7u6iINpT7mpMGIE
	4e+N1Tajqxsfwx3THbWuTfiMAOK3Myz8L1UXNFt5dV09pOb1ZhxsTt71ptBxPRAlH4N1sCSZqJIra
	NBoohmbA==;
Received: from static-243-216-117-93.thenetworkfactory.nl ([93.117.216.243]:56954 helo=[10.94.27.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1urBOc-00000001dKs-0nbS;
	Wed, 27 Aug 2025 03:20:42 -0500
Message-ID: <ed9e34c4-ab63-47cd-b27a-9aa18cd91180@embeddedor.com>
Date: Wed, 27 Aug 2025 10:20:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wifi: iwlwifi: mei: Remove unused flexible-array member in
 struct iwl_sap_hdr?
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fbc03dee-273a-4c75-a8bb-fbc6ae48d26d@embeddedor.com>
 <4f8037dc97958e06dfb08d75fce982c1e4e36068.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <4f8037dc97958e06dfb08d75fce982c1e4e36068.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 93.117.216.243
X-Source-L: No
X-Exim-ID: 1urBOc-00000001dKs-0nbS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: static-243-216-117-93.thenetworkfactory.nl ([10.94.27.44]) [93.117.216.243]:56954
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBoVT25ru371dSwC5cReoIGOCR/+IDOh7KFJupRFKXfJnfl8p6QD6QgDD5EgGZWxefoNzaDddPmh69TqQ3Cjj08pHTncVFKpovTuOhqX3FD6I4NwkYJh
 zzuU5qy4t0N+Ta4qdgA3gaF/2ZQAn6tBPrHTa8nmKKOGtPDy3zg7SU5KzBWwzCyCP439A/3sHtE+lhRQvpYolSJEWZZDRcLWbSLBMdYoihcuhUqID1YJP1g6



On 25/08/25 10:20, Johannes Berg wrote:
> On Mon, 2025-08-11 at 17:23 +0900, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> At first sight, it seems that the flexible-array member `payload`
>> in the struct below it's not being used:
>>
>> drivers/net/wireless/intel/iwlwifi/mei/sap.h:
>> 298 /**
>> 299  * struct iwl_sap_hdr - prefixes any SAP message
>> 300  * @type: See &enum iwl_sap_msg.
>> 301  * @len: The length of the message (header not included).
>> 302  * @seq_num: For debug.
>> 303  * @payload: The payload of the message.
>> 304  */
>> 305 struct iwl_sap_hdr {
>> 306         __le16 type;
>> 307         __le16 len;
>> 308         __le32 seq_num;
>> 309         u8 payload[];
>> 310 };
>>
>> If we remove it, we'd get rid of 14 of the following type of warnings:
>>
>> drivers/net/wireless/intel/iwlwifi/mei/sap.h:318:28: warning: structure containing a flexible array member is not at the end of another structure
>> [-Wflex-array-member-not-at-end]
>>
>> Is there any case where this array is actually used that I might
>> be missing?
> 
> Check if it builds? But I don't see it used in our internal (and
> possibly more recent) version of this either.

It seems that the whole thing is actually broken, see commit 8997f5c8a627
("wifi: iwlwifi: Mark IWLMEI as broken").

However, nothing complains when built without that array. So, I've just
submitted a patch.

Thanks!
-Gustavo

