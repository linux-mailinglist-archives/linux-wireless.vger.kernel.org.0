Return-Path: <linux-wireless+bounces-13748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D9995C6D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95BAB21424
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B08F6B;
	Wed,  9 Oct 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QnPfjmpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C179EA;
	Wed,  9 Oct 2024 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434700; cv=none; b=jtm7RMQ7t4MAV1NF5/oay75cdabuCW/OdzUkwLOOoK25SQ9RZwWytQk7xh4NMN22XVVVNNePTvgKzx18Sxe9ODZWo1yfJmSOH17SSE/ke6g/Jvi5R/qLgsykBNPBdgLfpL1XdNRtYGgX1I56MldF3vjr8xoTeK8vJKZEKL5EIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434700; c=relaxed/simple;
	bh=LcYBSAt2WmfbTdrkbUFEBmpBqWEGTUpWfgCGzhGqpwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gM1Z9PC5dwkyGyQcbKlbTRRkT1fJyKKLvfpKLa49pov2VxVcLeUxRSKVusFTeeuHkxiTD+kPPMG5kfM88Hfws09snMs7hf4RsIxcGfnMwJ0hAOiIHMD57cPbZ3lwt2IiNGnjWStp9L8Ns33S9xgTJzP4pW1JSBRnH5u7JiS94uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QnPfjmpA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1728434695;
	bh=RXN51MLDI2R2QyOtshsJQTkJZtwKN8Dmf1gBWRzdo1Y=;
	h=Date:From:To:Cc:Subject:From;
	b=QnPfjmpAFLaCq0lLbEG6wTtcLo1k+oQm1amnP+1B0Vk9IGCJ+kZLlk9gRTAQQ0Koj
	 chywpKedz2Kn2mNxgWto2bsY4YJdo1WQhSBZPQIUCVhMwT5lkYFA8fID9/KDRz7vMd
	 O7j+VH3U6wTZXG4N9jaEiHrE1Y+vXUjoWmmkIS4tbv/AJ9QuIg0AwXRT+geiEsk8Po
	 7WiUtZExF5WQa6vlqb83J2cZXypLV1i/6DY45apGbuZiOKY0WAdCjr7Cz41DvEBJcn
	 iFsb6iH6hZsvmc4LUFnDtDpaqWn5UIYozVgs3mrPk2GvShXl1RLuJW/K0Au+m1GyT4
	 18FAyiorjnlog==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNZ0l2PZRz4wcy;
	Wed,  9 Oct 2024 11:44:55 +1100 (AEDT)
Date: Wed, 9 Oct 2024 11:44:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Johannes Berg <johannes.berg@intel.com>,
 Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Tree Davies <tdavies@darkphysics.net>
Subject: linux-next: manual merge of the wireless-next tree with Linus' tree
Message-ID: <20241009114455.52db31ad@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cy25zv_kQV4WXhV.NuxvSfa";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cy25zv_kQV4WXhV.NuxvSfa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got conflicts in:

  drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
  drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
  drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
  drivers/staging/rtl8192e/rtl8192e/rtl_core.c
  drivers/staging/rtl8192e/rtl8192e/rtl_core.h
  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
  drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
  drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
  drivers/staging/rtl8192e/rtl819x_BAProc.c
  drivers/staging/rtl8192e/rtl819x_HTProc.c
  drivers/staging/rtl8192e/rtl819x_TSProc.c
  drivers/staging/rtl8192e/rtllib.h
  drivers/staging/rtl8192e/rtllib_rx.c
  drivers/staging/rtl8192e/rtllib_softmac_wx.c

between commits:

  5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
  5e6bf74d63c2 ("Staging: rtl8192e: Rename variable RxDrvInfoSize")
and many others

from Linus' tree (pre v6.12-rc2) and commit:

  be9be9f54f22 ("staging: rtl8192e: delete the driver")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/cy25zv_kQV4WXhV.NuxvSfa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcF0gcACgkQAVBC80lX
0GwZ+AgAmGKzGKsTtfw9LQ6bQvROvaiJBeB3qIJHyM2CsAfO/LYIiZovU7Fk14bF
gOLZocY6URxj2pIjgVXn0dZ7yuEGCppFDXpyVyojEzkOhJHmuREkl/jJ4Kigi1mu
/KNV6cJGGH2amyxTCzxGo+H/0rkR8ziA19g87gWXA0lFhct0nJaaSS2asw61VUTc
YfXqOJpTkh3MRL+7k9Kt51dHfgCW61fIijVervmDdsjFviPCHe9/DnvyoJQ+cKVL
z+i0u6r+1NDLCFrHBOPqaRfE5auFkOdn4OOF1qx+jp5FWT7Xbd8bW2JQeJfNDNH9
te/TGQajZHf84B1NwL23AhxerfTgaA==
=HIPM
-----END PGP SIGNATURE-----

--Sig_/cy25zv_kQV4WXhV.NuxvSfa--

