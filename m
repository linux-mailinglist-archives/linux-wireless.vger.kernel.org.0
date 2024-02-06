Return-Path: <linux-wireless+bounces-3219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D784B57F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 13:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0681C22E7A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DC3D54A;
	Tue,  6 Feb 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aVSbVj8a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9212B142
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223566; cv=none; b=QvSP7/wF+mkXIJqWNhkxCBxKjNwL8WgfucXY0WMtf484LPJXCFsoYDMmH3dJNeazH0FYTa0Qz/CWKVTnoESrPzpZiUAoZy5h7g0C9YC8EucmSCIGyZfHkCkvG5+IpdD9wVqrGbtmFB7p3VzfGTG0dr52JCSAwyX4TsXnStSPW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223566; c=relaxed/simple;
	bh=5lgwUMVIwlifMLILkjUkWV4OQdOrWI6zItry++4UVdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnlZj+kOC0BAiOszByNWaH0hQBknTUe0Yk6RREyLcNluhnSiJEYOeHKCk73W0/okzsBwM6Uq/hzKbJjjusBoX5HDV5jXupNjPGvTRMDDh4C5UgBb//fId9v3iLI7mx5GQ5HZrRkaJo65+lqZraN4xZDD8T6BjuXaEkPdV8M2Qhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aVSbVj8a; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=7a5o6aqgNM2NP4R+zkzFzSt6XT22rWZDJVYdik3SDuU=; t=1707223563; x=1708433163; 
	b=aVSbVj8aP1hQDYnosGrRzaDGPiZ0Tn1PXWaVTNt4pkVg7LAVG0XlrJAJ3595K+K9pgPVDGDpOY5
	WcAgrgO8wl9YINAoAe6fujLbnrYfhcPAbr0XvFXvQhjtCGihTOO2bqBy5fDLhJqdfUufAMJVTol4a
	53G+zVBZDvuQTdSJ/DwCpA6KYz5+2ShEBHC3+KgW9Pw80dlWNOXcuk47OtpZUFMJ9w+dv+nBpaoSO
	j7PWhSYy6KjU1q8kUAQK93VxPCdJ6lZE8nUzpUKxgE7MLBS8ZM3W4KLa7ldBdVdgg2DWbUNKjhwtI
	AUQqCHvw+lo4rIc9tTntdJQpKwcXt650umig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXKps-0000000Ehsl-0tOw;
	Tue, 06 Feb 2024 13:46:00 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: add missing kernel-doc for fast_tx_check
Date: Tue,  6 Feb 2024 13:45:55 +0100
Message-ID: <20240206134555.6354b0ac8610.Ib90d3651834c556b73697388f59bd396a1f6f9b0@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This was added earlier, add kernel-doc for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mesh.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index ad8469293d71..d913ce7ba72e 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  *             Javier Cardona <javier@cozybit.com>
  */
@@ -94,6 +94,7 @@ enum mesh_deferred_task_flags {
  * @is_root: the destination station of this path is a root node
  * @is_gate: the destination station of this path is a mesh gate
  * @path_change_count: the number of path changes to destination
+ * @fast_tx_check: timestamp of last fast-xmit enable attempt
  *
  *
  * The dst address is unique in the mesh path table. Since the mesh_path is
-- 
2.43.0


