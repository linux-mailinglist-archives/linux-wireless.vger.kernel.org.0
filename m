Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1D649BAB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 11:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiLLKIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 05:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiLLKIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 05:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715B2E8
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 02:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670839633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGXQSPHedGuszQET1W/i2vDSg7R0rzEkGl03y527D0E=;
        b=JDERSILGDKXqfF9mU2m7jvTDuJYNwD3ZLlAnXAzIKrlcuUSOAoXg9kM6olP/lKpTC/YoYY
        64JThqLgDHlyyNpfB3HQhB9sOtwGUfvdVOxl8+GTztJCD2KdFVTVU5om9Fgo+61GozPrQd
        WYCcy5kLBsM4tIh610gj/pZ6CwwQHT0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-MRS1TjqPOlKrCrTvhp3TEQ-1; Mon, 12 Dec 2022 05:07:12 -0500
X-MC-Unique: MRS1TjqPOlKrCrTvhp3TEQ-1
Received: by mail-qv1-f69.google.com with SMTP id og17-20020a056214429100b004c6ae186493so11251614qvb.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 02:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGXQSPHedGuszQET1W/i2vDSg7R0rzEkGl03y527D0E=;
        b=MUPK3ueAb5isqnjQYAJ492YImG3rEsI075zcs4vRi6qnrkgMYOEq/GDYlPIfQDmkvJ
         eHIpMZTAaNptlti5mFlZFBzlegl+1/v/zmq1rNTyny1gHZl4v4OjuMcvKQ0HJWI2Orjv
         Wouq938XJh28Hao8CT+AOT1/XtnVpi+0TFWVC2nGVZ2j6Np1XXO02jQqnezAsH+2ZDAM
         R3eOwRSTQS4aMSIgWQj7KJrwpoxpi3+3LEYiE42wPehb4GnRQEZscP7eyYhJUeJgg5Zn
         144EA0UBdWbxASv/Af2Lvw8kZyK90WfipMPKZEW+1/GhgyHHJsXYZZNB5WdJ3JpxHpSr
         nXPg==
X-Gm-Message-State: ANoB5plvRI3rHprQx3sdTCIG8GEWATgFkGfdKEvKjqwjO0//756VbfTl
        Y3thMuT3ExLtHwj3yX12h8FJ1bPZPI8RrSwOPaM9KKmt2T0VlSnLxva/qNFVpdkv5xd37MBv0Le
        nWdEXxafk87eg1kidAfNrNWnxL/5MF9twLZ2MQvgXPAY=
X-Received: by 2002:a05:620a:12f1:b0:6ff:aaca:3c2f with SMTP id f17-20020a05620a12f100b006ffaaca3c2fmr13878qkl.635.1670839631795;
        Mon, 12 Dec 2022 02:07:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7kYzmPZTPlUVlBdzjQYjc9aqulPgQXBB3rVsB44v/UqrPZRZur/Zbp7Ms5mj0yDY19rs0tmlAFueFhfAigk+Y=
X-Received: by 2002:a05:620a:12f1:b0:6ff:aaca:3c2f with SMTP id
 f17-20020a05620a12f100b006ffaaca3c2fmr13870qkl.635.1670839631569; Mon, 12 Dec
 2022 02:07:11 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
 <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
 <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
 <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
 <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com> <CACT4ouf8vDzhXkFAOh-LAbi1GKYp66YNMG_5VrkW0CqnxVBt0g@mail.gmail.com>
In-Reply-To: <CACT4ouf8vDzhXkFAOh-LAbi1GKYp66YNMG_5VrkW0CqnxVBt0g@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 12 Dec 2022 11:06:59 +0100
Message-ID: <CACT4oufQsqHGp6bah2c4+jPn2wG1oZqY=UKa_TmPx=F6Lxng8Q@mail.gmail.com>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 21, 2022 at 5:35 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>=
 wrote:
>
> On Mon, Nov 21, 2022 at 12:08 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.c=
om> wrote:
> > > the fw 74 seems to be a different issue - could you post more info ab=
out
> > > separately?
>
> This was my fault: I was checking many different things, and I checked
> this with an outdated kernel. With latest wireless tree and fw-74 it
> works fine, both with the patch from this thread and without it. Sorry
> for the noise.
>
> So I will wait  for this patch to be posted so I can backport it to
> RHEL, but using fw-74 also fixes the issue, as you said.

Hi Johannes, following with this: will anyone from Intel post this
patch? I can do it on your behalf, but I thought you'd prefer to do it
yourself.

>
> Thanks
>
> --
> =C3=8D=C3=B1igo Huguet



--=20
=C3=8D=C3=B1igo Huguet

