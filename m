Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B7943B971
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhJZSY6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 14:24:58 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:57670 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhJZSY5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 14:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635272552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpSsBuI/yra5yOXYuL8UW9rcOksCsGQVxFgeLbgQfGs=;
        b=DafVf0dhMTF9atvgEoEIYZ6Td7qBtIEEC55dFy7EEKcAZf5hvMcLNO6ySXPt+BwwVAk3Ks
        bP5yz74e8MWfe1J2KpGkC17Z4tZpDetqISnQmz/HbazMaf21s/tB2+r7SnqfPWGY5dbczm
        77dFrMkPT2M/p5TmSbYBHaqv7g4T4UI=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: Re: [PATCH] ath11k: clear the keys properly when DISABLE_KEY
Date:   Tue, 26 Oct 2021 20:22:12 +0200
Message-ID: <2140984.h3xd69cp4r@sven-l14>
In-Reply-To: <20211026155446.457935-1-sven@narfation.org>
References: <20211026155446.457935-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3042913.mnNX1PIVWj"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3042913.mnNX1PIVWj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: Re: [PATCH] ath11k: clear the keys properly when DISABLE_KEY
Date: Tue, 26 Oct 2021 20:22:12 +0200
Message-ID: <2140984.h3xd69cp4r@sven-l14>
In-Reply-To: <20211026155446.457935-1-sven@narfation.org>
References: <20211026155446.457935-1-sven@narfation.org>

On Tuesday, 26 October 2021 17:54:46 CEST Sven Eckelmann wrote:
> Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

I would like to retract this Tested-on. My test caused another problem which 
resulted in a complete shutdown of the vdev. After fixing this problem, it 
turned out that this change didn't fix anything (as far as I can see) on this 
firmware version.

Kind regards,
	Sven
--nextPart3042913.mnNX1PIVWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmF4R1QACgkQXYcKB8Em
e0ZtmA/+NHgZ2CVrq5gZ2qvv+rj6FNvuZLBnmSaMH8gjr+lRibxXr+3x9W1ZS2fM
ZDiQXeF7FCE9np2I7Nd8HdeAx08NMPu+Vqgw6hmsEd5ZRf6KOKp+S+5WMgU+fqKL
uYzYGwTPTnsWzJ8ZIEwAa8nR1+zx4n1L6CzSAxBpmdxeWcp99icO5iHMme+0WW2W
kqiOIzRJVlNzZBpu0gTybSnDTVR/unc25wTiQOktrw1FhJhjEkoJA/piZv7kFc6z
MWS9zhQJmk1cEJD2+YoObfaFmoQ7XN1SoqTBHh/jqAkJnjOkLGv41bFBwmHOZnyT
4vtFaAPYUqBfiCcsXlaxqHeYMIgOi2m2t6HtKXP6kDuddy1L/sO8vhHmkrQA4Gxe
ls48r6GJwXsB5ZedHP4BE8puzLEyOTs94geco0mPntceYNVbBjNYNVBuaLVvDb99
LdhYBiiNM6+fuQqh49WKfYuFmwa25etOPnHMV5PJgV7VViqgI5A6RtcJSOIfu9V2
B4hT6Mjx6p8MxUXPSLzpQefo9KjXXOGksTiFblKGOXGZ78Jz8werAuTxzzRESRZT
5e7tl+nNT+IHInbZufqTxf8+eYAC4U0M/Fq2lHbSbvT5498YFOm2FxqTirkl9b8V
y+JLaC+sAIrPABdztXhZ4djO0+hdaL6jho9NLds/xD9AZh11CI8=
=Ec1P
-----END PGP SIGNATURE-----

--nextPart3042913.mnNX1PIVWj--



