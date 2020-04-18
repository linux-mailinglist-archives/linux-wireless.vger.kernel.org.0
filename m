Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E231AEC0D
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgDRLTl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgDRLTl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 07:19:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC6C061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2020 04:19:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so6801039wma.0
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2020 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=3kjkA93BJSDiwCr9nxtbJyjJr33pf8XrWlRB2b+Cqsk=;
        b=TweeSCzB6iXQuANWrg4mu+OdX/xxJ7i2gQQ0wwvKVl+8qLLGXyJYXntzAwKnYTUQhJ
         ewRX3TqKzcjjg49zZLSpaa03Fg0UR/yhH1kwj2tyh0o2Ir8yQnsjuomZXvOFhqoudED+
         StTCrjSgqK4JPUoXwFBCOcondthrU8ywLQ+3mD/SBZRhqrJrGyQ5wl3yIqCAI872/eE2
         JojccoYR6Qlj16y6l9vA8n0VEgHHq9WCD6kpFck20ShfzBQvAkgkIt54iqcP5EB9KyJX
         XiJHLLsDPHtzK/5S0HwqT0xghz23q07yszBGTP3OultNCprnY5zcJ+BnYGCPJ/sCBgn0
         NFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3kjkA93BJSDiwCr9nxtbJyjJr33pf8XrWlRB2b+Cqsk=;
        b=cgzguBY3o4tDfTUkC04Gnff9Bl02KV8nvflWI1qNHLhulHOTmd2cgSEQNDVyDs5XN6
         6XhP0KKdWmdQ+kieR2L4qyX/M+RfLipFEIhKmQE6sDJMArPDuZjabsu3dYwZ+Zq9yF+1
         Wc5Amu1i3phUUkx7wfl+IgDJNW56ATq/ZFiuyCAQL0plLRjYFtJNECzGQrum8gZeq7CS
         ZSGkLdcpS16kZSvMZL/DVYO3fJQkj27AFJcJdIBAlT7sA8Wt51vLaQbf5rXO5tGQmlqk
         8ksMHAy3W8kZUjYzR8xnxiehVQTBOzBnG+ZraXnYiqte/8bAHKrohDUy0LfVnBc1Ativ
         S6Tg==
X-Gm-Message-State: AGi0PuaHQnM+JQel/Oz3zdqCJU+0KNVQtJ/QG1GPnJfEtKyOTHg5zN6v
        iRtCMuaXvSkVNncExWc=
X-Google-Smtp-Source: APiQypL/C6lNZ5ywH/3K8/P3r/hIywvhOJFFoY4meUJYoo49D2zGWMsVfAAlLFrQAAfa81ty0mTB+A==
X-Received: by 2002:a1c:e187:: with SMTP id y129mr8316620wmg.133.1587208777875;
        Sat, 18 Apr 2020 04:19:37 -0700 (PDT)
Received: from [192.168.25.100] (ip-176-198-223-134.hsi05.unitymediagroup.de. [176.198.223.134])
        by smtp.googlemail.com with ESMTPSA id a20sm13601681wra.26.2020.04.18.04.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 04:19:37 -0700 (PDT)
To:     chunkeey@googlemail.com, j@w1.fi
Cc:     linux-wireless@vger.kernel.org
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Subject: [Bug] carl9170 + wpa_supplicant: P2P mode doesn't work with separate
 interfaces
Message-ID: <3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
Date:   Sat, 18 Apr 2020 13:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm currently testing Miraclecast 
(https://github.com/albfan/miraclecast), an open source 
Wifi-Display/Miracast implementation.
In one of my setups, I'm using a carl9170 device as sink, which fails 
with the following debugging output:

...
TRACE: wpa: raw message: IFNAME=wlp0s2f1u8 <3>CTRL-EVENT-SCAN-STARTED
TRACE: wpa: raw message: <3>P2P-PROV-DISC-PBC-REQ 8e:79:67:11:22:33 
p2p_dev_addr=8e:79:67:11:22:33 pri_dev_type=10-0050F204-5 name='MY 
DEVICE' config_methods=0x188 dev_capab=0x25 group_capab=0x0
TRACE: wpa: raw message: <3>P2P-GO-NEG-REQUEST 8e:79:67:11:22:33 
dev_passwd_id=4 go_intent=0
DEBUG: supplicant: GO Negotiation Request from 8e:79:67:11:22:33 
(supplicant_event_p2p_go_neg_request() in 
../../../src/wifi/wifid-supplicant.c:1065)
DEBUG: supplicant: connect to 8e:79:67:11:22:33 via pbc/(null) 
(supplicant_peer_connect() in ../../../src/wifi/wifid-supplicant.c:739)
TRACE: wpa: raw message: <3>P2P-FIND-STOPPED
DEBUG: supplicant: p2p-scanning stopped on wlp0s2f1u8 
(supplicant_event_p2p_find_stopped() in 
../../../src/wifi/wifid-supplicant.c:904)
TRACE: wpa: raw message: OK

TRACE: wpa: raw message: <3>P2P-GO-NEG-SUCCESS role=GO freq=2462 ht40=0 
peer_dev=8e:79:67:11:22:33 peer_iface=8e:79:67:11:22:33 wps_method=PBC
DEBUG: supplicant: set STA-MAC for 8e:79:67:11:22:33 from <none> to 
8e:79:67:11:22:33 (via GO-NEG-SUCCESS) 
(supplicant_event_p2p_go_neg_success() in 
../../../src/wifi/wifid-supplicant.c:1194)
TRACE: wpa: raw message: IFNAME=p2p-0 <3>Failed to start AP functionality
DEBUG: supplicant: unhandled wpas-event: IFNAME=p2p-0 <3>Failed to start 
AP functionality (supplicant_event() in 
../../../src/wifi/wifid-supplicant.c:1498)
TRACE: wpa: raw message: <3>P2P-GROUP-FORMATION-FAILURE
DEBUG: supplicant: peer MY DEVICE connection failed 
(supplicant_event_p2p_group_formation_failure() in 
../../../src/wifi/wifid-supplicant.c:1318)
TRACE: wpa: raw message: <3>P2P-GROUP-REMOVED p2p-0 GO 
reason=FORMATION_FAILED
DEBUG: supplicant: stray P2P-GROUP-REMOVED: <3>P2P-GROUP-REMOVED p2p-0 
GO reason=FORMATION_FAILED (supplicant_event_p2p_group_removed() in 
../../../src/wifi/wifid-supplicant.c:1286)
DEBUG: supplicant: sent P2P_FIND to wpas on wlp0s2f1u8 
(supplicant_p2p_start_scan() in ../../../src/wifi/wifid-supplicant.c:2036)
TRACE: wpa: raw message: OK

DEBUG: supplicant: p2p-scanning now active on wlp0s2f1u8 
(supplicant_p2p_find_fn() in ../../../src/wifi/wifid-supplicant.c:1917)
TRACE: wpa: raw message: IFNAME=wlp0s2f1u8 <3>CTRL-EVENT-SCAN-STARTED
...


Searching the web for similar problems leads to the following thread:
https://marc.info/?l=hostap&m=135336063022534

As suggested there, I have patched the Miraclecast sources to use the 
wpa_supplicant configuration parameter p2p_no_group_iface=1.
So far, this works fine.


Regards,
Frank Schäfer

