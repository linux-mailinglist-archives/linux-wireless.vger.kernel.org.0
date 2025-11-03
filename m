Return-Path: <linux-wireless+bounces-28489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40756C2AA86
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 09:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54A414E4476
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FFC2DCBF2;
	Mon,  3 Nov 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kKKknquP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2CE2C0261
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160255; cv=none; b=UrigFAA3eWkAdaR3CgkgSYrMcBxu3Po3OjSEd08PfYyIgM50Bhr4VyXsEcx4RqQAg71tWRsr7BCtopNIdUaxkWJYqybHM9QEgbVWc9vMG/O+KGD189iWO9v7hQqZC/Oko6i53IkIqky+q9zDq6TUDmsCFkXo5DhQGxb9O+v6l+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160255; c=relaxed/simple;
	bh=NmXjogRZSZnHAWMDixScQHkgBOhBEllMfwwTWFombAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9Stb254iV/oFUzECmJHoEFMMZ31hoPlbNYc09brnT91af7RdU7OIwriGmP819nBp/Jp5RC0IcABmLtwhWBg+piv3SuGOc0HjH8ljLSg0h9oPLpY046yPsazX6+J8ByEDtSzs+CZHS8Io8VeIqRrm8xYWPvmG8VJPnxqKdbCy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kKKknquP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NmXjogRZSZnHAWMDixScQHkgBOhBEllMfwwTWFombAU=;
	t=1762160253; x=1763369853; b=kKKknquPBmSCSeKHtkVgSOe9+LYkLVpO67/g89q+UFi2f+m
	ZCe5t+BVYlzcwXBMB1HUKiOpxUWvDAV3d1ABzjVPKonewvtxFfKXRMmyBilhMIqJPcvrm8V3UIcjS
	xmHzvFYtElSSAFpfRDwdm/h2hNlh6a3jdHri4AyMS8iZLqslqhnaW32uMt21z+WewDnzIr0o9OG5M
	OjUG7s3876xKl8s9zGrG0S3NjIBLGErN5X7DgJGeaGJO4wR3jbKovpbApkjD1oFmT2flPN3shI5LD
	l7QWlAjY9GIxxzr2WmNAZKJU/ICLrTQwjN0Q3v563+DOpPtDDc5vUTLct0/coTGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vFqNQ-00000008lkL-2MCT;
	Mon, 03 Nov 2025 09:57:24 +0100
Message-ID: <e0027a727707215c279626548bd3bb2101ffd8a8.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211_hwsim: Limit destroy_on_close
 radio removal to netgroup
From: Johannes Berg <johannes@sipsolutions.net>
To: Martin Willi <martin@strongswan.org>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 03 Nov 2025 09:57:23 +0100
In-Reply-To: <20251103082436.30483-1-martin@strongswan.org>
References: <20251103082436.30483-1-martin@strongswan.org>
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

On Mon, 2025-11-03 at 09:24 +0100, Martin Willi wrote:
> hwsim radios marked destroy_on_close are removed when the Netlink socket
> that created them is closed. As the portid is not unique across network
> namespaces, closing a socket in one namespace may remove radios in anothe=
r
> if it has the destroy_on_close flag set.

How did you find that? :)

And then, how did you find it in hwsim only, there are surely other
places in wifi, see nl80211_netlink_notify, that have the same issue?

johannes

