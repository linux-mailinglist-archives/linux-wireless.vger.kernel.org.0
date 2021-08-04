Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340FD3E0A84
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhHDWqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhHDWqX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 18:46:23 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C5C0613D5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 15:46:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so3209728otq.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvjJXIAyDtPL/Ndk/Btj800bsnjEboaOCHdw/tjENlE=;
        b=NvgNV1BmOyqa+ONMf/ndrJq3FcJ7c5LtBMHtnvF0HO93XBKfRK4RrR34Cc/uKakySh
         m7ZcUjTOAWSAAigDKMZlCvF7srO4sHeRrHLUrLoJxffYgyd+VQBKS40QzRAd432FN48J
         RSWCYqHIZn95SJUMdLqpkiUnfZs96ZUZQ7ggQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvjJXIAyDtPL/Ndk/Btj800bsnjEboaOCHdw/tjENlE=;
        b=Rov9ejBhSpKGAlvUWg22ywOiuUDM9Y9mF2Jrdp4WK4s+2n0RHuYOAclQ07gmy1RYIy
         BConA23glf36mLY2cD0Uz+1xS8oVIjDczMtNWKoUHMcQ7/zUFA0tepGwIMDTUl9UjVIs
         TW2GtPbzg4qkeUTLujU57pMm+vG7tVCqbMNFKCgTiD1tNen34NCsZYNxR2G+uzI2CExn
         5gA65aaIQ1T9Xpn+o4FhD8lzPy1Z9KmXlyNs3LZg1sGWa+KN7jWZUXeexXnugACkuf+h
         J5tajix7sM1wCORz7vEoK6rMfSEBL3IsYQvMbpf1WCUpkjHB01PKEdsB8VRzGgmCrTwZ
         s42A==
X-Gm-Message-State: AOAM532//2iFetFEmmDRIK751JECG9Q6FN9it5PDt787lohelQSFWIAa
        zat1hEcJ1/QMvw6niENoshoM2iAenA3UIQ==
X-Google-Smtp-Source: ABdhPJyfEOJtCr/ndUdhREDuxNpYkoIQd4zR+7FPlmdJCbYKlUCD+wGCh7UyVZuyZehoQbwq1yAdOw==
X-Received: by 2002:a9d:6d16:: with SMTP id o22mr1402460otp.336.1628117168615;
        Wed, 04 Aug 2021 15:46:08 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id p8sm394988otk.22.2021.08.04.15.46.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 15:46:06 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q6so4771496oiw.7
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 15:46:06 -0700 (PDT)
X-Received: by 2002:aca:110d:: with SMTP id 13mr7258895oir.77.1628117166068;
 Wed, 04 Aug 2021 15:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210804020305.29812-1-islituo@gmail.com>
In-Reply-To: <20210804020305.29812-1-islituo@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 4 Aug 2021 15:45:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPxMBeVwb+708Z5ZwKsNmBhcAE1AwbbRvsQMDiNaGJXQQ@mail.gmail.com>
Message-ID: <CA+ASDXPxMBeVwb+708Z5ZwKsNmBhcAE1AwbbRvsQMDiNaGJXQQ@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: drop redundant null-pointer check in mwifiex_dnld_cmd_to_fw()
To:     Tuo Li <islituo@gmail.com>
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 3, 2021 at 7:03 PM Tuo Li <islituo@gmail.com> wrote:
>
> There is no case in which the variable cmd_node->cmd_skb has no ->data,
> and thus the variable host_cmd is guaranteed to be not NULL. Therefore,
> the null-pointer check is redundant and can be dropped.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>

Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
