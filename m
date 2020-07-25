Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91322D76D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jul 2020 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGYMLp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jul 2020 08:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgGYMLo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jul 2020 08:11:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E28FC0619D3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jul 2020 05:11:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s189so5190714iod.2
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jul 2020 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=0SNjNl2+Iny5/yg01OOdt78CHcAVl94td7xz87jKAbs=;
        b=uUSEArTrmETXVf5Lz3hPf/cdKdrvoCQs0zQ6iWrKxEnrIXyu2Zd3cSjdW2/fdSe0Ps
         srUmaxFZBPuZKySaMV8x/DjoG/MMtp848rgLVdknEacjRyHyoE9dKyr7DDzsZP+75oAx
         +l1jDR4sEnKP15EckSC3IHoWTB9CDA70JyY0D2iK3CRsvxCZNQnaGyDoTmAfnmoTCb9B
         6SCI8cEOiY0SdVNawlGou0SIyrvV+EoKPgyYeBVESut6X3zEAIGKZlNfBgB0IY8uS12F
         7h8PzgLbp0yfDqMIucsR6h+Xh37ITWxPW5W6PIscNapLaqagM5RemjuguYXBYHqO2YD1
         7haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0SNjNl2+Iny5/yg01OOdt78CHcAVl94td7xz87jKAbs=;
        b=eASBJj4ZBQ9e2+f4vxg3aGU9nnPiv59Z6vcW1DgTU8N64ZnoMdGUm114kWqI6PC/dJ
         Rhl26jzKtlkbZKMskJmRugtqaJOyW8b1xD82Ns6cHXRK7ixB6G7TeCDE9sAnlhzCK9N0
         IXB9tLKb6QvbtHoozO46c99VyAqiO156zWkTYzenxgETpZq7D22TYqnKkfp7V5e6D+FN
         nk28PRZcXr8nyDo++x91+EKxIoJz6788/GdodwDpH1mu1L4WQky6AsY0zMnO5mZL/Sev
         0YJgaPiBJvFsL3vtt13gzFVHh69BVRwTYVaubMjF2oTIpdNDnmziEVxN4RukiWvu7zxz
         jKZw==
X-Gm-Message-State: AOAM533ckGVLCdZ3DktfvtIjdeWWu0YONoNffqzVFcLJh0DaYpe8C5jd
        6TECQOWjcWOLEFzaV0sy7iBbd6d9dQT41mw+UTO11X2y22k=
X-Google-Smtp-Source: ABdhPJwja4f7VWxMM+t83nHQEJLNA0vf9VTvNZsgNFTc+Hnxt4bcWh6m8F0/7mjq4GiEPncRsleTChpesU2CxPUy7oA=
X-Received: by 2002:a02:c785:: with SMTP id n5mr16024253jao.75.1595679103850;
 Sat, 25 Jul 2020 05:11:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 25 Jul 2020 14:11:32 +0200
Message-ID: <CA+icZUWoycCvAAs5H0sigHTB+GGhX5NRVonYqKg7BRLB97dGkA@mail.gmail.com>
Subject: iwlwifi: Direct firmware load for iwl-debug-yoyo.bin failed with
 error -2
To:     Luca Coelho <luciano.coelho@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am seeing this failed/error message for a long time:

[Sat Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
for iwl-debug-yoyo.bin failed with error -2

So, I started to look for the file "iwl-debug-yoyo.bin" in [1], but failed.
AFAICS this is a file for debugging purposes?

Why do I see such a message as an end-user w/o iwlwifi-debugging enabled?
For some end-users I can imagine this looks scary and they will look
into their cupboards and below their beds but will not find any
monsters.

I found a rename from an ini file to bin here:
commit 8d9e982bf9bf ("iwlwifi: dbg_ini: rename external debug
configuration file")

Is "iwl-debug-yoyo.bin" a binary or as before an ini (text) file I
have to configure somehow.

Does this need to be guarded by some "ifdef CONFIG_IWLWIFI_DEBUG" in
"drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c"?

Or does drivers/net/wireless/intel/iwlwifi/Makefile needs some tuning
- as said I have no iwlwifi debugging enabled via Kconfig?
...
iwlwifi-objs            += iwl-dbg-tlv.o

Please enlighten me/us?

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/
[2] https://git.kernel.org/linus/e8d9e982bf9bf0e6f99099f1f09a37563b2b95b5

From my dmesg-output:

[Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: can't disable ASPM; OS
doesn't have ASPM control
[Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: loaded firmware
version 18.168.6.1 6000g2b-6.ucode op_mode iwldvm
[Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
for iwl-debug-yoyo.bin failed with error -2
[Sa Jul 25 13:03:30 2020] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUG disabled
[Sa Jul 25 13:03:30 2020] iwlwifi 0000:01:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[Sa Jul 25 13:03:30 2020] iwlwifi 0000:01:00.0:
CONFIG_IWLWIFI_DEVICE_TRACING disabled
[Sa Jul 25 13:03:30 2020] iwlwifi 0000:01:00.0: Detected Intel(R)
Centrino(R) Advanced-N 6230 AGN, REV=0xB0
