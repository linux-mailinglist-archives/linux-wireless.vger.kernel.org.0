Return-Path: <linux-wireless+bounces-29385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A7C8F304
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF8CE35477B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2B334680;
	Thu, 27 Nov 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bestosotech.com header.i=@bestosotech.com header.b="Fa2rFBOU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from hs9.name.tools (hs9.name.tools [169.60.152.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694327E074;
	Thu, 27 Nov 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.60.152.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256189; cv=none; b=NnGLSXWZWGorE/ASQ1s1fn9dIWVpLkNoPtuWoKvkxA4KmAlzD5IRsyZ2AD9yjDKdTaXukAAYM3R6rrklT1e98C5ZfNkG7K7AFcGdEHgrpcDiH/btu2WSadjS+SSQbBvuT5uDxqRa3B1lxfwdKZruXrcZwURrjzfp1j+EFVimKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256189; c=relaxed/simple;
	bh=90RaWt4BGTUBHFPuNeNb9a5Uub45kMW2TKe+0hikI3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOhN4wgHTK7Y/Zj5VqaqpOK74j2nqqxu8wWpYiuBm+aI/ozlvOVpkOQ16azRm3YX9GxxijPhrc4NHsovs7Q4BxnVfGS5AgBv4igmaibe6cYj8md925XLGrCG8+Bf0dnf+ecuDLuM5Q1NPlVxCKvkCYZnk4KoFe8zLayWOmuVwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bestosotech.com; spf=fail smtp.mailfrom=bestosotech.com; dkim=pass (2048-bit key) header.d=bestosotech.com header.i=@bestosotech.com header.b=Fa2rFBOU; arc=none smtp.client-ip=169.60.152.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bestosotech.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bestosotech.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bestosotech.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=90RaWt4BGTUBHFPuNeNb9a5Uub45kMW2TKe+0hikI3c=; b=Fa2rFBOUqsvgD3sSzF6b74zBLC
	4ZiGsRjMSfC/CT9kmguZdktSynwz4P1h6hy9LTnGGp05y9e0L2jhFA/Nd3owrraM0HLUuahVfsFvu
	EFHOtPBASHcRojTmTw0uwgBisf32FOqbewJiF12M3/dt1dvNkFtXlO01Ils8M+JGO/94N0b6D8L/C
	WjXLI+m7Nv+lQp4vYfB8Y41gchm/LInb2ZJOs434+3aPxTkr7twugm0puZCRmGZ7mM+GR/gerrzvj
	X8vht7uSDPX98a9QCUeES6WCXhcKkJqFRYbOhDjM7QMYz5gfdTSFolnhIitEo/gFZwhlLlpU9QWry
	/WVyRLNg==;
Received: from mailnull by hs9.name.tools with spam-scanner (Exim 4.98.2)
	(envelope-from <alexbestoso@bestosotech.com>)
	id 1vOdcw-0000000G0Wn-3P4a;
	Thu, 27 Nov 2025 08:09:46 -0700
X-ImunifyEmail-Filter-Version: 3.8.20/202511211447
X-ImunifyEmail-Filter-Action: no action
X-ImunifyEmail-Filter-Score: -5.00
X-ImunifyEmail-Filter-Info: SUVfVkxfQUdFX0FDQ09VTlRfMkQgSUVfVkxfQUdFX0RPTUFJ
	Tl8yRCB
		JRV9WTF9BR0VfRU1BSUxfMkQgTUlEX1JIU19NQVRDSF9GUk9NIE1JTU
		VfVFJBQ0UgQkFZRVNfSEFNIE1JTUVfVU5LTk9XTiBSQ1ZEX1RMU19BT
		EwgRlJPTV9IQVNfRE4gUkNWRF9WSUFfU01UUF9BVVRIIEFSQ19OQSBU
		T19ETl9FUV9BRERSX1NPTUUgRlJPTV9FUV9FTlZGUk9NIFRPX01BVEN
		IX0VOVlJDUFRfU09NRSBSQ1BUX0NPVU5UX1RIUkVFIElFX1ZMX0FHRV
		9BQ0NPVU5UXzJXIFRPX0ROX1NPTUUgUkNWRF9DT1VOVF9PTkUgVkVSS
		UxPQ0tfQ0IgWE1fVUFfTk9fVkVSU0lPTiBBU04gSUVfVkxfQUdFX0RP
		TUFJTl8yVyBJRV9WTF9BR0VfRU1BSUxfMlc=
Received: from ip184-188-225-63.ri.ri.cox.net ([184.188.225.63]:50720 helo=[192.168.0.172])
	by hs9.name.tools with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <alexbestoso@bestosotech.com>)
	id 1vOdcw-0000000G0WA-08ai;
	Thu, 27 Nov 2025 08:09:46 -0700
Message-ID: <0d0aae03-e903-4322-a5e5-ca01bc2526b7@bestosotech.com>
Date: Thu, 27 Nov 2025 10:09:44 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug Report - Rtlwifi
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <85517aee-6e2a-4524-a5e2-6b48d05facbe@bestosotech.com>
 <0b376fdcc68442f7b41268bb26cce73e@realtek.com>
 <fcd02348-804c-459b-aa03-de61931516be@bestosotech.com>
 <4e2592fe3ec242ba9a8d380ed4e16cc3@realtek.com>
Content-Language: en-US
From: alex bestoso <alexbestoso@bestosotech.com>
In-Reply-To: <4e2592fe3ec242ba9a8d380ed4e16cc3@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hs9.name.tools
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bestosotech.com
X-Get-Message-Sender-Via: hs9.name.tools: authenticated_id: alexbestoso@bestosotech.com
X-Authenticated-Sender: hs9.name.tools: alexbestoso@bestosotech.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Sounds good!

On 11/27/25 02:50, Ping-Ke Shih wrote:
>> Never made a patch before; but I believe that this is correct, made with git
>>
>> Sent as attachment and pasted below:
>>
> I can send a patch based on yours.
>


