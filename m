Return-Path: <linux-wireless+bounces-27601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D8B94D24
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D0B1903168
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726B3595C;
	Tue, 23 Sep 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mh64+j9L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73276548EE
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613267; cv=none; b=HliWKGI3xOklM6XIIoPrjMtHTy0E47AK8377Cb8+VxvUg7b5FjVfdbVMSniLEtyQe15D7gkXRzl4L7z/0cZOvJVHN8dStNbvHKUEaOM+Zj//8UJQ6aEia4kIkt66FJ0VtCxPsgaKr1yKX2kI8sEZV9naNNInTtxEjzw2KpV2DNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613267; c=relaxed/simple;
	bh=sW7huvxT9Cc7dlwL53+tfp7f8T7qFUGh+I4cCD0+Jd8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpI+uI2WZoS74yQ1krFQLjT6o/IA4I3Odu8JQsfVF3L2sSNfkbmStIUl5TOjIT5U9Qa7CjvC3DrrHC0ZxCova3NSGVJS6hj0JopHm9nBNFSW944F6p+8puo0CtuqMCwDZ6a6svx3gPWZE0Pa3d4eSo+SFz1yzcJQuoHLJE8NVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mh64+j9L; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FpJBcEFGeGbU8f8SoYo4TaBfiyMiHq40r8bQDDtgOak=;
	t=1758613261; x=1759822861; b=mh64+j9LeD9LuufTe60mOsWwvOrpFB94BPocy3PwCihTuVz
	uAtVdzcYpTU177FOk8YMi5zg/HAZ/hnCgLtWIHY4yLRWPvuzYlFVO7eYRr85VBMp1CXTykFeXh7/8
	LWsorkeeR68WRhe9A4hGIzg/Ni7W2pe6V+Fgw7q/Al1INz9LLxxswrupuTC0AEY7SEdiMdjSLfRWc
	VIeQ3BgsD7IinCL4IoJgaXHNUVnPzWEvXP1ccRfBMMe+ar5hj3F2jc/gy+X8rMfXHXNDuBfNpOuJV
	zau4XbrbMmnHuh5sUox75QdtwCt0IcDBSuCMypiLGyxie8HVOUicohuUpP7lbsAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0xdx-000000069h0-1WHY;
	Tue, 23 Sep 2025 09:40:57 +0200
Message-ID: <24cf2002d234a80590ad1cf9670729db1977bbdf.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 0/3] wifi: cfg80211/mac80211: add
 support to handle incumbent signal detected event
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 23 Sep 2025 09:40:56 +0200
In-Reply-To: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
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

On Tue, 2025-09-23 at 13:05 +0530, Amith A wrote:
>=20
>  - Renamed nl80211_incumbent_signal_notify() to
>    cfg80211_incumbent_signal_notify() and removed the gfp argument from i=
t.

I'm not sure why you removed the context (gfp_t) argument, are you
expecting all drivers to call it in a workqueue or other process context
(like hwsim does in debugfs)? That would seem odd to me, say you have
ath12k handling a WMI event (surely this is reported from firmware),
then you need GFP_ATOMIC?

Anyway ... we can add it back later if needed, but please document this
carefully.

johannes

