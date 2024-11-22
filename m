Return-Path: <linux-wireless+bounces-15585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462719D56C9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 01:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32478B20CF6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C8D23A0;
	Fri, 22 Nov 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeZdTVg9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3AA18651
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732236027; cv=none; b=LO0LmPp1F/2KX8BfgTm5c0QNKi9ZwkQ4xt7NCX4eUq7G71aDNSv1g6MB/5UO2X5WWMcXA4R+jKhculwKURW8PGdjK4d4z2JPC0h2+8jRm1Sc/dWtipgo/O/cKi97HiQpbWNsHr3dpAie13U2tCdcGrz2YU2gjsH8IZMq4uKZpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732236027; c=relaxed/simple;
	bh=koAmQyQVMbACzJzlAU/wukCgyoHbYjxGC3taTiVhzh4=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To; b=dN5llyt3oGjJnEwclopFzAvdArpf2Tf1Z0u2rscdio6vecYL0RzYGsY9D1Mgqd5PkQReMg1Cw/nhtD/Xay7xa9HTcCt9phfQst/LitniwnKp3MFfYG3KfHii9AreTYWGA0sBLe/aYj+iVy6T3xewyq4yAjaPsJFcqN39NLyveRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeZdTVg9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so263148766b.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 16:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732236022; x=1732840822; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOZ70VEtJJoR6bb59SHJ8Mi28at0V21g7r61VNydUEg=;
        b=OeZdTVg9lHVIfXdEfEqMglZbDmgP8od5e/40oETFPzRhzmGyM9fsqbYXLikEtg7loP
         XZWqKNIQZsDDBst+93X/LP4WUqO3BhC3AVQmTA3Eh0zoExzvu097Io2mj1UbhvssX9Ud
         8Ld/l3zaZ6lcPL6WyuS4hNJ7OQwdjnWXshnDN7/3Kcr+8AZ+H6pSio5ycDywBlxH6GrO
         Fo6sOVPM3z/UDgUyRMkHef2ie8lz4QIbQKNEIJI2KWhbL3fo4Y7XxByXmTjdvBkFEWQb
         F1ysFnuCH7PELxjom6LDHUTH/RWAcAz4WZ9T5Hhldp2RC1RmaylFWIAU80IcBMccbhFh
         frlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732236022; x=1732840822;
        h=in-reply-to:content-language:references:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOZ70VEtJJoR6bb59SHJ8Mi28at0V21g7r61VNydUEg=;
        b=SStn8MdWGac/USlgdJpX49rB33mclNo0s/sTTYtJ4MdinGHUav80fA1ZaCTEBL1l7c
         VO4RiFcfdBDeNCL91dkBsGmE6+2Ix0Y9Xwhr2r3nHqO9hA+zZdXO1sj0SqKC0ch5nteb
         LYmHHEXpspG4AikOiKWzjTwytuW3pBpvEm+ejyqGIGb3pPHvRuGmqSV5FK46r9A/2/6m
         m0yBZnL1IJGDlZYeKYwXgLGnAxNQztpx9kPiO2hHdr/31qA9JNXRy62mVsBxMAA397aC
         rZXQpnvcwWq8D8NXhU/d10IaWzePqmSuNSrTQePJVBAvTzuY0TkSGL7dkquKiFVmLsNX
         GMJA==
X-Gm-Message-State: AOJu0Yz70CsrFqwYc7QjU5rO5mEtNx+FKibsbnP/cI72zdCBCgw+HrQe
	jloWGOMweTCDqxnuL+hp6LR+DtOFrkD+iZz3QjWLa6BwZAhg5pAOI7eU+w==
X-Gm-Gg: ASbGnctN22LBT5KuX5Kj+wAhhrE40HW1dmL3xEl6g2vjCEnSskVEFQIFwZ+46EE3YMH
	SoCLEK49fIlYaNcs4Yf2S8kYwy7jpxAvPhcm3y0fDGUlykYN1DxLLGtwIYY87zOTu88qjHXB43V
	DpehjLZ8Eu5FgnZaxxEld7jk+gynU3NSBM2/M8aQdBFOiQ7sINqnokTYSVzfcW06fzUjlABHzIv
	ZhD5iQnNqzofyvZYTAnBUy7RUm21m9DWw8PFCUBt/wZJhHIuF0kFHOX+ysBqLMbp1UfJj5NmgV+
	fzw/c/jjVnZd3tPIlH7cZd3DBijQt/V4jcPkbnytYdFrrg==
X-Google-Smtp-Source: AGHT+IE3OODK3+e61VY4Tvmufm0fm2lZ7Tm4J7MLEW21FGGom+tDPBTcKQAT/Y+bjxvgaTTYkWYElQ==
X-Received: by 2002:a17:906:9d2:b0:aa5:b32:6966 with SMTP id a640c23a62f3a-aa50b327982mr70736666b.50.1732236021789;
        Thu, 21 Nov 2024 16:40:21 -0800 (PST)
Received: from [172.23.31.140] (cable-188-2-10-66.dynamic.sbb.rs. [188.2.10.66])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f88bsm29304066b.2.2024.11.21.16.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 16:40:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------tUqjYLfrzQ8iL0SN0eXBFipT"
Message-ID: <f5c7eb4f-fd8d-457b-92c4-8957f70888b9@gmail.com>
Date: Fri, 22 Nov 2024 01:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zoran Davidovac <zoran.davidovac@gmail.com>
Subject: Regression "Direct Firmware loading for Intel Wi-Fi 6 AX201 (rev 30)
 QuZ-a0-hr-b0-77 failed"
To: linux-wireless@vger.kernel.org,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>
References: <ab27218b-5e16-4932-a497-eb19491568b1@gmail.com>
Content-Language: en-US
In-Reply-To: <ab27218b-5e16-4932-a497-eb19491568b1@gmail.com>

This is a multi-part message in MIME format.
--------------tUqjYLfrzQ8iL0SN0eXBFipT
Content-Type: multipart/alternative;
 boundary="------------0xGfdC05ipYc495dlO9OrPGE"

--------------0xGfdC05ipYc495dlO9OrPGE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi to all,

Year ago I wrote about problem with that kernels 6.5.X, 6.6.X failure 
with firmware loading QuZ-a0-hr-b0-77.ucode,
either direct loading or with included firmware in 
kernel("CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin 
intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc 
iwlwifi-QuZ-a0-hr-b0-77.ucode"caused kernel reboot) and that kernel 
6.4.X could load firmware direct or included.

Year later It is still the same, but with 6.11.X firmware for 22000 does 
not get loaded:
-first problem from 6.5.X and up to latest 6.11.9 I can not direct load 
firmware  QuZ-a0-hr-b0-77.ucode or included,
-second it does not retry to load older firmware as it was decided to 
bump "wifi: iwlwifi: bump min API version for Qu/So devices"
"#define IWL_22000_UCODE_API_MIN        77" in kernel 6.11.X and
direct loading of  QuZ-a0-hr-b0-77.ucode just fail and it will abort any 
further loading of firmware.
(it will not even try to load next working QuZ-a0-hr-b0-74.ucode) And I 
one would have no working wifi!!!

https://patchwork.kernel.org/project/linux-wireless/patch/20230416154301.e522ccefe354.If7628363fafeb7687163103e734206915c445197@changeid/ 

https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/cfg/22000.c 


vanilla kernel from 6.11.9 log:
[    1.903903] Intel(R) Wireless WiFi driver for Linux
[    1.904006] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    1.906832] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 
0x20000302 wfpm id 0x80000000
[    1.906890] iwlwifi 0000:00:14.3: PCI dev a0f0/0074, rev=0x351, 
rfid=0x10a100
[    1.906891] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
...
[    1.907036] iwlwifi 0000:00:14.3: Direct firmware load for 
iwlwifi-QuZ-a0-hr-b0-77.ucode failed with error -2
[    1.907037] iwlwifi 0000:00:14.3: Falling back to sysfs fallback for: 
iwlwifi-QuZ-a0-hr-b0-77.ucode
...
[   62.970034] cfg80211: failed to load regulatory.db
[   62.970035] iwlwifi 0000:00:14.3: no suitable firmware found!
[   62.970038] iwlwifi 0000:00:14.3: iwlwifi-QuZ-a0-hr-b0-77 is required
[   62.970039] iwlwifi 0000:00:14.3: check 
git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

I reverted min API version to 74 (611wifi) patch to be able to use wifi
/* Lowest firmware API version supported */
-#define IWL_22000_UCODE_API_MIN        77
+#define IWL_22000_UCODE_API_MIN        74
Now I get the same behavior as with 6.10.X direct loading of 
QuZ-a0-hr-b0-77.ucode would also fail,
*but* after 60 seconds it would try and fail with 
"iwlwifi-QuZ-a0-hr-b0-76.ucode"and after some tries/time
it would load "iwlwifi-QuZ-a0-hr-b0-74.ucode" and wifi would work!

*Important is while comparing and playing with wifi firmware:*
-1-I found that direct loading of 
/lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode  always fail no matter what 
firmware it is.
I've renamed .74 to .77  and it still failed to load and at that time I 
realized that this is not QuZ-a0-hr-b0-77 firmware problem,
but either card timeout or (direct) firmware loading problem with AX201, 
it is not due disk delay as I've tested this year ago.

-2-kernel 6.4.X worked ok "iwlwifi-QuZ-a0-hr-b0-77.ucode"

-3-problem started with 6.5.X and it still present in 6.11.9!

-4-With 611wifi patch and 
  iwlwifi-QuZ-a0-hr-b0-77.ucode==iwlwifi-QuZ-a0-hr-b0-76.ucode==iwlwifi-QuZ-a0-hr-b0-75.ucode
# md5sum /lib/firmware/iwlwifi-QuZ-a0-hr-b0-7*|tail -n3
bde23ede60857d00768a7f6ca7041cc6 
  /lib/firmware/iwlwifi-QuZ-a0-hr-b0-75.ucode
bde23ede60857d00768a7f6ca7041cc6 
  /lib/firmware/iwlwifi-QuZ-a0-hr-b0-76.ucode
bde23ede60857d00768a7f6ca7041cc6 
  /lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode
# ls -all /lib/firmware/iwlwifi-QuZ-a0-hr-b0-7*|tail -n3
-rw-r--r-- 1 root root 1406124 Nov 13 02:43 
/lib/firmware/iwlwifi-QuZ-a0-hr-b0-75.ucode
-rw-r--r-- 1 root root 1406124 Nov 13 02:43 
/lib/firmware/iwlwifi-QuZ-a0-hr-b0-76.ucode
-rw-r--r-- 1 root root 1406124 Nov 14 20:24 
/lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode
after failing v77, kernel can retry and manage to load v76 (that is 
actually v77) and this works!

vanilla kernel from 6.11.9+611wifi patch log:
[    0.906238] pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000 PCIe 
Root Complex Integrated Endpoint
[    0.906276] pci 0000:00:14.3: BAR 0 [mem 0x603f29c000-0x603f29ffff 
64bit]
[    0.906416] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.948151] pci 0000:00:14.3: Adding to iommu group 11
[    1.947555] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    1.950802] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 
0x20000302 wfpm id 0x80000000
[    1.950876] iwlwifi 0000:00:14.3: PCI dev a0f0/0074, rev=0x351, 
rfid=0x10a100
[    1.950887] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz
[    1.951071] iwlwifi 0000:00:14.3: Direct firmware load for 
iwlwifi-QuZ-a0-hr-b0-77.ucode failed with error -2
[    1.951099] iwlwifi 0000:00:14.3: Falling back to sysfs fallback for: 
iwlwifi-QuZ-a0-hr-b0-77.ucode
[   62.974355] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 
89.3.35.37
[  124.410124] iwlwifi 0000:00:14.3: loaded firmware version 
77.0b4c06ad.0 QuZ-a0-hr-b0-76.ucode op_mode iwlmvm
[  124.533571] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
[  124.598887] iwlwifi 0000:00:14.3: base HW address: cc:15:31:4b:f9:7e
[  124.857428] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, 
with index: 1


Problems that I see:
-why direct loading fail at first
-when firmware is in kernel ("CONFIG_EXTRA_FIRMWARE="... 
iwlwifi-QuZ-a0-hr-b0-77.ucode") why it is causing just reboots

We know:
-It was working in 6.4.X and right iwlwifi-QuZ-a0-hr-b0-77.ucode was loaded!
-And it may not be problem with firmware as I believed year ago.

(Again) I am using stock vanilla kernel, from kernel.org and compiling 
it with attached config,
distro info:Slackware current x64 :)
my wifi:
0000:00:14.3 Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 30)

0000:00:14.3 0280: 8086:a0f0 (rev 30)
       DeviceName: WLAN
       Subsystem: 8086:0074
       Flags: bus master, fast devsel, latency 0, IRQ 19, IOMMU group 11
       Memory at 603f29c000 (64-bit, non-prefetchable) [size=16K]
       Capabilities: [c8] Power Management version 3
       Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
       Capabilities: [40] Express Root Complex Integrated Endpoint, 
IntMsgNum 0
       Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
       Capabilities: [100] Latency Tolerance Reporting
       Capabilities: [164] Vendor Specific Information: ID=0010 Rev=0 
Len=014 <?>
       Kernel driver in use: iwlwifi

Keep up doing great work, and like last time I am offering to do any 
testing, or answer any question.

Kind Regards,

Zoran





On 12/8/23 06:15, Zoran Davidovac wrote:
> Hi,
>
> I've noticed two problems with loading firmware QuZ-a0-hr-b0-7X.ucode 
> and booting  problem,
> probably some another maintainer is in charge for that, please add them.
>
> *1.failure to load QuZ-a0-hr-b0-77.ucode*
> with kernel 6.5.x and 6.6.X 77.bd067429.0 QuZ-a0-hr-b0-77.ucode fails 
> to load, but with 6.4.X loads it fine:
>
> Dec  4 16:25:19 Expert kernel: Linux version 6.4.16-eb-64GB-frm2go 
> (root@Expert.vm) (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #1 
> SMP PREEMPT_DYNAMIC Mon Oct 23 02:12:47 CEST 2023
> Dec  4 15:43:43 Expert kernel: iwlwifi 0000:00:14.3: loaded firmware 
> version 77.bd067429.0 QuZ-a0-hr-b0-77.ucode op_mode iwlmvm
>
> Dec  7 10:40:46 Expert kernel: Linux version 6.6.4-eb-64GB-frm2go-a 
> (root@Expert.vm) (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #6 
> SMP PREEMPT_DYNAMIC Thu Dec  7 04:57:29 CET 2023
> Dec  7 10:44:53 Expert kernel: iwlwifi 0000:00:14.3: loaded firmware 
> version 74.a5e9588b.0 QuZ-a0-hr-b0-74.ucode op_mode iwlmvm
>
> *2.failure to boot (this should not happened no matter what firmware I 
> include with kernel)*
>
> there is another weird problem if firmware QuZ-a0-hr-b0-77.ucode is  
> included *with kernel 6.5.X and 6.6.X* it restart itself at boot
>
>
> To explain a bit why and what I've tried:
> why:I did not want to wait for right firmware to load and wanted to 
> have working Wifi at boot
> so I've compiled custom kernel for personal use that have built in the 
> following firmware in kernel 6.4.16
> CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin intel/ibt-19-0-4.sfi 
> intel/ibt-19-0-4.ddc iwlwifi-QuZ-a0-hr-b0-77.ucode"
>
> Now with kernel 6.5.X I've noticed upon boot instant reboots, but I 
> did not had time to debug the problem,
> same is with 6.6.3 and 6.6.4, but now I had to debug and I've found 
> the following:
>
>
> -2.1. no booting problem with CONFIG_EXTRA_FIRMWARE=""
>
> and returning back firmware (one by one and compiling) I found out 
> that  with CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin 
> intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc" works
>
> but not booting with CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin 
> intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc iwlwifi-QuZ-a0-hr-b0-77.ucode"
>
> -2.2.Debugging: I've tried the following as I've noticed firmware have 
> changed:
> cc0698c4b69c7b495f4bbee16dbd141f 
>  ./intel/linux-firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode
> 3f2db8edac740f501e67121842b539dc 
>  ./intel/915/linux-firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode
> 3f2db8edac740f501e67121842b539dc 
>  /lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode
>
> also on git 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/iwlwifi-QuZ-a0-hr-b0-77.ucode?id=4fc5801ee0e7d41d945a8a6c06e0542ec9fa47e0
>
> but with none of iwlwifi-QuZ-a0-hr-b0-77.ucode  is not working with 
> 6.5.X and 6.6.X
>
> -2.3. with kernel compiled without any iwlwifi-QuZ-a0-hr-b0-7X.ucode 
> firmware (CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin 
> intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc" or "")
> kernel 6.4.14 is working with  firmware iwlwifi-QuZ-a0-hr-b0-77.ucode 
> while 6.6.4 fall loads only QuZ-a0-hr-b0-74.ucode
>
> root@Expert:/usr/src/asus/book# less /var/log/messages |grep -i "linux 
> version\|QuZ-a0-hr-b0-7"
> Dec  4 16:25:19 Expert kernel: Linux version 6.4.16-eb-64GB-frm2go 
> (root@Expert.vm) (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #1 
> SMP PREEMPT_DYNAMIC Mon Oct 23 02:12:47 CEST 2023
> Dec  4 16:26:38 Expert kernel: Linux version 6.4.16-eb-64GB-frm2go 
> (root@Expert.vm) (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #1 
> SMP PREEMPT_DYNAMIC Mon Oct 23 02:12:47 CEST 2023
> ...
> Dec  7 10:40:46 Expert kernel: Linux version 6.6.4-eb-64GB-frm2go-a 
> (root@Expert.vm) (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #6 
> SMP PREEMPT_DYNAMIC Thu Dec  7 04:57:29 CET 2023
> Dec  7 10:44:53 Expert kernel: iwlwifi 0000:00:14.3: loaded firmware 
> version 74.a5e9588b.0 QuZ-a0-hr-b0-74.ucode op_mode iwlmvm
>
>
> I am available If I can do any test, problem is detected on "Product 
> Name: ASUS EXPERTBOOK B7402FEA_B7402FEA"
>
>
> Regards,
>
>
>  Zoran
>
>

--------------0xGfdC05ipYc495dlO9OrPGE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix"><span style="font-family:monospace"><span
          style="color:#000000;background-color:#ffffff;">Hi to all,
        </span><br>
        <br>
        Year ago I wrote about problem with that kernels 6.5.X, 6.6.X
        failure with firmware loading QuZ-a0-hr-b0-77.ucode,
        <br>
        either direct loading or with included firmware in
        kernel("CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin
        intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc
        iwlwifi-QuZ-a0-hr-b0-77.ucode"caused kernel reboot) and that
        kernel 6.4.X could load firmware direct or included.
        <br>
        <br>
        Year later It is still the same, but with 6.11.X firmware for
        22000 does not get loaded:
        <br>
        -first problem from 6.5.X and up to latest 6.11.9 I can not
        direct load firmware  QuZ-a0-hr-b0-77.ucode or included,
        <br>
        -second it does not retry to load older firmware as it was
        decided to bump "wifi: iwlwifi: bump min API version for Qu/So
        devices" <br>
        "#define IWL_22000_UCODE_API_MIN        77" in kernel 6.11.X and
         <br>
        direct loading of  QuZ-a0-hr-b0-77.ucode just fail and it will
        abort any further loading of firmware. <br>
        (it will not even try to load next working
        QuZ-a0-hr-b0-74.ucode) And I one would have no working wifi!!!
        <br>
        <br>
<a class="moz-txt-link-freetext" href="https://patchwork.kernel.org/project/linux-wireless/patch/20230416154301.e522ccefe354.If7628363fafeb7687163103e734206915c445197@changeid/">https://patchwork.kernel.org/project/linux-wireless/patch/20230416154301.e522ccefe354.If7628363fafeb7687163103e734206915c445197@changeid/</a>
        <br>
<a class="moz-txt-link-freetext" href="https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/cfg/22000.c">https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/cfg/22000.c</a>
        <br>
        <br>
        vanilla kernel from 6.11.9 log:
        <br>
        [    1.903903] Intel(R) Wireless WiFi driver for Linux
        <br>
        [    1.904006] iwlwifi 0000:00:14.3: enabling device (0000 -&gt;
        0002)
        <br>
        [    1.906832] iwlwifi 0000:00:14.3: Detected crf-id 0x3617,
        cnv-id 0x20000302 wfpm id 0x80000000
        <br>
        [    1.906890] iwlwifi 0000:00:14.3: PCI dev a0f0/0074,
        rev=0x351, rfid=0x10a100
        <br>
        [    1.906891] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6
        AX201 160MHz
        <br>
        ...<br>
        [    1.907036] iwlwifi 0000:00:14.3: Direct firmware load for
        iwlwifi-QuZ-a0-hr-b0-77.ucode failed with error -2
        <br>
        [    1.907037] iwlwifi 0000:00:14.3: Falling back to sysfs
        fallback for: iwlwifi-QuZ-a0-hr-b0-77.ucode
        <br>
        ...<br>
        [   62.970034] cfg80211: failed to load regulatory.db
        <br>
        [   62.970035] iwlwifi 0000:00:14.3: no suitable firmware found!
        <br>
        [   62.970038] iwlwifi 0000:00:14.3: iwlwifi-QuZ-a0-hr-b0-77 is
        required
        <br>
        [   62.970039] iwlwifi 0000:00:14.3: check
<a class="moz-txt-link-freetext" href="git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git">git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git</a><br>
        <br>
        I reverted min API version to 74 (611wifi) patch to be able to
        use wifi 
        <br>
        /* Lowest firmware API version supported */
        <br>
        -#define IWL_22000_UCODE_API_MIN        77
        <br>
        +#define IWL_22000_UCODE_API_MIN        74
        <br>
        Now I get the same behavior as with 6.10.X direct loading of
        QuZ-a0-hr-b0-77.ucode would also fail, <br>
        *but* after 60 seconds it would try and fail with
        "iwlwifi-QuZ-a0-hr-b0-76.ucode"and after some tries/time
        <br>
        it would load "iwlwifi-QuZ-a0-hr-b0-74.ucode" and wifi would
        work!
        <br>
        <br>
        *Important is while comparing and playing with wifi firmware:*
        <br>
        -1-I found that direct loading of
        /lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode  always fail no
        matter what firmware it is.
        <br>
        I've renamed .74 to .77  and it still failed to load and at that
        time I realized that this is not QuZ-a0-hr-b0-77 firmware
        problem,
        <br>
        but either card timeout or (direct) firmware loading problem
        with AX201, it is not due disk delay as I've tested this year
        ago.
        <br>
           <br>
        -2-kernel 6.4.X worked ok "iwlwifi-QuZ-a0-hr-b0-77.ucode"
        <br>
        <br>
        -3-problem started with 6.5.X and it still present in 6.11.9!
        <br>
        <br>
        -4-With 611wifi patch and
 iwlwifi-QuZ-a0-hr-b0-77.ucode==iwlwifi-QuZ-a0-hr-b0-76.ucode==iwlwifi-QuZ-a0-hr-b0-75.ucode<br>
        # md5sum /lib/firmware/iwlwifi-QuZ-a0-hr-b0-7*|tail -n3
        <br>
        bde23ede60857d00768a7f6ca7041cc6
         /lib/firmware/iwlwifi-QuZ-a0-hr-b0-75.ucode
        <br>
        bde23ede60857d00768a7f6ca7041cc6
         /lib/firmware/iwlwifi-QuZ-a0-hr-b0-76.ucode
        <br>
        bde23ede60857d00768a7f6ca7041cc6
         /lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode
        <br>
        # ls -all /lib/firmware/iwlwifi-QuZ-a0-hr-b0-7*|tail -n3
        <br>
        -rw-r--r-- 1 root root 1406124 Nov 13 02:43
        /lib/firmware/iwlwifi-QuZ-a0-hr-b0-75.ucode
        <br>
        -rw-r--r-- 1 root root 1406124 Nov 13 02:43
        /lib/firmware/iwlwifi-QuZ-a0-hr-b0-76.ucode
        <br>
        -rw-r--r-- 1 root root 1406124 Nov 14 20:24
        /lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode
        <br>
        after failing v77, kernel can retry and manage to load v76 (that
        is actually v77) and this works!
        <br>
      </span><span style="font-family:monospace"><br>
        vanilla kernel from 6.11.9+611wifi patch log:</span><br>
      <span style="font-family:monospace"><span
          style="color:#000000;background-color:#ffffff;">[    0.906238]
          pci 0000:00:14.3: [8086:a0f0] type 00 class 0x028000 PCIe Root
          Complex Integrated Endpoint
        </span><br>
        [    0.906276] pci 0000:00:14.3: BAR 0 [mem
        0x603f29c000-0x603f29ffff 64bit]
        <br>
        [    0.906416] pci 0000:00:14.3: PME# supported from D0 D3hot
        D3cold
        <br>
        [    0.948151] pci 0000:00:14.3: Adding to iommu group 11
        <br>
        [    1.947555] iwlwifi 0000:00:14.3: enabling device (0000 -&gt;
        0002)
        <br>
        [    1.950802] iwlwifi 0000:00:14.3: Detected crf-id 0x3617,
        cnv-id 0x20000302 wfpm id 0x80000000
        <br>
        [    1.950876] iwlwifi 0000:00:14.3: PCI dev a0f0/0074,
        rev=0x351, rfid=0x10a100
        <br>
        [    1.950887] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6
        AX201 160MHz
        <br>
        [    1.951071] iwlwifi 0000:00:14.3: Direct firmware load for
        iwlwifi-QuZ-a0-hr-b0-77.ucode failed with error -2
        <br>
        [    1.951099] iwlwifi 0000:00:14.3: Falling back to sysfs
        fallback for: iwlwifi-QuZ-a0-hr-b0-77.ucode
        <br>
        [   62.974355] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ
        Version: 89.3.35.37
        <br>
        [  124.410124] iwlwifi 0000:00:14.3: loaded firmware version
        77.0b4c06ad.0 QuZ-a0-hr-b0-76.ucode op_mode iwlmvm
        <br>
        [  124.533571] iwlwifi 0000:00:14.3: Detected RF HR B3,
        rfid=0x10a100
        <br>
        [  124.598887] iwlwifi 0000:00:14.3: base HW address:
        cc:15:31:4b:f9:7e
        <br>
        [  124.857428] iwlwifi 0000:00:14.3: Registered PHC clock:
        iwlwifi-PTP, with index: 1<br>
        <br>
      </span><span style="font-family:monospace"><br>
        Problems that I see:
        <br>
        -why direct loading fail at first  <br>
        -when firmware is in kernel ("CONFIG_EXTRA_FIRMWARE="...
        iwlwifi-QuZ-a0-hr-b0-77.ucode") why it is causing just reboots
        <br>
        <br>
        We know:<br>
        -It was working in 6.4.X and right </span><span
        style="font-family:monospace">iwlwifi-QuZ-a0-hr-b0-77.ucode was
        loaded!<br>
        -And it may not be problem with firmware as I believed year ago.</span><br>
      <span style="font-family:monospace"><br>
        (Again) I am using stock vanilla kernel, from kernel.org and
        compiling it with attached config,<br>
        distro <a class="moz-txt-link-freetext" href="info:Slackware">info:Slackware</a> current x64 :)
        <br>
        my wifi:
        <br>
        0000:00:14.3 Network controller: Intel Corporation Wi-Fi 6 AX201
        (rev 30)
        <br>
        <br>
        0000:00:14.3 0280: 8086:a0f0 (rev 30)
        <br>
              DeviceName: WLAN
        <br>
              Subsystem: 8086:0074
        <br>
              Flags: bus master, fast devsel, latency 0, IRQ 19, IOMMU
        group 11
        <br>
              Memory at 603f29c000 (64-bit, non-prefetchable) [size=16K]
        <br>
              Capabilities: [c8] Power Management version 3
        <br>
              Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        <br>
              Capabilities: [40] Express Root Complex Integrated
        Endpoint, IntMsgNum 0
        <br>
              Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
        <br>
              Capabilities: [100] Latency Tolerance Reporting
        <br>
              Capabilities: [164] Vendor Specific Information: ID=0010
        Rev=0 Len=014 &lt;?&gt;
        <br>
              Kernel driver in use: iwlwifi
        <br>
        <br>
        Keep up doing great work, and like last time I am offering to do
        any testing, or answer any question.
        <br>
        <br>
        Kind Regards,
        <br>
        <br>
        Zoran<br>
        <br>
      </span><br>
      <br>
      <br>
      <br>
      On 12/8/23 06:15, Zoran Davidovac wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:ab27218b-5e16-4932-a497-eb19491568b1@gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      Hi,<br>
      <br>
      I've noticed two problems with loading firmware <span
        style="color:#000000;background-color:#ffffff;">QuZ-a0-hr-b0-7X.ucode
        and booting  problem,<br>
        probably some another maintainer is in charge for that, please
        add them.</span><br>
      <br>
      <b>1.failure to load QuZ-a0-hr-b0-77.ucode</b><br>
      with kernel 6.5.x and 6.6.X 77.bd067429.0 QuZ-a0-hr-b0-77.ucode
      fails to load, but with 6.4.X loads it fine:<br>
      <br>
      Dec  4 16:25:19 Expert kernel: Linux version 6.4.16-eb-64GB-frm2go
      (<a class="moz-txt-link-abbreviated moz-txt-link-freetext"
        href="mailto:root@Expert.vm" moz-do-not-send="true">root@Expert.vm</a>)
      (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #1 SMP
      PREEMPT_DYNAMIC Mon Oct 23 02:12:47 CEST 2023 <br>
      Dec  4 15:43:43 Expert kernel: iwlwifi 0000:00:14.3: loaded
      firmware version 77.bd067429.0 QuZ-a0-hr-b0-77.ucode op_mode
      iwlmvm <br>
      <br>
      Dec  7 10:40:46 Expert kernel: Linux version
      6.6.4-eb-64GB-frm2go-a (<a
        class="moz-txt-link-abbreviated moz-txt-link-freetext"
        href="mailto:root@Expert.vm" moz-do-not-send="true">root@Expert.vm</a>)
      (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #6 SMP
      PREEMPT_DYNAMIC Thu Dec  7 04:57:29 CET 2023 <br>
      Dec  7 10:44:53 Expert kernel: iwlwifi 0000:00:14.3: loaded
      firmware version 74.a5e9588b.0 QuZ-a0-hr-b0-74.ucode op_mode
      iwlmvm<br>
      <br>
      <p><b>2.failure to boot (this should not happened no matter what
          firmware I include with kernel)</b><br>
      </p>
      <p>there is another weird problem if
        firmware QuZ-a0-hr-b0-77.ucode is  included *with kernel 6.5.X
        and 6.6.X* it restart itself at boot</p>
      <br>
      To explain a bit why and what I've tried: <br>
      why:I did not want to wait for right firmware to load and wanted
      to have working Wifi at boot<br>
      so I've compiled custom kernel for personal use that have built in
      the following firmware in kernel 6.4.16<br>
      <span style="color:#000000;background-color:#ffffff;">CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin
        intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc
        iwlwifi-QuZ-a0-hr-b0-77.ucode"</span><br>
      <p>Now with kernel 6.5.X I've noticed upon boot instant reboots,
        but I did not had time to debug the problem,<br>
        same is with 6.6.3 and 6.6.4, but now I had to debug and I've
        found the following:</p>
      <br>
      -2.1. no booting problem with <span
        style="color:#000000;background-color:#ffffff;">CONFIG_EXTRA_FIRMWARE=""
      </span><br>
      <br>
      and returning back firmware (one by one and compiling) I found out
      that  with <span style="color:#000000;background-color:#ffffff;">CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin
        intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc" works</span><br>
      <br>
      but not booting with <span
        style="color:#000000;background-color:#ffffff;">CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin
        intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc
        iwlwifi-QuZ-a0-hr-b0-77.ucode"</span><br>
      <br>
      -2.2.Debugging: I've tried the following as I've noticed firmware
      have changed:<br>
      cc0698c4b69c7b495f4bbee16dbd141f
       ./intel/linux-firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode <br>
      3f2db8edac740f501e67121842b539dc
       ./intel/915/linux-firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode <br>
      3f2db8edac740f501e67121842b539dc
       /lib/firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode<br>
      <br>
      also on git  <a class="moz-txt-link-freetext"
href="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/iwlwifi-QuZ-a0-hr-b0-77.ucode?id=4fc5801ee0e7d41d945a8a6c06e0542ec9fa47e0"
        moz-do-not-send="true">https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/iwlwifi-QuZ-a0-hr-b0-77.ucode?id=4fc5801ee0e7d41d945a8a6c06e0542ec9fa47e0</a><br>
      <br>
      but with none of iwlwifi-QuZ-a0-hr-b0-77.ucode  is not working
      with 6.5.X and 6.6.X<br>
      <br>
      -2.3. with kernel compiled without any
      iwlwifi-QuZ-a0-hr-b0-7X.ucode firmware (<span
        style="color:#000000;background-color:#ffffff;">CONFIG_EXTRA_FIRMWARE="i915/tgl_dmc_ver2_12.bin
        intel/ibt-19-0-4.sfi intel/ibt-19-0-4.ddc" or "")  </span><br>
      kernel 6.4.14 is working with  firmware
      iwlwifi-QuZ-a0-hr-b0-77.ucode while 6.6.4 fall loads only
      QuZ-a0-hr-b0-74.ucode<br>
      <br>
      <span style="color:#000000;background-color:#ffffff;">root@Expert:/usr/src/asus/book#
        less /var/log/messages |grep -i "linux version\|QuZ-a0-hr-b0-7"
      </span><br>
      Dec  4 16:25:19 Expert kernel: Linux version 6.4.16-eb-64GB-frm2go
      (<a class="moz-txt-link-abbreviated moz-txt-link-freetext"
        href="mailto:root@Expert.vm" moz-do-not-send="true">root@Expert.vm</a>)
      (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #1 SMP
      PREEMPT_DYNAMIC Mon Oct 23 02:12:47 CEST 2023 <br>
      Dec  4 16:26:38 Expert kernel: Linux version 6.4.16-eb-64GB-frm2go
      (<a class="moz-txt-link-abbreviated moz-txt-link-freetext"
        href="mailto:root@Expert.vm" moz-do-not-send="true">root@Expert.vm</a>)
      (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #1 SMP
      PREEMPT_DYNAMIC Mon Oct 23 02:12:47 CEST 2023 <br>
      ...<br>
      Dec  7 10:40:46 Expert kernel: Linux version
      6.6.4-eb-64GB-frm2go-a (<a
        class="moz-txt-link-abbreviated moz-txt-link-freetext"
        href="mailto:root@Expert.vm" moz-do-not-send="true">root@Expert.vm</a>)
      (gcc (GCC) 13.2.0, GNU ld version 2.41-slack151) #6 SMP
      PREEMPT_DYNAMIC Thu Dec  7 04:57:29 CET 2023 <br>
      Dec  7 10:44:53 Expert kernel: iwlwifi 0000:00:14.3: loaded
      firmware version 74.a5e9588b.0 QuZ-a0-hr-b0-74.ucode op_mode
      iwlmvm<br>
      <p><br>
      </p>
      <p>I am available If I can do any test, problem is detected on "<span
          style="font-family:monospace"><span
            style="color:#000000;background-color:#ffffff;">Product
            Name: ASUS EXPERTBOOK B7402FEA_B7402FEA</span></span>"<br>
      </p>
      <p><span style="font-family:monospace"><br>
          Regards,</span></p>
      <p><span style="font-family:monospace"><br>
        </span></p>
      <p><span style="font-family:monospace"> Zoran<br>
        </span></p>
      <br>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------0xGfdC05ipYc495dlO9OrPGE--
--------------tUqjYLfrzQ8iL0SN0eXBFipT
Content-Type: text/plain; charset=UTF-8; name="611wifi"
Content-Disposition: attachment; filename="611wifi"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTYuMTEuNy9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Nm
Zy8yMjAwMC5jCTIwMjQtMTEtMDggMTY6MzE6MDQuMDAwMDAwMDAwICswMTAwCisrKyBsaW51
eC02LjExLjUvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvMjIwMDAu
YwkyMDI0LTEwLTI4IDA2OjQ2OjE2LjY5MDAxOTkyMyArMDEwMApAQCAtMTMsNyArMTMsNyBA
QAogI2RlZmluZSBJV0xfMjIwMDBfVUNPREVfQVBJX01BWAk3NwogCiAvKiBMb3dlc3QgZmly
bXdhcmUgQVBJIHZlcnNpb24gc3VwcG9ydGVkICovCi0jZGVmaW5lIElXTF8yMjAwMF9VQ09E
RV9BUElfTUlOCTc3CisjZGVmaW5lIElXTF8yMjAwMF9VQ09ERV9BUElfTUlOCTc0CiAKIC8q
IE5WTSB2ZXJzaW9ucyAqLwogI2RlZmluZSBJV0xfMjIwMDBfTlZNX1ZFUlNJT04JCTB4MGEx
ZApAQCAtNDI2LDMgKzQyNiwzMCBAQAogTU9EVUxFX0ZJUk1XQVJFKElXTF9RVVpfQV9IUl9C
X01PRFVMRV9GSVJNV0FSRShJV0xfMjIwMDBfVUNPREVfQVBJX01BWCkpOwogTU9EVUxFX0ZJ
Uk1XQVJFKElXTF9RVVpfQV9KRl9CX01PRFVMRV9GSVJNV0FSRShJV0xfMjIwMDBfVUNPREVf
QVBJX01BWCkpOwogTU9EVUxFX0ZJUk1XQVJFKElXTF9DQ19BX01PRFVMRV9GSVJNV0FSRShJ
V0xfMjIwMDBfVUNPREVfQVBJX01BWCkpOworCisKKworCisKKworCisKKworCisKKworCisK
KworCisKKworCisKKworCisKKworCisKKwo=
--------------tUqjYLfrzQ8iL0SN0eXBFipT
Content-Type: application/gzip; name="6118.zd.kernelconfig.gz"
Content-Disposition: attachment; filename="6118.zd.kernelconfig.gz"
Content-Transfer-Encoding: base64

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

--------------tUqjYLfrzQ8iL0SN0eXBFipT--

