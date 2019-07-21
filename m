Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097B36F391
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2019 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfGUNwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jul 2019 09:52:45 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:46720 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfGUNwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jul 2019 09:52:45 -0400
Received: by mail-io1-f44.google.com with SMTP id i10so68152079iol.13
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jul 2019 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oSsPXjU4E+7kroOz7eAl9Yi09u3qPnsCN+/HkaUoSjw=;
        b=qiIEbAZjaOV1bi9IT0zKmkblfdtTZmf6nPW9cb0sXklWiKCJYZIm6vT92Hp0wqlqXC
         mWk0qGU+zxxFrSfmYC/VqF+7RgVP7Tf3CJVLCMB/HR1GXMHHH0i4s8x1zz1T2BnmfGUs
         TgD+PgX21S2SyBGHXoLPA8khJGqtmZvWIhdM3T5+I07lcBx+q7tAceEfA3t7oJRmJv1i
         khgJhA8iFDXitJ87lCC7ZJV1P24FYBwGCRoBV5xcNUhkb7eYyJ8yd1vd2eENujoegkpe
         UzP+qk5a5LSzdHzSrCql+/ebhSBgj6Mc77D6Gf13kQ0d0wnmy3yoWvdedV9B3RZdLbxE
         4Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oSsPXjU4E+7kroOz7eAl9Yi09u3qPnsCN+/HkaUoSjw=;
        b=tMGu2CoG2XBhdzGKo1l0julEL+uZCSv5u/QnYPIcOgFr3VK7FdRX0mPvnhgrKaP7e/
         jdkg3Nr4m23yWf49fHDkZLJfCJpCw+z/zxMMxPpySDzpHxQwjtn7JvwmFGSFGlLVKZhw
         kTZgtHmVSic/M5wotLtlXcrrODTi9ujvTG6C0VAGI/MJ3s5vZ+Jlmsuw+qmFSa5AMzoG
         yB1N0cTfX/09gYZSgWgdU7wDSg/nk5O8bjC5e5vwwGWCcJ6EFetWBmPBaDTmUkQ+mPLY
         mOw90XzFObm4+gNtIX+P+dd7CQ90O76JnDz0OTPU+N1+tDQk9KQbRdWS4BSWr1HoUhWy
         yRqA==
X-Gm-Message-State: APjAAAVkilfcIj/sko6PeMvzy3speYFAG6sTMIy/8UcQ0HvODazB0zj0
        dYkKmp4rtz7NxLtPzBKdondLKETRgMeILzg+DM+e5ghM
X-Google-Smtp-Source: APXvYqxoRTl8GNFUL2ib9UazTIaszPrP98sFwAysjOeVMyHokqrf4Kztwxrnb00sByS0DOa+EeIapU2VKVuOGkL4kCo=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr32390574iof.162.1563717163970;
 Sun, 21 Jul 2019 06:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfDRXhVQvJYAiacyMx0sGqrh6L7KR606FaBdh4nhznsKY0TMg@mail.gmail.com>
In-Reply-To: <CAKfDRXhVQvJYAiacyMx0sGqrh6L7KR606FaBdh4nhznsKY0TMg@mail.gmail.com>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Sun, 21 Jul 2019 15:52:32 +0200
Message-ID: <CAKfDRXhTEAaEjyqMe3qzjJi41SK_N_MDsaDt=hRH+CzChJss=A@mail.gmail.com>
Subject: Re: Problems loading ath9k (ar93xx) calibration data
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello again,

On Sun, Jul 21, 2019 at 3:10 PM Kristian Evensen
<kristian.evensen@gmail.com> wrote:
> Considering that the next byte has the value 0x1, I suspect the issue
> might be related to endianess. However, I haven't found a way to
> trigger an endianess-conversion when the calibration data is read for
> file. Is there something I am missing or is this not supported?
>
> Could endianess be an explanation for the error I am seeing, or are
> there other things in the calibration data the looks like it could
> cause problems as well?

I took a second look at the ath9k-driver and see that 0x1 is the value
of AR5416_OPFLAGS_11A, which sets the CAP_5GHz flag. My card is only
2.4 GHz, so then I guess the endianess-theory was wrong.

BR,
Kristian
