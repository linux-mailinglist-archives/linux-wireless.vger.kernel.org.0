Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B934B9DEDA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfH0HgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 03:36:01 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:54524 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0HgB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 03:36:01 -0400
Received: from bentobox.localnet (p200300C5970B0CE86C4047C4D7108D73.dip0.t-ipconnect.de [IPv6:2003:c5:970b:ce8:6c40:47c4:d710:8d73])
        by dvalin.narfation.org (Postfix) with ESMTPSA id C165F200F4;
        Tue, 27 Aug 2019 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566891358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOrC2IaHAVZ//zfqDte0Y5Hbg3OHEzewX2dPc2zfRhs=;
        b=aT39pVoKq6VsPxQkuY5FieMpGBsAcUnmVY2LB4WlPLOpS6MBRvo11CF+L+q8gGnmK5EKXZ
        3GsxKCwmXaIMguAg6J28oC5X1MC4zp2Zfl8rpC2TH4hui3o7l0nrR2HpXvxfYL9OXgWHBO
        fiKY5HeJd5UgaUNJqwPmgkELVA7oeG0=
From:   Sven Eckelmann <sven@narfation.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 10/49] ath11k: add debug.c
Date:   Tue, 27 Aug 2019 09:35:54 +0200
Message-ID: <4441194.D8eDD6Tzdi@bentobox>
In-Reply-To: <80bdedf3740960e0ce05b02a77d1b457@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <2708501.D2hezO5Rnt@bentobox> <80bdedf3740960e0ce05b02a77d1b457@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2493492.G6y1Xp12sA"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1566891358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOrC2IaHAVZ//zfqDte0Y5Hbg3OHEzewX2dPc2zfRhs=;
        b=bXNDVrN5g9KqGtvXA3llhA9n/Fewg/BDzITGjLibhCDwjmNOJsuTvC5XU9hId+UD8IRIXo
        ZH9mEXHFbsOSOpStkrPNqYzCNmlpZbh420FivLaytl+hif11EGJDlZwIZ8PFkLo3HDvTiO
        85IYNJZroyf89oOiRW2gK1BkhdXh3OU=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1566891358; a=rsa-sha256;
        cv=none;
        b=adDZbf4ygUZFchkRUjlfU/bqtRI8cXqfLBfu6bzEaSW9+QotOjh+uAQBVgF1M9QMBSNUWd
        e8XMnzWeglO0k4ZiJqKCSc0Knop0zz9AjwNFGUPTh3YHfzPu5JUO+OvNnoP7eeJ+qqIoba
        PQ/Hw4wTSFJco3kMlm6aBFTkDAAbFLc=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2493492.G6y1Xp12sA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 27 August 2019 09:33:39 CEST Anilkumar Kolli wrote:
[...]
> >     [ 4312.884650] The reading for sensor 4 is 0x002041f7
> >     [ 4312.891499] The reading for sensor 5 is 0x002051f4
> >     [ 4312.896415] Couldn't get reading for sensor 6
> >     [ 4312.901189] Couldn't get reading for sensor 7
> >     [ 4312.905561] The reading for sensor 8 is 0x002081e0
> >     [ 4312.909902] The reading for sensor 9 is 0x002091f7
> >     [ 4312.914645] Couldn't get reading for sensor 10
> >     [ 4312.919364] The reading for sensor 11 is 0x0020b1fa
> >     [ 4312.923791] The reading for sensor 12 is 0x0020c1fa
> >     [ 4312.928621] Couldn't get reading for sensor 13
> >     [ 4312.933425] The reading for sensor 14 is 0x0020e1f4
> >     [ 4312.937941] The reading for sensor 15 is 0x0020f1e7
> >     [ 4313.942700] Rebooting in 3 seconds..
> > 
> > Maybe can be fixed by a different kernel (for the remoteproc). But I 
> > don't
> > have this kernel at the moment.
> > 
> 
> The write of an "assert", sends 'WMI_FORCE_FW_HANG_CMDID' WMI command to 
> target firmware.
> This WMI command forces the target to assert.

Yes, but it shouldn't kill the complete system.

Kind regards,
	Sven

--nextPart2493492.G6y1Xp12sA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1k3VoACgkQXYcKB8Em
e0a9MA//dLviXuRMjJGR01qJslAHx12n9IorBsRkDov60rQnOk+6rClZmgUHW4xI
RSNvzfGlTy9IH+vbmdsNKfK8ixnw9g4m8L5wxwzjGSjEOmerQOxHSsnOu9zTZnWG
AXlgdDSWfI06nx42aehdzZ9P6dgh0jpHIdc3m3t+qdhKsi4Tp3wA0aGyWdwaw2Qd
Ok34en5klPN629oEUEVIiPqvpr2xymiKrSnGx3F1cxXY7+hG9JtDhXj9jgVUlSXi
F76GSE5y/oEwZ0rCvziqismYir/xJntI7e2PX1IOLC3LirFkJvGY1J80ZaQRmyas
DQqt069SZL3bzsQn/FnQ/kgPJM6iTW0JkmThyLwPiy0ITJUQBQxJpUALP/kRPcrg
7L9c3uox6qMu/PKwUsgS/uxVWQ6t0X0BYX5ZQkl9pgM81gd0UG6CIov2x0tybkzX
rVCyVfVWPIA2OKbiExwZG201zghNu56Gzl7+lhWZFFy4FNBZUwcilONDHhECfuEi
0wrVx9UCMrxDMC8BZHa2mQV6+Bu9qbBz1eogQbtbtWk5A37iiQsvwGUZTU8q756p
I0BR+ZcBlW09kd9oyWOdXGnvOYjmyasT4uZatCYEWwdplXcfHCuA3oRrt3b61SsJ
f12M3O/Umhq0rBL/bx/ZxNeZF4F2msSDi0PW+w6mFdGaPqgwLpc=
=I7YO
-----END PGP SIGNATURE-----

--nextPart2493492.G6y1Xp12sA--



