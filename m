Return-Path: <linux-wireless+bounces-109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7617FA62E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285F4280C34
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8237144;
	Mon, 27 Nov 2023 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6b4T+hO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4B36AE6;
	Mon, 27 Nov 2023 16:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24A8C433C8;
	Mon, 27 Nov 2023 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102027;
	bh=e5iEUwNhZxQK2+PMVpHmCD+V+8vXe6S06XyezMckbuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6b4T+hOQphUZTFR60s304kZ9LjITrseve1KcyTVdUyJFHyG/4COKaTT973yy5MOB
	 7l1aEO8IbuCKZeq6fka1qI8n2x+AtSYGz4+JtfsBcbnnYHcrAE0Q/FEcn7BlXZDKdZ
	 yPOqpM3dJ7rr/H299JsIz3c6q0hP5ClFAh59kbsEPKbMvh+sd0KfBFzrhzBtzK6XoX
	 C6sza0BM0DuGWjlfIzBQlJ8LotDvcbVG3o18Mnye/ygTMAvzpVlFFKTomKYYSPaos1
	 XTubT6b+H8hLsuG8QNsZlGWIrc3PkngGMZOdTPtewE+b9OPUia34M8k1sqCq9uMXO/
	 8qdSyMHmv1ycg==
From: Kalle Valo <kvalo@kernel.org>
To: mhi@lists.linux.dev
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 2/8] bus: mhi: host: add new interfaces to handle MHI channels directly
Date: Mon, 27 Nov 2023 18:20:16 +0200
Message-Id: <20231127162022.518834-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127162022.518834-1-kvalo@kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

When using mhi_power_down_no_destroy() MHI hosts need to unprepare MHI channels
by themselves.  Similarly, MHI stack will also not create new MHI device since
old devices were not destroyed, so MHI hosts need to prepare channels as well.
Hence add these two interfaces to make that possible.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/bus/mhi/host/main.c | 107 ++++++++++++++++++++++++++++++++++++
 include/linux/mhi.h         |  20 ++++++-
 2 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index d80975f4bba8..3f677fc628ad 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1669,6 +1669,58 @@ int mhi_prepare_for_transfer_autoqueue(struct mhi_device *mhi_dev)
 }
 EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
 
+static int ____mhi_prepare_for_transfer(struct device *dev, void *data)
+{
+	struct mhi_device *mhi_dev;
+	struct mhi_chan *ul_chan, *dl_chan;
+	enum mhi_ee_type ee = MHI_EE_MAX;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+
+	/* Only prepare virtual devices that are attached to bus */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	/* There are cases where there is no MHI client driver matches
+	 * this device, we are not allowed to do prepare for it.
+	 */
+	if (!mhi_dev->id)
+		return 0;
+
+	ul_chan = mhi_dev->ul_chan;
+	dl_chan = mhi_dev->dl_chan;
+
+	/*
+	 * If execution environment is specified, remove only those devices that
+	 * started in them based on ee_mask for the channels as we move on to a
+	 * different execution environment
+	 */
+	if (data)
+		ee = *(enum mhi_ee_type *)data;
+
+	if (ul_chan && ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
+		return 0;
+
+
+	if (dl_chan && ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
+		return 0;
+
+	if (dl_chan->pre_alloc)
+		return mhi_prepare_for_transfer_autoqueue(mhi_dev);
+	else
+		return mhi_prepare_for_transfer(mhi_dev);
+}
+
+int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl)
+{
+	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
+				     ____mhi_prepare_for_transfer);
+}
+EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer);
+
 void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
 {
 	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
@@ -1684,3 +1736,58 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
 	}
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
+
+static int ____mhi_unprepare_from_transfer(struct device *dev, void *data)
+{
+	struct mhi_device *mhi_dev;
+	struct mhi_chan *ul_chan, *dl_chan;
+	enum mhi_ee_type ee = MHI_EE_MAX;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+
+	/* Only unprepare virtual devices that are attached to bus */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	/* There are cases where there is no MHI client driver matches
+	 * this device, so it is not probed or prepared, no need to
+	 * do unprepare for it.
+	 */
+	if (!mhi_dev->id)
+		return 0;
+
+	ul_chan = mhi_dev->ul_chan;
+	dl_chan = mhi_dev->dl_chan;
+
+	/*
+	 * If execution environment is specified, remove only those devices that
+	 * started in them based on ee_mask for the channels as we move on to a
+	 * different execution environment
+	 */
+	if (data)
+		ee = *(enum mhi_ee_type *)data;
+
+	if (ul_chan) {
+		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
+			return 0;
+	}
+
+	if (dl_chan) {
+		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
+			return 0;
+	}
+
+	mhi_unprepare_from_transfer(mhi_dev);
+
+	return 0;
+}
+
+int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl)
+{
+	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
+				     ____mhi_unprepare_from_transfer);
+}
+EXPORT_SYMBOL_GPL(mhi_unprepare_all_from_transfer);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index ae092bc8b97e..dcf62a57056a 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -668,7 +668,7 @@ static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool gracefu
  * destroy struct devices. This is a variant for mhi_power_down() and is a
  * workaround to make it possible to use mhi_power_up() in a resume
  * handler. When using this variant the caller must also call
- * mhi_prepare_all_for_transfer_autoqueue() and
+ * mhi_prepare_all_for_transfer() and
  * mhi_unprepare_all_from_transfer().
  *
  * @mhi_cntrl: MHI controller
@@ -842,4 +842,22 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
  */
 bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
 
+/**
+ * mhi_prepare_all_for_transfer - if you are using
+ * mhi_power_down_no_destroy() variant this needs to be called after
+ * calling mhi_power_up().
+ *
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_unprepare_all_from_transfer - if you are using
+ * mhi_power_down_no_destroy() variant this function needs to be called
+ * before calling mhi_power_down_no_destroy().
+ *
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl);
+
 #endif /* _MHI_H_ */
-- 
2.39.2


