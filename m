Return-Path: <linux-wireless+bounces-15817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D609DFCE7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E64A161C71
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A681FA25D;
	Mon,  2 Dec 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN0mihKq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9C1FA160
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131166; cv=none; b=mn14uycTeoDkUmMn8DRzrzy3UOzh3KO7umx+naFPrm5Lwsb2tGT8bFxCJXrRTzgRzsGgzPZvp9s9Mh+v8AfjBwPFrNbvXsEQAkecPsy3a2tvc9aReFdb0Wmv+8gqLEu3zreBOplSA5yGcKVlNbUMfuzXb+NZ001RMNpTD26zrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131166; c=relaxed/simple;
	bh=cgmZMlBMXzhIUq6OF7CNNMXyvUa8aucr3LtehGena20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dv5/LQgwH/LW/XH0BIa58asC9PIydcPZjyYNXPsDjys6V4u4724HFXGHl9hB72AI6N8PaVNGthloMw8HAiGNYz6m75Aw0/MqK2a+SNg+Ts2umI6FcuBtzlO4VN+3pl37qxQG+YryJbLq0T+YqWXzi7Jrhiuv6LnKQ0Y3aWPdLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XN0mihKq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733131162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pJLX/DjPT3GcTzak124rApB1YA2PHiuhhYQM4Pn37+U=;
	b=XN0mihKq7bSxHWLwQeprd3DEsxxXrRwjAdEnYiskbiya7iyCwLHQl4bN8UX8fsyZ5xXfa0
	PF74lu5JBWQxf9FtNdihvgvETr/u7ktWYbOToYyZAqEeNhJzjDhT1bYHbqmt6Ggpi+oikx
	DxRN50oz6S+YJ7xV2GGMnSfEeGT9VLc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-rQ6mmeXWP1Wn6wQRCo4ZFQ-1; Mon,
 02 Dec 2024 04:19:17 -0500
X-MC-Unique: rQ6mmeXWP1Wn6wQRCo4ZFQ-1
X-Mimecast-MFC-AGG-ID: rQ6mmeXWP1Wn6wQRCo4ZFQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADA5A1955D8D;
	Mon,  2 Dec 2024 09:19:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.188])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F3151956089;
	Mon,  2 Dec 2024 09:19:10 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: quic_cjhuang@quicinc.com,
	jtornosm@redhat.com,
	Vladimir Benes <vbenes@redhat.com>
Subject: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Mon,  2 Dec 2024 10:18:30 +0100
Message-ID: <20241202091858.200773-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Since commit f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces"),
if dual stations are supported for a device, we can not configure more that
one AP and/or DFS cannot be enabled.

Enable this by creating a new parameter (ignore_support_dual_stations) to
ignore this feature if it is convenient. Default behavior is to support
dual stations if possible.

Reported-by: Vladimir Benes <vbenes@redhat.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index be67382c00f6..55c7a55d85ff 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -37,6 +37,12 @@ bool ath11k_ftm_mode;
 module_param_named(ftm_mode, ath11k_ftm_mode, bool, 0444);
 MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
 
+static bool ath11k_ignore_support_dual_stations;
+module_param_named(ignore_support_dual_stations,
+		   ath11k_ignore_support_dual_stations, bool, 0644);
+MODULE_PARM_DESC(ignore_support_dual_stations,
+		 "Ignore the support for dual stations to support other combinations");
+
 static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.hw_rev = ATH11K_HW_IPQ8074,
@@ -2162,6 +2168,9 @@ static int ath11k_init_hw_params(struct ath11k_base *ab)
 	}
 
 	ab->hw_params = *hw_params;
+	if (ab->hw_params.support_dual_stations &&
+	    ath11k_ignore_support_dual_stations)
+		ab->hw_params.support_dual_stations  = false;
 
 	ath11k_info(ab, "%s\n", ab->hw_params.name);
 
-- 
2.47.0


