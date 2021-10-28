Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F343E11F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJ1Mpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 08:45:47 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:52134 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1Mpr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 08:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635424999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QoC3OLStbdQmvaOCAZZzBXCDyQBKZIDqUoI7nwVlY8I=;
        b=zRm2ZI6QBNV6gGXFufelafWy8ObcMPbfARLivD/K8NdPZ5z8pHTNifc9+WErcZ6X/R3PVl
        W9grdB0IpcoUzFmB1jNJXXfpF9jmdXypizFYI4LB7NHIcYLNmT/abruzmYxm3nzBA858ft
        zJimoW54ApW1DH9unUJFiY/affwVMD4=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: Re: [PATCH] ath11k: clear the keys properly when DISABLE_KEY
Date:   Thu, 28 Oct 2021 14:43:16 +0200
Message-ID: <4399157.2QDAq5Xuus@ripper>
In-Reply-To: <87sfwl494s.fsf@codeaurora.org>
References: <20211026155446.457935-1-sven@narfation.org> <26869605.A2Tbvc0WiF@ripper> <87sfwl494s.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3426232.laXtC95Ive"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3426232.laXtC95Ive
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: Re: [PATCH] ath11k: clear the keys properly when DISABLE_KEY
Date: Thu, 28 Oct 2021 14:43:16 +0200
Message-ID: <4399157.2QDAq5Xuus@ripper>
In-Reply-To: <87sfwl494s.fsf@codeaurora.org>
References: <20211026155446.457935-1-sven@narfation.org> <26869605.A2Tbvc0WiF@ripper> <87sfwl494s.fsf@codeaurora.org>

On Thursday, 28 October 2021 14:38:27 CEST Kalle Valo wrote:
[...]
> But it doesn't either break anything either, right? So in that respect I
> would like to keep the Tested-on tag in the commit log to document how
> it was tested.
> 
> Though I'm not sure what I do now, do you think I should the patch still
> or should I drop it?

It seems like QCA wanted to have a look again at the problem. So I would 
suggest to drop it or mark it as "Changes Requested".

I cannot make any statements about whether it actually clears anything 
in the firmware because I neither have documentation nor source code of 
it. So only persons which have more knowledge about it can work on this 
problem.

Kind regards,
	Sven
--nextPart3426232.laXtC95Ive
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmF6muQACgkQXYcKB8Em
e0Ybjg//UfH7a6x1M+B5p+UecsGikje4Z3pmYm6nbdZbseYEhgYra7DAdgi3wAZy
v2EW914tFvNo2v1aW9ALhAEJG0sDBnPmmlp3RBvtyVd4y55NNtXlWeX/6eTjyRty
K43725qiOa5EA4pTF4WINwzzZuUqQIx+XplPm9MI5PL7bW9hxR0FP3xMP/F4rtUQ
cjlGL8XeD4NiugM48Y8BENgPFOLWwEsMtd+UbUyKxuOAXEHNO2dunQ9OqMdyMiLf
U+KTTiTq65sS38KlrwOrPQD+Wnqlozd+TXYab1oIhpriYzabLoQMxMst4ak1sXaY
2Pga+m95mAuxjX1qct3LlgpiZb3ei5DYEMki2BeSTTSZQ/dgL3CgfUbVuMhLoRXb
99+Rw7G9+zLxXP+zPk4gRArGkRPFv/N15IYaOHNG/U2QYdokH1q7u62anbkmHfBt
y7eheiGdP+NHvP4i7Mf2jmVNkMit2V7m7nMoPBq4vJOaJHbVk8e//1cLpN/6EUo8
l+Q6NFL0uhusJhNJgejdqwQSXasqJSkjUaG+9/rE0ZzbQBkNwSEZL+7Siow+3mdy
yirVqmCReuLmG4cIrSJb5baYU5IIt0q32zYoju2wdt0xIUQpgMiDcx0Grg8QzueX
C7lAgXuYeqra72CVwUPLDs/krNg/LhFYdH6lUFU4Mukn9sXzuFI=
=F+Gz
-----END PGP SIGNATURE-----

--nextPart3426232.laXtC95Ive--



