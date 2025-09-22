Return-Path: <linux-wireless+bounces-27564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB6B8F2D9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 08:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923D2188D37E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 06:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A634242925;
	Mon, 22 Sep 2025 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JPoIzYIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752734BA39
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523131; cv=none; b=LRVI7FdhWSGTHGcL6qs2ACFMJkXay5LE+/6KniP3r0qzQG3a2UuV57ZKxcsj9eaVP4Cdq/PI+vwidgMVNuFaWb9rN8jBObh3TwBW7kVN/WT7UrY2h5gJT25pT74ZYDC+YPtja8c8bh/1N9/rkTjiXarb2XzaaJtfIFjik+BWMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523131; c=relaxed/simple;
	bh=MhL9qRQj35lWFWioMfnmXIwmjzzX8hCzg/6EFJKux2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RY6jnkq4QNPo2LXcaqlPZa+RHXE14JUNim9xdW3y88zyo5EFi2xWFvMZxutMHPoHvb0zJu0SHqjycfp4QtyFUZGyKNsGKRcZsG/B9quRenDgnPyv0OztIizKLhRHuUZeLWQnzfs350aSZdXDaJ5u4gyKdNb7AfWvjCkzboujPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JPoIzYIX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MhL9qRQj35lWFWioMfnmXIwmjzzX8hCzg/6EFJKux2A=;
	t=1758523129; x=1759732729; b=JPoIzYIXILhxM3+oKOsBYqhXrirCYXpsf4U+U7RvU+nxKKu
	o6qr+EmBrPvaPsHKiziDZmGKtbWcwNZjQCN4pgMb1nw5fHH+eezIeky+lV2brC20DdFUN++Gk5VTp
	xMvGIQyxY6Wf0RCQ5Ux0AKNf2D6NJIKaHgrJfad/Bie0ztYrJVSOZ9SuFFAsxDG+MOkyrHfmWsm6O
	Dyb9gprrVayhDhLAmrj1GRGoaybwMbUf61Mob/G01TuPcbwJfDleae2gy0c1Vgar7NX4umWgDGSiT
	TnDQuiklW/5MgwGwP7/dUZC8x+uQ/eAijiNBwGU5m8s6BE0zp4OpPahae8gVKoGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0aCE-000000048cj-1QIl;
	Mon, 22 Sep 2025 08:38:46 +0200
Message-ID: <a1ef1d78ab5c790d5fa3b6972a604949e210ccfe.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>,  Aditya Kumar Singh
 <aditya.kumar.singh@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 08:38:45 +0200
In-Reply-To: <e2647512-82cd-44b1-9d1c-941e4df11bd4@quicinc.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
	 <20250912032105.714949-3-quic_amitajit@quicinc.com>
	 <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
	 <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
	 <6f1f2a41ff0af4c6bff8199250397fd93ae983f2.camel@sipsolutions.net>
	 <e2647512-82cd-44b1-9d1c-941e4df11bd4@quicinc.com>
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

On Mon, 2025-09-22 at 12:07 +0530, Amith A wrote:
>=20
> On 9/22/2025 11:47 AM, Johannes Berg wrote:
> > On Mon, 2025-09-22 at 11:10 +0530, Amith A wrote:
> > > The workqueue mechanism here can be removed as
> > > ieee80211_incumbent_signal_detected() will be called from process con=
text.
> > That's fair, but somewhat besides the point - it should be OK to call
> > the cfg80211 function from pretty much any context, so even if this
> > weren't the case for your particular driver, there'd be no need?
> >=20
> > johannes
> You are right. Ideally the cfg80211 API should be safe to call from any
> context. However, in its current implementation, it uses nlmsg_new() and
> genlmsg_multicast_netns() with GFP_KERNEL, which assumes process context
> for memory allocation. That=E2=80=99s why I initially used a workqueue to
> guarantee process context.

Err, no? You actually gave it a gfp_t argument in the current form.

johannes

