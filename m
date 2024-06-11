Return-Path: <linux-wireless+bounces-8788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE299039CC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EFE2850CE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9D14F10E;
	Tue, 11 Jun 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AxwV6/iK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35413E8AE
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104688; cv=none; b=p+T7mXN+lYU2w22MlHMYJcazKdrjyDWf58zXmQ1Iorh7RnNz5pja0LxEqGV3Xn5vs1NsY4LBaMV7KJ1eh8lgCIZjcigsCPWj5T3lLo/gwz6pP+irX3r26eDAH3xLts1v/VI2ReCmRrR+wMeXTsyOmMLr7LpLgW6hbj5XROe2/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104688; c=relaxed/simple;
	bh=vnygC5WBBXsEj21WH/J8LxqSZv3WVKaQ2J2wUD1PSnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=coFSB9jtZogz134pcPDIYSwxob8pGSMgBJgRVW0+oETFtjx87QE4XM5Xp/WyhO/YHgEa45ioyjUeKXyI23ju8upUzFkGxOv8hGgdUiODtbmfW4qWwGV5W0ryWT3kkdd7dP1DC1TpiDZbPH/vQx+r1eUqaDEPMFWk+7y8eJCn35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AxwV6/iK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vnygC5WBBXsEj21WH/J8LxqSZv3WVKaQ2J2wUD1PSnE=;
	t=1718104686; x=1719314286; b=AxwV6/iKU5EzFcPUWGZ8TNgro9xH2EUdtINq2820HmiTMmB
	POM2peTYkL6DC32W+I3gP9Ny0Tq+HqH3MbnwcNnjZ4OZzy9VqwGfbC/YmGd7eTe1dey9DAXHRXuuN
	ls4Kbf85sPRfrf51xGfN1KLDdNu9c4cF72oHujR2o90moGnLQWKtORkDxmkr0jxc1NMWM1QPJhzdr
	VOIbRB5VFCGxxastTwISd110ggbgYhd1k8FkY185Bad5oaJWalbhBWR5YPJycs9pF+cXbr8/ncCe/
	V+WjOThuFEpKqTVKIDt7++QLPJbbzt2iKSgV4rnm181EBsDlkqrrFL44G7rwhn7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sGzVr-00000008Wml-0Rkd;
	Tue, 11 Jun 2024 13:18:03 +0200
Message-ID: <6bdbcae5cfedccc507426bde60fe86e72212ca5a.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: unencrypted message in 4-way handshake
From: Johannes Berg <johannes@sipsolutions.net>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "Le Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	 <pkshih@realtek.com>
Date: Tue, 11 Jun 2024 13:18:02 +0200
In-Reply-To: <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: 
	<BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-06-10 at 13:50 +0000, Sperling, Tobias wrote:
>=20
> recently we moved from a 4.9 kernel to 5.4 kernel

=F0=9F=A4=AF=EF=B8=8F

> Do you have some hints where to look at to solve the issue?

No, way too old.

Take a look at supplicant logs in how it behaves differently, I guess.

The only thing that comes to mind is that *maybe* the eapol-over-nl80211
path gets used (different kernels) and that has different behaviour in
wpa_s, but honestly, no idea.

johannes

