Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2B75B54F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGTROi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGTROf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 13:14:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315111739
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 10:14:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66869feb7d1so676140b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689873273; x=1690478073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlpcsYGlL/x0GLBNI9qt63nhzbsb90iaISSHZS7FpDM=;
        b=CjKnS3oHJIwg837yod+g3i9B5tVNjG93bWuJj6DAAbr6Gkeo8VYCDDgsH/DoOVaTuK
         tZ1eGblyS4kLLJkRavqj6EjlTMx2W8KcFrnxYvn8PVBVX6JyibFa82clyqkLqUh3BK3M
         qmXCCH9vLAObiep2RBKOUI3KeqvE5clK5i0s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873273; x=1690478073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlpcsYGlL/x0GLBNI9qt63nhzbsb90iaISSHZS7FpDM=;
        b=QzqIhfWuxjwjOHU0oBFY20pzKq2BPcqj69BgLdc7HybaOdkotDtvPf93i7DNIYHGvR
         pYDMTgtfWOGalUzkqDIEGZ10InkCBaDjDzY4aRpeV0m0RnjdlJdZ3BIyF9u1wDFLEdFL
         Eki4Hq0GvnyqLXEfocYs3gq5PWxvPiwupomwgNUwMBR7cHJK7s9r/VGT1EMqTlVXtJdJ
         YdNmjzIYbsocGIzYox+NRu84QJiScxIwqaKqoVjzSd/7I6Bu+WT7OxZwNtVzOhTmT4eT
         CL1lEvNtwe5W32APj9oTPho9c1pKAEBQgQt6t0EEmqEYUz07M81wWocrg5+A6TyDneZB
         /rqQ==
X-Gm-Message-State: ABy/qLaEb2So6EMCfqazS9f0YQHB+iZD/PcG+oGtRRd24HX0Tiknytvu
        Yiudokrjyul8Nbcfe8UVjUSUsA==
X-Google-Smtp-Source: APBJJlGqbJIS+cAL7U5Puzwioyfho0TNrFgA7mqXlDduG1s5LonZa4aGKv/+YUILXGom+bAlXbNOqQ==
X-Received: by 2002:aa7:88d6:0:b0:682:5a68:5645 with SMTP id k22-20020aa788d6000000b006825a685645mr2796007pff.11.1689873273533;
        Thu, 20 Jul 2023 10:14:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cf2f:1797:934f:52a2])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7825a000000b00678159eacecsm1430800pfn.121.2023.07.20.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:14:33 -0700 (PDT)
Date:   Thu, 20 Jul 2023 10:14:31 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Pink Perfect <pinkperfect2021@gmail.com>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Message-ID: <ZLlrd4dDz+kA5l18@google.com>
References: <20230713023731.2518507-1-pinkperfect2021@gmail.com>
 <CAKNAPeOvG1MVD0y5xuZpN8mSEzvrzcvRhdyrTJhju-_Z1nGV0g@mail.gmail.com>
 <20230713105644.49444826@kernel.org>
 <87sf9j3wd1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf9j3wd1.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 20, 2023 at 09:55:38AM +0300, Kalle Valo wrote:
> We have four maintainers for mwifiex and total silence:
> 
> MARVELL MWIFIEX WIRELESS DRIVER
> M:      Amitkumar Karwar <amitkarwar@gmail.com>
> M:      Ganapathi Bhat <ganapathi017@gmail.com>
> M:      Sharvari Harisangam <sharvari.harisangam@nxp.com>
> M:      Xinming Hu <huxinming820@gmail.com>
> L:      linux-wireless@vger.kernel.org
> S:      Maintained
> F:      drivers/net/wireless/marvell/mwifiex/
> 
> I'm very close of marking this driver as orphan unless anyone steps up.
> This is not how to maintain a driver.

I'd be fully on board with removing these maintainers, as I don't recall
hearing from any of them in years. (In fact, some of these addresses
don't have a single mail logged on lore.kernel.org/all/...) I just
didn't want to be the one to say it.

On the other hand, I regularly look at pretty much anything for mwifiex,
as long as the submitter is in relatively good faith. So I wouldn't mind
being a Reviewer (or Maintainer? what's the difference, when Kalle
does the committing anyway?). And that might qualify as "Odd Fixes", as
I don't plan on doing much more than keeping the lights on.

I'll submit the MAINTAINERS patch if you'd like.

Brian
