Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5953F3F7C09
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhHYSIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhHYSIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 14:08:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1DC0613C1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 11:07:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u3so197303ejz.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcYKVqQSFav1GX+z3dOkJIc4nB4fMZOFfEayNc3CdZA=;
        b=MWBegt9r0CkqgxFcqDtewibUSNsZ1bQl+pb0B6BQvvhIgHW+/lZ7gHh802g+Ho3zjw
         gqQp4+Vh2WP08rW72lYsSWVa8dVfodLMVnFAbO0DgNrkuE/ROW2Buu5GzX8gX0VHY3gJ
         yJ0XuUt7P4yWx9MFK/pFwP4pYtBZFlCl+UKpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcYKVqQSFav1GX+z3dOkJIc4nB4fMZOFfEayNc3CdZA=;
        b=qADzWm77/xGHQhbQTKIWAsQvEsTDV56PY5I647Pj/+IDvwvvIc1pf2ZHcKOC9ln/ib
         eP6PAM6P5Zr1kus3xFIDRxwpvgBRrNqQV23FNdSHdz+ds2Il8nDfO+iMLyFm6nW+96gn
         4FDrXTz6K6CKyQzb/JafhssWl3SVOQDCg0evu+YfwWRO88Rqx+MI1eTpVWQHeYb8ZfPI
         BLn9AiaidoIx6fxm0eIJuF9Kej4ZkWVAxC6qEfk5RNsbAP08mkrq5MhcxhI6Fm+k8iWF
         wM0DzRs1tT0jmG/zHOjjlR9Lg8su1lzeu2RR0s5iqmvGntVsilzliSbimPnnhMpJsIcg
         8yog==
X-Gm-Message-State: AOAM530Ifidaxt/jbeg1lOyX0uPimEhhMf05t454tt5aTfoOb/Zo5HXQ
        Rw+6Uit1iu+4Y5KPUmETqWyFcdRLOFOwzgCY4WnStg==
X-Google-Smtp-Source: ABdhPJxNfrBB4SRP7AEr2PstKyZ1UcKE7jB+fsPlnc3d+DtyMYlgpBb8XNigBy9JNwuG2+WzeSMznGaq1/298lXOJ/g=
X-Received: by 2002:a17:907:2126:: with SMTP id qo6mr19587033ejb.476.1629914864682;
 Wed, 25 Aug 2021 11:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210702223155.1981510-1-jforbes@fedoraproject.org>
 <CGME20210709173244epcas1p3ea6488202595e182d45f59fcba695e0a@epcas1p3.samsung.com>
 <CAFxkdApGUeGdg4=rH=iC2SK58FO6yzbFiq3uSFMFTyZsDQ5j5w@mail.gmail.com>
 <8c55c7c9-a5ae-3b0e-8a0f-8954a8da7e7b@samsung.com> <94edb3c4-43a6-1031-8431-2befb0eca2bf@samsung.com>
 <87ilzyudk0.fsf@codeaurora.org>
In-Reply-To: <87ilzyudk0.fsf@codeaurora.org>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 25 Aug 2021 13:07:33 -0500
Message-ID: <CAFxkdArjsp4YxYWYZ_qW7UsNobzodKOaNJqKTHpPf5RmtT+Rww@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi Add support for ax201 in Samsung Galaxy Book
 Flex2 Alpha
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matti Gottlieb <matti.gottlieb@intel.com>,
        ybaruch <yaara.baruch@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        yj99.shin@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 21, 2021 at 8:34 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Jaehoon Chung <jh80.chung@samsung.com> writes:
>
> > Hi
> >
> > On 8/9/21 8:09 AM, Jaehoon Chung wrote:
> >> Hi
> >>
> >> On 7/10/21 2:32 AM, Justin Forbes wrote:
> >>> On Fri, Jul 2, 2021 at 5:32 PM Justin M. Forbes
> >>> <jforbes@fedoraproject.org> wrote:
> >>>>
> >>>> The Samsung Galaxy Book Flex2 Alpha uses an ax201 with the ID a0f0/6074.
> >>>> This works fine with the existing driver once it knows to claim it.
> >>>> Simple patch to add the device.
> >>>>
> >>>> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> >
> > If this patch is merged, can this patch be also applied on stable tree?
>
> Luca, what should we do with this patch?
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Is that to imply that there is an issue with the submission?  Happy to
fix any problems, but it would nice to get this in soon.  I know the
5.14 merge window was already opened when I sent it, but the 5.15 MR
is opening soon.  Hardware is definitely shipping and in users hands.

Justin
