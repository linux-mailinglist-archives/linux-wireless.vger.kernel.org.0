Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1129A5B17AF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIHIuc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiIHIuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 04:50:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E70C19C12
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 01:49:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso1672569pjd.4
        for <linux-wireless@vger.kernel.org>; Thu, 08 Sep 2022 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WLlwnXfj/irDDa0dEvEsLrqy7lTcKeXB93kP8oPhx0Y=;
        b=Fzulh4AUggvpIuY5gd8Yy5z75WYtgdhYx2GB+fJ8UUnN+VsjQS79jCIl+yWOssoZx3
         2wuuWlNx1kVlyKehAKpzdt2qMeOt+SQ/LsZtJ4MNZDQ8UjpuRyQvI5XqIvmCGDxCdCRI
         O1BfCfv/qbRfIvmlDV5LzqdDSJuP5yAjS2fi/QoqF9XtqVilWYOPHy8WD7HTH+7UbygW
         ik53HJ/nk4qXc9UojxLeJynSiKXGLopvEBuN5mIsRZkRlaRqClNNApj8pGC7eptaDMKG
         VXK+5G2h2cmsR8zrsutL2Vxzc5ITa0HBLGAGiKINNO0FDRLt5nrHk5bpWKFI+/33CoZb
         Cljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WLlwnXfj/irDDa0dEvEsLrqy7lTcKeXB93kP8oPhx0Y=;
        b=bjBtAKGcw8jqgT6F+SvrBM8w6WzCVYOtzMAaFZxE3XUKoi20Cw2yL4r2X+zpx1ruRc
         bDjuoa60pY+0lOeh/GNDyVFSNwfmbKP0tVNKszZX70iNnzcBF0ehDLsG7AwBD4IIEWci
         NYsRdd/nDhwAREQGMcj0FagpGy55zqRSQTmlcEUfBeC0R36jj3GQbSGP/jmkkvONf9WY
         WeFtNwv5rIZHKdeFdT75BexpA47KU30/plp9UelvbU9f7JnKjqPsSduW/FwBVKLcKlct
         6Or1X33tBG2J9yYl62hF2Wpv4iSvjNFUtOMWpr/dhXUmWj7hPBktQX+G1tgSkeLk9M2E
         3C2g==
X-Gm-Message-State: ACgBeo1gcpjYprZoXkUSjAXSNmEwkJu8cHDunKndegMPxcPJZ+2XpmHA
        46EFBQRnjHMnVNstcWttPh3rulemN4ACs6UWG6M5HA==
X-Google-Smtp-Source: AA6agR4Q0sktHrbxxfNqcuOlS6HqWn4EJn3dPjeUjSGRc4/W0TU5jBSJsx6N55zJ09VVfRT/YpdRaoKWRe/JhIN/NlY=
X-Received: by 2002:a17:90b:4a8e:b0:1fe:1df3:bb11 with SMTP id
 lp14-20020a17090b4a8e00b001fe1df3bb11mr2987266pjb.22.1662626981574; Thu, 08
 Sep 2022 01:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
 <20220720135113.15755-2-quic_mpubbise@quicinc.com> <87czceaqng.fsf@kernel.org>
 <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com> <CA+HBbNGEoSyfbs=FHtWyvBnG_jh9m=Q9KW=Pcfq+pDdHWEV4mw@mail.gmail.com>
 <7615c815-ca2e-c6f1-b627-6e10f1272442@quicinc.com> <CA+HBbNEm9GhYcXQ9gXEb=U4x=BZTDp4UBqF8eNH1N0uCBLdadQ@mail.gmail.com>
 <5c07bcd5-574c-b13b-44c2-ef8ed9f23cf0@quicinc.com> <878rmucqhu.fsf@kernel.org>
In-Reply-To: <878rmucqhu.fsf@kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 8 Sep 2022 10:49:30 +0200
Message-ID: <CA+HBbNEAgMPKJFrAYGUT1x-XAX81tTNj4W5xgW-bYSm5j_r_4w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
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

On Thu, Sep 8, 2022 at 8:46 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>
> > On 9/2/2022 7:16 PM, Robert Marko wrote:
> >> On Fri, Sep 2, 2022 at 3:42 PM Manikanta Pubbisetty
> >> <quic_mpubbise@quicinc.com> wrote:
> >>>
> >>> On 9/2/2022 6:50 PM, Robert Marko wrote:
> >>>> On Fri, Sep 2, 2022 at 3:18 PM Manikanta Pubbisetty
> >>>> <quic_mpubbise@quicinc.com> wrote:
> >>>>>
> >>>>> Regardless of the chip family, even I feel that the tput changes like
> >>>>> these should be tested on all the chipsets. Availability of the hardware
> >>>>> and time are something which are stopping me in testing the changes on
> >>>>> all supported targets.
> >>>>>
> >>>>> As I said, I had made the changes only to WCN6750 initially (using a
> >>>>> hw_param). Can we take that approach for now and enable this for other
> >>>>> targets only if required & upon thorough testing?
> >>>>
> >>>> I can tell you that on IPQ8074 threaded NAPI really improves perfromance.
> >>>>
> >>>
> >>> Great. Do you have any test results on IPQ8074?
> >>
> >> I dont have full test results, but on Poco F2 Pro as the client @80MHz AX
> >> I got ~720Mbps compared to ~550Mbps before.
> >>
> >> I can tell you that in OpenWrt, we have had it enabled for 6+ months
> >> at this point
> >> and its been really good.
> >>
> >
> > That's a significant improvement, great to hear that. We have another
> > strong reason to have this change in upstream driver.
>
> Indeed, thanks Robert. Is the code in openwrt similar as what
> Manikanta's patch does?

Hi,

It's actually identical, we are also just calling dev_set_threaded
before napi_enable.

Regards,
Robert
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
