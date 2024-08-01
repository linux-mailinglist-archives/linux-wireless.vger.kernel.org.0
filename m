Return-Path: <linux-wireless+bounces-10783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A8943D24
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C01B1C20C27
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766051AF59A;
	Thu,  1 Aug 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx1Ldlp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD81AF597;
	Thu,  1 Aug 2024 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471811; cv=none; b=RiKCHza7ecpi0zkhsZ466smp/uP1k3Flbzm0YtVUFTbWxSkZFoWCeGcjKRyLyqtV181pgtW0LGs2Jujm/4oP2lYF0wdFrc249InuIE7AHdZ1R3uhUBYD1+WFscrprw23fuLN8AxqPh7ho9ZqtPRVr0wLsWHIHvsbfpYNlMU84+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471811; c=relaxed/simple;
	bh=gCtdOBVdkeOxjKIgW/YqDd1m0sYcjNkmBDF0L4l7fPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq2VHVzQIowkeORO5pmKSWI+vTfsTdPhG7Ssg+FNJy4PAEa8x7x2wiWszeR4uqfi2cefEGDpVHaJeScAm7vVHWyBV8BLAP+JrWXrmyFqrT1eCKS7e/on4jvbNeDTyN9tcmDvnS9+E4e3KkHegYV//rhY0hndL+WGSa69wJvZjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx1Ldlp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4324C116B1;
	Thu,  1 Aug 2024 00:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471810;
	bh=gCtdOBVdkeOxjKIgW/YqDd1m0sYcjNkmBDF0L4l7fPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yx1Ldlp690nCJY1vFhQzxuaCvlnuc+f2C2qqywmIxkIB7fEjRQEjNz5/Qwcto3DBH
	 w1kO5jY82vAlXNS4+v3JRmJUpssDfpFnzguSTV1AXo5VE2TbJO6KSpf9RzryNsVwCp
	 ri9Yx/E8KeP1kl5pFC0WdAiI6tSC76vBqVWBsI9eEKE8/JerYiW6/elNkLymMXhNiN
	 PAZz1nWErbETEk5rzhN1n9EPHcWAcuYs+So+voOQJOhUMt9PY+E9xGCKu8aFQQf/TN
	 Yyii48cVrj4UlIzgh6vkE6lX7EHXgjsDIO+2Tlsq5th05lYinsppWDU/DcqzBGNZCO
	 NrBDF/vUwM4Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 28/83] wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
Date: Wed, 31 Jul 2024 20:17:43 -0400
Message-ID: <20240801002107.3934037-28-sashal@kernel.org>
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

[ Upstream commit bb0b0a6b96e6de854cb1e349e17bd0e8bf421a59 ]

smatch flagged the following issue:

drivers/net/wireless/ath/ath12k/qmi.c:2619 ath12k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.

The reality is that 'ret' is initialized in every path through
ath12k_qmi_load_file_target_mem() except one, the case where the input
'len' is 0, and hence the "while (remaining)" loop is never entered.
But to make sure this case is also handled, add an initializer to the
declaration of 'ret'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240504-qmi_load_file_target_mem-v1-1-069fc44c45eb@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index e68accbc837f4..a132600427718 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2308,7 +2308,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp;
 	struct qmi_txn txn = {};
 	const u8 *temp = data;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
-- 
2.43.0


