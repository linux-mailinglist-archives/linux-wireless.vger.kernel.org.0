Return-Path: <linux-wireless+bounces-18208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A0A22961
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 09:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AFF166582
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5014113D89D;
	Thu, 30 Jan 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ieoU+iy6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54679819
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738224075; cv=none; b=hXYSsHIwykkIPPyutkCbcA/SM1uRc7SpOrbj8Kuq+fM24kB9ICdDBAlE9RioPZkCsflL1xknHFaostru+Qmfe4dh13SJxwqSMCmJJ2eh2SPoQET6ZqhGgPWh5Zr8wEZ2yNBwRYsy7FSGPl2a5B96BCBuKjJfJj1me9hI3SboQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738224075; c=relaxed/simple;
	bh=c27sKzN0BEAy6105hPnJ5lMV9Fqdp/r9y2xguCr1l5M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imqUhtB1gvWXFbh0jGzXlHSZFIYYJHgMZZ9MAFWEQ8Pt8CVJQF++77WBntByZ6aRBP/L7KCMGN/vA2NDZ35A9DrfVZhio1L70ytawyQRyUI6eACLg6fdWUidVQqD1qddgMkq7pAxYYXqsiWD8Zi2lN9spINHhRIkOa57VgVtSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ieoU+iy6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c27sKzN0BEAy6105hPnJ5lMV9Fqdp/r9y2xguCr1l5M=;
	t=1738224073; x=1739433673; b=ieoU+iy6YXahhh9z7iT3kikqH5Y8Qvo8F2te4fajj2dW7tU
	uGyZnpTUiWT7a71UszCOD81i5vAlxRZ5lUJbHygx4RYSzsXhMiUoqcN2cxPCiodj/i5GgaPGvUG10
	P7K8urUedMRskym0sH86OVLj4q6zcKRuEQB0nasyhC/zpA/h+NFQ/CzVN9FdiWRr3CdpBpJ8KGPrw
	VDOGU8RLJhX1UgTGR/yzSRmoa5SUvdxEv7rEiy6Y37lRyM/F1GF+y/MhLRqgTJYsyE5iW9BNkdJtJ
	IT2rq//mwAMh3XOThaGiA+n/KJP1XyStMVyS8gKxKiVRLUtZPbwrLqSslevml5wQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tdPTt-0000000EwZL-38DY;
	Thu, 30 Jan 2025 09:00:58 +0100
Message-ID: <3d6974e7c46a60eeaf767d2b89d60f7d99435e6c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 00/13] Convert mac80211 to TXQs only
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Alexander Wetzel
	 <Alexander@wetzel-home.de>, linux-wireless@vger.kernel.org
Date: Thu, 30 Jan 2025 09:00:54 +0100
In-Reply-To: <ae45d808-1a9b-4f92-a99d-6acd8100fd3a@oss.qualcomm.com>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
	 <ae45d808-1a9b-4f92-a99d-6acd8100fd3a@oss.qualcomm.com>
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

On Wed, 2025-01-29 at 14:15 -0800, Jeff Johnson wrote:
> On 1/27/2025 8:26 AM, Alexander Wetzel wrote:
> > This converts mac80211 to only use TXQs internally, moves TX into
> > a kthread and picks up some easy optimizations on the way.
>=20
> It would be awesome if the cover letter actually described why these chan=
ges
> are being proposed...

:)

I guess we've been discussing this for years, on and off, and it's
mostly because of the code cleanups this enables. Some are here, but as
Alexanders says it'll enable also more cleanups on PS buffering etc.

johannes

