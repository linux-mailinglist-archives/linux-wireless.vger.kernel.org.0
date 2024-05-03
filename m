Return-Path: <linux-wireless+bounces-7133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6D8BA8AE
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30C11F228B9
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E428148840;
	Fri,  3 May 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cb0d8Zgd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CC148313
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724791; cv=none; b=qZ8w9K0PzAVOPJERIW5nYD1xRENXyWG1Zmz74O12gWXSknesx1RD32Eka+f71lXTGe/wvb65s1b9gDVKW5nhWkOwmPOQ4MZGRTXiIJ6d1v6EPSgD3eafkacZ6EnBr/VtyWACdVd/1d9kqEMaGQIu7lUsNYrx2bCtEKOWXcfWP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724791; c=relaxed/simple;
	bh=f/CucrM1UvFS4v060w9y1q+W4JQqFvhwFbb6E8KZHQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twFSUB/DXacEOXNXDtkGEWiWO8J/M7RFZnBRf6aVAYzZLb1rj9Hj8CENr0V2kuGST7Xab2iJL59VBLTQuJyymam1vnaSLexk70b5PHRPLA+I0unSKg8CapqlPpuDIj2ihadmq7rRQs8gDofL6MGYSWSG5QJOblgy6Y10eS1cM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cb0d8Zgd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f/CucrM1UvFS4v060w9y1q+W4JQqFvhwFbb6E8KZHQ4=;
	t=1714724789; x=1715934389; b=Cb0d8Zgd/BxJMz2QXJ4zZiOZd5mlTpVV1Cdx0Lc82ltC4ki
	NqXq7nNC+ua8oU2o/tgEW9QD/eKzjWjOGQ2rztM5mSJC4gFHbc43uOwpSv3DCg/oG6rM7ouo4iQhW
	TwuS1BtsdwqmUMvm9w9gZnhWdth8j5OFSc6MOq642SZ04FXUqhRtHqCd/YFExF3PzjzpoXRyK6aWp
	TZcOhXN9zA0xhSoS2rJzayKixP8zA33uDhfKkNhYqdiiATsacJJwzHVRTlT6Wa3v3JpGxrY8RukfR
	ZOyHpDWvB/MdkOcb7QnyEvWtegU4eXyt0jmG7oPJ6PDiJ+QpYaDIvAbw6aCsUk5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s2oFN-00000001fk2-1SI7;
	Fri, 03 May 2024 10:26:25 +0200
Message-ID: <21cd883ea7d3a7735bbba2c85f5d9e5d5803b5d6.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Allow pre-CAC for self-managed wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Harshitha Prem <quic_hprem@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Fri, 03 May 2024 10:26:24 +0200
In-Reply-To: <20240429042723.2847389-1-quic_hprem@quicinc.com>
References: <20240429042723.2847389-1-quic_hprem@quicinc.com>
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

On Mon, 2024-04-29 at 09:57 +0530, Harshitha Prem wrote:
> Currently, to allow pre-CAC it requires both driver's regulatory domain
> in wiphy and cfg80211 local regulatory domain to be same, along with the
> region to be in ETSI.

Any idea why that is?

> But, for self-managed driver, some countries have mismatch between these
> two regulatory domains and it would not allow for a pre-CAC. For example,
> in ath12k driver (self-managed), country Sri Lanka (LK) is classified as
> FCC domain as per cfg80211 local regulatory database but as per ath12k
> driver it falls under ETSI domain then because of this mismatch, the
> driver might not be able to do a pre-CAC.
>=20
> Hence, add changes to allow pre-CAC based on wiphy's regulatory setting
> if it is a self-managed wiphy.

I don't see how that's really all that much more helpful than simply
removing the restriction? But then why is the restriction there?

johannes

