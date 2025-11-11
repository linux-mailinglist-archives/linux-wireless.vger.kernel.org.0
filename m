Return-Path: <linux-wireless+bounces-28831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5CC4C66C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 09:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3D3A130A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEC2BEFE4;
	Tue, 11 Nov 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kFWIFjVW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463F34D39F
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849421; cv=none; b=lRfbuj6zxz20mHO/QD3c2prOOEIQxufvzdLd+5XDMfoVfU/PFdMUL8qpCtqJpRzNmz9cXBDaKX8k+SVgx5hOd3qZsKbTKlY3Vvelr3xTGFwTxHZE7KWCvt1VLYg3sTCefD3jFVVkPWEIK8jHWXPktn5KBe5dOgWEwXlNMS4Tteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849421; c=relaxed/simple;
	bh=ARUDe+MtjGRlKTq3jknzNm0s/RlkplP8dat2gjZHU0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mg8RnlGrBtlxXyA5HfatwPPaiod/YR4pXUJGjAHF7crTgktKWIJuFYtEtmfoCP35VxI6WWsoaWaT2QPSRbSvLmoI1Lw4M5e4VaKqMoZDE9IBHDLWNd56Bx34Z/C4sNHwzrCMW3n2ruy4odWWJZ7qVE3XYXJpKDRRvYPFUvM7ZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kFWIFjVW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ARUDe+MtjGRlKTq3jknzNm0s/RlkplP8dat2gjZHU0o=;
	t=1762849420; x=1764059020; b=kFWIFjVWV/dOezu4KKnTowzENGmexJehXlA7Nh/hcqX2yEZ
	nHFzwhqGn8BAbh0+qaaGu20RAhUBplx4xo4Q5EN2zFqJzbuAtEHSWpddbMPe1x17yM7D/qDuO+lPi
	ZUVWexmDcMji5fZRMBM7WW6QY4GaO7RtlnMQnIUWNZkuIOgeJr3wqbV/XvD5i5FRCQI9ytvIcT052
	KRVBf0T+mwJN0aazt3ZSKFofjwwgmiS0sOClJ8UqGZvaHCclZ6MftuPwgjRIsZ2a6hsm1/KXhtacp
	2Js6HZgGhsIxPX4yPllh0Hw9UK0tcgj+jqJOteKPf3htMkMTTurTKbnxLyhV5k3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIjf7-0000000F6mx-0jPR;
	Tue, 11 Nov 2025 09:23:37 +0100
Message-ID: <2aec9a934baafe94d0c581c3e48e16226bd6f037.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: cfg80211: don't allow adding/removing
 NAN function when not supported
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 11 Nov 2025 09:23:36 +0100
In-Reply-To: <20251110135822.5c545f924515.If337e56bfae927b039bccb4ffa38a3f0e0a8f0f5@changeid>
References: 
	<20251110135822.5c545f924515.If337e56bfae927b039bccb4ffa38a3f0e0a8f0f5@changeid>
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

Hi,

Why did you send this twice, is there a difference I don't see?

On Mon, 2025-11-10 at 13:58 +0200, Miri Korenblit wrote:
> add/remove NAN function is not supposed to be called/implemented for
> devices that uses user space DE.
>=20
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>

I probably thought it was going to be squashed - I think should have a
Fixes: tag now, and maybe a better description?

Does it even need to be in wireless though, only hwsim ever sets
WIPHY_NAN_FLAGS_USERSPACE_DE, did it break hwsim in some way I didn't
notice? Surely I should've seen the WARN_ON, so I guess nothing ever
makes hwsim have NAN capability (i.e. NAN in HWSIM_ATTR_IFTYPE_SUPPORT)?

johannes

