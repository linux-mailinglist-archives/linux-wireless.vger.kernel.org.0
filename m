Return-Path: <linux-wireless+bounces-19173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F1A3D30D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB59D3BB6F0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40B1EB183;
	Thu, 20 Feb 2025 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lN0AghEy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A811EB181;
	Thu, 20 Feb 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039725; cv=none; b=ktGV5pMUJeeQRTtpl2klUN0tGbaufBv/VxYP7gzQ79kfZXUzoU0oAE5OCJBbSxlCHMemYhEvZZYJxeOL7s7Yb9AjizbZjI47Mzn/yOit0KkuFs9oEtTPQY0yUpbnzy22lCnc0RpEApRGq6lz6N6iyWeMr61kEGtAw1OhP+qzCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039725; c=relaxed/simple;
	bh=ngy4VSTw6cbr0NhLbcdeEVL5dA+MQxWppEmRRRV1CdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CakZ/htzeJsCniBX366EY5hcAWcl4G4g6kkgczXKgojfTDjdmHKKCe63LMlFukKmm0kC1oAi0aDkbk8vChyq99oinsKcGxhIVoUyrC/5BrQjCgk5gwchNeey2Fjf+GTzGeVI6W5RtaQllwYcVD5GyQGnKfOlgFFrDXGOXFzxJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lN0AghEy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ngy4VSTw6cbr0NhLbcdeEVL5dA+MQxWppEmRRRV1CdI=;
	t=1740039723; x=1741249323; b=lN0AghEyo9itfdcb3uptqWHHxfNi4HvoB1DutXXxGD8EXom
	o8bK6kMusRZYlcYUJFjiMCL1iMznsHOBEv2U19AJx9hNBG737n5h2Kn6GuYT6lx3wSDjYWOXSJv7X
	9pb2sLyAKrwUjG78e10e1uV0bZ4spElEMo5ZSACOp8K69hZnLjGBYgrYV9YyRVBIOQ4a9i1DFWmCh
	bvdPQPKgFdZmDt3NEglZgiMHYPddaS/N+/CdFJdqyHzg4r2ASl+Nmx1amZmOAiEtF6S75eb7/lygz
	+ofk5XsyQRLknY5nn1KMMNvZZXkaYrcuSGyzymD7YsBmAGt88mONeq5oXSqWdmRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tl1oV-00000003mf3-3XO1;
	Thu, 20 Feb 2025 09:21:45 +0100
Message-ID: <532b0a5081addd100d42642953347d09a29d1418.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/2] Resolve the failure in downloading
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Date: Thu, 20 Feb 2025 09:21:35 +0100
In-Reply-To: <20250220061143.1417420-1-jeff.chen_1@nxp.com>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
	 <20250220061143.1417420-1-jeff.chen_1@nxp.com>
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

On Thu, 2025-02-20 at 14:11 +0800, Jeff Chen wrote:
> Hi Johannes,
>=20
> Based on your feedback for the previous submission, split the
> original patch into two separate patches.
>=20

Thanks. I guess it really should have better subject lines now, and it
doesn't need to (or shouldn't really) indicate in the commit messages
that it was split (you can do that after a --- separator if you like.)

johannes

