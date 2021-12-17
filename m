Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878C34785A3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 08:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhLQHic (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 02:38:32 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:49380 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLQHic (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 02:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639726710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x11yMX0KsbJcjPNKUQ/1GVC9s0S6w50A5zeidXkvOPc=;
        b=B9irIFy+SpUutOy1WR+v4AfT5S22njqyJftQpewPNxmQRe6I9Pf5ZorzNwGVFpq8tSojWI
        zovZYvUzkifoEaQcs/SLh/SQqWPe+wY+D262mHIrPrHRUHXIfJiH1mWjIGmtWXy1Pdg1uD
        WAma4+jwO2P/Bs/BDmnhQlSR35nJ3zI=
From:   Sven Eckelmann <sven@narfation.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, nbd@nbd.name,
        jf@simonwunderlich.de, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Deren Wu <deren.wu@mediatek.com>, sw@simonwunderlich.de
Subject: Re: mt76: MT7921K monitor mode not working
Date:   Fri, 17 Dec 2021 08:38:27 +0100
Message-ID: <2379616.QugRJdfsTW@sven-l14>
In-Reply-To: <YbusBazb4GAC6YQl@lore-desk>
References: <YapTmM3EztojTS9F@lore-desk--annotate> <12706913.cppxkphV4n@ripper> <YbusBazb4GAC6YQl@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4742295.SFTHtOJNxW"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4742295.SFTHtOJNxW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, nbd@nbd.name, jf@simonwunderlich.de, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Deren Wu <deren.wu@mediatek.com>, sw@simonwunderlich.de
Subject: Re: mt76: MT7921K monitor mode not working
Date: Fri, 17 Dec 2021 08:38:27 +0100
Message-ID: <2379616.QugRJdfsTW@sven-l14>
In-Reply-To: <YbusBazb4GAC6YQl@lore-desk>
References: <YapTmM3EztojTS9F@lore-desk--annotate> <12706913.cppxkphV4n@ripper> <YbusBazb4GAC6YQl@lore-desk>

On Thursday, 16 December 2021 22:13:41 CET Lorenzo Bianconi wrote:
> can you please try the patch below to see if it fixes the crash/hang in monitor
> mode?

Thanks. But I don't have the mediatek card with me and can only test this in 
slightly over three weeks.

Kind regards,
	Sven
--nextPart4742295.SFTHtOJNxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmG8PnMACgkQXYcKB8Em
e0ZJXxAAqLsrz0RPe0KAydHDa/+D1RrY/pCqVqDZcFyAUzww8J3K7lqbdGlcxoc3
PlvoYCWsIJiYpIxRcshYkdEGAIN/RdqzUtpEDQgF+EYqrNcE3BbKBy61zvwGKLIU
jd7/aePHPD4Hf4gXPrsHuPTlHMPy88k+9w7VUhvq2jXl+irlQ17QHafdpL+fhiDp
vtzMKBo+z53tcssRdabBxnaB/2FMzps/WrnGf2q1LXuqtOJpPKst6kmDpBVpO6ju
E6uQIf6wjjUYpxRApL8s/j7RvuF7yDYc3WgxsOlWbm11b1oszWd7WsxUSRfYEIlw
3W2TFOAKMXOR+nZATaMMJY5C6yi+vrTiyQq6d/5ncHbldogq5Aa0L7MGmKcbASus
Li51h9Y+LaHbYVqacG/ZM4vzJ8VLJ2W6hs0I1RqQtAcx0xxsr75OcQKdOzqYqfvD
qpWmn1t0J53/L0gdXL1tK6QMNEwPAjZHeVmB9U/5PKn+soQj07N6sCA2oNtZecXn
M9E6cIEGL+Cl5qRQcGu/IoJ9UZYBhFT3bq/qmwZ/SbR4CLUSNSY1bmxW+jIjmBbK
sunJmNTODZ8N6HUUTEEplreUpJzhOC5YV0tdQWJKb4Xgtjz/inq4TPXJdaVZrDlq
Qa3WfXks0XNbbXAE5LDIt+9YqbzlR0KsYDrXbQaSwrMJt2fXoEA=
=6go4
-----END PGP SIGNATURE-----

--nextPart4742295.SFTHtOJNxW--



