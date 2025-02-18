Return-Path: <linux-wireless+bounces-19096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B326A39503
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 09:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2187A2849
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41AB241136;
	Tue, 18 Feb 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fOjh5k2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F256241122;
	Tue, 18 Feb 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866527; cv=none; b=qsQypNVAQBvWGFVwhM7AW4zvEXGq2t7k/SmObbmXDrcuANdDz5r6C5icl1moxh2krDOu9AYgYbp5DGSqNh0YxSTvX1e7vS0BCcd07uPv3qi82Cbu+7iK4QvjiofAEoLNH9EN35BJU3rvu4YrWFV9q9jAeFSLf3R39W9YGJJ3kIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866527; c=relaxed/simple;
	bh=kIzCi96nV3/q5JwgPyMeC5hhqR1+he9F7aU3vXLhIJg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDIto8KfuxXsbkhEeeri6rt0mT1RtGuY4QE+l+WYLOYvNHKVRcD2PTaR/vcRyRDj7i3xkHyUimpVZd/04NsIch3JSqnlZSBhTmTakV3iXCyTjkXx5aWEr2GJ24/qsM91YzOblaJwJQ5wb3+g1gf1QfQkIG+mI91t2+oliELj21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fOjh5k2v; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=72etSD4IW1fdoCqIDb0MAOspZxQRpcvYAHDUFcZyj8M=;
	t=1739866526; x=1741076126; b=fOjh5k2vwuLnhfGIpqmLuB2M2Od+0kK9+kemXTGaWyMFPdg
	67SDUfqQWHyf0U/vvqcE7ABYEvg2IFMAR0ABNB9M5NoYvnsVRfWNuBwfB7c1sEDmkDH9vo8Lw+/VZ
	T8pVDaSBZSDrgC+irJ/zkdWiIhEJ0oh44x8u/DpoEJtMiPX0eZXuUOIGtt6ypgcu+oHxxyETX+kyV
	LDUqikhcDfs9t5nBc6tceVebCKXpsf6tik2LJmafVMnKwO00k1uR84CpArv4ZlwV+XwC1Dt7fEdst
	HR3KW0SE3K4sx7mTur+fUL3QzKd9cAIydNCahAtsOoqyVEN5bP2vd/DlP0yoN1Ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tkIlF-00000001HxQ-1ViY;
	Tue, 18 Feb 2025 09:15:21 +0100
Message-ID: <6a5eb58c06cc1d5bdeb67fe877ef3a98520627ed.camel@sipsolutions.net>
Subject: Re: unknow Network controller: Intel Corporation Device 093c (rev
 3a)
From: Johannes Berg <johannes@sipsolutions.net>
To: Corentin Labbe <clabbe.montjoie@gmail.com>, kvalo@kernel.org, 
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 09:15:16 +0100
In-Reply-To: <Z7N7AvQvv8k4OY-o@Red>
References: <Z7N7AvQvv8k4OY-o@Red>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-02-17 at 19:08 +0100, Corentin Labbe wrote:
> Hello
>=20
> I have a thinkpad t460s laptop with an unknow network device.

According to ifixit teardown images, that came with an 8260 WiFi NIC.

> Since the laptop does not have wifi, I suspect it is the wifi card.
>=20
> The laptop is running Debian bookworm, and I tried to update pci.ids, no =
more information.
>=20
> lspci -vx give:
> 03:00.0 Network controller: Intel Corporation Device 093c (rev 3a)
> 	Subsystem: Intel Corporation Device 2181

But that doesn't match at all, not even close.

I cannot find any record for WiFi of these numbers, so either the device
is not WiFi or is malfunctioning. You could try to open it up, take a
picture so we can see what the WiFi NIC is, and also maybe re-seat the
NIC while at is, occasionally that fixes such issues.

johannes

