Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083151B591A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDWKXu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 06:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgDWKXu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 06:23:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F54920704;
        Thu, 23 Apr 2020 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587637429;
        bh=EFM/XUej/p55K3upUZnFJZia7Wn4UqTBYkpy2EOYyCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDF01/eomYp1HuQOisUMTc+1GEL4HUcWeCOMZWOgELPJeCggaDRRFRf9OCl6lQBKY
         yR6UsjFCilguMxHTT0ULgGKgv6Anb47WExQ+uMenJ8457BptHgdiy3xZUwodJrxt2e
         sUEwZ+qP5M5win1RBFH1ahX0gcYjhZLCURCgartE=
Date:   Thu, 23 Apr 2020 11:23:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, yhchuang@realtek.com,
        Dejin Zheng <zhengdejin5@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] iopoll: Introduce read_poll_timeout_atomic macro
Message-ID: <20200423102347.GC4808@sirena.org.uk>
References: <20200423063811.2636-1-kai.heng.feng@canonical.com>
 <87lfmmn1fo.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <87lfmmn1fo.fsf@kamboji.qca.qualcomm.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2020 at 09:47:23AM +0300, Kalle Valo wrote:

> I don't know who maintains iopoll.h, at least MAINTAINERS file doesn't
> have an entry, so not sure how to handle this patch.

Andrew Moton often picks up things like that, or if it's used by some
other patch as the original message indicated then often whoever picks
up the user can pick up the core change as well.

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6hbLIACgkQJNaLcl1U
h9ByNAf/XAXRWSCZMcOEEcUgVNKsbO44YKIhqbh7MmExLvHSty5NYZGAHZJSxBsF
GD0zRWxlp/s4qr23mqIkMhV1ws170DV72nml7g7An+C3dOFLRmCzfrxhFz5V/jPA
qOQs51npOhdbcL/Duc7wyek3iJWdNLzVsLZ0EDuU4suxH7EBXKQdF+Ot0gfjC9Qh
frpVi/hWLV3GGFHqo2U6NveplhOjdDT/Nxg6w1phpvTeX/V7bRUCI80vQmdj7LNN
ZMTeqtPHI3vC/n4HQ/uBMPcRSidtLXxQlYi3XdCN6cg5fdKER5fk+4q2Iz6O2aUv
c+O5hjlpM7isyIIn+BibBZ7eU6nlCw==
=Oimp
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
