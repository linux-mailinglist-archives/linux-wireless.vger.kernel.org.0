Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83871C5A6E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgEEPDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729458AbgEEPDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 11:03:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E1C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 08:03:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so2732563wml.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Eiwc8tYLjzfjAjmoBYKQ0yovicA80NE2VbHY90CxgTI=;
        b=ZA+l2Tzp8LI4ajpr2DwU9yX7B8apoYqRcPAp1V9+RFWixa/hEP3qEQ/sicesTlVKAW
         tdUnB009tr7QpbXEdYykWj7Gtt6XicCJTl04nStmDOsuxvQEp/Nv5TtzCV0DcqtuUoCw
         DoVG/UpuHEHtfH/k0FInZe6QvhzPQ0NbjzuU0Gc8YtZnNv76tnxlAIO3rhmgPYmQYNdh
         oAK/C3kIID7PKTuPnBJU2lnex/PmNfBPkvW0ctvV5WCMuAx9pGtiQrAEKvhNDWvr2Ygb
         Yn3/em1EJRX1XCS+BS9JR1uNgifl/p2Ju6LmgukJUadPXWnLWnHoZo5vq/qf9KbV8I1z
         OFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Eiwc8tYLjzfjAjmoBYKQ0yovicA80NE2VbHY90CxgTI=;
        b=hCI3b+go7CV5YuXMs6KwdSnUR/UysdKUsGrFs8d041ie+DklOsdti8Gyp8Dnys232T
         wgX5EOlQdLSO7KRVd2fmJu1fb4mxX6FS7OxBE0RTZjjTTF0FRHhsHc8wSTVY71eYR7CR
         rcsZZsqRlVvw5qPwibHGSqmv9M9xuMs32mBwajbCZd9ynTcxDoowoSiTOT4+n0gcn5Pt
         E+sXEBkmNcpTdEzqlvA5YYhcyCJMjpJvnT/EgqzCNzdKQY/GU8ZOV0oSgsIXpNeQEdsl
         ND8Ks+ffwGgC3rlR0yQBiXRDlbsgd0hbzT9CFn04fDo2p5l93kKhs46vkwcQa58t02gJ
         lU8A==
X-Gm-Message-State: AGi0PuZ2vvvKTn8HLEmUrz4AYwBwDZbMR2P8K3cg2IHSGykNwuBFZ95H
        1RyoMggcM0pQXLHG554=
X-Google-Smtp-Source: APiQypICwhX3eD4e/Vt1DJJM8tksqs9g3nfILja9eipPliil/8u05Yxvg3A1JUCXw8v7k0NAFouDLA==
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr3616225wmc.57.1588691021782;
        Tue, 05 May 2020 08:03:41 -0700 (PDT)
Received: from [192.168.25.100] (ip-176-198-175-128.hsi05.unitymediagroup.de. [176.198.175.128])
        by smtp.googlemail.com with ESMTPSA id f8sm3849245wrm.8.2020.05.05.08.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 08:03:40 -0700 (PDT)
Subject: Re: [Bug] carl9170 + wpa_supplicant: P2P mode doesn't work with
 separate interfaces
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
To:     chunkeey@googlemail.com, j@w1.fi
Cc:     linux-wireless@vger.kernel.org
References: <3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
 <71051a8e-b8fc-3289-5009-b651e6c1a409@googlemail.com>
 <11106990-ab12-3a8b-a203-2af8528ce3a1@googlemail.com>
Message-ID: <652b81f9-76b4-721b-6086-d958717ba1bd@googlemail.com>
Date:   Tue, 5 May 2020 17:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <11106990-ab12-3a8b-a203-2af8528ce3a1@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Christian, Jouni,

I have tracked this down as far as I can get without some help.
It would be nice if you could take a closer look at the results - see 
questions below.


Am 29.04.20 um 18:22 schrieb Frank Schäfer:
>
> Am 27.04.20 um 18:53 schrieb Frank Schäfer:
>>
>> Am 18.04.20 um 13:20 schrieb Frank Schäfer:
>>> Hi,
>>>
>>> I'm currently testing Miraclecast 
>>> (https://github.com/albfan/miraclecast), an open source 
>>> Wifi-Display/Miracast implementation.
>>> In one of my setups, I'm using a carl9170 device as sink, which 
>>> fails with the following debugging output:
>>>
>>> ...
>>> TRACE: wpa: raw message: IFNAME=wlp0s2f1u8 <3>CTRL-EVENT-SCAN-STARTED
>>> TRACE: wpa: raw message: <3>P2P-PROV-DISC-PBC-REQ 8e:79:67:11:22:33 
>>> p2p_dev_addr=8e:79:67:11:22:33 pri_dev_type=10-0050F204-5 name='MY 
>>> DEVICE' config_methods=0x188 dev_capab=0x25 group_capab=0x0
>>> TRACE: wpa: raw message: <3>P2P-GO-NEG-REQUEST 8e:79:67:11:22:33 
>>> dev_passwd_id=4 go_intent=0
>>> DEBUG: supplicant: GO Negotiation Request from 8e:79:67:11:22:33 
>>> (supplicant_event_p2p_go_neg_request() in 
>>> ../../../src/wifi/wifid-supplicant.c:1065)
>>> DEBUG: supplicant: connect to 8e:79:67:11:22:33 via pbc/(null) 
>>> (supplicant_peer_connect() in ../../../src/wifi/wifid-supplicant.c:739)
>>> TRACE: wpa: raw message: <3>P2P-FIND-STOPPED
>>> DEBUG: supplicant: p2p-scanning stopped on wlp0s2f1u8 
>>> (supplicant_event_p2p_find_stopped() in 
>>> ../../../src/wifi/wifid-supplicant.c:904)
>>> TRACE: wpa: raw message: OK
>>>
>>> TRACE: wpa: raw message: <3>P2P-GO-NEG-SUCCESS role=GO freq=2462 
>>> ht40=0 peer_dev=8e:79:67:11:22:33 peer_iface=8e:79:67:11:22:33 
>>> wps_method=PBC
>>> DEBUG: supplicant: set STA-MAC for 8e:79:67:11:22:33 from <none> to 
>>> 8e:79:67:11:22:33 (via GO-NEG-SUCCESS) 
>>> (supplicant_event_p2p_go_neg_success() in 
>>> ../../../src/wifi/wifid-supplicant.c:1194)
>>> TRACE: wpa: raw message: IFNAME=p2p-0 <3>Failed to start AP 
>>> functionality
>>> DEBUG: supplicant: unhandled wpas-event: IFNAME=p2p-0 <3>Failed to 
>>> start AP functionality (supplicant_event() in 
>>> ../../../src/wifi/wifid-supplicant.c:1498)
>>> TRACE: wpa: raw message: <3>P2P-GROUP-FORMATION-FAILURE
>>> DEBUG: supplicant: peer MY DEVICE connection failed 
>>> (supplicant_event_p2p_group_formation_failure() in 
>>> ../../../src/wifi/wifid-supplicant.c:1318)
>>> TRACE: wpa: raw message: <3>P2P-GROUP-REMOVED p2p-0 GO 
>>> reason=FORMATION_FAILED
>>> DEBUG: supplicant: stray P2P-GROUP-REMOVED: <3>P2P-GROUP-REMOVED 
>>> p2p-0 GO reason=FORMATION_FAILED 
>>> (supplicant_event_p2p_group_removed() in 
>>> ../../../src/wifi/wifid-supplicant.c:1286)
>>> DEBUG: supplicant: sent P2P_FIND to wpas on wlp0s2f1u8 
>>> (supplicant_p2p_start_scan() in 
>>> ../../../src/wifi/wifid-supplicant.c:2036)
>>> TRACE: wpa: raw message: OK
>>>
>>> DEBUG: supplicant: p2p-scanning now active on wlp0s2f1u8 
>>> (supplicant_p2p_find_fn() in ../../../src/wifi/wifid-supplicant.c:1917)
>>> TRACE: wpa: raw message: IFNAME=wlp0s2f1u8 <3>CTRL-EVENT-SCAN-STARTED
>>> ...
>>>
>>>
>>> Searching the web for similar problems leads to the following thread:
>>> https://marc.info/?l=hostap&m=135336063022534
>>>
>>> As suggested there, I have patched the Miraclecast sources to use 
>>> the wpa_supplicant configuration parameter p2p_no_group_iface=1.
>>> So far, this works fine.
>>>
>>>
>>> Regards,
>>> Frank Schäfer
>>>
>>
>> I finally managed to create extended logs and to compare the working 
>> ("GOOD") and non-working ("BAD") case.
>> See attachment.
>> If anything is missing, please let me know.
>>
>> Hth,
>> Frank
>>
>
> Ok, this is what I can see happening in carl9170 with regards to the 
> interfaces:
>
> 1) 1 interface is added+initialized: NL80211_IFTYPE_STATION, p2p=false 
> (when miracle-wifid is started)
>
> Non-working case (p2p_no_group_iface=0=default):
> 2a) 1 interface is added: NL80211_IFTYPE_STATION, p2p=true (apparently 
> the p2p group interface)
> 2b) 1 interface is removed: NL80211_IFTYPE_STATION, p2p=true 
> (apparently because setting of the interface flags failed with -EBUSY)
> 3) 1 interface is added+initialized: NL80211_IFTYPE_AP, p2p=true
>    => fails with -EBUSY, because main_vif->p2p is false (main.c, line 
> 656)
>
> Working case (p2p_no_group_iface=1):
> 2) 1 interface is removed: NL80211_IFTYPE_STATION, p2p=false
> 3) 1 interface is added+initialized: NL80211_IFTYPE_AP, p2p=true

UPDATE (removed some confusion due to async output to the log, added 
disconnection/exit):

1) STA non-p2p interface is added+initialized (miracle-wifid start)

Connection attempt:

BAD case (p2p_no_group_iface=0=default):
2a) STA p2p interface is added (p2p group interface)
2b) STA p2p interface is removed (p2p group interface)
3) AP p2p interface is added: fails with -EBUSY (carl9170 main.c, line 
654), because main_vif->p2p is false in line 648
=> connection fails

GOOD case (p2p_no_group_iface=1):
2) STA non-p2p interface is removed
3) AP p2p interface is added+initialized
=> connection established, streaming

Disconnection (GOOD case (p2p_no_group_iface=1)):
4) AP p2p interface is removed
5) STA non-p2p interface is added+initialized

miracle-wifid exit:
6) STA non-p2p is interface is removed


So there are two things to investigate further: BAD 3) and GOOD 2)

@Christian:
Can you please check if the behavior of carl9170 (BAD 3)) is correct ?
Reading the comments and the rest of the code in the switch 
(main_vif->type) {} section, I wonder if the main_vif->p2p check in line 
654 is correct/required.
Isn't all we have to make sure, that the AP interface always becomes the 
main interface ? Why does main_vif->p2p matter here ?
A few lines below (660/661), STA interfaces are always added if the main 
interface is a AP interface, no matter if any of them is p2p or not.

@Jouni:
Why does wpa_supplicant remove the STA non-p2p interface before creating 
the AP p2p interface if p2p_no_group_iface=1, but not if 
p2p_no_group_iface=0 ?
That seems to be inconsistent.
In case the driver doesn't support concurrent interfaces, the behavior 
of p2p_no_group_iface=1 seems to make things work.
But I don't know if there might be any disadvantages.
In my case, the removed interface is added again later (5)) and 
everything works fine.

Regards,
Frank

