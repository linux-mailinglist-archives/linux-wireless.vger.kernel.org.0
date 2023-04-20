Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082186E9EC7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 00:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjDTW1c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 18:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjDTW1a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 18:27:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC312D6B
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 15:27:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94ed7e49541so114203766b.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682029647; x=1684621647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o31TJ5tZoCsBlp2o0xbjnltm9BzQDN1XsD84HTTJdiE=;
        b=gH17N6HjtfHWN3S390MXhVbuk2MCZdw26bMFlZMahYUxKtClUThvAXVIQk2GO2KoZm
         i6rlEitC6IkiLv4bwWCBKuFIbECj31pSCKCIKDBmVs244PYRLlSQLNak4h6sGf3dmlIL
         tYq9DJ/NsHoBvxK+xJtlJvqmfn8YVQWucFV4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029647; x=1684621647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o31TJ5tZoCsBlp2o0xbjnltm9BzQDN1XsD84HTTJdiE=;
        b=alcwk9CGkGPsR014frzUwczoJ8a8TbbzHvPjO6cggOWBh/Sv8OjCm0yPnxet/kZc8U
         HNVBVO/0GEZzvUF4/mO1oVO51xC8oz5cLZfDkgQ8AEPoZ7ktSCnCCHZWXTttnKxPdk1y
         iqlmZYatMDKvEMPDeirDBqUiFZyGSlRsIlwPd98/Gz8/LBjg24x0DQfsVS4Ziin6bVc+
         87hHlsRfr02mXVuFNDdStMaqDeWGrULE6XAjke7rrFOkwV/fciY6gY6MCygbJ+XTHSBf
         JFDDwQUXkg4C67ZsnFL5XvrguOfIAK98M6DZs5FSNVIjMT7uC59MLwUGCnNRYakqKIKX
         ZSHQ==
X-Gm-Message-State: AAQBX9cFeUWAsTA3DDtitVR9xkVA78DeSGBj2FznSLxzlHZDokrvqdAH
        wahx5JFl/9U1FIhR7ITpZExXrGlh5juYuvYD9ECvvQ==
X-Google-Smtp-Source: AKy350bC/3GeoECR/5IRcT/07jWUYp+4OdL0DdQXJaz7PKngXOWTVsh/or24OebOCMKivU+u0OsKrw==
X-Received: by 2002:a17:906:b2d7:b0:94a:5a9e:9da0 with SMTP id cf23-20020a170906b2d700b0094a5a9e9da0mr301967ejb.77.1682029646852;
        Thu, 20 Apr 2023 15:27:26 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907207800b00882f9130eafsm1225958ejb.26.2023.04.20.15.27.26
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:27:26 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso1383688a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 15:27:26 -0700 (PDT)
X-Received: by 2002:aa7:cb59:0:b0:504:aeb5:89c3 with SMTP id
 w25-20020aa7cb59000000b00504aeb589c3mr2953453edt.5.1682029645826; Thu, 20 Apr
 2023 15:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230413214118.153781-1-toke@toke.dk> <87zg72s1jz.fsf@toke.dk>
In-Reply-To: <87zg72s1jz.fsf@toke.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Apr 2023 15:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com>
Message-ID: <CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com>
Subject: Re: One-off regression fix for 6.3 [was: Re: [PATCH] wifi: ath9k:
 Don't mark channelmap stack variable read-only in ath9k_mci_update_wlan_channels()]
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 20, 2023 at 2:09=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> So, with a bit of prodding from Thorsten, I'm writing this to ask you if
> you'd be willing to pull this patch directly from the mailing list as a
> one-off? It's a fairly small patch, and since it's a (partial) revert
> the risk of it being the cause of new regressions should be fairly
> small.

Sure. I'm always open to direct fixes when there is no controversy
about the fix. No problem. I still happily deal with individual
patches.

And yes, I do consider "regression in an earlier release" to be a
regression that needs fixing.

There's obviously a time limit: if that "regression in an earlier
release" was a year or more ago, and just took forever for people to
notice, and it had semantic changes that now mean that fixing the
regression could cause a _new_ regression, then that can cause me to
go "Oh, now the new semantics are what we have to live with".

But something like this, where the regression was in the previous
release and it's just a clear fix with no semantic subtlety, I
consider to be just a regular regression that should be expedited -
partly to make it into stable, and partly to avoid having to put the
fix into _another_ stable kernel..

             Linus
