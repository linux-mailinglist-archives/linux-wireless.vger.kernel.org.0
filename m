Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03FE770715
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjHDR3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjHDR3Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 13:29:24 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812F3C25
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 10:29:22 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44756c21105so1556195137.1
        for <linux-wireless@vger.kernel.org>; Fri, 04 Aug 2023 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691170161; x=1691774961;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y31ynTvWmeTHL1NTsgINzt9HXeX/OdVZuEC9OyRT55g=;
        b=tiYBsu6sxtSdFgY74ewQ923H5gr9rklrbV6uN4qg2hdXDlDuujAxBT50vPKhA1Sunf
         4U6T9JXnH9ImmSLbDkyIRZ4Z6csqysBNXH15cL5JXjDBCPzgoIQzatOsxOb+CJOQ94+/
         q3mBZE2OuH+tBJU6l8zy0yfzD/OtFgenxELyp6lsBIBU+BeusN5HRh1NWdcVBr/1h1un
         nq+Mo+lUE94VYn3mgvgm2VVTzFqGmc9FdEPuQ5C7mHnBmbxIrpwjPPc9vZJGXtzXruB1
         cR1XaLC9Xt7F3FjMg8sXt8xyhGHB5YSW7zNgBpQv2oKLPLvDGFO0jUL7ZYpZ/M7OGygr
         9pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170161; x=1691774961;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y31ynTvWmeTHL1NTsgINzt9HXeX/OdVZuEC9OyRT55g=;
        b=VvVXLyonjbBVJLCutDF1MM6rD7/2hZuc9uClnJhIYS45kmJnfSqKIIofJ3wDmmJ6YT
         oizj8u4RMUVKEjBY9Nh67KxQC+TAVV3II5rmXzW6b7qQTXaxG5fi0AUvbyRwDpPnU0tK
         Ya3VMKvEmomNKSunhq44kjetv2ssAsJBIIi2CYUa2hj6lzYOq2RnI6ykylAoxek4qLhQ
         jkvzdZkRGd0hAqR8TzRt5JeZDCRA6/aZumrNkd8lyzScxtpDIkkkfSzLfwVWCUCx+Ivg
         C+RJZ5CREAZMAde3qD4PwAU1au7uc5EduH5Cb3OWvUXklE2PoGPpmQHSYTycVoCR3OkD
         irKg==
X-Gm-Message-State: AOJu0YzzeY/zQD0AAp3+8zqY1Op1TSjtGm9mKwnrruceyjm85UsaZ81C
        I6Nutv6ldQfOhn80cLFSnUWck4sZTZks+G1FSNu53X7N5pd6squdZ9Y6yA==
X-Google-Smtp-Source: AGHT+IGHYdas3iBtL1R/DE2NpyhS3QZpegBBEIpBXvUlaIV37cBpO0dPI3TrdCAcPZ+0urGSvQccCAniT5/V4T2ArS4=
X-Received: by 2002:a05:6102:3127:b0:447:c2f5:ee09 with SMTP id
 f7-20020a056102312700b00447c2f5ee09mr197906vsh.2.1691170160918; Fri, 04 Aug
 2023 10:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230602225751.164525-1-kglund@google.com> <8545d75827ff8d85fece58542539db6c9930d3b6.camel@sipsolutions.net>
In-Reply-To: <8545d75827ff8d85fece58542539db6c9930d3b6.camel@sipsolutions.net>
From:   Kevin Lund <kglund@google.com>
Date:   Fri, 4 Aug 2023 11:29:09 -0600
Message-ID: <CADgzm_mvnoETW3y4hvhqdUSC1ByNEjy2BsQUqq_Va-YEaGzULg@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: cfg80211: Reject (re-)association to the same BSSID
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for the response. I'm still a little bit confused because
AFAICT, over on the userspace SME side of things there are two
similar checks that reject both authentication [1] and association
[2] to a BSSID which we are already connected to. Wouldn't that
break the 11be flow which you're referring to?

In any case I'm ok with abandoning this patch. I'll resubmit the
other patch in this series [3] on its own.

[1] https://github.com/torvalds/linux/blob/master/net/wireless/mlme.c#L281
[2] https://github.com/torvalds/linux/blob/master/net/wireless/mlme.c#L342
[3] https://patchwork.kernel.org/project/linux-wireless/patch/2023060222575=
1.164525-2-kglund@google.com/

Thanks, and apologies for my late reply,
Kevin

On Mon, Jun 5, 2023 at 10:42=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2023-06-02 at 16:57 -0600, Kevin Lund wrote:
> > Within cfg80211_connect, reject the (re-)association request if we are
> > already connected to the exact BSSID which is being requested. This
> > prevents an unnecessary attempt to connect which in the best case
> > leaves us back where we started.
> >
> > There is precedent for behaving this way over on the userspace SME side
> > of things in cfg80211_mlme_auth. Further, cfg80211_connect already make=
s
> > several basic checks to ensure the connection attempt is reasonable, so
> > this fits in that context.
> >
>
> I don't think this is right - we should be able to reassoc back to the
> same AP in some cases, for example in 11be this comes up when you want
> to change the negotiated links.
>
> johannes
