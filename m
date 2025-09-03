Return-Path: <linux-wireless+bounces-26963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D9B417AE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC637C2F1F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C042E6126;
	Wed,  3 Sep 2025 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BLAJOxcI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C02E1C55
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886469; cv=none; b=YvxVK1eJ6woeML1D9Xul16j6TO0+uEdWyYASlBa0qlnbmBFk5GbM8jmA2g5fsDDGCDnFP/qHHpbG1ULwVkLxiVNO6QCosToWkbKOqDEZbbaQ7+P5JKyqDYCThHcaW1UElxDowk1u5zVkwL48Dfw76ex3MwQ2fWQE6FbVNRUTOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886469; c=relaxed/simple;
	bh=isNA2HGhn50XPqzeDNmmxeg3TOI96Veu6bbVl6tfsCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+G0HrVcV3FCAVdnQvXEqYf3T7MNpNNYqlJCjhXYsMHzz0E2A7o5UWQeI59qBQKxXYY/RVFNc0vYd6Iyza850m44nzwoUsJRv943w8g+PLw1qaOOXGun7t2uF6/hAGvCcKU9xAMgInrqwqbbAMiyidJ6irR4e6F3GM2VmuIISng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BLAJOxcI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=isNA2HGhn50XPqzeDNmmxeg3TOI96Veu6bbVl6tfsCw=;
	t=1756886468; x=1758096068; b=BLAJOxcIBbveKxw2smewFz6jn4qf5i2pa7cBB71Yu7zxu9d
	qf9MAzaq8rikFhyFhsYqRcTJUOkl/bTEM2znkwuVsyzKj/d/H0rjVShtihvLwbFm1oA4TZccGAlFD
	t13n2e1E2Xo1H+y6GColtq1jl5+XJMQ5ykTFnnjz5vfPbhEa3Pzh2IXMPdaKWsyGcOv8mYZqVIms+
	qFPn7NTNuWKjDk0mJjg4cE8LmvDBmmDnUHPy6udHaMCBeTaGzu/yH6TGBwYmEbHLQL/6G7AoKXmv9
	bXYBzkkTCFrsxCrMfH8d03s70T49PrzTB/odffjpm11jWlfsKlVoWklmz02Kd+bw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utiQS-0000000BVFb-2XNx;
	Wed, 03 Sep 2025 10:01:04 +0200
Message-ID: <b8eb835bb73e348c331e008408159a8026d28870.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix reporting of all
 valid links in sta_set_sinfo()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 03 Sep 2025 10:01:03 +0200
In-Reply-To: <20250822053229.519836-1-quic_sarishar@quicinc.com>
References: <20250822053229.519836-1-quic_sarishar@quicinc.com>
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

On Fri, 2025-08-22 at 11:02 +0530, Sarika Sharma wrote:
> Currently, sta_set_sinfo() fails to populate link-level station info
> when sinfo->valid_links is initially 0 and sta->sta.valid_links has
> bits set for links other than link 0. This typically occurs when
> association happens on a non-zero link or link 0 deleted dynamically.
> In such cases, the for_each_valid_link(sinfo, link_id) loop only
> executes for link 0 and terminates early, since sinfo->valid_links
> remains 0. As a result, only MLD-level information is reported to
> userspace.
>=20
> Hence to fix, initialize sinfo->valid_links with sta->sta.valid_links
> before entering the loop to ensure loop executes for each valid link.
> During iteration, mask out invalid links from sinfo->valid_links if
> any of sta->link[link_id], sdata->link[link_id], or sinfo->links[link_id]
> are not present, to report only valid link information.
>=20
> Fixes: 505991fba9ec ("wifi: mac80211: extend support to fill link level s=
info structure")

With a Fixes: tag for a commit in 6.17-rc, why should this not also go
to wireless for 6.17?

johannes

