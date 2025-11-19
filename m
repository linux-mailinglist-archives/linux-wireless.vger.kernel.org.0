Return-Path: <linux-wireless+bounces-29133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6A7C6EAA0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 14:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 329743A6A9E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55CA35CB96;
	Wed, 19 Nov 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="c4pe6OOj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1407359712
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556674; cv=none; b=XxUERJ1w8Y1eRPGMs3YU4JUUbQ/0AtI7Wq1daapSJVaXmhXkU0KqIu48JBYQMQ9Dby7/gcrPtxO1vGAxTsEyCAk9F09qQzR/Zu0g09BkTt8C1+dmpqvlCamAe0OKo8Qav0+/PGNaxpOZzrSYz46TDMgpVXPW3ufmcFR1nxJxVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556674; c=relaxed/simple;
	bh=vb+vVqzfu6frLthfwYque9tPOlidPhFARRvyEMqVlr0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TtCo/nBv3wMUnLsw724ARgeuH9KaBV4SGo/NId/iORKFMC7CZECEohqSog9Rz2ASVYhzhGlnvPVfCfXxk00OUBJeGxAy5X3YGx+As6Kh5eQrpAhnFsOk579zXPON9ZGoiftJZR4GzrFnpBlu9/Ey+M+pKJUBQYexH+lDPOLCOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=c4pe6OOj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YdjXY7Yg646RRIFhyvF6GZaKELmBnbutm8wohnODoc4=;
	t=1763556672; x=1764766272; b=c4pe6OOjPcXixzJ6ielWRQ4lP39vdRowpH4V8jJXGkYXL/g
	B0Ye6tsNeSc+URoZ3vC2p1q7v7e8ApRiQM3WGRHe1Txp7d063dDI2GEeIxkNky/nOU/XqqCQLF+Nw
	7iRZjfZ1lY953KlkNftBG5rx95rui812DQuo90RdyruHLM80J2Lzor3yjGSV0hUSsLXPp8LaIPVDp
	FXOLmnZ2P1V83lc/COsropANEc2UQmZDvgrHc5DtRDIk4L98R9Yt/jtqLYqoZxJPBQunkajmPUnpr
	27+RX1seX9ZA90cUncyR/a5dg3w6fCwmqONU42qqQ0r3bEBmOIjpIl2YzuUGD9+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vLheQ-00000002Che-0cp9
	for linux-wireless@vger.kernel.org;
	Wed, 19 Nov 2025 13:51:10 +0100
Message-ID: <6535091517a614fc96cc04d2f449c85c3c0de1ca.camel@sipsolutions.net>
Subject: Re: NPCA/DSO configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Wed, 19 Nov 2025 13:51:09 +0100
In-Reply-To: <dd57945cae41bde3f271187db349ea7c2b7a2485.camel@sipsolutions.net>
References: 
	<f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
	 <dd57945cae41bde3f271187db349ea7c2b7a2485.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-11-18 at 15:41 +0100, Johannes Berg wrote:
>=20
> So as such then a chandef would get two new fields:
>  - npca_chan: the channel pointer for the chandef, and basically a
>    chandef has to be valid with chan/npca_chan transposed
>  - npca_punctured: another puncturing bitmap that indicates which 20 MHz
>    subchannels are disabled for NPCA transmissions, always (by spec)
>      (punctured & npca_punctured) =3D=3D punctured
>    (if NPCA is used at all.)

So I wrote that code, and it's not that hard, but now I wonder ...
should we consider the NPCA access parameters part of the chandef as
well?

On the one hand I'm thinking "eww no that's awful", but on the other
hand it's a pretty integral part of using NPCA... I guess I'll think
about it more, but I still don't like it :)

johannes

