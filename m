Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0EE32FD19
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhCFU1n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Mar 2021 15:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhCFU1k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Mar 2021 15:27:40 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06442C06175F
        for <linux-wireless@vger.kernel.org>; Sat,  6 Mar 2021 12:27:40 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 97so5326867otf.13
        for <linux-wireless@vger.kernel.org>; Sat, 06 Mar 2021 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=e+Ere75oCQWSmOpz788sW6R8AeYpQOZY+AlLnzPu4nA=;
        b=bHiG1PFbENrTJVDVaHEaQuHfTjv1dRM7IAWNveS0CXsm+sgC/S2oWK09PHS0f81eB4
         6hYdFYtYnDaCLTYFcfHudB+xPGwqtdmfasK81Yp99CgjcpcpgwD4i0phOAl0gb2I6PDI
         vD56JUFiZC3h8x2/RmxUw1d93TMHJyUg8BCzGYaMxKZi2QHcO5fIoVnhWqyOk57t2uRf
         n8fmtOI0K0VWA1md6QgNjXIqUjA8+CnGAJMvy9fmmpdi7n6b8vaFnFydMXk70gWq71pl
         TldQLkfwZdPeyHCrgFi43L/tkEGla9A8akQ8Ea5F/hNmPkpDQdWBUUsTFoFWqeeQP6ph
         2pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=e+Ere75oCQWSmOpz788sW6R8AeYpQOZY+AlLnzPu4nA=;
        b=ar/can7GqYFHJLeQJVWVAxx5sMClm6b9qfWqaa8FRRPKuuKNyCHwayfw9chyU5l5R/
         BFXP2quAVAzzOjHYZIqsQONvC32Fn220zRTMzBA6xtfEzT+QT1oVM4806gSwbQpqpjtq
         TKUV69Vfo9ynWFDR/WdBQ09uLSJVQFVo5JLbNpQc99926nZDJ2UuaCw5ZdufA5FGyEl7
         cBYYEQG2tFMRQdS1zPOGYGEDv7b3EwIeRT3rgBraJSO0UEKCm1J3x1C17ZFYwylKbG6u
         jku0uDVrNRSFqWEuN5qsw892rqaUCVUM/0k/TzoPLHJSh5JDrC8SviuR9ViPBPAj1YsB
         6G4A==
X-Gm-Message-State: AOAM533nVhQ2NdmgmFA0SkPEEtYxTMKWNW5i46Pj9YuAObF8KPfNEkst
        kewQXq+Y1Yx1IM1HdhyXLY2Nwg==
X-Google-Smtp-Source: ABdhPJyVdqrQqI1rCj7xVOLaAzCPfpgEQigRntSoNrMPuYhqNPFkbrb2axkAOhPmmr++12qr3k6eLw==
X-Received: by 2002:a05:6830:15:: with SMTP id c21mr4570241otp.20.1615062459173;
        Sat, 06 Mar 2021 12:27:39 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w1sm1401471oop.1.2021.03.06.12.27.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 06 Mar 2021 12:27:38 -0800 (PST)
Date:   Sat, 6 Mar 2021 12:27:09 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Sedat Dilek <sedat.dilek@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iwlwifi: fix DVM build regression in 5.12-rc
In-Reply-To: <CA+icZUVedsZzJ7qk4fgSZV37M6YUjnP=sfWFK9V9f0y0KpQ4tA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2103061224040.1637@eggly.anvils>
References: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils> <CA+icZUVedsZzJ7qk4fgSZV37M6YUjnP=sfWFK9V9f0y0KpQ4tA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 6 Mar 2021, Sedat Dilek wrote:
> On Sat, Mar 6, 2021 at 8:48 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > There is no iwl_so_trans_cfg if CONFIG_IWLDVM but not CONFIG_IWLMVM:
> > move the CONFIG_IWLMVM guard up before the problematic SnJ workaround
> > to fix the build breakage.
> >
> > Fixes: 930be4e76f26 ("iwlwifi: add support for SnJ with Jf devices")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> See "iwlwifi: pcie: fix iwl_so_trans_cfg link error when CONFIG_IWLMVM
> is disabled" in [1].
> 
> - Sedat -
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=62541e266703549550e77fd46138422dbdc881f1

Thanks for looking out that and the other one, Sedat: I swear I checked
linux-next before sending, but my check seems to have been... defective.

Hugh
