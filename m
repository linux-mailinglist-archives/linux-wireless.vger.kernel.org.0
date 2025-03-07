Return-Path: <linux-wireless+bounces-19983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB05A561CD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 08:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79ED1884781
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312D1A5B90;
	Fri,  7 Mar 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r156DgKD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F71A314C
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332586; cv=none; b=Zn7VDmuSYtkh3D6hqCjgWTGOwOTr1fzLZSxN5ieJLrW4Xfj4Gsy4P/ExvmTnW+y/bBimpKfBmwEWd/tqgC9EDgTt5H74RTL1xUISVmZ4NoCUSs0ja8z2d2H+asa26/9+7eRLRiMvmD7QyZcboQ+8Z96bHEzR8RpgHI9h8kmciuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332586; c=relaxed/simple;
	bh=x0nGMi6DZYNGcdrtciOzKE0iFYhiIYOOp8uTemfcT6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WZ3iOZeeHkTLZshKxFjcL943Y9GosxucKSBokUwDEnYD3JNeMe7j4cxu8E7I8GMV/PXgzBoOTHCKuTLr35sNvXdsG6HFhli5t49qdGnFNvwvahFHwbr0I1PifnagP4DhWUfQsILzEzmc6vh7HrsW/kyPXHSlUsVX4kfRzSZrjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r156DgKD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WM3UZPiUX6gxrhOx2AaxW/A/RxslbFwe7tDIYCKt0Do=;
	t=1741332584; x=1742542184; b=r156DgKDo/lcAL1lug+2+mePOKP/XA41/OBU+vL+h6n9lAh
	ISt5adnAGilErMNfsadHcSGsXvLQXFfjghAr5+vTh2MrNmTbYkX+6RoKewbg/JFAtBcS31GNEYMgj
	IZawmH/we/d8TftV/D2ImS5dfuBm1q3fu7n/3P/WdYlOmnO0rhyLbAa4UdPHJYVMDAwHBh2meMz/F
	LWBtMDmoh5kFyCIMqvGWOkdVjt9Y86XsnRFl6Q9iP4G7FCREMaG6gjXZKOzSuxZdOaaNykJn8YjaK
	lcpDc6P9R7qX74FkX+smAA72zchYXjEv02lJPbOJRrGqc2T1VBX8Mx1a0qr7Glvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tqS9F-00000003kKT-3TPF;
	Fri, 07 Mar 2025 08:29:34 +0100
Message-ID: <b0a6d7d7e9a4f2bf6e93529a9f974f7d8509759d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 04/15] wifi: cfg80211: allow AP operations
 in 20 MHz configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Anjaneyulu
	 <pagadala.yesu.anjaneyulu@intel.com>, Somashekhar Puttagangaiah
	 <somashekhar.puttagangaiah@intel.com>
Date: Fri, 07 Mar 2025 08:29:32 +0100
In-Reply-To: <408de5a4-2948-45e9-a60e-81e2bb837331@oss.qualcomm.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
	 <20250306124057.a7b909d23df2.I8a8f79e1c9eb74936929463960ee2a324712fe51@changeid>
	 <408de5a4-2948-45e9-a60e-81e2bb837331@oss.qualcomm.com>
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

On Thu, 2025-03-06 at 07:27 -0800, Jeff Johnson wrote:
>=20
> > +	NL80211_RRF_ALLOW_6GHZ_VLP_AP       =3D 1 << 24,
> > +	NL80211_RRF_ALLOW_20MHZ_ACTIVITY    =3D 1 << 25,
>=20
> if you are modifying, why not use BIT()

Can we even do that in uapi/ ?

I see that there *are* users of BIT() there, but I don't actually see
that it's *defined* anywhere, and I don't think it's really macro that
the standard library *must* provide?

johannes

