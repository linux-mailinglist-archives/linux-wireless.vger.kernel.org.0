Return-Path: <linux-wireless+bounces-20001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA6AA56A5D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CD9177466
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AD221C161;
	Fri,  7 Mar 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MFFbJbw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396A18DF65
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357781; cv=none; b=AuB6beMZphKfxj1xUeXJRd5p5pq8PMaA0DwV67XASBT5BKTnhfAA8ZW698vu1kwF4+JESbIp2wbAa2D4Rxkg3DKQ0qK16FG4GsVatC9tuGDDdZpVSRAivtEmsqq1Wi9is0z+ok6MkkzvpsBGhQZYTMUvx0A/l584KJb6OGzBm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357781; c=relaxed/simple;
	bh=G5D8EPwzNRV4lH+m6NqnB8ETwnrrvWL9XLsxy8bRX2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjvzaX8+OgRboSlOpPKpUXioAY+8T3NJxp2E8sLGkbXdadyZyEjTOk2tPlA1svy7/XpEnJT4ssFN6hyi3DITgI/wmcSvcMV+3RWs02Q+528rY0NmfknV4coLvxGf5oleu3v9WN5z2Jjo1zIrrkUs+4MPxoic86ffbLFx55I1Zjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MFFbJbw7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G5D8EPwzNRV4lH+m6NqnB8ETwnrrvWL9XLsxy8bRX2Q=;
	t=1741357779; x=1742567379; b=MFFbJbw7iv/WPKH1Bxz4ngjZtMLBXh9q8Y5c54CRLdBe9Jb
	UnGlrT8UJRX/gmVM1oiduQT0JZDYDnTfGJYHjawpYClDicm19EF5SDQdx4lDLxIYO27WJkcojpTy5
	FATQmhRYYgG/RaiLNewjKt0jmKwo60Rtv6OaA7oKXJF8uy0YLH3qlOvdyznfjRLPc4LpJU5hBCaw8
	mClLfL8WT561jNRue3ptl+dhU7/GBxgVxHFFs8tr3a1/jGIu5cRRY087v21xSvw/+MQshndn552bk
	xz3SfzxHIJuP0zDCLUBc/i3lqHMai8Y/BvjPICB48pNZfYPq+oNap7iY/dXvYnOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tqYhk-00000003wHp-1rum;
	Fri, 07 Mar 2025 15:29:36 +0100
Message-ID: <48c5536e0640d3d925fcac50d09648c5478a9b0c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 01/15] wifi: iwlwifi: bump FW API to 97
 for BZ/SC/DC devices
From: Johannes Berg <johannes@sipsolutions.net>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date: Fri, 07 Mar 2025 15:29:35 +0100
In-Reply-To: <MW5PR11MB581034BE05FD2F104700384BA3D52@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
		 <20250307000213.1678abe8c9b6.Iee3bbd245e7bc750b92624f7085afef02e7dbdc6@changeid>
	 <39059b0c01f42028bd17b54cc74f7d0aeaadf9b6.camel@sipsolutions.net>
	 <MW5PR11MB581034BE05FD2F104700384BA3D52@MW5PR11MB5810.namprd11.prod.outlook.com>
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

On Fri, 2025-03-07 at 14:28 +0000, Korenblit, Miriam Rachel wrote:
>=20
> Should I also squash the 'bump MIN' patch maybe?
>=20

Dunno, that seems unrelated, I wouldn't. Logically it's a different
change (adding supported FW vs. removing supported FW)

johannes

