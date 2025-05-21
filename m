Return-Path: <linux-wireless+bounces-23235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E2ABFB84
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 18:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F3B1BC1F3F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52031E47A8;
	Wed, 21 May 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RQ20b01C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C41459F6;
	Wed, 21 May 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845942; cv=none; b=GnbnmlX/aSoh+CvkbvwkXlNtTd9aXAQ5lJJJGpDRRrzB0nrVU28bfMMifgQEu7o+Spf/vwi0hzTLhOcIvDB90pSG2+1QMUkA5TRPu7fKqXwMKMmrnNwgoLuYrGsHQHeXyYSLYYLgdBEDEBZHxRUsSYtti5cEvFjy2fSOcpP/CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845942; c=relaxed/simple;
	bh=Bplp0R6ehE/qK1Y+wrRr+0p/f01IFIQxvxbQgueu2vE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3tn7V3wohaSSJjeg1QheVwLEXEdFiLVbMAIK+9kwEmHw2dEeBqw1jGgRDg2YH1Qfetc4f6OLNtmWPiQN/3rybixWSy/swtoV2p9zIxb1J/rcVIz0NlG0tha9kq+EAdeFszCEj1ACJeJ8cD1mUoRwHLxfZ7S6CT8rryVGrEe3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RQ20b01C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Bplp0R6ehE/qK1Y+wrRr+0p/f01IFIQxvxbQgueu2vE=;
	t=1747845941; x=1749055541; b=RQ20b01CdDfLdLDQmSaB9njtfdlO127q3aNSzy0lQGplef4
	dqaKT+75a4BhywUc6ZpTq9u3VIbD628AsjfkTtL+BhY7K5FrT8wk0RiG4rlpt5kT2YGFQdJ+X6XgW
	Y5ckZYZGBSbFaWGWObcmRJDhknnMgixafdf6AKDGAtIEltB+SrT0XfAhbnsM1qY0CrfLAMWbkTPFm
	VDxLmUxRVQNbFQO0X0j+eklXafewMOOhSCzl+zIOx/B9xdTIuyFh7CHOQeto0dDcCxppb05Bq5N+Y
	a6C2O9tUsCTM7UEbSLXW/Y5bud46FHWaaU6JHjLSK7Qw3QUZXOAzP/LsXDmGHmOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHmZW-0000000Eovo-2s3q;
	Wed, 21 May 2025 18:45:38 +0200
Message-ID: <1418960c71272ec745fe2186a769e8b555dfafdc.camel@sipsolutions.net>
Subject: Re: [Bug] soft lockup in ieee80211_handle_queued_frames in Linux
 kernel v6.15-rc5
From: Johannes Berg <johannes@sipsolutions.net>
To: John <john.cs.hey@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 May 2025 18:45:37 +0200
In-Reply-To: <CAP=Rh=PV2nqPkBV8rALZRHLO4n58XwKTYRGYkS5snNc0Zo0YuQ@mail.gmail.com> (sfid-20250521_183237_575261_4D4284EF)
References: 
	<CAP=Rh=PV2nqPkBV8rALZRHLO4n58XwKTYRGYkS5snNc0Zo0YuQ@mail.gmail.com>
	 (sfid-20250521_183237_575261_4D4284EF)
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

On Thu, 2025-05-22 at 00:32 +0800, John wrote:
> Dear Linux Kernel Maintainers,
>=20
> I hope this message finds you well.
>=20
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.15-rc5.

I don't know why you're rehashing what's obviously syzbot reports.
Please don't.

johannes

