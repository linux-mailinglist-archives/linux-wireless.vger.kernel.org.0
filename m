Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1741A347D7A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhCXQRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhCXQQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 12:16:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938EC061763
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 09:16:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f19so22076617ion.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0JPkFhehcwvc0TpggQe1HDDfhQRa/+ly2iG1DRkDwM=;
        b=DjgtLvS4E36rhdFWoOW4TtRvx3iWGdsGLuQt4/7KcCt8aDn8r4IJ7CDFVd+zzu/WKz
         0FCAUc8o/yNZ7cBLfQ/qMDx/CGAsjlUCmGZ1IImq5v4rduvP6mbz+wGDIodz05PkqGsU
         F721iJB4Hj3Wwrx9uZdDIPDw7pNORZWq16cooy6nSmsCfWn1oL6CgxDwzFC1caKUZQ4g
         dVuhxPQsppRTCqZG8uCqiWU7XuLdzcmnlyD0+0KBkvn3g58AaZUKMD8bY8sbTDUFyX+c
         jsGynRHPnafC2NPmGqYrV2MkeeCN+kpMkBrf9PMjrYQDP/lVCwdVKOwYcp0Y87KoWwu2
         WlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0JPkFhehcwvc0TpggQe1HDDfhQRa/+ly2iG1DRkDwM=;
        b=NSBvmtm2AXv4Lr9cPvgxcU7KxtNHpyMDtW3FlqoylqhOmuaNOCBPQ7GcYlMCoCyv/R
         tfOMDV7/MGzPvsWkTshXJA5f4MIeWNBjIKE6gN0LaPhOtVjuj1WzkVYI7HAa4DUM9pm6
         9uH1hP2Tg7DW9ceJkS3O6ewh8gx75+oYi/1pHyRSh/ryNEq9xsamov+wh5f/lX+sDI/Q
         OyDpfPx/CODOB//CYOM4kkvLEWTPuAcbQI89+BTabTqr8wj98NQK/cVLl4XKB+cqy5x6
         nfsDVg0Gf0wLbtzBe4QT3jhohxG5s1YYkTcBK9aL7X5avSbySvrru+38qtVPx1WeqlRi
         l66A==
X-Gm-Message-State: AOAM533f7/jIhRpvaGm7lBw1Sj2UHcdVqpZ+036LhC4LBfMQavSVBRXb
        3lnNGQoVOtpwyzl++PBO+Ns8QezZYci5aJ02s9o=
X-Google-Smtp-Source: ABdhPJzL49D6MgpUPDnm/yjmbKIqETFPaIVNXoRjDJIsJTaNJ6IY4pXhTvaE99oyRY05R085R/ac3Fwm+adVcwCgkRg=
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr2991531ioc.99.1616602613495;
 Wed, 24 Mar 2021 09:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiS6wC4BBANaY62sV8hxreDBsHXTHr=NKFLrOLc6SOYEiztmg@mail.gmail.com>
 <05fc5ab7-58b4-ac63-be21-bff9d5fc0ad0@candelatech.com> <CAPiS6wB4Ls53ykD6iSUpBGN+sHauya1Mhu-7Q+Z_gzh=bAShAw@mail.gmail.com>
In-Reply-To: <CAPiS6wB4Ls53ykD6iSUpBGN+sHauya1Mhu-7Q+Z_gzh=bAShAw@mail.gmail.com>
From:   Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date:   Wed, 24 Mar 2021 18:16:42 +0200
Message-ID: <CAPiS6wD=NZe6+aT6wc_s94KVfFRVK_3b+zM_RUR7q6uWe-Wgpw@mail.gmail.com>
Subject: Re: Intel AX210 does not work on 5.11
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org, luciano.coelho@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 24, 2021 at 3:46 PM Paulius Zaleckas
<paulius.zaleckas@gmail.com> wrote:
>
> On Wed, Mar 24, 2021 at 2:24 PM Ben Greear <greearb@candelatech.com> wrote:
> >
> > On 3/24/21 5:21 AM, Paulius Zaleckas wrote:
> > > It was working on 5.10.16:
> > > [    4.274856] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> > > [    4.279014] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> > > supported by driver
> > > [    4.279031] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> > > Version: 93.8.63.28
> > > [    4.279401] iwlwifi 0000:3c:00.0: loaded firmware version
> > > 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> > > [    4.456228] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> > > 160MHz, REV=0x420
> > > [    4.607524] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > > [    4.673134] iwlwifi 0000:3c:00.0: base HW address: d8:f8:83:d9:35:87
> > > [    6.055731] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > > [    6.288461] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> > > [   72.546602] iwlwifi 0000:3c:00.0 wlan0: disabling HT/VHT/HE as
> > > WMM/QoS is not supported by the AP
> > >
> > > And fails to start on 5.11.8:
> > > [    3.882744] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> > > [    3.937708] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> > > supported by driver
> > > [    3.937720] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> > > Version: 93.8.63.28
> > > [    3.937891] iwlwifi 0000:3c:00.0: loaded firmware version
> > > 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> > > [    4.341262] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> > > 160MHz, REV=0x420
> > > [    4.486405] iwlwifi 0000:3c:00.0: loaded PNVM version 0x324cd670
> > > [    4.588212] iwlwifi 0000:3c:00.0: Timeout waiting for PNVM load!
> > > [    4.588213] iwlwifi 0000:3c:00.0: Failed to start RT ucode: -110
> > > [    4.588215] iwlwifi 0000:3c:00.0: iwl_trans_send_cmd bad state = 1
> > > [    4.796206] iwlwifi 0000:3c:00.0: firmware didn't ACK the reset -
> > > continue anyway
> > > [    4.808321] iwlwifi 0000:3c:00.0: Failed to run INIT ucode: -110
> > >
> > > Please add me to Cc as I am not on the list.
> > >
> >
> > You probably need to get latest firmware from https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git
> > and splat the intel related firmware into /lib/firmware/
>
> Did that, but still the same issue...

Removing /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm fixed this issue.
