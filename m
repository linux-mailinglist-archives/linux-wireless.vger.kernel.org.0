Return-Path: <linux-wireless+bounces-30711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBED14E38
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 20:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACBC4300F9C3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144411A5B84;
	Mon, 12 Jan 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fKJCTqYP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926CBA3F
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245510; cv=none; b=e6dXKATzggN9sLYLdJjh70gGPozbWjdoE7Xe7Y0VOwFn15VTcMKGDm6eLiiEn9kT07Si26Zi1Yxi1rHTrM/gR2N/9oGDSHX3OhdgFgDAY/t6Qns1XLnBDv3vYsdsFYj29YJwHits3JNi9tOHpvD+0HsjeknEsUMmmSH6/zl930g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245510; c=relaxed/simple;
	bh=8GjqNiKKFojuLMmaBmWkZoBBFUEPAi0Ka0pw1kQpeYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MiwrDgTa6X/qmwLVlO6uYkMN0PNSXt3+pyC1GeaHWj8fSR3ByTwTp/TgvRDWMlgk1FH5CJGUe6mEw4yoEBsdMgkXUtsnxNv4zEL+RIdaPdEIQ5NHmTH7+3uR/IGVqW7OTDLMXUH5W00x6iyIYozfOqZLfeaSWRoVfsk0udGUtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fKJCTqYP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8GjqNiKKFojuLMmaBmWkZoBBFUEPAi0Ka0pw1kQpeYE=;
	t=1768245508; x=1769455108; b=fKJCTqYPESsR6P+mTUzmu8kTUPkfm/uZpFG2a36CNOsnDcS
	e517sEbPXQdFCX4ZYwW0ZFebfQCjn29mk+P7swkpGyU1VeQUwvOZXiRdW1KuLWk2fqmHDwqzeUbJL
	0CnO7ilUkgA0r9klkX4obxQRpudQF3jUC6HypGBgY7tEwKQ9skGPi8sf6oB222O2iwH5d8aI+0vWP
	Sf2Qkso37MUYY6M3E2yHf953bLkmkbpHCkN0aJ8wRRf+/6coqJPOzHa+fvQ6CepSshrRYzb5npEBe
	yzsUOGnR2LcrE3JZMsqzDWQCJXS/ToUDXV2rdyuvaVBEDsGXy5rtzWsxEuXfUxQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfNQn-0000000A1Pp-10Ag;
	Mon, 12 Jan 2026 20:18:25 +0100
Message-ID: <59cec65b29ded381c85d1be943d88e956a4b7e74.camel@sipsolutions.net>
Subject: Re: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP
 Coordination (MAPC)
From: Johannes Berg <johannes@sipsolutions.net>
To: Abhishek Rajkapur Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>, 
	ath12k@lists.infradead.org, hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 12 Jan 2026 20:18:24 +0100
In-Reply-To: <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net> (sfid-20260112_201230_217667_8E744336)
References: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
		 (sfid-20260112_195259_393455_5899DC2E) <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net>
	 (sfid-20260112_201230_217667_8E744336)
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

On Mon, 2026-01-12 at 20:12 +0100, Johannes Berg wrote:
>=20
> Why do you always want to let firmware be in control of everything?
> Seems at least for some of this you'd really want the upper layers to
> control it for purposes of coordination? How does the FW even know which
> other AP it can coordinate with, isn't that something a network
> controller would determine?

A less generous reading of this could be: you guys want everything to be
controlled by FW, so you don't have to open-source it in hostapd. Now
you realize oops, don't really want to do all the security handshake in
FW, so we need to ask hostapd and then we need keys and stations and all
this stuff. So let's build something nobody else can use, upstream it
and we get the best of both worlds - others will maintain the mac80211
code for us anyway.

Am I wrong? Is there a technical reason for not simply doing MAPC
discovery/agreement negotiation etc. in hostapd as well, based on
driver/hw/fw capabilities, and then you don't need all these strange
"triggered by firmware" flows?

johannes

