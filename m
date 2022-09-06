Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C665AF7CB
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 00:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIFWVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 18:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIFWVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 18:21:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF8A1A66
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 15:21:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v5so12644258plo.9
        for <linux-wireless@vger.kernel.org>; Tue, 06 Sep 2022 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RgoXF8Fr2Vb4R0rdgwHkQdSUNWvhKRSE+FTvXutxsP0=;
        b=kYQR5RDttIPEHnSgK17BspmZVJMATsZPhzxdlRR66Zz2Qvs4R3EN+2CfX8FZiC1IlA
         CAlrS2Tzzwd2mtyvqpT7zIvmgMwFmvvNlOJnNt0/qDondu18gM0AT1E0v1qZHWZ7sh8W
         c/DJDCO9vnIi/7Tea7dPVjchX5G8Jyij0w2kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RgoXF8Fr2Vb4R0rdgwHkQdSUNWvhKRSE+FTvXutxsP0=;
        b=eeK/bmYNiy1mDPg6Vn8WI/pvWQ2gCwhWrNDJUUKvXBrKO1Dx/EG91GmE/KqXXr08ww
         RvuxyraXvBv65wHDcCjG4hKaskaqz8HigdkRTyAEptSVp/QitS99AyPVugFfrXj9vgLx
         MPRYOWg8gL0UDgPt/OnZZUNulQ6hzJwWqP/lvoWLlPvlb3GY6PhrqHG+Ru659T4+xMin
         18HMu4lImS9V4O6kIs4SkX0BY0SEcN/84Vv3m4c62s8jghXIwP13r7IsOwxL1CQ5xvVR
         JiyJn63PQxtvivqEZ8N24vlUTPtKqc7cwgFi+VnMCvWx+K5WYndzIqwHwkQN/JTkMhLb
         c1iw==
X-Gm-Message-State: ACgBeo20+MVekB8B3xm6b2jaYbeUFU6XFwZa7nzfyg6YbWGxlKoTiZgj
        UkMXnfgKFATAQvoZeL5rTq6qHw==
X-Google-Smtp-Source: AA6agR7fjIxOgwIL3OptIro5K1Hx/nBJUJV2foFTu5sSbnH+/mmTJ8RF8F4pym09gHa+35Ym31NI5w==
X-Received: by 2002:a17:90b:3903:b0:200:7b4d:737b with SMTP id ob3-20020a17090b390300b002007b4d737bmr542056pjb.83.1662502908867;
        Tue, 06 Sep 2022 15:21:48 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:922a:25d3:a5a:7290])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79a4e000000b0053e22fc5b4fsm2576441pfj.0.2022.09.06.15.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 15:21:48 -0700 (PDT)
Date:   Tue, 6 Sep 2022 15:21:46 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 09/12] wifi: mwifiex: fix endian annotations in casts
Message-ID: <YxfH+jtBYsSwBOYL@google.com>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
 <20220904212910.3f72609a3825.If4048592701bf04981be1dab18eaaa339b2ea382@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904212910.3f72609a3825.If4048592701bf04981be1dab18eaaa339b2ea382@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Sep 04, 2022 at 09:29:09PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> These cause sparse warnings, and since the device generally
> works in little endian we can assume the code is correct, so
> just fix the casts accordingly. No binary changes on x86.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>
