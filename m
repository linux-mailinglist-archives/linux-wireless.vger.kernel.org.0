Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E187D4D507B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 18:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244401AbiCJR3J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 12:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiCJR3I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 12:29:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE8D4CA9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 09:28:06 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b8so5880787pjb.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 09:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TqsqHCoTEdqIo0vGj3llrDDd30YnzYqjLPG/pFLVFAk=;
        b=YjfYhI0xUjn6PIpT7EQTNQIQf+eWQB/MVfnReDuYwbFzJJZ4mMk7F0Rfb/Lubp5N9m
         zmnw7T/ud2rCq7Mi/i6LhVxJLsU6eCXR105kEj/MYP2gXO09pAdxUh/SzrRWCHwLv77d
         53vcp4crDD0ngx0glI6GnYYHzunzOnu9qV46Af9gtaogAsAeImpqaOGVRUqHnikWUUwc
         EhZhVaYXiilea1E1axhSHqLeX0CsY85jjNYUO5SyiGXQYSicrIj1+lDeJ+j6F+VhbAku
         NTkXDdIt1qXaGr7oCza5ZfWJKOhmJWJtBS5uhSGNmeSTZWPB5wpQprbJSdiQbAmE0Kte
         IfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TqsqHCoTEdqIo0vGj3llrDDd30YnzYqjLPG/pFLVFAk=;
        b=j3/EuoQJ8zcxYhMe1N61UffjjzgxdVWmZCgex3ITsmvS8AqBN9peQZGpfe2jzJsmum
         Kv3zjg7ACAvYhaYXIoQVR+34Ozd+LLrxm8xi2SFrDnkJKTkCvRjXKnzXF77CUUIOUf7K
         bokwybReKYgLOSw0x4Qt4Heb/d3u3iVJ5DpBzctkVnNV4aoPZAxk5/X9ZpyiuusWh6/T
         8xNczNqkzrmfou3hpmtWweqxB/cFSP9I1cb8+XZjy/y5Uc0UJ63ChTYAjc6JLop7QZL+
         AlKwVn58QqWqNPbwSbuDKrg2lJ2qyxHD0K3OnCFOi7cTqOwM9XEb20htJgZDvBytGc1N
         aiuQ==
X-Gm-Message-State: AOAM530F2CsICaVSG03XCFImBrA9Dpm2ERsszocBva52Pv/sEn/wi/zq
        AAKIAKLNaO28I9VgwYXZGLIDOU+2wXcDKTB2RsQ=
X-Google-Smtp-Source: ABdhPJxLFxCMg62rbSMJ/wKTW8BeJDRHrDTCtP4r8Z2l4UunDaqG8VH9C6/sL7in04b9TzdHLBl/uUhiU7n6Ie803as=
X-Received: by 2002:a17:90a:fb4e:b0:1bc:8227:edd9 with SMTP id
 iq14-20020a17090afb4e00b001bc8227edd9mr6135611pjb.56.1646933286007; Thu, 10
 Mar 2022 09:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20220309195759.1494-1-jelonek.jonas@gmail.com>
 <20220309195759.1494-2-jelonek.jonas@gmail.com> <bc398c48-b5b2-8037-a8c6-712b2e191202@candelatech.com>
 <8FC6B734-4D4A-4D91-A38E-DE36E415A36E@inet.tu-berlin.de> <22a43538-a2ad-f3a7-2909-5ef6a0d2ab27@candelatech.com>
In-Reply-To: <22a43538-a2ad-f3a7-2909-5ef6a0d2ab27@candelatech.com>
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
Date:   Thu, 10 Mar 2022 18:27:55 +0100
Message-ID: <CAChE-vRdnLgjGt3wDrzDC_eKWnX-wi_bWAiBYcheZrSMcfDoyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mac80211: extend current rate control tx status API
To:     Ben Greear <greearb@candelatech.com>
Cc:     =?UTF-8?B?VGhvbWFzIEjDvGhu?= <thomas@inet.tu-berlin.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
        johannes@sipsolutions.net
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

On 3/10/22 16:43 UTC, Ben Greear wrote:
> >
> > Certain 802.11a/g/n Atheros chips provide a 0,5dB tx-power step granula=
rity, while Mediatek 802.11ac chips have 1dB or even 3dB step width. So I w=
ould argue that a 1dB step width is a good compromise as the common value f=
or new tpc algorithms.
>
> If you use 0.5db units for that struct, then it will support anything wit=
h that granularity or higher.
> But, fine with me if you want to just have it be 1db units.
>
using 0.5db is more appropriate for the already existing chips that
support this granularity, and is more future-proof.
1db units may be easier to handle for the API and/or TPC algorithms
but again limits existing hardware capabilities.

> > The ath9k chips I have used so far support a minimum tx-power of -5dBm =
(=3D0,32mW), Mediatek has a min of 0dBm (=3D1mW)=E2=80=A6 so I would argue =
to use 0dBm  (=3D1mW) as common minimum tx-power value, as the any possible=
 spatial reuse gain happens from 0dBm up to max tx-power.
>
> If a chip supports setting to txpower to -5, then why not let the API sup=
port that?  Have The value -128
> be 'do not set', and anything else will mean 'try to set the chip to this=
 power or the nearest thing to it
> that the chip supports'.

I agree with that, having -128 as value for 'not set' or 'invalid'
would leave the negative dBm for chips that support this.
Whether the TPC then actually makes use of this should not be the
reason to use 0 as default.

To your previous question:
retry_count =3D 1 is intended to be a single tx, so naming the struct
member 'try_count' would be more appropriate?

Besides this, I will add proper documentation for this in the
following patch version to clarify the units and meanings.
