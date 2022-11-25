Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC03A637FB0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKXTfp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKXTfn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:35:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07A827D4
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:35:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j4so3894925lfk.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jWkUaNoHrSPKQOkBRg0F/kgVQTBoHdztu+sCWJWV2+Y=;
        b=cbb9+vf1nV/BoIefRcjmx1rmTyEEyBEg+0ydPdS6EbhepBARkojOgvVpXj487EfUqD
         JkLnX4Wi6OeGuWg4WVOxl0bJBLpGaObS4sjdR4YV9DojmRfY47FsRKVd4IlfWU/Wbjt4
         a3jWbYGGT87T3l/DVz3ggJ+/qeOYiEfXkgvumTpoverQvXd+Tq0kyALZ5Ro26PkwYUWo
         e5rePJ2Vp9ubl55jEdbqIOsZCAfav1KbXdJ9q6CiH8NA69gwvqIAhyGdghbLlTnwYMbt
         YqdT9TxCgGWnUeWN0bDOF0501O0lLnIIqnuLmAEEdZn/sDxu/2RAFQQyBjUxTb1aq43U
         KjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWkUaNoHrSPKQOkBRg0F/kgVQTBoHdztu+sCWJWV2+Y=;
        b=C2TUipuH/qPUgzGY8VmDtvT6SPWHr9FIBpxUHGI5GQIyS/CNValCqRBso/rYoQxVKW
         lcEOmONp3Hn89hPaUx9DDR3CWZZ/M7Eek6RE3sE0gB77stQN6ctYBg7/Eyf+XQriSDf2
         0uKISRGeamQ/Rt43FKcg5+ZC+/jpVYxQhh2/8JuYINBudmDtBfRdmN6BYoDWGbZ+GglH
         rECYAmhbixrLEExnsAU/R85Ba6dNHxg98d3anuHHjHhCI2QWeNnAUhLqrVga+GUN7Fwe
         PzRstWvJka9hLg4i3V30BqmrVDP7X59fKkuoBoo+AcFSSiu9oBJRtCHq8W0d6+lD5rVk
         y73A==
X-Gm-Message-State: ANoB5pmZqiARFDv6iUIjIyDygo5CbQ5G7bI5zmDKwRkhLRuEp2PKkmLV
        KIG7La60qJlY80dzDRdQHwK7phJ+FRDI6CFk/bjczOVqdwOikA==
X-Google-Smtp-Source: AA0mqf68iLoyQHTA3EcjheDdTIe88NRz/BW7RZO+JDcNntI/aGOVyi3x+AryJAwhfvTa7GsnHenGonTmH/Da1T9vL0M=
X-Received: by 2002:a05:6512:4c8:b0:4a2:7d11:80e8 with SMTP id
 w8-20020a05651204c800b004a27d1180e8mr10879387lfq.464.1669318541058; Thu, 24
 Nov 2022 11:35:41 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:34:30 +0200
Message-ID: <CADUzMVaETr=hwh8=ZouQvF1BCGDifwMcp1k8zDtCt_vVWoe=7w@mail.gmail.com>
Subject: BCM4313 Broadcom WPA3 SSID connection problem #7
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Moving to the next mPCIe device, on Ubuntu boot I get:
[   58.342128] Support for cores revisions 0x17 and 0x18 disabled by
module param allhwsupport=0. Try b43.allhwsupport=1
[   58.342140] b43: probe of bcma0:1 failed with error -524
[   58.342185] Broadcom 43xx driver loaded [ Features: PNL ]
[   58.460434] brcmsmac bcma0:1: mfg 4bf core 812 rev 24 class 0 irq 16
[   58.461372] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   58.461941] ieee80211 phy0: registered radio enabled led device:
brcmsmac-phy0:radio
[   58.466916] brcmsmac bcma0:1 wlp2s0b1: renamed from wlan0

Here is what I get on WPA3 SSID connection attempt:
[  314.562750] wlp2s0b1: authenticate with c6:27:28:**:**:**
[  314.562799] wlp2s0b1: 80 MHz not supported, disabling VHT
[  314.564600] wlp2s0b1: send auth to c6:27:28:**:**:** (try 1/3)
[  314.753466] wlp2s0b1: authenticate with c6:27:28:**:**:**
[  314.753485] wlp2s0b1: send auth to c6:27:28:**:**:** (try 1/3)
[  314.859120] wlp2s0b1: authenticated
[  314.863380] wlp2s0b1: associate with c6:27:28:**:**:** (try 1/3)
[  314.869543] wlp2s0b1: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  314.870070] brcmsmac bcma0:1: brcmsmac: brcms_ops_bss_info_changed:
associated
[  314.870086] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos
enabled: true (implement)
[  314.870114] wlp2s0b1: associated
[  314.946507] wlp2s0b1: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  314.946534] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos
enabled: true (implement)
[  314.966486] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211:  txop
exceeded phylen 168/256 dur 1850/1504
[  314.997892] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211:  txop
exceeded phylen 137/256 dur 1602/1504
[  315.067741] wlp2s0b1: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  315.115601] brcmsmac bcma0:1: brcmsmac: brcms_ops_bss_info_changed:
disassociated
[  315.115627] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos
enabled: false (implement)
[  316.169090] wlp2s0b1: authenticate with c6:27:28:**:**:**
[  316.169143] wlp2s0b1: 80 MHz not supported, disabling VHT
[  316.169326] wlp2s0b1: send auth to c6:27:28:**:**:** (try 1/3)
[  316.178750] wlp2s0b1: authenticated
[  316.183370] wlp2s0b1: associate with c6:27:28:**:**:** (try 1/3)
[  316.191260] wlp2s0b1: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  316.191778] brcmsmac bcma0:1: brcmsmac: brcms_ops_bss_info_changed:
associated
[  316.191794] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos
enabled: true (implement)
[  316.191824] wlp2s0b1: associated
[  316.277762] wlp2s0b1: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  316.277794] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos
enabled: true (implement)
[  316.296526] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211:  txop
exceeded phylen 184/256 dur 1978/1504
[  316.301724] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211:  txop
exceeded phylen 137/256 dur 1602/1504
[  316.332056] wlp2s0b1: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)

and later on can't connect even to the WPA2,3 2,4GHz SSID. It worked
only after a reboot and was dead slow so what needs to be done here?
Use the b43.allhwsupport=1 parameter or try wl as well?
