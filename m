Return-Path: <linux-wireless+bounces-4338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157A8870557
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 16:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C7E2813E2
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD33FE58;
	Mon,  4 Mar 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FmAVzTGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0F3F9C0
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565808; cv=none; b=U9nFUceE7xdzhlq3UWDrHpgFNE7dA/fp9xOLH/t2IVfbBTOLzEqgDwrnJYJ3zSt6nVc2E3Sgkv+HJdzhI2HsDzpKNj9y+CwoK9cE9Wopu9DK6qjRwWUFZHz58lJsn0/7r4NdfzFv6LwGMJ7LfGzzanw8KTOrlOxN4gi1quceQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565808; c=relaxed/simple;
	bh=9T3EbTHONBgQcb3H7lylWbmDBuwbd0RkfktleVFc5fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LtUrYJrHAcclUOZg5TeSQOiFp34ISFA24mQmOo3cXcoqIJ7FY0946VKT522Y1Zvql6K3xHq5fKrk/tu7vQushIg8yR7nap1S3sygFCSEtVzvD4L1bXlmg9J7DXOgHEs979qCIks7eIh6vOZcAbd+8r4mbaYKceRkYBpTnt+7mBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FmAVzTGp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9T3EbTHONBgQcb3H7lylWbmDBuwbd0RkfktleVFc5fw=;
	t=1709565805; x=1710775405; b=FmAVzTGpnyLq8UA4MCkl71SaX0l7kWjSQ/lUnE0KMpvOtYl
	apNeDgampNmonUY0wui1rZ82bZpIZK5xnwB3rLQ35WZEXltoOVrkqaEtu35/JT9TfZYheokqLHwoD
	U6hdSzRuv6GRHC4kBm/ecoIu50fBplHMCmjgNAqdSRD7dhp1OtQ3WZZ1/uZWjuYd77FrvOxZwEvxf
	M4449bJswDmUrKe76zmyd37IOoGxU2a46Md5K2u08GTMLR6+dZbyejU/PpClHyeGgUIn5rpOw2tbw
	3dcGQE7DU28ZrpAIy8uKY0jnOT4iVFLXv29L8JDnTo6fa0QGIu39SL8DFIN0t4DQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhA9q-00000001RxJ-1MPU;
	Mon, 04 Mar 2024 16:23:14 +0100
Message-ID: <91955fe006705879b5debbb1618262754ea4be7a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Adjust CQM handling for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>, Miriam
	Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Date: Mon, 04 Mar 2024 16:23:13 +0100
In-Reply-To: <8734t682er.fsf@kernel.org>
References: 
	<20240228094753.bf6a3fefe553.Id738810b73e1087e01d5885508b70a3631707627@changeid>
	 <8734t682er.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-03-04 at 17:03 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > From: Ilan Peer <ilan.peer@intel.com>
> >=20
> > The CQM handling did not consider the MLO case and thus notified
> > a not-existing link with the CQM change. To fix this, propagate
> > the CQM notification to all the active links (handling both the
> > non-MLO and MLO cases).
> >=20
> > TODO: this currently propagates the same configuration to all
> > links regardless of the band. This might not be the correct
> > approach as different links might need to be configured with
> > different values.
>=20
> Is that TODO link there intentionally?
>=20

Yeah, we need to consider this in the context of what wpa_s wants to do,
etc. So this _helps_, but it may not appropriately resolve the issue of
what this API really does.

johannes

