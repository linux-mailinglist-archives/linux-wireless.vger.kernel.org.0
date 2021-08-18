Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD643F0CE7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhHRUop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbhHRUom (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 16:44:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB9C061764
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 13:44:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r9so7432644lfn.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReRbCCu0NU8RaS/JlVj2xJ16jur0TR6FOgfUXy9kMT8=;
        b=kHgHFIrN/AkFQjVOnO4YPNKDmkaGspaNUBCMzY0msP8ztHtG6lO1QOmF0BWTuW/DDd
         rCsJ7uzdbEWQvvfchSR9Iyqkz6ChERVfC2kM+iIUM0tKGAbllVb5gy4GFlqpSRmx3WlM
         CmaVPJ/xAUYPG/lHcVFFjdFynEvzKT/3XDNk64VIdw/Mmis2OVvDzbYTjD4kHBgP8USF
         ygH1DOw3CRci8FUZPqxgdlW/gHn5GBzsIQF1yTrNKr5kp6GuEWuPMjMtIuszrWFs955V
         LyVWV2i5enncbyXqyZiJhqBc59lNZqv5PiRrJxwyJqKNg6R0CrqT9bKloaYW0dHbPkrT
         KqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReRbCCu0NU8RaS/JlVj2xJ16jur0TR6FOgfUXy9kMT8=;
        b=muXMO933KlwBzcCd9MLfgAh9WmBZRzKf1IEeZcn9lpltjN47mC7OzCLLac2LDBchhx
         dOrVe090yQUHY1aB/PxDwQ88iGD6+C8pAQl1XwQokkpoUEWs/HrxUefIdTNTSfSbHHD3
         AOF+imWRmn6sahRn6+7MuTMm2UVdc/y0Moyt5cxkr2XrSOGh4TV8TWi+FGfRpgZrLyHD
         5mWS+8fQkw0HaN8FV/T6c0Td/L+vlQTCVvTRcqYuen01rr5YuX2RKjGq6DViiZ9jAnlV
         eDrezLWiyqLsCwndFQg8P4SzF1krLZpl/2YxZP1llo6aHub11hTblZHxYWmkXfPtNk5e
         z66g==
X-Gm-Message-State: AOAM532edoblbzEjCtcUeIIl5Z4gksP0DtTM1IvMtMBNf32IBE3ALVJ3
        9MeYFaUH+ud8IeRLUaPd/cGG1R7DG4ICRgN1As4=
X-Google-Smtp-Source: ABdhPJxvKi2zQU2opUFjrNrd9PiSQytgodqEWYK7C9DiGchwcwp1emNustuYq+DrpER9P34sni153g+POCphaBCki3E=
X-Received: by 2002:a05:6512:401a:: with SMTP id br26mr3380230lfb.539.1629319444959;
 Wed, 18 Aug 2021 13:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210818150943.1630199-1-festevam@denx.de> <17b5a29d098.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
 <369c1f89-df33-455b-773e-a2e0dbf582ff@eero.com>
In-Reply-To: <369c1f89-df33-455b-773e-a2e0dbf582ff@eero.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 17:43:53 -0300
Message-ID: <CAOMZO5DbZ11HE4un20tBkLbjGWcyUu8KpTV+gEtVf=rT2JyT+A@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Do not call dma_alloc_coherent() for SDIO and USB
To:     Peter Oh <peter.oh@eero.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, erik.stromdahl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Peter,

On Wed, Aug 18, 2021 at 2:35 PM Peter Oh <peter.oh@eero.com> wrote:
>
>
> >> Fix the problem by not calling dma_alloc_coherent() when the device
> >> is not DMA capable, such as SDIO and USB.
> >>
> ath10k calls dma_alloc_coherent multiple places including
> ath10k_htt_rx_alloc.
>
> Do SDIO and USB not use such data path function at all?

Good point! Maybe I am not just hitting these paths on my simple tests.

Kalle,

How should we handle this?

Thanks
