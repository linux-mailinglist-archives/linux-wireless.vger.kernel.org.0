Return-Path: <linux-wireless+bounces-9596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA95917DC1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9ED1C2103E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150F178376;
	Wed, 26 Jun 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/awx/1Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB8177998
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397596; cv=none; b=dFMkVQ7XwkO8Rui6tCTFVS9LU5jFn0INcKdcKqfQHpMnuTH36ekRc51+MXyZ6VYcfw/NajnB25yLu2KFeMmvvgwjx2jIAmkYy6y6TPdUwHJ/NjQ+N85M16pHSHzgftgKeN5HHfHKYLzYkxVkKCZB6XEC20iwi3gL5ViFGi2Wkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397596; c=relaxed/simple;
	bh=wpLxNH25+HaRa7MjpsRH1I6HxeVwu5+Y08nX+fLKDaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fVjE5wOQfTPuQG+QFUw4PXn6WnlHPIDNZnfP2eyIm6kK2zL7aTDXEsYAOhKVzgZdu6q4axLMKEV4/q+qSah0jQSPrQWMJlxjLF6nlfzsBwysQmckFYTvh40rxPCQcZ4P61lxEr+zYtCuDAU8lSC+b7JBgU0O79sLao2518bMSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/awx/1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C369C2BD10;
	Wed, 26 Jun 2024 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719397595;
	bh=wpLxNH25+HaRa7MjpsRH1I6HxeVwu5+Y08nX+fLKDaU=;
	h=From:To:Cc:Subject:Date:From;
	b=H/awx/1YmMEbnTyHDxRVuydFD0IfLgN6zc3jnBnJwEqAhboqX/8pVoKVAKglqya5a
	 G4nxLw+AMjDKycUxkHZ7zaSvKQ/G0PvmwwoWUHfvhKTAIwWeuL29Eklz0o932Ys6VK
	 VuJlU1MMjRXpuFCO155ZG8MIx6DRaPWt8F82013fYzwQ0/3LXGMyfb2FBkKvwNT5Py
	 ILemdjnRKi0ZeAqRk6hfOBsUZ6HbuxegqcOJHsXIdV2VLsClsywxgwvYUunxZbI6sm
	 xviDMWAaJJVldxsvqX2jVSEZF8s77bxR4DgV5KpLtC8E0pTJWs+FK8eqGzI/1whnMf
	 1FMqHBfmEXoLA==
From: Kalle Valo <kvalo@kernel.org>
To: ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless] MAINTAINERS: wifi: update ath.git location
Date: Wed, 26 Jun 2024 13:26:32 +0300
Message-Id: <20240626102632.1554485-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ath.git tree has moved to a new location. The old location will be an alias to
the new location and will work at least until end of 2024, but best to update
git trees already now.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..969412b75c46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18376,7 +18376,7 @@ M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath12k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath12k
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
 F:	drivers/net/wireless/ath/ath12k/
 N:	ath12k
 
@@ -18386,7 +18386,7 @@ M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath10k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
 F:	drivers/net/wireless/ath/ath10k/
 N:	ath10k
 
@@ -18397,7 +18397,7 @@ L:	ath11k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k
 B:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k/bugreport
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
 F:	drivers/net/wireless/ath/ath11k/
 N:	ath11k
 
@@ -18406,7 +18406,7 @@ M:	Toke Høiland-Jørgensen <toke@toke.dk>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
 F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
 

base-commit: 321028bc45f01edb9e57b0ae5c11c5c3600d00ca
-- 
2.39.2


