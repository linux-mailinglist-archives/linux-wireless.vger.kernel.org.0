Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1290728BF75
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404165AbgJLSNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbgJLSNK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 14:13:10 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA48CC0613D0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Oct 2020 11:13:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b1so15911296lfp.11
        for <linux-wireless@vger.kernel.org>; Mon, 12 Oct 2020 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OI+BNknfnSWOTefxKU58+szxy3gvGdhtzbtnFjkVkA=;
        b=LGqqXTahMXpwQe6jJHxx5TFzmKQH98FQFA5mijUS7/19U6PQdk8NO+IW3emfAT9Ixx
         D0IijAQhAzwuIZqwC3N/tZVqA9e+86WrzN85xCFd1QfOzZ0PNUDEMIAAL3W8sFsaqIdX
         C+v9n/2cutamPPZ1r7dKcUAQtqC+NlozSu7UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OI+BNknfnSWOTefxKU58+szxy3gvGdhtzbtnFjkVkA=;
        b=JU5bZSzZeqtJ8E8dJpIy6uxcaAVTSM/DGQwEEyx+9quxUqCMw2eK/f0i48DD6E4eRb
         ky+QVf3qLVibNKwJQObR28pcqD+oWSTamD351hfCJgdO/vqic+rgDaUCgAYs74SIq0b3
         dMMq4l9iLgipky/Nl20GjxlGivKO3zCwQcfu2oNaN4AqtjNi206SAvms5s//C9331QBM
         LZbesiW2EFiFX64FRf+WXAtJN5h+v276seOUiH7zfzWx74vS8IRN7/MyTuTgNBQCOu1q
         7SbokJ5ogQyjAhmmXszSpLzJgoHjiLbDWIxtAVbch8CKaRXanniFF4t/jQe2XPBcJJdC
         FJdw==
X-Gm-Message-State: AOAM531WmWAao5kEGXoi5Gh92QoUvjHoMzaoNEEytJH22jgrQZY2FUIh
        D1qS62MLOW8YMYdTAyV4yt8ks40Y/R5MRQ==
X-Google-Smtp-Source: ABdhPJzXLVEsUSj7IhGxA0+mf0L+6GijG5L79BKMYqlNGjXAcJxgIRADLiQNJ38cSC+X5YzQH788ow==
X-Received: by 2002:a19:1c7:: with SMTP id 190mr7812870lfb.516.1602526387865;
        Mon, 12 Oct 2020 11:13:07 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t1sm3193726lfl.289.2020.10.12.11.13.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 11:13:06 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id p15so17792752ljj.8
        for <linux-wireless@vger.kernel.org>; Mon, 12 Oct 2020 11:13:06 -0700 (PDT)
X-Received: by 2002:a2e:88c2:: with SMTP id a2mr8373807ljk.438.1602526386413;
 Mon, 12 Oct 2020 11:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
In-Reply-To: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 12 Oct 2020 11:12:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
Message-ID: <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     David Rubio <david.alejandro.rubio@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Oct 11, 2020 at 9:13 AM David Rubio
<david.alejandro.rubio@gmail.com> wrote:
> Oct 11 12:20:39 youmu kernel: rtw_8821ce 0000:02:00.0: rfe 2 isn't supported

I'm not sure anything changed since the last time this came up:

https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82@realtek.com/

I think this needs somebody from Realtek to look, or else ignore the
objections and merge the sub-optimal (trivial) patch. I'm not sure of
the ramifications of doing the latter.

Brian
