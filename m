Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487765A50DD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiH2QBE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH2QA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 12:00:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588FC5F9BF
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 09:00:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so8067367pgi.10
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=4M0i3XiDN/+kkqbpcLkvRg3J5WfZu733Pqyignr2Kxk=;
        b=JthZYmGosV2+yTcDS7/k3vYteoerjPi2oQ+isK6Eh6d0E7LAplpFmNzQtH+Nv/cPp1
         qvzoOJQLr5mbSNpO5S7+7fq90TsISJuqUTr9gIWVcaW311oKvP50DzePiIy8SlX3tX8A
         kEgarZMIv5QBDiSGsmNURNVckAdaL1CFJvu1Mve6k/5oPBtUXQ95O/6JJsX+jUgvRnB5
         6NOGCCJTwthXa2wN9iE43pYVwpNv+jjFs+LJcN/HueZ61gHL2QJsrtL5voRP+Kz8gOt8
         D93cm5nwrb27A1MnVL0k8boZzLmxUGSgO3n+VrneSMWI/n923u1qfsksYpsOmpT1OskC
         Aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=4M0i3XiDN/+kkqbpcLkvRg3J5WfZu733Pqyignr2Kxk=;
        b=7Ts3zMdS7n4ZVZGwJW69vWXUC2z1F6B6HOZjwOA4lXY2E3SMPJcDQd1yx6jZlXwptC
         AVTzKFjkH4cm0E3DEOcq8Qq5G3byTR7j7bVdJKKaXAEubi7TKgFkhq/iuYpFB6TG2Bz4
         tY0oenZqEqOfqN2crtXAcSWPUnA8S2NBjdIxxrQXkrDtz2Az0TSJn3FFC5xKw74i8qCM
         9uQLiIAslFtaNylC1BZXlP7hYu/EqugcTnfvEDyBU8mKIXPjjAI8RFL09pZf0SY0b7do
         mQLm07aG8JYsF0LCtOPfO3nMjwuEcb6l+e00DWiYFcTgC9sAjVOXwTgMq6IIkAx6lsQ3
         pnzg==
X-Gm-Message-State: ACgBeo0a40ggd6xf+3RxJWUkz+bR4rxYqY+MoyVMarHZIImp2P0oz8KF
        WSuzfJa9iV1An9A8Cca5WQ9AEFeUc7U=
X-Google-Smtp-Source: AA6agR5Zrz3Bi9fGWpmhzcbq9L9UVUFdnstys+FjCIVHNLZdUu9Pqpe6mfnLlGUGGlQifFknauUq3Q==
X-Received: by 2002:a63:ba05:0:b0:42b:229d:e644 with SMTP id k5-20020a63ba05000000b0042b229de644mr14125318pgf.125.1661788855520;
        Mon, 29 Aug 2022 09:00:55 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902a3c200b001714e7608fdsm7708211plb.256.2022.08.29.09.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:00:55 -0700 (PDT)
Message-ID: <cba322cbf992067e843114ab53da610978768d64.camel@gmail.com>
Subject: Re: Automatically adding OCI in mac80211
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Mon, 29 Aug 2022 09:00:54 -0700
In-Reply-To: <199f2ac280a1e1a195add45290411a9c1dc519fc.camel@sipsolutions.net>
References: <432703ce83ac979ba06e2b85d6dc500f246c6a76.camel@gmail.com>
         <199f2ac280a1e1a195add45290411a9c1dc519fc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2022-08-27 at 16:46 +0200, Johannes Berg wrote:
> On Fri, 2022-08-26 at 14:12 -0700, James Prestwood wrote:
> > Long ago support for multiple authenticated BSS's was removed due
> > to
> > its complexity. 
> > 
> 
> Well, actually, you can still authenticate with multiple BSSes, we
> just
> don't really track it.

Yes what I meant (which I never made clear) was that once you
authenticate you can never go back to the original BSS without fully
disconnecting.

> 
> > CMD_AUTHENTICATE now changes state/channel, and is not
> > recoverable if authentication fails (i.e. disconnect). 
> 
> It never did anything else though, IIRC? Anyway, doesn't matter much
> now.
> 
> > The spec
> > actually allows/intends for multiple authentications to be
> > supported
> > and FT specifically can really benefit from this.
> 
> Sure, and with FT especially you can do some things over the DS too -
> but the kernel no longer cares, which is the part that was removed,
> if
> you try to assoc without ever authenticating it doesn't matter as far
> as
> the kernel is concerned.
> 
> > As a workaround we started playing around with using
> > CMD_FRAME/offchannel for authentication, bypassing the kernels
> > state.
> > This works, and we can authenticate, fail, try another BSS etc. all
> > without the kernel knowing, then proceed to association.
> 
> Should work, yeah.
> 
> > The small problem is dealing with OCV. Prior, we would call
> > CMD_AUTHENTICATE (channel changes), then GET_INTERFACE in order to
> > obtain the channel/operating class to build the OCI element. Now,
> > since
> > authentication is done offchannel we cannot use GET_INTERFACE.
> > Deriving
> > the OCI based on capabilities is certainly possible, after all this
> > is
> > what the kernel does, but rather than trying to mirror/maintain
> > that
> > code I thought it would be great if the kernel could append the OCI
> > automatically to the association request. This would also save a
> > round
> > trip since GET_INTERFACE wouldn't be needed.
> 
> I don't understand. You already have to know the channel in order to
> even *do* this (off-channel TX)? The kernel doesn't really know much
> about operating classes, so that part seems a bit tricky.
> 
> Also note that this is not going to work so well with MLO due to the
> link and MLD addresses, and the kernel currently inserting the ML
> element, so not sure you're going to want to go this route now.

Yeah, true the kernel doesn't have the tables for operating classes... 

Basically the critical info we need is the channel width and center1
frequency (plus center2 freq for 80+80) values for the offchannel
operation.

So maybe another API for getting this? Give it a channel/freq and a BSS
MAC, and run roughly the same derivation as
ieee80211_determine_chantype().

The only problem here is when picking the channel the kernel tries one
configuration, and if it fails it downgrades the width... So this would
need to be fixed to know ahead of time, if thats possible.

Note, adding something like this would also benefit FT-over-DS since
currently you cannot do OCV with it.

Thanks,
James

> 
> johannes


