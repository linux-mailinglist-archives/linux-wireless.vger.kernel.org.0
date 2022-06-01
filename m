Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1B53A2CA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbiFAKhB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 06:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352109AbiFAKfB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 06:35:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1F7CB42
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 03:34:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hh4so815541qtb.10
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jun 2022 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AX1aU92WNtfdOkIt5sxzsSkaDvk1+o93dreOm4oGYGk=;
        b=MpHJ6ZZ+VY6LYh2Tbdy+UL75aLbwI+CBqbg8hdrtFQNmpeG9/j1cgb79l8nkNg/oWZ
         S5P00PFcOTyEBHx3245sZsgKdLXx46LI328Xmw8Wc0jbr318yNAwgiRAJjCMuzi9UniD
         ysuUiaiseboWAV3ANBCCwvS2RDvPZqYV3mGkQ4ieNctvI4SBEE0cGuQezTDazDxa9r7n
         jFA9p9yFbLgD6p+PnSB65+clN+etJVe7BZTN4yDoJK6efgqPUqc396RNFmr8hX7njBJQ
         nSxYfFfx4+WTyDERQrLw96Ez4crrUu/2IyekAhWxd7nPB545KMGy8oqheoTF/h/OUQJ8
         T+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AX1aU92WNtfdOkIt5sxzsSkaDvk1+o93dreOm4oGYGk=;
        b=Kg8h1AJeXvLTsm5RIbEYCsSUcXIhLhgr3iX0Rxo+69efhbGVHLZPApTraFUVJE1aHi
         PNN6vg1ZzIuMTBBlS+/QEOrcOu3nQquEkVqr9zDZr83PXzPTGH8CJErTbYaSONSoPuy3
         1j8Jx211KWEH1WSkxCEctnuZSEycnbKIo+bv8JylzUaflkUtPQIDp2T2iG0DU/nNoP1V
         TfebGNQkQVFmcMYwleUyffuRNNSiZ65culPSz8djCVFupy5Ll/+tcZfapiwWxDMdiFRy
         chshzJJ5amkrrHKxDjcUcpLdf3e6asY/QWcxK6Q7rosEbwqlq1b0ZbZeCthKGcslu0VA
         7qzw==
X-Gm-Message-State: AOAM532P1c0/i/TeNqhs3fBIok1h09L8sUwMuzx36I6GV8IZIUYdDvHd
        tw5nj/LKseKF7xDLhydTvgNazwAeK8Y7d5O9kRvEGId54Us=
X-Google-Smtp-Source: ABdhPJyxtzlXZmOy66yFMqw6hawHCM74kzO8BgZgrPRFgx/TQPeT2PGwJX08xXjicyp+Dem9JsTuXFxZ0el5Ho78CrA=
X-Received: by 2002:ac8:5990:0:b0:304:c8d6:3147 with SMTP id
 e16-20020ac85990000000b00304c8d63147mr419347qte.370.1654079696073; Wed, 01
 Jun 2022 03:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR02MB4567E377F14F272DFF48907A92FA9@BYAPR02MB4567.namprd02.prod.outlook.com>
 <332e62e5-b04d-3a6a-38fe-924d056bf0f8@linaro.org> <87k0b8fnpj.fsf@kernel.org>
 <CAA8EJpr3Uxa-Tif5TyHfXL03j1--vrAb+DgT=0DY8KDpvHPjeQ@mail.gmail.com> <87r148opbm.fsf@kernel.org>
In-Reply-To: <87r148opbm.fsf@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Jun 2022 13:34:44 +0300
Message-ID: <CAA8EJpqj57v6yetGLHHi-xZocsGfAyPfdHZFV4wZ+Cpz2XaRvg@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20220423
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 1 Jun 2022 at 09:44, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > On Fri, 29 Apr 2022 at 08:44, Kalle Valo <kvalo@kernel.org> wrote:
> >>
> >> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> >>
> >> > Hi Kalle,
> >> >
> >> > On 27/04/2022 11:32, Kalle Valo wrote:
> >> >> Add support for QCN9074 and WCN6750 ath11k hardware families. Also
> >> >> there are several updates to existing firmwares and board files for both ath10k
> >> >> and ath11k.
> >> >>
> >> >> Please let me know if there are any problems.
> >> >
> >> > I noticed that this pull request doesn't include the board file for
> >> > WCN3990. Is there any issue with it that we can solve on our side?
> >>
> >> Oh, sorry about that. I guess this is just a bug in my scripts, I'll
> >> include the wcn3990 board file in the next pull request.
> >
> > Thank you! No problem, it was more of a question if we missed something.
>
> It was pulled now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=86f0c5642c4c06583fccce8e03ca400300330cba
>
> Do let me know if there's anything missing or wrong.

The board file looks fine to me. Thanks a lot!

-- 
With best wishes
Dmitry
