Return-Path: <linux-wireless+bounces-28862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF496C51266
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 09:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D343718962BA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC62C08C2;
	Wed, 12 Nov 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cp2nlfRM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C2283C83;
	Wed, 12 Nov 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936878; cv=none; b=o2oEPXEfv5PxmSpH6jZM0GGozmh+8T8RugzCsQnjKPGTa4uoDpSE4Pq5AZ5JejxCO/VZhyNmFlGdg33ZDVA4bl1piMTaAMixggYfwd+wSqEhPX5xCJ3ncc6qMcEE1UIpPZBkm29C3c7m6iMFI1dc1R/6pA1PSAEmODahOoHY6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936878; c=relaxed/simple;
	bh=AODcbYRXYAyiBe0miJXWc2OK8chkjOMJ2iNX5JU3mPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOdV1kgkVRxrl7GZZe4ix4MRtt9zCLgAcDNHFRIuohaEbH+FgXKFF45tey8XSvvAMtMcPRhb3S3j/8ndT3AmYj1W9xZGtDely0d94gPzhSpP2KdIP5ItoLkbsnUKcWYL7DBgYvOnB7YXo7Wg6Nfqxz4YkuxZ49PXykZCqiDHk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cp2nlfRM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AODcbYRXYAyiBe0miJXWc2OK8chkjOMJ2iNX5JU3mPQ=;
	t=1762936877; x=1764146477; b=Cp2nlfRM+vR0VigYYXwc/YM1K2bQKKJcIxaShtIdYFqoE8d
	ZoPQFYwUq72fIodPgu1Fe5ZzpYjYtJKUsZdgcCQuKDlBxpBok3cBtk3uUfQtr710njvybbiAKzFn2
	UfyRy8cxjF6iW45GyVFXVPCK5Qit1WoC7tmaQYMaH4PGQGZsWJbVIgqTrhqgZKoEE5Ro0VErJJ4Yz
	fIvyJOncZn5iMpxKHmE1AwV6SQHpnDUR6a4rmHWfdzVGryFI8HBRFsycroa8z2UM7uJf+BB/HnByT
	u5p/gDBDcvak0BuL+1YWT+2irq8HoJ1YY33tpf8UwuutZdAAKzxZ5C8rGkIKyE7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJ6PZ-00000000vOA-2Ale;
	Wed, 12 Nov 2025 09:41:05 +0100
Message-ID: <494afbf2ca5b18f230b02b03f122c4d427dd08ee.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: make n_channels updated absolutely before
 accessing channels[]
From: Johannes Berg <johannes@sipsolutions.net>
To: xu.xin16@zte.com.cn
Cc: kees@kernel.org, concord@gentoo.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, qiu.yutan@zte.com.cn
Date: Wed, 12 Nov 2025 09:41:04 +0100
In-Reply-To: <20251112163750463kAkOIyBxvHkYWh9Cgdypb@zte.com.cn>
References: <20251112163750463kAkOIyBxvHkYWh9Cgdypb@zte.com.cn>
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

On Wed, 2025-11-12 at 16:37 +0800, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
>=20
> The commit 2663d0462eb3 ("wifi: mac80211: Avoid address calculations via =
out of
> bounds array indexing") said that req->n_channels must be set before
> req->channels[] can be used. But there&apos;s still the case that req.cha=
nnels
> accessing was prior to n_channels++.
>=20
> This does not fix any visible bug, just making n_channels updated before
> accessing channels[] absolutely, to avoid potential UBSAN out of indexing
> warning.

I reverted the annotations, so this isn't necessary.

johannes

