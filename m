Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B991BE3AA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD2QWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 12:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2QWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 12:22:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041E0C03C1AD
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 09:22:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r26so2695269wmh.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DOTnimDsAI5yUUeib/xe7HLYjuUMaDYDeMa0ddh0vO8=;
        b=fG0Z27J1k9GBAmpQgvInaBR7w4U8FXIbGT0BfZg2gsELcBfL14n6eRqOetQMpQL9im
         /pTCmi7OFHRxiV/m5oks5Rdq1c8B5Fj5/Gf7SBZw7hh2Wff/WRFY7y4wcKSHJblcnFXt
         35T5cDFax5EgJ8M/CLgV/ja8A6U2VL3U3viuGFVn4PwY6v3lu9TbqwP4WsYYSMicVcqn
         KSpDDbXZff+6YqRTduCBFBgSqOKIg8/vi1saQVz9wUiNMM+F39RJYrFtvUW/eETg7d2H
         OYiKhtKFxhc0d2YyRYWxvbaUksu+Sj+oV33fOfd/MzIr2UPEZsmGd4F5nxBlXgOJmpAj
         yEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DOTnimDsAI5yUUeib/xe7HLYjuUMaDYDeMa0ddh0vO8=;
        b=F0ggur0bWKCwyXSP2e5YdcMoLCdbHkDqQhV1L2W/rENZ4mTihFWGJIRI7HOWPfTXmb
         ZIHkmUAhS3/417fEVPK+JYRqcuT8bsDKQzZaTVcLflA7yH53yuFHWnxW3VRBNrnsXZB3
         SPQSh0ksGNasuKWKiy18LLBQOfW0DLg84uJgp2d7eaKkApY10JS9Uwcth5yYueUN1arP
         yxTOtpu6it0sMeBDXR9l8z/FdIiQOZdUBlv0fqZihTlfJnFqd2GZAy6ou6VNiQzfyltS
         x34uW0b721S70JCDWzcdBcvYImaHjplTr3lveQt7NsfQiRlFultI7GGOmoeZEhXGt2z0
         vXww==
X-Gm-Message-State: AGi0PuavmHWYcFoGaGD+4/NYoSXjQSUWYPh6hGuZa+vUYrzK+rAPCIqU
        sgLKZyCujhD1Bpgv0Ms=
X-Google-Smtp-Source: APiQypI2+fq311aFLLZmKzC7DOSYKGvwXWXrZG9m57tMvDtHe8L9CjduwzYEGMjrOxk+6KNSVPdXsA==
X-Received: by 2002:a1c:492:: with SMTP id 140mr4334469wme.9.1588177343288;
        Wed, 29 Apr 2020 09:22:23 -0700 (PDT)
Received: from [192.168.25.100] (ip-178-200-114-192.hsi07.unitymediagroup.de. [178.200.114.192])
        by smtp.googlemail.com with ESMTPSA id 19sm8247310wmo.3.2020.04.29.09.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 09:22:22 -0700 (PDT)
Subject: Re: [Bug] carl9170 + wpa_supplicant: P2P mode doesn't work with
 separate interfaces
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
To:     chunkeey@googlemail.com, j@w1.fi
Cc:     linux-wireless@vger.kernel.org
References: <3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
 <71051a8e-b8fc-3289-5009-b651e6c1a409@googlemail.com>
Message-ID: <11106990-ab12-3a8b-a203-2af8528ce3a1@googlemail.com>
Date:   Wed, 29 Apr 2020 18:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <71051a8e-b8fc-3289-5009-b651e6c1a409@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 27.04.20 um 18:53 schrieb Frank Schäfer:
>
> Am 18.04.20 um 13:20 schrieb Frank Schäfer:
>> Hi,
>>
>> I'm currently testing Miraclecast 
>> (https://github.com/albfan/miraclecast), an open source 
>> Wifi-Display/Miracast implementation.
>> In one of my setups, I'm using a carl9170 device as sink, which fails 
>> with the following debugging output:
>>
>> ...
>> TRACE: wpa: raw message: IFNAME=wlp0s2f1u8 <3>CTRL-EVENT-SCAN-STARTED
>> TRACE: wpa: raw message: <3>P2P-PROV-DISC-PBC-REQ 8e:79:67:11:22:33 
>> p2p_dev_addr=8e:79:67:11:22:33 pri_dev_type=10-0050F204-5 name='MY 
>> DEVICE' config_methods=0x188 dev_capab=0x25 group_capab=0x0
>> TRACE: wpa: raw message: <3>P2P-GO-NEG-REQUEST 8e:79:67:11:22:33 
>> dev_passwd_id=4 go_intent=0
>> DEBUG: supplicant: GO Negotiation Request from 8e:79:67:11:22:33 
>> (supplicant_event_p2p_go_neg_request() in 
>> ../../../src/wifi/wifid-supplicant.c:1065)
>> DEBUG: supplicant: connect to 8e:79:67:11:22:33 via pbc/(null) 
>> (supplicant_peer_connect() in ../../../src/wifi/wifid-supplicant.c:739)
>> TRACE: wpa: raw message: <3>P2P-FIND-STOPPED
>> DEBUG: supplicant: p2p-scanning stopped on wlp0s2f1u8 
>> (supplicant_event_p2p_find_stopped() in 
>> ../../../src/wifi/wifid-supplicant.c:904)
>> TRACE: wpa: raw message: OK
>>
>> TRACE: wpa: raw message: <3>P2P-GO-NEG-SUCCESS role=GO freq=2462 
>> ht40=0 peer_dev=8e:79:67:11:22:33 peer_iface=8e:79:67:11:22:33 
>> wps_method=PBC
>> DEBUG: supplicant: set STA-MAC for 8e:79:67:11:22:33 from <none> to 
>> 8e:79:67:11:22:33 (via GO-NEG-SUCCESS) 
>> (supplicant_event_p2p_go_neg_success() in 
>> ../../../src/wifi/wifid-supplicant.c:1194)
>> TRACE: wpa: raw message: IFNAME=p2p-0 <3>Failed to start AP 
>> functionality
>> DEBUG: supplicant: unhandled wpas-event: IFNAME=p2p-0 <3>Failed to 
>> start AP functionality (supplicant_event() in 
>> ../../../src/wifi/wifid-supplicant.c:1498)
>> TRACE: wpa: raw message: <3>P2P-GROUP-FORMATION-FAILURE
>> DEBUG: supplicant: peer MY DEVICE connection failed 
>> (supplicant_event_p2p_group_formation_failure() in 
>> ../../../src/wifi/wifid-supplicant.c:1318)
>> TRACE: wpa: raw message: <3>P2P-GROUP-REMOVED p2p-0 GO 
>> reason=FORMATION_FAILED
>> DEBUG: supplicant: stray P2P-GROUP-REMOVED: <3>P2P-GROUP-REMOVED 
>> p2p-0 GO reason=FORMATION_FAILED 
>> (supplicant_event_p2p_group_removed() in 
>> ../../../src/wifi/wifid-supplicant.c:1286)
>> DEBUG: supplicant: sent P2P_FIND to wpas on wlp0s2f1u8 
>> (supplicant_p2p_start_scan() in 
>> ../../../src/wifi/wifid-supplicant.c:2036)
>> TRACE: wpa: raw message: OK
>>
>> DEBUG: supplicant: p2p-scanning now active on wlp0s2f1u8 
>> (supplicant_p2p_find_fn() in ../../../src/wifi/wifid-supplicant.c:1917)
>> TRACE: wpa: raw message: IFNAME=wlp0s2f1u8 <3>CTRL-EVENT-SCAN-STARTED
>> ...
>>
>>
>> Searching the web for similar problems leads to the following thread:
>> https://marc.info/?l=hostap&m=135336063022534
>>
>> As suggested there, I have patched the Miraclecast sources to use the 
>> wpa_supplicant configuration parameter p2p_no_group_iface=1.
>> So far, this works fine.
>>
>>
>> Regards,
>> Frank Schäfer
>>
>
> I finally managed to create extended logs and to compare the working 
> ("GOOD") and non-working ("BAD") case.
> See attachment.
> If anything is missing, please let me know.
>
> Hth,
> Frank
>

Ok, this is what I can see happening in carl9170 with regards to the 
interfaces:

1) 1 interface is added+initialized: NL80211_IFTYPE_STATION, p2p=false 
(when miracle-wifid is started)

Non-working case (p2p_no_group_iface=0=default):
2a) 1 interface is added: NL80211_IFTYPE_STATION, p2p=true (apparently 
the p2p group interface)
2b) 1 interface is removed: NL80211_IFTYPE_STATION, p2p=true (apparently 
because setting of the interface flags failed with -EBUSY)
3) 1 interface is added+initialized: NL80211_IFTYPE_AP, p2p=true
    => fails with -EBUSY, because main_vif->p2p is false (main.c, line 656)

Working case (p2p_no_group_iface=1):
2) 1 interface is removed: NL80211_IFTYPE_STATION, p2p=false
3) 1 interface is added+initialized: NL80211_IFTYPE_AP, p2p=true

So if p2p_no_group_iface=1 is used, the initial STA non-p2p interface is 
removed before a new AP+p2p interface is added.
Maybe the same needs to be done in case of p2p_no_group_iface=0 ?

Regards,
Frank


