Return-Path: <linux-wireless+bounces-19570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C9A48DB3
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 02:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDC165B55
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F524409;
	Fri, 28 Feb 2025 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZmLlEo5B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B37224CC
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705255; cv=none; b=HidlP+f1a60fe2DXlDCgDcWckeCnRzrurBbR+90Sm/DyU3L+Gv0JeZmyL3s0/ICm1wtzbzZMfN8olWDFWOnuA+9Oe5FCdj9qPZz2gWM6tVNjymvU528jyK5Iz8OGnUs9sUnp21h2MHc97VaxcKwb5x0s2LQ6zrLc14J+pwQY9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705255; c=relaxed/simple;
	bh=Ku3DMkLSDJrrHzEgYbO69j04S6unATPZdunPnRs1vGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jk2E9Hs1tZYWKvVGoYkAy3WRbSRPw6joF1y75hCW2Smgef7lGk3DxGhAZZrXaiV9K/QmdjufFMW4XPua9Oc6epsIxtAX9qfvD7XG35y+8Po9ACSMsIzoFHQeDPCnDtqmgwlG6nMlbMFsenkHt6yK19M3vhl1xFNommfRODzhxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZmLlEo5B; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ku3DMkLSDJrrHzEgYbO69j04S6unATPZdunPnRs1vGQ=;
	t=1740705254; x=1741914854; b=ZmLlEo5B/TtebIt7HBDYfZ/e0jTWYVnEQprvfxJ8Woi4b7m
	/ormjYxe1BYBwQQ48C/kcggzh65PGv6i05A4AN6UsmohnDnh54m11wNSuXZM2Gpa8RGCuUVy0Eubh
	9wJutHKXaP9k1KjvhrkHDcTX5C+Bq8Olu3wdOneNmxXN1u9Qypt4espYSBDASGnvrXiC8R+c5+oUR
	Msg+bAhdDriklmTZOGwlgw0RhMRKvbmLULDJznGy6rHAqtBeOmnvtDsaef9OeTNUFOh0U4qY7pRES
	4HIKXIwzhu4f/w6q10KfP8ey1kq+/nkIH+AfyC1pdSxDoNu3vgKZUquhjjPmVJ7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnoWt-0000000D0LN-0og3;
	Fri, 28 Feb 2025 01:47:03 +0100
Message-ID: <98b73681e9ebe7e6252dc2a1d62cacf4b0524ff5.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/5] wifi: mac80211/ath12k: add support to fill link
 statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ping-Ke Shih
	 <pkshih@realtek.com>, Sarika Sharma <quic_sarishar@quicinc.com>, 
 "ath12k@lists.infradead.org"
	 <ath12k@lists.infradead.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date: Fri, 28 Feb 2025 01:47:02 +0100
In-Reply-To: <8bccb677-de56-475a-9b27-ccd55bcaebc5@oss.qualcomm.com>
References: <20250227045824.91480-1-quic_sarishar@quicinc.com>
	 <bac3fdc3bd39e45150e5b7d60be01b5d732a04bf.camel@sipsolutions.net>
	 <df26e3aeb3724d969f444eab65d8c872@realtek.com>
	 <900f042d03d34385fa3507610ae291a36ca4885b.camel@sipsolutions.net>
	 <8bccb677-de56-475a-9b27-ccd55bcaebc5@oss.qualcomm.com>
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

On Thu, 2025-02-27 at 11:35 -0800, Jeff Johnson wrote:
> On 2/27/2025 1:32 AM, Johannes Berg wrote:
> > On Thu, 2025-02-27 at 09:30 +0000, Ping-Ke Shih wrote:
> > >=20
> > > I have encountered structural (not functional) dependency problem too=
.=20
> > > Could you share how I can tell NIPA the dependency between two patchs=
et?
> > >=20
> >=20
> > I don't think you can at all, at this point.
>=20
> So it doesn't support the mechanism 'b4' can handle, namely having a
> base-commit: tag along with one or more prerequisite-patch-id: tags?

I don't really know, but I don't think so. Note that (afaict) b4 also
doesn't really use it to select the base to apply things to, it uses it
to make a 3-way merge to the tree you want to apply the patches to. I
doubt that would have helped here, given that it was trying to apply the
patches to the wireless-next tree, where that commit likely wouldn't
have been present anyway.

johannes

