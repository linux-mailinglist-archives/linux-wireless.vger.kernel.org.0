Return-Path: <linux-wireless+bounces-10791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8D943E34
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 03:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178B3B2ACD1
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805521B705F;
	Thu,  1 Aug 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COAoqR6n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B621B705B;
	Thu,  1 Aug 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472176; cv=none; b=r4PI3LSkEc8FqD+tLrGHRrBwYMHsqd5TIozISURYt2aHQi1Gmu+8lJ9sIdAKl1ORpYdvwNJZPdUMHsPqp8HPAQ4RmRFcVVJ9TC2RV55BBYWJppTwlwEzIYv9APSo6hSAN7KL0jKMsB9jasXgDaWbHlFHmCvH/J7zMOwJYiWbPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472176; c=relaxed/simple;
	bh=kNxJXrEdScUdF1a16Z9Du17I+OiwChLQGQxU4a1UgOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoJxcD3phd6tsgZD1PqPH3yfAHJvqIIPY9JDnNXqmVQcGmbhQNKpNwUypIPM2cH7q3sGSTHCGAFL417FEfRhAl99zov37Zx5lP7WjCg9+vPXs5Li/T0WCwtzYQ+I6aK4K9HM8NNcj7NpHnVrZteh29a0DERAwNePM7Itiotg2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COAoqR6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A77EC116B1;
	Thu,  1 Aug 2024 00:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472176;
	bh=kNxJXrEdScUdF1a16Z9Du17I+OiwChLQGQxU4a1UgOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COAoqR6nIOISuDojkXarqVGcfrJXn1rfUDXMvCSeJkthO5O6bZLrXGEdnYAYXyyzB
	 TESDyluBIkCXFh6Xlt2YjEzSozLvHyv5mPfhi4KmyoeoeYQj2PKeD60g6BkmxgMIVK
	 MMDL5ozaz3btHxibbXY06564+bjwJtC72WJQvLMAs8Mq4NIBgpCdo9VCgjkQHZATMx
	 4r9ztlc4QWD1hU9xyG7ZZQqIcWqcjMt3jJYaC/o7XHVKnY11CBGXYFPtx7l0RttcdB
	 uyq1abEqFArTbANOtq7iRdyT6k+DVyd9Kgkz9x8ggqtlGKTtYC1obtdy4HqVWaFlND
	 aQuwUy0rmQeWQ==
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
Subject: [PATCH AUTOSEL 6.1 21/61] wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()
Date: Wed, 31 Jul 2024 20:25:39 -0400
Message-ID: <20240801002803.3935985-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 01b02c03fa89c..764cd320c6c18 100644
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


