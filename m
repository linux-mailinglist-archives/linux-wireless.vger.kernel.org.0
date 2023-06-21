Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E928D7389E5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjFUPlJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjFUPkp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 11:40:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B41ABC
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 08:40:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-553a998bca3so3210862a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687361994; x=1689953994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+yCyBwF3XR3hDGNb43rreQVhJvrloK5Tk0QghMWh+U=;
        b=E23yA51ZwSOW7vdFOZ2qK+jb8TTRlCmJxB2+QOHpPJ0LWRwlkz2Z90HHpizqEYUXjc
         i8Ykh5vT1cb1yOnWGuXTv2aK9h/gIJMR2kxXUk579xiDkYnTuLuNarCCnxHNiPDOX6oU
         zQ3O4Et/LUZpIw/zmVo+PSnGM1E1LsymHLgv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361994; x=1689953994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+yCyBwF3XR3hDGNb43rreQVhJvrloK5Tk0QghMWh+U=;
        b=hdpYhM/QqrNSdj5CboutVjFDzfzEG/4/NX3qZcN4OWo75zR/GjE7rFd1sWIuTwtmco
         925KCbuOGE0jkInfBTzCDr75rBdhMgyS49r0yJ4yI1Bn/cXcP6SUHeYk2K6aFNTj8tKW
         8Wk6h2TKn9Xe+wqD1VZVgWADA5TmPA6S+7DZZ3ETRNpxpZkpMPXfhg2SnyJN5i5vp9Xg
         YbdR6DK0RPoJsMyKPAPpeGSA74Ma+VyMdntZafREpER37H2CRZAah1z5OMuQJVuKQuKZ
         zBW9L/fvjVgqqZAekAgCoQyklZRjFEAEH8yPCfAY1DCyYmDlyhQwFPSAysjbOWXvvI5u
         ozHQ==
X-Gm-Message-State: AC+VfDzuCM/qDdCqJP6XQWnfbbe1QReVCfk5ukr7RcLJ4L/v1ZMPKlr7
        LbDn7nFoMuToG+AqNjDfUaT4fBrSpraEA+X1ONU=
X-Google-Smtp-Source: ACHHUZ4OQyUkQ6geaxRGO+Kp4PmaUpzPH0MRDby6T+5sIEc30qwvz4I+/d0WeLBlbLKnayFSyY0XkQ==
X-Received: by 2002:a05:6a20:428b:b0:122:2bc1:8857 with SMTP id o11-20020a056a20428b00b001222bc18857mr8608698pzj.52.1687361993949;
        Wed, 21 Jun 2023 08:39:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:566c:67e8:1803:3438])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b0065992d334f4sm2466486pfc.177.2023.06.21.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:39:53 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:39:51 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] [v2] wifi: mwifiex: avoid strlcpy() and use
 strscpy() where appropriate
Message-ID: <ZJMZx2E1irSNVOEl@google.com>
References: <20230620100803.519926-1-dmantipov@yandex.ru>
 <ZJHO/pa7JB49j3rN@google.com>
 <ee69ac82-bc62-a288-d7c9-bb432a1b5959@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee69ac82-bc62-a288-d7c9-bb432a1b5959@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 21, 2023 at 11:08:46AM +0300, Dmitry Antipov wrote:
> On 6/20/23 19:08, Brian Norris wrote:
> 
> > I'm not sure how a compile-time constant makes this "unsafe" at all, but
> > if you feel the need to change this, then sure, this works too.
> 
> The only reason is to avoid strlcpy() which is now considered deprecated.

Sure, OK.

> > FWIW, this 'firmware' pointer is all derived from compile-time constants
> > too. So the commit messages seems misleading ("all other calls [...]
> > should be safe" --> well, *all* calls are safe).
> 
> Indeed. So I think we can stay with strcpy() everywhere except strlcpy() to strscpy() replacement
> (just to follow https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy rather than
> to fix something).

That works too. It's cool to drop stcrpy() anyway though, since it's
really just a feature of a poor language (C) that we have to reason
about whether any given string operation is "safe" or not. I was just
noting that your commit message reasoning was slightly off.

Brian
