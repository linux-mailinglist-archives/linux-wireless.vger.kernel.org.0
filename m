Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9258D43E9C1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhJ1UlH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhJ1Ukt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 16:40:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789EC061767
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 13:38:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j2so16198419lfg.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m748Ylk/42jFnseN0nSePnrxsWBhg1Gxw5o64vc/HiQ=;
        b=I8Tjpg0p7tNAGRqmM/T5wuG1h38R4L64v7g8CXycP8m4fhUnMXcgPfJyFiUedEBix+
         MHkp0SOBbN+gV9ZQnWjs0VBMdxLz6E0uuVBxO+FyueD6AFK7aGEsZjOvadVrD0/ncZgs
         Kd8ScIOmQIuNPD71x5DGby3GxOiqJCXOibM+c+By74IMcK3HcVS3SgZT0oJZCeMFFtX2
         CjtIXwEfHh7DQB6gLtypasmsDW7/AqtgTK/Pd2LK6ADkMMvQUdiKmahcS1yKHWPog+Yk
         4yyccxwKt6qp/0FNEk/M18MpND6NZJ8rJ1JXGgeke3ZBRU4WN9EO444VCXYbiHiGtjmu
         VqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m748Ylk/42jFnseN0nSePnrxsWBhg1Gxw5o64vc/HiQ=;
        b=kqwcyI6AIVECWGyRHkmbWUzQJPULP+Hia6iRDex9KpsKY3+EvIQ7kUR6As1cbnfvP/
         FK1TtqH8Pn/uJloolbvomcTjZ2IsY6tt0HAdWzGm7YqeoDlcby2Ycal3l4stnmB7PmNH
         9uEsBVHaeeBhDDLrMG+rYXmrESN+WCKOL5mIqOsTIk59axkLMZn5AtvLgDT1iXKSW2VM
         o9G5nA60R5JGhu+V0q4U51CnG6p1t24Y8p1O41ypAhUt7zSSaicgMPxmWN+qNtG4kwUV
         BBaFNaBgjGJD2ntcY+7F4AL3/IzqrLpbk6WPUuYiyAkzsdYWMMdR3MeNT+nW3oo6j9RE
         U62Q==
X-Gm-Message-State: AOAM530254oBHFaUCK9uDFBtue/6t13vArG61H7c5icv26/agJHKy08i
        y2V1A3ykhkFYu7bIPF5HqHvM7Mb/MmMc7S/2kcuz6OZSO9A=
X-Google-Smtp-Source: ABdhPJzzflckRfuz9r9492nVKVHj+QpvesCXckwIrvUCehouHlIU9rApdzCEgqVktJkljAhSMUvprPVEuW7Pi1Hbu5U=
X-Received: by 2002:ac2:4e09:: with SMTP id e9mr6367525lfr.308.1635453494899;
 Thu, 28 Oct 2021 13:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211016234609.1568317-1-chunkeey@gmail.com> <87ee855xwa.fsf@codeaurora.org>
 <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com> <875yth5pt3.fsf@codeaurora.org>
 <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com> <CA+_ehUxFDUE6BU3TbngKOA-VKCBkTnpOv7ibTjtpur37KrQ4Jw@mail.gmail.com>
 <e6936f55-6ca7-209c-8c3f-5eeae879c9dc@gmail.com>
In-Reply-To: <e6936f55-6ca7-209c-8c3f-5eeae879c9dc@gmail.com>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Thu, 28 Oct 2021 22:38:04 +0200
Message-ID: <CA+_ehUymo1nQ8bzkBNKQttWgFpWz7vNs8-jj2Wo+3hkEXHYx4w@mail.gmail.com>
Subject: Re: new "[1/2] ath10k: Try to get mac-address from dts"
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 28/10/2021 20:57, Ansuel Smith wrote:
> >>
> >> The "[1/2] ath10k: Try to get mac-address from dts" patch
> >> will need a respin, so it can apply cleanly.
> >>
> >> Is Anyone interested? If not, I can take a shot at it on Saturday.
> >>
> >
> > A refreshed patch is applied to atk10k-ct repo so it would be good to
> > have the same patch on normal ath10k. Many router would benefit
> > from that.
>
> Found it!
>
> https://github.com/greearb/ath10k-ct/commit/e6a7d5b5b834737cd12e357b5efdc2e42d923bf6.patch
>
> Hmm, Author is now "Ben" and the whole commit message is gone.
> Now, adding the commit message back from your original patch
> is not a problem, but the missing "Signed-off-by" from him and
> you might be.
> ...
>

Let's use the patch in ath10k. Seems cleaner and ready to merge.
(probe_defer to handle)
https://github.com/openwrt/openwrt/blob/master/package/kernel/mac80211/patches/ath10k/984-ath10k-Try-to-get-mac-address-from-dts.patch

> But then, do we need it? Because there might be the option to extend
> device_get_mac_address() instead?! ...
>

That is also my concern... It would be good to add support for nvmem in
the device_get_mac_address().

> >> (There's the tiny question of that device_get_mac_address() which
> >> ath10k currently uses. It looks a lot like of_get_mac_address() too!
> >> but with extra ACPI (through FWNODE-which also includes OF), but
> >> without NVMEM.)
> >>
> >> Cheers,
> >> Christian
> >
> > About this I never manage to understand the priority... Should ACPI
> > variant have priority and fallback to the OF api or the OF api should
> > overwrite any mac if a nvmem cell is found?
>
> Hmm, from what I know the device_/fwnode_*() functions are just wrappers
> for either ACPI (on systems with ACPI - x86 and ARM) or OF (on systems with
> Device-tree) functions... (There is also "software nodes", I think these are
> the lookupd stuff that came up recently with APU2 + MX100)
>
> This confused me too. But I might be able to show this in the context of
> ath10k-ct's current ath10k_core_probe_fw() and this threads new subject:
>
> <https://github.com/greearb/ath10k-ct/blob/e6a7d5b5b834737cd12e357b5efdc2e42d923bf6/ath10k-5.15/core.c#L4044>
> copied in here for a better reading experience:
> |
> |device_get_mac_address(ar->dev, ar->mac_addr, sizeof(ar->mac_addr));
> |
> |/* Try to get mac address from device node (from nvmem cell) */
> |of_get_mac_address(ar->dev->of_node, ar->mac_addr);
> |
>
> The device_get_mac_address() will on OF platforms essentially check and
> process the same "mac-address", "local-mac-address" and "address" OF
> properties of the same device-tree node as the following of_get_mac_address()
> will do. There's no priority.
>

The question was with the strange case of both device_get_mac_address and
and of_get_mac_addressproviding a mac what should be taken? In the current
implementation of_get_mac_address sets the mac and has priority.

> I think now, that instead of adding of_get_mac_address() into ath10k,
> the time might be better spent asking what's the goal for device_get_mac_address() is.
> Is device_get_mac_address() poised to usurp of_get_mac_address()? And if it
> is: Should it be extended to get that "mac-address in nvmem-cell" as well?
> Because then we don't really need to touch ath10k at all (well, maybe except
> for -EPROBE_DEFER handling).
>

To me it seems device_get_mac_address is used as it has ACPI support and
fwnode seems a better implementation of the OF api.

Anyway yes i think the current patch should handle the error as nvmem can
return probe_defer error.

> Cheers,
> Christian
