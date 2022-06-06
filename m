Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068DD53E7E1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiFFOmH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbiFFOmF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:42:05 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C72DB32B
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:42:00 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f16a3e0529so19409421fac.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jun 2022 07:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Nvu8iB4xWX4bHR6ue9VhTaz6xu3wc17oTSTm8NyzdGE=;
        b=SSOwZH8gdPajYVgk1yx/39HnJJNHu2TVvNAECfGPCUPcbMw9TKMoaKzSzTiizNcSEx
         xXe5hY9tbjYW6qBXslI+NK2/rR66gcnqqFkV42GPEpC22bdi1bGeMnHBC6mcWd2p0jaE
         Xuge3nmwHUNKGSUEk4ohyznYTFGo3dafZs45nD7tNGwjQjFHD7IcoYTDeLmNHs2CKBD1
         ilIKlYQKm0UnVZNcfd/27TMQJQRt59r6/FsiZItTCzSiWOJbuZHBt7vcjssf4luD5F6y
         xNlOvWd13Qe1VrxIlvKo26NaXfjVeEizThYDu9ozUslRZmdsEI1AMIPbJpds1JeEqFga
         1WBg==
X-Gm-Message-State: AOAM531rwaHQvSS/eZm1lNNLK1uqJj7RtO9J/CYeG2bJUeRwTOz5Q3TQ
        NevfeOgHu6ZwbL+k6U/0GXQ=
X-Google-Smtp-Source: ABdhPJysFbsvplh3PArjmCfQ753+RaOpClMrznu4ZGagpMh8jSSBB9ccqGh851h2S7vMZgYIDMLQFw==
X-Received: by 2002:a05:6870:b41b:b0:f2:c8c7:b30a with SMTP id x27-20020a056870b41b00b000f2c8c7b30amr30354960oap.22.1654526519561;
        Mon, 06 Jun 2022 07:41:59 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:e98c:2dab:81ec:c18c])
        by smtp.gmail.com with ESMTPSA id b10-20020a9d5d0a000000b0060b069325f2sm7725590oti.63.2022.06.06.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:41:59 -0700 (PDT)
Date:   Mon, 6 Jun 2022 09:41:58 -0500
From:   Seth Forshee <seth@forshee.me>
To:     Ed W <lists@wildgooses.com>
Cc:     Seth Forshee <seth.forshee@canonical.com>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] Correction of wireless-regdb for GB
Message-ID: <Yp4SNofnJOeu/tB1@ubuntu-x1>
References: <4d07581c-a3be-a3c6-bf32-7007eb45d541@wildgooses.com>
 <20201106214446.GG6125@ubuntu-x1>
 <2a710032-f2ec-d55b-5da4-d881089fe0cd@wildgooses.com>
 <20201120175444.GN5439@ubuntu-x1>
 <e7268989-03cf-ae7c-f3c6-b48fe679b790@wildgooses.com>
 <Yn7PFi556pM+r08j@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yn7PFi556pM+r08j@ubuntu-x1>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 13, 2022 at 04:35:18PM -0500, Seth Forshee wrote:
> On Mon, Apr 25, 2022 at 02:17:57PM +0100, Ed W wrote:
> > On 20/11/2020 17:54, Seth Forshee wrote:
> > >> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
> > >> ---
> > >>  db.txt | 7 +++++--
> > >>  1 file changed, 5 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/db.txt b/db.txt
> > >> index ac32483..cc5ffd0 100644
> > >> --- a/db.txt
> > >> +++ b/db.txt
> > >> @@ -588,13 +588,16 @@ country FR: DFS-ETSI
> > >>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0019/136009/Ofcom-Information-Sheet-5-GHz-RLANs.pdf
> > >>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
> > >>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0013/126121/Statement_Implementing-Ofcoms-decision-on-the-57-71GHz-band.pdf
> > >> +# GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0036/198927/6ghz-statement.pdf
> > >>  country GB: DFS-ETSI
> > >>  	(2400 - 2483.5 @ 40), (100 mW)
> > >>  	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> > >>  	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> > >> -	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
> > >> +	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=ETSI
> > > This looks okay to me.
> > >
> > >>  	# short range devices (ETSI EN 300 440-1)
> > >> -	(5725 - 5875 @ 80), (25 mW)
> > >> +	# See UK specific notes in ir-2030.pdf, p47
> > >> +	(5725 - 5850 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI
> > > To echo what I said above, I'm unclear whether this change is in effect
> > > yet, and based what I've seen so far I think it would need to include
> > > NO-OUTDOOR.
> > >
> > >> +	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> > > I'm also unclear on whether this change is in effect yet.
> > >
> > > Thanks,
> > > Seth
> > >
> > >>  	# 60 GHz band channels 1-6
> > >>  	(57000 - 71000 @ 2160), (40)
> > >>  
> > >> -- 
> > >> 2.26.2
> > >>
> > 
> > Hi all, I dropped off watching this for a while....
> > 
> > Seems like the update to IR2030 (GB country code regulations) was re-published last year, and the
> > relevant sections are in pages 32 + 34-36
> > 
> > My reading of this is:
> > 
> > - Other stuff we changed 2 years ago seems ok, caveat I'm unclear when we need to state half power
> > vs using mean EIRP?
> 
> We have to use half of the maximum EIRP in cases where TPC is required
> because Linux does not support TPC. This is why 5250-5350 and 5470-5730
> have lower limits than what is prescribed in IR 2030.
> 
> Note that many recent rules have also included power spectral density
> (PSD) limits, which can also limit the max EIRP in the database since
> there's currently no support for PSD limits in Linux or wireless-regdb.
> Where specified in IR 2030 they do not impose any limit beyond the max
> EIRP for the minimum relevant bandwidth for our purposes (20 MHz), so
> they don't end up making any difference here.
> 
> > - The 5.9-6.4Ghz range is now good for use (page 35 near the bottom), perhaps add something like:
> > 
> > +    (5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> 
> This looks about right. AUTO-BW isn't necessary since there are no
> adjacent rules. It looks like this was overlooked in the beginning, then
> the pattern was copied.

I've updated all rules for this range to remove AUTO-BW. I think the GB
rule is correct now.

I did a quick check of the other rules versus IR 2030, and they look
okay to me. Let me know if you see any issues I missed.

Thanks,
Seth
