Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A82655286
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 17:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiLWQED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 11:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiLWQEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 11:04:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4E3EAC9
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 08:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B9E2B820E4
        for <linux-wireless@vger.kernel.org>; Fri, 23 Dec 2022 16:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9C6C433D2;
        Fri, 23 Dec 2022 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671811438;
        bh=OKOAqxKT607r839NMfVxk5d3NBrMK6QVS1reAe+w2CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AezOj3welAFhBUATTKMcyy4Mt10PNNAcAHL+vk1/HiMbc2ajz8jJe6zaq709ram1B
         scV2H0/1H4RAowpJau2cre3FIPOG8pbB28hjB6obZfl55HNIruvxnIOsMzuEEIaOj4
         16U/5eSlCh/C0u1/iskLNl0uKHU1wtC/aeJoGq6ZqyOwwDX4zLodcFwZJh/mzNWAQC
         q5oQ0qfCcujZ6L0bUk1Ci4OGA8LyJr0f6d34cLbcGwVo3XfKdjB+1tH4O122D/qeeI
         oJ7mYDhvX2NNR/UMTW5PnMMRlxg5H5VFQOXSEVD5lSF2AgO4kgfvVX1V9sKNmxwzVM
         UlEkLzRk6jRug==
Date:   Fri, 23 Dec 2022 10:03:56 -0600
From:   sforshee <sforshee@kernel.org>
To:     kleo <kleo@hak.dog>
Cc:     wireless-regdb <wireless-regdb@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: wireless-regdb: Update regulatory rules for Philippines (PH)
Message-ID: <Y6XRbJThM4oKMOVY@ubuntu-x1>
References: <184ec3a63fe.d96b82f6427171.7593361304891506395@hak.dog>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <184ec3a63fe.d96b82f6427171.7593361304891506395@hak.dog>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry for the slow response. Please see my responses below.

In addition to those comments, the patch isn't formatted correctly for
application, and it is missing a Signed-off-by tag as noted in the
CONTRIBUTING file. For sending your patch I suggest using 'git
format-patch' to export the patch to a file and then either using 'git
send-email' to send it as an email or attaching the patch to your email
message.

On Wed, Dec 07, 2022 at 06:56:00PM +0800, kleo wrote:
> diff --git a/db.txt b/db.txt
> index 3f74194..fa9ffd7 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1368,11 +1368,17 @@ country PG: DFS-FCC
>         (5735 - 5835 @ 80), (30)
>  
>  country PH: DFS-FCC
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (17), AUTO-BW
> -       (5250 - 5330 @ 80), (24), DFS, AUTO-BW
> -       (5490 - 5730 @ 160), (24), DFS
> -       (5735 - 5835 @ 80), (30)
> +       # https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2003/MC-09-09-2003.pdf
> +       # https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2013/MC-03-08-2013.pdf
> +       # https://ntc.gov.ph/wp-content/uploads/2016/MC/Explanatory-MC-No-01-01-2016.pdf
> +       # https://ntc.gov.ph/wp-content/uploads/2022/mc/Memorandum_Cicurlar_No._002-09-2021.pdf

The documents you linked to establish use of the frequency bands but
don't seem to contain any information about the relevant power limits
and other requirements. Where did this information come from?

> +       (915 - 918 @ 2), (30)

I don't see anything in the above documents about the 915-918 MHz band.
I also don't see that range listed in this table of frequency
allocations that I found:

https://ntc.gov.ph/wp-content/uploads/2022/frequencyallocations/NRFAT_Rev_2020.pdf

What's the basis for allowing this range?

Thanks,
Seth

> +       (2400 - 2483.5 @ 40), (24)
> +       (5150 - 5250 @ 80), (24), AUTO-BW
> +       (5250 - 5350 @ 80), (24), DFS, AUTO-BW
> +       (5470 - 5730 @ 160), (24), DFS
> +       (5730 - 5850 @ 80), (30)
> +       (57000 - 66000 @ 2160), (40)
>  
>  country PK: DFS-JP
>         # https://fab.gov.pk/type-approval/
> 
> c5da72a2fef48891aceb3f3378afbb12a2778c83e9f053f5d23e589630536b61  country-ph.patch
> 
> kleo
> 
> 
> 


