Return-Path: <linux-wireless+bounces-23992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49897AD5A42
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 17:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C474E16BD43
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730A1A9B52;
	Wed, 11 Jun 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Gys4Y9KH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473021A3148
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655224; cv=none; b=YCOhCIcJRDvsJRvZvB8+em54zIUl5K1b6VA+pcD6J93jZjDscta0aOwdBFPdJTJMfwPTp3SmbBPH2XKi6POxaJ8Cg5mfODvkPpXiDCBDl4KyD6OnM50XjgTU3bEjW+qJVmXX3zHB2mTinohhStc3k97uQnrRPFO4UVGIdejcUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655224; c=relaxed/simple;
	bh=9H0Ww5lmGaGfECqfT83dmaagSG0+b1DXzL6WMNSqqSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoJBCkiB6CviWrFD3muVPXiQKMzHqWGr9flB0hBeAiUVGBO4pY1qrEowkzNpYjm6D9bNfMuBbZQtTSp765SEi24BAQnuAXfqKK+BIQVcVcfmxT8DEzGEm1rwP5E6FZ8ULsK+gXBzEcspJ+/hLr/cknCPoSbhHJJXUTzbiZx9miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Gys4Y9KH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9H0Ww5lmGaGfECqfT83dmaagSG0+b1DXzL6WMNSqqSM=;
	t=1749655223; x=1750864823; b=Gys4Y9KHtMuGYVnCfgoU5Qetk4799RFJ+8CbxUBYrlpgnzg
	Rkb4wKmcnSNiYt1SSdAdUZ9pbRSYtX3R8beeg9p7uBnFPbYzLysxQoLw/9RQVnW3CpOgY6BxGr61I
	aiaN5xpLS4ihJZLpASzLhI5DxiEJYP3hK4l460IzBNiV80NTkUbPZF2x92EVz9WDm5J+ZCbtlhyV3
	FI+5viQPI+/kGxW8shOBa6vtt/fH8GHqNLiHbR6S4/FjbJJ6S+NnDkERhQsNLDIA8LqzJyQ8/HCd2
	AX6DNByjMyIUJX2vCDVgn6CtkbPoBdj0tAOVH+4HQefeO3Scs4OL7iUsAKcVjE+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uPNFT-000000029JR-2xhO;
	Wed, 11 Jun 2025 17:20:19 +0200
Message-ID: <55613e9bc81cb0a17ce65df5ef71abe0710d11ab.camel@sipsolutions.net>
Subject: Re: pull-request: ath-current-20250608
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Date: Wed, 11 Jun 2025 17:20:19 +0200
In-Reply-To: <2ecbedb6-401e-4023-9eff-8123e2c90c45@oss.qualcomm.com>
References: <6574640b-a383-4c16-bbd2-710f362ed644@oss.qualcomm.com>
	 <2ecbedb6-401e-4023-9eff-8123e2c90c45@oss.qualcomm.com>
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

On Wed, 2025-06-11 at 07:16 -0700, Jeff Johnson wrote:
>=20
> I'm accumulating some more patches for "current". It would be nice to get=
 this
> first set pulled so that I can cleanly fast-forward and apply the next se=
t.
>=20

Oh .. I forgot to push it out.

johannes

