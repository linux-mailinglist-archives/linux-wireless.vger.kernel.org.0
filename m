Return-Path: <linux-wireless+bounces-27202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB37B5114C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E35E4E25A0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CEA30FF28;
	Wed, 10 Sep 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mFyTMIbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5673289E0B;
	Wed, 10 Sep 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493099; cv=none; b=sK8Z4aF6a04L1TLGqnrAJUoZCr4jK2BHg0Ghn1muQzC2hEKVvYq8J4UPOccxu3tVz4PdDerSqlAz9+tMgnxJH82QEwcH1wt4sM8Wo72JIJNdMthsh7Vm5lEB9cBgdTOD+vxy2Xwdir3YDGzp6tyguVayRaxhz/3zORXWkEtcZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493099; c=relaxed/simple;
	bh=+9CyyhiBqsqEEkMgmiWTIUJkdrwkBNWrz2XsxrlGKzc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XyKxENajqL0wHaAsAGdpn8Us30sUV0tgWXNZD/843w7qfXmx3Hmv1RZPuLcZcZ0b2E3phDdjcePABtNWWBoT1y0rkl9qdcr7KMsvXeva2WWM24BwGqLRzkaIPxQObe8ymHkoHf9c7a6hcD5ICMkB0S7338wuefJ3A9Giyixbyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mFyTMIbV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nuTppplujsMKzus0pB3OrPfOinZEAxgSflrOcbgbuCM=;
	t=1757493097; x=1758702697; b=mFyTMIbVMyhxCNv7de47LEAb3zRu6wf/RvBPrjrVQW8/ukH
	x7Sbh1O4mN/AFGBihe4NKIuecaoZYqxlV1b2xx/E4aMwJ2VqzfKeZ6odxywLibLmEqhKAjA7lpC1d
	+9XrqWxG/cEKAlD5XPLN/oDLt/KT+fXA3+R3YopjMLnC87U4FKTTPgCCYBc62TCAMnjIb/3jA/UrO
	40AW5ZwxJskJ71gIbVYT+dWRrmoqba0QP7R9RiaUkNG3wCQpL7ZaMzqUcQwJ6eJI6Xcorkx+/GiAA
	yRS8biyXUn2Bp6zW+2bBnTDDKkuaEjKCqIyaoaL9s0/VIg94KSPR1rGI5nvYiY2w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwGEo-0000000CSl9-2I6x;
	Wed, 10 Sep 2025 10:31:34 +0200
Message-ID: <285c7cd9935d5c245ad478c5692faa927bcda245.camel@sipsolutions.net>
Subject: Re: IWL Error Log Dump since 6.17.0-rc5
From: Johannes Berg <johannes@sipsolutions.net>
To: David Wang <00107082@163.com>, miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2025 10:31:33 +0200
In-Reply-To: <487c99e0.6ed4.19932979ca5.Coremail.00107082@163.com>
References: <20250909165811.10729-1-00107082@163.com>
	 <487c99e0.6ed4.19932979ca5.Coremail.00107082@163.com>
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

On Wed, 2025-09-10 at 15:47 +0800, David Wang wrote:
> Hi,=20
>=20
> I think those error dump is introduced by commit 586e3cb33ba6890054b95aa0=
ade0a165890efabd("wifi: iwlwifi: fix byte count table for old devices")
>=20
> My wireless pcie card has device_family 15 which is less than IWL_DEVICE_=
FAMILY_9000, and the changes in the commit have changed the behavior for my=
 devices.
>=20
> -       if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
> +       if (trans->mac_cfg->device_family >=3D IWL_DEVICE_FAMILY_9000 &&
> +           trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
>                 len =3D DIV_ROUND_UP(len, 4);

I think I just got confused, and that 9000 should be 7000. Presumably
that'd work for you, I'll send a patch.

johannes

