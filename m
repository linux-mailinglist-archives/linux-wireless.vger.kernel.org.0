Return-Path: <linux-wireless+bounces-18060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A0A20732
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C2C188463B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9E1DF97E;
	Tue, 28 Jan 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8ZNHXYU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9F1DC04A;
	Tue, 28 Jan 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056030; cv=none; b=U+QNlxlgNT0B/KUKbHOq3z+aOVklvlhjCv+01kFACgDhUeOfmfHtLoPnRuAcPkUx88HvSjslmXhJiClf4GDJ5FY6nct87HmDuwsdqu57Ju6gHIrHwPWdNtzlU3U0SHj48w63Di37szuEZQDvPi88I9EQBz0KZB0qjuyv4YdohWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056030; c=relaxed/simple;
	bh=qHeRy3aXUVz3lNP+jrhSUEGQtSOzOk73nEF1lSoli+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d1uAxKn/Cck60RoE7YrDVYC3/XOobIMGdBuEZodG22cgTxOAuJUMDP+rgjUTNe+jRPcFAF2iW7fP0EtdO5pbkKkCHZuYr+QqDGtPzS8BqngK06z6zdy6r37gt0VcAnj7MexzM/9J8PJ/JtFupnV7Jsql0eepdteZ+QnSp7jrDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8ZNHXYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FAEC4CED3;
	Tue, 28 Jan 2025 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738056029;
	bh=qHeRy3aXUVz3lNP+jrhSUEGQtSOzOk73nEF1lSoli+k=;
	h=From:To:Cc:Subject:Date:From;
	b=K8ZNHXYUl3f3CX04A/gRsMdbcnsm5XHuUu09LIKbTrgDhN7EiQa1CkSLXGIys41po
	 1mVBJp4TV3pOXMF8dYKG9iHdw6unF78RF1PJ9fXJo3WdlK1bVWKv694rYn+zVfdoG1
	 bdVymOW/LyFH/StlcJN+88e6VC8f4M5L4H07ynFqsjZsBGbDDW9sVyR/LMYkSP+5j9
	 3CKA2IhdazaLE3D+nEnI5WYtpPCH0H0u0xxtvbnSFTgyDokMXXhBz7MJzevjKscHfR
	 dO9TYyK6JeN1OVdnXR1+Emthm9Yn5A5VgYZGp638eqn0J6L896E1V+70UU6lgxPvWT
	 6BkmKGFmr+Uag==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc: ath12k@lists.infradead.org, ath11k@lists.infradead.org,
    ath10k@lists.infradead.org,
    Johannes Berg <johannes@sipsolutions.net>
Subject: Stepping down as maintainer
Date: Tue, 28 Jan 2025 11:20:26 +0200
Message-ID: <87wmefguqt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi everyone,

I'm stepping down from all my maintainer roles. My first commit
feed9bab7b14 ("spi: omap2_mcspi PIO RX fix") to the kernel was back in
2008 for v2.6.24 so I have been here for a long time. Thank you everyone
who I have worked with, there are too many to list here.

Jeff continues to maintain ath10k, ath11k and ath12k drivers so they are
unaffected. But for the wireless driver maintainer (drivers/net/wireless/)
there is no replacement at the moment. If anyone is interested, please
do let Johannes and me know.

Kalle

