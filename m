Return-Path: <linux-wireless+bounces-29836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF57CC7B7E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71397300AFFE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774131ED60;
	Wed, 17 Dec 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j/hsuqhv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5A29B766
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976135; cv=none; b=sGfrmgiGLZAsmVeMK2jC+P1tm35zo59mqHTTmsLg+hTidmB3yrREpX1lINLZ6JKcXgaMtZlJIGbycLc0mR9QEweFV+DPuBPZUh4prZBU2VBLjiX7A76f6KCropu8k7J8y1EWWhBhJeaBDVhkxJhId8QiD00gI7Amk9mN8I7acbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976135; c=relaxed/simple;
	bh=PJSax5py48vF6r90f7BHRdIyciCSTRDB3v2rqqApTFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tajQ8RzjFmSrvcmcVtamdGQfuT5JNHtlxIYaxD3uoAZ/WvN00hkYCPpWgPMSjNFyTCwQebHsOfIOZE2X+oTFnshrtNFm2cvJ3U9UYGsG/Rl71dGmcS9C5ip33QeOp5uveMVDNkLIsb/wGETRwFQgrxSffF7BOzyBCMz2HVKxn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j/hsuqhv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PJSax5py48vF6r90f7BHRdIyciCSTRDB3v2rqqApTFI=;
	t=1765976133; x=1767185733; b=j/hsuqhvdHKQWryzdHMnU+Z04KER0D6BjPjRJVki0fsWG+I
	ucoh/WYmz4gHn6OUuUNcRE/+R0uRR354AIeCrsSLVI0JgfqvqghLnTT/lcpIr6v+9JOdpIK++7NQz
	mTC7p/s4e4vY551BoIxuPjfuQS7b8xrR833bZTST0xKjz4Qpte9qnxYrVqq7xdZS+SlLTQABPpw9a
	ZTW00pVjC0bTQEDkGGwHDRqXY3rmTUt45Q+x1AfAQ+7T4fNH2+CsZUfoy6Z1Q3xQaE6BXVDMYCZ02
	rhCJsk7kGGImtvYldrNcxs2CycbDhzl8Fkcd/eMxypUnVORxgy/XcCWK46Z7HlBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVr3y-0000000BtP4-3XI3;
	Wed, 17 Dec 2025 13:55:31 +0100
Message-ID: <c74d5c2c9327b265ed6cb48ebfdad3f687a2fa71.camel@sipsolutions.net>
Subject: Re: [PATCH RFC wireless-next 02/13] wifi: ieee80211: Add UHR
 (802.11bn) definitions
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 17 Dec 2025 13:55:30 +0100
In-Reply-To: <3b58cd19-d522-4df3-880a-13fc26ebc642@oss.qualcomm.com>
References: 
	<20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20251216062656.1738022-3-karthikeyan.kathirvel@oss.qualcomm.com>
	 <94411a1f601b3b4cbc09cb780c37df9013f3b6bb.camel@sipsolutions.net>
	 <3b58cd19-d522-4df3-880a-13fc26ebc642@oss.qualcomm.com>
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

On Wed, 2025-12-17 at 18:24 +0530, Karthikeyan Kathirvel wrote:
> >=20
> Sure, I will change it to hex format. Last bit mask is fine right it is=
=20
> from B32 - B55, what is wrong here ?

You'd need GENMASK_ULL()

johannes

