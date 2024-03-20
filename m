Return-Path: <linux-wireless+bounces-4993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D988161A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B931C21315
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845A369E07;
	Wed, 20 Mar 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs85bH2/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5369DFF
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954420; cv=none; b=jj9VVu3359T1CAGnzJyduwk7l3UXhrJLeEawTsJqSBkXIt4ZXnzHcOlsWyVbrZ5S+3YgI+60nlD+WZef/UnzpeTXwF4JgVoSzTIXJ+w/ge5uNSb7OxuGDRRl377mMClvT1nc1yKdoLMGH/IbUDvNj5FxFjLKqRcOViY+5WzVRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954420; c=relaxed/simple;
	bh=DUxuvt+EOgdceiAGNNxvFz0FDIS7bKghTm0uubPaxq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gG9uyjb39urhL+JSNOakGXqV7LVr2eQr+JAvle4yC5IvHU97MsIOgpf4IibLzRBoYYIvoIGdVx43eNzp5A+6zf87AZbjxbyAFNLrOVXp2xhl8Gs7JiSKpisQxUyKBADc1/kQmxK0CqCP+qcvh1VX0Gt4wbCrjglxEHIC9beME7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs85bH2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A89C433C7;
	Wed, 20 Mar 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954419;
	bh=DUxuvt+EOgdceiAGNNxvFz0FDIS7bKghTm0uubPaxq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gs85bH2/3HzUT4wN6qYiX01bc/SOiLLPIaOLogA8NIMelZT3fmQgOFwbQ/PoBwwyU
	 6abUQ5Kg7X4MJvJ+PY0z+s0Eg8qaFN++se7180Ip8mCZ2dC2E7XlNu+RB9xq+d8kzl
	 gO/EL7vPGcycS+BXsOCTpdyZ8DOHD4VnX1hlD1xZkNPNz0SOhRA2Nn6j68iHqs5LY2
	 St+J2O3m/tWVpjgSbkLVw9qZX3QORgkLc/Si3dy4a4dCjXXJFSVld/FQbrMLKpKtZi
	 Bkfp9W84odVhmRGBjZE/mgHYJiqlhS/4HTB05amkAMO0WT9iJYgpy/Pm7Ry4ojCsOn
	 DyO6Yw+6D7Haw==
From: Kalle Valo <kvalo@kernel.org>
To: toke@toke.dk
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] wifi: ath9k: ath9k_set_moredata(): fix sparse warnings
Date: Wed, 20 Mar 2024 19:06:54 +0200
Message-Id: <20240320170656.3534265-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320170656.3534265-1-kvalo@kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Sparse warns:

drivers/net/wireless/ath/ath9k/xmit.c:1677:20: warning: incorrect type in initializer (different base types)
drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    expected unsigned short [usertype] mask
drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    got restricted __le16 [usertype]
drivers/net/wireless/ath/ath9k/xmit.c:1681:17: warning: restricted __le16 degrades to integer
drivers/net/wireless/ath/ath9k/xmit.c:1682:42: warning: restricted __le16 degrades to integer
drivers/net/wireless/ath/ath9k/xmit.c:1682:36: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    expected restricted __le16 [usertype] frame_control
drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    got int

Fix ath9k_set_moredata() to use __le16 with masks and use if statement instead
of multiply operator.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index d519b676a109..35aa47a9db90 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1674,8 +1674,14 @@ static void
 ath9k_set_moredata(struct ath_softc *sc, struct ath_buf *bf, bool val)
 {
 	struct ieee80211_hdr *hdr;
-	u16 mask = cpu_to_le16(IEEE80211_FCTL_MOREDATA);
-	u16 mask_val = mask * val;
+	__le16 mask, mask_val;
+
+	mask = cpu_to_le16(IEEE80211_FCTL_MOREDATA);
+
+	if (val)
+		mask_val = mask;
+	else
+		mask_val = 0;
 
 	hdr = (struct ieee80211_hdr *) bf->bf_mpdu->data;
 	if ((hdr->frame_control & mask) != mask_val) {
-- 
2.39.2


