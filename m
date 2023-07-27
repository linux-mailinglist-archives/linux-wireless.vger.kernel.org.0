Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9CD765863
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjG0QN6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 12:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjG0QN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 12:13:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D19310B
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 09:13:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdf08860dso119550866b.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690474434; x=1691079234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAolxS4IusoeO3YfRXX+XbhFutKgmKfmAwH/RTvZy64=;
        b=Fv4thv+XDhRgj/xBVO7Kekb831rjX3/gAux9itwEq9RzbJAi0eYz+l/hY141jb417b
         aaDpnCCwQscCyjlonjA62RmE7GRXf1XyJeDkbtdUu+/v38vEyHwsJvxhRh0ffVxt6W6o
         lvmvdzv9q3o5yp8gAM4X9T0RB6wCp19mOP7h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690474434; x=1691079234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAolxS4IusoeO3YfRXX+XbhFutKgmKfmAwH/RTvZy64=;
        b=BGaIfebFprnidtR+h5ib0AcLYP6r5dfYnV7Vq9C1glZgE4eQSSKVHW7vhW3A4eGUoO
         KQfobg9hSmeG6TeICzvG51Mtx0FiwvktZjWJUPfFAbyTGY023QRgxz4xjDw1boXIPmYw
         qKW5UblOCp3tO6fbfdUOF8DuckOCUfzkRg7OQKr6o407bUizK7/iRmE8O1XysU4mVJ01
         oBlSHCMsTvGuzYlRcFqEkOhGcKf9gde/KMSxeZAcICo0vmanmrurveyzZvnH0MeRCx3v
         o0K3RjMIc7vreXeHAwoWB2GDlNRHpxtyEoBZwLT9xKgZrbfljlEakEEZp0Zch1EWcgJV
         1XPg==
X-Gm-Message-State: ABy/qLafjyH/inKjdFUaeQO6XyPcqplN3DG+X/0E++oMiINk+TFJ6mRV
        T+eWp43+BCN11+KzoLG/IDNO7Xr3GhAw4iGsOhXxgA==
X-Google-Smtp-Source: APBJJlFnezJ+C7Dsdek3MBvDySdahCxk53qPA3mia546+YGfp1xAKnX347Dh7CpR9dFqp6AAxbUaew==
X-Received: by 2002:a17:907:1b0e:b0:978:2b56:d76e with SMTP id mp14-20020a1709071b0e00b009782b56d76emr2682478ejc.12.1690474434592;
        Thu, 27 Jul 2023 09:13:54 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id s14-20020a1709064d8e00b0099364d9f0e9sm933439eju.102.2023.07.27.09.13.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 09:13:54 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9891c73e0fbso235840966b.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 09:13:53 -0700 (PDT)
X-Received: by 2002:a17:906:2d2:b0:989:450:e565 with SMTP id
 18-20020a17090602d200b009890450e565mr3176882ejk.23.1690474433484; Thu, 27 Jul
 2023 09:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
 <ZMGO3r44oOtMck7S@google.com> <87ila528c3.fsf@kernel.org>
In-Reply-To: <87ila528c3.fsf@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 27 Jul 2023 09:13:38 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO6yTkVfA_GaJZLJYcZo=MU3f1uVm1tZBdS6vTT6x1mOQ@mail.gmail.com>
Message-ID: <CA+ASDXO6yTkVfA_GaJZLJYcZo=MU3f1uVm1tZBdS6vTT6x1mOQ@mail.gmail.com>
Subject: Re: [PATCH v7] wifi: mwifiex: Fix OOB and integer underflow when rx packets
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Polaris Pi <pinkperfect2021@gmail.com>, matthewmwang@chromium.org,
        kuba@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 26, 2023 at 11:10=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
> Brian Norris <briannorris@chromium.org> writes:
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> I'm nitpicking but now that you (Brian) are a maintainer I would prefer
> that you use Acked-by instead of Reviewed-by. Patchwork shows the
> statistics (A/R/T in the web ui) and then it's easy for me to see that
> the patch is ready to be applied. This is for the future, no need to
> change anything here.

Argh, I knew that's the recommendation, and I thought I did that here,
but obviously not. Thanks for the reminder. I'm sure I'll fix my
muscle memory eventually :)

Brian
