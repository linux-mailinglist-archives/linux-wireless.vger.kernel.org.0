Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C635D74E647
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 07:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGKFSH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 01:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGKFSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 01:18:06 -0400
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0B812A
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1689052686; x=1720588686;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=J7mRGXWzjzUypZl1YrlY6WnKyilGpAMzn3Fsy5/G7mU=;
  b=PmTPaJFcFG+/TLTLWbus1VXCqqhLtqyxqJ/7DoYNG6mCXPPUlgVEi4KA
   HgwVihUyrsYn5qPFhOSB8qLmZWuccA+iVB2oNXgmC3g/N+oJxMD6Pe3uN
   hhSd8RNFM2+MglXqe3g4tRygiIkUl9b71OYbLY0cYzzm1fJtiMyRECaWp
   xJxPkXu4AKUvW/x+aQdFBrH00Dtz634UzrJNPFwCnG2ohKjAiwb2CXiy4
   8IvbveLO7pYQ0+tqMgEaQsGLn2uklytbIwEvZYB6eLIUW9/38Fyp4WZtS
   QwlpiZ+qHeg1RPajnHnsBFfo1LrvDhjztuRHORVh6HLYuGAxBriBjD1Gt
   w==;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2023 22:18:05 -0700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31596170243so1664372f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1689052683; x=1691644683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7mRGXWzjzUypZl1YrlY6WnKyilGpAMzn3Fsy5/G7mU=;
        b=tGMxj18PMGNBcN11yKaDN2a8+AEOJLpLBtgkukMkomxoAQW1SohL/wOlp+9LgZhM4G
         pF23yM43mJennj9ItvgP8QjvrMd+x8pPaEhJjALVGAfRog6uEKW1Lee/OvPzIlUpMqK8
         hHbP+QByT0LmmexpGnpvo0jMr+kjJ6wMkgrTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689052683; x=1691644683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7mRGXWzjzUypZl1YrlY6WnKyilGpAMzn3Fsy5/G7mU=;
        b=PQ1e7Zd/4QoInbQ+pb7rCdooyHvNa3oUh+c3ewbdPIm5OTqmtWbmrdJTMGmBUvo/cK
         h1GMKsy7JJyL2vgWTqQS7InAXoZBQ925PdDYMGBOnLM4zQj/1C6GOfAWrI6qIvajwesS
         Qw5MvbN1GdnnwfIJZt+Uxr44JaScHQ667vpJzfGMW/JrGRxi4fPYJsXGlm09JvoKd/Ih
         7Ma3td9oUAsPZkYrWttguESsRw3OExDF/PbIgHXw3fuob5678z+lOkY6FRiSxBYlRvhE
         agTOtrHaekc+faWAbiPYQX7DMIskSH4W7VebAfpD1j9GKQxgYU1xBJ5TyBBqGM1Cxdct
         EjQw==
X-Gm-Message-State: ABy/qLbWwA7nieIQd/ge2tYHu2KcgkqQH7N8f9XEdFbIwzytNrkGBZ+c
        0mZjt4YnNgD3LjDvCnUB6u+a/aVRWuGU+56vGv/XWTNZEyN93u4q+acr+UArg/+YNyJ5e4SoCtu
        db+0xUBhI1O7dudTZjXkgYZV9y8khYQBMsgwfkZV97SBlqGlWZEH0
X-Received: by 2002:a5d:504d:0:b0:314:1582:6eb4 with SMTP id h13-20020a5d504d000000b0031415826eb4mr13048366wrt.46.1689052682981;
        Mon, 10 Jul 2023 22:18:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcnTK0PswcZXZPjRlH+DrHN2Yu+zWHba4C9fsKbw7o/gHv+E+HaCsuq/OYFlMktrMxYq6kbtwbdKeqSeL4N7A=
X-Received: by 2002:a5d:504d:0:b0:314:1582:6eb4 with SMTP id
 h13-20020a5d504d000000b0031415826eb4mr13048355wrt.46.1689052682700; Mon, 10
 Jul 2023 22:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
 <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
 <CA+UBctANALC+FdNf+0v+hFZS5RPry=44LF3HQWKMYCxibgb_vw@mail.gmail.com> <770f630823c33f25ecddcbac19ef3acad82c2636.camel@redhat.com>
In-Reply-To: <770f630823c33f25ecddcbac19ef3acad82c2636.camel@redhat.com>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 10 Jul 2023 22:17:51 -0700
Message-ID: <CA+UBctA8iE+NWqgTk-v8K5-nAGzX9Zb4fJu+xP0PKmzyxzVufg@mail.gmail.com>
Subject: Re: [PATCH] net: wireless: cisco: Fix possible uninit bug
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     kvalo@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
        Jason@zx2c4.com, linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Got it. Let me do this.

Yu Hao

On Mon, Jul 10, 2023 at 9:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Sun, 2023-07-09 at 19:52 -0700, Yu Hao wrote:
> > I found that the related code is from Linux-2.6.12-rc2.
> > In this situation, the 'Fixes' tag should be 'Fixes: 1da177e4c3f4
> > ("Linux-2.6.12-rc2")'?
>
> Exactly!
>
> Cheers,
>
> Paolo
>
