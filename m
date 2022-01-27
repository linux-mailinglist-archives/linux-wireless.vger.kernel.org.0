Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8949DFF0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 11:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiA0K6Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 05:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiA0K6Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 05:58:25 -0500
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jan 2022 02:58:24 PST
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2002::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C8C061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 02:58:24 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1643280626; bh=twzfaiuwidAgKgvANdRYhtKtnNrz81wgsU8UZt9EDXs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JY7lb67X+rDuuThi2tlBD7p4i32x+W3Xgd87LkOUxRqZHb7JeOmx0MPJgokHdMgGB
         w5+HWOWS0qiwfeLRh3w6gD7ysuKPV02g6KqW1Hm6emRGFrKqZgEWS8VVDErlcSqGKw
         so/XyDWcLfeqWg+DadjdIEUrvCnzmF8YXGlSGLTYoRMjsuqdX4YQsN4QIcUZ78kIyt
         4Gac4sYllslQ09di+37ZhpwNautQQzkC7ShN+YYgxk/tcm8wsGzqzjzd5FS/L+iOOI
         0pRKQUmjYux0p16JaGUwESozV606MAat+RaTR1IZoUHIyV/SNYvA76TzYrHWAYkicM
         jZk2Slht0Oukw==
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     loic.poulain@linaro.org
Subject: Re: [PATCH 3/4] MAINTAINERS: hand over ath9k maintainership to Toke
In-Reply-To: <20220127092709.5203-3-kvalo@kernel.org>
References: <20220127092709.5203-1-kvalo@kernel.org>
 <20220127092709.5203-3-kvalo@kernel.org>
Date:   Thu, 27 Jan 2022 11:50:26 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sft91mh9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> In practise I have been the only maintainer for ath9k for some time now b=
ut I
> don't really have time for it. Luckily Toke is willing to look after so m=
ark
> him as maintainer. Thanks Toke!
>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2bf3b1f7442e..b1251fc9a71d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15899,9 +15899,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/=
git/kvalo/ath.git
>  F:	drivers/net/wireless/ath/ath11k/
>=20=20
>  QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
> -M:	ath9k-devel@qca.qualcomm.com
> +M:	toke@toke.dk

Could I get my full name in there, please? :)

I know it has weird unicode characters, but you can copy-paste it from
my other entry in MAINTAINERS, or from:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
