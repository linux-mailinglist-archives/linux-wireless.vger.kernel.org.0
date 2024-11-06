Return-Path: <linux-wireless+bounces-14992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E09BF00E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2E1C22404
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F0201102;
	Wed,  6 Nov 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf8Dz24j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DB2010FF
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903180; cv=none; b=fdT+rOBT52N+vfjoU4NvtU9HXffPDrfJtXwDRS9gAK5v7QiUfwzlXFlxXwM2D8qpNZUwTeYlyI6bERyIkUmGY6W8nYk+X6XF0MVqvgwMuYC2+E7cLXZtgoM2G/7OxWc7wX1XA7u8/5vCsxl+j9U2DN9JUrOmdOe3IsMhkw8s4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903180; c=relaxed/simple;
	bh=D1YYTFPj2QFVAITbV4+lhQ1jReiar+IinCTKBPU40y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EjryfSudMhg1s7EiBVYI1rAMcnHBxEmxb1yA50tCw6H02t9ZVFZLC9LW4kaPMfzmyan2XuFpCLifh/9+g/Gytu9XfMVspxm0TbAVdw8Vv6Y2k+2NC4FFAnFQZpPv2kJdzQg/tX1s3O3nKtCz9oTj5komcpkpXEK23NcMn+aT9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf8Dz24j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC81C4CEC6;
	Wed,  6 Nov 2024 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903180;
	bh=D1YYTFPj2QFVAITbV4+lhQ1jReiar+IinCTKBPU40y0=;
	h=From:To:Cc:Subject:Date:From;
	b=pf8Dz24jqa2mQ+A4A69SSUiBR2yfhtK7JHq5beqdYbhjVQcr2UPSVQNYYX1qC/l57
	 ggO2/eAgEe7VN/EJRmGGnOpnrv5dVSl0X3jRHQaLXomoIblC081f0n0cxWn3NFvPK0
	 RF8EJ6rszWJKNIUtInNgqkNzcEg5qQ56sU25sS/B6bZkArT+nObMvpCL6guSNg83Zx
	 H4mGr7Kx0QMRP8ISoRowPphu0invI1VJymAQDd7VpIBA03z9bYY0KnOSwdl4myDV5K
	 Zpw8ZxGDdWd0gZi6CBFZo66TJjuRGvlzVMcYIO/wU8IqeIpkIw18gfJv4BMkrph6dd
	 47nRwx20qEyrQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] [0/8] wifi: ath12k: MLO support part 3
Date: Wed,  6 Nov 2024 16:26:09 +0200
Message-Id: <20241106142617.660901-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

We continue refactoring ath12k in preparation for supporting Multi-Link
Operation. For example, in this patchset we modify station state handling and
start to use more link level configuration.

Please review.

Rameshkumar Sundaram (2):
  wifi: ath12k: add reo queue lookup table for ML peers
  wifi: ath12k: modify chanctx iterators for MLO

Sriram R (6):
  wifi: ath12k: Add MLO station state change handling
  wifi: ath12k: support change_sta_links() mac80211 op
  wifi: ath12k: add primary link for data path operations
  wifi: ath12k: use arsta instead of sta
  wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf
  wifi: ath12k: Use mac80211 sta's link_sta instead of deflink

 drivers/net/wireless/ath/ath12k/core.h  |   4 +
 drivers/net/wireless/ath/ath12k/dp.c    |  44 +-
 drivers/net/wireless/ath/ath12k/dp.h    |   1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c |  58 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 993 ++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.h   |   1 +
 drivers/net/wireless/ath/ath12k/peer.c  | 117 ++-
 drivers/net/wireless/ath/ath12k/peer.h  |  11 +-
 drivers/net/wireless/ath/ath12k/wmi.c   |  16 +-
 9 files changed, 987 insertions(+), 258 deletions(-)


base-commit: d63fbff74ab1af1573c1dca20cfe1e876f8ffa62
-- 
2.39.5


