Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80D03ED8AA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhHPOHE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhHPOHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 10:07:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC6BC061764
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 07:06:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w20so34693876lfu.7
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=duFu4RVpjgk0FQCnAlrtbA/QUf60ak3bQY76vgudJb4=;
        b=usUDzemyap2HHtls9Iqu0hZopPFMu9PQQaRS9A26zl/vB0vnWST/VrGbfukTab/KGP
         gxCgZbFQzbxLJExCvl/Diuu/Y79Cu6igozKLmRyqdkj7IkhJhYxo7fljNEZ57C09cRAV
         hjfcyFc4EzV1vdCZ9bM0IW3XQYsaIudIjMRukq60TbBcC1U0PY7pnsMLlY4ZnzeDIyT6
         BSlARAsaNy4iy8CbLdU/R4jW5gsoLrzbWnR9KcuiNRyJdBsq1RenlZEYz+yKhNLXNzwY
         IAfX71aDt1RRhf/9DBUJI1v5dSuxIrhi11KO0I2VG78P30qjCqf41KhnrKlxj82dJ2Ct
         kVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=duFu4RVpjgk0FQCnAlrtbA/QUf60ak3bQY76vgudJb4=;
        b=COtS+Du0xrhkqw0DhKhKtSig8Df8jJk0460/4SBT9BeeBAdj9EHG3fbvp4ndTM5rS6
         taepBLcJEwUr9KwUDc7qqtDvdDY/FpGBAWV6ahmMdmfIRLhr4fwyzPasrzqwN+RZGM5r
         8M9Py39Y6ldHDdjRTvUpFRqN5UM81uHed36/MRWeMxxmr4mWerAS28A6UqloltzFXuFI
         9Gl0vQ+/k1MeLcLnysY5OIUVhLNLAPkJwP6vlbjJLOIbOZdZMbMhq6b1nRejDv1oIUnu
         QARJ4Bq3D9gdSXVFnmQBFg0CvSu0TymLqu6qxXp+3g1br1Zd0nuaodKZGgvo6wAQs2ge
         u77g==
X-Gm-Message-State: AOAM533aNbhk6N6dH+LqsfHePGBJJlFbLt3TaG1ZZS6Fr6cbFDfvHjga
        M7Iwq29ae8HhWcFy5cHgg0Y=
X-Google-Smtp-Source: ABdhPJzqgjBRmVVDRIi3Qi9iKrszUPFtXkVS7V1bngYnLJaBYH41xjl1MpKf6hi5KUq16/urxPpfHA==
X-Received: by 2002:ac2:5f0f:: with SMTP id 15mr12175211lfq.25.1629122789907;
        Mon, 16 Aug 2021 07:06:29 -0700 (PDT)
Received: from razdolb (37-145-210-192.broadband.corbina.ru. [37.145.210.192])
        by smtp.gmail.com with ESMTPSA id r83sm953879lff.299.2021.08.16.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 07:06:29 -0700 (PDT)
References: <20210628145412.26046-1-mike.rudenko@gmail.com>
 <20210801102503.C56E4C433F1@smtp.codeaurora.org>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH v2] brcmfmac: use separate firmware for 43430 revision 2
Date:   Mon, 16 Aug 2021 16:59:38 +0300
In-reply-to: <20210801102503.C56E4C433F1@smtp.codeaurora.org>
Message-ID: <87y291zdp7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi, Kalle!

On 2021-08-01 at 10:25 GMT, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Failed to apply to wireless-drivers-next, please rebase.
>
> Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c'
> error: Failed to merge in the changes.
> hint: Use 'git am --show-current-patch' to see the failed patch
> Applying: brcmfmac: use separate firmware for 43430 revision 2
> Using index info to reconstruct a base tree...
> M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> Patch failed at 0001 brcmfmac: use separate firmware for 43430 revision 2
>
> Patch set to Changes Requested.

I've posted a rebased v3 [1]. Anything else to do for this patch?

[1] https://lore.kernel.org/linux-wireless/20210804231308.576071-1-mike.rudenko@gmail.com/

--
Kind regards,
Mikhail
