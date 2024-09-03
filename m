Return-Path: <linux-wireless+bounces-12409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B996A81B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07050281B89
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C161C9DC4;
	Tue,  3 Sep 2024 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="i700OaBU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-84.smtpout.orange.fr [80.12.242.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B11A3057;
	Tue,  3 Sep 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394249; cv=none; b=RLzr5kt1QY3GVyExIrvzWyNeCH4KICbo/yn1+NUyJUkOJ7o+PzZpYhfTpl+9nHCJ1edIvDudi8GbEQbkFplS+HUpKSeBDamcMfLPY+8+PBDmtK2x79bNcGK9KHivi7hdvPjnMWHZrtjvkPsUi3u9XuVJlMwTB1ouu7jKhDWyTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394249; c=relaxed/simple;
	bh=QqaaHpNpRoVdiDpL5M+17nve1cS60O+MVRVWdYynLzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6k9RIUXcSf73UKAcwWoZHIYFbxNiR9It7zifYseWCjmbrLeBu/6oUy4kBwqjsDwURVETdLnxcpIh+2DylrWxakEHpT1H2ls/jMP6eDgR+tsONc+w/RIeZ1fdqt436mdTL3F9XX+/8DhfBufv/07ohbVxZyd9hYqVM5C9ivsito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=i700OaBU; arc=none smtp.client-ip=80.12.242.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id lZrKsfDJa41DAlZrKsk3Um; Tue, 03 Sep 2024 22:10:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725394238;
	bh=HXvGRblJckpJgnRTWzq4VwyDlvBY3FPkUJEamxYaz6U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=i700OaBUGhNTb2q5K8bBJtWF8rCwthe/VF17hVK69t+bKm3SseOZE1MTqP5ecSrSI
	 xr8xl9g9WCKI1GbuCUBC0QLZupTOzB5svRYvwUcrR16KYub+nxvkK8i2AYcR3uBYC4
	 8ApDmCPWaA6nUDgjNHnqxdQ50Cq/vj8D0aDBk/VdxhUjY/G1L4lGSqwxjXgFA1bCWo
	 LjSdwT914Wmtg2q7FmAOVSLA3V1H8iBzjJ6VKG7kYm1mdQj5zJWP1zvt4/DpG3f0sh
	 cyGl7H6XjbI1r/8o720QmwnD4uA09mOvZPOwzfIl7PQeJnSsXzf891790xRfxSMYxt
	 8Ujjn7e7ThRPw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 03 Sep 2024 22:10:38 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: rsi: Remove an unused field in struct rsi_debugfs
Date: Tue,  3 Sep 2024 22:10:32 +0200
Message-ID: <15b0609d7b1569ec6c500a175caef4c9189f33e2.1725394207.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dfs_get_ops has apparently never been used since its introduction by
commit dad0d04fa7ba ("rsi: Add RS9113 wireless driver") in 2014-03.

More-over struct rsi_dbg_ops is not defined.

Remove the unused field from struct rsi_debugfs.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/wireless/rsi/rsi_debugfs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_debugfs.h b/drivers/net/wireless/rsi/rsi_debugfs.h
index a6a28640ad40..bbc1200dbb62 100644
--- a/drivers/net/wireless/rsi/rsi_debugfs.h
+++ b/drivers/net/wireless/rsi/rsi_debugfs.h
@@ -39,7 +39,6 @@ struct rsi_dbg_files {
 
 struct rsi_debugfs {
 	struct dentry *subdir;
-	struct rsi_dbg_ops *dfs_get_ops;
 	struct dentry *rsi_files[MAX_DEBUGFS_ENTRIES];
 };
 int rsi_init_dbgfs(struct rsi_hw *adapter);
-- 
2.46.0


