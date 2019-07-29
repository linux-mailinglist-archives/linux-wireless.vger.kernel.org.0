Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6570A792C5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfG2SFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 14:05:18 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:34819 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfG2SFS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 14:05:18 -0400
Received: by mail-io1-f44.google.com with SMTP id m24so122102516ioo.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RPPVB2DH745rVxScp1X25ORUy6JT/zQANY7+TCeop8c=;
        b=Q+dNRllC/n7wkb1XBomV72wMlPE1ODAyRm6SL0mEcufRk3AOQsIwQzqF17fX32s+sx
         Kd/hiMqPC2amh3yI+BFt0ypvDTHvWfqfQLoPZ2mtclL6n2k/NY4fRC7OI2UFlHb+58TM
         sOWllKLBTPq0IgFZT5kpAKBDxHSfx+x6jx7jV81Y3XX01ZVKsK3KWUXbnS398MjNu754
         jafjc3NQwjN+tD4n0GaqWrEwdsWp+u+fE6pSDianKJK1QeunW2eucDDkxRXGjFBuPcWf
         Bl103HYm/LSbQV5dm744uTGEWl+691be2fIlpxWAx6lm8mOj1PHmv8iDNC96c+d6UkbP
         3ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RPPVB2DH745rVxScp1X25ORUy6JT/zQANY7+TCeop8c=;
        b=Vz4m91bh3zx7svZkxQLMopAVtPudHA7xuvnrZn8f/qvP6Ctjscl/G0rKb9RPErQHpE
         3Ayx58wYFfFgw0qnZ9e/in7/I7qDehOYfIynMO4tg3F1dnwsRwHJEJuY6Zmcqw/VeqKY
         Hb2fn5f4Adm1pGqmdSaDaW18l8/CORgJuDfpkzvWjtjyAXO/1RphZA7/uIXzcbwVqpRQ
         uuuCK0Sm7cNiluI2E94sp6CfLKxWkiRIjkNlyeCsxEwVXhXrt9lkWPzGBTa1ArQBRMOz
         R+mU4qfnd9ozo3FCzGYVmWsn5lb8hiW9O+TVVqG9UyeNkk62AU+MjiTuO6C+EkbPDZ9U
         bcHA==
X-Gm-Message-State: APjAAAX1vemKngxg0Ox8JeN2hd2zQxHgwL1GomZgJkmtkYgDw3tMtUKn
        1anUDg6zMZYeU6VfWw2Gf/koYuH6CYC6CjAo6Ho=
X-Google-Smtp-Source: APXvYqzTLBGKaqddd3BFXu3evTjWGohbS8unFo8lJLP9lZLluubJ4f8r/wVc49p9QQb32Ta9BuynOnyw+ipwtQMC8J4=
X-Received: by 2002:a5d:8451:: with SMTP id w17mr27398597ior.226.1564423516964;
 Mon, 29 Jul 2019 11:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANoib0Hn9uNnk5vpjEJUiGriD5rHuDc7xxLFj3r8ij6ALSxcag@mail.gmail.com>
In-Reply-To: <CANoib0Hn9uNnk5vpjEJUiGriD5rHuDc7xxLFj3r8ij6ALSxcag@mail.gmail.com>
From:   Dmitry Tunin <hanipouspilot@gmail.com>
Date:   Mon, 29 Jul 2019 21:05:06 +0300
Message-ID: <CANoib0Et3gLu2gGYeWracV4v7tgWj8qhtO7w_c8TSJ+CE-gjMg@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Russia (RU) on 5GHz
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I made an error while editing. The correct section is

country RU:
(2402 - 2482 @ 40), (20)
(5170 - 5350 @ 160), (23), NO-OUTDOOR
(5650 - 5850 @ 160), (23), NO-OUTDOOR
# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=96129_2204=
2015.pdf
(57000 - 66000 @ 2160), (40), NO-OUTDOOR

=D0=B2=D1=82, 23 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 00:53, Dmitry Tuni=
n <hanipouspilot@gmail.com>:
>
> The db entry looks like this now
>
> country RU: DFS-ETSI
> (2402 - 2482 @ 40), (20)
> (5170 - 5250 @ 80), (20), AUTO-BW
> (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> (5650 - 5730 @ 80), (30), DFS
> (5735 - 5835 @ 80), (30)
> # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=96129_22=
042015.pdf
> (57000 - 66000 @ 2160), (40)
>
>
> This doesn't look correct. The regulation document is here
> http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-=
_-16_36_03.pdf
>
> According to the regulation document issued Feb 29 2016, there
> frequencies should look like this:
>
> country RU:
> (2402 - 2482 @ 40), (20)
> (5170 - 5330 @ 160), (23), NO-OUTDOOR
> (5650 - 5835 @ 160), (23), NO-OUTDOOR
> # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=96129_22=
042015.pdf
> (57000 - 66000 @ 2160), (40), NO-OUTDOOR
>
> Note that there was never a DFS requirement in Russia, but always was
> NO-OUTDOOR on 5GHz.
> Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> Also Russia has never been regulated by ETSI.
>
> If this looks good, I can send a patch if needed.
