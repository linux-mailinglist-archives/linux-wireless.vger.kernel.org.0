Return-Path: <linux-wireless+bounces-14471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24119AE8F2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29BB2946C6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB11E2825;
	Thu, 24 Oct 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FPdiZOYt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4661E378F;
	Thu, 24 Oct 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780309; cv=none; b=jtYqTcSexpSQH2pyKJBW0yykAp4XM+lGzyec297Z7V6h3sSIrgBefKOtBkoRJj/l/m40DJkM9lEpmjtB/UIkI6LamEQEYUY6gNmdwhUnpYlrBp7ViFknmsF4xbs6jTzoQUDn7Ty7kO0RJk5Oqep6IaLXdIWY4DuBR7iNVkZEDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780309; c=relaxed/simple;
	bh=0NZJiq4I4rARHG1rXNbf35LFYmAj8WzSlt0orS3uSc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RF/R8wVMQzKQVUMpE6i12shyqg83lMD6FvGJ4TaZAYirc2tTXrAGEOl/8UROenOuymg3KJpSceBDariT1+IUnAmRAan1FzvGmrsFrs/piKZszYyi84MQORm43ibZUUeWef/kn11oDusf9f0DDN2eiFxCBI661uwG6aaZpUBLO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FPdiZOYt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NZlKRTEwlQABItLaO3UOVyig+SdyAB6OM0zuFfz95XI=;
	t=1729780307; x=1730989907; b=FPdiZOYtNg7zC6u6C7ImsGoLSekTOApJO1wiIB/2nb+x1iD
	rFsI9zUQTPI192na5WXbOVVbeZz6p2sISXbIZUjVz2dIoxv9k2QLFVc3NhmiS8A0jPeqjbBTecD4A
	I9EdYzw19xIh5SsgcrjyGGk+eUeFvfHNZxl3yJd6VWOR/jgfyjIuCvP80u7D9QqfeE3s5xPpdCSk2
	gblYzAoDVDc83RbbnnqVe/u6fnFhuMUdoq3eJxml+kENJQ4VPwBiAOgO+DmsAGmNd9aYkkgXg+/v6
	x3ShI4hrdRRo/mzl3hpyKO/bS89Sl8K+NQ2VF6CcfM+nVa6fjqFdk+SWKBLc3t6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3ysK-00000003gac-3ZbE;
	Thu, 24 Oct 2024 16:31:45 +0200
Message-ID: <170542c319f6b38330a3029f1f35594b8154763e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 24 Oct 2024 16:31:44 +0200
In-Reply-To: <ZxpZp5KYN_VofWZ0@hog>
References: 
	<20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
	 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
	 <6461c18e0be520b4f7ecefc910af5d8dd205bce9.camel@sipsolutions.net>
	 <ZxpZp5KYN_VofWZ0@hog>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-24 at 16:28 +0200, Sabrina Dubroca wrote:
>=20
>=20
> Not really familiar with spatch, but I'm guessing this won't cover:
>     val =3D attr ? getter(attr) : default;

True, we could add

-val =3D attr ? fn(attr) : def;
+val =3D dfn(attr);

in the spatch for that.

But also see my other mail - the spatch can only be used to suggest
places to change, need to review them still due to integer type (both
signedness and width) issues.

> See macsec_validate_attr in drivers/net/macsec.c for some
> examples. There are also some cases where we have "if (data &&
> data[IFLA_MACSEC_*])" guarding the attribute fetch
> (drivers/net/macvlan.c does that too), but I guess you can't really
> cover that without adding some kind of "default_with_cond" helpers.
>=20

Yeah if there's some additional condition then I guess we just keep the
existing code.

johannes

