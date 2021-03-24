Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8461B3479DF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 14:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhCXNrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhCXNq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 09:46:58 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A129AC061763
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 06:46:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c17so21427825ilj.7
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWKqGMeo8mYdxMmrZWqa/MmY+77hzLp3R5QbjJVSrys=;
        b=Y+gP4ffbT9rPgaUxXOLV2ehp7fypFWzB9cj/CxGSR18RbFZYPcjkAjWJNkRHWsj4wL
         03mtK0spJzwss7nPZUMDBaxsuhYt39u6JkN5a7ehn8PlhsJcAJSjrdkhPpwWQ6vVM/R7
         C11SX6fns5k72Uz7V6ZEgkE++/cc15U098NxyVfrTqxM0/gKz4LzYGyMheSZGyiS8bDR
         /R0J2dVgxzQzrCjQYVRoz8GEFQipBksWv/LERLstLa/zcA0C+r0BZAa5nA8Q5NecJKGR
         H4WaSR9CQuYK+Xf4qHRJVdHVPvnVIxeJbXDnwghtW0zKdJzRjdAKyhqQ9nANcjp5QZki
         wGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWKqGMeo8mYdxMmrZWqa/MmY+77hzLp3R5QbjJVSrys=;
        b=pS+O3uvyS+UqcTXLyvQC/lkSlo/4FQsYVtTb0Zk+vxjjfHowaIy86LTDrmACKB/F3k
         xGsmoLUBgZ8AbfvVQJyosqPdLxi8an8ClQ0/SqTYruBl5Qi0Cy2wys522mIuZfXlPUAU
         uHOpBy8oMLXtNFny2qnd/elEr9XsGRFZb438+dXYri2tb/3EuT8VnRI3uGNCPsTD/2U9
         UkwSPt4rqzkp2ade031PHlQc5H5Nm1ujY4CAqUYOJ3dLDPBmP1iCkvjl3lpQVDiC4o+g
         3nnhwb2kpv4ooMtM8cwIVPflIHFpiVEaqN4qryJPHqXWmsli7cd/p1Rst6LJPec5JuHs
         5NLA==
X-Gm-Message-State: AOAM5307FEFJbej/SpaRq0wXEXrNgaPgeVBtBbDKXEDxDTudN80OYkHt
        dtTGgX3pSRimWHdPMu8B/a4i0/nTeEuYlAkxLnbeGdyIhuU=
X-Google-Smtp-Source: ABdhPJyRIKGKM5CLpcpN6RIQ6nqLcqAFgw2qbLhUHfGv64Q63vRIvxDpYbV86Pxk5TVPh4/MbaIcYSNqCUINd8XnXYo=
X-Received: by 2002:a05:6e02:1a09:: with SMTP id s9mr1130781ild.60.1616593617117;
 Wed, 24 Mar 2021 06:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiS6wC4BBANaY62sV8hxreDBsHXTHr=NKFLrOLc6SOYEiztmg@mail.gmail.com>
 <05fc5ab7-58b4-ac63-be21-bff9d5fc0ad0@candelatech.com>
In-Reply-To: <05fc5ab7-58b4-ac63-be21-bff9d5fc0ad0@candelatech.com>
From:   Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date:   Wed, 24 Mar 2021 15:46:46 +0200
Message-ID: <CAPiS6wB4Ls53ykD6iSUpBGN+sHauya1Mhu-7Q+Z_gzh=bAShAw@mail.gmail.com>
Subject: Re: Intel AX210 does not work on 5.11
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org, luciano.coelho@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 24, 2021 at 2:24 PM Ben Greear <greearb@candelatech.com> wrote:
>
> On 3/24/21 5:21 AM, Paulius Zaleckas wrote:
> > It was working on 5.10.16:
> > [    4.274856] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> > [    4.279014] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> > supported by driver
> > [    4.279031] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> > Version: 93.8.63.28
> > [    4.279401] iwlwifi 0000:3c:00.0: loaded firmware version
> > 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> > [    4.456228] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> > 160MHz, REV=0x420
> > [    4.607524] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > [    4.673134] iwlwifi 0000:3c:00.0: base HW address: d8:f8:83:d9:35:87
> > [    6.055731] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > [    6.288461] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > [   72.546602] iwlwifi 0000:3c:00.0 wlan0: disabling HT/VHT/HE as
> > WMM/QoS is not supported by the AP
> >
> > And fails to start on 5.11.8:
> > [    3.882744] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> > [    3.937708] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> > supported by driver
> > [    3.937720] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> > Version: 93.8.63.28
> > [    3.937891] iwlwifi 0000:3c:00.0: loaded firmware version
> > 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> > [    4.341262] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> > 160MHz, REV=0x420
> > [    4.486405] iwlwifi 0000:3c:00.0: loaded PNVM version 0x324cd670
> > [    4.588212] iwlwifi 0000:3c:00.0: Timeout waiting for PNVM load!
> > [    4.588213] iwlwifi 0000:3c:00.0: Failed to start RT ucode: -110
> > [    4.588215] iwlwifi 0000:3c:00.0: iwl_trans_send_cmd bad state = 1
> > [    4.796206] iwlwifi 0000:3c:00.0: firmware didn't ACK the reset -
> > continue anyway
> > [    4.808321] iwlwifi 0000:3c:00.0: Failed to run INIT ucode: -110
> >
> > Please add me to Cc as I am not on the list.
> >
>
> You probably need to get latest firmware from https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git
> and splat the intel related firmware into /lib/firmware/

Did that, but still the same issue...
