Return-Path: <linux-wireless+bounces-2864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697CB843823
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7D4B2116A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE55DF21;
	Wed, 31 Jan 2024 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="evlkxGxz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB55DF0F;
	Wed, 31 Jan 2024 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687069; cv=none; b=PEuROIfsNKue09sFQxBHTo+vnIR9cyceRoOkcIBjbtVd+Co979SsX7jRX+Og6wyiUwb5WcDqRx9mCIHkBJNA6GYoGbSZR+MPQg1MCw8VBOWMatjOzGPR3P3jrfnmKRa/wF1mvLwcWZIMk/EtOR2rUS+IHLKM9/5g87Bg0Xe65So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687069; c=relaxed/simple;
	bh=mQKIln3W0ISq3kuNCiQzmdN7IQWgnmxq6RpOiDib6vo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvyu5UzZski1i5lSGy2RMfflt9RkDgJM7Sw3LMm+adoKEUvZGCPKmPZc80lfb0dKDAYO37LGB+jowO2EnNrGCCATnEROUFiazzPQTX8D7u5ff/sZgl3yPpM2ZRc5SHXo/4NcdLNYKankNYN0DO2efvCIdVVfomIc4D33BO3VzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=evlkxGxz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mQKIln3W0ISq3kuNCiQzmdN7IQWgnmxq6RpOiDib6vo=;
	t=1706687063; x=1707896663; b=evlkxGxzUaRpTfqBeiw36jlOKlJbpdtIxG2C7feL6YcShIo
	mnKUm7xbSyaXOBNsgkPvkFpgoKn6ttKlI/onLBjaR8ICbl8dNCpceEs8KGI4RaG8sfEEVwyU/P0NN
	x0CxMuTK44PAlal2xb3p9NxR5M+s39xWhFEy8OyLY8LmIWcvez0sL/3jZDd+UyNlKgl5O7gXfVacP
	e+fpegTxGkJHZbvDYrKM6AsRehyFPJ8OuhfGj/vNv9Rf6rHIR5FbAqmDTzr75soK7/GtLYECrcWYi
	68chELfQ7wZUaqc9RDxCzZqNFwpQpb2rffpqNXsRp6MH/l4cKpPxRSRFo4NVd/xA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rV5Ge-0000000763z-0yT5;
	Wed, 31 Jan 2024 08:44:20 +0100
Message-ID: <912f1d0f22815823fa3c199a434d7510412e60fb.camel@sipsolutions.net>
Subject: Re: wireless backports 5.15.148-1 released
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 31 Jan 2024 08:44:18 +0100
In-Reply-To: <14959b08-35e3-4a86-acb8-04ee0a218271@hauke-m.de>
References: <14959b08-35e3-4a86-acb8-04ee0a218271@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 23:09 +0100, Hauke Mehrtens wrote:
> I am planning to drop support for kernel < 4.19 from backports=20
> based on kernel 6.1 and later.
>=20

I guess that makes sense, 4.14 is EOL at last :)

johannes

