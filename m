Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1418A473A5
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFPHdz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:33:55 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:59666 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfFPHdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:33:55 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499838"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:14 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 08/11] wil6210: publish max_msdu_size to FW on BCAST ring
Date:   Sun, 16 Jun 2019 10:26:04 +0300
Message-Id: <1560669967-23706-9-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set max_msdu_size in WMI_BCAST_DESC_RING_ADD_CMD to allow FW
to optimize the buffers allocation for bcast packets.

Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 298c918..cacafab 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -3835,6 +3835,7 @@ int wil_wmi_bcast_desc_ring_add(struct wil6210_vif *vif, int ring_id)
 			.ring_size = cpu_to_le16(ring->size),
 			.ring_id = ring_id,
 		},
+		.max_msdu_size = cpu_to_le16(wil_mtu2macbuf(mtu_max)),
 		.status_ring_id = wil->tx_sring_idx,
 		.encap_trans_type = WMI_VRING_ENC_TYPE_802_3,
 	};
-- 
1.9.1

