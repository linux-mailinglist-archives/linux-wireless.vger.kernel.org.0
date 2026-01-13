Return-Path: <linux-wireless+bounces-30745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77AFD187B9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 12:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A204330181AD
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB9313E20;
	Tue, 13 Jan 2026 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KuMYNYWQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72F277016
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303651; cv=none; b=kbl5dyyk3f2iqMuhl9H3Uy7y1L79N8IRwDjbApGVSszDiUe58X81okDijTHk44ESQtjPHT0QBSjMalATmaAaxX0+sc8j3M2GXfWlS4CcLkJQI124cHi2LUgknIZ82VAw+vvqDYtle6CfeT5xmHB0m5WZ8ph0t1aJA681sqabsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303651; c=relaxed/simple;
	bh=+p+7ARasYppKXO/qZrvJpUFL6EeKzqUzwXXycmPCl98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HX2j9YX5n6Aa/6PTwz0q3lBkj0KHzm+QbuCAkPePCk4hpnb3lFhIFT1gOWodvIoBfRm3klvO7v193f4igKeDKdXutY8f18jCQIbSOkDSH3n6ZCF47lP+KnxZVsLAJ1UxLJbYkJcjPGPj8WA9iJX9plZ9b6V4Bbs70bKatb0U2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KuMYNYWQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+p+7ARasYppKXO/qZrvJpUFL6EeKzqUzwXXycmPCl98=;
	t=1768303649; x=1769513249; b=KuMYNYWQtCE0KlEJusLwfNn+a0uKHCeX31zuuz8Gab28b3/
	jKCU44DZHAVCRBDSNd2RJQ7NCjaCiFqNpepaL0cCO/lTbD3kJ0sD4OK5nCurviMMQaV6g+4Xgp3IQ
	CAso5r+IwJEKWbtoiyasE3xWl3xKX4milyHvUNLq4JmSLVcFDrrh4FRo3q0xaWAhZPuERpLF+g30H
	N8XYNrjCQeGJC1ccDQ2N2IaVJbjVcNcrNBfRMPBjfJE8W1JfhWqdC9Ek1uAOrF9b85E5y72OcTy1h
	h7V22QwPt/mYEuX17zsao4JWUUVJT8PQZWm16MsgW8MFj5+wksEg7JG8X000EYsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfcYX-0000000Ajqs-0omC;
	Tue, 13 Jan 2026 12:27:25 +0100
Message-ID: <745cc8e42be1751c7f7f18d39d85b8e81fb0d951.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 4/9] wifi: nl80211: Add new NL
 attributes to support (Re)Association frame encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>, Kavita Kavita
	 <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	quic_drohan@quicinc.com
Date: Tue, 13 Jan 2026 12:27:24 +0100
In-Reply-To: <f2292ae64dc0da7e68e025a13327270d4a65cd87.camel@sipsolutions.net>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
		 <20260106152503.223216-5-kavita.kavita@oss.qualcomm.com>
		 <16099966d1cbdccc5160c6aa7a2615dcfd0060d6.camel@sipsolutions.net>
		 <036322aa-0c90-4735-88cf-76fa831a9ec3@oss.qualcomm.com>
		 (sfid-20260113_050745_660998_F8C7BDF5) <f2292ae64dc0da7e68e025a13327270d4a65cd87.camel@sipsolutions.net>
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

Sorry,

> To some extent it _feels_ to me that you're arguing they do have value
> to the driver and I just don't see it, but then can you please explain?
> Or maybe you're just arguing "we may need flags in the future", but then

That should've said "we may need _other_ flags in the future"

> why add the two unused ones now?
>=20
> johannes

