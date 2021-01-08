Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40632EF28B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbhAHM2m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 07:28:42 -0500
Received: from mail.toke.dk ([45.145.95.4]:59723 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbhAHM2m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 07:28:42 -0500
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1610108850; bh=XrbMDAa3p/Vtl/GFCNGFI/BX1TzGSrmhTacLKUkj8Ak=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i9LXKNH473wIxrKg1IhZ9ZPexv3Nv6TlUnndvsCjjuV4nCZX0KwNChYYf7dGbbUiw
         D+g/KG5/21hxtipROXxaN/XxDuEWskg9ogBeM0Qzj6jCcZ975tf3oxRO3Xo7qsvTix
         UnePKUi6LeV9+ANJQ5EOusFi2XxwHLYC6tt7cx0j5mm1jmyTKolii7VQnY3/leQ6sn
         dTpK6yRBCesg7lsFLjRHSJO4hYWjdE9LdWZ8udmTsEbqB14skvtBhA+c7hfqbKrWwB
         tBWuHv+aQccSHH2LQyY4bomdEQ+8+NEzzy6NhYj5DnlvQaZRIl+eRRI8EMLRKtEHD3
         hMXtcEoFQ0gZg==
To:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: Re: [PATCH] mac80211: fix incorrect strlen of .write in debugfs
In-Reply-To: <20210108105643.10834-1-shayne.chen@mediatek.com>
References: <20210108105643.10834-1-shayne.chen@mediatek.com>
Date:   Fri, 08 Jan 2021 13:27:30 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8735zbipfx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shayne Chen <shayne.chen@mediatek.com> writes:

> This fixes strlen mismatch problems happening in some .write callbacks
> of debugfs.
>
> When trying to configure airtime_flags in debugfs, an error appeared:
> # echo 0 > /sys/kernel/debug/ieee80211/phy0/airtime_flags
> ash: write error: Invalid argument
>
> The error is returned from kstrtou16() since a wrong length makes it
> miss the real end of input string.  To fix this, use count as the string
> length, and set proper end of string for a char buffer.
>
> The debug print is shown - airtime_flags_write: count =3D 2, len =3D 8,
> where the actual length is 2, but "len =3D strlen(buf)" gets 8.
>
> Also cleanup the other similar cases for the sake of consistency.
>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
