Return-Path: <linux-wireless+bounces-11734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140F95989C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87324B22E61
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FE1C2DAD;
	Wed, 21 Aug 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hv1LJmd7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950B1E6165
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231770; cv=none; b=kPhJGGcCd+PUMdtBZUsG3mXDu6YTgnrNZpEbbO3HmNVC3IpuOeUHKjeQ63I5U0mhfCqd/YcIW+lOc/Ad3P63RC96vOhrj0+q7oIzZDWnsaHSo6Jxi0DM+HQfCPHb/wgqu9D96E/0mWPyIo/ak3Z5vLmu6QnPUMwoJCOT0wHnyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231770; c=relaxed/simple;
	bh=Xp2VmvKHO4q0zrH+xBcCeIKoEe9o4elGaOHCdrpei1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLJRNMLCv1Yayc0Vmm6WS5v1fTfCqxO0Gbtvr96RnXqlo38Y60kkl6ZxlrzjgJVwMocT+qxr3KuxoosodSzheMkLnVvb33w0fevN6jL9YVVmvWkHux8B3FqEHDbmgcwHclGOwRpvjgtUBkNYBTuAKqQw+E+jDByWjy3TGbNaWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Hv1LJmd7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Xp2VmvKHO4q0zrH+xBcCeIKoEe9o4elGaOHCdrpei1Q=;
	t=1724231767; x=1725441367; b=Hv1LJmd7GVUEB5M21nROYsnMO3ihrcr8ZUFF5X8ndfg1dNv
	UjbtQZdFIQZW2u7txOJ4DtcRHcG0Zhq9Yqus6PTWbxKaOWpVH6DQ0+mCF4mEqBcCZeJ7LZvjsfIFb
	qSGPIIyBa9NV6RRuLZuIa1INFRJID7Modur92syfXjayqWfZ3gF+1Nd3hk225qqdZD81At2RFnxON
	Q1u0qFbKkBLjpAmCl4JPseJI0GqjvMs6LtrYXdx1bdycI0CAm9mpmpKs6GLiH/7ofNVokOD0Zq6oP
	x+XmAC1v/hWn5/YSRTdjGsEMtEBENGepHZLOLPukzGg1jpm55eXK5RTxhOXeVH4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sghRl-0000000Aduc-1ZlL;
	Wed, 21 Aug 2024 11:16:05 +0200
Message-ID: <c4beca76eee7303af22a9bae67d00fea0efa3b50.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: mac80211: Fix 320 MHz max TPE field parsing.
From: Johannes Berg <johannes@sipsolutions.net>
To: Rory Little <rory@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 Aug 2024 11:16:04 +0200
In-Reply-To: <20240812213728.1799255-1-rory@candelatech.com>
References: <20240812213728.1799255-1-rory@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-08-12 at 14:37 -0700, Rory Little wrote:
> Transmit Power Count will be one less than the number of HE fields, so
> if we do find an extension field, its index will be this number, plus
> one, rather than two.
>=20
> This fixes an issue noted in the iwlmvm driver, where clients
> associated at 320 MHz had degraded performance.
>=20
> Fixes: 584b4bfff5ce ("wifi: mac80211: pass parsed TPE data to drivers")
> Signed-off-by: Rory Little <rory@candelatech.com>
> ---
>=20
> We noticed and recently reported a 20-30% drop in transmit throughput on =
BE200
> radios, and have identified the issue as being that the TPE sent to the
> firmware did not match the TPE reported by the AP. The fault appears to b=
e an
> off-by-one error in IE parsing logic. This patch fixes that error.
>=20

This should be equivalent to my previous fix 5f12dd57a071 ("wifi:
mac80211: correct EHT EIRP TPE parsing")

johannes

