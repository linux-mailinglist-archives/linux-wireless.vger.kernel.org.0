Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673DC2193FC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2020 01:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGHXDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jul 2020 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHXDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jul 2020 19:03:47 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE88C061A0B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2020 16:03:46 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p7so130751qvl.4
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2020 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=To0+Smg43e/9CvTBABgED+cYpEQSStMGVMvi2i5fPzg=;
        b=RNAYnBEgE2TiqdyUeojImy8gOwbVIOFQQSEjYG9KHdt061+dFG2b6jIUUBiUdQPmWP
         deilgIVor23VxDCpWJSMXIwqiBgoH2437YnkMzPREaSjNBTwA6LUpqctj7unzQTUdblH
         y4ikK2xUtF+NbXQGkN8KYqXc1LKB/rvSP17sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=To0+Smg43e/9CvTBABgED+cYpEQSStMGVMvi2i5fPzg=;
        b=Ybj9xCkVn8vNtpp82sL/OmAOQsmDK0e3xvZlAOA1s/LP5IaUUpg+OgvSYregt5ojwp
         T6tid7PhjIUQXTnmgQ2cvISegahnWrFHkCnT7XrIQ/vlZJFDFXomFjmEvN5cOBXCQOHN
         5oqsus2UuSCWs+7z3TUcgJoVU9oPKQ6ALjXT7R7LTSAUFUivbK1/D0cc14fEBtbDcBBo
         haR4nw+lNeFF2Baf3AgShJ0h4EBu4dsXwJbh86io94bTMkIj3VfQUbd3dP44+G89cyWZ
         0Whjc1htqSBw/sJ40RZQ0uLroP+GylPJ0uOjn3r0KG4AuKN3GwTB/nFz0RljZbiTUSE3
         WkjA==
X-Gm-Message-State: AOAM530Alv7qGhs6wENnUaa9VauPe0ieVg7E7BfqC/HN5cHoKWtJEhxP
        LK/zY0KCpwGFI4AK1dKaL6wTcAxt2nc=
X-Google-Smtp-Source: ABdhPJyVhQJjsxJUnC9iQ2lLmhZhAsjUksJlyXFy6cvlr7SCnVvTvRS9CqZ+sib80wKI+zRQNVwn0Q==
X-Received: by 2002:a0c:fdc5:: with SMTP id g5mr12429574qvs.189.1594249425129;
        Wed, 08 Jul 2020 16:03:45 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id x36sm1327324qtb.78.2020.07.08.16.03.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 16:03:42 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id e11so84932qkm.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2020 16:03:42 -0700 (PDT)
X-Received: by 2002:a37:b6c6:: with SMTP id g189mr44795113qkf.206.1594249421577;
 Wed, 08 Jul 2020 16:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101712.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
In-Reply-To: <20200707101712.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 8 Jul 2020 16:03:28 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMXtwdV4BNL1GSj8DY-3z8-dZ=1hP8Xv_R-AjKvJs0NMw@mail.gmail.com>
Message-ID: <CA+ASDXMXtwdV4BNL1GSj8DY-3z8-dZ=1hP8Xv_R-AjKvJs0NMw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Keep track of which interrupts fired, don't poll them
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        saiprakash.ranjan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 7, 2020 at 10:18 AM Douglas Anderson <dianders@chromium.org> wrote:
> diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
> index a440aaf74aa4..666ce384a1d8 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.h
> +++ b/drivers/net/wireless/ath/ath10k/ce.h
...
> @@ -376,12 +377,9 @@ static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
>  {
>         struct ath10k_ce *ce = ath10k_ce_priv(ar);
>
> -       if (!ar->hw_params.per_ce_irq)

If I'm reading correctly, you're removing the only remaining use of
'per_ce_irq'. Should we kill the field entirely? Or perhaps we should
leave some kind of WARN_ON() (BUG_ON()?) if this function is called
erroneously with per_ce_irq==true? But I suppose this driver is full
of landmines if the CE API is used incorrectly.

> -               return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
> -                       ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
> -                       CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
> -       else
> -               return ath10k_ce_gen_interrupt_summary(ar);
> +       return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
> +               ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
> +               CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
>  }
>
>  /* Host software's Copy Engine configuration. */

> diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
> index a3dd06f6ac62..5095d1893681 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.h
> +++ b/drivers/net/wireless/ath/ath10k/snoc.h
> @@ -78,6 +78,7 @@ struct ath10k_snoc {
>         unsigned long flags;
>         bool xo_cal_supported;
>         u32 xo_cal_data;
> +       DECLARE_BITMAP(pending_ce_irqs, CE_COUNT_MAX);

Do you need to clear this map if the interface goes down or if there's
a firmware crash? Right now, I don't think there's a guarantee that
we'll run through a NAPI poll in those cases, which is the only place
you clear the map, and if the hardware/firmware has been reset, the
state map is probably not valid.

Otherwise, looks OK to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
