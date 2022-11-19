Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2D630CD9
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Nov 2022 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiKSHIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Nov 2022 02:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiKSHIp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Nov 2022 02:08:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A82CDE0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Nov 2022 23:08:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y203so6908932pfb.4
        for <linux-wireless@vger.kernel.org>; Fri, 18 Nov 2022 23:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JAomBLzMWpxG+jKkSWv7aeDaZwvbB6/vO10KmU8WTn4=;
        b=XFZNNwUBtpky5AvtQ3KG/OOizK7sfxo4Mc0+CYLH8LZtO5cS0vhuXi3Gc7+bsucxAT
         UOekSiNbjEW0FF2soQCYEc6CErOmClQUcIbE2T4NAZzFN+cmXTDEMfqLxz5aAgLDaA4m
         /xyBsm1XxzNoQwCmToyZTVqhs/GTOBG67Z6sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAomBLzMWpxG+jKkSWv7aeDaZwvbB6/vO10KmU8WTn4=;
        b=b9fdXT7g5xOyBAno3vgrGbwKpD4KWSU74sImdzti5pNomNt9HYLX++Vo8C37GJ7WzB
         ACYs+7stNhpbS4dZ+Dno2eEm9JJhCsgan8CvoGVI+0glSQWAIwwkiFoBydWIFEzKXS0v
         7ynNzyc745cbN2ifbZedTk42P74OO6hSq2WCO5uUBlcSSRWj0ntOQpkKBBuu+tnYFwbV
         C/rjY7zpx8UUIw052s22afa6/H9lYE7TBQbFG4SmesEVVLh0aG1QAEAxrPUqdMd0J7Rh
         Noh+YurHb/FWX6Xfvl5u2dJiV/tkkFW4X6CZh5CKQVyqqSojlGhuV1Y6vq2nfCo9I/Qu
         DnJg==
X-Gm-Message-State: ANoB5pm4p1DPqML3zU1h6+PRYdLVjnUgjlYzDjhoGFZmCBHLNlmH8zSG
        L/DAwSlRhJ63UVE/KDxfgdZ9hg==
X-Google-Smtp-Source: AA0mqf5yxrtOD/a/N7wAQgsex//ZjQfa+t4D7cq4uMpYXby9xwV1i8aqA0ejg5jd+aWdvhTIN3h4tw==
X-Received: by 2002:a63:e802:0:b0:46f:ed3a:f36c with SMTP id s2-20020a63e802000000b0046fed3af36cmr9800450pgh.372.1668841718412;
        Fri, 18 Nov 2022 23:08:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n62-20020a622741000000b0056b88187374sm4308162pfn.85.2022.11.18.23.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 23:08:37 -0800 (PST)
Date:   Fri, 18 Nov 2022 23:08:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] carl9170: Replace zero-length array of trailing structs
 with flex-array
Message-ID: <202211182307.3EF1218@keescook>
References: <20221118211146.never.395-kees@kernel.org>
 <877czrqwhc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877czrqwhc.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Nov 19, 2022 at 08:39:11AM +0200, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > Zero-length arrays are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> >
> > Replace zero-length array with flexible-array member.
> >
> > This results in no differences in binary output.
> >
> > [1] https://github.com/KSPP/linux/issues/78
> >
> > Cc: Christian Lamparter <chunkeey@googlemail.com>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Nowadays we include "wifi:" in the subject, but I can add that. But
> please use this in the future for all wireless patches.

Okay, thanks! I use a recency/frequency prefix guesser, but I've updated
it to include "wifi: " if "linux-wireless@vger.kernel.org" is in CC. :)

-- 
Kees Cook
