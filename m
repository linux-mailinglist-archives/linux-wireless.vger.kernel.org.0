Return-Path: <linux-wireless+bounces-15665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC959D7A80
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E3E28115D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 03:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFA01534F7;
	Mon, 25 Nov 2024 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="AqEXqkJH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122E38382;
	Mon, 25 Nov 2024 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732506719; cv=none; b=T5ClZnqPYCeAVvX69T6j+N6o92fxghA7u9t8shuyaWr+v8bjOqww3lreqd7n3UqFdwXYr4d00X19/YZIT+5NrbkKH0cZpgms1+FdYQlhfbZCsm6GxNarWSKDTId2AVrVtMZnoNtbCb4+Chs2SJRRqZr4eFMQd3cm1I2IaTIzGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732506719; c=relaxed/simple;
	bh=uKVKRmRDkN/eSoUbniCNPAitj2cpMMyzr4m9wHpkjkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fppbDxsy9f0dGZdfZXzzQz59GFwFjd5neTTULauKL1pkGxs4uBQAMUYHl8+BQy/LoWFuR46xEb1K4CREEclRhr7fFe76fm6ddsu2e28oV/EPw8VNmLOPwY0VluzQGXsvIajDBol+CzRXAM6L3605v2HHbD3x8Rkf9GYMgaDxyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=AqEXqkJH; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506710; bh=uKVKRmRDkN/eSoUbniCNPAitj2cpMMyzr4m9wHpkjkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqEXqkJHG/9LQ53Vq3mgTjeMfkWYogi1qAhApXi/U20Ul2/8jiXZyPjyLRHyQNXwy
	 XeGMlirfy/6uT5ceN+LP9gCQQ9YIgIMfOJImBdcoLbQjk0jTLcfOkOgLhuH+5mv/gL
	 uWwoH3qUyxMnD5vAxjl2hj+kpvRF1VgBeNvReHGA=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id C02871488DDC;
	Mon, 25 Nov 2024 04:51:50 +0100 (CET)
From: Mihai Moldovan <ionic@ionic.de>
To: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC] [PATCH v2 13/13] wifi: ath12k: bind to QRTR endpoint ID in ath12k_qmi_init_service
Date: Mon, 25 Nov 2024 04:50:28 +0100
Message-ID: <b5f7ea340f8b03bec6916f9c1bf8a970932ebe14.1732506261.git.ionic@ionic.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732506261.git.ionic@ionic.de>
References: <cover.1732506261.git.ionic@ionic.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If possible, fetch the QRTR endpoint ID in ath12k_qmi_init_service, just
before calling qmi_handle_init, and make it available in the qmi_handle.

qmi_helpers will then automatically bind to this endpoint for us.

This finally allows using multiple ath12k-based cards with the same QRTR
node/port combination to work simultanenous (and, for that matter, at
all), including combinations of ath11k-based and ath12k-based cards.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
---
 drivers/net/wireless/ath/ath12k/qmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index d2d9d03c7a28..a96bad490b10 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -9,8 +9,10 @@
 #include "qmi.h"
 #include "core.h"
 #include "debug.h"
+#include "hif.h"
 #include <linux/of.h>
 #include <linux/firmware.h>
+#include <net/sock.h>
 
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
@@ -3371,6 +3373,13 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	ab->qmi.ab = ab;
 
 	ab->qmi.target_mem_mode = ATH12K_QMI_TARGET_MEM_MODE_DEFAULT;
+
+	ret = ath12k_hif_set_qrtr_endpoint_id(ab);
+	if (ret) {
+		ath12k_warn(ab, "failed to set QRTR endpoint ID: %d\n", ret);
+		ath12k_warn(ab, "only one device per system will be supported\n");
+	}
+
 	ret = qmi_handle_init(&ab->qmi.handle, ATH12K_QMI_RESP_LEN_MAX,
 			      &ath12k_qmi_ops, ath12k_qmi_msg_handlers);
 	if (ret < 0) {
-- 
2.45.2


