Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3077804E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjHJSf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 14:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHJSf1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 14:35:27 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD32713
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 11:35:26 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56cc3453e31so996055eaf.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691692526; x=1692297326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSG/F4t14oAJim+zDvaYu5N3S/EYktNQQ+S/ve1hxM8=;
        b=hFCcLQafTq3HD50KnLO7D3IH61kgNcrvq+YU1JjkWLgI0/A+u2wmpm3NYnwFlHqtY4
         CE7pC9rxmSyj8ErJde0pvvCQf37d9kU84zK46masfxMrmoZhn9Y5MRJtmwMCE/57odpV
         dGb4P/31N4Kh4ULUQKuxxoAKyA3RHLLrvlTQXxmFQmdM+2IyEeMTwVQpP9hejd2241As
         kXqpK/QUvAJmV9wFoQ6pT1MV/6zKlIlSzMhdrj7T5AQeuLSrhWYd390Tz1eobJaa84Pv
         kfwmDW+H4AKGDcFpEniPsGR298bGP6eAzm3vVsglxrMOU27pbAE8LFt03XvyW0MRZpj8
         NSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692526; x=1692297326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSG/F4t14oAJim+zDvaYu5N3S/EYktNQQ+S/ve1hxM8=;
        b=alllPyCpEzZADkB7/d/BoL1eY+oQqNGp4QKoq2WKfWSRLEEGu1o1c+qA/lXTxb9Si4
         VElCLPfZrUmmIu/9WnffTyDCz/yt2CjLgSyA98pyMv9QpfKEamoSIiS2/rhF8q1Ip5tJ
         l2EDGa8A4jAeD+atoMTMl9Y5fXLfXvsuUx5/rdiq3o+tieh8Kzgbra0HkFgMLF9T9P/R
         86rRIEs6LWTQ2VXozBplxib1dItxL+L/ItHKY9hp85eTPC09bUbQfPwt814c5fq6T7sJ
         ixDTApcALHT43WYdk9jf8qTIwC6wY9nBKHMJ6OyR3jJGUvZ0bvqgrDih34/r97vJkSmi
         sLTQ==
X-Gm-Message-State: AOJu0Yx/gzP7rDiVlAoC7RD6K44PiwUacjpWkcYMmBnRyXikyyLI7VFz
        liz4z/1vacYUVw0rteQHyt0PTZwHg7bdR8vpc7E=
X-Google-Smtp-Source: AGHT+IFKJD2BoNTJbp4KkhpfVT/1XruFkqoS/M/lYfwGGQsbILWNuMVWn8yLiwR1yqLvVYWZISouegvjD9w3FSNNJxg=
X-Received: by 2002:a4a:918a:0:b0:56c:e856:8b2c with SMTP id
 d10-20020a4a918a000000b0056ce8568b2cmr2549853ooh.9.1691692526074; Thu, 10 Aug
 2023 11:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no> <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net>
In-Reply-To: <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 11 Aug 2023 00:05:06 +0530
Message-ID: <CABPxzYJvAtgbrr_v6cMuKwFjzRjYOCDota+koYp-iogtJS75HQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: Add support for sending BSSMaxIdle in association request
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 8, 2023 at 4:43=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Thu, 2023-07-20 at 01:10 +0530, Chaitanya Tata wrote:
> > When WNM is enabled, a station can send its preferred BSS maximum idle
> > period in the association request, add a new netlink attribute to get
> > this value from the supplicant and add BSS maximum idle IE in the
> > association request.
> >
>
> I don't see anything here that even requires all this code, rather than
> wpa_s just including the element itself in the association request extra
> IEs?
Yeah, WPA supplicant can prepare this, please ignore, thanks.
