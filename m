Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80285117F1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiD0Miw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 08:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiD0Mih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 08:38:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D97B53A47
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 05:35:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x12so1347381pgj.7
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KGoiKThNNldW5CuJfONmCAcyG3jeF9yQplW3LmQI8ds=;
        b=yet35CrIHS2XNUbO5g6ky98Cy5tkPaJju737xmjI08OzgVss6VOcU4HBtGavtGBV7u
         5gisqQwcfTFy7Smf6TkZ32jn6ni2BCSemuOYK7T0kgpt6d/Y8PDOXActrsY6HAH8e6ok
         KOl6Z04D4mXoy9ImokH8j0RHlqt7hwNcDmlHEKj4JMlyQjhdLG8KN8CTk4HN31j/RMpE
         qNYbm6ETxV6eFnvYT+SgnwKlzfhVoHNnLGPv4aQh2xMUhdBpzEhqNLNnJZwft1hGMmY/
         AOOgVPq/ljPPHAPe+u3255WQCOa5hERMVzwo5xaZremIxahA4nxE6hqAAt1P8+fqg1AK
         X95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KGoiKThNNldW5CuJfONmCAcyG3jeF9yQplW3LmQI8ds=;
        b=EnkIutwKaI6xbCSqhaXGzNbUHTZU20jHYybKm+v/jduNIpzjfzq3M9vx7uRC3In9PW
         rBt6KCgpZd8HQtKRHTQmZ0w+jY9BlumBw75DrGPOTHGG2sMU0iGhKqWYeUPoQFx5zWG/
         3iSDUp1rTTNwfAS5mG1KZltu3vKXufYOxSqi7qoLERIzUNL/Zzbc4Gp+B08Gpa0ZjzEd
         aVQ8re7Z8nhB4x/7QkN8CxqKiRCeF8Kq/GBlB6s3Hf9mHpFFT4QsO4P7J+CdkKd68WOP
         Sw6zMeWTQ3OeLV/2F4I5wF1iJRU3PPXA7RnAsq8Vg6Fw0KDzLrIRu+QTllw6uvWWKT2W
         r4Lg==
X-Gm-Message-State: AOAM530zjQDnEm+mMHn4GAd/QR9uDLUBzb+ZaCBFSQ+nqCKaeaAjDRyU
        ubNsLaX3fXo+RQ7N3X3luEMuIiConZxMF8kJ3AJiNQ==
X-Google-Smtp-Source: ABdhPJzodkNISExPGwp0lK9r8R/HIdY0dG/DdpVT2DucIyCUQhJuI2UP85XQYrbeSsbDhLugrjGiXnHVXAHKLFG5jdQ=
X-Received: by 2002:a05:6a00:228b:b0:50d:4d2a:e911 with SMTP id
 f11-20020a056a00228b00b0050d4d2ae911mr11107031pfe.79.1651062924587; Wed, 27
 Apr 2022 05:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220407223629.21487-1-ricardo.martinez@linux.intel.com>
 <20220407223629.21487-3-ricardo.martinez@linux.intel.com> <CAHNKnsRt=H_tkqG7CNf15DBYJmmunYy6vsm4HjneN47EQB_uug@mail.gmail.com>
In-Reply-To: <CAHNKnsRt=H_tkqG7CNf15DBYJmmunYy6vsm4HjneN47EQB_uug@mail.gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 27 Apr 2022 14:34:48 +0200
Message-ID: <CAMZdPi90Joo8+_44ceqS3k8ez08W_AX-eWs42F0ztDN67WR2Pw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/13] net: wwan: t7xx: Add control DMA interface
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        M Chetan Kumar <m.chetan.kumar@intel.com>,
        chandrashekar.devegowda@intel.com,
        Intel Corporation <linuxwwan@intel.com>,
        chiranjeevi.rapolu@linux.intel.com,
        =?UTF-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>, amir.hanania@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dinesh.sharma@intel.com, eliot.lee@intel.com,
        ilpo.johannes.jarvinen@intel.com, moises.veleta@intel.com,
        pierre-louis.bossart@intel.com, muralidharan.sethuraman@intel.com,
        Soumya.Prakash.Mishra@intel.com, sreehari.kancharla@intel.com,
        madhusmita.sahu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 26 Apr 2022 at 02:19, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrot=
e:
>
> Hello Ricardo, Loic, Ilpo,
>
> On Fri, Apr 8, 2022 at 1:37 AM Ricardo Martinez
> <ricardo.martinez@linux.intel.com> wrote:
> > ...
> > Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> > Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> >
> > From a WWAN framework perspective:
> > Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> >
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> This line with "From a WWAN framework perspective" looks confusing to
> me. Anyone not familiar with all of the iterations will be in doubt as
> to whether it belongs only to Loic's review or to both of them.
>
> How about to format this block like this:
>
> > Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> > Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> > Reviewed-by: Loic Poulain <loic.poulain@linaro.org> (WWAN framework)
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> or like this:
>
> > Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> > Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> > Reviewed-by: Loic Poulain <loic.poulain@linaro.org> # WWAN framework
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> Parentheses vs. comment sign. I saw people use both of these formats,
> I just do not know which is better. What do you think?

My initial comment was to highlight that someone else should double
check the network code, but it wasn't expected to end up in the commit
message. Maybe simply drop this extra comment?

Regards,
Loic
