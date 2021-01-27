Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04F305E54
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 15:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhA0ObS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 09:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhA0ObH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 09:31:07 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E6C061574
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jan 2021 06:30:26 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 186so1188476vsz.13
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jan 2021 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0OciNgCIzSI2IY36uVRRwblVcbGfdple6Q4mhsom/w=;
        b=a4pBXI0XVAC/4j3m8gIClrjBFsO0ql8zs6gR5wcURRqaYPhmAjCgPxYxF8r9xrFTbE
         ffVnpnR+inv69JB6Rffd2Tgagex2byG9t5dsRb3gSzgiAHfQ/U7uIbq0mfElDBfQ8DLs
         8lTiwuz3zjoerRUHLSQx0oQMuduoN3elBv9Nq5TjEl8H8/J+k40WQlHSAk2A8dQbA/Xc
         VQbVASosByEdFZno39YUeod2MymSJ4w/JDbzwUAsD7q5MXS+Oce8f/B5zh7TaBucmGLA
         556gDhHKdPE/j5KfwsfhtbpBhqyz1wjpCOpW+DtTekIOJAPaiHmASRAbkCjhp/mem4Uz
         JgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0OciNgCIzSI2IY36uVRRwblVcbGfdple6Q4mhsom/w=;
        b=OxwvvYy6iFuYyE1fZxqufkXD6YG9nhTkJWRe9PjwI3vIGP6Sb+FrVLGAG0s5HKDzNK
         Q4g5DF2aYaT2MW8IKPgjFqCtvpcwuLByS0TfwyOQudP5xhCiWutUtekXCCfDzdYi6gna
         UIneMOn9yanZUm5mPJyR1C5X3dCTevAIJ5L4BocckLNhHjAdn7zhy2XHVeeHinppSsSw
         zI0e7e7iUo6KpZB81gchs5nxSv0VwhARflKZHUJHvoO9F31q/TjdcQj8UqbKdAZlo2AP
         f/+oF2IxZlkkg2GE5g4j6LORJ9uIPV/tQ8YOfHvCUVnHm75+Rse1QjRagBDXy7tH35fe
         l2pg==
X-Gm-Message-State: AOAM5307HpIhXmODn+byZL0mWuAUPz6hGekTOZWBoTOv4VzFNLfRfamM
        HSydX+IbduYc9OrgyMFxrmAW4pnoUVU=
X-Google-Smtp-Source: ABdhPJxTIuftSgmA8wj4P+mbgz6wkf0Ma5p1KoyftnvNUzmPe6jn4ydUcYJgVEa4zew5uQDPnKSKNg==
X-Received: by 2002:a67:6602:: with SMTP id a2mr7832270vsc.5.1611757826139;
        Wed, 27 Jan 2021 06:30:26 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id y2sm288167vkg.47.2021.01.27.06.29.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 06:29:54 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id b5so1223626vsh.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jan 2021 06:29:45 -0800 (PST)
X-Received: by 2002:a67:c10f:: with SMTP id d15mr8063009vsj.14.1611757784589;
 Wed, 27 Jan 2021 06:29:44 -0800 (PST)
MIME-Version: 1.0
References: <1611741189-45892-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611741189-45892-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 27 Jan 2021 09:29:08 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfERdgtzb4QGrWgCw4Y_t8kCvA5rjokA2YfrSn9qwmn-w@mail.gmail.com>
Message-ID: <CA+FuTSfERdgtzb4QGrWgCw4Y_t8kCvA5rjokA2YfrSn9qwmn-w@mail.gmail.com>
Subject: Re: [PATCH] rtlwifi: halbtc8723b2ant: Remove redundant code
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     pkshih@realtek.com, Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>, lee.jones@linaro.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 27, 2021 at 6:05 AM Abaci Team
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:
> 1876:11-13: WARNING: possible condition with no effect (if == else).
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>

Signed-off-by lines need to have a real name. See
Documentation/process/submitting-patches.rst

With that change

Acked-by: Willem de Bruijn <willemb@google.com>
