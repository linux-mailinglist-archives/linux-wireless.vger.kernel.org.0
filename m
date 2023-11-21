Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3341C7F31BB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 15:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjKUO5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 09:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKUO5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 09:57:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA7F98
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 06:57:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40859c464daso25638285e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700578653; x=1701183453; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k/NXgzcwq+EZ7LyUScl7RrWGz6rvJ6CisFhRZhilJYc=;
        b=nnmXTi1BZhaER/OFWxHgbHaGw3VcjO8HdEzAfqJWCyTzZe1vT2RAwX2HsV5REr4cmX
         AKayMjkvdyJ5HWn7RqwpEceW2uLJBjhGxI6zRfiMtNUMg+xk1T6bDAEIQmgMJtQa3Jmp
         /MycuuLs6wVj5AgawAkc/DC5AUhGPiLCfJtjaLedKHTSrtCYZau6zJM+EXDduC3yVDp6
         5Q9metVMIqbWfd0v0vfNLuCqHHlD8TLaSgi9OTYR7P44ihe//6+4OghbTHvnlqF62wrY
         1VvLVWmoryzga1DvsKnTL3KpwqjL6sau5iw40M9G9AFijXsdRrtxr/6ldVqFS5729d4l
         yiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700578653; x=1701183453;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/NXgzcwq+EZ7LyUScl7RrWGz6rvJ6CisFhRZhilJYc=;
        b=h2iLibNM8QK3BWje/8IjCuhXYF7QynTYu83msuKeIKDcEDXJZlibUKhjTbjEHRS0z+
         OM2a3eDT1FLlVXxCuRwlE4H2RMtdnf7y4j4N3kjEsFAaaO0LNb5p6wUBEdB1ywROdLbT
         Jyr0O77qHafDRQoCH669+16KOXEILFMpScZePIbjRdlKAjKc+9nu8YakTFBD2MrPmkdW
         RaN5ccasUbHjak/o4xK/BJQcCPaG7FMz08W8GEtr+2pdyLD9HaloWNVpptIR0snBUrTT
         ZUd+hn550zDNZHWvdspzG6EyE8cE61EOC72WtwrC9qpUhcNVRTeLKGOZre0m1m5qIU/i
         G9Ig==
X-Gm-Message-State: AOJu0YzIGsoAb9HdjB0j05djt34Dxyba74DTeZ4b9fK0XqMp9tXL9LGX
        UfxIstAk9a57lIzQdY9wd21ng8zn37F+vvm5CNZEivy+S/0=
X-Google-Smtp-Source: AGHT+IEyiITNAc2V1UauHIKG+FhnYT+tv+I4AJWUw25WaXNX/6rNaOJ4SYIATEOP7AcRYWyfdSurI8cN9diPsGbcsrk=
X-Received: by 2002:a05:600c:4fc5:b0:40a:4835:d2a7 with SMTP id
 o5-20020a05600c4fc500b0040a4835d2a7mr8926460wmq.7.1700578653036; Tue, 21 Nov
 2023 06:57:33 -0800 (PST)
MIME-Version: 1.0
From:   Martin Larsson <martin.larsson2@gmail.com>
Date:   Tue, 21 Nov 2023 15:57:20 +0100
Message-ID: <CABUmD9v4sU2eBcGRiG_7pMhUHcjtEpsS4-g5EYfJPCHnt8X9jQ@mail.gmail.com>
Subject: mediateck firmware for mt7921 segfaults
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hello!

when I use the latest version

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/mediatek/WIFI_RAM_CODE_MT7961_1.bin

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin

I get kernel errors and no device cant function.

   5.949111] Unable to handle kernel paging request at virtual address
ffffffc07201f469
[    5.949128] Mem abort info:
[    5.949132]   ESR = 0x0000000096000005
[    5.949137]   EC = 0x25: DABT (current EL), IL = 32 bits
[    5.949143]   SET = 0, FnV = 0
[    5.949147]   EA = 0, S1PTW = 0
[    5.949151]   FSC = 0x05: level 1 translation fault
[    5.949156] Data abort info:
[    5.949160]   ISV = 0, ISS = 0x00000005
[    5.949164]   CM = 0, WnR = 0
[    5.949168] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000012aa000
[    5.949174] [ffffffc07201f469] pgd=0000000000000000,
p4d=0000000000000000, pud=0000000000000000
[    5.949192] Internal error: Oops: 0000000096000005 [#1] SMP



my device functions fine with firmware from
https://anduin.linuxfromscratch.org/sources/linux-firmware/mediatek/

OS is libreelec 12 using kernel 6.1.58
machine is raspberry pi 4

full dmesg below.

http://ix.io/4LOo

thanks
