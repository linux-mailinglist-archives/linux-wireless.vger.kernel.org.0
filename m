Return-Path: <linux-wireless+bounces-14466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B169AE46E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 14:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1874C1F23621
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0A1D5144;
	Thu, 24 Oct 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HQjTmV+z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5151D174F;
	Thu, 24 Oct 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771871; cv=none; b=O9uSm2bXS6WkCsJLDU/VIfoAMtdu+ARB/GxbxzkIwJnIzIO1qsGTfYfGXPlJ7skIjQpHnZsmr2irbz0EMD+PIzFOSFoCnJSPybz1Pg6bq9xUacd4NZ3S46QTZE1hF8EM4r4Bezl6SCpfDar6PRB2rpXx6pZ7JndeG0psBYkzygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771871; c=relaxed/simple;
	bh=wMU6dY7TVg6TAJC+av7cXdBdpRzCOepMRELr/Bpf0v4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GI5eU4vSsNpkoyGs7JTVbhXdMYs8bBnKaLIfecrZD5XstGeLft8QBCzVNU3bblnJfx++vEI1QesHkOU7OLqMsH60kdFFnk3sX18l2MsUWeBH5NC3VSsvHPPMBBJF35L5SZp7rXr+SlIC6nvqe+8+EYg7N7XL9UTT2NjqR938e4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HQjTmV+z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Yv5vMmnHB72ppkztkQfrFSxWLbID9R/jEsBocXpljV0=;
	t=1729771869; x=1730981469; b=HQjTmV+zVvx6SEyDYOzw6OtzwKCEurZyVUYtzt7KST1IIft
	DjeQryY8ny0DZtjwiV+yw5dEfho6n52x6dxki+ZSTNMykTrmd7wpK9DEk16yB/2pj06/l9ytjkwZ8
	l/QUEASPsyKV/k7xsSTA293XQg4C2g5IRIzfrt8uZMmb44u7VKp9RhI75Sjz2eyphoXgiBbiQj1um
	b4wNmAzGk/rgbNeXWWqOYH4trtAnoGT8lviDSMOIGyVeQpZWYIgmG3jrEPbzIF/KKPvoEh5hlRaKy
	akYyrHk/NZY1zEop/yAeMJiEgvszhlOLr/MJD3z1UDXMfqZJs9zdU/fRHyzrzARQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3wgE-00000003d7E-2l86;
	Thu, 24 Oct 2024 14:11:06 +0200
Message-ID: <6461c18e0be520b4f7ecefc910af5d8dd205bce9.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 24 Oct 2024 14:11:05 +0200
In-Reply-To: <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
References: 
	<20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
	 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
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

On Thu, 2024-10-24 at 13:18 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> This is mostly to illustrate, done with the following spatch:
>=20

And we can extend that and get bunch more:

@@
expression attr, def;
expression val;
identifier fn =3D~ "^nla_get_.*";
fresh identifier dfn =3D fn ## "_default";
@@
(
-if (attr)
-  val =3D fn(attr);
-else
-  val =3D def;
+val =3D dfn(attr, def);
|
-if (!attr)
-  val =3D def;
-else
-  val =3D fn(attr);
+val =3D dfn(attr, def);
|
-val =3D def;
... where !=3D val;
-if (attr)
-  val =3D fn(attr);
+val =3D dfn(attr, def);
|
-if (!attr)
-  return def;
-return fn(attr);
+return dfn(attr, def);
)


(also just running it multiple times finds more instances?!)


johannes

