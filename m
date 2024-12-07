Return-Path: <linux-wireless+bounces-15994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A59E7EA2
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 08:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3495D1884CBB
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA177111;
	Sat,  7 Dec 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEhNaW9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977FD27E;
	Sat,  7 Dec 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733555616; cv=none; b=GIaDh4o+85T91a9dwCkuGCW4X320ErqxtLe7kO3MH5Epwczv2OXrR99W+UNzq9d44RoqT5ggFtbOYoVsRETfToFZSRopZn+laS7lqMd2QQU1HEGS34a842CokEIJLJzslEvVZvu6BCUbVkpCJP9gzaep4STlOqhgQGrzNO50DqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733555616; c=relaxed/simple;
	bh=dxQaZ3QETiXZOtB6uYm5sCLfYSZ7bD7bTFUm5favjio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KoVOU0pjWGkrOncDQAURITcbZUODzkit31DjPzY73QiOihiKZxcdPj7fFbPuRP2lHJBLu1o1XERMYPo9uQ99RxdnvG5jTZDU7p1N1n3AfW24KRVLErSlsvkYO1Z3gKUqsOR3RbAj8XfdjBw72Hkp1UzcSipM95GwdCVSsA47HXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEhNaW9E; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724f42c1c38so2534213b3a.1;
        Fri, 06 Dec 2024 23:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733555614; x=1734160414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDh4so1yjrmnXRNWBoE4vaLN6p43zggddIolQiXyMls=;
        b=AEhNaW9EuiQ2/55zTaLeLd1hvjFCCYnGi3DOKI6vZ1nl3/NH+6qLDYKrbHoH4VW8Vd
         RCOt9RbUnySfNb7vYCdRcMnWGJKYzNpQ/p6zypGGyXV7kFZ/9YA2jnpGpm47twbOKxOq
         HPaOP7elMPgOphy5ionAfnVlkSPy5tIIyONdSt30NzNYgPw1K2Wy9hZsWIezjprQ4LBt
         fznGIkmIDnhKD8UkGUr03ns+d3B6H5F/ykZFDcvTuZV/8nWUABwFug4ZVP4XWK9g0dUJ
         wkfpZF6i2WiU5Mj8z0m0ZoliAlDoO0jH2SnUiF3vvMuLBC6+1n+8sP6o2KsMRI/fXe3P
         NRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733555614; x=1734160414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDh4so1yjrmnXRNWBoE4vaLN6p43zggddIolQiXyMls=;
        b=GlN52k1IWi9l7TPyZGKdncQY5dSjVz0worDVnuN5YsOLKuarUUtWHUXy3qhD29TyCf
         oJZ9JFG/4BzxlVl2JLn3vDjo0iMW+SE6K6Hs0hynjrcQSnaEZ5A4ycBfYnCVtj8txEUM
         k5jYERLz4OwCuhAqx6FUXOEa4v/3t0MOOLIhuKHk7jiChlSzh5Xh8A4z2MLeOQnCvf3p
         a3DzhGGg2HY3jhpYNEI2EsvnfCk2X3HAChkMJgAn4UXrxCh0AvD7M8ioYs8pSTtuaD+B
         wmBPO7/oTPQ32i8DTTLIakKF5t6UFZig0B2u1qrMDVVndaSM/1sKSqip1gdFbP7o/3NZ
         xaXw==
X-Forwarded-Encrypted: i=1; AJvYcCXn/xOpqsrwygIeyS9Fbxprpf7+qJk3T29j0EVuh0zP0cR+/bcLkaFtn6hQJjBzz5pnixLe4Y04NLQIa1s=@vger.kernel.org, AJvYcCXrBS1DIE5umqWPduSPanTdCOY+crSrA6UBbAkRMDaVQpUyMJCFKeOuSetnMis6/wmt878BVBY98tx7QkgRxLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukEFYPcw5QejKze8O2QbQ9XRk36uOlg5DeOs/w5rgGCtfrbxv
	JT+lo9db07cowobANyai1GDr1Nu/2e3DtT2MidmtkYpRIxVXzYRRG98sgVoF
X-Gm-Gg: ASbGncvXUfCDo03RGodig3CytY2u/0U8Uuw2v1hem8JIFGFjz0GXNpRGryoUoo6DDBl
	ZBiVjiHq5A/0RfQf9uNXsAwKDbS9gnce0JpRTWAQzGofQOsdGT1cZ/pgB5zdW18EjY9SopnDhWE
	JNPMgss9n+9jzdsSrAN7FYVFVSbMxB2lNQA7ITYxS+Bv4ksW2zKF8+6vwD6mq8ODJ8p8Qa+RH0w
	ors6pSErpOvRp4Z/TrjWqfyTuBrf/526fWPPFcGuzoT1UljT7h1/MQ=
X-Google-Smtp-Source: AGHT+IHcxeD+MG11WHWR1knOlXO90l6SOht2f808Qj7jDLPyZTb4RWMfYlbEdp8v9XhDP/cfmP8X3A==
X-Received: by 2002:a05:6a00:b52:b0:71d:f2e3:a878 with SMTP id d2e1a72fcca58-725b80e1828mr9388605b3a.5.1733555614125;
        Fri, 06 Dec 2024 23:13:34 -0800 (PST)
Received: from HOME-PC ([223.185.130.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5abdsm3952436b3a.35.2024.12.06.23.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 23:13:33 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: kvalo@kernel.org,
	ath12k@lists.infradead.org
Cc: jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH v2 wireless-next] wifi: ath12k: Fix out-of-bounds read in ath12k_mac_vdev_create
Date: Sat,  7 Dec 2024 12:43:06 +0530
Message-Id: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bounds check to ath12k_mac_vdev_create() to prevent an out-of-bounds
read in the vif->link_conf array. The function uses link_id, derived from
arvif->link_id, to index the array. When link_id equals 15, the index
exceeds the bounds of the array, which contains only 15 elements.

This issue occurs in the following code branch:

    if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
        link_id = ffs(vif->valid_links) - 1;
    else
        link_id = arvif->link_id;

When the first condition in the if statement is true and the second
condition is false, it implies that arvif->link_id equals 15 and
the else branch is taken, where link_id is set to 15, causing an
out-of-bounds access when vif->link_conf array is read using link_id
as index.

Add a check to ensure that link_id does not exceed the valid range of the
vif->link_conf array. Log a warning and return -EINVAL if the check fails
to prevent undefined behavior.

Changelog:

v2:
	- Updated the commit message as per the reviewer's suggestions
	- Clarified the description of the bug in the commit message
	- Added Fixes and Closes tags with relevant information

Fixes: 90570ba4610 ("wifi: ath12k: do not return invalid link id for scan link")
Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602214

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


