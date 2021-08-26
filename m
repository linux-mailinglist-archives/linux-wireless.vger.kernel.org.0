Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0253F86E8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 14:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbhHZMC3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242434AbhHZMC3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 08:02:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B48C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 05:01:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y34so6259602lfa.8
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxiV7ERqDs1q2vy53IAICS71yjit7QHURfhHYR5Qkmc=;
        b=kYcF+L37cZeqiUKaYvw7RXwE+AkjBgz4yVfL180iQEVlrVP/d4WUwsD9R1MPeknA5w
         haQVebhjKt+6J7NiL//7M4BnN0mAlheDZAYQ88qjZ0Gj8QhNLdA0pzqQs8yRp/8FTE6x
         h7WulZhGu4bJjHi5y2GgmCMEu4c3TlqvwydMpqAI4qpTE6V+cTybcclb8TcfQSR30g3I
         ggrKAon83LPO+UA3xAF5b0KKb2vE5c2S5/rM/WHP8SRX+jOBdNtJabJWPO6z0l4hauKl
         mCW4JXuVzYVyCkeEufBXA95OymbYuZjSZgwgD3+q+JEc9fh0nBtHP4HenXS5w/I0TTXB
         Bz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxiV7ERqDs1q2vy53IAICS71yjit7QHURfhHYR5Qkmc=;
        b=Z11qx0v9j6DgZmaBc/iu6SdaOiS4nb6kVQj1gILVrRIcZp4cqACJpL0IYp9pt4MeKD
         GQTkBVsk8yvAt4GXMjqqz9840J4//PGUMH/cKT1CUWvDrs0vOIJtlf8RkPQbTXzTcQ/W
         ObdrpIJx5khLUblwY96p1M9HM6Tau/RwB4DGVoqmUUFToKDMCe8AqROwa/nPDr1qD4em
         0KCMzo5kvGq8C1Fyl6UyOL1pdojY4SRt2qA16BE/5LVwoDFl7EMmnZPuG1ipMu8xrGvP
         E9v4lnbVg2rQzg9zSAwtLpIy1Yozm7BnD/DpBb9nUYuDxehqXPxdrOBSgB398T8tS2Ty
         JFqw==
X-Gm-Message-State: AOAM533qywHxkP8ntSLTGfqa9MKZETZG0nIec1QRTbpovlslZYBTPfjf
        VU9CtWwBiC/3bvcUkFTTM+iwH5qq2YUV1AQ+Ue4=
X-Google-Smtp-Source: ABdhPJydRTHpuS5wvu11saeoFPugthubxBfE787bIrwBOiaTLZekqZIj1aXPsHJRo+6/Ud0+fBGxZeV3iJ1dW44MG3g=
X-Received: by 2002:a19:701a:: with SMTP id h26mr2379051lfc.443.1629979298649;
 Thu, 26 Aug 2021 05:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210818232627.2040121-1-festevam@denx.de>
In-Reply-To: <20210818232627.2040121-1-festevam@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Aug 2021 09:01:27 -0300
Message-ID: <CAOMZO5CJC0=iH4zzJGj0e82GexBN7suOehz8ajKK8bK3ZcMOSg@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: high latency fixes for beacon buffer
To:     Fabio Estevam <festevam@denx.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, erik.stromdahl@gmail.com,
        Peter Oh <peter.oh@eero.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Marek Vasut <marex@denx.de>, alagusankar@silex-india.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Kalle,

On Wed, Aug 18, 2021 at 8:27 PM Fabio Estevam <festevam@denx.de> wrote:
>
> From: Alagu Sankar <alagusankar@silex-india.com>
>
> Beacon buffer for high latency devices does not use DMA. other similar
> buffer allocation methods in the driver have already been modified for
> high latency path. Fix the beacon buffer allocation left out in the
> earlier high latency changes.
>
> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
> [fabio: adapt it to use ar->bus_param.dev_type ]
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v2:
> - Pick Alagu's patch:
> https://patchwork.kernel.org/project/ath10k/patch/20190417191503.18814-3-erik.stromdahl@gmail.com/

A gentle ping on this one.
