Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C832E7D4F
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 01:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgLaAGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 19:06:53 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:47754 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgLaAGw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 19:06:52 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CE3D113C2B9;
        Wed, 30 Dec 2020 16:05:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CE3D113C2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609373132;
        bh=69xd9fncyK4BEHUUyMr7Pt9bTkPdpaT5zCUS4y2xqgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIPfNwLbEUwZ+9POJMgi9/B4GyOFIedH6XkT5LQ7W9nfO6Ff44Ym/J+SNQK/HvSd3
         auVeahA0VyngT45WBuOMeuC/uydlXlOv+7Mc9D+E6QkuRV08RoGfwun84OjLTILXUc
         +w0mxHPrLW6f7nlqogdLWWqpT1TB/Hm+eT0LgUNw=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     luca@coelho.fi, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 6/6] iwlwifi: Support configuring tx-agg limit.
Date:   Wed, 30 Dec 2020 16:05:23 -0800
Message-Id: <20201231000523.14963-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201231000523.14963-1-greearb@candelatech.com>
References: <20201231000523.14963-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This should affect ampdu, I think...not sure it works
as hoped.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index e8ce3a300857..070c8458e4cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -86,7 +86,7 @@ enum iwl_amsdu_size {
 	IWL_AMSDU_8K = 2,
 	IWL_AMSDU_12K = 3,
 	/* Add 2K at the end to avoid breaking current API */
-	IWL_AMSDU_2K = 4,
+	IWL_AMSDU_2K = 4, /* ax200 blows up if you set it to this */
 };
 
 enum iwl_uapsd_disable {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 8e7a3be7621a..a3fd791bab78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -791,6 +791,11 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	case IWL_AMSDU_DEF:
 		trans_cfg.rx_buf_size = rb_size_default;
 		break;
+	case IWL_AMSDU_2K:
+		/* ax200 blows up with this setting. */
+		if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+			trans_cfg.rx_buf_size = IWL_AMSDU_2K;
+		break;
 	case IWL_AMSDU_4K:
 		trans_cfg.rx_buf_size = IWL_AMSDU_4K;
 		break;
-- 
2.20.1

