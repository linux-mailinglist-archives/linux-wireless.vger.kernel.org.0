Return-Path: <linux-wireless+bounces-19530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2CBA476A4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 08:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE1B3AB360
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260CE1EB194;
	Thu, 27 Feb 2025 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O2vRy2bK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25F374FF
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641646; cv=none; b=t1hhKFNCmSNXMSdq+VhTfuStiUMO3IWldIKSiyHQnhFkbbG3C0q3OfPB+mWuMH8rcmsEkXidZwCqx4522Hz6YnqVIYGJtqtwGeDeVaLKbLnvTf3N0DeFP6JwD4X6QC+wSpDBAyxmTDUIi2emDIrW5B7kTIRu8XMoEX1A2Gx/jqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641646; c=relaxed/simple;
	bh=bn93eqiaYt0rFloBFngFjMy8+5vb69+CMW035a8UWfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSrjxv+gveBxFnw+BYh2mIUU65t2C2W/I2y8O+Pfl8vYVksMBu1B4fS1/Ox4T8oqlyf+wk0vF0leecP9skTJjH8MeRJZVxxYdIfDQ1bYYdCG55vbjIZNY5x2j28u8tuAr9cqhgnx8PBfygRqLQCXPOk00+buRYgDeGVTkSlfY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=O2vRy2bK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bn93eqiaYt0rFloBFngFjMy8+5vb69+CMW035a8UWfo=;
	t=1740641644; x=1741851244; b=O2vRy2bKgUrgQIAbrO97V/0+Qiq+4ABueiiI+9uOfgoq6uK
	VkF3MYXp6+dWDIedvVwrxwSE6/LZZpOGsfv3RByIcZywLMqGKZoM0QbaOm6oCYlj3dlMqV700nI68
	RpocXdSh1120M7RbnxhD5rOtFACeA8xbzU9ltjuC0g6LwRFA0/Y92lGJxPAmzYDeKpsf8RZkrdKMk
	f2D/oQgqnM2o0xYOgsWi1mMgFbeM/OqB78Fok/b5X2ukcgxp0TcD7kKPvs6+tRek7gt3EezLD1Mta
	7Ahxk+YGIPMEHkUWrKC6ugIs9I482RQ/gOyeXLCgOgVSdqTwvcQ/3gv8kXE9UKfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnYP9-0000000CSaT-0KsA;
	Thu, 27 Feb 2025 08:33:59 +0100
Message-ID: <2eaeb361c279a8c68e3b8a165a45a20de8d94103.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Add support for management frames
 stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Ramya Gnanasekar
	 <ramya.gnanasekar@oss.qualcomm.com>, Jeff Johnson
	 <jeff.johnson@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 08:33:58 +0100
In-Reply-To: <b3ca11a1-2923-45c6-ba42-be916c37d664@oss.qualcomm.com>
References: <20250211202518.126305-1-muna.sinada@oss.qualcomm.com>
	 <0aa5d6e8667350c7a3d80af4ce3956cad7096fba.camel@sipsolutions.net>
	 <b3ca11a1-2923-45c6-ba42-be916c37d664@oss.qualcomm.com>
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

On Wed, 2025-02-26 at 17:17 -0800, Muna Sinada wrote:
>=20
> I was wondering is there an existing feature/statistics that is a BPF
> program commonly used in wireless you would recommend to use as
> reference?
>=20

Not that I know of, but even the simplest examples of 'bcc' [1] are
about statistics on tracepoints.

[1] https://github.com/iovisor/bcc

johannes

