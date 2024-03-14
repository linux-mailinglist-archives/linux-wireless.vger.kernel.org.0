Return-Path: <linux-wireless+bounces-4746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E84787BCDC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 13:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447E6B20E50
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B65811C;
	Thu, 14 Mar 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="v2MCGf7j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FE53E2D
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419511; cv=none; b=UatmRGVsvnpPhsFlAA/thyWaQT662JcsY2cbOxlzMdIAhygP1z5MQCE6NrJw4vJkwnXNQKgyCJ6CXBo6bPzOGXprh5Dyc4boyoKFfS2/NZvLW/b3DvxLf5zuXqmmUI8u/PtjvhkaBzRRoIBr3SKUq+Qo6q8/XcPbSjfgqzH5VmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419511; c=relaxed/simple;
	bh=xZP0lBjNkwnLWtWJybWs/jJTRTA3Y/OQMXmp+1aCZQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f82WNlwS1wK4S1RfLSbWFhjhHASwBnvnXQ0bonGuo5UvmlD/1QZ3xsGs0+srN8Or+S9mFj4DUCkcnk8EG4C/WnRjU24TB6JQoOgBuQdBOdaU3+kkccIH7A4ISgISxmRuFFDEzHigVefRWq/skNK5McCCAVQ/bQaGRoSOupjJrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=v2MCGf7j; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-413fd8e4b3cso34955e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1710419506; x=1711024306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gE5wEUzP7oRy3rpOImMIWYyKlvOqAt+4cy9tZHxAd+w=;
        b=v2MCGf7j45xaZ/8HWvkl5fvTq+xA8iFVaxGlFBhvD3KS4fMp7d6CGG76I/uqnMi5ly
         3e8cfbn2xGewR55w9/wL1sn23Q7K2W6v3ifyeMkzDkX4I31l/9fzLp3S165qQtyCT96F
         a7rUGSE+/JolHe8pLnXotOpPOzICCDIoWgNVVqqWUZldeNY9aRrMV0p8WwaRu0pG8uTr
         gkvu+z57cVUt/05BxYThfezvygVdLk3aLUnl3UtzvvRlaZunXgfgXjLqcIHfWWGSw0ey
         cCLyl8PY8/1HqzL2trbnCHQtUcI+PDQ+bbo8XtmslVsoOU8TqEWQKvY8c82tSPE/ZJhM
         8k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710419506; x=1711024306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE5wEUzP7oRy3rpOImMIWYyKlvOqAt+4cy9tZHxAd+w=;
        b=gZKhprBvtGeQsHp7J4CRFI5h/bGRlT4hu5GW+LW8Y6vlv9q/mWUCrW0ez0BFpZ6x+b
         6JcDGMpfy41pef7DmAo0obZOauhy9haXqYqAhMC/pLa8LMvg9PFV2Mca/mJujFYKjR8+
         t/VRawtAwXzr6Kr4RKXIh9ftm9dVCPozGBeR6VHLDzXPakiBFzK1K4ZCp1kbvrdr0KAH
         FcNJEi5mh8286bpgLZiftNitQmg8zAgqFI8dyPWDh5c5lMejOEUuVaoYpmNMzLXxJ9sL
         73udXLQF40H1kmhVSjDPJHO4eGOqaPWB+/PI7DQ6KkCJ6QuEMZC39+qhbV2ua/PrUiJM
         3xJg==
X-Forwarded-Encrypted: i=1; AJvYcCWCM4cXOJC/RMMj1m0m21PuUY8kw5p1ORhWwflhw5oK4LeMSIlDGFwvmpWdYPBCD7OqsXOasMHrM/YgRWwb64oFBAvIhAdIQSWF8duNSgQ=
X-Gm-Message-State: AOJu0YwYJrzbNcqo0IQn8zSVxNaTbjr7s09pKWRRGAoj5KbzC2t1siYk
	wYxSnOrboymHzH1CBD9OuPSFDAdHuhl0yNwMHRhih5kpDILPnQMaQ1Gk5L4Jqfg=
X-Google-Smtp-Source: AGHT+IGz1iLcUF/1hNFI8SsZo3VRQ0H0FsSZ2Wlq2pNKXkkk0OSmNI0yqN9iyYu5/VCpoSTCzs4/zg==
X-Received: by 2002:a05:600c:3150:b0:413:f7c4:f4fc with SMTP id h16-20020a05600c315000b00413f7c4f4fcmr659441wmo.15.1710419506243;
        Thu, 14 Mar 2024 05:31:46 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b00413e79344b7sm2352745wmo.19.2024.03.14.05.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 05:31:45 -0700 (PDT)
Message-ID: <d23b5fc5-9fc2-4841-8eb9-b22a28f05f69@freebox.fr>
Date: Thu, 14 Mar 2024 13:31:45 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k
 <ath10k@lists.infradead.org>, wireless <linux-wireless@vger.kernel.org>,
 DT <devicetree@vger.kernel.org>, Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
 <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 16:53, Dmitry Baryshkov wrote:

> On Wed, 13 Mar 2024 at 17:09, Marc Gonzalez wrote:
>
>> On 05/03/2024 20:20, Kalle Valo wrote:
>>
>>> Marc Gonzalez wrote:
>>>
>>>> I need to build a kernel + rootfs + FW to test the proposed solution,
>>>> then I can spin a formal submission.
>>>
>>> Yeah, please do test this to make sure we are not missing anything :)
>>
>> I used buildroot ( https://buildroot.org ) to generate a kernel + rootfs
>> for my board (a variation of qcom/msm8998-mtp.dts)
>>
>> Not sure if I must use the vendor FW blobs? Or if I can use the blobs
>> from linux-firmware-20240115.tar.xz (as supported by BR2).
>>
>>
>> All I see from the ath10k driver (with debugging cranked to the max) is:
>>
>> [    0.539801] ath10k_snoc 18800000.wifi: Adding to iommu group 0
>> [    0.541941] ath10k_snoc 18800000.wifi: snoc xo-cal-data return -22
>> [    0.543633] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not found, using dummy regulator
>> [    0.544002] ath10k_snoc 18800000.wifi: qmi msa.paddr: 0x0000000094400000 , msa.vaddr: 0x(____ptrval____)
>> [    0.544271] ath10k_snoc 18800000.wifi: snoc probe
>>
>>
>> # ip link
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
>>     link/ether 34:27:92:82:48:ec brd ff:ff:ff:ff:ff:ff
>>
>> No wlan device at this point.
> 
> Do you have pd-mapper, rmtfs and tqftpserv running? You also need to
> have wlanmdsp.mbn in the same directory as modem.mbn for your platform
> (see how this is handled for sdm845).
> If these points are implemented and you still don't have the wlan,
> please check for tqftpserv messages in syslog.

I first tried using buildroot, which doesn't package these tools AFAICT.
I have now generated a debian rootfs, which does package them.


>> I got shell-shock from reading these setup steps:
>>
>> https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_835_(MSM8998)#WLAN
>> https://github.com/jhugo/linux/blob/5.5rc2_wifi/README
> 
> These readmes are mostly correct. You don't need qrtr now, it is
> provided by the kernel.  pd-mapper (protection-domain-mapper),
> tqftpserv and rmtfs usually can be installed from your distro.

Can you explain a little bit why all the steps are required
just to be able to talk to the ath10k IP block?

It's just an MMIO device, right?

		wifi: wifi@18800000 {
			compatible = "qcom,wcn3990-wifi";
			reg = <0x18800000 0x800000>;
			reg-names = "membase";

Is the IP block behind some kind of switch that must be programmed
by a remote processor on the SoC?

Regards



