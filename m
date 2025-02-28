Return-Path: <linux-wireless+bounces-19581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3755A49A25
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D59160918
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE626A1D0;
	Fri, 28 Feb 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QLwQkZpb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D52F41
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747784; cv=none; b=LwUWvQEE19jAd/ZKdjXk28wwO3cennCHeuLWqXKODO18jWBEBEoRF/3js1YvfYPZz3Gwe2kTUDR94Z8Dej3zfwacmTaaiwnWu+Nsiqz3kmNG5v8yQWsWZoqFICBqLjfZftuY4X5IqUaoQlAhLH7minz0ZFXf6DzQXP1I8JSwqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747784; c=relaxed/simple;
	bh=g8d54fYP3kg0OupH7FPUoVTqtQ0w5TmDFCs/DdOLm/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEB9xi6MVBoS4pukUmBbgNj/QofbsKt1O+MogaJ8sNzPMGt0BAOqBozweXRxTSAjmKM867QkpMx0AZo8ZmSjM7M/NiKgdggP+1xd2NposHuWJRyKqQOnIycPjF/qcliFfoyNVcwbyGbF/N8oT9xlUQBDYZRIwyG8pCLyPxi7Rdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QLwQkZpb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X+YrtBwxMz3rYPjBwJsSEgS3pqswkWwqhrYEWZkYMa8=;
	t=1740747783; x=1741957383; b=QLwQkZpbMeV/i6SouPdHy3g6zAIvw2PPrpel6sk9ZSCq54t
	fEQf6ZH0jwBXyJzltkeoJtc4priIl4KB974RoH360AxYnxfmziI+nKoIkkMDH9qfR+zFseWSsFlRR
	TZVdaum6L6eXwpF3Zfg6kDZrBsKr+YLJk7tXfkm1OMfOfAYaSrJ+BaeTMqPTZS9aRGK7cyFCNwI1l
	/9mBozPH2IxKxjXplbR+SfRpBhrz3/R2KCvcHSqTTj2rMvtpz0Xw1QHQM1abhnCSqfRsKuHzMEp9S
	hDaqPw7ehx7ut8ypxOLWRPYrLKjc9tM/J5ksgFw9w1wVqJJOqCehC2SaooCUgMQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to015-0000000DkKD-3pby;
	Fri, 28 Feb 2025 14:03:00 +0100
Message-ID: <a2bcb0b6507c843b13e0ef98d76727a76b53f129.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:02:59 +0100
In-Reply-To: <20250129155246.155587-2-quic_rdevanat@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
	 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
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

On Wed, 2025-01-29 at 21:22 +0530, Roopni Devanathan wrote:
>=20
> +			result =3D rdev_set_wiphy_params(rdev, radio_id, changed);
> +			if (result) {
> +				rdev->wiphy.retry_short =3D old_retry_short;
> +				rdev->wiphy.retry_long =3D old_retry_long;
> +				rdev->wiphy.frag_threshold =3D old_frag_threshold;
> +				rdev->wiphy.rts_threshold =3D old_rts_threshold;
> +				rdev->wiphy.coverage_class =3D old_coverage_class;
> +				rdev->wiphy.txq_limit =3D old_txq_limit;
> +				rdev->wiphy.txq_memory_limit =3D old_txq_memory_limit;
> +				rdev->wiphy.txq_quantum =3D old_txq_quantum;
> +				return result;
> +			}
> +
> +			for (i =3D 0 ; i < rdev->wiphy.n_radio; i++) {
> +				rdev->wiphy.radio_cfg[i].rts_threshold =3D
> +					rdev->wiphy.rts_threshold;
> +			}
>=20

The order here also seems really odd? That basically means the driver
now needs to propagate it to all the radios, but you still have
different per-radio values at that point, that seems bad. You also
didn't even document any such assumptions.

johannes

