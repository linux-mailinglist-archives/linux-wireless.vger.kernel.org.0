Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C543E8B8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJ1TA0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1TAZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 15:00:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E52C061570
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 11:57:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l2so12381551lji.6
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw+VDcV2kIndQWct5dm6yaq4vBp/HlTp8mqiaJHsvbg=;
        b=ICGC40s8o4poV1N11X+JXRkG65G5HiSh9m6kiy/MXKFbogpX5+e3xaC/U3w0X0hK7L
         RIVKJ36JuKUvhHSAzL1Ggg+RC5+nZt8Z4MoLAc07Xx1/hoRJwu5hCqjebga2Nj1K9jIn
         nDocNb4MoyZeW27InIJDB+jsoCQ+vcn5D+qmmkqVEiMyfVlciVnwqLADMq48u6QKC94y
         32jsEC8/XeBcJipMhANCYuHSvNNJJTIvGuO9YH7W7nln7iubrcMNrSqd8W0qQJ/9GPke
         099po2UkO61mWCI9Vqea2wr2vnVUL+hOa/KhmD2GB9zSoF45FbFna8FS118NL5+U7+eh
         Ez5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw+VDcV2kIndQWct5dm6yaq4vBp/HlTp8mqiaJHsvbg=;
        b=wtVd3z9vDzDIn2lt2OGZKVP7hkIH4uS5wXi9rJOxrckIpZfiRHDH7EYtsMmNE8z3M7
         IFFHBngX1H3SItB+BLetUpK5s17plnjgI4JPUF4A46E8Iup4nEIfrNGO5o42UMfAF544
         NPc48VRU2lF6H7vNqs5SoYucxpXEzWUs9IxRCgx2q3hA2L0XYDeiIWQlJugVopT0++oy
         cjOsMsKyN2FaLZlax4a8kLXUnW8gzTcruwIAe9YwfuYocjiL59z7/v8mBGr/cIUmSCKY
         /ZMYHJBMMbSHKowMcRl4oeydCdFWyqHf7/c6SvVwEMMJzNGEndPNPDMTK5wWOQVi8X9i
         z0ww==
X-Gm-Message-State: AOAM533c2P4dXXwJmqap2LAudLSH9y7Zz9O6FNUH+JLfOp7CQFQmMLbr
        aEp+4nsbseeUAzC92ASf/gN/lc2Fn2e6+w2tnJFagHIK
X-Google-Smtp-Source: ABdhPJy6w9QiUN2QnFSh27vBZFYIzNqbuYhYoH0/0aT2+EGXnwahFIOa+UM5Jx47XpDOwgcwu6QFyH5jRpBJh9Juuo8=
X-Received: by 2002:a2e:9b81:: with SMTP id z1mr6577518lji.518.1635447476629;
 Thu, 28 Oct 2021 11:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211016234609.1568317-1-chunkeey@gmail.com> <87ee855xwa.fsf@codeaurora.org>
 <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com> <875yth5pt3.fsf@codeaurora.org>
 <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com>
In-Reply-To: <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Thu, 28 Oct 2021 20:57:45 +0200
Message-ID: <CA+_ehUxFDUE6BU3TbngKOA-VKCBkTnpOv7ibTjtpur37KrQ4Jw@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem subsystem
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 28/10/2021 13:52, Kalle Valo wrote:
>
> >>>>
> >>>> v1 -> v2:
> >>>>    - use %zu and %u in the format string for size_t
> >>>>             and u32 types (catched by the "kernel test robot").
> >>>>    - reworded commit message + successfully tested on QCA9880v2
> >>>>
> >>>> I placed the nvmem code in front of the current "file" method
> >>>> (firmware_request). Reason is that this makes it easier for me
> >>>> to test it. If needed it can be moved to a different place.
> >>>
> >>> Looks good to me. Before I apply this, I want to mention to that I have
> >>> had a long in my deferred queue related two patchsets:
> >>
> >>
> >>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-1-ansuelsmth@gmail.com/
> >>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-2-ansuelsmth@gmail.com/
> >>
> >> Oh ok, serves me right for not looking thoroughly googling this first.
> >> Alban Bedel and Ansuel's work made this nvmem all possible. And indeed,
> >> the second patch here looks eerie similar.
> >>
> >> Do you want to go with his two patches instead?
> >
> > I would prefer to take your patch.
>
> Ok.
>
> >> I'll change mine, so it just consists of the cal_mode for the older
> >> QCA9880v2,QCA9887 and add the -EPROBE_DEFER handling. This
> >> -EPROBE_DEFER only ever comes up with the Meraki gear. This is because
> >> Meraki likes putting the MACs-Values into SoC-connected AT24
> >> eeproms-chips. Everyone else just have them in a proper FLASH
> >> partition. Though, this's usually nothing more than adding the
> >> following line:
> >>
> >> if (ret == -EPROBER_DEFER)
> >>      return ret;
> >
> > So I'll drop this version and wait for v3?
>
> I guess that "waiting for v3" won't be necessary in this case.
> If @Ansuel doesn't voice any concerns, you might as well just
> apply v2.
>
> The "[1/2] ath10k: Try to get mac-address from dts" patch
> will need a respin, so it can apply cleanly.
>
> Is Anyone interested? If not, I can take a shot at it on Saturday.
>

A refreshed patch is applied to atk10k-ct repo so it would be good to
have the same patch on normal ath10k. Many router would benefit
from that.

> (There's the tiny question of that device_get_mac_address() which
> ath10k currently uses. It looks a lot like of_get_mac_address() too!
> but with extra ACPI (through FWNODE-which also includes OF), but
> without NVMEM.)
>
> Cheers,
> Christian

About this I never manage to understand the priority... Should ACPI
variant have priority and fallback to the OF api or the OF api should
overwrite any mac if a nvmem cell is found?
