Return-Path: <linux-wireless+bounces-29361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7BC8B1D3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 18:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F513A3B40
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401F1E7C12;
	Wed, 26 Nov 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OuDAd5to"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06061DF75D
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176561; cv=none; b=Ko2AEuPftvB6rfMW1auDYGv89B4IBSgVK4quQKJ14qsKZQ90cqBrDh8ZPZ3dRpFWRTiAhSinrgBaCwVl465viXwdiWdis9zTkVJFBCx/UJIfdsDr7qH/ZvBT5Y9bp9GcipGzYb+2WgebpMSqzLKMLQbIFpDxnPKYVnHsUBKhdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176561; c=relaxed/simple;
	bh=AIOlAWyWaTjRliFd4nmSQlOjMUhMfH4Q0yg0lI8kJl4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ga5Gvaxo8OflqWCKBgmh097udyr5fMTnKPqLrrLNaHevjD0MVGitmJmVuNZeLYTB29uahheSpISNKh/+0Ei/ETQRejD+HsebreL6sDo8i0NynXGpkVW7MNBJ3uUN0Yz9RMTqZXUfP+Q3wjy6/ON8qpvS2HJ2g9LhtiVa8jdhs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OuDAd5to; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=uuv37uwupzbuzfgdf23znnfovi.protonmail; t=1764176547; x=1764435747;
	bh=AIOlAWyWaTjRliFd4nmSQlOjMUhMfH4Q0yg0lI8kJl4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OuDAd5toQyWlIpy3kAtolh9j4Qfqn7KRfU6uOmqAfXWceyM5BT62NZ/F2qpz37LDR
	 Iscg0z0eD+cb8pijTZvl+7+z7CZ/4gFNY17fUeA1QpHe9gujyWaZmAG4VsXnkd0ZpP
	 RHKBGqMQ/XYvNs/Os014P47VLd8EPry0s4BN1+hxOHq9oOoGgRffP76zLKJMof5Sr4
	 AyP6QNKAzUJrsaRK2WhFbcQR6FwWJnp2dG1xtNCGL+nU/BgM6ZEb04VbsNqGiLpt0p
	 Z/HMd+VeGU5frxKx6evPtmzhxJ9Ib4WgaR8R2+7nNn01evVodGK5ulg99IDZJG2s9/
	 hOe4DRpM3Blwg==
Date: Wed, 26 Nov 2025 17:02:20 +0000
To: ath12k@lists.infradead.org
From: Alexander Minchev <adminchev@proton.me>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: remove redundant pci_set_drvdata() call
Message-ID: <20251126170213.27959-1-adminchev@proton.me>
Feedback-ID: 99141252:user:proton
X-Pm-Message-ID: 31056a73fd1cbf5979bf38ab2e7430a6e6ba5cfe
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

this patch removes a redundant pci_set_drvdata() call in
ath12k_pci_probe() and keeps a single call after initialization is
complete.

I noticed the same double function call in ath11k's pci.c in the same
context, but I do not have ath11k compatible hardware to test a similar
change there.

Thanks,
Alex


