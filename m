Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426255AB1F5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiIBNqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiIBNpW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 09:45:22 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507FC12F542
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:21:24 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11f34610d4aso4586409fac.9
        for <linux-wireless@vger.kernel.org>; Fri, 02 Sep 2022 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MlPQ6RuyQwzcf964BU43ZE1DMT0sZsqlhs/qizrhu04=;
        b=z+IkFe7d/IeTbgkSgmjVb1Qv9BgoxcrrGhvsC4LsYAWYwc8waUmTtyW8PD2LhtfAAS
         EbvKnrT2PtjTQosdKdEVYkVfcr2HnYW/xN4QRc8WwzHnog3B/8ro4LBKpKUq1pFclorR
         FkwHghDFT5KKVFzAn13pNuOyGk9TGYsQpgJHZi4smX7DK+SNBCc8VeLDPLo65dOA1sf8
         w3ZzRRoquXYwysEp3cri2EdikMGgZGMndTb8BR6rS/sav8MhG6zKs4o4PEoHCN0YtNRz
         E/6mbGfcbuzg0739Wox+lokafBG6a0kR8nwVFFOoZD3G7o/GAhqgidaSgb/gAu0F/Ggu
         i11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MlPQ6RuyQwzcf964BU43ZE1DMT0sZsqlhs/qizrhu04=;
        b=rxhWCUGO4LViwcrYXayiMAHtUg7OwzaxxhKs2VCgWQypxvJ/jUjnmdr5KjUyTyxg9r
         5q1+1jEU9Lhq/OTkipMoN9pqpPYBLaMKs4UjmGFYadE6S8JrqBO9lk2ofR5/HcO2f8mQ
         CjrvcbkhozyE/Yjb/zPBJMUy3kNTZ236/7qDap1hHeC/QUT0KBH/ZABmJmzh7chE9UnV
         V/E9ilRPCUGQRg8YxAPuW9eXqu8ZU1h2FsxygrxD1ooE/XO9eCRsFaHFTVsLIoaSyjN/
         PY+I2vqyCaBFyiG6mkqyNpFEkhXUuSDBwY0ABbGRMxE4pgQGgDvpKgzhOohjmcZuJU3R
         j8uA==
X-Gm-Message-State: ACgBeo1d5M7G9SG0Byx7QbQb+a4Y8/E/A6FZX694W84XGXiENDmkEalZ
        IMjSFk6m0YMcV00EV66WtLQCVnWjJHMwkCHAvcQaDCjRCrApOg==
X-Google-Smtp-Source: AA6agR7IckvwEiaXtrETYANK2S0/xbjVTZDUh5ZiJkhvriahodKcVl5t1ETL7bWEmu9vxrbTlTq67j7lmaefw2FuB+s=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr2052975oae.33.1662124822012; Fri, 02
 Sep 2022 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
 <20220720135113.15755-2-quic_mpubbise@quicinc.com> <87czceaqng.fsf@kernel.org>
 <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com>
In-Reply-To: <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 2 Sep 2022 15:20:11 +0200
Message-ID: <CA+HBbNGEoSyfbs=FHtWyvBnG_jh9m=Q9KW=Pcfq+pDdHWEV4mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 2, 2022 at 3:18 PM Manikanta Pubbisetty
<quic_mpubbise@quicinc.com> wrote:
>
> On 9/2/2022 6:18 PM, Kalle Valo wrote:
> > Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> >
> >> Enable threaded NAPI on WCN6750. Unlike traditional NAPI poll which
> >> runs in softirq context and on the core which scheduled the NAPI,
> >> threaded NAPI makes use of kernel threads which are under direct
> >> control of the scheduler and helps in balancing the NAPI processing
> >> load across multiple CPUs thereby improving throughput.
> >>
> >> In the case of WCN6750, enabling threaded NAPI has improved
> >> 160 MHz RX throughput by nearly 400 Mbps. This should give similar
> >> gains for other ath11k devices as well, therefore enable threaded
> >> NAPI on all other devices.
> >>
> >> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> >>
> >> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> >> ---
> >>   drivers/net/wireless/ath/ath11k/ahb.c  | 1 +
> >>   drivers/net/wireless/ath/ath11k/pcic.c | 1 +
> >>   2 files changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> >> index d7d33d5cdfc5..e44e2f29a88f 100644
> >> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> >> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> >> @@ -314,6 +314,7 @@ static void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
> >>              struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
> >>
> >>              if (!irq_grp->napi_enabled) {
> >> +                    dev_set_threaded(&irq_grp->napi_ndev, true);
> >>                      napi_enable(&irq_grp->napi);
> >>                      irq_grp->napi_enabled = true;
> >>              }
> >> diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
> >> index cf12b98c480d..c703db19de51 100644
> >> --- a/drivers/net/wireless/ath/ath11k/pcic.c
> >> +++ b/drivers/net/wireless/ath/ath11k/pcic.c
> >> @@ -440,6 +440,7 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
> >>              struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
> >>
> >>              if (!irq_grp->napi_enabled) {
> >> +                    dev_set_threaded(&irq_grp->napi_ndev, true);
> >>                      napi_enable(&irq_grp->napi);
> >>                      irq_grp->napi_enabled = true;
> >>              }
> >
> > The commit log claims that this enabled _only_ on WCN6750 but aren't we
> > enabling it on all ath11k hardware, or am I missing something? I admit I
> > didn't check this very carefully.
> >
> > (reads the commit log one more time)
> >
> > Ah, in the last sentence you mention that it's enabled on all hardware.
> > That's quite easy to miss and the commit log is quite misleading, please
> > emphasise already in the title and the first sentence that this is for
> > all hardware.
>
> My Bad, yes you right. The patch was made initially only for WCN6750 and
> was enabled later for all devices.
>
> >
> > Also more testing would be nice. Enabling something like this with
> > testing only on one hardware family (WCN7850) can be risky. I always get
> > warm fuzzy feelings if a patch is tested with all three hardware
> > families we currently support:
> >
> > * IPQ8074 etc
> > * QCA6390 etc
> > * WCN7850
> >
>
> WCN7850 should be an ath12k device If I'm correct.
>
> Regardless of the chip family, even I feel that the tput changes like
> these should be tested on all the chipsets. Availability of the hardware
> and time are something which are stopping me in testing the changes on
> all supported targets.
>
> As I said, I had made the changes only to WCN6750 initially (using a
> hw_param). Can we take that approach for now and enable this for other
> targets only if required & upon thorough testing?

I can tell you that on IPQ8074 threaded NAPI really improves perfromance.

Regards,
Robert
>
> Thanks,
> Manikanta
>
> --
> ath11k mailing list
> ath11k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath11k



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
