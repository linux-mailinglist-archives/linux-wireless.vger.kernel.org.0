Return-Path: <linux-wireless+bounces-5488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EDE89082F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283851F24141
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F52C18F;
	Thu, 28 Mar 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sMr3HbN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03F1879
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650336; cv=none; b=cipupqCf7iOTW6eQ0QHEU5f5PXcRIz+cvgOsBj5jGoEQRYtf76OsDhsTC7nyLFftJR11c8AHFn9hM5DB9/Jivq1NJwNHB6PyE6SDJpUOmykoYOVGTYhsRJPdHRIWA/Wyqfk0Nj3V6TtE1y6iIEkE11wJHjijHDGpunpdJTjuxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650336; c=relaxed/simple;
	bh=4ISEsymbowgkORltO8GqXHNWkZd0dNrHh6FP402gvfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0h3IaGM2ErV44OCF58leOh5RInE+cUvUmcKRESWik5X3tkGR2FiHXeXq4PxNciYU13NedHyi3elMsNV7gTrLzy2KwhEpgLTzOYTypjt6dvNH2iM/h96sApULHJna+4SJzSbyumCzlV6PMPNw0LBzDlA8RHT4PTEeEr8GVChgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sMr3HbN4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4ISEsymbowgkORltO8GqXHNWkZd0dNrHh6FP402gvfQ=;
	t=1711650334; x=1712859934; b=sMr3HbN49CCLM5gL/NI3u1gzquSliOFE2SV8uI+WgCRJ+Zc
	OKZfyj0hUiv4JSJZxUqwiaY0QyMUU0N151R+5mjqmcuKpHei3vUanisLpTInmB7FpwJPcYb6B6Et1
	l8/uYkqT8n6JpGxfVSKL6Q+e4a5fiOjxZhznl9mf6eDN7v0zwbJekQnTz7rlycP03CeVL3agKKoix
	doOTPVVsL0hNlSOtlyIdrREYvVoMXyQNyMrZsvoMwhstupkmYJOORd/QQPKu4S38q1TJMTh8CPMT2
	vk270wAclPMmpKUw6Pzu2B/DCcLdFrywrh7s/ugvry/p4vyyYpwy3tPmnz35YWkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpuRQ-00000001Dl0-0D7A;
	Thu, 28 Mar 2024 19:25:32 +0100
Message-ID: <36c9759651193a1de32020b9f9a019523eebabc8.camel@sipsolutions.net>
Subject: Re: [RFC 0/2] Add Multi-Link Reconfigure link removal support
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 28 Mar 2024 19:25:30 +0100
In-Reply-To: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
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

On Thu, 2024-03-28 at 11:22 +0530, Manish Dharanenthiran wrote:
> This is a preparation for supporting Multi-Link reconfigure link removal
> procedure[IEEE P802.11be/D5.0 - 35.3.6.3 Removing affiliated APs] for
> driver which supports offloaded Multi-Link reconfigure link removal.
>=20
> Multi-Link reconfigure link removal offloaded drivers will take care
> of updating the reconfiguration MLE in self and partner beacons.

I think we need to flesh that out. I don't know if you saw the CSA
discussion, but I think it's pretty obvious that the same discussion
about partner links is going to apply here. That doesn't necessarily
mean that you _have_ to do that in this set (though I'd actually like to
see it to support hwsim, for testing purposes of both sides), but I
think the way it's written now the API doesn't consider how we might
update partner links if it's not automatically handled by firmware, etc.

johannes

