Return-Path: <linux-wireless+bounces-24433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F605AE69B9
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700A41881C04
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400742D8DDD;
	Tue, 24 Jun 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ofQDJGX2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841042D8760
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775822; cv=none; b=dMv/WGg7dzyzMcXdXSaboFMpkh7hfDPOTDeyUAzel/0aRerusbZyVehhq3Q71XfD8okZclXldAqcI6UH41AwbXTs2UdkDf2B7XUOqezK0UeesHTgzbkSrtiYNPKMLAiExHv+mjxl4godN7+YcA4WTiNfvh00Pj93cVYdpNJ1gKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775822; c=relaxed/simple;
	bh=uMneD8dgdZ8itGS0JXQLr653uUvavmXifsnS1P9ttq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+Cc6WS4Jm1n3HS+F5bxZvpau/yZtccQEhxOPvb8Q9uqiP5BcVG9bYL8OLBiziBp86+w2DoXPPCNQcsUMtYS657ahT1S7X19fPdQxuPyNbK2sxFWvuqrPayqczCJKhm8GfE1xK+VrSrKUGSi6MBaCjIHjWb4c9RhtOwEtRTjpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ofQDJGX2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uMneD8dgdZ8itGS0JXQLr653uUvavmXifsnS1P9ttq8=;
	t=1750775820; x=1751985420; b=ofQDJGX2xKomp4p8Y5wrGpETJQPSHVT0Z+jTexfvOCwIIG8
	YqToK5f67ZforSUNdFhGHaOZakZiCqBlIhd3KLfAPH8iz50+76TG4jZHAk4rmglRd8mDFe+QQi2TN
	7Z3qH6JNCDd7YpLblBxC23/iywzT5ZEQg3GTVuva2vaUFtM2STK/NWnIczoqWroPz4+DASXPoXZAE
	RTx8B2tKdp/q+9pGAr81yNlysi6yQ2Ncfh0HCVtLCeWZqmmgMFR2SzWwIg0Cigas6lta+0MAiQ4Pr
	oPzwoypGU30ql8Djs5tH5qv00ElQd6zMI/ven+7QqaU+Cj5HaN3QYg4M8o8dbgTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU4lb-00000008u8e-49Yj;
	Tue, 24 Jun 2025 16:36:56 +0200
Message-ID: <240506063ecb64fc0e7ffcf13b7d4649cd46a3da.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v10 00/10] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Sarika Sharma
	 <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 24 Jun 2025 16:36:55 +0200
In-Reply-To: <4872f305-b597-40b9-aa3e-c079f9e0f27a@oss.qualcomm.com>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
	 <ae46cc4ffc3ec8c776f70c4c61031d82ffdc4be0.camel@sipsolutions.net>
	 <4872f305-b597-40b9-aa3e-c079f9e0f27a@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-06-24 at 07:06 -0700, Jeff Johnson wrote:
> >=20
> > I'm going to apply this because we're at v10 and I'm losing track of al=
l
> > the changes etc., but while looking through it now, here are a couple o=
f
> > things I think you/we should still change:
>=20
> For clarification, do you want to change these as a v11 or as a separate
> series after v10 is applied?
>=20

I was applying it, but ran into test issues with other patches, so got
delayed. Should be any minute now. So separate changes please.

johannes

