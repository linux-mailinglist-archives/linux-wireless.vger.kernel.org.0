Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603BD63B4DD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 23:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiK1We5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 17:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiK1Wey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 17:34:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF062F663
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 14:34:52 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l8so14811189ljh.13
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dY3T8WV6rN34qq+v4X3XEqQEIvMj47VGhvplwf2h/GQ=;
        b=PmrDNl7kWst1m2yrGw7L3AE9U+NPImxP7CNFtkNpwhZZdWOuqi4giB8NGB3/iNSve0
         4+vkwcuXUY1kuhsf4Y/sbozMqFxFIQJxI5XF7FZ7qkomXFOvsrXNqJge6+yuOxltlkAC
         oD3NmlDyVLCXwGMqiE5oN8ZVQdPgdmyGVc3+kVFPsRxudQC8vaXDjeY4QLrbDFWRdys8
         CIAJOwEu++xyaWzpJWis5y/0eI4StbOkVUh4SuXGMOl8FcpYQ9aK/TLM1t4uYyoYXou7
         7NZSJ1+8m+vQlOl3iBEUiqMvIWiovEVEFCnBn45VRhLk/H/83xWFIgbc2VK0SXbfyUoI
         6mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dY3T8WV6rN34qq+v4X3XEqQEIvMj47VGhvplwf2h/GQ=;
        b=u+D9LioDGfdSr5KhyqXS3hHVvb/Bu1tQzQ8uJUo2/GvLR8ZqBM8vTv6V84HKuHaQKI
         zy9snEi3tEWxBeUpAwM/rUhiRs42FnxlWFlbsTBPpbEwyRh/x7t7gEJJTVNRSItc0uc7
         1tDilB4VTkdXoQ/KK4I5GrLWvds0y+oJf+Lx+Z09Eg29F7WUqRTZM9f1W3K1JcbcHjZ0
         g3/DWEWFtS7po9XJubww0I/yQLMLP3tUrTNuiYp/cKlfnXX8YswMOO17MSQHR/aYwyUP
         0fYp6z9g3WYMQFVS8E+Sl8VN3DrKOEb+CbbEKqXEuqKxKvr6xf+7wlP2o4F7ikKA45e5
         Lpgg==
X-Gm-Message-State: ANoB5plOTs3xIrd0oRMrU82+nZr/Jc+xt0sJgoCbr2ZxBhAbB231OklN
        W/oKrVGQ7BDwzQvXG73dtDfg6gfg1+ypjkrU5IH6HgpdRnA=
X-Google-Smtp-Source: AA0mqf4ZSBSJ0Y8ov7wOphT6vc+vt/+TcJ+uDH3a5wNsFmCwvIHLOwaG3rkhZpWUeSf8AgFCZY4hfNVvlyx6c/mZNcg=
X-Received: by 2002:a2e:a375:0:b0:277:7c00:e130 with SMTP id
 i21-20020a2ea375000000b002777c00e130mr10434348ljn.268.1669674890078; Mon, 28
 Nov 2022 14:34:50 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Tue, 29 Nov 2022 00:34:38 +0200
Message-ID: <CADUzMVb6QKX-dhVpFXvUJ2MXMf93vK1RC+R8JqAPxExBSisA0A@mail.gmail.com>
Subject: Re: PRO/Wireless 4965 Intel WPA2,3 SSID connection problem #1
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Stanislaw,

I have figured everything out with MX Linux and created a new kernel
based on 6.0 that it works well on my test PC as well. Then I applied
your patch along with some debugging options. Unfortunately the
problem remains and it continues to be unable to connect at the
desired WPA2,3 based network.

Here is what I got:
[  127.010836] wlan0: authenticate with c6:27:28:**:**:**
[  127.045272] wlan0: Allocated STA c6:27:28:**:**:**
[  127.045302] wlan0: HE not supported, disabling HE and EHT
[  127.045307] wlan0: EHT not supported, disabling EHT
[  127.045312] wlan0: 40 MHz not supported
[  127.064987] wlan0: Inserted STA c6:27:28:**:**:**
[  127.065001] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  127.100178] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  127.256076] wlan0: authenticate with c6:27:28:**:**:**
[  127.269267] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  127.326218] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  127.359865] wlan0: authenticated
[  127.359878] wlan0: moving STA c6:27:28:**:**:** to state 2
[  129.673505] wlan0: authenticate with c6:27:28:**:**:**
[  129.701276] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  129.749290] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  129.907091] wlan0: authenticate with c6:27:28:**:**:**
[  129.929278] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  129.991639] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  130.004849] wlan0: authenticated
[  132.634674] wlan0: authenticate with c6:27:28:**:**:**
[  132.665273] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  132.708248] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  132.867195] wlan0: authenticate with c6:27:28:**:**:**
[  132.881305] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  132.946943] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  132.977713] wlan0: authenticated
[  135.033232] wlan0: moving STA c6:27:28:**:**:** to state 1
[  135.033252] wlan0: Removed STA c6:27:28:**:**:**
[  135.033405] wlan0: Destroyed STA c6:27:28:**:**:**
[  135.091310] wlan0: authenticate with c6:27:28:**:**:**
[  135.117296] wlan0: Allocated STA c6:27:28:**:**:**
[  135.117313] wlan0: HE not supported, disabling HE and EHT
[  135.117316] wlan0: EHT not supported, disabling EHT
[  135.117319] wlan0: 40 MHz not supported
[  135.117412] wlan0: Inserted STA c6:27:28:**:**:**
[  135.117416] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  135.150662] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  135.320150] wlan0: authenticate with c6:27:28:**:**:**
[  135.337246] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  135.363815] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  135.415642] wlan0: authenticated
[  135.415648] wlan0: moving STA c6:27:28:**:**:** to state 2
[  140.457249] wlan0: moving STA c6:27:28:**:**:** to state 1
[  140.457269] wlan0: Removed STA c6:27:28:**:**:**
[  140.457419] wlan0: Destroyed STA c6:27:28:**:**:**
[  147.809410] wlan0: authenticate with c6:27:28:**:**:**
[  147.825285] wlan0: Allocated STA c6:27:28:**:**:**
[  147.825318] wlan0: HE not supported, disabling HE and EHT
[  147.825323] wlan0: EHT not supported, disabling EHT
[  147.825329] wlan0: 40 MHz not supported
[  147.825479] wlan0: Inserted STA c6:27:28:**:**:**
[  147.825487] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  147.867399] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  148.006392] wlan0: authenticate with c6:27:28:**:**:**
[  148.033196] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  148.086859] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  148.141567] wlan0: authenticated
[  148.141580] wlan0: moving STA c6:27:28:**:**:** to state 2
[  150.029249] wlan0: moving STA c6:27:28:**:**:** to state 1
[  150.029261] wlan0: Removed STA c6:27:28:**:**:**
[  150.029333] wlan0: Destroyed STA c6:27:28:**:**:**
[  155.174647] wlan0: authenticate with c6:27:28:**:**:**
[  155.197269] wlan0: Allocated STA c6:27:28:**:**:**
[  155.197313] wlan0: HE not supported, disabling HE and EHT
[  155.197319] wlan0: EHT not supported, disabling EHT
[  155.197326] wlan0: 40 MHz not supported
[  155.197506] wlan0: Inserted STA c6:27:28:**:**:**
[  155.197514] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  155.384578] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  155.543828] wlan0: authenticate with c6:27:28:**:**:**
[  155.569253] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  155.644007] wlan0: authenticated
[  155.644022] wlan0: moving STA c6:27:28:**:**:** to state 2
[  155.797297] wlan0: moving STA c6:27:28:**:**:** to state 1
[  155.797315] wlan0: Removed STA c6:27:28:**:**:**
[  155.797454] wlan0: Destroyed STA c6:27:28:**:**:**
[  167.764981] wlan0: authenticate with c6:27:28:**:**:**
[  167.793277] wlan0: Allocated STA c6:27:28:**:**:**
[  167.793306] wlan0: HE not supported, disabling HE and EHT
[  167.793311] wlan0: EHT not supported, disabling EHT
[  167.793317] wlan0: 40 MHz not supported
[  167.793455] wlan0: Inserted STA c6:27:28:**:**:**
[  167.793462] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  169.801320] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  170.018822] wlan0: send auth to c6:27:28:**:**:** (try 3/3)
[  170.209315] wlan0: authenticate with c6:27:28:**:**:**
[  170.241234] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  170.279403] wlan0: authenticated
[  170.279422] wlan0: moving STA c6:27:28:**:**:** to state 2
[  170.429292] wlan0: moving STA c6:27:28:**:**:** to state 1
[  170.429312] wlan0: Removed STA c6:27:28:**:**:**
[  170.429464] wlan0: Destroyed STA c6:27:28:**:**:**
[  190.301561] wlan0: authenticate with c6:27:28:**:**:**
[  190.329276] wlan0: Allocated STA c6:27:28:**:**:**
[  190.329311] wlan0: HE not supported, disabling HE and EHT
[  190.329316] wlan0: EHT not supported, disabling EHT
[  190.329322] wlan0: 40 MHz not supported
[  190.329468] wlan0: Inserted STA c6:27:28:**:**:**
[  190.329476] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  190.483964] wlan0: authenticate with c6:27:28:**:**:**
[  190.497227] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  190.591039] wlan0: authenticated
[  190.591055] wlan0: moving STA c6:27:28:**:**:** to state 2
[  190.725244] wlan0: moving STA c6:27:28:**:**:** to state 1
[  190.725263] wlan0: Removed STA c6:27:28:**:**:**
[  190.725405] wlan0: Destroyed STA c6:27:28:**:**:**
[  202.785134] wlan0: authenticate with c6:27:28:**:**:**
[  202.805254] wlan0: Allocated STA c6:27:28:**:**:**
[  202.805287] wlan0: HE not supported, disabling HE and EHT
[  202.805292] wlan0: EHT not supported, disabling EHT
[  202.805298] wlan0: 40 MHz not supported
[  202.805447] wlan0: Inserted STA c6:27:28:**:**:**
[  202.805455] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  204.809255] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[  205.045503] wlan0: send auth to c6:27:28:**:**:** (try 3/3)
[  205.221541] wlan0: authenticate with c6:27:28:**:**:**
[  205.237258] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[  205.320738] wlan0: authenticated
[  205.320753] wlan0: moving STA c6:27:28:**:**:** to state 2
[  205.509251] wlan0: moving STA c6:27:28:**:**:** to state 1
[  205.509268] wlan0: Removed STA c6:27:28:**:**:**
[  205.509404] wlan0: Destroyed STA c6:27:28:**:**:**

iw
1669673436.833745: wlan0 (phy #0): scan started
1669673439.001886: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
""
1669673463.911045: wlan0 (phy #0): scan started
1669673466.037955: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673466.105512: wlan0: new station c6:27:28:**:**:**
1669673466.295875: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673466.400447: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673466.503503: wlan0 (phy #0): scan started
1669673468.701925: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673468.946255: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673469.045388: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673469.548926: wlan0 (phy #0): scan started
1669673471.669892: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673471.906366: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673472.018293: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673473.022236: wlan0 (phy #0): scan started
1669673474.073890: wlan0: del station c6:27:28:**:**:**
1669673474.125865: wlan0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673474.157962: wlan0: new station c6:27:28:**:**:**
1669673474.359301: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673474.456212: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673479.464050: wlan0 (phy #0): scan started
1669673479.497881: wlan0: del station c6:27:28:**:**:**
1669673479.529843: wlan0 (phy #0): scan aborted: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673484.537935: wlan0 (phy #0): scan started
1669673486.837847: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673486.866010: wlan0: new station c6:27:28:**:**:**
1669673487.045456: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673487.182167: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673489.069827: wlan0: del station c6:27:28:**:**:**
1669673489.404480: wlan0 (phy #0): scan started
1669673491.537799: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
""
1669673491.896429: wlan0 (phy #0): scan started
1669673494.205876: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673494.238065: wlan0: new station c6:27:28:**:**:**
1669673494.582959: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673494.684606: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673494.837881: wlan0: del station c6:27:28:**:**:**
1669673504.692823: wlan0 (phy #0): scan started
1669673506.793871: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673506.834008: wlan0: new station c6:27:28:**:**:**
1669673509.248406: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673509.320015: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673509.469936: wlan0: del station c6:27:28:**:**:**
1669673517.385456: wlan0 (phy #0): scan started
1669673519.589930: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
""
1669673519.945687: wlan0 (phy #0): scan started
1669673522.057900: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673527.064392: wlan0 (phy #0): scan started
1669673529.329866: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673529.370023: wlan0: new station c6:27:28:**:**:**
1669673529.523041: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673529.631659: wlan0 (phy #0): auth c6:27:28:**:**:** ->
00:13:e8:38:80:8f status: 0: Successful
1669673529.765869: wlan0: del station c6:27:28:**:**:**
1669673539.645268: wlan0 (phy #0): scan started
1669673541.813879: wlan0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240 5260
5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700,
"AI-2+23" ""
1669673541.845944: wlan0: new station c6:27:28:**:**:**

After authentication it changes states then it gets removed and
destroyed at zero time. The SSID in question is at 2,4GHz and I have
enabled SSIDs isolation.

Any ideas?
