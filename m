Return-Path: <linux-wireless+bounces-28708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD9DC444E3
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7910B3A9DAC
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C501DF270;
	Sun,  9 Nov 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="HT7qskbX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7E1CEAA3
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762712665; cv=none; b=La0hkptPiSOgBDbLhzEEmepQ/ad8CzR0VAVhAhfDQ4vOOzStdE2e4x0IfeHIacq7pppxRcse0x1PmHV2eXf96R/v1/UPFCxHXZUqKzOpwNCNZrl+2QJT0QA7VjMEZ6lWDDQS/Fg5apiQHnQL/7+p1wYjTYcfxdCHkcpK1boqwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762712665; c=relaxed/simple;
	bh=wlj07ZXL9YSbIF+CP12XdhGrBJ75DGchH8cfIjGAxtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcUcPUS9BLLRMPOH4ZcWjke2WrQ83tOJ9dIKuYA159rZIt5bvD8wgC+cNlwptMDg0nXBQibqjJ+uaXfyZqakwlpSni9ZIQafrXWVRIXcq+pbwOh9HRNIrGwxj2/xll8tlxNlS3g0GjTLr7ZQVKDCmxpSHzksYUQli/AuxAishXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=HT7qskbX; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D15B710005E;
	Sun,  9 Nov 2025 18:24:15 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.36.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8F2A513C2B0;
	Sun,  9 Nov 2025 10:24:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8F2A513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1762712652;
	bh=wlj07ZXL9YSbIF+CP12XdhGrBJ75DGchH8cfIjGAxtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HT7qskbXI74SvKyvi/lG92vS3pEBaPyfY+jsKNrllt9wuN6cERJC5McTjnN1OB0ni
	 q06eyW7N9CnxBQS7qFhe0oE2srMMnUvHq/uE/7zvt6n3mly9EXWsOR5SFYtK9JkKvR
	 rFmhhh903fvrHe2KC9hbWjRUI3vbTD9WHLW5UXso=
Message-ID: <c434d289-0b5b-4611-92ad-b6af7e93c0d6@candelatech.com>
Date: Sun, 9 Nov 2025 10:24:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: support for
 COMPRESSED_BA_RES_API_S_VER_7
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
 <20250430155443.c4be90e242ff.Ie8a0f0d6320613bd8c5cb6c82a063069fffa3b67@changeid>
 <11cca5db-28c5-a57c-78c5-7084afd92509@candelatech.com>
 <ebff7d3d89c87b2646da17bd10b8f075a4be4d98.camel@intel.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ebff7d3d89c87b2646da17bd10b8f075a4be4d98.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1762712656-bT5zyLgX16eP
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1762712656;bT5zyLgX16eP;<greearb@candelatech.com>;164575d057495991bbcad51b50c00bde
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/9/25 00:10, Grumbach, Emmanuel wrote:
> Hi Ben,
> 
> On Fri, 2025-11-07 at 15:16 -0800, Ben Greear wrote:
>> On 4/30/25 05:57, Miri Korenblit wrote:
>>> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>>>
>>> The rate format changed but since we don't use the rate, just claim
>>> support for this new API.
>>
>> Hello Emmanuel,
>>
>> I'm interested in using the tx_rate to provide tx histogram stats for
>> mcs, nss, etc.
>>
>> Could you please share the rate format?  I'm specifically interested
>> in
>> Intel be200 on kernel 6.18 and higher.
>>
>> Thanks,
>> Ben
>>
> 
> It's ... a bit complex.
> The firmware is changing the APIs to add support for UHR.
> You can look at iwl_mld_fill_phy_data, it translates the rate using
> iwl_v3_rate_from_v2_v3 which allows to use only v3.
> 
> v3 supports UHR and v3 is supported on firmwares that support the
> TX_CMD version 11:
> mld->fw_rates_ver_3 = iwl_fw_lookup_cmd_ver(mld->fw, TX_CMD, 0) >= 11;
> 
> This version of the TX_CMD is supported only starting c101 firmware
> which is not supported by kernel 6.18.
> 
> So... bottom line... you still have the old format of the rates (v2).
> I suggest you checkout dabc88cb3b78c^ to see how things were done
> before Johannes added support in the driver for UHR rates.
> 
> Then you can look at iwl_mld_rx_fill_status to see how we translate
> rate_n_flags (v2 of course) into struct ieee80211_rx_status.
> 
> HTH

Thank you, I will take a look at that.  I was able to guess a lot of
it by staring at hex printout in different wifi modes,
but it will be good to verify and fill in the missing bits.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


