Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D76361E02
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhDPKfe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbhDPKf2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 06:35:28 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A4C061574
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 03:35:02 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso20570209otv.6
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo0dgl6n3YVpYu69S3Ie9W2PG/lo6dYAG+rFL0p8Xb4=;
        b=YTXRUfosijR9NjIl4KcpxO5vGp+AHx42OC1FOv9EysvIQOVgSlsZrO5mulZsxuSEZQ
         N1d6rNuA55wZ3wlfQmxgkRvF1hfDw2cpY48edyKEczd5CoTdBP9pf1L0CYZ38LiYIXD+
         W7S2A/JvZnDdCd7uEBNaC1AK8ZD/JoeFIAa9ixOdiAlYIforpgfrzkl2mcrO4b1pONfo
         /ArLdAwbZNIlRxA3EyYMG3kwy549b959CnLbF4kCnJECD/+LOcmZGmnq7QU8KRg+p9u2
         pCpn9msKC8f57TNT7VUUN01eDXp7Jyotoaik308dYRpWVqEbl5XMMYhiE+arkcf/21Gf
         MTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo0dgl6n3YVpYu69S3Ie9W2PG/lo6dYAG+rFL0p8Xb4=;
        b=Jnud6frvfChcaGkn/rJxRg7lamuKms99peXKxzrehsfdwOvReOIAGinFwCkWg7++PU
         a/wIsqLrs4VpRETweL+/pw7g3ptusQH4b3i8DXlNT/dSps8IO0NWTRBhPdB+hr5crd/Z
         rGBqWeOBDdKFCdBrrtuk8C0NSbqcEloUTtbwwyKkB45dgXChl4ybb49hRZzsMkhXzC61
         QUO+WJyxOoOykXaoK9YOb/+Pis6GcywIxDIDFuhho6RjaV74by4jGLEz0SKSFhl+0aAp
         Qkjae+hyCDRaKuDOuwDKmn1NRxCeDarRZJu5KW9SCceWv2dn40vnZUVOsbsdmOn5ouU4
         xPLw==
X-Gm-Message-State: AOAM533+0caZkCYuMGAmKZ6dM5RQ06NYLDbHh5/DwHuXEE58NUf2qvQH
        K39FuY6I7wmTrg9IjRyj7UoYN/4VKW+sddxG/VTMDQi5FG8=
X-Google-Smtp-Source: ABdhPJz0CFxT8VNlUYR34agRrenLJJ3a/BHfo3vqlCEJDW5Iad4/0Q453lZ90Bpm43Tglm3BJAI4+XItSG3lz7SrJMU=
X-Received: by 2002:a05:6830:802:: with SMTP id r2mr3042361ots.110.1618569301793;
 Fri, 16 Apr 2021 03:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <fae3f300-8e04-d9ec-8e22-a401aaa6f70a@st.ovgu.de>
In-Reply-To: <fae3f300-8e04-d9ec-8e22-a401aaa6f70a@st.ovgu.de>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Fri, 16 Apr 2021 13:34:50 +0300
Message-ID: <CAHNKnsSrQvGwhm6q3xjw41xMx7LaYzg0eaOZ2OVaDMdpUfO9gg@mail.gmail.com>
Subject: Re: Adding a fifth edca tx queue
To:     Johannes Behrens <johannes.behrens@st.ovgu.de>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

On Thu, Apr 15, 2021 at 5:19 PM Johannes Behrens
<johannes.behrens@st.ovgu.de> wrote:
> currently I am planning to implement a fifth edca tx-queue in the kernel
> for research purposes for special requirements on the tactile internet.
>
> Now I am facing the challenge that I cannot find any actual hardware on
> which I can implement another queue. Do you have any tips for me there?
>
> I have already dug through the code of some drivers of Linux, but
> usually it fails because of the firmware of the WIFI chipsets, which
> does not support this.

Did you look at the ath9k driver for Atheros AR9xxx chipsets? These
chips support only .11a/b/g/n, but they are still a great choice for
MAC research due to the possibility to reprogram many aspects of
channel access.

-- 
Sergey
