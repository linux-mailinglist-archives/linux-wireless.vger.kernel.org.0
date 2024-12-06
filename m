Return-Path: <linux-wireless+bounces-15957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E99E67FE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 08:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE571882F5B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051641B87F6;
	Fri,  6 Dec 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFIkdjZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFE193416;
	Fri,  6 Dec 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470550; cv=none; b=fvZXZGDFtENuKOXlSdR3XzT1kn92S44fBZzHayAxDIWof1S8l3A8PAUOlPeMzWePCQoMhK0kihpuSdIWGfDYURnoRiaxOQ+AE7MeMXrKpHFOCAP/kGOd5uketg40W65EOzw+XcBCtP7ANRRGYg4UuyQxgdI6MhwS3kmas/L5jak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470550; c=relaxed/simple;
	bh=uoBVnc/X3iISs39icolnHNEdtqyPvFkWR6P0eYgohZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NmjExvuZQAXfkqL0u87P73GVtIneldbO0LXsqTM2cZHNz5GusVBpelEXDZcgkIwgXMRD5zjhuajy8iUzV/38JCYc6VXmrtfZ1aP4K5dkkdbmmjdBdQUsVOwaUdTeR5jLVC7MAKRDTLUAUvv6FdfQod+DzRmnBbUQr5ZPX8Sb8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFIkdjZE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd23d9160dso720168a12.2;
        Thu, 05 Dec 2024 23:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733470549; x=1734075349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUVAK9sW01x7/UJNB//zngqTlDnV1jFf5ZhFyhScFnc=;
        b=YFIkdjZEXR4ccuwCG1anwmZpNJ6Xs8wrKPVle+T4KGCKce6S42dBUI81iWQPyI4F1A
         EYJE9ykWDAtdutAec8EViNHLaMzh5TmTiZKF5o5VroIK1ppsfsUh9PlQIgL3J0cxB8wX
         hL0sjBZBPTupJ2lgGekjEuYD+uZyG7uFxy5Hs8+iwtfjVbMx0un92oHroOyr9GYx+Mqb
         54shUIWptAXXXvV9ZOZJHU6Hf3Mgu+ZSOy3WuW+G3ukyr8R/Plz9awxDrqn1rHCRuWMH
         kPD6vbVo9a+LrOSdgrwzarm9JckRTxceeQJ25bBVXm0BhLEc49pGItDVc+8IrQy8icfS
         WttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733470549; x=1734075349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUVAK9sW01x7/UJNB//zngqTlDnV1jFf5ZhFyhScFnc=;
        b=B3DJt7/ZU+MJHXSYlC3BrruF4Bs9QVPCIxQjFYyNDt8iJXCkF90hZxENKv06QorfOD
         oZC4u8X4LIRN5BZ+cNOuPddrGbUksK/XZovARZJ35Es1vrbJvrqsmOQozx4/J5EgFVVk
         OpU2S758OiEUkgzxIRY6VI5+AfFDLWVYgNc5UqX+4lgMOB2gc0rSkp0k65LwXfsvB+KT
         XyRmB7H4YZmXLQss3mSgfeWqYFRb7cohGAXBFVldoa461EFvp8vpuxyID6aGLSsadJ95
         QqbHgWzVPm+msrdsAJqNxYYthRAeg4iPwCUb1DHwJuqXcLSXhVjrxxREAzF6YDejPgVr
         SUgw==
X-Forwarded-Encrypted: i=1; AJvYcCUel1QPcpR8S0VrsjgU3I2Kr5HEH8uN9LaDODYzKMvzvIKI6986F38MO3ufBf8biDQsUd31DWg1jbeK2Rws6v8=@vger.kernel.org, AJvYcCX53YH4skwIufyAG/eNV1ccyKExxnOHuDw8BV+uXfZ8acX4FDwQDvqpQ8GdBbkMHuNzrQ0HPArt9v/5WV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqSZcbrPBhvwCtbcUw6oXEF0oc0CyFQXSc6AsAm1uO3NgrDeB
	sfrFz3ENSnUrhlGQ3edQCyRxJDFvuao3YiD1EOTYf22m7iW0d1iD
X-Gm-Gg: ASbGncvCk56nP+eyUN8FWXHza6SZ2oeKLF3/jNuJ6jMTxY5+O/nAa5LCsRqQWYe911e
	6g0sDQxpA4m0uBqhJLjyAr7PPujcinoYTz0tg8/LwQy7nyiAglLpG1jWOA5oc2VNNrSPhiOwvg4
	T/W1sfExEPdq+eYX9eVf8pMDiAy1hboMxssPSXCz9XaoWwEwwoq9gpeigBluCCMi13iBE+o2aQ1
	fFtyn96VkqQ56Gz0GV+axrfqSqDXzH1aTB5urHBD5HcPjPEQIUbS3Y=
X-Google-Smtp-Source: AGHT+IHHKMowzfRZqo/yrxckrktsXFddOpWRgdDwk2tLcCRDBXvPAQ1jymmDN6Mz8n0W8ujCfq1Rgg==
X-Received: by 2002:a05:6a20:7f99:b0:1e0:bedf:5902 with SMTP id adf61e73a8af0-1e1870ad3acmr3032805637.6.1733470548723;
        Thu, 05 Dec 2024 23:35:48 -0800 (PST)
Received: from HOME-PC ([223.185.130.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2ca671asm2363763b3a.153.2024.12.05.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 23:35:48 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: kvalo@kernel.org,
	ath12k@lists.infradead.org
Cc: jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH wireless-next] wifi: ath12k: Fix out-of-bounds read
Date: Fri,  6 Dec 2024 13:05:42 +0530
Message-Id: <20241206073542.315095-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses the Out-of-bounds read issue detected by
Coverity (CID 1602214). The function ath12k_mac_vdev_create() accesses
the vif->link_conf array using link_id, which is derived from
arvif->link_id. In cases where arvif->link_id equals 15, the index
exceeds the bounds of the array, which contains only 15 elements.This
results in an out-of-bounds read.

This issue occurs in the following branch of the code:

    if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
        link_id = ffs(vif->valid_links) - 1;
    else
        link_id = arvif->link_id;

When arvif->link_id equals 15 and the else branch is taken, link_id is
set to 15.

This patch adds a bounds check to ensure that link_id does not exceed
the valid range of the vif->link_conf array. If the check fails, a
warning is logged, and the function returns an error code (-EINVAL).

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 129607ac6c1a..c19b10e66f4a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7725,6 +7725,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	else
 		link_id = arvif->link_id;
 
+	if (link_id >= ARRAY_SIZE(vif->link_conf)) {
+		ath12k_warn(ar->ab, "link_id %u exceeds max valid links for vif %pM\n",
+			    link_id, vif->addr);
+		return -EINVAL;
+	}
+
 	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
 	if (!link_conf) {
 		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
-- 
2.34.1


