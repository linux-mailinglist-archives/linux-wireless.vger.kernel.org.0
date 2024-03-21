Return-Path: <linux-wireless+bounces-5113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883808860E6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDD31F238FE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D7134435;
	Thu, 21 Mar 2024 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vzvrKFy8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AA383A4;
	Thu, 21 Mar 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048477; cv=none; b=ldatn8DbGumm63WVrt2b0aEMt40dEUmeFfJVRotHsUbhTFvN7XnasYZZl7YILITvNyqMF+cuvnbIaKBZgOd0l2b1h3WNIetmvI1UwSMk+rrPFzpiK+420IJc+h2UbBN+7IdiTwI2aeK4Y8Csv74FmCRGhnuyU0hArade3hS+zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048477; c=relaxed/simple;
	bh=NfFW5kCLFafWVBiNpJ5W+QaU+TMnoueVsQ3m1t2yNsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYOePpDB8VtHBurpDxUavMwkNWPQKO4mreK+r1a+cr7cBdPb2TgMuWsHwjwHztVkcUBg+OmcD/VJdzC2baGe8T/z+3UgLA8NP/BIDFeCVwhCxtcCcWnh8fUjaj5lofQv0c8PvdGaxMc+1SNBsC156tCt+wNQ6pa3y1fAro7OdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vzvrKFy8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NfFW5kCLFafWVBiNpJ5W+QaU+TMnoueVsQ3m1t2yNsk=;
	t=1711048475; x=1712258075; b=vzvrKFy8EWu2P5bteKVdyjhdKQBx9z5cqoUFnFBfTb4XLgD
	s5XeSJn7V10NZlXpMYG77NtCEZ9jUu4y7fKHa6aEXcFzbihclNoCmh3bzLKxYimeA19BVy0xV+O11
	MbUNBm5dCb5s5QkWDM+IIqk4js3qTtOSmVF2GxFOqAP74xiZL3T6UVh3WIrx/xdkVBoUKbh89WMos
	otOXrGWprbht0R6ZlgzHsiFn1H3yGoXoTXA+Z4nhTuZzJBLwh766uXGXMET354FjJAGltw0PNmTEl
	u3kMdelTJXFvSBcSxADmLkIp/+fHw13DZ4/5I/ymg3m466BXuCQ+8XsjIy491E/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rnNrn-00000008deO-075c;
	Thu, 21 Mar 2024 20:14:19 +0100
Message-ID: <55125648b2553ce746b92092a009d4939d1eb6b8.camel@sipsolutions.net>
Subject: Re: ath11k and vfio-pci support
From: Johannes Berg <johannes@sipsolutions.net>
To: David Woodhouse <dwmw2@infradead.org>, Baochen Qiang
	 <quic_bqiang@quicinc.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Kalle Valo <kvalo@kernel.org>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, James Prestwood
	 <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, iommu@lists.linux.dev
Date: Thu, 21 Mar 2024 20:14:17 +0100
In-Reply-To: <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	 <8734v5zhol.fsf@kernel.org>
	 <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
	 <87r0ipcn7j.fsf@kernel.org>
	 <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
	 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
	 <87mstccmk6.fsf@kernel.org>
	 <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
	 <8734v4auc4.fsf@kernel.org>
	 <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
	 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
	 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
	 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
	 <87il3w7zjh.fsf@kernel.org>
	 <20240115104658.0b56bd35.alex.williamson@redhat.com>
	 <543d9d2f-e132-4fdb-8454-68595cd20515@quicinc.com>
	 <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
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

Given the "ewww" patch to make a module parameter workaround for this:
https://lore.kernel.org/linux-wireless/20240321172402.346191-1-jtornosm@red=
hat.com/T/#u


On Tue, 2024-01-16 at 11:41 +0100, David Woodhouse wrote:
>=20
> How exactly is the content of this register then given back to the
> firmware? Is that communication snoopable by the VMM?

If I'm reading the code correctly, it's just a write to a register in a
memory mapped region, possibly in multiple locations (different queues
or something). Possibly indirect (see __ath11k_pcic_write32), but
someone would have to trace it or know the HW better to understand which
locations it's written to.

But yeah seems totally feasible to just translate that back in the VMM.

> > > Off hand I don't have a good solution for this, the hardware is
> > > essentially imposing a unique requirement for MSI programming that th=
e
> > > driver needs visibility of the physical MSI address and data.
> > >=20
>=20
> Strictly, the driver doesn't need visibility to the actual values used
> by the hardware. Another way of it looking at it would be to say that
> the driver programs the MSI through this non-standard method, it just
> needs the VMM to trap and handle that, just as the VMM does for the
> standard MSI table.=20

Indeed. Much better than having a module parameter.

> Which is what I thought we'd already seen on some Atheros devices.

It probably also affects ath12k, seems similar.

johannes

