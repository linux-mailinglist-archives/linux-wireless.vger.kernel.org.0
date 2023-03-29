Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AAC6CD7D5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjC2Kms (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjC2Kmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 06:42:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41CE2135
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 03:42:45 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d22so8989010pgw.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1680086565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pqAbUFfZiNAhVrRkDDtYoGzMzm37Wd82TtGFY4R3UI=;
        b=s0u0upSbIUKtRcAK0o7kK2itfM/jxmnYT3JBkMYKb9duYTH2DIjSlFLFsgkPeNa10r
         +FSc9ZFLQmMokiJ61N+ZFV0MN0GikoBkv+8xYN84qBheVTrDwLRjYByfbtLpQE+KzauL
         wuBtte2nZdW4kYI5kFbgjjyD7X4/BFw5MsCDPR4yc2hgq9nv1vP4gSE13Fw1hrRdCAfM
         WA/PRvIGBjf2mxPI5GOaJ+ltD8BDhYpHEVKV1/0Rspq06QsSfA36r0oL73rx4kAUf3ZX
         k76L3Df19RpQMXVppI+bEKLvQ2uOrq2f80skSAMsrTGFusHpHfIYg7Hdwwry/Obx4Lfn
         eeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680086565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pqAbUFfZiNAhVrRkDDtYoGzMzm37Wd82TtGFY4R3UI=;
        b=e1WXY6uL/z9ZzrkxZe4A/kz1YSkCg/F6kO2iON5O3cqgQxJUrYmiKnpF5d52PI97Ed
         1CQmE1PEc5zKTdV8SQGxyPoLhCjVsl+r35A8WcVHV9JgvS7XpQlVkguf7tViiKw8Fn43
         jpmWpOCQu920dvEHUEh8oVTdq/WIA33yuZns2albD2r/bvrJ+CR362uVKBALyF3AYXlR
         G8kVICbQBjDd9Bc/gCjZ5j0UeFLvXEave2nfGSnIhdBm48FW8N2MLuVIqMUrMiatqUa5
         HB2U93dflNGp69vb5pwQQaCAbvbp90FmeLa4tkPo6fPLDnMD57XqhBREw/Jqf1S0Uz/d
         LQcw==
X-Gm-Message-State: AAQBX9fan34K0O2Rcc5Tv+5tJ0nZ4y8JLjev3ydAKVtgWsXVVEZsfDfu
        U3aZSY3zJr/P40KFTdFIqv3nw0mj2+59mFH66jeEHw==
X-Google-Smtp-Source: AKy350Yo8TVnevEY8VdJ78n97+w7knMlBtntmkhqLIV2dPuhf6x+6a+8fOe4sJdxednmNd9dC1IRhn76LC0i5ZDbidk=
X-Received: by 2002:a05:6a00:2d1d:b0:61c:67d2:a332 with SMTP id
 fa29-20020a056a002d1d00b0061c67d2a332mr1039907pfb.3.1680086565027; Wed, 29
 Mar 2023 03:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
 <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
 <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com> <87fs9ndh6s.fsf@kernel.org>
In-Reply-To: <87fs9ndh6s.fsf@kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 29 Mar 2023 12:42:34 +0200
Message-ID: <CA+HBbNEaNTkUv_UPgQievxaLya0XC6=AVj0=GWiH+qB9=vRZHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Muna Sinada <quic_msinada@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 29, 2023 at 11:45=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
> Robert Marko <robert.marko@sartura.hr> writes:
>
> > On Tue, Oct 18, 2022 at 11:28=E2=80=AFPM Muna Sinada <quic_msinada@quic=
inc.com> wrote:
> >
> >>
> >> In the previous behaviour only HE IE in management frames are changed
> >> regarding MU-MIMO configurations and not in hardware. Adding push of
> >> MU-MIMO configurations to the hardware as well.
> >>
> >> This patch is dependant on mac80211 patchset:
> >> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D683=
322&state=3D%2A&archive=3Dboth
> >>
> >> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-=
1
> >>
> >> Co-developed-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> >> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> >> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>
> [...]
>
> >> @@ -5369,6 +5491,10 @@ static int ath11k_mac_copy_he_cap(struct ath11k=
 *ar,
> >>
> >>                 he_cap_elem->mac_cap_info[1] &=3D
> >>                         IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
> >> +               he_cap_elem->phy_cap_info[0] &=3D
> >> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MH=
Z_IN_5G;
> >> +               he_cap_elem->phy_cap_info[0] &=3D
> >> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLU=
S80_MHZ_IN_5G;
> >
> > This is causing a regression for us in OpenWrt at least on IPQ8074 but
> > probably on all ath11k-supported HW. Cause 80+80 and 160MHz support
> > bits are being cleared here so 160MHz is not being advertised after
> > this patch.
>
> Oh man, not good. Robert, should we revert this patchset entirely? Of
> course it would be better if Muna can submit quickly a fix, but I'm not
> going to wait for long.

I would prefer to see it get fixed, cause just removing the flag
removal gets 160MHz working,
but I am not sure about other flags as well.

Regards,
Robert
>
> The patchset is in wireless-next at the moment and the commits from the
> patchset are:
>
> a96f10422e74 wifi: ath11k: modify accessor macros to match index size
> 38dfe775d0ab wifi: ath11k: push MU-MIMO params from hostapd to hardware
> 8077c1bbbc28 wifi: ath11k: move HE MCS mapper to a separate function
> ebf82988f844 wifi: ath11k: generate rx and tx mcs maps for supported HE m=
cs
>
> > I fail to understand why are 80+80 and 160 MHz feature flags being clea=
red?
>
> Me neither. I missed that in my review.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
