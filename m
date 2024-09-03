Return-Path: <linux-wireless+bounces-12388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE594969CC4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 14:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7893C1F24346
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4D1B12C9;
	Tue,  3 Sep 2024 12:02:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF81A42D6;
	Tue,  3 Sep 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364976; cv=none; b=pLMdLTh0cWIShK2r2cXbKCi1l41jIjC5gMyJ7yvfqNKQBbt1OnyohfhP6+OYZryijhcM6zQ5E8PyFm642g5BVSiN6j4TEqSIZSYm/stWRyBQygZfK0lAEvZeWZ1LXDzCTeus+8zSwIkz0XDyp0W6f9UbSvMnn0wzRNivNW9LklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364976; c=relaxed/simple;
	bh=CdkPZCW7AZCqwheqnCFrVjTPRPnUge6Ii1ZRfWJZeX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmeOgpOgA+zOC9UVa2rPJFjwPzEsP411IocHnbjoqvthxuJMjwRcrGgCrDxG5R8eWP9xjXxG5yZ5wKsz9Z+2FupvtJRtNsCdurT9WBkPbqyUwhh206Hrx47O/Giz5o+ACfGY98TaPAbHLLwZDAODKm9aO1tfeNdPAJCjElmzI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WykkV2vGQzyR09;
	Tue,  3 Sep 2024 20:01:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D06C01800A7;
	Tue,  3 Sep 2024 20:02:50 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 20:02:50 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <kvalo@kernel.org>, <yuehaibing@huawei.com>
CC: <libertas-dev@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] wifi: libertas: Cleanup unused declarations
Date: Tue, 3 Sep 2024 19:58:11 +0800
Message-ID: <20240903115811.958692-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

There is no caller and implementation in tree.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/marvell/libertas/cmd.h            | 5 -----
 drivers/net/wireless/marvell/libertas_tf/libertas_tf.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cmd.h b/drivers/net/wireless/marvell/libertas/cmd.h
index 3c193074662b..d7be232f5739 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.h
+++ b/drivers/net/wireless/marvell/libertas/cmd.h
@@ -116,11 +116,6 @@ int lbs_set_power_adapt_cfg(struct lbs_private *priv, int enable, int8_t p0,
 int lbs_set_tpc_cfg(struct lbs_private *priv, int enable, int8_t p0, int8_t p1,
 		int8_t p2, int usesnr);
 
-int lbs_set_data_rate(struct lbs_private *priv, u8 rate);
-
-int lbs_cmd_802_11_rate_adapt_rateset(struct lbs_private *priv,
-				      uint16_t cmd_action);
-
 int lbs_set_tx_power(struct lbs_private *priv, s16 dbm);
 
 int lbs_set_deep_sleep(struct lbs_private *priv, int deep_sleep);
diff --git a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
index 631b5da09f86..a5d4c09fb918 100644
--- a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
+++ b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
@@ -484,12 +484,9 @@ void lbtf_complete_command(struct lbtf_private *priv, struct cmd_ctrl_node *cmd,
 void lbtf_cmd_response_rx(struct lbtf_private *priv);
 
 /* main.c */
-struct chan_freq_power *lbtf_get_region_cfp_table(u8 region,
-	int *cfp_no);
 struct lbtf_private *lbtf_add_card(void *card, struct device *dmdev,
 				   const struct lbtf_ops *ops);
 int lbtf_remove_card(struct lbtf_private *priv);
-int lbtf_start_card(struct lbtf_private *priv);
 int lbtf_rx(struct lbtf_private *priv, struct sk_buff *skb);
 void lbtf_send_tx_feedback(struct lbtf_private *priv, u8 retrycnt, u8 fail);
 void lbtf_bcn_sent(struct lbtf_private *priv);
-- 
2.34.1


