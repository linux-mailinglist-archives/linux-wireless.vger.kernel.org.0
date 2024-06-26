Return-Path: <linux-wireless+bounces-9603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD439180ED
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AF2824E4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116A17E911;
	Wed, 26 Jun 2024 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kScL+BE7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A515FA71
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404764; cv=none; b=XrSI0/TYe+yGMJD/UCxmtk29YeX+vUkI/MXfxbwbb/VoDu+UwLd+n8GI4Jmkgs9kVpuxu21oRRcu6qdoay2wFqHJpoDDwJFiN90x/33NI4kQ2BwhAOYSOe6AhjrWzQPKD/zissEj5IYodzw+nxpDfbCWHeMyefxNgTCk32FF7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404764; c=relaxed/simple;
	bh=c6UT0gS3+HtLPvlVhliSd1M50rTBxMRi2mM22Yr7eRw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fapq8xFOTIN95Gtj9NatTONEkyfafSydS7l6SUlWaMZXhWLMfyZrUGwEWoSmZ+cpRzAYWjVvHgfGIiBcQM70Fplqd0buIpQJUwc90bscZQdBG1PTwomUP90PyR67VnxeQYnXvl4gI+nDdKDNfhzps6NTXrGSKvw4JCykAYtqAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kScL+BE7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c6UT0gS3+HtLPvlVhliSd1M50rTBxMRi2mM22Yr7eRw=;
	t=1719404762; x=1720614362; b=kScL+BE70ucx3wkAh5txRb/Uy5Xqq4E2c/DvQy6xLOufGmE
	CKqe1ZDBd/4TvKs87Qsiznr7tCGRI7pw02CPCXsJv6LzG/Q+/oTPSuC9T3oQzoYUT0xkLo80UeSSv
	sNxSDXAzEF+S0UHjLTM720tf0WWthzok8cHZDHA1CARE+r9T6xG/snrELLjtOtE27K/ohr0CoOOw8
	qo6enCNu4YMwlY9Q337rkEwIqJNOD9nm7UEsRi03J4K5Ti0E8UR58UEiZ6dVMebhILW2/SX0yz72X
	0uQvK1TGLQz4ERQu+S9UmnH2mTZ75/14eqfws8gXz3DAADCeMxx+jhAO8FjkUZNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMRip-00000003c8n-2rhO;
	Wed, 26 Jun 2024 14:25:59 +0200
Message-ID: <65e48b46d81268ae8ccab7f21bb293320440ec40.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/9] wifi: nl80211: allow CAC while other links are
 beaconing during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 26 Jun 2024 14:25:58 +0200
In-Reply-To: <20240626045216.3754013-4-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-4-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
> Currently if any of the link is beaconing, CAC can not be started.
>=20
> However, with MLO, it is possible that interface is beaconing already on =
a
> link that did not require CAC, but now another link is being started that
> does require CAC. Hence, same check does not apply to MLO.
>=20
> Add changes to check the link under consideration is beaconing or not in
> case of MLO.

Also this really doesn't even do what it says, since it just checks link
0 ... I think some reordering here would be better.

I'm also not sure it all needs to be in this many patches? Might be
easier to have fewer, and put e.g. patch 6 first since it's just trivial
prep.

johannes

