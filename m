Return-Path: <linux-wireless+bounces-12797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD209757C9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459B61F21CFF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808E33986;
	Wed, 11 Sep 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UAbnea+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA538DC0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070435; cv=none; b=Vy0xWrgv3m0rArcXFsJ1a6zaR8RH3AoTEnNjbTfwzU1F7ZYZcNQQLHgy4OF368l44MC3Tkmt7MZvyjf9TKMyJRz1ds8hHVE6Isd7Zhdcw+d2XKVbCLiGyFlxGvvcDlOQUhv8Il9jxSfi0ldJUKy2ptm6zfeJ2+MtjJtafnxKVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070435; c=relaxed/simple;
	bh=0iBJlVkdJTVNH/dTaH2AMDRd1BkRaHhXHrReBrPuvBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIbFai0Mbplm3kkhyls8bd+Evg6UcXz9q+5cNYkmwMcxKyJizHa5SvvSK9h7aagz+NGS+gtEA/L3oCfk6biGjxWbpXUeY60R7yjgYnuZN0/kckf95HhL52vgN8tejIUI6T2cjP3G+MUl3zdVqpnPLFLVNvAxI35Is5OjffWAsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UAbnea+E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0iBJlVkdJTVNH/dTaH2AMDRd1BkRaHhXHrReBrPuvBo=;
	t=1726070434; x=1727280034; b=UAbnea+Ed5e409lnWuFVDvDIy2hjO7/Y0IQyZWBWJ2PUByT
	pLlIMfNl0YXXw8c6ATJJGZQtmRvp7ccFhtkcFSyrvr1PWKBT4N4rjBaXD7NaOde3XBhKWI/JibaUA
	PgyPiMNG1UxD/NISdT3D6IgO0KGpaed0CciKx+YyBeSAZn3Lbob/ihFM9FyUfAO9A8TWRMnscx0K4
	6PQfJz3WvfQcCMwz/R6d+1TOoLETyoSep6H3AQtNHyt/P5JsuD9hiO4w9JMLLYHm3f6XhnK02lyA6
	GrPt9qOwbLau4M2akpS+MB2fS+EJQpQhOIexqKU1kg/NAmJYsEFyS5cySDjYz64g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1soPld-000000097PK-2pYB;
	Wed, 11 Sep 2024 18:00:29 +0200
Message-ID: <d880275455b93c92a0f8d0e59169a22433d815ba.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, Karthikeyan Periyasamy
	 <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 11 Sep 2024 18:00:28 +0200
In-Reply-To: <3d2d9a9e-43ee-46f5-bf66-6227ce6bdfd7@nbd.name>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
	 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
	 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
	 <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
	 <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
	 <36d111a1118349a86946bfdbc55e8fcbf3720fbc.camel@sipsolutions.net>
	 <a588beba-ddeb-445a-abff-cfb3f6a41a63@quicinc.com>
	 <7ddb082fc1a1886f343e4c0233a24221932edb64.camel@sipsolutions.net>
	 <3d2d9a9e-43ee-46f5-bf66-6227ce6bdfd7@nbd.name>
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

On Wed, 2024-09-11 at 17:58 +0200, Felix Fietkau wrote:
> >=20
> > We still need the part of the patch that calls the validation on each
> > radio, but it shouldn't be different from the global one. If you could
> > make that patch I'd appreciate it.
>=20
> It's implemented the way we discussed it back when this topic came up.=
=20
> Legacy user space gets the ifcomb data from the first radio for=20
> compatibility. The actual global ifcomb data is reported in a new attribu=
te.
>=20

Hah, I forgot about that. Then that means we _do_ need to relax the
validation in this case, but I guess needs to come with a big comment
saying how the driver-global !=3D nl80211 global ...

Sorry!

johannes

