Return-Path: <linux-wireless+bounces-5271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6D88BB8A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07C029E33C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87B130AEC;
	Tue, 26 Mar 2024 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J5e+BM70"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D401804F
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438961; cv=none; b=QpFoDeJjx14ZFw3vmeRPE+Q4QyOHbgaRCE/CTV+oYvhKjYaYyypDjeLO0ztSQs/DknbCrT0U4kEDdE/KkvAPrBve7qrHIwjuEYOckz1UpIfmj3g4bG4QO23UiwwlaO7X2ebUc//mYzYxcqjvsCe4w5rZusunjgVfiafrhiM7iN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438961; c=relaxed/simple;
	bh=zWGXBDXwY0D35LSKb6gY+Q2iYQkXHTQz8uERzaTlFrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9DfEv4EzUZsV8omm57H5jrUl0nLZ8Qq8hUMhmxW6q0eqpHlrNdxTWuR5RLLrlfrm1Ijin+opnK21zOt7QF9Jw7palODFESJ14N0D3DDH8D2WNoUKUeFX1WENKy1q5/oBeDZV5yxv3gx4ejugzOaBtkWgLQPENfOd4R584KZGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J5e+BM70; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zWGXBDXwY0D35LSKb6gY+Q2iYQkXHTQz8uERzaTlFrE=;
	t=1711438958; x=1712648558; b=J5e+BM708yaE/+gJGjE7Fd8+B3luhaquobXHjf3PG9H2YGb
	On2XiVepKDHkSKBudgJyXq91LKNhz3Cd7yqQionVGpan3PXny/LfMPVExuEiN3RZYDyyaVnvpXPy9
	m9v0Zsnhi8miZ0EH3wgvWHBOhIfnJ+sMHOdJvOcWbZB4/pnwtysw3wEeVUoRoWPH1DuyOLnu50EHh
	QiAIE3Hid7SZYUY8FP8GRBr5MdYq2CbxnrH1iXZwC5Wvjpkt+yPV6t3gRxvconv9qt/zH9wNF1n7A
	5RmKRWU8nQd0SYKXcMiXumWh9HU57QZsyeLBDZ0TruN2gj7f6O/gJSKEFwI1oF8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp1S7-0000000FXmQ-0gPX;
	Tue, 26 Mar 2024 08:42:35 +0100
Message-ID: <5576f8160e7d4b707fe2dc3681721cb49dfeec5d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: validate link status before deciding on
 off channel Tx
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
Date: Tue, 26 Mar 2024 08:42:34 +0100
In-Reply-To: <cd8f0071-1033-46b8-b7d7-3140079e8a5a@quicinc.com>
References: <20240312154620.242773-1-quic_adisi@quicinc.com>
	 <2c8338a29d3c42ebbf1fd5efd348c14471fa5004.camel@sipsolutions.net>
	 <bc2422eb-efae-423e-b60a-2aa0a3ea94fb@quicinc.com>
	 <cd8f0071-1033-46b8-b7d7-3140079e8a5a@quicinc.com>
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

On Tue, 2024-03-26 at 11:27 +0530, Aditya Kumar Singh wrote:
> On 3/26/24 09:58, Aditya Kumar Singh wrote:
> > > Can you fix
> > > that too? And if you fix that ... yeah we probably still should have
> > > this patch but ... _without_ this:
> > >=20
> >=20
> > Sure let me try to fix that as well. So here's what Im planning -
> > 1. Separate the ether_addr changes into a separate independent patch.
> > 2. Patch series to fix the active flag handling at link level.
>=20
> Upon checking further, I see -
>=20
> If we fix the setting of the flag only when first link comes up and=20
> reset it only when last link is removed, then probably there is no need=
=20
> to add separate handler - ieee80211_is_link_bss_active() to check if=20
> any one link is active or not.
>=20
> FWIW, the purpose of the new function introduced is to check if at least=
=20
> one of the link is active. And now if the flag is set, this ultimately=
=20
> means that one link is at least active. So we do not need to go and=20
> check in each link again right?
>=20
Yes, which is why I even noticed the whole mess with 'active'.

johannes

