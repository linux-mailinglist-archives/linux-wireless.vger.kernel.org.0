Return-Path: <linux-wireless+bounces-14817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413409B9426
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F3A2827E9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C02B1C0DD6;
	Fri,  1 Nov 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPpjGeG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1624778E
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474228; cv=none; b=SLlMkuzQtJEWNrxx6oaBgnXwJzHGkAs32mSR69qWTH+sFi1mZ2VwpfKW+DTkZ1KcnLqT/6BJAUZ0rMLrgzZpKX1nNm70Ij0I1Xesd65nFE+kE9tz9gn4a97EgfvDo08C1TpMukJZzDXgeh4rHrH1qTvxoUDqPgLxfPLHv7G/+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474228; c=relaxed/simple;
	bh=rqKZRh1kZWq0dO6E77nwpLrqssHmvDvFFYlqyHS8MoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Soz3R20v12aYHRJg9bG/uSmPhlCl/FGbGf/r7m2U9tGwZm+OP/oyb7LLQcSYPYHgOWCfPuNeGP4IG3G9/B+q+9CosRwKrwEsxqJbNkdEGIbLmEvDLOhXH7oGLAfKTRzaB7BDq66fKYWHKPw4Zwd3zxG8yihCXuTo+Z4Jk8thqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPpjGeG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0487C4CECD;
	Fri,  1 Nov 2024 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474227;
	bh=rqKZRh1kZWq0dO6E77nwpLrqssHmvDvFFYlqyHS8MoA=;
	h=From:To:Cc:Subject:Date:From;
	b=tPpjGeG5lqGIuXysu2lSZISFOBxuEiX7mn5u7WM7i9R/w+pKsSGgVFO0dItd1wkMV
	 Is90czFTBUVq0SZ3ZNXU+CHF4nmvVnoBjUmAPJTJFpNoYrkc9HL3kLY/7/DzHX4CiR
	 VHVF+913zLngMlpd6VDLrmyeJOsKqh1FwO4WCHmV3i0c/XzCoA6aawRvsZSJ0mA3p6
	 ryClx+6rWbTdyLpcQ1SotRya5rf3raHeJTOyh9GhpfYjtcDBFeuiyGRBL+lSr692AK
	 //NUHGfKKrbV6Lmm0rko2+z71N+PJTQMJfLgHuyMDdnEOmeLvRWsqDQlW3uY7FDsIa
	 xhFJfeIF0i7Hw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/8] wifi: ath12k: MLO support part 2
Date: Fri,  1 Nov 2024 17:16:57 +0200
Message-Id: <20241101151705.165987-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Here we continue to refactor mac.c to support multiple links and extend peer
assoc WMI command to support MLO.

Please review.

v2:

* patch 1: use err_vdev_del

* patch 2: ath12k_mac_mlo_get_vdev_args(): switch
wiphy_dereference()

* patch 2: use struct ath12k_wmi_mac_addr_params instead adding struct wmi_mac_addr

* patch 3: ath12k_mac_station_post_remove(): assign
ahsta->links_map before rcu_assign_pointer()

* patch 3: ath12k_mac_station_unauthorize(): fi* confusing comment about __sta_info_destroy_part2()

* patch 4: debugfs.c: copyright year

* patch 5: ath12k_peer_mlo_create(): remove parenthesis from the
  warning message

* patch 5: ATH12K_ML_PEER_ID_VALID: move to peer.h and rename to ATH12K_PEER_ML_ID_VALID

* patch 5: rename struct ath12k_peer::ml_peer_id to peer_id

* patch 5: use ath12k_peer_ml_*() naming style in peer.c

* patch 7: improve commit message a bit

* patch 7: struct wmi_peer_assoc_mlo_partner_info: add _params to name

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20241023133004.2253830-1-kvalo@kernel.org/

Kalle Valo (2):
  wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
  wifi: ath12k: introduce ath12k_hw_warn()

Sriram R (6):
  wifi: ath12k: MLO vdev bringup changes
  wifi: ath12k: Refactor sta state machine
  wifi: ath12k: Add helpers for multi link peer creation and deletion
  wifi: ath12k: add multi-link flag in peer create command
  wifi: ath12k: add helper to find multi-link station
  wifi: ath12k: Add MLO peer assoc command support

 drivers/net/wireless/ath/ath12k/core.h  |  25 ++
 drivers/net/wireless/ath/ath12k/debug.c |   6 +-
 drivers/net/wireless/ath/ath12k/debug.h |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 504 +++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/peer.c  | 115 ++++++
 drivers/net/wireless/ath/ath12k/peer.h  |  12 +
 drivers/net/wireless/ath/ath12k/wmi.c   | 191 ++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h   | 115 ++++++
 8 files changed, 848 insertions(+), 125 deletions(-)


base-commit: fa934bf3e0a825ee09f035c6580af513187d59a2
-- 
2.39.5


