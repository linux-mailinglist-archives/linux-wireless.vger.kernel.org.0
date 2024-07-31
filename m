Return-Path: <linux-wireless+bounces-10771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 233C8943B0B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C251E1F214CA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3B15746F;
	Thu,  1 Aug 2024 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5sQV981"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A2157467;
	Thu,  1 Aug 2024 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471165; cv=none; b=TOQBfoZsHK4jWYgwnHLA4ApptZYzdk0VOUpjqGWA9cVoBWHwrCymzCrRDTF8WKSu69sGLYTYs6yFofS/uloSt39137Zi910tgykOHClmywCyx3SUldv8gjVJx1oyGy37t4HuesPtdguggYVKflmu+YOIXjHrZZcfiLA24Ud6Vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471165; c=relaxed/simple;
	bh=mkbH1HDvlQU+3/cr6kcml5JYntra0ISK9U/XzN7Q2S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3rEJDEgN+UyyOwDWZGKWIIPBC/5jBVlK3rPkf1bOsXq5jfs5+iMQlteK+T/T2tk41MA9lv38XvtDfkHWO4NREAQxX2izhsq/+amWgtzjU2XmVHKWRmJxKmHuS2NDPwyh0tDdMepPEYzR0kJOrBXmTrUL5vLbfHSYmlgzVepOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5sQV981; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821B5C32786;
	Thu,  1 Aug 2024 00:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471165;
	bh=mkbH1HDvlQU+3/cr6kcml5JYntra0ISK9U/XzN7Q2S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5sQV981+9WaRmgMxTQQa3jLsaQDDfkWa2H6T33/TXNZQfa46c9ApLK/HO1ccB1r1
	 tOWJmPlZyD3gaQ62gaETnUdDFbfmKGXbCFUVxC7DHE/XnWu0wUcwNPGl4PqNeUy2QV
	 n40uOu/7tJs8Ne6Km1dK9GP9zEdx7itgnDKV1Ves2EDBWz8EKv7UWItBtBboCwyx3H
	 0yEpDn3ImhX0xXrLJg5VtPvFepR2yXMevvILZo/lzH9sBheDAO308FM8UsoNQrQoxU
	 8qt9QgIslXZtNqZpzRVCCw4JD1VCK+FN8ymKQcb6o+lR0L6TP+LO6w+sY/F3Umzy6y
	 S/4sE8L9/+5fg==
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
Subject: [PATCH AUTOSEL 6.10 038/121] wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
Date: Wed, 31 Jul 2024 19:59:36 -0400
Message-ID: <20240801000834.3930818-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 5484112859a66..6d1ebbba17d9b 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2538,7 +2538,7 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp = {};
 	struct qmi_txn txn;
 	const u8 *temp = data;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
-- 
2.43.0


