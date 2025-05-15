Return-Path: <linux-wireless+bounces-23009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F8AB851A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6B43AD18D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB57819;
	Thu, 15 May 2025 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WgZo+WkC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1FC2C9
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309308; cv=none; b=nAmtXfKKwwyvYzW8v3S1HYKPfKezZ1MKx8SI1HUMSwGPRha3PG7Tp+RqoV8SBaaKjOHmtixlsJW//mCwbmgDCpga/IcoQJwZe3NKaZO6abOVkoX5ONtBdkVznIfRLSZWO+ztvjJM2bGRwOQfRs/e8AMqzN8/UsRP8+Wvx2a0+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309308; c=relaxed/simple;
	bh=C7ingLdRJ+NjgqOXgDZysXzeJ2zBMRD2QhJ9odi6olc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfnE7p0RkgXnf36ghSlqDJfXSKuFaLZYg2SdDL0Z/+e3c+M8AJ+TxX6XQczXJLDKpwU+w4bUHOziLgqJpsaiVM+WJz4SXD12puBTJwkmOY5XXzKQdbcLR6a0dQ1L8e7RVi0dAeWoP2n92yFN7hzLW9rywSJu8kdjRi2tPdTZv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WgZo+WkC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YXt32dsjN/TU64h9Ly5z28m7H+uZDa+2STLGJN37F28=;
	t=1747309307; x=1748518907; b=WgZo+WkCkFqCJGZI3wxDMGabaZuD/yhHc0cWvoIoZNtpa0l
	8iqxiipd0wJzvBntQ+8yZ088vilmSEWSziOPIIndidLCeKwJtZW51pq1qWBe6hzvYWXjSNt1KVFvt
	XvuY+57i8p0Qy6KqeofQPVuqfhs3N2DTuKVmCs0Dj/CqtxMTr190/4l1ME5xfcfUN0V63/JzcI4En
	aVy3Dto7iMN70o5nD6xDuLByuLnK25kksGTU+/uhBAQPEUbhGRSST8DFLQ3KQ3nc8EBWpFGMFK01s
	0b8SBiubuPNN7cN7pTHGGtzXhnx+wZrjKeTYFW5ypZisuzuxXEyue7Aa2XDSsNgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWy7-0000000B8N2-0GQj;
	Thu, 15 May 2025 13:41:43 +0200
Message-ID: <22c4f501ab25f4ebeed119db6948d73442b98948.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 08/10] wifi: mac80211: extend support
 to fill link level sinfo structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:41:42 +0200
In-Reply-To: <20250515054904.1214096-9-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-9-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>=20
> +	if (sinfo->valid_links) {
> +		struct ieee80211_link_data *link_sdata;
>=20

That's always just called "link" elsewhere, maybe stick to that
convention? There's no mention of link_sdata elsewhere anyway.

johannes

