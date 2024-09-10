Return-Path: <linux-wireless+bounces-12756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BCC97365F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 13:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6341F24D08
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DFD17BEC8;
	Tue, 10 Sep 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="o+Fo7BfD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929818EFC6
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968386; cv=none; b=UzVOcdllSnR+B63n4GYI6OIzbIbstXS5U6TU5TrBBGDFSXaKbOriz+CUBF24vN/5srOaJg1/G4IONIzwZkcN7Wxr+y5alC+dGlQwLsUVFk0hmgSU1OP6uCi0D4EV+gjtWhNLjQEmLXtQ9yd7M3AVyybZZSJgTXMPBuTcFyFx2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968386; c=relaxed/simple;
	bh=H19oh/kdlyHs/RbvJ09CpAZPgU8fXXtgzBBJMWoqArI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2xpXOb46XvOQe6hHqAcleMUUY1TK55QMhgBTW9Clp4ZN4p4W0loW7JFb7/8Fkw0LMt7CjZXh4vaJVdm20wSVEmyV2i4PoMCcR9T+PtH9+hOnAO37ljv7LQeO93l/fRUkT8HkbuZymcACrAmkubplVrC0imIZ8Gl/wZf4kT4bPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=o+Fo7BfD; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1725968381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXq+ZcFe+uGF0qCrxYiYGxfjiCAC1RobJ6ZdNP4DdEY=;
	b=o+Fo7BfDSVouUSQY03qg/6AK+OlXK3bfrIHp1yKtYB7K8ErGjrCXk31FwDVBJnMle/PugM
	0dn+8zS/4GAoqnfkWr1/JMmfUp8hebpCreiu7nZy9iVej8EeJ8AaiqX/CLlfEzhoHqyJCm
	zckQNnWNXsc51WacwLyPsHgPPCO0fgA=
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, ath11k@lists.infradead.org,
 ath10k <ath10k@lists.infradead.org>, ath12k <ath12k@lists.infradead.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Robert Marko <robert.marko@sartura.hr>, Kalle Valo <kvalo@kernel.org>
Subject: Re: New staging repos for ath1*k firmware
Date: Tue, 10 Sep 2024 13:39:36 +0200
Message-ID: <2248097.72vocr9iq0@ripper>
In-Reply-To: <87h6ang8v3.fsf@kernel.org>
References:
 <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <3772134.MHq7AAxBmi@ripper> <87h6ang8v3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2659000.7s5MMGUR32";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2659000.7s5MMGUR32
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org
Subject: Re: New staging repos for ath1*k firmware
Date: Tue, 10 Sep 2024 13:39:36 +0200
Message-ID: <2248097.72vocr9iq0@ripper>
In-Reply-To: <87h6ang8v3.fsf@kernel.org>
MIME-Version: 1.0

On Tuesday, 10 September 2024 11:23:44 CEST Kalle Valo wrote:
> As there are so many different branches I have lost track, do you have a
> list of missing firmware updates? We could try to push for updates on
> our own end as well.

Afaik, ath10k is missing various security updates - but I don't know the 
firmware version which has these security updates.

ath11k is missing the 2.9.0.1 release - which seems to be still required to 
get various APs working correctly (without a crash). Maybe Robert Marko has 
the newest firmware version (not the file - the version) somewhere.

Afaik, there are even newer ath11k versions - for example for IPQ9574 (which 
is completely missing at the moment in the repositories).

For the completely missing ones, I've submitted following list to QCA:

* ath11k/IPQ5018_QCN6122 (that might be rather complicated due to the way how 
  QCA designed this)
* ath11k/IPQ5018_QCN6122_QCN6122 (that might be rather complicated due to the 
  way how QCA designed this)
* ath11k/IPQ9574
* ath12k/IPQ5322
* ath12k/IPQ5322_QCN6432_QCN6432 (sounds a little bit like the QCN6122 
  situation)
* ath12k/QCN9274

Kind regards,
	Sven
--nextPart2659000.7s5MMGUR32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZuAv+AAKCRBND3cr0xT1
yzNMAP4vOWz42pBBdfOi7bFUKqGG5FMHqf+B0fLQbv2d2diGhgEAkyF9prdNC8k0
RX1aJrl/aoFbyY944ujcUZwra+h5ew4=
=2o8c
-----END PGP SIGNATURE-----

--nextPart2659000.7s5MMGUR32--




