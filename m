Return-Path: <linux-wireless+bounces-12188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7AF963467
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 00:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE1F1C2242A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23778165F13;
	Wed, 28 Aug 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="fXFvQrfp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F7165F06
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882777; cv=none; b=V/WremwS6oK/lcA74ZVdAWY2Q3KBKC8L9IjveluW6ebtzGOZAPBKylGFpJYBL43hLlp+5d1oRHEhOj7NGuODYA25OThBhEnBL7j5zduac9zPalqlKPtao2uPXsKsz/El4ttlpB9KCF7MMPnJJ0weKlYukBxXT0LffSFYLMI4lVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882777; c=relaxed/simple;
	bh=v7S+4AK65Kujrl6CMWiL03HOsWkw1zW5vhe/hw5R8Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXlrJVJLw1d66dOaI7ZAoYKYMTey+GD0u/I1SRuaZH3UPaNq7FZegydsa4t7qfPnrlPJxgGqfPsLoZaDWme/NolNozTGDLBQDTNNIP1IZhKYry8rYbWspeFPQIoQnCtWQzQHFQh5FSFAiESNe4gMJWmJH7MgWK3VhrXRxbFBtis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=fXFvQrfp; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 563CF400066;
	Wed, 28 Aug 2024 22:06:07 +0000 (UTC)
Received: from [192.168.101.118] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id C0CAB13C2B0;
	Wed, 28 Aug 2024 15:06:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C0CAB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724882766;
	bh=v7S+4AK65Kujrl6CMWiL03HOsWkw1zW5vhe/hw5R8Wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fXFvQrfptGbB2XSsOk/G0l2XhFYA2oAQL2PDJH9GhV4seXCWUcwzNqOzkVSdB0dWd
	 fEYSPATeDplIcGO6TiVtOO7zN9RK/9yyU1Wfcbc3A0gFI1J3QE2jyWVA+npuLbrA7X
	 RtB21Job4zt58R7/ZoGG5BCNUcDopubOJAxZNAsk=
Message-ID: <50e85bef-d782-425d-a6df-49be5e7cb71f@candelatech.com>
Date: Wed, 28 Aug 2024 15:06:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iw: scan: add EHT beacon info support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20240731162022.2943045-3-dylan.eskew@candelatech.com>
 <dd210692356dfbcfedac1bebb444a726eaef519d.camel@sipsolutions.net>
Content-Language: en-US
From: "Dylan E." <dylan.eskew@candelatech.com>
In-Reply-To: <dd210692356dfbcfedac1bebb444a726eaef519d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724882768-3Gx5By2-Hz_5
X-MDID-O:
 us5;ut7;1724882768;3Gx5By2-Hz_5;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 8/28/24 4:39 AM, Johannes Berg wrote:
> nit: a bunch of places here have weird indentation suddenly,
Apologies. I'll be more diligent moving forward about spacing.
> I'm a bit more concerned though with the changes about the EHT MCS/NSS 
> set. You don't have the HE stuff now, and you're not handling "20 MHz- 
> only non-AP STA" here any more, which seems relevant for local 
> capability printing? 

Your concerns are well placed. My initial iterations have been naive; I 
now have a better idea of what's required after looking back at 
documentation and having a better grasp of the standard generally. Your 
patience here has been and will continue to be appreciated.

Dylan


