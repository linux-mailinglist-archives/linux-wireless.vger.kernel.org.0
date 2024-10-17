Return-Path: <linux-wireless+bounces-14139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D19A1BED
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 09:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E5285A9F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 07:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6D1CEE90;
	Thu, 17 Oct 2024 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aaj7RQJ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAA1CDFA3
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151228; cv=none; b=GrBCv4WVfxyouVxCskPQ7fD0BPOmf5LES9QiKGA680s9LWG4kQY+KQkkpuP0QEjX28uj7p38Yj4BsCoo4MNF9o22vqf13hHryDmw2WyvW8cHZMi+WT8b0F8umegr+uXweeSPNi4ki+T1rjPZqd/vhfX/6aNgNZCVVvZiRIFARwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151228; c=relaxed/simple;
	bh=BciklybZy7CwsodV1J+FHbLak2bcBG+EA9zVeiHIUZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=az3Jy3lfdWfBMF0XuHWsqiTIGlKTX9kbUzn//j4t8fMaI6Vchj4U10p2fl7Nrtp7PC52RrKEuKyKgp0ko21DRuPLMXc/hDy6NeNRTUz+ezDIeWh1ir5qLZMcfNjha8EVR2LhQKfT6xdVB8tBFwzyT/Y49+9JO3Y/uEWHdcCFdMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aaj7RQJ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729151226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QvbMmE2srGF798/Jy+9JBC3NRkx6cG+PNhzrzhRPIPw=;
	b=Aaj7RQJ5JtqtljqG20L8p1lH5QjhTqNhIWAnJk6DZW5xtPZUr2pPa2ZxwSKlt3dV40igTp
	6tdRr5c06n4q54Ap8W1ZJhUyGL9irg1tx7zq0koUXBqNu85pQTDsA4lk1nIeK/8X9AQJeT
	j2yTcDD0xWXHPj71VR8cBAYGHxs9+UM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-l1Ymol9FNQqdY6Tsc_4KNw-1; Thu,
 17 Oct 2024 03:47:02 -0400
X-MC-Unique: l1Ymol9FNQqdY6Tsc_4KNw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DEB419560A5;
	Thu, 17 Oct 2024 07:47:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.60.16.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C0F630001A3;
	Thu, 17 Oct 2024 07:46:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 09:46:31 +0200
Message-ID: <20241017074654.176678-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If there is an error during some initialization related to firmware,
the function ath12k_dp_cc_cleanup is called to release resources.
However this is released again when the device is unbinded (ath12k_pci),
and we get:
BUG: kernel NULL pointer dereference, address: 0000000000000020
at RIP: 0010:ath12k_dp_cc_cleanup.part.0+0xb6/0x500 [ath12k]
Call Trace:
ath12k_dp_cc_cleanup
ath12k_dp_free
ath12k_core_deinit
ath12k_pci_remove
...

The issue is always reproducible from a VM because the MSI addressing
initialization is failing.

In order to fix the issue, just set to NULL the released structure in
ath12k_dp_cc_cleanup at the end.

cc: stable@vger.kernel.org
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3:
  - Trim backtrace.
  - Fix typos.
v2: https://lore.kernel.org/linux-wireless/20241016123452.206671-1-jtornosm@redhat.com/
v1: https://lore.kernel.org/linux-wireless/20241010175102.207324-2-jtornosm@redhat.com/

 drivers/net/wireless/ath/ath12k/dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 61aa78d8bd8c..789d430e4455 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1241,6 +1241,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	}
 
 	kfree(dp->spt_info);
+	dp->spt_info = NULL;
 }
 
 static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
-- 
2.46.2


