Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413A4D624F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfJNMUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 08:20:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42676 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfJNMUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 08:20:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id y91so14602732ede.9
        for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2019 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m/CxiEdckKwLReSUTDQ3wufvnzpVl+4j/+0XnWtbNxk=;
        b=VZgpmuNfDBKE6PfyedfKGYxdxQV/583aElP6aFtEgV1lo8gPfdweaQDPAXxmjrQBbh
         uwqmPitciJSmHHulSys3z/s/Jf7GTCybHBcYR8InzN/XKEP+Yzg8Rnma8sLVBMpBTWgB
         1BZTHWB27yZ+o7MZjjKW65ulS5UFJZvJ2ClIDXRfRYkETbAMgm1Dqro4vhudBl7/j451
         z1vko/Hhox11UAFjO//CJhDeFvvneIhY3lhCIx2JB2+dzqHlYMzsk8du5fXwBEb67ECQ
         WFU7/e5TjxuabZvkBX269WUOfR+tSF5e4ObKqA7qwEDuXe4z2ljUmicrXL4kjDc+ZCTb
         zXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/CxiEdckKwLReSUTDQ3wufvnzpVl+4j/+0XnWtbNxk=;
        b=HjLj1n2eY8PHe0En/NKpGjr8AFOUsy2ZYSodQjVieh6C3VPmT0eh7WSUCyskMHjl9P
         k6Xd7ZRy8bVEOxnTsD+KFz3lG2qAgSCMHdaVQcA5DcNUjoRE7mdz6YAaMzdujsCRPGV5
         U78ryEju/QmEETWLKx5wjCqDXv6+3et/ox9LHFgr7aWRbhZLcHPZ/mfEylqap8jA7cG4
         2bqqoaOs+VzMQ4mdVNHmDQJbXhmvDHjXRcIiOQ/R0/WyOc72jQsR+8HRjEODuz0di4Vr
         Jc4/QsO1uSMdyeqkPwC1F+YLaRH3TWZbsRjO06Vo7qUG/n/+2ieroJ1VDpoa44vlNcPh
         a4kQ==
X-Gm-Message-State: APjAAAVneUL1wuagXBFWySxaMdhjbNzQ37iONTfXcwkXR7x/kFGJc7lv
        lGUrN3j/DIICalLK59BUJvfbaspC
X-Google-Smtp-Source: APXvYqwhj0Da9Ou6i4sUjn3aQXbyoqNJqOwCeP9i6faNWm8Nt+NNSe6r77HzoPLyKTWTXqTU6tkv5g==
X-Received: by 2002:a50:c304:: with SMTP id a4mr28066509edb.303.1571055622040;
        Mon, 14 Oct 2019 05:20:22 -0700 (PDT)
Received: from ?IPv6:2001:db8:4b:222::197? ([2a02:810a:8c0:6498:9d87:72c9:c815:5f34])
        by smtp.gmail.com with ESMTPSA id v8sm3183979edl.74.2019.10.14.05.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 05:20:21 -0700 (PDT)
From:   "g.schlmm" <g.schlmm@googlemail.com>
X-Google-Original-From: "g.schlmm" <g.schlmm@gmail.com>
Subject: Re: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <0d0159a8-a83e-cef3-fd32-4928a2301719@gmail.com>
 <20190612091330.GC2965@redhat.com>
 <F7CD281DE3E379468C6D07993EA72F84D180639E@RTITMBSVM04.realtek.com.tw>
Message-ID: <5960cc5a-becf-8bdc-7898-b9933247b6e3@gmail.com>
Date:   Mon, 14 Oct 2019 14:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D180639E@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14.06.19 10:24, Tony Chuang wrote:
>> Subject: Re: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
>>
>> Cc Tony
>>
>> On Sat, Jun 08, 2019 at 02:26:51PM +0200, g.schlmm wrote:
>>> my RTL8822BE M.2 card is not working with linux 5.2rc3
>>>
>>> the staging r8822be driver in linux 5.1 was working for this card
>>>
>>> from dmesg:
>>>> [    8.001186] rtw_pci 0000:04:00.0: rfe 3 isn't supported
>>>> [    8.003870] rtw_pci 0000:04:00.0: failed to setup chip efuse info
>>>> [    8.006405] rtw_pci 0000:04:00.0: failed to setup chip information
>>>
>>> lspci:
>>>> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
>> RTL8822BE 802.11a/b/g/n/ac WiFi adapter
>>>>         Subsystem: Lenovo RTL8822BE 802.11a/b/g/n/ac WiFi adapter
>>>>         Flags: fast devsel, IRQ 19
>>>>         I/O ports at c000 [size=256]
>>>>         Memory at 81200000 (64-bit, non-prefetchable) [size=64K]
>>>>         Capabilities: [40] Power Management version 3
>>>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>>>         Capabilities: [70] Express Endpoint, MSI 00
>>>>         Capabilities: [100] Advanced Error Reporting
>>>>         Capabilities: [148] Device Serial Number
>> 00-e0-4c-ff-fe-b8-22-01
>>>>         Capabilities: [158] Latency Tolerance Reporting
>>>>         Capabilities: [160] L1 PM Substates
>>>>         Kernel modules: rtwpci
>>
> 
> Hi,
> 
> Please use the attached patch. And RFE type 3 has not been well tested,
> I am not sure if the quality is expected. But it should work fine I guess.
> If there is any further problems, just tell me, thanks.
> 
> Yan-Hsuan
> 

Hi,

the above patch doesnt apply anymore on newer kernel sources.
can we except to see rfe type 3 support in the mainline kernel?
what can i do to help testing, if testing is still needed?

thanx
