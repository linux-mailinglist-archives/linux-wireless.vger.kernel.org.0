Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0776741802B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 09:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhIYHRi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhIYHRi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 03:17:38 -0400
Received: from smtp.dkm.cz (smtp.dkm.cz [IPv6:2a02:8301:0:11::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3FAC061570
        for <linux-wireless@vger.kernel.org>; Sat, 25 Sep 2021 00:16:03 -0700 (PDT)
Received: from smtp.dkm.cz (localhost [127.0.0.1])
        by smtp.dkm.cz (Postfix) with ESMTP id 171F32897E;
        Sat, 25 Sep 2021 09:15:59 +0200 (CEST)
Received: from router.bayer.uni.cx (ip-89-103-167-90.net.upcbroadband.cz [89.103.167.90])
        by smtp.dkm.cz (Postfix) with ESMTP;
        Sat, 25 Sep 2021 09:15:59 +0200 (CEST)
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
        by router.bayer.uni.cx (Postfix) with SMTP id DA7EBA00CB;
        Sat, 25 Sep 2021 09:15:57 +0200 (CEST)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Sat, 25 Sep 2021 09:15:57 +0200
Date:   Sat, 25 Sep 2021 09:15:57 +0200
From:   Petr Pisar <petr.pisar@atlas.cz>
To:     linux-wireless@vger.kernel.org
Cc:     petr.pisar@atlas.cz
Subject: Re: [PATCH] Revert "mac80211: do not use low data rates for data
 frames with no ack flag"
Message-ID: <YU7MrUv3ZM0PZvZe@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wmy1x/AYgU+Af5Hv"
Content-Disposition: inline
In-Reply-To: <20210906083559.9109-1-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--wmy1x/AYgU+Af5Hv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I confirm the revert fixes sending multicast frames on my ath9k device.

-- Petr

--wmy1x/AYgU+Af5Hv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmFOzK0ACgkQT9GuwzZa
978LhQ/+LcMZh1VYlCYN90kmGFnBQFrfbrzJztTvZlV01Prr6Dclsk6bXGipBzQW
rqxElvT4DmuIMSKsrtYia6HaXbl0CI3A2lxa3igBW1C+Lm378erHKv7dgzryArJd
pN98LLAps4w4FGhYqbqGdaXVetPIyoM6Z5Tus76eiAoj9j2u67TNfkgy6X9FfrH5
2IM0Vl5inPHNJtKS8Yv1Sftt+d95Os7ejfp1s0rxwWgvNzpnNjDqKrLmWvOXf6N+
vlwAcUN0Bqh48rHC+WNhnuwAd32VtjCok/JfxPFgF3wHgIdiL2DiryNJSHen9RKu
StGPGGpy/Q8POSJsSyuGxlRTVON4mtYUJfKwjTIuna19QGDAPwH2rgKowHKBI6f7
LyHu0MeLWhHpSH18VYPpkHh7yNa+rMvs/YjcM5PSOGdkXZkXGGkEk9OPGfSuUFjY
afzkm8hzJCHSO56luKh9rUNXE9pPmqdLVbrwN3KWv42JijWZR/GSb5/aoK6biB3u
bFwvxNkHNL45wavwuh3sjN4BOO40iGtotk4AYhn+pR3v+KH++htf4IiWs/tYNt94
+egl5jZHHqmWlhIC6GGKbRqG/LCO1zZvpkLvHPnet5qPo4mYWp8ANFegjEqLQK98
XuyQxITeG+qmQWUAzZ1U7+VyY/kercpwR/gotftECAhAwOqGU6k=
=Pr0/
-----END PGP SIGNATURE-----

--wmy1x/AYgU+Af5Hv--
