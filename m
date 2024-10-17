Return-Path: <linux-wireless+bounces-14141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE99A1BF7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 09:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A2B1C22499
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 07:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF01D0BBB;
	Thu, 17 Oct 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHPdm5Y5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AC1D0149
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151348; cv=none; b=idiB7EpfqNFTJaqaajl9e+PCawCkhDh/dIic14OJ3YpOWhPwW9VMIQpuVvri5iluGBPATn4xNJ2BtONtPQ1icJ7PcKGLYVbsadUYNULmXGIGRI5yxtkYjNwgtJVfT2iILswgfw2iF0RHJneRICYbwTaWZKAXq5FqTE7qypnvHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151348; c=relaxed/simple;
	bh=fRCJhGtgZMDr7r4S2J0gZoJavK2qD80Zh8Z67SYLGHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDM/Pt3XuKFvtVoTwkp540NnZQZQDWG6oR8BO0IQBMJ1zu4MtJw3S79q1yDGCaWMpf4A53yb3TWjOz/uK7EIzC+4jDcKz1YPoEvgOEOhK8T0dKQ1b72/ieLJFY2awjUH66nIfn9MUgFl+Tjx5nqDi2oQnWhtNa4BF8ezDLuGNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHPdm5Y5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729151346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4va4c2L7EgdgRCb+CXhLRRmcsU+QQfGi6+Ot1ojIP3o=;
	b=eHPdm5Y5wt6DnrYdOI4dONfEEhMldHuDilDMVO+JlSA51n8zvdrEorUZlNCoPlCaKVy+G0
	qBSR2cVJDqrmQc0skaLQnLGifptT8ad/cPBlNW7sQxGiHETmw/cmmUCZNK7U3krMARBV3V
	z68+4xKn80bhEkUULCnqyBXalNbjnt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-jZBC4SsGOW-NIaEQXlR-9w-1; Thu,
 17 Oct 2024 03:49:02 -0400
X-MC-Unique: jZBC4SsGOW-NIaEQXlR-9w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62A3019560A6;
	Thu, 17 Oct 2024 07:49:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.60.16.52])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45B1519560AD;
	Thu, 17 Oct 2024 07:48:57 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] wifi: ath12k: fix warning when unbinding
Date: Thu, 17 Oct 2024 09:48:15 +0200
Message-ID: <20241017074854.176765-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If there is an error during some initialization related to firmware,
the buffers dp->tx_ring[i].tx_status are released.
However this is released again when the device is unbinded (ath12k_pci),
and we get:
WARNING: CPU: 0 PID: 2098 at mm/slub.c:4689 free_large_kmalloc+0x4d/0x80
Call Trace:
free_large_kmalloc
ath12k_dp_free
ath12k_core_deinit
ath12k_pci_remove
...

The issue is always reproducible from a VM because the MSI addressing
initialization is failing.

In order to fix the issue, just set the buffers to NULL after releasing in
order to avoid the double free.

cc: stable@vger.kernel.org
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3:
  - Remove unnecessary check to not free if buffer is NULL.
  - Trim backtrace.
  - Fix typos.
v2: https://lore.kernel.org/linux-wireless/20241016123722.206899-1-jtornosm@redhat.com/
v1: https://lore.kernel.org/linux-wireless/20241010175102.207324-3-jtornosm@redhat.com/

 drivers/net/wireless/ath/ath12k/dp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 789d430e4455..15061782a2df 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1277,8 +1277,10 @@ void ath12k_dp_free(struct ath12k_base *ab)
 
 	ath12k_dp_rx_reo_cmd_list_cleanup(ab);
 
-	for (i = 0; i < ab->hw_params->max_tx_ring; i++)
+	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
 		kfree(dp->tx_ring[i].tx_status);
+		dp->tx_ring[i].tx_status = NULL;
+	}
 
 	ath12k_dp_rx_free(ab);
 	/* Deinit any SOC level resource */
-- 
2.47.0


