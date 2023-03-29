Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5B6CF117
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 19:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjC2RbK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjC2RbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 13:31:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF05D55BF
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 10:31:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id iw3so15637004plb.6
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680111063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqe69HFaNOq0YEfaCMdU5RQwjzTAJ7NCS+lXWX7C0Ow=;
        b=fgV5bK6G/cChCqRL0ySpa7zJJ9FDHzXIRpZxhAWLeRt4oe1LyI3mjsxmTi9MbBzNUK
         /5o76XCn10r/hVBTAH6KOa8fTo+MnBY/825H+39jeY2lfCAWCSWvyQuYL2NIh2ptHEgv
         +TSHyGN53kx2k0sUyyuwlgTlFMtpNKzu4GMULdZ39A9R+MzVGtRQIr5JtEgQ9vAdMHGm
         YihrokQyrIniFCP5M+DY0k2ttjnEFLDkx51rwB/tbykEdBvhalpjYIvGy8rIpADFU5AP
         DqPgp5dXbQxhEaGO7DYB7O6Utzfpr9Rp7f+3F4g7VaHJn19wYvEOR9lNxGNVSJxOZVrQ
         sSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iqe69HFaNOq0YEfaCMdU5RQwjzTAJ7NCS+lXWX7C0Ow=;
        b=UwQl1UfgHkHAWpsSZiMp9s/nX4eTs3lJ/wjLdeCw+9cE3rmnXrF2jXTlheMHtAbNSP
         N9Kyor/uCMzmS0TFwAnOhWZhUN7n6pTW0T9+v3zP0AQbyG3hjxAv62mLTK5CmOKfPOsz
         klvu267by/r7xyPtaMwktpMnZ1pKDvXyBMl4WzZqpycoV/LL7v2pKdEoQSSq0uHc0wVh
         DNyf/ureKJDHr21TUyPjDFvx1wZsVhCe04uTc7gZcU4Q7zmaYvZoLpotOt6BU+kIuJAE
         5hgMNIprZ19zA6DZCNVhL4DeVS2G4SJPYVLmzu1ArugwqsNoc8WTgK5bzqHA8hVYIHj+
         4CdQ==
X-Gm-Message-State: AAQBX9cB0uPFiQ/zwlloogSWCVYyYvXf6CA//ZpohCASkD5JJF7zP+Z8
        AEBX4YIs27knLepDmBGcMTXUqge8IdjOlMtZyV9oEg==
X-Google-Smtp-Source: AKy350atJjB3NfefAlEQAjsESXx1pyD/dLXWZpEQb2TSowSlCN33+CyqApNwgBkzAUaCdf674rfh4BihgkQ7p8EOYJ0=
X-Received: by 2002:a17:902:c3c3:b0:1a0:7630:8ef4 with SMTP id
 j3-20020a170902c3c300b001a076308ef4mr7299419plj.2.1680111063096; Wed, 29 Mar
 2023 10:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-iwlwifi-ptp-avoid-64-bit-div-v1-1-ad8db8d66bc2@kernel.org>
 <9058a032c177e9b04adbf944ad34c5ed8090d9d6.camel@sipsolutions.net>
In-Reply-To: <9058a032c177e9b04adbf944ad34c5ed8090d9d6.camel@sipsolutions.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Mar 2023 10:30:51 -0700
Message-ID: <CAKwvOdnQ9feXGYV2CUyVwg-FNAOmb4HBmDxMg243v28DzSfLuA@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: iwlwifi: mvm: Avoid 64-bit division
 in iwl_mvm_get_crosstimestamp_fw()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Nathan Chancellor <nathan@kernel.org>, gregory.greenman@intel.com,
        kvalo@kernel.org, trix@redhat.com, avraham.stern@intel.com,
        krishnanand.prabhu@intel.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        "kernelci.org bot" <bot@kernelci.org>,
        Craig Topper <craig.topper@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 29, 2023 at 10:20=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Wed, 2023-03-29 at 10:05 -0700, Nathan Chancellor wrote:
> >
> > GCC has optimizations for division by a constant that clang does not
> > implement, so this issue is not visible when building with GCC.
>
> Huh yeah, we did 32-bit builds with gcc ...

Right, GCC is better about turning division by double-word constant
into multiplication by reciprocal. Craig has been improving LLVM, but
it seems that some divisors still aren't supported (in this case 100).

>
> > Using div_u64() would resolve this issue, but Arnd points out that this
> > can be quite expensive and the timestamp is being read at nanosecond
> > granularity.
>
> Doesn't matter though, all the calculations are based on just the
> command response from the firmware, which (tries to) take it in a
> synchronised fashion.
>
> So taking more time here would be fine, as far as I can tell.

div_u64() it is then.

>
> > Nick pointed out that the result of this division is being
> > stored to a 32-bit type anyways, so truncate gp2_10ns first then do the
> > division, which elides the need for libcalls.
>
> That loses ~7 top bits though, no? I'd be more worried about that, than
> the time div_u64() takes.

The result is still stored in a u32; there is a loss of precision
regardless of use of div_u64 or open coded binary operator /.  So is
the loss of precision before the division as tolerable as after the
division?

--=20
Thanks,
~Nick Desaulniers
