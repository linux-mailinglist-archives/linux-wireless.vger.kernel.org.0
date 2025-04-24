Return-Path: <linux-wireless+bounces-21994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01252A9AE31
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2543B8BBD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E71BC3C;
	Thu, 24 Apr 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oVYilADA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578DE545
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499695; cv=none; b=pEKS/m/dNjJ2emtxI+NdAortsNN+zF9ATwzrhT0lqO7nltRADX2x7C02hMY255kbVmbwTQrhmX0w/Xo24tAAWZ0f49LB6+Mk+/tOH0MUJSsh8ZOVj/Wc1pqEpUBW4XocYWu0qN5du/NMkR/jIorNFF73wINrqyOrA8nTK8shTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499695; c=relaxed/simple;
	bh=am6dmNALjqAowssSSg5ayS8ncmDV5kX3COcYoNTfSi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=irJ1mTzUvJzKDR+bkpMXg869eCNQc4ovBgTPOUld0G9iS5cPvCvPeayWyqOQi4r5jkLauhxjpix5QGrQrW1o+9bkvJYjdDGsf816KAl1JthaQ1+XIxbhv2LVrhBT1XnsVG2Q7CEfOmhwuBALv+Dqarpu4SzuVSlkrCbpMjDQHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oVYilADA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gRhGLmYORZw9qyXo7wZMVDoT0WRKxhUi8VJEMMpEqdM=;
	t=1745499693; x=1746709293; b=oVYilADAKejmki9y+4ilsDLkPUXIiKbFoWDwXmz3476+1dl
	79kHq1MfOXNDXsMo/IVj88c6RjikhDapxXr4Mqkea63ZzDMujZIIhWqnPpLHrjy6qx+gfowjAwIu2
	PWEsig0OOy+z54S3Tc388wkqlsJ4ZS2JlIc2/cF6ycSrpUfU7DuEOQhl005jXpa9DP0jfTfws4R9y
	tQuLHexum1T/7e+EL3/HcoQhHWXMY9BeGHqoQ00T1MV/KgkOzRS8pceK9ycAOkL4OdnQVeuxYyQoA
	0xY6qsrnjesDo+yPN3cORK5fk8MLbJjKx4kShjnGdVkwQ0o4JPE6lJDAxpojh/Kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7wCi-0000000H8mZ-3XYN;
	Thu, 24 Apr 2025 15:01:25 +0200
Message-ID: <046188792efada343c12476e5bc00247a61c0fef.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Update MCS15 support in
 link_conf
From: Johannes Berg <johannes@sipsolutions.net>
To: Mohan Kumar G <quic_mkumarg@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Dhanavandhana Kannan
	 <quic_dhanavan1@quicinc.com>
Date: Thu, 24 Apr 2025 15:01:24 +0200
In-Reply-To: <20250424043256.2982345-1-quic_mkumarg@quicinc.com>
References: <20250424043256.2982345-1-quic_mkumarg@quicinc.com>
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

On Thu, 2025-04-24 at 10:02 +0530, Mohan Kumar G wrote:
> As per IEEE 802.11be-2024 - 9.4.2.321, EHT operation element
> contains MCS15 Disable subfield as the sixth bit, which is set when
> MCS15 support is not enabled.
>=20
> Get MCS15 support from EHT operation params and add it in link_conf
> so that driver can use this value to know if EHT-MCS 15 reception
> is enabled.

I guess I'll take this (modulo the question below), but I think for UHR
we should probably just pu whole fields there rather than splitting
things out, that doesn't seem all that useful?

> @@ -830,6 +831,7 @@ struct ieee80211_bss_conf {
>  	bool eht_support;
>  	bool epcs_support;
>  	bool csa_active;
> +	bool disable_mcs15;
>=20

Perhaps we should group it with the other EHT ones like
eht_80mhz_full_bw_ul_mumimo, and also use eht_ prefix?

johannes

