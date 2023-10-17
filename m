Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307247CC9ED
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjJQR3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjJQR3a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 13:29:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8776C98
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 10:29:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so10394056a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697563766; x=1698168566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVjPvtK7dBS1HEVTVRVRRx6/uZvdlxYNu1++CMU25iQ=;
        b=KxgD2+/vY/Y3n88Q6cLm8ZH4KYfWGUiq9uXOxPxYjJKvUBWAbgAqS7uwwdFShf3ZI9
         Du+Tiblgk3pi8+wEuIkcbAStfd1Gm536twbgQtxTZmIq2SUZJ84eJgq7s4ghamrLzve6
         5/O0JQU12d+ofBgjQ0fyfu1PGVoQHvsGtTu++bQVRPwOHgWqlZ8mFjZSZSYvzgm//MCc
         /ys/5aJdURpV2l8GrKABJw8o8bIM7n09ABe/1wvHFH5pgODJaAvR8g7MO+DBrJ9lOgoJ
         4KbWlAj3EgqhQ0n28FEzjCNICOP8wFjfaXJND/DxwliduZ6f4JB2zB3Ia+OJVZUmZyf3
         yo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563766; x=1698168566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVjPvtK7dBS1HEVTVRVRRx6/uZvdlxYNu1++CMU25iQ=;
        b=Vl1NE2PEkbEalGG5jxOg1v+2rb+4VaE5CGnCnXq4QVGW5B0LnC9opD2K/uHYLEYU4r
         dY4eqZDUflJeySPax213PYpXwcMrec+jslcbQXafCwFzyruH8HyCyg/9knW8+f1phyLV
         Z+4+ov2mli+iB+7Wa2hq+GnFtd4WYsc/7SrL0AzXdZx6oOApoTgYeVj5bGARYZD/U5o3
         seEwRk2YM18YqGm55nFP8TXL6AjfxEC2mb3F/+LNPa8aM2Xs/CcrmcXqZvRqm2jCyw6h
         A5zRJnRHnDG8Rizgbg8VZT819gJTtVB+KFcMd8yOYHXizw5wSRTYuUVDHy/Q3jZ+7bX/
         ZRDg==
X-Gm-Message-State: AOJu0Yy9qHAOcl5Ked+G7YH4IWlD9haG0gmEJ5a7UWndpWwhTr81irYp
        1BUGekdoxGk4vaoCbfAaQnDrsQYAbjLdQ335lN5T8g==
X-Google-Smtp-Source: AGHT+IGrgeOgDqO50bp1dx1lJcdPZVSnhShz2o9OXsMWdY9GkfkcS0pbU/y2lq9RHQQbRyyoxZ95LOoT9iFOrqLav+M=
X-Received: by 2002:a50:cd82:0:b0:53d:a17a:7576 with SMTP id
 p2-20020a50cd82000000b0053da17a7576mr2202416edi.8.1697563765976; Tue, 17 Oct
 2023 10:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com>
 <CA+8PC_cZbchz-i0Wfhr1rE5M-xqUVdQZce94TowU=yqOynDBKg@mail.gmail.com> <875y352nrg.fsf@kernel.org>
In-Reply-To: <875y352nrg.fsf@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 17 Oct 2023 10:29:14 -0700
Message-ID: <CAFhGd8q17rgScrsaBvJmiwFUW=KAPTgD_BHQeb7YiFBuiDXE0g@mail.gmail.com>
Subject: Re: [PATCH v2] brcmfmac: replace deprecated strncpy
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 17, 2023 at 9:54=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Franky Lin <franky.lin@broadcom.com> writes:
>
> >  Hi Justin,
> >
> > On Mon, Oct 16, 2023 at 3:14=E2=80=AFPM Justin Stitt <justinstitt@googl=
e.com> wrote:
> >>
> >> strncpy() is deprecated for use on NUL-terminated destination strings
> >> [1] and as such we should prefer more robust and less ambiguous string
> >> interfaces.
> >>
> >> This patch replaces multiple strncpy uses. For easier reading, I'll li=
st
> >> each destination buffer and mention whether it requires either
> >> NUL-termination or NUL-padding.
> >
> > Kudos to the detailed analysis of each instance. One thing I can think
> > of to make this better is to split it into smaller patches so if any
> > regression is observed, only the specific code causing it needs to be
> > reverted. Maybe instance 2, 3, 4 can be handled in one patch since
> > they are touching the country code in one file. The other instances
> > each can be an individual patch.
> >
> > The "brcmfmac" in the title is not accurate. The change touches both
> > brcmfmac and brcmsmac. So "brcm80211" would be more appropriate.
>
> Please also add "wifi:" to the title, see the wiki link below for more
> info.

Sure thing :)

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

Thanks
Justin
