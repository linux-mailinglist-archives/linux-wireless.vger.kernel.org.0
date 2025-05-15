Return-Path: <linux-wireless+bounces-23039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A269AB9247
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 00:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55B31BA680A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF5280A4B;
	Thu, 15 May 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGGaY4Dm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311C198823;
	Thu, 15 May 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747347931; cv=none; b=Xg15XnHoXU8iZtX/hG/cLFq2FrmS5pz0rns0JPfHPAClxlP2GPmkKnc9o8YtuByP6nTFUcCYVR8KiPJHLgHTSDbt6c03UiFsLgUWVYUYRUsCOdYKOqWQFZHFVIr799TrkyW3LpCJNhDvcpKDgzoRGxe9/PBUK2co5KyN5blCdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747347931; c=relaxed/simple;
	bh=6FSa4xzac07nTKUuiZ5eHBluODj2JOGzX6Wf+8IItKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSyxm1n/0JtLzKDdlNTQbSWZSuNx8ZmTf0Ez8YCr5wJ82Ug/ffwhBJSGUkLYVbaplpmXowbzzTFs9ilwIVu7v6dJIj5S2GiXa8NDxz11YkAOLMdJKIZZryZgmeIFyNMXrrtG+wtkZmokZr0JOZTWUObXazj67AuflWVs62uAk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGGaY4Dm; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52403e39a23so762610e0c.2;
        Thu, 15 May 2025 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747347928; x=1747952728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKoACcwZvqB4hjAADhBiXrdtznQVIY5lA2O4xWzuOU0=;
        b=SGGaY4Dmo16/+p+eDrwILWSAMvyFixfdTXOo0vk6y5TnjLfGtRA8QpWsFdXrdPkvOg
         g5g5o4ZUKWPWHPwP0NVgFG4UkRT0Jc5UkTU3uLyKsctC5MXkyoWbnQYICnj4xsUHgfKy
         xyG1Z9t0FMZOLxvu4nSfw146gx2iACBbmk+FoLzyV2To616Q/S4m7zCIUvwWz6TpWMQ6
         N7DHzpm3+x/B6fyFIBceLEykk+jcgF56euObJtZNGqtQvy2wO7ve+QhsytGLDoCRl0uq
         Q6pvdcisgAyENOoNB/kvobp+gUVoRGyxrLkjbxF3gpWQ35ozwIhhjqr1uf2fyn9w+O9j
         JTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747347928; x=1747952728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKoACcwZvqB4hjAADhBiXrdtznQVIY5lA2O4xWzuOU0=;
        b=mUdqWTS/GgbeWyPoYDEJEyIEMecWVJgeqOVgmyta2HmlC1euPzkxGmTNOUREl1shBN
         GvMvlxaM0772dTe1BH40h3I09IzDaukiWdi8nzbAqnTWHwOTwU7BwZJk1lBWVuw0JW6C
         fOtef4VfDqdIINvHnYxzTuV0DVhUQoTw3YJrHQuiPnLzeS941/3EtUdXILU3wFZp/KCf
         5SuwzjUPTQjtM+mFoPztqhh1ehsYXrxSZ/cUk+U0bbEsygAeZp4JMfqmoDVh5t5hku8q
         2ztl2UfXw9aUUgMTai3M01KFClYFY+g3QUplxxC303bMmWlMMSRSNrIyFGCc9jywG7f6
         3YjA==
X-Forwarded-Encrypted: i=1; AJvYcCUmLSNgjvKiOipG+AapKrE/PopcMK2ElRvHWfV3ZJgXyZmsjX60XFyBju2QbZbP7MGKcZWru9jhko6+WKsRuiQ=@vger.kernel.org, AJvYcCV4HJKtuYL9aS+YKAv8VKvq62FtfTPxN5ur8E1MWaKSp7DOVUXa1Nx34JKwssJEtOeR17tPxAwSigU0/eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfounRe81ng91Obxg2TrulPvCEfuZbdEjUxokztWkoKDgPRK5
	UbWN1iFZje1c5WNMS+mwiLapshNWaJjV+Q+BDjig4lmKSWaiZdYbfrtLjW8+fJUl
X-Gm-Gg: ASbGncv85ao/R02cVraH28J/2Da1A46/kvvtBBP3A3Yk8pNZQ9vTtILYm68ocouKoje
	Z6yN9UTMtm7MhV0tQcJoVpF4Tddl7oK73Qyn/vE85SwAvY6sy7U7aT3evVqFvH5PRLTR3hyCjjB
	n5v96fmbmgMug03Sizy9MpCUBaMhMTBAACtfhSqnlFjoIj95v20khiAHx9sCWIvIKeaRP8bWg1W
	ELVgwwugpEZFJwWnTmWNK1n+GaF6uGrE6ZuIA5V8+8v6uMqtfVLu8yN3iNTWYYsaOG2sahhpCJX
	Jio3qncxSpirQxZygCpW7pJ2EKLwgwuS/sHoskd2TOyka6HG8PQ+MTtmanxkwCiJHyUJe+a5rg8
	=
X-Google-Smtp-Source: AGHT+IH0Tx0zRc430b72Scg4pBsmQupJJ3uqemf4Bh0+E2crHEPLAfCrR3/q35Bega+vTcWuytGTlQ==
X-Received: by 2002:a05:6122:88c:b0:52a:cdd8:fc33 with SMTP id 71dfb90a1353d-52dba614e02mr2282226e0c.0.1747347928588;
        Thu, 15 May 2025 15:25:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba9408f5sm724417e0c.15.2025.05.15.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 15:25:28 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jjohnson@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: clean-up during wrong ath11k_crypto_mode
Date: Thu, 15 May 2025 19:22:48 -0300
Message-ID: <20250515222520.4922-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if ath11k_crypto_mode is invalid (not ATH11K_CRYPT_MODE_SW/ATH11K_CRYPT_MODE_HW),
ath11k_core_qmi_firmware_ready() will not undo some actions that was previously
started/configured. It's reasonable to undo things during this condition, fixing
the following smatch warning:

drivers/net/wireless/ath/ath11k/core.c:2166 ath11k_core_qmi_firmware_ready()
warn: missing unwind goto?

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Changelog:
v2: add smatch warn at commit msg
v1: https://lore.kernel.org/linux-wireless/20250515004258.87234-1-rodrigo.gobbi.7@gmail.com/
---
 drivers/net/wireless/ath/ath11k/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2e9f8a5e61e4..fd3017c444a4 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2163,7 +2163,9 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		break;
 	default:
 		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
-		return -EINVAL;
+		ret = -EINVAL;
+		ath11k_dp_free(ab);
+		goto err_firmware_stop;
 	}
 
 	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
-- 
2.49.0


