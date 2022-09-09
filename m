Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1355B2F4F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 08:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiIIGye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 02:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIIGya (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 02:54:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8D395
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 23:54:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so1829141ejy.5
        for <linux-wireless@vger.kernel.org>; Thu, 08 Sep 2022 23:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=C8mOufAnbZRl+iaqRSjTK1hOqHh/V9tIOH97yB9mTwc=;
        b=i70d5ZplWnp33lhN8Vn61WeFCfYPosdzPnUEB6i7orIahdXRDcrLwl3JVcLwwTGWgb
         6By7eYRGKLEWauhv5MMOPudhMfJTU3TQvDfXfDB5EybxtzvOTjO4ryAMuspvxrQOG/UM
         ISKLtMw+KJzDaYux6MzTozE+5ssOAeS2bghnLKkzCFAqRn1tPp7JIEauEwE0FGfjOORu
         kLcc+Xlrok6hLnPgF7JDUFxgrkIwi2r/HzCW900qo2JfNtn3XwJ5JFCELbrGoKW+OpOt
         EQ4X+4jTGgMBsnJB8NvHWGmUBjSSaaVpWYNSAmxqkvwObdtmMrDTzBDRwxAnuaYFeLpD
         ldFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C8mOufAnbZRl+iaqRSjTK1hOqHh/V9tIOH97yB9mTwc=;
        b=kU0Ywmb3y511IhPemTysGg14asg7DYcjSyPTW3ay0oGMqxfrcb3TQO22DSKUqYhTjO
         ZjaEs0FSwHqp6LnufAWLuMW+yteN0wgIIJ7v7v6pl75pUr/9dDDN8wlHfjuFBh/VHLTJ
         9JkKuwQYMqrxbUwc3gaDGHXge3OflGBpCM3av77bJGEXZf+f6pTUtFgczXn913ddOfcV
         pmVRIuxJlYglvfW4fZKmlknIKwB0Hct+2waK9a7sQx3QCoNNupxf9lU8oRr5KcCPlBcQ
         MEFoqKIcTqa/1myZqBzMKUZsWy8LibDDdymoV98vfEV4/3zxwVByd+RcRV3bXPs15fak
         M08g==
X-Gm-Message-State: ACgBeo1oq+fIoLgu1t47x9xzD/z7kDtV2s3sv7wm3vcviLwiZ8tWYxlf
        uNIx9DFbSJzcUHr5ZPYv1CUOWwnkGSfhWXlC18xsww831J3PwA==
X-Google-Smtp-Source: AA6agR4odZFG9aQPmsj/J9R/FLRlSfypcr/wHujTaCRcosfR+czW2zOzYseuoATQ05oqL1HgHWqyKFeuX5nDNUF5j78=
X-Received: by 2002:a17:907:2c4f:b0:741:5b68:e2d9 with SMTP id
 hf15-20020a1709072c4f00b007415b68e2d9mr8527349ejc.314.1662706464329; Thu, 08
 Sep 2022 23:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220907134450.1183045-1-toke@toke.dk> <87k06daysx.fsf@kernel.org>
In-Reply-To: <87k06daysx.fsf@kernel.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Fri, 9 Sep 2022 09:54:13 +0300
Message-ID: <CANUX_P3=k-+r6n1MRSiUPuB3FmtuoeUw8z6Sjxb2ed7+gmb+yw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Mark IWLMEI as broken
To:     Kalle Valo <kvalo@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 9, 2022 at 8:59 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
> > From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >
> > The iwlmei driver breaks iwlwifi when returning from suspend; the bug
> > report[0] has been open for four months now, and now fix seems to be
>
> s/now/no/? I can fix that.
>
> > forthcoming. Since just disabling the iwlmei driver works as a workarou=
nd,
> > let's mark the config option as broken until it can be fixed properly.
> >
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D215937
>
> So does the bug only happen with iwd? Should I mention that in the
> commit log? It would be good to describe the conditions when the bug
> happens.

The only reports I am aware of are using iwd.

>
> > Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation=
 with CSME")
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I assigned the patch to me on patchwork and will queue for v6.0.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
