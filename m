Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F1751DA5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjGMJqJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjGMJpw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 05:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F02D42
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689241429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvl5g0I3V6gIRknYTzW98aMpTqLnXVAL5Iexw4g15cg=;
        b=eu/WssOYo4QhchEutCqd4dgWdzN4Y2SNii/n0GTP7rgXSNEs9W+G/rlH+V6a8a00pJrV/2
        wIoetnxGirdAJE3j+gND514G3kpyqz9MSVfVcDvLklTMvXydvABH+ZGr3gPKr38wBP43kQ
        kbuqWiR4ipKxOU1s/kr4tLGVdfzJfqc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-LhtwI8GtMsW1c4JOcYtSPg-1; Thu, 13 Jul 2023 05:43:48 -0400
X-MC-Unique: LhtwI8GtMsW1c4JOcYtSPg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-767ca6391aeso12738385a.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 02:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241427; x=1691833427;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvl5g0I3V6gIRknYTzW98aMpTqLnXVAL5Iexw4g15cg=;
        b=QuNXLRi5PhkxX0hfFUOCMRrBY4uhIya/MKP4hsOmNPba3QHoZkL2Sv3fASR+VwSEgy
         YO4HPwBv/xc1eKWlIAmukQ7Hy+aWeH+e1bIJEDreLESfU0evzmvfNy/f5Fqi/k/dsb8o
         jTk1tpS073d4XwhjNpJiEdPp6GS1CYOaFUjd8ECt0mYC6HrLOdxrXO7ZasXdZMdbhxcd
         ALqRjJJHGhUftFToqEk9XrKh/B6jzhp1gqQLJFH1eK7iIFJ5Hxy7N6S4FmSDO1Cc3Y1Z
         vL3efMtn/5sJJYejGFqfS/ym5qqUKD4tv+KiojtlA51GlrSSBN/Ak2NjN6QkBLTHjVur
         c6lA==
X-Gm-Message-State: ABy/qLbP1SLPd81K1AXinJ21Wn33lN82dkaGJ2UVTY8wVH+rRaeBzKdl
        mHM0QWxayiOij2NRx3FnA6IVBCvEE/1ctw9N+TX0Eua8ZlTap3jK7LcZRav416EInQEHvDeFcUN
        zr9Db7YjDc+r7hL4NYH8MiOIROKQ=
X-Received: by 2002:a05:620a:471e:b0:767:13cd:e17d with SMTP id bs30-20020a05620a471e00b0076713cde17dmr1160192qkb.3.1689241427620;
        Thu, 13 Jul 2023 02:43:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHPetQa7l02yWfkaCDia2vEYnlURmsCxd3pHlY3W0FYEdJ+SRTXZNHsUrEF9ekvUKtT2nPDtg==
X-Received: by 2002:a05:620a:471e:b0:767:13cd:e17d with SMTP id bs30-20020a05620a471e00b0076713cde17dmr1160182qkb.3.1689241427405;
        Thu, 13 Jul 2023 02:43:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id g5-20020a37e205000000b00767cee76155sm2743794qki.55.2023.07.13.02.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:43:47 -0700 (PDT)
Message-ID: <54b3fb4d5a58d123826a7f0c8442379dc071dfcc.camel@redhat.com>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A?= [PATCH net v1] ath6kl:Fix
 error checking for debugfs_create_dir()
From:   Paolo Abeni <pabeni@redhat.com>
To:     =?UTF-8?Q?=E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=E5=BA=95=E5=B1=82?=
         =?UTF-8?Q?=E6=8A=80=E6=9C=AF=E9=83=A8?= <machel@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Date:   Thu, 13 Jul 2023 11:43:44 +0200
In-Reply-To: <SG2PR06MB374387D043556FE8AEAA6ED9BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230713040518.13734-1-machel@vivo.com>
         <a9dc336793322d3525280e4f30b2acbd0c88bbf8.camel@redhat.com>
         <SG2PR06MB374387D043556FE8AEAA6ED9BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-07-13 at 09:31 +0000, =E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=E5=
=BA=95=E5=B1=82=E6=8A=80=E6=9C=AF=E9=83=A8 wrote:
> Thank you for pointing out, I will pay attention to it in the future.
> In addition, do I need to modify this patch and submit it again?

Yes, a v2 is needed.=20

There are a few patches on this same topic, and I read only now what
Simon noted:

https://lore.kernel.org/linux-wireless/ZG8YY%2Fr8BLCzw93q@corigine.com/

so, the current code is likely not really buggy, and a possible cleanup
patch (such patch would _not_ be a fix) could simply remove the check
altogether.

Cheers,

Paolo

