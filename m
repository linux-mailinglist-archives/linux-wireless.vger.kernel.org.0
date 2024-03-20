Return-Path: <linux-wireless+bounces-5005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6174881745
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D121F23161
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5656BFAF;
	Wed, 20 Mar 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/roussB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6B6BB24
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959092; cv=none; b=PhB0FJdFzlje+y/VnonLOhuH8bvj4yvWQUDONZbWiDMFmrFbGRLTsokqFWBPHuwe8gx8qQEJxSUuzqpd4ORtXByGqITNDyoKjFBP9fwn2Z0exJsKTr79iSHgg8YTa1wqXAHSFhKHvCs2glxj5zM+xqaxRK5x0+IV3B8MsUOqXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959092; c=relaxed/simple;
	bh=ujGI6Gkz44YVs1cgcIJ6eWhqOS6tpeImCsfw2lU7deM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qCKqBbrszBzHvGU/Hrp8K9igYoYgHlU7TXnGwa/9eXh2LTBsEHEa2l65M4Z+dZH2UshoAQquiH2C31BMQRs3wu0srPXXnrwFV1I1DzC6KDUkKJJ3ZauhHkFSH1jmTG98hWz6XXOo/aF0roarEohNvvOEpFUYuAIuAKsdjg/Qkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/roussB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CF4C433F1
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710959092;
	bh=ujGI6Gkz44YVs1cgcIJ6eWhqOS6tpeImCsfw2lU7deM=;
	h=From:To:Subject:Date:From;
	b=M/roussBrVQuucM/vpsNvu4oktMU9I4yMosGyvyUkMqO5C20TkbktXw1VqU3eiTUb
	 Pp0OY/GtgLvkl8Vl2LC3S8TOJX84BiPZOfvQ24dzQUv/MUR71bH/OlHx4MJxNtBDLJ
	 RwfS+RnF246tS9KGkWBO4qOWctmvcj7uun6B7Er/ETMgtOSURqeFbJNZjhNPChzhP5
	 e2aNQLr3KiHrAtBNl9dOcT301YVbuo638PovcNt+fvG8IAGYOkaaHxJc2YfMF1ZMcQ
	 /9P91qPpTf7Wj2dyR79eWuDBLKoWHsJRaMp7qXRVlWKk1RZ7IgT86ELFoFA6MFoihr
	 WFj0YPanITXCA==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] wifi: ath: fix remaining sparse warnings (excluding ath9k)
Date: Wed, 20 Mar 2024 20:24:45 +0200
Message-Id: <20240320182449.3757215-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

With this and the ath9k patchset[1] we finally have ath drivers sparse warning free.

Please review, especially the wil6210 patch. I'm not really happy about that one.

[1] https://patchwork.kernel.org/project/linux-wireless/cover/20240320170656.3534265-1-kvalo@kernel.org/

Kalle Valo (4):
  wifi: ath6kl: fix sparse warnings
  wifi: wcn36xx: buff_to_be(): fix sparse warnings
  wifi: wcn36xx: main: fix sparse warnings
  wifi: wil6210: fix sparse warnings

 drivers/net/wireless/ath/ath6kl/htc_mbox.c  | 3 +--
 drivers/net/wireless/ath/ath6kl/htc_pipe.c  | 3 +--
 drivers/net/wireless/ath/wcn36xx/main.c     | 4 ++--
 drivers/net/wireless/ath/wcn36xx/txrx.c     | 4 ++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h  | 7 +++++--
 drivers/net/wireless/ath/wil6210/cfg80211.c | 4 ++--
 drivers/net/wireless/ath/wil6210/fw.h       | 1 -
 drivers/net/wireless/ath/wil6210/fw_inc.c   | 4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)


base-commit: 4b2f0ce6f2fe0fd906d408a01e494b85c272c7d7
-- 
2.39.2


