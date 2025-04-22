Return-Path: <linux-wireless+bounces-21826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A54A95DD5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 08:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CF63B3DE1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4A1E5B94;
	Tue, 22 Apr 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="VNYBFmOg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A801E5707;
	Tue, 22 Apr 2025 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.66.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302438; cv=none; b=PHi8CpkUgTLMRO2Bj68QwHcaceOGA3+AtEImUaO4JC7PtxRFIwk8owtUQecKCR8o4yZT459rXNYixZPiXb13XlCFZmpuYlxdmTUZRKbChlCyy7k/WahTZ4l4EuH6jTX9CUsEDKYVHsjzkNHTuoOdhdwFpH6aXs/YVib/oIckAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302438; c=relaxed/simple;
	bh=haRoeOk6LzW0VxiMtuKkFaS3hRndffn4xbn/cmXz4vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyI1CJsjCC+59miedN1A3armZTugY8tCGTm8lVGBGLyVjyLEqGqLUPktccfjLv8GzpK/g/l0p/Qcyluab/v62PQPjL0IlM5sS15QYJB+WTrjXq1RrCy1ay3ShRkiAbFdsi8xx6fbHbsT/CIywJMmToB2OAGFKLqcXe3S3WMDj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=VNYBFmOg; arc=none smtp.client-ip=217.182.66.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id E2FE13E8FC;
	Tue, 22 Apr 2025 06:13:48 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 8195F40074;
	Tue, 22 Apr 2025 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1745302426; bh=haRoeOk6LzW0VxiMtuKkFaS3hRndffn4xbn/cmXz4vQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VNYBFmOgDIW3+FDDYkghTG/pZf8vnfCeqMx8EVPxSNpSiq78Zhq2ObIVHchp6GOVZ
	 2w7oejMR3aMiHJBK8Fu69YnmewYfwsF3eUv0ldDezLFOmKKB02tsSzVoDx96O+W2DM
	 oHaHReJ+oG3PbJVbYvFJZybuBO0gcuS9uKpHecgw=
Received: from [198.18.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0E12B42AD7;
	Tue, 22 Apr 2025 06:13:42 +0000 (UTC)
Message-ID: <fb0b667a-ebea-4705-9f69-b3bb98399494@aosc.io>
Date: Tue, 22 Apr 2025 14:13:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtlwifi: disable ASPM for RTL8723BE with
 subsystem ID 11ad:1723
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Liangliang Zou <rawdiamondmc@outlook.com>,
 "John W. Linville" <linville@tuxdriver.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 "open list:REALTEK WIRELESS DRIVER (rtlwifi family)"
 <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250422032132.348598-1-jeffbai@aosc.io>
 <1ab6f74b5b9d4f0d8023eb43d41906be@realtek.com>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <1ab6f74b5b9d4f0d8023eb43d41906be@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8195F40074
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [0.00 / 10.00];
	SUBJECT_RANDOM_CHARS_1(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,stable.vger.kernel.org:server fail];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[aosc.io,vger.kernel.org,outlook.com,tuxdriver.com,lwfinger.net];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Ping-ke,

在 2025/4/22 14:08, Ping-Ke Shih 写道:
> Mingcong Bai <jeffbai@aosc.io> wrote:
>>
>> RTL8723BE found on some ASUSTek laptops, such as F441U and X555UQ with
>> subsystem ID 11ad:1723 are known to output large amounts of PCIe AER
>> errors during and after boot up, causing heavy lags and at times lock-ups:
>>
>>    pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
>>    pcieport 0000:00:1c.5: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>>    pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
>>    pcieport 0000:00:1c.5:    [ 0] RxErr
>>
>> Disable ASPM on this combo as a quirk.
>>
>> This patch is a revision of a previous patch (linked below) which
>> attempted to disable ASPM for RTL8723BE on all Intel Skylake and Kaby Lake
>> PCIe bridges. I take a more conservative approach as all known reports
>> point to ASUSTek laptops of these two generations with this particular
>> wireless card.
>>
>> Please note, however, before the rtl8723be finishes probing, the AER
>> errors remained. After the module finishes probing, all AER errors would
>> indeed be eliminated, along with heavy lags, poor network throughput,
>> and/or occasional lock-ups.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> 
> This Fixes is weird to me. The subject is RTL8192CE, but you are adding this
> for RTL8723BE. More, at that time, HARDWARE_TYPE_RTL8723BE isn't defined yet.
> 
> This might be more suitable?
> 
> Fixes: a619d1abe20c ("rtlwifi: rtl8723be: Add new driver")

True. Sending v2.

Best Regards,
Mingcong Bai

