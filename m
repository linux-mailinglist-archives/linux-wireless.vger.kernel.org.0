Return-Path: <linux-wireless+bounces-24658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D3AED605
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680247A991A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2ED242930;
	Mon, 30 Jun 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="WGpDSjxV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2124168D;
	Mon, 30 Jun 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269532; cv=pass; b=XuKQdB87uQx1xda6isZ3o+bUYWiB+l+/6ZhtaWF2xjD2LF0vgCwawfkCGcDDdpGvs4rJMbVDglwImwEGF5duYGKXDb+GNuNvOI6TMEbTPziXAhm+eGtAl4e6A69ST0KPL4Tk0TTO2mZs5BSqGL18gNrQxa87Qh4/MfkoAcBZl3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269532; c=relaxed/simple;
	bh=j1xv/Qn5dLAoYoR8VHIw9acjzWzOm5sWBpC4Zyzq9Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G90YI6Mu8aefGv9plIXL0xitAaay1h9hlIS0xwMYbE3RH7uGLJwZSasFuUqf4AUB8sq2qaIDyUUzdPwJvIIzaOWI7C3E14a12ADeDzxRrkmRVF4o4F1GsaljbGYaFx15QCbzRLm6FlnmSc7jr+wIukwfIR/YTp9k1c5ai4pOViw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=WGpDSjxV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751269483; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XGxFZzOgso314U88svUkjhZdO0Qh39BYpQTUm1Scir/2cxiYNWh51lY56mEXskd13RkbZWc/LoToSFE/eSZFsqd0gfSC2lMEOyQqk5Uy4194TapE6XtNIFCfBP0WfwsIMojTzxaV8BIE9iWQ09y2xQ4PTHPR0LhVSjRepm1bB5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751269483; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uV8S0JK7uX8xYk9O0AqGs9CFpRRSYI7UmJ+uMI5PmQs=; 
	b=N2GdNEELh25VdHU/JfFHjVD5rRasxbVWOlxdgoHBobHssMjS9crleUumwwI+XwFM+83NRrxUPq7eKY4qcWTqhOzXNx4OwP1EFDSsNYrAeCMA+iJpJWUAmXWpxeZDedK6ucbB4DjL+lrPrV1BAPiWxk64JFTHvxLdKX+7xXb3ieY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751269483;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=uV8S0JK7uX8xYk9O0AqGs9CFpRRSYI7UmJ+uMI5PmQs=;
	b=WGpDSjxVGnc/HCN4ZIY3kCu34NKFqF6M+6tziUE4RPNau5eyoZXqQzfWcyaIn3C6
	IIqCgN8VE2zeqArJNvOKNuCJPW0GX5Vk4JhtPzmQqONPrg+MQNzOgUiYE6BXOu8zWn5
	suvL3ro4tTUU+qR1Sk1OYcYdUaqdyYyqf0E2eY0w=
Received: by mx.zohomail.com with SMTPS id 1751269481985439.6433346986413;
	Mon, 30 Jun 2025 00:44:41 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Alex Elder <elder@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	Sujeev Dias <sdias@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	John Crispin <john@phrozen.org>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Cc: kernel@collabora.com
Subject: [PATCH 3/3] bus: mhi: keep device context through suspend cycles
Date: Mon, 30 Jun 2025 12:43:30 +0500
Message-Id: <20250630074330.253867-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630074330.253867-1-usama.anjum@collabora.com>
References: <20250630074330.253867-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Don't deinitialize the device context while going into suspend or
hibernation cycles. Otherwise the resume may fail if at resume time, the
memory pressure is high and no dma memory is available.

Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/bus/mhi/host/init.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 2e0f18c939e68..8f56e73fdc42e 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -1133,9 +1133,11 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 
 	mutex_lock(&mhi_cntrl->pm_mutex);
 
-	ret = mhi_init_dev_ctxt(mhi_cntrl);
-	if (ret)
-		goto error_dev_ctxt;
+	if (!mhi_cntrl->mhi_ctxt) {
+		ret = mhi_init_dev_ctxt(mhi_cntrl);
+		if (ret)
+			goto error_dev_ctxt;
+	}
 
 	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
 	if (ret) {
@@ -1212,8 +1214,6 @@ void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
 {
 	mhi_cntrl->bhi = NULL;
 	mhi_cntrl->bhie = NULL;
-
-	__mhi_deinit_dev_ctxt(mhi_cntrl);
 }
 
 void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
@@ -1234,6 +1234,7 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
 	}
 
 	mhi_deinit_dev_ctxt(mhi_cntrl);
+	__mhi_deinit_dev_ctxt(mhi_cntrl);
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
 
-- 
2.39.5


