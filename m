Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03E36F7AB3
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 03:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEEBf4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 21:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEBfz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 21:35:55 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8DE11B47
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 18:35:54 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-54c6c4c4845so627651eaf.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 18:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683250553; x=1685842553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z0wUVYjmCB20u3Vom7wnQiPFIize619OP7FEu4CRV0g=;
        b=jMFefYVBseZVSHuo5KszGNDI4Us7mB1HWimkFItdx7SnwiiM5dodkN8OtWz03ZLG/d
         TUGvAjEq7UliS/HPE7RZaGzCyg83Fnq1Ds17aWIhDOK0E8bgGnsalQQjLsrAItIaJqX+
         GZDtq8VvOozsl9/Ires6840zVARadN1V4r6kBoDXBHZCdcW/KJdrEBUJax0CQOGG5lXq
         v1msKnmkboZBt7rw1UBORHl1CiAQK6Hv7iqn0SAEDmOoCn2ohi/CNCvxb/BvXYNU7/QF
         fw8sV10j27Ry4LrwebcZhNCeZ43CVz1voZxDujFRZlwUL4cJZslF6YMRciC4wwKn6VZm
         AhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683250553; x=1685842553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0wUVYjmCB20u3Vom7wnQiPFIize619OP7FEu4CRV0g=;
        b=NZzDUGpIjcQop4PKBYXApkseS5400Rxdo5WT8DW/XxJ3VJlwg8Xsz6H4B9/nSMI2fV
         m+Ua6KE2ypbhYsEjEH+o1vQlOeoBkeFjNNsDhd4quGw4kTIhf8RoOAV1Yb8RzJpD5qFA
         V5f0tv1k5bCWUFAFCiBl14Crmk5jtiRSweWw5wAKso2DlRh+CVBjK7o9Gkn2kLF49UfM
         ytCBSypMSdujScu6x6v1zBktzRLByuqaROpryRv52ohhLNi2i6VkewuutBPr2/+LpkgS
         /n+wIR4vkaDKWfnL4xltRc1WQMm+SfqUOC61e0Syhg6roATaejQuAOnfLXCT4T/+UCSr
         2Aiw==
X-Gm-Message-State: AC+VfDxFBf+Rb6iqKHYSx6kBFbQ1q2rJY/mhh0CAPsNNZaBuquh0MFP0
        YEKUJ1QEDvLGrcTjqjHAcguZQGUwVCI=
X-Google-Smtp-Source: ACHHUZ58P8Md5Z46ecXQyn6xdT1W+nNTDbGW91DAknfXDfkDIF55w09/++AjEYyc6/75dcdiSHiFEA==
X-Received: by 2002:aca:ba41:0:b0:38e:a005:720b with SMTP id k62-20020acaba41000000b0038ea005720bmr2161005oif.1.1683250553384;
        Thu, 04 May 2023 18:35:53 -0700 (PDT)
Received: from [192.168.0.117] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id c5-20020a4ad8c5000000b0054cbf3be7e1sm383853oov.32.2023.05.04.18.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 18:35:53 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b5f379e5-1917-d83b-ab3b-b651444d8f67@lwfinger.net>
Date:   Thu, 4 May 2023 20:35:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Slow RTL8822CE 802.11ac PCIe Wireless Network Adapter
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
 <b7a59145-37b0-eade-3a9e-b565cc75de35@lwfinger.net>
 <4b3f4c5b-cada-bb7c-65f3-936437261b08@amd.com>
 <98f8852a-1710-2792-3196-e74fe614a03d@lwfinger.net>
 <eed0261b-6447-fe8a-ef98-073ae45ff137@amd.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <eed0261b-6447-fe8a-ef98-073ae45ff137@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/23 20:23, Alexey Kardashevskiy wrote:
> 
> 
> On 5/5/23 01:04, Larry Finger wrote:
>> On 5/3/23 22:10, Alexey Kardashevskiy wrote:
>>> My bad, I should have mentioned that I tried this one as well, 
>>> https://github.com/lwfinger/rtw88/commit/75e2c81 3weeks old, no difference 
>>> there.
>>>
>>> And it does not look like there was any change related to my problem since 
>>> then, is it still worth trying the very latest version? Btw reboot is not 
>>> really required, it is Linux, not Windows, rmmod+modprobe should do 😉 Thanks,
>>
>> I added a bunch of stuff on April 24-25, so a 3-week old pull would have 
>> missed some important stuff.
>>
>> The problem with rmmod+modprobe is that the rtw88_core module is not removed, 
>> certainly not with a 'sudo modprobe -rv rtw88_8822ce, and it is really easy to 
>> get a mixed bunch. I get tired of explaining that to a bunch of newbies, thus 
>> I recommend a reboot. Of course, I do not reboot.
> 
> Turns out I had to reboot because of the module signature :-/
> 
> Anyway it does not appear to work any better. Below are bad ping and good ping, 
> the difference is moving laptop 2cm to the left. I believe the right driver is 
> loaded as the modules are "rtw_" and not "rtw88_". It is quite bizarre how 
> moving the laptop for a little bit helps and moving it back does not necessarily 
> put it in the bad state, may be there is a microcrack in some PCB or something :-/
> 
> 
> aik@aiemdeew ~> ping -c3 192.168.10.200 ; iw wlp1s0 link | grep signal
> PING 192.168.10.200 (192.168.10.200) 56(84) bytes of data.
> 64 bytes from 192.168.10.200: icmp_seq=1 ttl=64 time=7707 ms
> 64 bytes from 192.168.10.200: icmp_seq=2 ttl=64 time=6677 ms
> 64 bytes from 192.168.10.200: icmp_seq=3 ttl=64 time=5653 ms
> 
> --- 192.168.10.200 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2054ms
> rtt min/avg/max/mdev = 5653.382/6679.203/7706.911/838.350 ms, pipe 3
>      signal: -56 dBm
> aik@aiemdeew ~> ping -c3 192.168.10.200 ; iw wlp1s0 link | grep signal
> PING 192.168.10.200 (192.168.10.200) 56(84) bytes of data.
> 64 bytes from 192.168.10.200: icmp_seq=1 ttl=64 time=3.35 ms
> 64 bytes from 192.168.10.200: icmp_seq=2 ttl=64 time=3.48 ms
> 64 bytes from 192.168.10.200: icmp_seq=3 ttl=64 time=3.84 ms
> 
> --- 192.168.10.200 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2003ms
> rtt min/avg/max/mdev = 3.347/3.553/3.837/0.207 ms
>      signal: -55 dBm
> 
> 
> aik@aiemdeew ~> modinfo rtw_8822ce
> filename: 
> /lib/modules/6.2.9-100.fc36.x86_64/kernel/drivers/net/wireless/realtek/rtw88/rtw_8822ce.ko.xz
> license:        Dual BSD/GPL
> description:    Realtek 802.11ac wireless 8822ce driver
> author:         Realtek Corporation
> alias:          pci:v000010ECd0000C82Fsv*sd*bc*sc*i*
> alias:          pci:v000010ECd0000C822sv*sd*bc*sc*i*
> depends:        rtw_pci,rtw_8822c
> retpoline:      Y
> name:           rtw_8822ce
> vermagic:       6.2.9-100.fc36.x86_64 SMP preempt mod_unload
> sig_id:         PKCS#7
> signer:         Custom MOK
> sig_key:        0C:F6:31:12:B9:95:09:20:A6:62:E6:72:4F:D1:85:00:F4:A6:A9:B6
> sig_hashalgo:   sha256
> signature:      9F:F1:74:86:E8:B6:63:FA:F5:EC:2C:84:02:75:63:DC:66:C8:99:92:
>          9D:A8:1E:2F:FB:5F:50:EE:DD:59:A5:EC:DE:5F:AB:8A:4C:F9:D3:8A:
>          CC:CE:BE:3B:55:C8:E9:D9:AF:12:D0:A4:DE:B7:FB:A4:44:B2:F0:96:
>          CD:E2:C0:69:0C:A8:EB:1C:9C:BF:A8:91:3E:D2:7F:AD:9B:7D:22:A4:
>          3F:33:8F:86:40:DD:B3:42:B9:96:5B:94:CD:0B:E3:38:A0:8E:4E:8C:
>          62:38:11:01:D6:16:EC:B6:E2:28:48:07:A0:C4:6C:6C:55:04:01:F6:
>          C6:82:7E:F9:DE:EA:D0:20:63:41:4F:0A:D8:27:56:49:F6:84:E2:B9:
>          21:DF:3E:4B:C2:A7:C6:0A:8C:B7:66:17:E5:81:13:D6:5E:CA:94:D1:
>          E7:60:EF:B1:9D:52:E0:64:F8:4D:C5:54:CE:EF:F5:DC:2F:AA:22:5C:
>          81:52:CE:AF:9B:FA:9B:8B:88:99:2F:2C:8E:6A:A3:44:58:3B:6B:08:
>          78:43:B1:E9:27:C9:43:E6:49:BB:86:0E:23:10:0E:05:33:0C:23:B0:
>          5E:47:92:EE:0B:96:EA:65:92:89:69:DC:73:50:1D:A5:96:5A:11:32:
>          C6:2A:69:7A:B6:FE:6A:22:7F:69:61:B1:9B:F1:CF:66
> aik@aiemdeew ~> lsmod | grep rtw
> rtw_8822ce             16384  0
> rtw_8822c             499712  1 rtw_8822ce
> rtw_pci                40960  1 rtw_8822ce
> rtw_core              319488  2 rtw_8822c,rtw_pci
> mac80211             1486848  2 rtw_core,rtw_pci
> cfg80211             1273856  2 rtw_core,mac80211

You do have the right modules. It would take a really strange environment where 
moving the computer 2 cm would have a drastic effect.

I think I have gone as far as I can.

Larry


