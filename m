Return-Path: <linux-wireless+bounces-9417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90232911E8B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C07A2827AA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96316C863;
	Fri, 21 Jun 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UlINek0F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54016D4D7
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958102; cv=none; b=onGrDyeily2+2OQai2lcYSf9TdetVC6vAh7fLDgrpc/WvY9kT0JaOyP6ZaXEWWjqzz24tlFzGE9g06w5AJABHc/RA42Gxq6qsCMJd9U3X7rxYmqjCbQgtafESHu66napx2o5BEs9igonf4LtIsyO1O6vj7I7fGnQWfK8w8tip7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958102; c=relaxed/simple;
	bh=U1xmQpWGsjWQda1p8ndKjiH35/ZHpzAoDvnE7zeCxrY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhuvBwM5VLRmQek9LlruJDC/fJPJ7uh0pVf4A1K/v3MpFb+6xKfnG2EXwbJOp0iID991yDONYtrhuTPL8eTa6i8FzwF50a/vdPywaBus5iUkk5z2Lu2iIg49EjrTKtt14wKmxAXqhfy/GYJ+y1P6kO/TyBNngBXi32HsJgLuqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UlINek0F; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=U1xmQpWGsjWQda1p8ndKjiH35/ZHpzAoDvnE7zeCxrY=;
	t=1718958098; x=1720167698; b=UlINek0FzNw3VDQKkPoUWNX2ntarRG1R2Tt6Q4TI5QJK9YI
	b+QEC7Ds1iwocJ6ymY5YvX/EA/aNmT9CxeNzXXpyfsvPXuTecoAxCj1FsxvR2F8h8afBOPuak8HQ5
	Tc1sg0cVQnCleCeRpGBKbh7KnW++fO/N1qY7M7MEeCv/Nce7gSh4xy4a3NQOSO1mfbBu5peY0viu4
	FIWkrNQiDMSn7zU1i+Idf6/6BcT9ZlDa1Z/Mv8SISOLC/2qATerc5Mxyz9ZcTBtl7krfGOypLO4Es
	obLAzx7G7Elv0OBncuzP415NZVw3fV5iEATMn7y34dpcj6KFOEzYHo9gxcofApiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sKZWZ-0000000BgQG-1HcI;
	Fri, 21 Jun 2024 10:21:35 +0200
Message-ID: <efc8cdc0853a921ce4dad1a36b084608fe0b01a8.camel@sipsolutions.net>
Subject: Re: ieee80211.h virtual_map splat
From: Johannes Berg <johannes@sipsolutions.net>
To: Koen Vandeputte <koen.vandeputte@citymesh.com>, 
	ath10k@lists.infradead.org, linux-wireless <linux-wireless@vger.kernel.org>
Date: Fri, 21 Jun 2024 10:21:34 +0200
In-Reply-To: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
References: 
	<CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
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

On Fri, 2024-06-21 at 10:04 +0200, Koen Vandeputte wrote:
>=20
> memcpy: detected field-spanning write (size 64) of single field
> "tim->virtual_map" at
> ../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:=
4043
> (size 1)
>=20

Check out commit 2ae5c9248e06 ("wifi: mac80211: Use flexible array in
struct ieee80211_tim_ie") ... :)

johannes

