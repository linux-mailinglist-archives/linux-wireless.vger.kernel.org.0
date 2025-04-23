Return-Path: <linux-wireless+bounces-21924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA0AA992F7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF959214FA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CD28C5AB;
	Wed, 23 Apr 2025 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QIvLme8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4B28CF6E
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421904; cv=none; b=Q41n8oVnPKRE81HihmIJYBFTze9M5pZvnSG+7IFhtji13BOqce17xn/ooLTvfHUZOcds1+iyhAJBpjQqAJ7KSpclL6f4tMdepwZ9wABv6qCVFdynV9BDvKLdsGkaP40mnx7YawZxhwDBFjdhcDmoepVT337PeCQW9dcl4h2m8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421904; c=relaxed/simple;
	bh=z3vlMr+SyB+YlsOkfoepQu1/yhPre0AUIEWtPj+rGPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orWoK1HBT19pSo/Z5h6GNYDi3VEq5ZiCkVxijJoHyOpWbpyVYxm/xL2m0KKqJy6sHWxt2asrCm/zLHdaLx+nMz/EE+Db3l1RE5jBzT+NpjKW3OlO3Rdh3EieaDdhtkgjHhye1bXrTYQAUcFfdwb1bv6pDti8YP2QRRfpvraWdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QIvLme8Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8t0+KPKv/ioJ18JH+ZW9DGQrfj4hDXtsEr67vUFR4CU=;
	t=1745421903; x=1746631503; b=QIvLme8Ym77cI3YoTzHfF76UBYvlLqCPmlNogh0zmbL6PCX
	d0/VBgMoVmbsPnKL8bdeE9/8NQl56de0h0AJVwrnQlSm8OH+a0SuEKbt/D6SjnMR6oubqIy+7ZPks
	24Or06hEoCfcZ20BgEZepAhXY8thlTsl4Mr77PBNCvFGZGL2RObq0/G327tvbsivzyRSYxRRHOhtS
	NGM80M4mUpKqNKr7DVmEKS0MuB5i3V1Rk8JJTqc3pHZr/QGG2XNOAPWUmCPAUMnCnrLeA3vLA3B5H
	P+Si7Is8pwrmLVBwdAfppIymlw4c/7y6bK75r0UmJJuPf0KsWF/yKmsLDvJitdzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7by7-0000000EmzS-1Orp;
	Wed, 23 Apr 2025 17:24:59 +0200
Message-ID: <9670e31afa60a810d7ae7b786c8815fd5ba178e5.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 1/4] wifi: cfg80211: Add support to get
 EMLSR capabilities of non-AP MLD
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Ramasamy Kaliappan
	 <quic_rkaliapp@quicinc.com>
Date: Wed, 23 Apr 2025 17:24:57 +0200
In-Reply-To: <20250327051320.3253783-2-quic_ramess@quicinc.com>
References: <20250327051320.3253783-1-quic_ramess@quicinc.com>
	 <20250327051320.3253783-2-quic_ramess@quicinc.com>
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

On Thu, 2025-03-27 at 10:43 +0530, Rameshkumar Sundaram wrote:
>=20
> +	/* Reject EMLSR capabilities change after association */
> +	if (statype =3D=3D CFG80211_STA_AP_CLIENT && params->eml_cap_present)
> +		return -EINVAL;
>=20

I changed that to be "statype !=3D AP_CLIENT_UNASSOC" instead, don't think
we should let you do it for TDLS/mesh/etc. Please send a fix if that has
issues.

johannes

