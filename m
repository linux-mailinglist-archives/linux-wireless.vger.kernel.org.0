Return-Path: <linux-wireless+bounces-28868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE84C52201
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 12:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D06284EC59D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED62ED168;
	Wed, 12 Nov 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OogWjKuo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BF2FD684
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948310; cv=none; b=CVHsJ4uL9VeLPd/Q5s3bpd8ox2ta7DuqoOIbC4jUtGmVA5OK4Jrxa66hG3vfKkgNfnLvELvDaYwC68Ouq2LXAih1B+DtGgP8e/i9gY3wunPU4Fo8gvdQJcPV880fSg4XlT+xT9OGoyK+bOmlVoZy4upcafZHK/IGYnubxTZuEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948310; c=relaxed/simple;
	bh=ILdVpbZMTUtPn3ikkCWNRoVepJCljp51S16BFGgv3cc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpQ0Oqn5VnmUVWf+kJMsM1FTBFnM4BeuAqCezf3uQc0FsDGhZoz8aknvtzlkyVjIM2SG0GbIoarjJ1QY17C6Axui+wPxA16o7ZI8vEk+jYB8496cp0jx17etvTkij36tNDdkbyU+wtuUQUpPkea3OsxOihhhrNbeqOGPOcKSzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OogWjKuo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ILdVpbZMTUtPn3ikkCWNRoVepJCljp51S16BFGgv3cc=;
	t=1762948309; x=1764157909; b=OogWjKuoz8JeM3mUyet+PWu8JdNYUlJg+Z9e/HRfw2t182R
	+xCRGJKTFODihJEK639zmoYjycVQKpoETjVnnvbDWNKd3ax+o7SrkKvZoyxMCeOtiGoCVhqhAW9ku
	nOEYfgRxHuc1APMlHBzg7T7t53GIA/iJnQmfbyRJDX3k2qjDe715Ov5pwftx8+LxlY/BDruDPbD41
	cmyQDLFh3LOlHbUVp3ZDFOmxhJgcvYTLDehE9SCugQ07gG1IYQ7Nu+WJRM/5PXTctKwKRVpPcU+zw
	oRMlwg4smKN/OZTCPu0cEtUUOXbaw+ur63NjIXpZWcNsm+IVcikmlR2/18MWg1VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJ9O5-00000001CV6-1Hqc;
	Wed, 12 Nov 2025 12:51:45 +0100
Message-ID: <7d445736914f971bfbf89b3480cd6552434eaf7f.camel@sipsolutions.net>
Subject: Re: pull-request: ath-next-20251111
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, jjohnson@kernel.org
Date: Wed, 12 Nov 2025 12:51:43 +0100
In-Reply-To: <15a98cae-0274-45f4-9b8e-be6fa9720884@oss.qualcomm.com>
References: <15a98cae-0274-45f4-9b8e-be6fa9720884@oss.qualcomm.com>
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

On Tue, 2025-11-11 at 09:28 -0800, Jeff Johnson wrote:
>=20
> Once pulled into wireless-next, ath-next will fast-forward, and that
> will provide the baseline for merging ath12k-ng into ath-next.

I just sent a PR to net-next with this, so you might want to wait until
that's merged and I pull net-next back, to have all the current net
content as well.

johannes

