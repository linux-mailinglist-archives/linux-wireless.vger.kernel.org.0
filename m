Return-Path: <linux-wireless+bounces-5583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E018891FDE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9ED228A8C2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D204A3F;
	Fri, 29 Mar 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fl0YAjzY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817D4A0A
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722658; cv=none; b=f+d4+MLtJBlzFhOCbM6j8KwQx0hkoiVP+nX1oiNTTCKvYo6yrsN3gqfXGKCo+IqCXT0l7RC9RbCHJSc1LdcAJmbeuFhH+eiXvHDfBicXkyOxk4SVkmc+6Ljpjr6oU8KcCecj09Z5CvUersL/QPbpikdt69+nEO3smoFuJd5fcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722658; c=relaxed/simple;
	bh=De8ky1DzZ8eM/B+kpzJ8kuVN8daku74qiajPS0FKmXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFe+uejkBFSlbvBLdOetWTdY9Bk/PBtBQq1qCFdqWw1Dg8JVzJRV+uCwV7O/hrlV6nHqrBvZwBTo00c6EOZXhxt+VERPtC46sts+h/0MhQqxR244JjCpRIrHfowMnnmU9wsRXV6/Q9K2/9rf1mxC4IcI45zwHQF60bUiikGRsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fl0YAjzY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4MxyLAQKLRPBHf7X1vQ8DGlS+2oCmN/Pbo3XLT9STCQ=;
	t=1711722655; x=1712932255; b=fl0YAjzYNlnfRWyK4z5+ufZ3ZRzEIsXf+M7eLhsnCIA1qhQ
	FueviZKrdgj72/Hld32jYJy5Tj+ZVM3t/j0B68Es14rL1x0UNeX2d5LCbOImuPk5b1pz09+rH0+RK
	zvo8i5uvgDv0/UjPoUDwvyAwDmcnJdZPW+QcBS1/0oXnIjmiUp7Mjl97iUKuk9IV5J1SjQaw5OdDE
	AzGwBKSgJ0dy4StwCmdf5fRf0kCDsjg5hrKsWCD8j+lepCDwbylbFCJO7ReXg2Zj+9fOfl9y2cAzH
	6PJop7gR9kcmkb49cuuk5O1dKza+ZM6j7OK2pt395UwPGyUfGJ98c+5/6azIKbcg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rqDFj-00000002j9b-35Wc;
	Fri, 29 Mar 2024 15:30:43 +0100
Message-ID: <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, Karthikeyan
	Periyasamy <quic_periyasa@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Fri, 29 Mar 2024 15:30:42 +0100
In-Reply-To: <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
	 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
	 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
> >=20
> > > + * @hw_chans: list of the channels supported by every constituent un=
derlying
> > > + *	hardware. Drivers abstracting multiple discrete hardware (radio) =
under
> > > + *	one wiphy can advertise the list of channels supported by each ph=
ysical
> > > + *	hardware in this list. Underlying hardware specific channel list =
can be
> > > + *	used while describing interface combination for each of them.
> >=20
> > I'd expect there to be a limit on channels being within a single band o=
n
> > a single "hardware"?
> >=20
>=20
> There are ath12k hardware supporting multiple band which need to be=20
> registered under one mac80211_hw/wiphy. This design is to support such=
=20
> hardware.

Oh OK, that was something that I didn't have in mind any more, or never
knew or paid attention to.

> I agree, it is adding complexities. I was thinking if this can=20
> be done in steps , first limiting to single band for a single hardware=
=20
> then extending it with multiple bands later but that may bring in=20
> different set of challenges...

Probably not point, yeah.

johannes

