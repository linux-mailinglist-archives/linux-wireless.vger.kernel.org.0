Return-Path: <linux-wireless+bounces-1808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519F82BE86
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 11:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E9728D419
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0378F60B82;
	Fri, 12 Jan 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O2anVHQK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406B5EE9A
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bzJMTFHtUbKYgtEnCGRs6r87xAVqJ2VCgbLdPauXUpY=;
	t=1705054919; x=1706264519; b=O2anVHQKyFcRKFH2uZDeLkb0jxh9ohTtsJF13Ixbzq+VH/d
	byVUWOgq6JnV2NwR4Xa+vqNxT/FKIZ7hGM2TxJDEAqahuYd50T1j7A0qG9b1Wz7Ri/0MOKORSnkyp
	DX9kAHS67n8YPYsEWAYgHy2HeNje0DzNIwZ7XaLAa7InI3qUrLLg5XKIe5DbHiJcfvii03xWuBMho
	2hR4v3+B4/B0nCO4lsNgkYuNOnnR07TKAjPKkLWl6pa1IoJRcPosjaKWtVxPV+5E39HF6NRSt5Ls2
	ei/asal4/V7y+RFpTK+DIGlD530PluXNnvQRIO0mNEVepJhoJaBv8BVCDmjnn6zg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rOEfe-0000000GbJJ-2Ssq;
	Fri, 12 Jan 2024 11:21:50 +0100
Message-ID: <8bf953ad3255982277e8eda484b5b2a367f5a19d.camel@sipsolutions.net>
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than
 HE
From: Johannes Berg <johannes@sipsolutions.net>
To: Jonathan Bither <jonbither@gmail.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Gregory Greenman
	 <gregory.greenman@intel.com>
Date: Fri, 12 Jan 2024 11:21:49 +0100
In-Reply-To: <037b6a4e-e143-3b69-2ab2-00c4dee75bda@gmail.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
	 <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
	 <037b6a4e-e143-3b69-2ab2-00c4dee75bda@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-01-11 at 15:39 -0500, Jonathan Bither wrote:
>=20
> > +			/* currently no support for HE client where HT has 40 MHz but not H=
T */
> where HT has 40 MHz but not HE?
>=20

Yep, typo, thanks. I'll just fix it when I apply it.

(Btw, it'd help to trim quotes - no need to quote _all_ the context
before and after.)

johannes

