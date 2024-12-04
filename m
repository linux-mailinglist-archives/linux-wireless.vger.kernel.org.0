Return-Path: <linux-wireless+bounces-15892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332A9E3FB3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333F62824D5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB6920ADCA;
	Wed,  4 Dec 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D08VRphc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FF156C6A
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329940; cv=none; b=WTPlKNMcbDDZbrpA8YdSQM1msQJ1ZmYUuKcGFcNm+mVUrXtLXYBhyjBgzBDsmh+YBQfnMf/EDQLlWoogRnrv5SwqJz3hexMQ1rsx0sEmcooCokAORn5KOA1/Tj3drJpFAP/jdOydvd0AMg+2LN0PzEOaK35ysii7QRg1vbWXPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329940; c=relaxed/simple;
	bh=OwPJmCes64j6esiKcT95YSy4YtWsyeSNOeyY0UC2m8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SmuWsdkhMbd6avHjYC7CWiVgL3U305lelq7NogIfFhjUSpqEyelVu2v4C8xbjNuOBalh8d5+DLSh9RD923gFyQWpF1NEAZyUquxlKrbM3WYlAdypD++oOOrkVYteefz50ajGL8pCz5KRoxdFx4k0YPdsHfNavPzBz4PXB5fE4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D08VRphc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D19C4CECD;
	Wed,  4 Dec 2024 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329939;
	bh=OwPJmCes64j6esiKcT95YSy4YtWsyeSNOeyY0UC2m8w=;
	h=From:To:Cc:Subject:Date:From;
	b=D08VRphcW4iFvMr4oB7zjcIWFALSwt0n8pnLpt+aW9rqfkkA5UTPzVOFf4mnrdh47
	 7ZcVDajUXkbuiky0FDLbC0abuDILbnyaKfTtLeVLZ58j73H7P5a0pple829UhAZTWn
	 UNbBhdk3ckZsE7/wkR8aIMcHp3jbLP3QL0RChNqnuA2yJh6pbyEsKnLmY8BPABXcr5
	 dPlPFgg09kPgZl94GyV+N1efslQbY3J/o7NvxdmbZaPYaP46rQ2+z8jyhyvKulKjFp
	 xo3DL5MOle+yrSaXgL+VlAnjudiTefszcW2eQiM9jS3tI6NQ0A5ySmDIwb6uliDl2z
	 rgPOFk6MqpGCQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/7] wifi: ath12k: MLO support part 6
Date: Wed,  4 Dec 2024 18:32:09 +0200
Message-Id: <20241204163216.433795-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

In this patchset there's refactoring to support hardware grouping, meaning
multiple hardware devices can be registered to mac80211 as a single device.

Please review.

Aditya Kumar Singh (1):
  wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp

Karthikeyan Periyasamy (6):
  wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to
    ath12k_mac_register()
  wifi: ath12k: introduce device group abstraction
  wifi: ath12k: refactor core start based on hardware group
  wifi: ath12k: move struct ath12k_hw from per device to group
  wifi: ath12k: send QMI host capability after device group is ready
  wifi: ath12k: introduce mlo_capable flag for device group

 drivers/net/wireless/ath/ath12k/core.c | 449 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h |  88 +++--
 drivers/net/wireless/ath/ath12k/dp.c   |  19 +-
 drivers/net/wireless/ath/ath12k/dp.h   |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c  |  97 ++++--
 drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
 drivers/net/wireless/ath/ath12k/pci.c  |   1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 123 +++++--
 drivers/net/wireless/ath/ath12k/qmi.h  |  20 ++
 9 files changed, 658 insertions(+), 150 deletions(-)


base-commit: 3b2ab397d31f926523f2781d7f0a14a387415bf4
-- 
2.39.5


