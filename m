Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10682608474
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Oct 2022 07:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJVFQC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Oct 2022 01:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVFQB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Oct 2022 01:16:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F429B8A7
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 22:15:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so4876091pjl.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UN4R7aan0TFMWstrrKsDuG9HVGJJPIMOBUhXuvvb92w=;
        b=My+ELWetjMbws+T8dsw8yMCpKzsFA9KZyeYMl9OSoD+XTUDDMeyRWjveA0ukQcNUjY
         Ard5Zk6nonUzGcHFsKVPuvrmMtZwIgXWIlJrpLGKnq7Sgm0g8cIA9inABbx7Jx2E+LJA
         n3NWlG87SOjZ6OcgLz6F1thcKs8rCEJlIPgbTViZQ+H+aeoxXHjbHLGHxhwDISLtEu93
         ArlfzicznbMGwF/CD081oM5zkF+0V3TBfYTzcYNLf4gKGRR6MXWLqe1930TgRE1vojru
         TGZ9p2kVLxYh3KVQb9YWyus/GAiUWeRTfMmtk/oj7kyKUjBiXgbI7O1sBgV8ZeFgbFrb
         LLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN4R7aan0TFMWstrrKsDuG9HVGJJPIMOBUhXuvvb92w=;
        b=aMqv/7mj2L2w/yj17dPWzwBmyJxT7AXmfipwnkJNS9FWUrJlh8ZsBQGhjRMoZpJI+A
         BUypzE/3JhXJVxQ71ipBquovkECeZhxojxf8fWQuwDsf0BLGdLkQwraPzq48DJ9ifsfJ
         jutbQhQEboURrmnolwGPGM8rkzThYDuOkqbEw+Vbsy+mWlnCP3H3iI6PdAX32EgLaKzR
         ZNY2ZnPESM91/MF6isMVH4rqPWft7OcazChPD/VLl+7AbnQYDdBcUkxmsb2uLF3Vjbmq
         iACeHHrzBdyhqFQ1dE74SdOnY/t0F9aIIYPu6DubWYsuXQcZjpgGbjNJJA/J614F3qLM
         4fUA==
X-Gm-Message-State: ACrzQf1VNV7oNSHU9IPbCFOsi3JWnNii2d6iOxQVvhbaz3tk9NmhiMcY
        nND19icbjPJy0RSrFaoKo5I=
X-Google-Smtp-Source: AMsMyM7D7325vPg09cycrQQPbvIuRwapPyDDn8Z3wiBpvUP1H86YMccxButb+KKsOeQwvDN0c3o2TQ==
X-Received: by 2002:a17:90b:17c9:b0:20d:b4ee:aec2 with SMTP id me9-20020a17090b17c900b0020db4eeaec2mr51699450pjb.234.1666415758427;
        Fri, 21 Oct 2022 22:15:58 -0700 (PDT)
Received: from laguna ([165.132.118.110])
        by smtp.gmail.com with ESMTPSA id u189-20020a6260c6000000b005627d995a36sm16161274pfb.44.2022.10.21.22.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 22:15:57 -0700 (PDT)
Date:   Sat, 22 Oct 2022 14:15:53 +0900
From:   Dokyung Song <dokyung.song@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arend Van Spriel <aspriel@gmail.com>,
        Dokyung Song <dokyung.song@gmail.com>,
        linux-wireless@vger.kernel.org,
        Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: Re: [PATCH v3] wifi: Fix potential buffer overflow in
 'brcmf_fweh_event_worker'
Message-ID: <20221022051553.GA633896@laguna>
References: <20221021061359.GA550858@laguna>
 <87v8od1x69.fsf@kernel.org>
 <10230673-8dbe-bf67-ba76-9f8cdc35faf3@gmail.com>
 <87czali5x9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czali5x9.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 21, 2022 at 05:53:54PM +0300, Kalle Valo wrote:
> Arend Van Spriel <aspriel@gmail.com> writes:
> 
> > On 10/21/2022 8:57 AM, Kalle Valo wrote:
> >> Dokyung Song <dokyung.song@gmail.com> writes:
> >>
> >>> This patch fixes an intra-object buffer overflow in brcmfmac that occurs
> >>> when the device provides a 'bsscfgidx' equal to or greater than the
> >>> buffer size. The patch adds a check that leads to a safe failure if that
> >>> is the case.
> >>>
> >>> This fixes CVE-2022-3628.
> >>>
> >>> UBSAN: array-index-out-of-bounds in
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> >>> index 52 is out of range for type 'brcmf_if *[16]'
> >
> > [...]
> >
> >>> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> >>> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> >>> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> >>> Reviewed-by: Arend van Spriel <aspriel@gmail.com>
> >>> Signed-off-by: Dokyung Song <dokyung.song@gmail.com>
> >>> ---
> >>> v1->v2: Addressed review comments
> >>> v2->v3: The subject now begins with 'wifi:' and add a reference to a CVE number
> >>>
> >>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>
> >> Please include the driver name in the subject. And we prefer use
> >> parenthesis with function names. So the subject should be:
> >>
> >> wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_worker()
> >>
> >> I can fix that during commit.

That would be greatly appreciated. Let me know if anything further needs fixing.

> >>
> >> Should I queue this to v6.1?
> >
> > Please do. Probably good to add Cc: for stable. Should apply to older
> > kernels as is.
> 
> Ok, I'll add that as well.
> 
> > btw. is there any formal way to reference CVE. There probably isn't as
> > generally we don't require a CVE in kernel tree [1].
> 
> I'm not aware of any formal way to mark CVEs. If there are, please let
> me know :)

I am not aware of any either. I looked at other commits and followed recent practice.

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
