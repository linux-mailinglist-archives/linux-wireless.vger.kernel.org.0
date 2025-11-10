Return-Path: <linux-wireless+bounces-28786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80CC46F6F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6793AED7A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B77311968;
	Mon, 10 Nov 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ds2bEVev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8730FC10
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781710; cv=none; b=pY3nUx9qkK3RrMk4W9KzZycAVYWDYxTotJN5o6jsXh52axtNvPPveGCIAVvSPBZkMn1ovk3sf8Wtnto042rR+DtmFY/XUsEov/nsodRCo2VAFLMdoxg6C0jzXDGOZ9GwHvDiAXf/D2dFWwjsddUsSlYgQI3WnjnVQRQf94gGsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781710; c=relaxed/simple;
	bh=rAJYeffqe6oNlvUnYNhFl9HW7fnM8KO7Sbw6w1uEIOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qty0+1nsdwBfYRTwhh+earp38bOpsItUoyGofQknyEnW3o8N1Y+joC7CX+dt2UhaBkjEN8sKwtFmyXpZWUVCxP21qFEcyntMiL1IrJB7K5qrZJadf/uYUYgsEqje5uDD9Wk9kYXZW3d49vqwXPgrXYl1FEcBQDdIs0rIVTrbxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ds2bEVev; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rAJYeffqe6oNlvUnYNhFl9HW7fnM8KO7Sbw6w1uEIOk=;
	t=1762781708; x=1763991308; b=ds2bEVevfpKGy7YAA9p+1dDAbZOeG5IBQpeBgKxx4AGNvtq
	e8DJQlXBeVk7TKVyjUZNsp0/MXDHE0dxw7NLzIGLoZ/g3sopQe1VJcRWdSSedxUvLzwOTAvm/DbYL
	d1AunVxeBTtAu7QZNFut7lVtlJfT9F3cgpcU4nBIkCkT7Rjn/RRw5FhNChX9Qb+SwPL1vP9JWUFd3
	8Ow/IxB+w3jZN1wq7GSbo3ugUiOCeo0sGcLFzqST1vgIE/M/6nfQzBWqTHwLbMvojmNbrbCOJqTaI
	kMZVP+NuTPDY8K3LMM5707Adicpsp7XkX5fexpg3P95JOHXpDBVanR/henL3a8ZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIS2z-0000000Bppy-3jEU;
	Mon, 10 Nov 2025 14:35:06 +0100
Message-ID: <6a84990ab74953fff19daed71db79988f56a6fe5.camel@sipsolutions.net>
Subject: Re: [PATCH 1/6] wifi: mac80211: remove an unnecessary copy
From: Johannes Berg <johannes@sipsolutions.net>
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 10 Nov 2025 14:35:05 +0100
In-Reply-To: <0ed7eb21-a261-45b5-b3d2-9b9bb63d688d@xv97.com>
References: <20251109140450.118106-1-m@xv97.com>
	 <20251109140450.118106-2-m@xv97.com>
	 <e340d3d08e945df144110b9da2f272cab8a2c40b.camel@sipsolutions.net>
	 <0ed7eb21-a261-45b5-b3d2-9b9bb63d688d@xv97.com>
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

On Mon, 2025-11-10 at 21:33 +0800, Chien Wong wrote:
> On 11/10/25 3:34 PM, Johannes Berg wrote:
> > On Sun, 2025-11-09 at 22:04 +0800, Chien Wong wrote:
> > >=20
> > > Compile test only.
> >=20
> > You can trivially do better than that, say with hwsim + wlantest.
>=20
> OK. I will test with hwsim and update commit message in v2.

Or just remove that and add it in the cover letter, but anyway it seems
you _did_ even test it (to some extent) since you can't test just patch
6/6 by itself? :)

johannes

