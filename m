Return-Path: <linux-wireless+bounces-10784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95E943D27
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DD9282A83
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64871C1E2F;
	Thu,  1 Aug 2024 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIlDZ7Vs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F391C1E2A;
	Thu,  1 Aug 2024 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471812; cv=none; b=ShXUoeEaAC/D90vBoFRinKwGHmQo5d1I4W0kYC4R2cwLH55c/zITHBjKE3YpWyNMzlLfYxdMtCc/nZbX3iQMMw2Hv84Zw2Fa3BWPJ0aoVkXFPzX04R5J36Y7pTdcAluT/0FdzUTZFqICz4ohdEGfNHgM4nY6Az6QQUlQM4x9oeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471812; c=relaxed/simple;
	bh=rwVkRkJQ2gD32Y5505C+ZI7WWjlcv5dKaKfOtE875AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLvqtOwMpezl68zQ/qY1zhEdYOFwn4rIIN7dKEyq+kNd8HMFM6LsAhF1LYrbGDbomGed6nj/jWWYXBAAAxCWYHYR+prRmmOWTNJUL21m6J2pf9ZO7shMCdkcrA3JvXOvHMv2QYUpAcZ8ofA8ORQzu2cBC619HOW/M6i4osM0FJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIlDZ7Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496DFC4AF0C;
	Thu,  1 Aug 2024 00:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471812;
	bh=rwVkRkJQ2gD32Y5505C+ZI7WWjlcv5dKaKfOtE875AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIlDZ7VsV8szPWzzXfnkuMCpn309/UjxrRJL/Zzf8IHMLys0hl4B5A5wwSbQwbhfd
	 Zs7P9PYjr2QQ8PV3vqXe0o8EllIo5Z0v7H8+C94CYJdfEBUguHkAldARNb1+m3VWyL
	 JSWDczgTDnu17UpAJn3Ycx8yvb3bloJ3AqukbFw321RwJaF4cXhH2x1d7vYY3jMnJA
	 JF1NW6H8kv7ZHOq/ialTLtKtAQB86M/xSiEgGWewiWqlvjEFWGfUZKAVLSSCc3GhIP
	 Cn5qAc5Q/7CxV+6rKW3Vll13e2M9XRLChHji2FgRCct2exDbyBvhmUwwMk8UfMuMfe
	 h4nQzrTT6VoWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 29/83] wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()
Date: Wed, 31 Jul 2024 20:17:44 -0400
Message-ID: <20240801002107.3934037-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

[ Upstream commit 199f149e97dc7be80e5eed4b232529c1d1aa8055 ]

smatch flagged the following issue:

drivers/net/wireless/ath/ath11k/qmi.c:2401 ath11k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.

The reality is that 'ret' is initialized in every path through
ath11k_qmi_load_file_target_mem() except one, the case where the input
'len' is 0, and hence the "while (remaining)" loop is never entered.
But to make sure this case is also handled, add an initializer to the
declaration of 'ret'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240504-qmi_load_file_target_mem-v1-2-069fc44c45eb@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 41fad03a3025c..e089df26bac9a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2293,7 +2293,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 	struct qmi_txn txn;
 	const u8 *temp = data;
 	void __iomem *bdf_addr = NULL;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
-- 
2.43.0


