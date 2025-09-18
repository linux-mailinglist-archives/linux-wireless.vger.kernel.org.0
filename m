Return-Path: <linux-wireless+bounces-27479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AFB83DF8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5342C542FF5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2D81F3BA2;
	Thu, 18 Sep 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tHvjbHT7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2D27FD5D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188603; cv=none; b=XAFC2MJs9PGROVJutVc+HHFrkJJeNdebG2nE8cIsYAvytoOxcTSFDoaXDYU0dJqG0F09hn2jxT1Lhc8wqrmDOjki8aiSEzQcGgEG+CvR8/oIXHgVVCnhjd+bzYRVOt+T1ELxsxL1gTuDdF3EBYpyZePcvhCIVQbOqQJhiDwiyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188603; c=relaxed/simple;
	bh=sXMzOO76Yq8hl+r+v5wA30CkApcGimWXczoPEcr3smg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/gh2H5xi2ago5M7oPh1ovGag1TDrj2qgrg6+U5QgQGmGe/DiDqePtKir7AsTfRzMP7GJyj9AeitKXGm1kR+5Tg7sA9afv8pYb4HSGRRKH2cRqvwDxXP4WyJHIhpnKFOlfnTd/zDIyETgGuwQxNgyphRz0nXfzBQzOxi1MPORXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tHvjbHT7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sXMzOO76Yq8hl+r+v5wA30CkApcGimWXczoPEcr3smg=;
	t=1758188602; x=1759398202; b=tHvjbHT7W1s2woYNg0sJAOPj6fwhrjBoK1XjJ3RMzG4gGwt
	14RIrjP8jRiBmK1ACRxD7QHRJbIeaK92pb26Rg0I7cfnTWOIWDWjH4S/Zj1/ZH3nNot2ELZONx9/T
	TAWM5G+K+CBnAfTCfz4jqC+7xC3fkOqv9W/+10ucBycSX0JHr5p4gser4JXkx5mAlcu47uIlrqmDy
	8ZAcEWvbOXSvDt596Y+Z+Vr0OGfB9EcSQLnCvgdQz6yraUQStYtSVUood2WQFswN6ucdD8AL+Efc/
	kg9PS2jtO2Xar5OuQNkLnpF3yU8AWcfkM+uU/Toa4Nv7KLwbO2oDEKfuQ6P3rxKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzBAd-0000000DGP0-254Y;
	Thu, 18 Sep 2025 11:43:19 +0200
Message-ID: <49a1db341ae944a28b06fffc77e24bbf1af3bb08.camel@sipsolutions.net>
Subject: Re: Inquiry: WPA3-FT Roaming Support in iwd ver3.9
From: Johannes Berg <johannes@sipsolutions.net>
To: amit kumar <amit60700@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 18 Sep 2025 11:43:18 +0200
In-Reply-To: <CAJNKUtcMh9+i2AiXGxKDqa41QRrkfHbU1rR-HJEKx9aJj2tJSg@mail.gmail.com>
References: 
	<CAJNKUtcMh9+i2AiXGxKDqa41QRrkfHbU1rR-HJEKx9aJj2tJSg@mail.gmail.com>
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

On Thu, 2025-09-18 at 12:04 +0530, amit kumar wrote:
>=20
> My query:
> Does iwd officially support WPA3-FT roaming? If not, is there a
> specific reason this AKM suite is excluded =E2=80=94 such as spec maturit=
y,
> roaming logic limitations, or security concerns?
>=20
> I=E2=80=99d appreciate any insights into the roadmap or design considerat=
ions
> around WPA3-FT support. Happy to share logs or test results if
> helpful.

This is the wrong place to ask, they have their own list.

johannes

