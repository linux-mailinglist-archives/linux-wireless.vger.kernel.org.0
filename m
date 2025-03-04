Return-Path: <linux-wireless+bounces-19761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9FCA4E1C2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D167D174519
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1657B207E09;
	Tue,  4 Mar 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLHWNa2Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43F78F2B;
	Tue,  4 Mar 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099335; cv=none; b=jTcHW2PCm8mv1Juri7cZ5GPRDYigGJQxksgIjEEeXnRyvMwcArB07jtk7/n+kteoop+86xfHL2xmvjgju2e54+hAv8W5oNmtpGbS7+EZpUua2kG5IYrlwAq6KuUUb4DYt8dBa78C+THH6cpDVIpdT0wvlGt+u+rWaTsUyxy6DMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099335; c=relaxed/simple;
	bh=s6xCfxNbJMyFt0m33T6necoKJrmHfnEKisGUWWK2sR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5leDASUyK9WgVNzkGw8OD0IbSsvJTIVZMfgFw5RnorrteXdAPYyuTXK+f+SIedJ5Ew6Q/hgtA45E5LleisJMM1lbxSAHNuTt2+keFE82EL242Sk0StzzTuKVUzSKKRSkFxZcchJ4ytM1n2AKsyEmu+ZEczqH/XQFF90LtYHXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLHWNa2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C921C4CEEC;
	Tue,  4 Mar 2025 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099334;
	bh=s6xCfxNbJMyFt0m33T6necoKJrmHfnEKisGUWWK2sR0=;
	h=From:To:Cc:Subject:Date:From;
	b=KLHWNa2Y1q4LJqfW2vVuh+uwFFkqsftA/t2TIQumxXD3J8sNtEeKbUkFnTH6ky8RB
	 GzMNxjZZs+U3yrUUqJVb8nIpZNnnOWhum+9ZA5q5Xoj5q4JW8aeZVL02Sl1E5VNkfU
	 mRR/pNq9fzCXsZxUeiadvYMqqNfSCvpoppdxLndBLhKDW7jIYk77RXuFNMMILuynR8
	 RAnedkqGNON3MT2ghLy93bcinWxiNb0BQgwxRnRuVqUovZesSvLP+C4YK2ZA0RIGTT
	 j5fZnMov8SAl2IE8jutvlTrcUgMdzcbmI/OfQhn9u8WUYlv2WgIdZ9Dh8bc4QfBAmC
	 LuZgVfw579kBQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes@sipsolutions.net>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlegacy: avoid size increase
Date: Tue,  4 Mar 2025 15:42:07 +0100
Message-Id: <20250304144210.997531-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

My previous patch caused a slight code size increase when DEBUG_FS is disabled,
as Stanislaw Gruszka pointed out.

Fix this with an added IS_ENABLED() check.

Fixes: cf6b9ba172dd ("wifi: iwlegacy: don't warn for unused variables with DEBUG_FS=n")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Ideally this would be folded into my original fix. If that's not possible,
please apply on top.
---
 drivers/net/wireless/intel/iwlegacy/4965-rs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index f754fb979546..0e5130d1fccd 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2495,6 +2495,9 @@ il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
 	u8 valid_tx_ant;
 	u8 ant_sel_tx;
 
+	if (!IS_ENABLED(CONFIG_MAC80211_DEBUGFS))
+		return;
+
 	il = lq_sta->drv;
 	valid_tx_ant = il->hw_params.valid_tx_ant;
 	if (lq_sta->dbg_fixed_rate) {
-- 
2.39.5


