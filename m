Return-Path: <linux-wireless+bounces-28117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC552BF417E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 02:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914A5425FC9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB114D599;
	Tue, 21 Oct 2025 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Qz06iSNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DE800;
	Tue, 21 Oct 2025 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004935; cv=none; b=O4QFbApemkC5ynejCu3/KpX0u0f9ujcChFTdXRK3SIuKHPeoI069f2jOsqzJbcU9RkIp2ibLwIKyWJpSfgKfuKXnhl4Yfj2VQcqCx+kDfr5PUdD419FKT2eUqTGqDQEl1JjHsBOdk5hE5ockD7L1asBRCVJqLd1wth4hKXzTZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004935; c=relaxed/simple;
	bh=RPKMz+FZqU3Ym9VUHosAG0Mmo/rDbbCY7J0xa//Gio8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqrwu3lZHQuqDmIeb6wVvEp063abGFmKH1F7ws9zgWV4N8iXiE9JUqv5dkHtbPgAhaW7uqig4c2LyHBsrdaWR5LhssSo6KsWCo43qtq2O4KGXw/uQ27avrci5D2/sC8v6EhnxS5o2PkvWGYotW08GV9fmEVKnAG1maTnJcgIZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Qz06iSNl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RPKMz+FZqU3Ym9VUHosAG0Mmo/rDbbCY7J0xa//Gio8=;
	t=1761004934; x=1762214534; b=Qz06iSNlfQAF7UoSi60fRsPkmRikk3Mv/K69HZ3Q4TeHCBq
	RrL9rRJuMsF4rPVClibMCyQ3UpF72s/QsA+l2nXGnVKocMCTbPo1X5J80M1wO5+ptyp8tecTEjLnE
	o/IUpC41sfb9TH9tKS0SKUC21vJFt9yReGy6ovkbeY8SfFmxmViVfnJsFVbxdJoo6FR1CC95L7hVk
	XnN+L6chb6g7nkSzFxr2tDVCKtshJsVRMoqdOhB4wzJe4Z0soblTZW6ouSCErPKCQ2/IAxCwZGWDX
	jVzThJ6yogPc/plGxEwvVY3riL7edVmpurDOb4/Bc+QxV2prdLYQztuUmem8/PgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAzpK-0000000A2VQ-3wBP;
	Tue, 21 Oct 2025 02:02:11 +0200
Message-ID: <017a316a1200a41cd5a51c4f1b7c46292860386f.camel@sipsolutions.net>
Subject: Re: [PATCH v1 6.14] wireless: aic8800: add support for AIC8800 WiFi
 chipset
From: Johannes Berg <johannes@sipsolutions.net>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, "he.zhenang"
	 <he.zhenang@bedmex.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 21 Oct 2025 02:02:10 +0200
In-Reply-To: <0d807f54-7579-43a2-99c7-2a19cf715ec3@gmail.com> (sfid-20251020_232725_435849_A51F912E)
References: <20251020092144.25259-1-he.zhenang@bedmex.com>
	 <0d807f54-7579-43a2-99c7-2a19cf715ec3@gmail.com>
	 (sfid-20251020_232725_435849_A51F912E)
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

Hi,

> However, there are some problems with this patch.

That's a _massive_ understatement.

johannes


