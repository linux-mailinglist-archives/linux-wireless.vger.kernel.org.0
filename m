Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3063C8E4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 21:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiK2UBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 15:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiK2UBT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 15:01:19 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3A27FD1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 12:01:16 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a7so18503396ljq.12
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 12:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Waw38L+iAfz/yF0QagMM3gO2FdQYXmp0om5bjiHPsZU=;
        b=MxKQ8/17tnjosiBbapTw2UdjiPgxUuxdi77uvDWI1KMcCBQhA0iPKCXqd2S+lqGk4J
         EcrMoMjezz3Lea8iJTwK6shMZAhDlkkhvkcHMUyFXTpoLw5Khezr2AJFVgw9gaXkVgLG
         9/rKgbpBv+VtQGM/uYWNB0D9w5XPbXQwcIGyPEVkQMiUZAaSd/ueIPNuxkm/AuHQLz5J
         ReluxpVjSGz+o5jaJh95dvFFuLP0KnpkAgWl5V0peaxjZt3TfGyuR8HL8vfj9EJyCMX+
         vh64INg22r6QWPhJwRLXsZgOeTb4u52u5q/pwLue+Wqoy2lSIy+dMsx8H1GxrKb2Yk9x
         +Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Waw38L+iAfz/yF0QagMM3gO2FdQYXmp0om5bjiHPsZU=;
        b=3Kj0Php4m7BUrdZ/UfVHWxPI0hxRdcTBFF9JVZNSSHqse3hAjUqoXUpjoIkzrzwJsv
         P0JvxPUKLrQGXD2PnZoyOjhl8iudcg7kojfduecXfru4FseWU0pdyUL9CIbd8uqTPGcu
         I5m86/ivcPv2ooKtgxYPCrvHKPFFpTFNMipEohP5oY1zzwb6gLDO5ktVFz3GfTdSAcvC
         o7xuH1as08lDXLM2aXsnr06b1BxJEXTABQ80U+XVZ0V2+FqQV+2OqrooTa5AAphh0OK8
         9yi6RI6apa6pP09h5xOfvDmT3gCOXpsY0gTTD0BrCXwO2FRPOHWaz6mSJiosNX1/Vghv
         XiBQ==
X-Gm-Message-State: ANoB5pl9VOoY7jG45mVnyc5DOpEn3YBzs8zfKeFdMsFPjx3Y4gsh0U3A
        0WWr2OxaHKHz2cUzTRBIVDQSoGpNshWDFbaWpCClIw+PSeg=
X-Google-Smtp-Source: AA0mqf4AWA/tSPUH0gsBrILRIReLMT182JexC4SRprhxJulQ983ky9He9qHOVcfTBH3fq2I44sNqiz1Vo1X7Me+3KLI=
X-Received: by 2002:a05:651c:988:b0:279:7ab3:8738 with SMTP id
 b8-20020a05651c098800b002797ab38738mr11569446ljq.232.1669752074994; Tue, 29
 Nov 2022 12:01:14 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Tue, 29 Nov 2022 22:01:03 +0200
Message-ID: <CADUzMVaOxv5DRLQypu2Hdafwuo37fP4U2L1St_uT9Fw0NZVvzg@mail.gmail.com>
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

Indeed that error was fixed but the device is still non functional and
I got two of them so it is not defective hardware.

I tested with:
rmmod iwl4965
modprobe iwl4965 swcrypto=1

and after a reboot I added:
options iwlwifi swcrypto=1
here:
/etc/modprobe.d/iwlwifi.conf

This time some new errors came to surface:
[ 1635.006819] iwl4965 0000:02:00.0: Error sending TX power (-5)
[ 1736.613307] iwl4965 0000:02:00.0: Can't stop Rx DMA.

In detail:
[ 1334.537673] wlan0: authenticate with c6:27:28:**:**:**
[ 1334.557315] wlan0: Allocated STA c6:27:28:**:**:**
[ 1334.557347] wlan0: HE not supported, disabling HE and EHT
[ 1334.557352] wlan0: EHT not supported, disabling EHT
[ 1334.557357] wlan0: 40 MHz not supported
[ 1334.557502] wlan0: Inserted STA c6:27:28:**:**:**
[ 1334.557509] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1334.700383] wlan0: authenticate with c6:27:28:**:**:**
[ 1334.713363] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1334.809397] wlan0: authenticated
[ 1334.809412] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1334.905323] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1334.905342] wlan0: Removed STA c6:27:28:**:**:**
[ 1334.905491] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1346.945244] wlan0: authenticate with c6:27:28:**:**:**
[ 1346.973500] wlan0: Allocated STA c6:27:28:**:**:**
[ 1346.973544] wlan0: HE not supported, disabling HE and EHT
[ 1346.973549] wlan0: EHT not supported, disabling EHT
[ 1346.973558] wlan0: 40 MHz not supported
[ 1346.973778] wlan0: Inserted STA c6:27:28:**:**:**
[ 1346.973787] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1348.985488] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1349.140047] wlan0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1349.281270] wlan0: authenticate with c6:27:28:**:**:**
[ 1349.293504] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1349.392493] wlan0: authenticated
[ 1349.392510] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1349.465546] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1349.465567] wlan0: Removed STA c6:27:28:**:**:**
[ 1349.465659] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1362.286207] wlan0: authenticate with c6:27:28:**:**:**
[ 1362.305641] wlan0: Allocated STA c6:27:28:**:**:**
[ 1362.305671] wlan0: HE not supported, disabling HE and EHT
[ 1362.305676] wlan0: EHT not supported, disabling EHT
[ 1362.305682] wlan0: 40 MHz not supported
[ 1362.305826] wlan0: Inserted STA c6:27:28:**:**:**
[ 1362.305833] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1364.310367] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1364.458140] wlan0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1364.600945] wlan0: authenticate with c6:27:28:**:**:**
[ 1364.613682] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1364.706960] wlan0: authenticated
[ 1364.706973] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1364.769623] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1364.769641] wlan0: Removed STA c6:27:28:**:**:**
[ 1364.769787] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1376.829234] wlan0: authenticate with c6:27:28:**:**:**
[ 1376.841759] wlan0: Allocated STA c6:27:28:**:**:**
[ 1376.841789] wlan0: HE not supported, disabling HE and EHT
[ 1376.841791] wlan0: EHT not supported, disabling EHT
[ 1376.841796] wlan0: 40 MHz not supported
[ 1376.841924] wlan0: Inserted STA c6:27:28:**:**:**
[ 1376.841928] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1378.015830] wlan0: aborting authentication with c6:27:28:**:**:**
by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1378.029754] wlan0: Removed STA c6:27:28:**:**:**
[ 1378.029922] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1390.358913] wlan0: authenticate with c6:27:28:**:**:**
[ 1390.373953] wlan0: Allocated STA c6:27:28:**:**:**
[ 1390.373984] wlan0: HE not supported, disabling HE and EHT
[ 1390.373992] wlan0: EHT not supported, disabling EHT
[ 1390.373998] wlan0: 40 MHz not supported
[ 1390.374128] wlan0: Inserted STA c6:27:28:**:**:**
[ 1390.374136] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1390.522330] wlan0: authenticate with c6:27:28:**:**:**
[ 1390.549913] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1390.621516] wlan0: authenticated
[ 1390.621531] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1390.725981] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1390.725999] wlan0: Removed STA c6:27:28:**:**:**
[ 1390.726142] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1402.731377] wlan0: authenticate with c6:27:28:**:**:**
[ 1402.754076] wlan0: Allocated STA c6:27:28:**:**:**
[ 1402.754107] wlan0: HE not supported, disabling HE and EHT
[ 1402.754111] wlan0: EHT not supported, disabling EHT
[ 1402.754117] wlan0: 40 MHz not supported
[ 1402.754243] wlan0: Inserted STA c6:27:28:**:**:**
[ 1402.754250] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1404.760795] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1404.897746] wlan0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1405.047343] wlan0: authenticate with c6:27:28:**:**:**
[ 1405.062086] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1405.148172] wlan0: authenticated
[ 1405.148191] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1405.286057] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1405.286078] wlan0: Removed STA c6:27:28:**:**:**
[ 1405.286219] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1634.944032] iwl4965 0000:02:00.0: vgaarb: pci_notify
[ 1635.006819] iwl4965 0000:02:00.0: Error sending TX power (-5)
[ 1635.078785] pci 0000:02:00.0: vgaarb: pci_notify

Module loaded here:
[ 1666.956980] iwl4965: Intel(R) Wireless WiFi 4965 driver for Linux, in-tree:d
[ 1666.956989] iwl4965: Copyright(c) 2003-2011 Intel Corporation
[ 1666.957030] iwl4965 0000:02:00.0: vgaarb: pci_notify
[ 1666.957039] iwl4965 0000:02:00.0: runtime IRQ mapping not provided by arch
[ 1666.957103] iwl4965 0000:02:00.0: can't disable ASPM; OS doesn't
have ASPM control
[ 1666.957223] iwl4965 0000:02:00.0: enabling bus mastering
[ 1666.957253] iwl4965 0000:02:00.0: Detected Intel(R) Wireless WiFi
Link 4965AGN, REV=0x4
[ 1666.999179] iwl4965 0000:02:00.0: device EEPROM VER=0x36, CALIB=0x5
[ 1666.999193] iwl4965 0000:02:00.0: Tunable channels: 13 802.11bg, 19
802.11a channels
[ 1666.999497] iwl4965 0000:02:00.0: vgaarb: pci_notify
[ 1666.999632] iwl4965 0000:02:00.0: loaded firmware version 228.61.2.24
[ 1666.999840] ieee80211 phy1: Selected rate control algorithm 'iwl-4965-rs'
[ 1684.544669] wlan0: authenticate with c6:27:28:**:**:**
[ 1684.584425] wlan0: Allocated STA c6:27:28:**:**:**
[ 1684.584459] wlan0: HE not supported, disabling HE and EHT
[ 1684.584463] wlan0: EHT not supported, disabling EHT
[ 1684.584470] wlan0: 40 MHz not supported
[ 1684.606124] wlan0: Inserted STA c6:27:28:**:**:**
[ 1684.606139] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1684.642375] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1684.789570] wlan0: authenticate with c6:27:28:**:**:**
[ 1684.812363] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1684.848190] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1684.893973] wlan0: authenticated
[ 1684.893988] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1687.106441] wlan0: authenticate with c6:27:28:**:**:**
[ 1687.120408] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1687.159559] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1687.298837] wlan0: authenticate with c6:27:28:**:**:**
[ 1687.312388] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1687.347211] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1687.410445] wlan0: authenticated
[ 1690.178463] wlan0: authenticate with c6:27:28:**:**:**
[ 1690.200390] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1690.242843] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1690.378920] wlan0: authenticate with c6:27:28:**:**:**
[ 1690.404411] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1690.430707] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1690.491418] wlan0: authenticated
[ 1693.658542] wlan0: authenticate with c6:27:28:**:**:**
[ 1693.688393] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1693.729205] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1693.869910] wlan0: authenticate with c6:27:28:**:**:**
[ 1693.888382] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1693.922554] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1693.978397] wlan0: authenticated
[ 1699.012448] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1699.012471] wlan0: Removed STA c6:27:28:**:**:**
[ 1699.012629] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1700.063570] iwl4965 0000:02:00.0: Can't stop Rx DMA.
[ 1710.656930] wlan0: authenticate with c6:27:28:**:**:**
[ 1710.672404] wlan0: Allocated STA c6:27:28:**:**:**
[ 1710.672437] wlan0: HE not supported, disabling HE and EHT
[ 1710.672442] wlan0: EHT not supported, disabling EHT
[ 1710.672449] wlan0: 40 MHz not supported
[ 1710.672622] wlan0: Inserted STA c6:27:28:**:**:**
[ 1710.672630] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1710.819981] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1710.960209] wlan0: authenticate with c6:27:28:**:**:**
[ 1710.976349] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1711.076359] wlan0: authenticated
[ 1711.076376] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1711.156395] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1711.156414] wlan0: Removed STA c6:27:28:**:**:**
[ 1711.156557] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1723.252501] wlan0: authenticate with c6:27:28:**:**:**
[ 1723.276416] wlan0: Allocated STA c6:27:28:**:**:**
[ 1723.276449] wlan0: HE not supported, disabling HE and EHT
[ 1723.276453] wlan0: EHT not supported, disabling EHT
[ 1723.276459] wlan0: 40 MHz not supported
[ 1723.276605] wlan0: Inserted STA c6:27:28:**:**:**
[ 1723.276612] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1725.280410] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1725.422479] wlan0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1725.565379] wlan0: authenticate with c6:27:28:**:**:**
[ 1725.588412] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1725.666706] wlan0: authenticated
[ 1725.666722] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1725.772388] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1725.772406] wlan0: Removed STA c6:27:28:**:**:**
[ 1725.772554] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1736.613307] iwl4965 0000:02:00.0: Can't stop Rx DMA.
[ 1746.290214] wlan0: authenticate with c6:27:28:**:**:**
[ 1746.328440] wlan0: Allocated STA c6:27:28:**:**:**
[ 1746.328475] wlan0: HE not supported, disabling HE and EHT
[ 1746.328480] wlan0: EHT not supported, disabling EHT
[ 1746.328486] wlan0: 40 MHz not supported
[ 1746.328627] wlan0: Inserted STA c6:27:28:**:**:**
[ 1746.328634] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1746.470935] wlan0: authenticate with c6:27:28:**:**:**
[ 1746.484363] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1746.572808] wlan0: authenticated
[ 1746.572822] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1746.656400] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1746.656417] wlan0: Removed STA c6:27:28:**:**:**
[ 1746.656558] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1758.692182] wlan0: authenticate with c6:27:28:**:**:**
[ 1758.712464] wlan0: Allocated STA c6:27:28:**:**:**
[ 1758.712497] wlan0: HE not supported, disabling HE and EHT
[ 1758.712502] wlan0: EHT not supported, disabling EHT
[ 1758.712507] wlan0: 40 MHz not supported
[ 1758.712643] wlan0: Inserted STA c6:27:28:**:**:**
[ 1758.712651] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1760.736423] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1760.873119] wlan0: send auth to c6:27:28:**:**:** (try 3/3)
[ 1761.020778] wlan0: authenticate with c6:27:28:**:**:**
[ 1761.040373] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1761.127529] wlan0: authenticated
[ 1761.127545] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1761.292330] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1761.292348] wlan0: Removed STA c6:27:28:**:**:**
[ 1761.292486] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1784.365757] iwl4965 0000:02:00.0: Can't stop Rx DMA.
[ 1804.667349] wlan0: authenticate with c6:27:28:**:**:**
[ 1804.692421] wlan0: Allocated STA c6:27:28:**:**:**
[ 1804.692453] wlan0: HE not supported, disabling HE and EHT
[ 1804.692458] wlan0: EHT not supported, disabling EHT
[ 1804.692464] wlan0: 40 MHz not supported
[ 1804.692612] wlan0: Inserted STA c6:27:28:**:**:**
[ 1804.692619] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1804.832489] wlan0: authenticate with c6:27:28:**:**:**
[ 1804.868340] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1804.936487] wlan0: authenticated
[ 1804.936502] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1804.956395] wlan0: waiting for beacon from c6:27:28:**:**:**
[ 1805.024417] wlan0: associate with c6:27:28:**:**:** (try 1/3)
[ 1805.164426] wlan0: associate with c6:27:28:**:**:** (try 2/3)
[ 1805.345600] wlan0: associate with c6:27:28:**:**:** (try 3/3)
[ 1805.452423] wlan0: association with c6:27:28:**:**:** timed out
[ 1805.472401] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1805.472418] wlan0: Removed STA c6:27:28:**:**:**
[ 1805.472566] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1824.829685] wlan0: authenticate with c6:27:28:**:**:**
[ 1824.848377] wlan0: Allocated STA c6:27:28:**:**:**
[ 1824.848410] wlan0: HE not supported, disabling HE and EHT
[ 1824.848415] wlan0: EHT not supported, disabling EHT
[ 1824.848421] wlan0: 40 MHz not supported
[ 1824.848558] wlan0: Inserted STA c6:27:28:**:**:**
[ 1824.848566] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1825.001929] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1825.003969] wlan0: authenticated
[ 1825.003982] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1825.032444] wlan0: waiting for beacon from c6:27:28:**:**:**
[ 1825.096377] wlan0: associate with c6:27:28:**:**:** (try 1/3)
[ 1825.238853] wlan0: associate with c6:27:28:**:**:** (try 2/3)
[ 1825.244131] wlan0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[ 1825.244150] wlan0: c6:27:28:**:**:** denied association (code=31)
[ 1825.260359] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1825.260375] wlan0: Removed STA c6:27:28:**:**:**
[ 1825.260518] wlan0: Destroyed STA c6:27:28:**:**:**
[ 1825.289616] wlan0: authenticate with c6:27:28:**:**:**
[ 1825.324400] wlan0: Allocated STA c6:27:28:**:**:**
[ 1825.324430] wlan0: HE not supported, disabling HE and EHT
[ 1825.324435] wlan0: EHT not supported, disabling EHT
[ 1825.324441] wlan0: 40 MHz not supported
[ 1825.324586] wlan0: Inserted STA c6:27:28:**:**:**
[ 1825.324593] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1825.472799] wlan0: send auth to c6:27:28:**:**:** (try 2/3)
[ 1825.612963] wlan0: authenticate with c6:27:28:**:**:**
[ 1825.644358] wlan0: send auth to c6:27:28:**:**:** (try 1/3)
[ 1825.720211] wlan0: authenticated
[ 1825.720226] wlan0: moving STA c6:27:28:**:**:** to state 2
[ 1825.740367] wlan0: waiting for beacon from c6:27:28:**:**:**
[ 1825.812404] wlan0: associate with c6:27:28:**:**:** (try 1/3)
[ 1825.818262] wlan0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[ 1825.818281] wlan0: c6:27:28:**:**:** denied association (code=31)
[ 1825.832426] wlan0: moving STA c6:27:28:**:**:** to state 1
[ 1825.832442] wlan0: Removed STA c6:27:28:**:**:**
[ 1825.832588] wlan0: Destroyed STA c6:27:28:**:**:**

All these are from 6.0 plus your patch and swcrypto=1. Iw showed the
same things so there is no reason to send it again.

Best regards
