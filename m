Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206879E3AA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjIMJ3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIMJ3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:29:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26954DF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:29:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7e9d849bdfso5778654276.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694597351; x=1695202151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+MFrQb049CZGpD5Zjrkdb/5Mi4AniQ9UI6VaAP+DKI=;
        b=nqobbugR0J71jJav4XvddP5C8S7awiekldJ/jzjRx4AKyl50wOWNzjflUI14AUFAIO
         NM36yEiaa1NpqZ+DcgBUF0JAjxW/OPyeSs6YtcchwUXDg7en7kZhoJIEqE9JhA4+yEwY
         ZxtDc+u8gZEO2lymribJBvOBKBLdcj+x07jWQbbblHp6mZVbwgcyMJRK0MERUMMVc29F
         f837xFMA4HZhlzc7VaLYVOOsRwkLo97BDf1mvnQkmfGb5BF2TwneSYG65etoN9hECm8R
         p1YjFYcl8Ag+7LRrnCCNNKXa2flTdYMII8ejoinlsqUS79+UxZ7GlriQfTxtvEMYkneH
         ekyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597351; x=1695202151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+MFrQb049CZGpD5Zjrkdb/5Mi4AniQ9UI6VaAP+DKI=;
        b=ow29o/c0UqNAzwCbQHF7aASIhTEDboOWCkl4ZVtcp8K5ogLp/LICLSBmflpPqi+en7
         +88nRIey/MrOTh3Jn1FqCSPaN8oHsqH180WcZ65SJyM23+bu4acStICoaUnpm/c9POZm
         tCmSjvC1Ac9KDYSO5ptgw/EF91e16BciOjkkjzGstRJiyE2xe5gi8lJqua6sPnRMiPN6
         lWD1YEDDg4tRx6uEhDnwOv/enkEmM4nJNQp/FI5RmyccoDrcVLcQeiB0G6bI3sSIL+1i
         2PGtRedte3HHd2+1JTVptEBb1KndlEFQxCWh9xoE2kuGqMbhFbXpXkx7ifSxpAnAWlOR
         shQw==
X-Gm-Message-State: AOJu0YyIcnmuqF3qRdt4w7pidTJMz9AUZENTTqbVan7loR24Avu0CuuB
        GQ1oAce6FpKT4ZWIScr5RaztDkgnY81EFmwiYprW7Q==
X-Google-Smtp-Source: AGHT+IGVYATgybqJdQWccuvKju5FLYK1upeu8sUATvMnSclQgqyxQgb2vhtl1TPyVBSLk/BEp3cBzJWvCfm+nCEdZeA=
X-Received: by 2002:a5b:982:0:b0:d78:341d:e475 with SMTP id
 c2-20020a5b0982000000b00d78341de475mr1702968ybq.44.1694597351319; Wed, 13 Sep
 2023 02:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
In-Reply-To: <20230913065421.12615-1-juerg.haefliger@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 11:28:59 +0200
Message-ID: <CACRpkdaJd9PA96ryKnJbxotT_+sH-qKgOq=xJDQdXXwTvYBC0w@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible arrays
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        marcan@marcan.st, keescook@chromium.org, gustavoars@kernel.org,
        hdegoede@redhat.com, ryohei.kondo@cypress.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 13, 2023 at 8:54=E2=80=AFAM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:

> Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> 'element' and 'channel_list' will trigger warnings, so make them proper
> flexible arrays.
>
> False positive warnings were:
>
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm8=
0211/brcmfmac/cfg80211.c:6984:20
>   index 1 is out of range for type '__le32 [1]'
>
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm8=
0211/brcmfmac/cfg80211.c:1126:27
>   index 1 is out of range for type '__le16 [1]'
>
> for these lines of code:
>
>   6884  ch.chspec =3D (u16)le32_to_cpu(list->element[i]);
>
>   1126  params_le->channel_list[i] =3D cpu_to_le16(chanspec);
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Obviously the right solution, thanks for looking into this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
