Return-Path: <linux-wireless+bounces-7477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F99B8C26D0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5991B210F3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47616EBFA;
	Fri, 10 May 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VcFOqYaP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BE168BE
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351285; cv=none; b=qMR+4qwbiCoeGuGPcyzQyHVgJDhtSP5MRScFW+mV9tOO7c/iMOvXrTVZM1CzC0c3/nHBizJ+c7q7FBiL/Mfbd1wOI2PlNH1z7EEjRIfQ2YVVC4ba3R19hu7jaPXddB9exwu9HALzpLdCAbPVMDIkLtwpiRxW2lhIeohvuJGFPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351285; c=relaxed/simple;
	bh=ImjHlYQP+XNCQDzcPg5fUsFr2N0pLeWjdrdftjlFBmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwWmOs0w4FLrO6ympqbrG29HPYXNioc5hlXHEc8Z+WIPbK/yVG3n+OjgALkSNXGhFDYyC8SAJ4VuP0aN3pl8CmumybSu1FSBvmq+H0qADrshSiS+oGjT7AnNgrW0ZZRljtOdsw5KgsS5X+xJOfGOHvSFAGe/QVprQub7YZkhz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VcFOqYaP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ImjHlYQP+XNCQDzcPg5fUsFr2N0pLeWjdrdftjlFBmw=;
	t=1715351282; x=1716560882; b=VcFOqYaP6Z0vTHY4INxBxMIa/4QIfItCV9E2A+GrvyDw5Ij
	9h+2nDVKxBayrm5ujKF3sAUUTnhW+UYi66pZD8+n/cJH0tSzJVCMsY8DDWsZEVMr1FxJEKw2cM2Aw
	m0nXTE1vndgzzDpsct5FRgV2lkEqbQgBT4VlCk3k/9AOc8ZyKMpQ/ZQhoiSg3ox8JOp64eICEqIwK
	rxEXVkO0nGBHEQSGLveqwP62UNM5+bkOL3ZLbkOwdYjn6L4r5uY9B7BLQ9i0DgjMmb5lRIWJEWcUl
	XgFAZBHHrqo7lMRl0hcRbsiSM81hkSh8rHMIXS3a71sx3x/ssoRGHe9dT1+8vqUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s5RE6-0000000F1bl-4BfG;
	Fri, 10 May 2024 16:27:59 +0200
Message-ID: <88b36efce036ad4f0316ffb434a5352bbe4f1599.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: move radar detect work to sdata
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, 
	linux-wireless@vger.kernel.org
Cc: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Date: Fri, 10 May 2024 16:27:58 +0200
In-Reply-To: <4dd39edb-cd23-482a-8c94-b09142d92198@quicinc.com>
References: 
	<20240506211311.43bd82c6da04.Ib39bec3aa198d137385f081e7e1910dcbde3aa1b@changeid>
	 <4dd39edb-cd23-482a-8c94-b09142d92198@quicinc.com>
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

On Thu, 2024-05-09 at 09:52 +0530, Aditya Kumar Singh wrote:
> On 5/7/24 00:43, Johannes Berg wrote:
> > At some point we thought perhaps this could be per link, but
> > really that didn't happen, and it's confusing. Radar detection
> > still uses the deflink to allocate the channel, but the work
> > need not be there. Move it back.
>=20
> I'm currently working on MLO DFS support. It is better if the work can=
=20
> be left in per link structure. With proper support, instead of deflink=
=20
> it will use appropriate link.

A number of patches I have actually depend on this (though only by
patch, not semantically), so it might be better to leave it and just
move it back.

In any case, your work will likely have (simple) conflicts in some
places with the other patches I posted.

But we have a couple of weeks to decide, I guess, given the release is
around the corner.

johannes

