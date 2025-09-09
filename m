Return-Path: <linux-wireless+bounces-27152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E071DB4A5FE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6B01C219BA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6262737EE;
	Tue,  9 Sep 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fu7KJTdD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C4258ECC
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407930; cv=none; b=KQuB1tEx8aepckXmyEqSpvhyNnVNaAPSdo5SJr0IhkBTwqspcq6S0WWmDqJv6Aji5rgxwHqewN7cEB6YoCeQW99+ZvU8J3uLCbIy/CGzdiJWymTSUbfbvXdUAm2hTr+XJCVjnMPGEX12nIMFe5zKeSlekoYHJzi+uEKvMmEjJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407930; c=relaxed/simple;
	bh=70DKahrCgTUX7Bt2nig0R7FcGtwZv4NLmcMvVOEdKfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SR8KC4G8m/z9RlcRceQzJlL2G75xPrzfyj7K1LTdreUPsUVfICeJG88pbgOk80TsK5JgkK8Okj04OwA8pqDLlylMa6elSqFpU61P8DQh6sltc+VVxU+oNDMTjEJf+g2hVIdbJWGCwIJeutS+nGRc0Jszvv5NXoLjUhK4tusm7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fu7KJTdD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=70DKahrCgTUX7Bt2nig0R7FcGtwZv4NLmcMvVOEdKfE=;
	t=1757407929; x=1758617529; b=Fu7KJTdDkggsybY22+M/ycK8oazxpeugoeKYHZQfxRrDaED
	NTvYIIbfVRaaaDyfNlXBYCHbemPczROqaW92Wsi+G6qlj6CWpArTNrnH8PfeYKWUL2XZ5giSUlo5H
	AU4Tny39fyYPKssSPMJ3qdMCkQjMGiWEY21XNACfZQoBXSOkJNVkUdqdmsGXvZRqFr7peJu0R+m6F
	Xqcxswl+tTJH1EF1SuBDOrDT/XREYxp1YnmyE5k4a29VnmsyL3Ammy4ylEHs8ST585OZ6Nx+fiwbs
	XJXTNsE9GB7mMAzLV6YDk/1ClOrYruiQe6fDQ8Nvtur043wiLut5iOZgDtZQj7+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvu57-00000009w1Q-3xoL;
	Tue, 09 Sep 2025 10:52:06 +0200
Message-ID: <6e9988588b74e2c7d9b1450ab9e3c2174b619d29.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 3/3] wifi: cfg80211: remove
 ieee80211_s1g_channel_width
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 09 Sep 2025 10:52:05 +0200
In-Reply-To: <20250909080758.1004956-4-lachlan.hodges@morsemicro.com> (sfid-20250909_100824_918342_91DBE4A8)
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
	 <20250909080758.1004956-4-lachlan.hodges@morsemicro.com>
	 (sfid-20250909_100824_918342_91DBE4A8)
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

On Tue, 2025-09-09 at 18:07 +1000, Lachlan Hodges wrote:
> With the introduction of proper S1G channel flags, this function is no
> longer user. Remove it.

Oh, so this is some "keep mac80211 working" trick?

johannes

