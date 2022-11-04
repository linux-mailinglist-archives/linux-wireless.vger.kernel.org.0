Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20961A0AC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 20:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKDTP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiKDTPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 15:15:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880C44874A
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 12:15:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v3so5164109pgh.4
        for <linux-wireless@vger.kernel.org>; Fri, 04 Nov 2022 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEf9d311gYlVy+enAlEz8rGW1CJ9xfrOljmhcAt92Dg=;
        b=LhjGaHgkBVWHBr/Hub8tG7h7OMzM9VZ+F9/RSmJH3AmPOAxF3jcmpjLhRHst+xu34F
         En6EekpQvCmcfyhPAgT8Wnsm+PpVO9AydAUvODs7XTbkYHVHJw8YrzKiOS6WWcQgh1T1
         NSsrq4CnpSZUgzr5KqYrrWERL+HiysUc2s+us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEf9d311gYlVy+enAlEz8rGW1CJ9xfrOljmhcAt92Dg=;
        b=AllivqZn9MM31GtpGhk+8w5bpoIUowHtWNlfWD5ciKzFfNsmHHgCO243jAb81+d6pK
         vAHVMFLOC+BxOAR5g3OeBo31aQq+WPpv+11T9g6970VYIdwszEGJ0kSgk7E7zJB25J1p
         YS49le/GPriGNsgGoVKCcdyf5nxysppjVJYMG7EufdVk6b2wWbYpcze1bVYOR+WakCzk
         Yb0c49Ge/BgujazvLxBjzK+xnNkIkicxXp10m/l7ZlHr6snfilE6IHzETpOAlsjEamLC
         ckeC3txLNtjEuFEI/sB5KkF/t2Nvd/PaqKd0kXpReeCoib34anupV/LtKocXlZO6Ivc0
         bNGg==
X-Gm-Message-State: ACrzQf0+DWyRjGN1NWOubhGp697go4CDyXgl3SYP9QDmZ3+IUchbUZxI
        PQg3I9vTq//vkTfv92+fXvu/IQ==
X-Google-Smtp-Source: AMsMyM7YfYNFEIynGzowgsu6m5LvrNg+n/4e5PtDyEWzcl6lmyrNsLMr56TmeYEshR0X8edL+EHHRg==
X-Received: by 2002:a05:6a00:1749:b0:56e:4586:4bc1 with SMTP id j9-20020a056a00174900b0056e45864bc1mr10268770pfc.41.1667589314056;
        Fri, 04 Nov 2022 12:15:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b0017f7e0f4a4esm126654pll.35.2022.11.04.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:15:13 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:15:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Gary Chang <gary.chang@realtek.com>,
        Timlee <timlee@realtek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: Coverity: rtw89_mac_resize_ple_rx_quota(): Integer handling
 issues
Message-ID: <202211041204.CCA9C3F778@keescook>
References: <202211021253.44E254479@keescook>
 <884ff1b628e44d32960f438f75a6524c@realtek.com>
 <87h6zgfub4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6zgfub4.fsf@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 03, 2022 at 08:03:59AM +0200, Kalle Valo wrote:
> I noticed that linux-wireless list was missing in CC, would it possible
> for the bot to automatically add that to all wireless related reports?
> Adding it manually now.

Yes, good point. The tooling was looking at the commit's tags, rather
than getting a get_maintainers.pl list. I'll add this logic.

-- 
Kees Cook
