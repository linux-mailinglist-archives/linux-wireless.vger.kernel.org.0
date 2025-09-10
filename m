Return-Path: <linux-wireless+bounces-27212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240DB51797
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C37486527
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CF31A54A;
	Wed, 10 Sep 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fAd+ueeQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79531A070;
	Wed, 10 Sep 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509685; cv=none; b=O1L2aiOhfbiwRnjDhZmisae+uAJKeJxuuTkBEwiZfQEu/tsLrfG3pqr+f457PVwFYzibkmhli/ZWobwkkAOpnFOttyA/10zGEayzNChtsJLG1DrjMv/MYFTxC023Oyffjs9lduVPVK+uvMe7TTiwU4En/RaZ14Q6IK9bFkj2N1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509685; c=relaxed/simple;
	bh=aUghY/cNdvYBjwgly52UnFeOS0MQvDwnhjms1Piw60M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+Fq01F2jgkeWInZaxwRGrYivovPEf3IacZedSKGOipLiK1U/YiKe6dnyRw11LKrN0utV+pwKan5gy46xsw3jJ3EQFO01lzrXk6ONqHckVWtaIjNh/Mf+mmz7SJnouXHMRcNLMziK62FnXq+oOTDnbJ9CdvCHB8Ik/pb3bKqahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fAd+ueeQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aUghY/cNdvYBjwgly52UnFeOS0MQvDwnhjms1Piw60M=;
	t=1757509683; x=1758719283; b=fAd+ueeQJK5baRwoUTrG70R3LIJiv5H+v1VZaqZZv5zyjDI
	cx2HrnJ/Quk2VoQBOTUHIufQ8mcTBzlA4uNSljUpjAGqk/7n+7Sd6389XZd7Y4mM2l/466VT7nqUX
	EtLBbnp0NpbiQWQt3AAEBOHQjFnwZsbelnKShKiY8jkNckVRLKlDAdZpOwX/MGHXShhkUb1Q+97tc
	jo4cstrDr0mYwb0BB1NLfmkRnvEcyUXJSKW8rcSTrKs+2VW3TIFljOK56m9WdPTUOoqXlR/B7iOB6
	PmJAQSBpPAgGCBmrG7an/O+sjsZIatO04VTeNs1W3tR0hjxUQjc5Gv8dqCG40CIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwKYI-0000000CtKZ-4BfI;
	Wed, 10 Sep 2025 15:07:59 +0200
Message-ID: <555b2d44403b08cb01d200eb00544e12b473cff9.camel@sipsolutions.net>
Subject: Re: [PATCH v5] wifi: cfg80211: Remove the redundant wiphy_dev
From: Johannes Berg <johannes@sipsolutions.net>
To: Zheng tan <tanzheng@kylinos.cn>
Cc: arend.vanspriel@broadcom.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Wed, 10 Sep 2025 15:07:58 +0200
In-Reply-To: <20250910015556.219298-1-tanzheng@kylinos.cn>
References: <20250910015556.219298-1-tanzheng@kylinos.cn>
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

On Wed, 2025-09-10 at 09:55 +0800, Zheng tan wrote:
>=20
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

I'm going to remove that for you this time, but for the record: please
don't ever add tags that weren't _explicitly_ provided to you in email.

johannes

