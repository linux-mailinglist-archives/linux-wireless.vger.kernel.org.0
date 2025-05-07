Return-Path: <linux-wireless+bounces-22710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B80FAADF9B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A934E733F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973438DDB;
	Wed,  7 May 2025 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ue/jKG+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BC280020
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622036; cv=none; b=rMGGF+aN/T1F+zHKBozzRFciMW4Ue594Rc741gLNjwnKzAx4y+shSzT0hGoH4CUN6I1odGGcD0GN2DIUJEPxvYtgefScyOhD2IGngGxcJYxiWBVMi3044PgwIek5uI6xHdeNPr8gGtRHCKnr/m0xJ3PXxnz9FCo530AxM8sTyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622036; c=relaxed/simple;
	bh=qH9OTfibColAqnF4mEySvqfTZywlbkRxLMjq08xTboo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HI43g9W7klgYcSCyVJ2Be+HGJGKNVmVaQhrYjGdrSXGHqdzVGb/MAzvUttVp+f7C+fFZa1OOHFKZXiv0hF+DlTZYZ2Evd0N9/6iHvz7tis6oNet9F00CNHmjXPNy39EViQvDyjbZJU/D2M+CLgQ0xvkZShA0CUUdJPrGS2zC2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ue/jKG+N; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qH9OTfibColAqnF4mEySvqfTZywlbkRxLMjq08xTboo=;
	t=1746622034; x=1747831634; b=Ue/jKG+NtRloYhBwVpj9bjHWUt/t963Xf8tkc08SrP4GwAS
	d6BgXbpwkHqFtcJLIbJJmFFpx93O0dx4WcYWl0L4c3IhbNsGyweh7g2XA5gM/fGaBgA6Pl1njAHiK
	46LI+smAKm7SfPP/dmiB/8M4KhUAJK3JJ5aXtOHj3lutlNJ8miBaCDP5eQNnF0RWn+vKdtkdysbHt
	2/a2vC69gxSN/ygT6f2+g6waF7S6ttnxVP99zS+iWtPlP0BJFs3KpMGUe1N6RCA0/vOJw3StpfTpw
	+A8m8//PkbctF+pHu7W1r0Rm9tOvhlydujd2luNO2hG1otdFevWQ57XsUC3oQIvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCeB5-00000007y22-1Sic;
	Wed, 07 May 2025 14:47:11 +0200
Message-ID: <4997fc7c851086822d631a47275aa9ccaa6979c2.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 07 May 2025 14:47:10 +0200
In-Reply-To: <cc89028a-c785-4f83-9c17-8c98b087748c@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
	 <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
	 <cc89028a-c785-4f83-9c17-8c98b087748c@quicinc.com>
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

On Tue, 2025-05-06 at 09:22 +0530, Sarika Sharma wrote:
>=20
> Will allocate memory during get_station() call only, in
> cfg80211 for all possible links(sinfo->links[]).
>=20
> Going to implement that approach and send V7 for review.

Maybe hold off on that for now, I'd really like to have fewer changes to
all the drivers.

I also realize that you guys have stuff waiting for this, so I think to
make that work better we can also do things in stages and nail down the
userspace API mostly first, do what's needed to support it, and defer
bigger cleanups for later.

johannes

