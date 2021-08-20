Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C173F301F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbhHTPud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbhHTPuc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 11:50:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9013DC061760
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 08:49:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so1223469pjw.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JP8WFZmb9rgUa+mH2LJuzuE/iABY2L7RW9PxVxSWy1g=;
        b=k4UQQteJL7Qh1f6962sQXTg69gVAgArCnEbcoafW8q8WU3a0dFyoCb6HUcE0lFqUsS
         2TQNQdHpbA93nCoa1N/aiXdy8pDJcz4pQGJmxqJfbouuNtmtbloWKcbAnFDzgP+YEWHK
         NHH2EzfCjBYGkA2kf/rNG+rCeii3d90rhg4wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JP8WFZmb9rgUa+mH2LJuzuE/iABY2L7RW9PxVxSWy1g=;
        b=PCKDUbiU9XCKjNCpKq2FVoxhEUW95rz1x4gaaEhb9pcSDcefo76JXRTVDp60yEweVC
         WdwJl4D1KbEI3K67zQFJ0NL6aV5WAKXHkZdOw521J1OXy8zQKJsmjfsYBan2Q9NiHbEx
         PU8YwY6+o31FfSLoWaiMMOXpSzAIzm9G7YtfmYwp06aDgnRywU6ZQ0RZpBAUtkDfzKwI
         4fuaTeKLLhyHwJZpVKW73/6LLiLhONwkweTPa7dMUSLAotYG918p8BMQP79aKohkIeyL
         ipV0J1xlmwuu3m2qop5Q3Ook9niP6bPKrVgLownT/1R2+4TBDTeCvQCPg9Np4jldW69T
         r8NQ==
X-Gm-Message-State: AOAM5304CisDK9b7KHtOKCavYltpc8hPSg5oQEVeU5S1JGS9kjTEYe5j
        N5n4KjpgMZ5Y0w7IYtIuy+Bb5A==
X-Google-Smtp-Source: ABdhPJwhegutOkRrxvU2g3GeI5YumyD6linmLQRuyi6C1VpKbOltTluibfSiLlEYf9DDH4WcSj+Egg==
X-Received: by 2002:a17:902:7c98:b0:131:21fd:3717 with SMTP id y24-20020a1709027c9800b0013121fd3717mr2602853pll.53.1629474594147;
        Fri, 20 Aug 2021 08:49:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm7564913pfj.178.2021.08.20.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:49:53 -0700 (PDT)
Date:   Fri, 20 Aug 2021 08:49:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, linux-staging@lists.linux.dev,
        linux-block <linux-block@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 55/63] HID: roccat: Use struct_group() to zero
 kone_mouse_event
Message-ID: <202108200849.9EBF036376@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-56-keescook@chromium.org>
 <nycvar.YFH.7.76.2108201501510.15313@cbobk.fhfr.pm>
 <CAJr-aD=6-g7VRw2Hw0dhs+RrtA=Tago5r6Dukfw_gGPB0YYKOQ@mail.gmail.com>
 <nycvar.YFH.7.76.2108201725360.15313@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2108201725360.15313@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 20, 2021 at 05:27:35PM +0200, Jiri Kosina wrote:
> On Fri, 20 Aug 2021, Kees Cook wrote:
> 
> > > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > > field bounds checking for memset(), avoid intentionally writing across
> > > > neighboring fields.
> > > >
> > > > Add struct_group() to mark region of struct kone_mouse_event that should
> > > > be initialized to zero.
> > > >
> > > > Cc: Stefan Achatz <erazor_de@users.sourceforge.net>
> > > > Cc: Jiri Kosina <jikos@kernel.org>
> > > > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > Cc: linux-input@vger.kernel.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > >
> > > Applied, thank you Kees.
> > >
> > 
> > Eek! No, this will break the build: struct_group() is not yet in the tree.
> > I can carry this with an Ack, etc.
> 
> I was pretty sure I saw struct_group() already in linux-next, but that was 
> apparently a vacation-induced brainfart, sorry. Dropping.

Cool, no worries. Sorry for the confusion!

-- 
Kees Cook
