Return-Path: <linux-wireless+bounces-19367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB29A4194A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 10:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43133A5FEA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BCC189912;
	Mon, 24 Feb 2025 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lbRNTS1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DD194A44
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389759; cv=none; b=KxBvXw4n2GhPAHrPfXyVz3RBhgS4yEd9NIqb+T0kj7Ru8hZWZpAMhfNsMNEWrYX7+ku8bYEYmPjnlo0TQoyfdrrpDqzV4WxN730Jy1J/tRaUFH5L33dF+vdHoYOskKlXCAiKv2OtvSJGYErEH6Stjmc8yorvNnnOtDkKMaHrCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389759; c=relaxed/simple;
	bh=Cvg5lflensd5J90StDnvFX8CxNxsnTZz85oUok30DkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEIu0cSKCOGS5J2zYMCMMR7wP0ANDlTocKi49zAggtz4BtAvWkO6JNn553RY6xC/aneqoUXq8HMwrArsFhKMQOZVUeprQ2Xb0aDxzF2j/96eAAs0UnHVRRxkPHX5f12lgsk/J3cLINYqxc84CJHCGdVbz0VTjUA3NxEyo9j/p00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lbRNTS1r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C8BwX2NT2SrvrWsSF8l8qypvWFWcTpR1Sxh2dY8xskc=;
	t=1740389758; x=1741599358; b=lbRNTS1rlu5VdO9LuWrxMInActe3Q+D2KX8XDwHBIjuN/3S
	h79B4W8bbIw+rnc7UBjjS2OGAQlQmZE1/sTmazsgv4NRNloxcl+sQyuZwte+7ZfINnP3NsllQUpSK
	g2Elxe7uSY2W3DgSuSmiNEwnBf4d55DkPFMOpTWx/vVfUidLqyeTyNvuPOchLVbbosQUWrKAcygqs
	OYSQIk51u0DhqRElbGmdY45ycwdSqwq10x30Hpe8P9SoQdnoh0/jrACs+zdpIwzBazJvDGfFrvcco
	C9debmwoa6b1wb6oTobr3ztt3UIRexrHNZ6kkD29bT3uvU0xMYzssU41rWrKM9Gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tmUsM-00000008d0U-21g2;
	Mon, 24 Feb 2025 10:35:46 +0100
Message-ID: <3e486a87c6b385fc37d087e2bae7f32a5f15221a.camel@sipsolutions.net>
Subject: Re: please use tree tags in patches
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>, Aditya
 Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 10:35:44 +0100
In-Reply-To: <7c7498fd-ede6-407b-b583-e9b8caf56bda@oss.qualcomm.com>
References: 
	<ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
	 <7c7498fd-ede6-407b-b583-e9b8caf56bda@oss.qualcomm.com>
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

On Fri, 2025-02-21 at 10:27 -0800, Jeff Johnson wrote:
> First of all, thank you for adding any automation which improves the live=
s of
> the maintainers. Aditya has been working on that for the ath.git tree as =
well.

Cool. Do you have additional tests that should feed back to patchwork?

> ath.git contains both ath-current and ath-next branches in the same tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=3Dath-=
current
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=3Dath-=
next
>=20
> So we can use:
> 	[PATCH ath] for current (this branch gets little use)
> 	[PATCH ath-next] for next
> if that helps your automation.

Yes please. I've picked up those trees in my config/workspace now, so it
ought to work and report back, but we'll see when patches are posted.

As I just said to Ping-Ke, we can hopefully also improve the auto-detect
logic, but I didn't get there yet.

johannes

