Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B955963A2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 22:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiHPUT4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 16:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiHPUTz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 16:19:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624FB5E579
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 13:19:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so21021608ejp.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=8ADEpdfGA0jqJVpgEhbjoKMmeHDNOBoopF/N+sTzUmE=;
        b=MGCgac7ljCXXGvkqRXlnA23rglD3jYCgRVlZJMFqLklrXpI4kA7BadECYJxk6VeCZu
         1sJzCx1Qynymy64YgKMy3Z4MD6XUtPdSIVTxwNHwmtDcs4BjwMsGVk4MbZ3tJB2y1DB2
         eLAciEemAk1CKxy6nVpb1rWkfB/UlZDXO/U5PJJmHF0u+IrEq49e6LIzo6N79+G5KyXA
         dfbWXCWW1QUiuAk0CifLPqnv9IFBQqC3Xv+1kUsAghulFnCWmR4qOMRm+prD1jbaEoXl
         IJNuspb6pHQZn+iQlJW7+kWlC8+JfgUlDVTSN+yzRI3NFCI4Frhh+2tOEauU3l2wvYSt
         ywgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=8ADEpdfGA0jqJVpgEhbjoKMmeHDNOBoopF/N+sTzUmE=;
        b=EW7ugB6ycbpn751ewHrqnvI2CoUqXbE398RlAxGkCFQ/bIcYhK2VrKUAm3jTIAIvsh
         2QJR8MLVMAI9p+RPl6QIFbbxDgvgshjZKNuf1AsjwzDW81f6YspMlwz51Kc4C/LIOFJL
         Mou8zhE4lVvFnTzwUWTI1Y4StvgWvILV4nTuVYqQp10A/FTqJ7OAGGc+zQVS/wYm7zwE
         25RF1P21DZVL9KaEbLyhTFCNj2BfswUV3ZDsECfm0KHZ0fPDikohoyFZAjt+XX4hHqpt
         /UZXb1e+YwC54vpvo5nG4CIcf43Qu7h8CIXhiu23G/ziTYGa+V/7jUi0pE/627Wvf79d
         naaQ==
X-Gm-Message-State: ACgBeo0rb7DB6GG9OQwPYp86Ack4LYaI6QhrtA8XO14skTOcjWeYhBkX
        iYHIUfPZw10O5g==
X-Google-Smtp-Source: AA6agR6nuQbEVQkD0oF5YNPgyN+62KjdoiJMvHXhBrBR8GipR+hw6qjWif4SNnZe4AgM9lCNQcqHxw==
X-Received: by 2002:a17:906:cc48:b0:730:7545:bf51 with SMTP id mm8-20020a170906cc4800b007307545bf51mr14067677ejb.247.1660681192988;
        Tue, 16 Aug 2022 13:19:52 -0700 (PDT)
Received: from [192.168.25.160] (ip-176-198-221-165.um43.pools.vodafone-ip.de. [176.198.221.165])
        by smtp.googlemail.com with ESMTPSA id jz20-20020a170906bb1400b007309a570bacsm5825730ejb.176.2022.08.16.13.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 13:19:52 -0700 (PDT)
Message-ID: <6415466b-f745-df14-2a0b-40861bd1ea10@googlemail.com>
Date:   Tue, 16 Aug 2022 22:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: de-DE
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Subject: rtw88: "timed out to flush queue 1"
To:     pkshih@realtek.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


I tried wireless-testing today to see if the recent rtw88 patches are 
fixing the problems I'm facing with my rtw8821ce device.
The device now associates much faster and the tons of "failed to get tx 
report from firmware" messages are gone.
However, the device disconnects very often and the log shows lots of

[   20.900786] rtw_8821ce 0000:02:00.0: timed out to flush queue 1

messages, which is new.


A typical section from the dmesg output:
...
[   13.099028] wlo1: authenticate with f8:d1:11:xx:xx:xx
[   13.128833] wlo1: Allocated STA f8:d1:11:xx:xx:xx
[   13.128846] wlo1: HE not supported, disabling HE and EHT
[   13.128848] wlo1: EHT not supported, disabling EHT
[   13.128849] wlo1: bad VHT capabilities, disabling VHT
[   13.128852] wlo1: VHT operation missing / VHT not supported
[   13.634812] wlo1: Inserted STA f8:d1:11:xx:xx:xx
[   13.772803] wlo1: send auth to f8:d1:11:xx:xx:xx (try 1/3)
[   13.775493] wlo1: authenticated
[   13.775501] wlo1: moving STA f8:d1:11:xx:xx:xx to state 2
[   13.775676] rtw_8821ce 0000:02:00.0 wlo1: disabling HT/VHT/HE as 
WMM/QoS is not supported by the AP
[   13.812815] wlo1: HE not supported, disabling HE and EHT
[   13.812822] wlo1: EHT not supported, disabling EHT
[   13.812826] wlo1: HT operation missing / HT not supported
[   14.318955] wlo1: associate with f8:d1:11:xx:xx:xx (try 1/3)
[   14.561324] wlo1: associate with f8:d1:11:xx:xx:xx (try 2/3)
[   14.571012] wlo1: RX AssocResp from f8:d1:11:xx:xx:xx (capab=0x431 
status=0 aid=1)
[   14.571052] wlo1: moving STA f8:d1:11:xx:xx:xx to state 3
[   14.571208] wlo1: associated
[   14.649252] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[   14.649610] wlo1: moving STA f8:d1:11:xx:xx:xx to state 4
[   20.900786] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   21.392784] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   21.904779] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   22.044770] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   23.312776] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   25.444803] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   25.960816] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   27.249290] wlo1: cancelling AP probe due to a received beacon
[   31.168781] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   31.604945] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   32.572767] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   33.832856] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   36.461025] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   37.405071] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   37.889031] rtw_8821ce 0000:02:00.0: timed out to flush queue 1
[   39.641417] wlo1: cancelling AP probe due to a received beacon
[   49.293315] wlo1: cancelling AP probe due to a received beacon
[   58.861319] wlo1: cancelling AP probe due to a received beacon
[   68.669330] wlo1: cancelling AP probe due to a received beacon
[   78.205321] wlo1: cancelling AP probe due to a received beacon
[   80.793042] wlo1: detected beacon loss from AP (missed 7 beacons) - 
probing
[   80.824424] wlo1: No ack for nullfunc frame to AP f8:d1:11:xx:xx:xx, 
try 1/2
[   80.851851] wlo1: No ack for nullfunc frame to AP f8:d1:11:xx:xx:xx, 
disconnecting.
[   80.889060] wlo1: moving STA f8:d1:11:xx:xx:xx to state 3
[   80.905202] wlo1: moving STA f8:d1:11:xx:xx:xx to state 2
[   80.905230] wlo1: moving STA f8:d1:11:xx:xx:xx to state 1
[   80.905233] wlo1: Removed STA f8:d1:11:xx:xx:xx
[   80.905338] wlo1: Destroyed STA f8:d1:11:xx:xx:xx
...

FW version is 24.11.0.
I tried with and without disable_lps_deep / disable_aspm, but that makes 
no difference.

Any ideas ? Anything I can do ?

Regards,
Frank
