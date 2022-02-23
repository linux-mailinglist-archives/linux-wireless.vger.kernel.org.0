Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185874C11D6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 12:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiBWLsu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 06:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiBWLss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 06:48:48 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E11506E9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 03:48:20 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i1so149886ila.7
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 03:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nTmI/+28E4j0O3bjZQM1rXqMEHAW1ITZXntraScJE0=;
        b=miN/CakF4s7rMN2YWY9w8ZE8n1+0blY6GkSeQZ3lE6eupGx9XJcrlspGMCZZcOCCI4
         th3BijNkmbQUhievYm9Ye+fT1cBQduAToNQrSQyZ51Vm010iz2d1XbsdUzqVQWAb1fS6
         gcTViIElQfxGDXIJLWhxovASQLCAOCnkQaBR5E6kxz16+7/jjG4boOj/SjysaXxr8QxS
         okq7mBIZOx39RicxUPxWrDA+UYcCfs/b486YTBl61+nFiUCKeZc4X1sgYLbrLl4sQ/Il
         E5bVz3ICrHvgT2I7D3a7adVqIB9g1qJvFWxdZyfkmmENoAeYJ+eePfml3unkc7yDPjbm
         Ezuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nTmI/+28E4j0O3bjZQM1rXqMEHAW1ITZXntraScJE0=;
        b=5e6n+bUh5JzXS+2Qxoc1WfMtmkhPG1KNpa66/0QlpxTvvlQQTDxvZS/I1rNDyYfhJh
         VK6V6e2pWlQNnMz7E84RzI4AThHkteZXOd04Rc/915Vkb71LcjuG286uQE0mb2aBmcvu
         EN1QUq7csbGIn/dQVZ4brekwuJNrvcGWuKhU3kQ/7bOJ7MDF1PicS5TdBSqOdsoy2Gh7
         3OWnthi/8LCCOcu/QPzk3CsY3vFFRTNF3wjX3FsH3sNsB6PzR6/7OzqYadq6VQ0JhCLS
         haeYBtbg1P5Lx3CBje3x6XBIYV1O2hQLsnmzB80YAJlCk7k3NPM16X44+HfyCXkN7UTV
         maWw==
X-Gm-Message-State: AOAM5307gw2ll1C1TJHnOpCeZw5xy3PQC0rEzChVoCOtPHMra68Bd18l
        /7M1+VcgxCVNjlzZUTAeqoFbxfc47JLMsUppDgg=
X-Google-Smtp-Source: ABdhPJyWYThIa2FyL2PoxgRXYQaX16nylwKAWr1cPhhfZCros/JvuNYdTCFtHrpvvwHpdtVpflIJ1QVBp7wu4yBDlBo=
X-Received: by 2002:a92:c261:0:b0:2c2:70be:efc2 with SMTP id
 h1-20020a92c261000000b002c270beefc2mr4574473ild.46.1645616899849; Wed, 23 Feb
 2022 03:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20220221122638.7971-1-franciman12@gmail.com> <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
In-Reply-To: <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
From:   Francesco Magliocca <franciman12@gmail.com>
Date:   Wed, 23 Feb 2022 12:48:36 +0100
Message-ID: <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: fix pointer arithmetic error in trace call
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath10k@lists.infradead.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        rmanohar@qti.qualcomm.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, I picked (void*) to be conformant with the other examples in htt_rx.c
For example at line 1431:
>    rxd = HTT_RX_BUF_TO_RX_DESC(hw,
>                    (void *)msdu->data - hw->rx_desc_ops->rx_desc_size);

But for me it is ok. Maybe we should fix all the occurrences of this kind.

Greetings,
FM

Il giorno mar 22 feb 2022 alle ore 21:52 Jeff Johnson
<quic_jjohnson@quicinc.com> ha scritto:
>
> On 2/21/2022 4:26 AM, Francesco Magliocca wrote:
> > Reading through the commit history, it looks like
> > there is no special need why we must skip the first 4 bytes
> > in this trace call:
> >
> > trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),
> >                        hw->rx_desc_ops->rx_desc_size - sizeof(u32));
> >
> > found in the function ath10k_htt_rx_amsdu_pop in the file htt_rx.c
> >
> > i think the original author
> > (who is also the one who added rx_desc tracing capabilities
> > in a0883cf7e75a) just wanted to trace the rx_desc contents,
> > ignoring the fw_rx_desc_base info field
> > (which is the part being skipped over).
> > But the trace_ath10k_htt_rx_desc later added
> > don't care about skipping it, so it may be good
> > to uniform this call to the others in the file.
> > But this would change the output of the trace and
> > thus it may be a problem for tools that rely on it.
> > Therefore I propose until further discussion
> > to just keep it as it is and just fix the pointer arithmetic bug.
> >
> > Add missing void* cast to rx descriptor pointer in order to
> > properly skip the initial 4 bytes of the rx descriptor
> > when passing it to trace_ath10k_htt_rx_desc trace function.
> >
> > This fixes the pointer arithmetic error detected
> > by Dan Carpenter's static analysis tool.
> >
> > Fixes: 6bae9de622d3 ("ath10k: abstract htt_rx_desc structure")
> >
> > Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> >
> > Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
> > Link: https://lore.kernel.org/ath10k/20220201130900.GD22458@kili/
> > ---
> >   drivers/net/wireless/ath/ath10k/htt_rx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
> > index 9ad64ca84beb..e01efcd2ce06 100644
> > --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> > +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> > @@ -429,7 +429,7 @@ static int ath10k_htt_rx_amsdu_pop(struct ath10k_htt *htt,
> >                               RX_MSDU_END_INFO0_LAST_MSDU;
> >
> >               /* FIXME: why are we skipping the first part of the rx_desc? */
> > -             trace_ath10k_htt_rx_desc(ar, rx_desc + sizeof(u32),
> > +             trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),
>
> since void pointer arithmetic is undefined in C99 would it be "better"
> to cast as u8 *? I realize that gcc has an extension to support this
> [1], but this usage will cause a warning when -Wpointer-arith is used.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
