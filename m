Return-Path: <linux-wireless+bounces-29713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD3CB8CDB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 13:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653E530088BB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA1330BB8E;
	Fri, 12 Dec 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iTjQtF/L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59A283FF1
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542458; cv=none; b=oo1lhCLKAttH8G8bV5ZsEtIrwX00KL8Kz/rxTABDq39NGCggL4502akisvlQHi38pVQ3ANGdhrUq7h09zhoa5SQfHXwNjamO2UdWN3VNClnxUtvh4ZpdMPv1zXQ963iEc7BnCDSEeXYBWK1kkxGHa5cupb/eb1Qb3bc1R+LR9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542458; c=relaxed/simple;
	bh=Kp+nZtWE6yXfiZZ+GfbgZIpAPGFY3teaTHkoDnIhwhQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YR/nlHvmcSdipwPeY612puTryWQB7c3dDMTIsbADcPhx0007HALl1tfcAg27vcCSa8rz3f23gx8IlAcdlhwmfDbua038iTZ7g8EE+zgfVcmCkSD547nu/po4VY06BGPiSP939Sjw3h7oe437sZMx3QOTamgwS59asEoYxnbvahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iTjQtF/L; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Kp+nZtWE6yXfiZZ+GfbgZIpAPGFY3teaTHkoDnIhwhQ=;
	t=1765542456; x=1766752056; b=iTjQtF/LITUp6dy77IWXcP9fRrs4GLVS0aGelnjHh6bp5xg
	NL9V9GlOvu8wMVQxTE7okfv5HXhFC/j+9tDD1NbzZit4J0JKdhJ5fPclWrE+QykZ1MjM+rL+ObO6p
	1m98h8ETUO0wtk2H5A4x/TFzIk/OA4VMkdyoCogUXv0kMYh2SKtbHexCf1pcNJvoRkt4Ipb5CRbKI
	GiFRWPyQ8dq17NBszA33/LuxIZJajLIPpv1aIiqzyhtaPR6DhZkOwcm8iF00B7RwaNUXHS4yaBNT+
	VvZqqbNyRn2HeBjBS4sEFGbRvEKBmwx43ealFkElZdkJUOBU75oiDiQqL9rO2YQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vU2FA-00000003Smu-2a9L;
	Fri, 12 Dec 2025 13:27:32 +0100
Message-ID: <b2c6a526c7d0d30a00713ac7e760d9e2e12fc7fe.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 04/14] wifi: cfg80211: add support for key
 configuration before association
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 12 Dec 2025 13:27:31 +0100
In-Reply-To: <20251211124051.3094878-5-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
	 <20251211124051.3094878-5-kavita.kavita@oss.qualcomm.com>
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

On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
> Currently, cfg80211 does not allow key installation, removal, or
> modification prior to association in non=E2=80=91AP STA mode. However,
> Enhanced Privacy Protection Key Exchange (EPPKE) requires encryption
> keys to be managed before association.
>=20
> Introduce a new netlink attribute NL80211_ATTR_KEY_PREASSOC for
> NL80211_CMD_NEW_KEY, NL80211_CMD_DEL_KEY, and NL80211_CMD_SET_KEY to
> indicate that key installation, removal, or modification is permitted
> before association in non=E2=80=91AP STA mode.

If userspace is allowed to do it then it can just do it, no? Why should
it opt in as well? Do you think there's (older) userspace that relies on
the initial key installation getting rejected?

johannes

