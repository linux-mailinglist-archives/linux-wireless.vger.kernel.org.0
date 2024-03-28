Return-Path: <linux-wireless+bounces-5495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CEE890948
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 20:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E65D1F2383E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322E1369AB;
	Thu, 28 Mar 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eG5PI9JV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632C1C6BD;
	Thu, 28 Mar 2024 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654363; cv=none; b=DKL09O1MlQgPEQsqffbB8zimbFkZAZAdWy3tPILy4634a7lpNDjrX2dCsM56sv1pWu1HOU6ywkSTtsQJ52Yk5K2vWSNchMH4voCmwzyj17DOrDLBGQ0duGizE0+dR6OmYZH8WzgRX8Q2i1PihqzcCOUreKRZI1FCGfyBQiEdLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654363; c=relaxed/simple;
	bh=HHi1NCcjgbQrsX909aBPkyDgJxO80H1X0GsrKc/s0qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/zK13A6MlQZKt0UEB2DpOlDUqg2pixcxaRkelLp9pXQg0YOM787u0t7D1Ej1oyzHWuBNY2bS8nZtTpFq/Vnh/Bvgg7GBh+Znnn/irIV/9D1bI/5Q5FM1wSB687pdbgugjl48D54U+7Ro5aUwjpxpG99hEDoO//gP//yzg4Djb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eG5PI9JV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HHi1NCcjgbQrsX909aBPkyDgJxO80H1X0GsrKc/s0qk=;
	t=1711654361; x=1712863961; b=eG5PI9JVlTcvWG6Ko5x9UZBROJSEWDco9KUJPPmbVIuCaJ8
	He2nWKchwyDa/dv0/+PjzPhnMm1gHpExj8qNaSqSuzTHJzccUkMOVG0/HL97cOMUOi4oNG6TtBZp1
	DbpCLC8xjSW8ZNa05vl5vhUUZcA8Kdu/W0HwjmlDee7sxSl3p0M2oAaFGquPZbgrAAj78vLiE793m
	IsFIJ14pzWK1eNeXQy/8tGY3kYy8CRIqvB//EpZcntSWbmOTfUrI50hcX39q/XgznyeNzkanPwR/R
	HsH2TjNsMBQ0nVg2uEwEfiL6J6qpzvM/6wLLGa9urcpdkyngLSaby1agOzbrD+Sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpvUL-00000001GkI-02Oy;
	Thu, 28 Mar 2024 20:32:37 +0100
Message-ID: <1e0e09fa6c1d4111f48aba93c1e16d906f5f89c3.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, Vasanthakumar
	Thiagarajan <quic_vthiagar@quicinc.com>, netdev@vger.kernel.org
Date: Thu, 28 Mar 2024 20:32:35 +0100
In-Reply-To: <20240328115739.78ec5650@kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
	 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
	 <20240328114903.1d0c8af9@kernel.org>
	 <485ca445f0f0c47179a338df2538e74d520627ad.camel@sipsolutions.net>
	 <20240328115739.78ec5650@kernel.org>
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

On Thu, 2024-03-28 at 11:57 -0700, Jakub Kicinski wrote:
> On Thu, 28 Mar 2024 19:53:33 +0100 Johannes Berg wrote:
> > I suppose we could even define a
> >=20
> > nla_for_each_type(..., type)
>=20
> That's probably a good idea for the kernel! We already have a bunch of
> the loops with the if (type !=3D DESIRED) continue, as you mentioned.

https://lore.kernel.org/r/20240328203144.b5a6c895fb80.I1869b44767379f204998=
ff44dd239803f39c23e0@changeid

:P

johannes

