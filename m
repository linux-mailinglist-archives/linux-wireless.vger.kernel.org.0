Return-Path: <linux-wireless+bounces-15314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EB9CD6DE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 07:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5002831C0
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B117BB32;
	Fri, 15 Nov 2024 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LgQDI7qe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A3187862
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650829; cv=none; b=dgoUAIwvaWwisjUXNxZUVaggrvSFZjKDN9U/k2c7nPg3ia1o91Gyr7bbYChdYgqPFQhTycz9mI5jyVjNEho+w7kqnmUcnV0plOji6ZrGrJ5NHvRSTkRmjB0yRKasWfaSieHcn0xzXzYCX9NnxVTqoKjOpQeD/ieBfYKPpZO236U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650829; c=relaxed/simple;
	bh=88BVfufxkEL6e6/rCKPaZQfdezOSPrWgFe1YnPO2lQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hXrAIbPE8xCF8ZXn8D2ZXansdAPZUmqm/y0RFoiPXnJoP4raWJUHeCtR91Ebqnordm1CmedPuEI84QfNhMlWEjp5XpDh/AvRdEC83cquCMfyWG9bFbjZA73GJPU4EP0COorN6bRRzcduKY62MbsrP99ED8QOVluLpWyzbHEbgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LgQDI7qe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=88BVfufxkEL6e6/rCKPaZQfdezOSPrWgFe1YnPO2lQo=;
	t=1731650827; x=1732860427; b=LgQDI7qe+YaZ/vQMXX28ACYFRnMwORU39V/5d4NtlvXaP9j
	vsZp3Zhs9WA5hKRhVnmLv1Zz+EmIOHyFSyhf1EqoIyUXkCqMlcSGwvVGSvjOq5dBz4oqtyR15szRI
	s3g9AfqXJs0Xdn5AaK66fpuzsGvTfdJFUHswFA1emVjz4JMo7poIBOSvrrD1xLKLMRdRr8eAEzN3H
	v9b+T7qHGPbhj0jH8WuIuBuF2CsroP7ZesgkM5WXFhvma5CUeAX3BDuh8wQxsmIz9o++WzQQAVPj7
	umDyjzNZ2OEQu3XUgOIVDqHVmepl2lrawm157q/vJ8apGHWgGrekIJhOCDRoVhyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBpTz-00000005RkI-3Jzj;
	Fri, 15 Nov 2024 07:07:04 +0100
Message-ID: <cef32cdb2b40c8f57e1aa3806f9f46851430b57f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Fix potential NULL dereference in
 test_cfg80211_parse_colocated_ap()
From: Johannes Berg <johannes@sipsolutions.net>
To: Gax-c <zichenxie0106@gmail.com>, benjamin.berg@intel.com, 
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, chenyuan0y@gmail.com, zzjas98@gmail.com
Date: Fri, 15 Nov 2024 07:07:02 +0100
In-Reply-To: <20241115052525.14554-1-zichenxie0106@gmail.com>
References: <20241115052525.14554-1-zichenxie0106@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-14 at 23:25 -0600, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
>=20
> kunit_kzalloc() may return NULL, dereferencing it without NULL check may
> lead to NULL dereference.
> Add a NULL check for ies.
>=20

Let's prefix with "wifi: cfg80211: tests: " for those, I think?

johannes

