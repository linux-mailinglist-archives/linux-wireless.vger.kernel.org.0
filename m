Return-Path: <linux-wireless+bounces-23175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0075ABD232
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E12169BB5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02935263C75;
	Tue, 20 May 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X6torU56"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE78263C8C
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730550; cv=none; b=W5k3Gf02POmV0E3oqY7VMiUvhpvjsalRiEdHOC3DkYKH0AfrzmGDn54if649RRbRIJ2iPIiOy/ZUDtjvwGrRkipNBX97t+z1RduluatYhzbAKF3tk8dbq0Uu7oJ5AHj5Z1YPEMTFlouFLWDI+NbAubt+wtgFDG+2JCUiyILlhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730550; c=relaxed/simple;
	bh=aMf+042Xv2f+wBo06XZL2AHmT+ivSFRrSwUNzD1W8/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sH+mTQ/oxnG4O/2VZJ2WcQDZkkep8MRTsrf/1NbbUQ5Yoz1A21Ciih2a/KrfBT4OlMK1rrmMLg+QB59ZndjvLsGZY2kHSdvn2ZCP07ie5u7mad6/AqM9ltAizw1vRscTxKnNtLS32ekyl7KqkCtDckbq7uD3E9L8NNh3sDys7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X6torU56; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aMf+042Xv2f+wBo06XZL2AHmT+ivSFRrSwUNzD1W8/0=;
	t=1747730549; x=1748940149; b=X6torU56deaIZFjGAWhgSRH0m2f+oUYvtYwlybwpi66+Wru
	pM3E+egE2Eg1XBV+NteXyuE4IWAn6JM/Yb64d83qT1tUeWdoQyp3JueGrnr0O1beqNowba31R41fl
	NC+GOIpo+e5H36HE5X3sJcHEE5KcpSDHZtk1SHsosVQqK+ccgw1jdQKBoSg3fFYTYqszQfsiJVqsk
	npVS/rxZ/GCXDIyp0vIGVQA72Y/Zn4P7faTBpKoHIIOxqHuKWgPVRZ8PBC1TBb52n8O7t9Y0aLOjw
	y2mUqBF8eujm2+js/eDxvp3DvFK1c7CeTUR3Y4j59rSjJb5eSnO5+Eb8k/3LREMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHIYM-0000000AqEh-0m7d;
	Tue, 20 May 2025 10:42:26 +0200
Message-ID: <f2a8671507db0aea673d61f78f1934212263d434.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 07/10] wifi: cfg80211: reset
 sinfo->filled for MLO station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 20 May 2025 10:42:25 +0200
In-Reply-To: <dd416225-2302-4f50-a980-a76c7e541fe4@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-8-quic_sarishar@quicinc.com>
	 <b6aa1823646f6911c6dab8db973398bda8526a9a.camel@sipsolutions.net>
	 <dd416225-2302-4f50-a980-a76c7e541fe4@quicinc.com>
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

On Sun, 2025-05-18 at 22:04 +0530, Sarika Sharma wrote:
>=20
> I reviewed the code again to check for pertid and realized that it is=20
> applicable at the MLO level as well. The rx, tx fields are reported per=
=20
> link (which can be accumulated for the MLO level), while the TXQ_STATS=
=20
> related fields are applicable for station level meaning MLO level.
>=20
> Therefore, pertid is applicable at MLO level and also at link level for=
=20
> rx/tx fields.
>=20

Hm OK? Not sure I completely follow. Still seems mac80211 should only
fill that up with accumulated-from-removed-links stats?

And now it gets pretty tricky since we have some stats that are
accumulated from removed links, and some that aren't?

johannes

