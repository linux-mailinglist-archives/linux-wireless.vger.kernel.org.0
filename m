Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58A32D29C4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgLHL2m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 06:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgLHL2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 06:28:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7DC061749;
        Tue,  8 Dec 2020 03:28:02 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e23so11912148pgk.12;
        Tue, 08 Dec 2020 03:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KL6dZ3kydfS5o6fiJ+I/B+eMrsD10UYcVwgCqkl6bVc=;
        b=n4eC0V67c5Zn4pZhDWc8qhYJkm+ApzAWilQ5Fzv6PSQkJ/402nqQtZ5Njs+Ybzuq3R
         b+3uuV5rij2zVJinDxcsPsz7Mi4h21+7c6kuR5+83qXcm4bCIqUwieOCMkE6oDVjNG52
         dvB/ba/9fO1svSj6l5DdfpbLilXXilvqsYry/BvkiWjglwwwx5MESUqvmcfL2pB/2zzo
         9XIPIbX15Fxy92vTX3naQs+mv+CQqhuBkomxBvHfmO2yCLClhW2fE3WDocdKvba16QCR
         AEYyeZ6TkD6epvYUvZBsByUSmUKQnhhfvI525Dh0PtMMD12zXnxRV8SQ6MtbJgOh9f/6
         neQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KL6dZ3kydfS5o6fiJ+I/B+eMrsD10UYcVwgCqkl6bVc=;
        b=TW9CF7lvESgPvkV55oY/OUpEfzuxUgRE4SEI9zaEOF3nZJST14Xnt94p1hM1K45K5G
         Gea0YpI2xuiZZJ86VvrksNoGbuGa3c2VZYHuAPftdni2mWXy3EXCZdnK18Y/QsuylHEW
         jPwcYf69TKZct74sUZDQJOhi+i/OVMCIfFDqMr/ol4EtGXCUlkSlj/V+QQ7WAjlmSsM7
         PZL551psHR+64Ws2lmJ8aaoAAAGkpM5ZtPfvabaBKb2SLU82ScfkrGj47Ad1MrNMUE1+
         0KgbX0mM3DEGPARyARG5BIDiuoJetOazVAvzDqxbJXdm9U8yz81sGUDeJEkaDBpkTrdf
         JolA==
X-Gm-Message-State: AOAM530cfSFWKuidcx/yMqzpwZmwVAS8vYE6PbFDoLsipZ8XnIyMbxi2
        TIxi17tbF/Sg0wF+LaSZ1i0ZjPcsYaPz6Z9Vcu3oe+b2koN/
X-Google-Smtp-Source: ABdhPJyZzxxtmdarg1cjvXB15iicRD97f7jDIRCjmYPZ+MwBvZ+eDJ40mottimbUflrXRrO/KY7TYfV9mr/Mt8j2RXw=
X-Received: by 2002:a63:b60:: with SMTP id a32mr22160949pgl.275.1607426881636;
 Tue, 08 Dec 2020 03:28:01 -0800 (PST)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 8 Dec 2020 11:27:50 +0000
Message-ID: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
Subject: [BUG] iwlwifi: card unusable after firmware crash
To:     luciano.coelho@intel.com, johannes.berg@intel.com,
        mordechay.goodstein@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, everyone,

I'm running Linux 5.10-rc7 with this firmware/hardware:

[    1.431878] iwlwifi 0000:02:00.0: loaded firmware version
29.198743027.0 7265D-29.ucode op_mode iwlmvm
[    1.431899] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band
Wireless AC 3165, REV=0x210

Most of the time, after disabling/enabling Wi-Fi (or, say, rebooting
the router), the card dies and only comes back after reboot. This is
the relevant dmesg output:

[ 3174.003910] iwlwifi 0000:02:00.0: RF_KILL bit toggled to disable radio.
[ 3174.003913] iwlwifi 0000:02:00.0: reporting RF_KILL (radio disabled)
[ 3174.040788] iwlwifi 0000:02:00.0: iwlwifi transaction failed,
dumping registers
[ 3174.040790] iwlwifi 0000:02:00.0: iwlwifi device config registers:
[ 3174.041008] iwlwifi 0000:02:00.0: 00000000: 31668086 00100406
02800099 00000010 c1100004 00000000 00000000 00000000
[ 3174.041010] iwlwifi 0000:02:00.0: 00000020: 00000000 00000000
00000000 42108086 00000000 000000c8 00000000 000001ff
[ 3174.041011] iwlwifi 0000:02:00.0: 00000040: 00020010 10008ec0
00100c10 0046e811 10110142 00000000 00000000 00000000
[ 3174.041013] iwlwifi 0000:02:00.0: 00000060: 00000000 00080812
00000005 00000000 00010001 00000000 00000000 00000000
[ 3174.041014] iwlwifi 0000:02:00.0: 00000080: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041016] iwlwifi 0000:02:00.0: 000000a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041017] iwlwifi 0000:02:00.0: 000000c0: 00000000 00000000
c823d001 0d000000 00814005 fee00318 00000000 00000000
[ 3174.041019] iwlwifi 0000:02:00.0: 000000e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041020] iwlwifi 0000:02:00.0: 00000100: 14010001 00000000
00000000 00462031 00000000 00002000 00000000 00000000
[ 3174.041022] iwlwifi 0000:02:00.0: 00000120: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041023] iwlwifi 0000:02:00.0: 00000140: 14c10003 ff75a50d
e09467ff 15410018 10031003 0001001e 00f01e1f 6003000b
[ 3174.041024] iwlwifi 0000:02:00.0: iwlwifi device memory mapped registers:
[ 3174.041075] iwlwifi 0000:02:00.0: 00000000: 00800000 00000000
00000080 00000000 00000000 00000000 00000000 00000000
[ 3174.041076] iwlwifi 0000:02:00.0: 00000020: 00000001 080003d8
00000210 d55555d5 00000000 d55555d5 80008040 00080042
[ 3174.041088] iwlwifi 0000:02:00.0: iwlwifi device AER capability structure:
[ 3174.041112] iwlwifi 0000:02:00.0: 00000000: 14010001 00000000
00000000 00462031 00000000 00002000 00000000 00000000
[ 3174.041113] iwlwifi 0000:02:00.0: 00000020: 00000000 00000000 00000000
[ 3174.041114] iwlwifi 0000:02:00.0: iwlwifi parent port
(0000:00:1c.5) config registers:
[ 3174.041198] iwlwifi 0000:00:1c.5: 00000000: 9d158086 00100407
060400f1 00810010 00000000 00000000 00020200 200000f0
[ 3174.041200] iwlwifi 0000:00:1c.5: 00000020: c110c110 0001fff1
00000000 00000000 00000000 00000040 00000000 000202ff
[ 3174.041201] iwlwifi 0000:00:1c.5: 00000040: 01428010 00008001
00110000 06724813 70110042 002cb200 01400000 00000000
[ 3174.041203] iwlwifi 0000:00:1c.5: 00000060: 00000000 00000037
00000000 0000000e 00010003 00000000 00000000 00000000
[ 3174.041204] iwlwifi 0000:00:1c.5: 00000080: 00019005 fee00258
00000000 00000000 0000a00d 382a17aa 00000000 00000000
[ 3174.041206] iwlwifi 0000:00:1c.5: 000000a0: c8030001 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041207] iwlwifi 0000:00:1c.5: 000000c0: 00000000 00000000
00000000 00000000 07001001 00001842 8b1e0008 00000000
[ 3174.041209] iwlwifi 0000:00:1c.5: 000000e0: 00630300 00000000
00100006 00000000 00000050 4c000000 08230fb3 02000004
[ 3174.041210] iwlwifi 0000:00:1c.5: 00000100: 14000000 00000000
00000000 00060011 00000001 00002000 00000000 00000000
[ 3174.041211] iwlwifi 0000:00:1c.5: 00000120: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041213] iwlwifi 0000:00:1c.5: 00000140: 2001000d 0000000f
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041214] iwlwifi 0000:00:1c.5: 00000160: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041216] iwlwifi 0000:00:1c.5: 00000180: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041217] iwlwifi 0000:00:1c.5: 000001a0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041218] iwlwifi 0000:00:1c.5: 000001c0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041220] iwlwifi 0000:00:1c.5: 000001e0: 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000
[ 3174.041221] iwlwifi 0000:00:1c.5: 00000200: 2201001e 0028281f 6003280b

I also had this problem with the previous firmware version. Any ideas
about what could be causing it?

Thanks,
Rui
