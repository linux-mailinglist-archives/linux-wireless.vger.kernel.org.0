Return-Path: <linux-wireless+bounces-22361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FCBAA7ADA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 22:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDE14E2386
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F31F9F7A;
	Fri,  2 May 2025 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="DJv0pt31"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B61F8AC8
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746217641; cv=none; b=bWjcAB6+8o4q72Kn7Z9DD5BKiQ6GuhYn7oxzEPdCgMDSWnOYWDcAZ7UJXK6KXfidXoEbGDW9U4KSK0DL3r3Nt0d6MY2GIGlBTsWQeLkntCVZyZq3W8sa7UcQX6N6RVj5xFV9NCXzcvz1ycqpvJxykb5JhxAj8r4H6CjuGNtRceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746217641; c=relaxed/simple;
	bh=kyHKKlO9w2mpZ86b8rIPb85l+t46jNwT3MVSaEiQW9A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=obSHYwiHQgzLmsJejUFTZhJ1E4DP5qhfEgKAuG58uHWev3mvxaTnXF3WP3eRR60tIHFIH4X8gKJRDNwiPBvT76aYUCpuil18vUjoSfEbDvEq1Y5j4roR7q+h94q6gI4tiGcet3tcEGUJ6Z6b4cNs0n17MHAe3KbztXPoELfV9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=DJv0pt31; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from engine.ppe-hosted.com (unknown [10.110.50.141])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BCD0F600F4;
	Fri,  2 May 2025 20:27:13 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5452094006D;
	Fri,  2 May 2025 20:27:12 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7388A13C2B0;
	Fri,  2 May 2025 13:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7388A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746217631;
	bh=kyHKKlO9w2mpZ86b8rIPb85l+t46jNwT3MVSaEiQW9A=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=DJv0pt31vGOnoSLWIIqlkwkFp4i9MffuSU4JFcndT/LQLbYs7Yb0hFZOu1rj4yLKR
	 TGApz7fmbUTxr9cvEDrMpxSpvgi/PkQtFWYZvwrHz9Yv5DctuPX0LwGLGi0PyOwrj3
	 sT25hu4HhtiPBou3KdTuIk/LqMjlFEdWYES4vI2s=
Message-ID: <6fca9c25-843d-5d3d-cd2a-4556731fd6fe@candelatech.com>
Date: Fri, 2 May 2025 13:27:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Intel mld stuck at 40Mhz on 6.15-rc4
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
References: <aee3f644-16f6-6edb-5e45-f9da3c021f89@candelatech.com>
 <ae0d64a2-8a69-37ce-7ca0-a6a73d371a63@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ae0d64a2-8a69-37ce-7ca0-a6a73d371a63@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1746217633-ElfVnDJLf9-s
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1746217633;ElfVnDJLf9-s;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;

On 5/1/25 17:05, Ben Greear wrote:
> On 5/1/25 17:02, Ben Greear wrote:
>> Hello Miri,
>>
>> I am seeing an intel be200 radio using 6.15-rc4 + hacks kernel show only 40Mhz
>> bandwidth on a channel 36 wifi-7 AP that should be supporting at least 80Mhz.
>>
>> I looked through the recent mld related driver patches on linux-wireless
>> but did not see anything that looked like it was addressing this.
>>
>> Do you know if this is a known issue and/or is there a known
>> fix for bandwidth problems in STA mode for the new mld driver?
>>
>> Thanks,
>> Ben
>>
> 
> Gah, I should not send email at the end of the day.
> 
> The system in question is actually using an older kernel with no mld in sight.
> I'll debug it more tomorrow.
> 
> Thanks,
> Ben
> 

So, while not root cause of my issues (I have a generic BIOS w/out this info),
I noticed that mld is using a boolean for this field, but it is actually assigned an int that can
have two bits set.  So maybe something like this is wanted?

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index ad45c64ca196..8adae3620f8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -319,7 +319,7 @@ struct iwl_mld {
         struct led_classdev led;
  #endif
         enum iwl_mcc_source mcc_src;
-       bool bios_enable_puncturing;
+       int bios_enable_puncturing;

         struct iwl_mld_baid_data __rcu *fw_id_to_ba[IWL_MAX_BAID];
         u8 num_rx_ba_sessions;

Thanks,
Ben


