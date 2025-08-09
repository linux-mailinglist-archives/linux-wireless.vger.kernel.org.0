Return-Path: <linux-wireless+bounces-26230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A3B1F1FD
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Aug 2025 05:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189605861E9
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Aug 2025 03:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD6627703D;
	Sat,  9 Aug 2025 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E90cnf+v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FA1ADFE4;
	Sat,  9 Aug 2025 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754709322; cv=none; b=fBsZGguIbrg5ZZCYsNjg42yMcf5eMjBaNXZKoyK6ZKCYS/oDKfR0j/MBOHoYmCBTBFvceAqCbThdYrsm6nSzjgFzcUTcl5FJ7Z+R98A0Do8yTvcug3WT81NkuKHNMgfGBjMAivEL9XbQVCAYRZdH0gWxKi8REOFn2HvZOb97qRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754709322; c=relaxed/simple;
	bh=BZCnahdOzz0JjUUcOzlAmKtlk4BlFWU9nBcRAZVJw7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgnYys4KFnvtmpoLAvtTj0+1vzSMcaGYaJeRA+hzNLm5nZ070mkRr84HTGLD/4N+s7fNiN2rT5BFNyaEl/E9MwMwllEb4OqxTnpXKIScD8gRGgB1nDVO8wvJczIK+6stNou9Hnr7FkJjGKG8ZOv8E0QrlMJDBPjgEKE4bXxksLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E90cnf+v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23fd3fe0d81so25979885ad.3;
        Fri, 08 Aug 2025 20:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754709320; x=1755314120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46P9Qe+V3mlrJsYmvr/FTUH9c45AThc9QMz5HU6zoKA=;
        b=E90cnf+vGvPl9MIaEP49Kywf9lBC0ZIfljk76kdckYx5DnQn36SDwbG+VFRxllv1mB
         KXSVQfsErigUucR/EBy6NVeYqd4DdfWEYMltiyS7qLH7Hr9Uc2CnDfMElMdbNo6S+myj
         veytCIi/1xY3lc25wbDJPJgf17j7S3hjvzDKL3742ikZONmDwmlIwzS7uSBfFdgTlQKW
         gjUcQySCyLYFsOJgJ2JQo6R0F/Fs0a2VUINu4jIGYZsG0KJgmFhzQo8pNeGYdqJ9u464
         lMv/HrcGP9HleEPVIMmrkc4voPb7fe6Vz8DHoWGTuJ+sLsGEQzRHBuW6RfQz8hEZShW8
         2i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754709320; x=1755314120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46P9Qe+V3mlrJsYmvr/FTUH9c45AThc9QMz5HU6zoKA=;
        b=VyRGPfnlndwJFC4KuHssynVgWyGrXSQpHMCf03We8ZQUK8jf+K8V2kEVPXxJGSSrbk
         Mpt5MsrvdrMY7wse5pg5V3Klj5laKCdXKKTLbpkpIm3yF2yF5vykWgsFetdJGZMNrVc2
         kzA+Vnz+jAlZrzdRbW9PMnyhF2W3lrnNS6HNAk3XIUNZCqK5wBEp5de/0IQeuMtDrOsK
         Xs1gLyCvkrz0ALqKh32ZlCsjNJHIMCrI8wgbSxBbP5VTIvH0TimOgyrd1NHVKlX9wwEO
         ZXX/TPIt4O/TcEyTva9R+AzHB2M3IGHN6vTs2fQ2Fe1GZJf+wvRZeGSI6hRBiEklSE5J
         6Fcw==
X-Forwarded-Encrypted: i=1; AJvYcCVCO8TTbBRNZPeYFg3/xYu5jbVD4m5JuwodbRVF1APH9o8UMSWu1SJqibXjrcxxlyUQAEUpSg4qggINqyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4ZfYBtG6gNPTsK1MUGB8eLlkKWOQBQ/+bjziK9LkoOXe1grO
	BZaWIk3cTAljJh/CHYoNytwUXD03o+23Tdu4LcwJpfl2qZqFFfuHmBPjiy5rSA==
X-Gm-Gg: ASbGnctgsEQHxF8x3sjj/eUlfPH3imZLKFSVB0bV+YQnCMpZByznPziX1Bl+fUpp8TW
	7M8crq+YM7b/kQwhsIvchAWFp6OfB3aT9ivdTltrOcvD2X2PiZjBbpE3osCZVjser5QzjE55KPI
	P4Ap/xgjPJvUht+xUzNZvOWCyMJLmPWYpX5X75ZTx5245RDEMyzfv4DkhOJVJeGPNm3yBz2bAGx
	ll3qDCv+YsYBon1vJdtMVLqpd3rXLGR8mB1jY0rLzFEaVCQKEvHhYgKpLnN+qe+bn/rD2WZFMQU
	3TYp26XFpoQ+h84LbiLaicl/Vl0EcT0Jlw5WaGzBF7b28/dl3UCcKqAwcxTmvLra6WuHN4xbrDE
	EjoE=
X-Google-Smtp-Source: AGHT+IFeprYnDuXSMUyQMFUHnCT0gO21hf/Our67h1VwLYgFg/XReIWO4NavPTRMFt2wlcZJOH4kBQ==
X-Received: by 2002:a17:903:11c7:b0:240:80f:a4b6 with SMTP id d9443c01a7336-242c2070712mr78197865ad.4.1754709319578;
        Fri, 08 Aug 2025 20:15:19 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242460ffab3sm174741215ad.50.2025.08.08.20.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 20:15:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath10k: switch to of_get_mac_address
Date: Fri,  8 Aug 2025 20:15:17 -0700
Message-ID: <20250809031517.5535-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 9d5804662ce1f9bdde0a14c3c40940acbbf09538 , device_get_mac_address was
introduced as a generic way to get MAC addresses from anywhere.
Unfortunately since then, the landscape has changed and the OF version
is required for NVMEM support. The second problem is that with NVMEM
it's possible that it loads after ath10k. For that reason, check for
deferred errors and exit out of probe in such a case.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..76747eb0925b 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
+#include <linux/of_net.h>
 #include <linux/property.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
@@ -3456,7 +3457,9 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 		ath10k_debug_print_board_info(ar);
 	}
 
-	device_get_mac_address(ar->dev, ar->mac_addr);
+	ret = of_get_mac_address(ar->dev->of_node, ar->mac_addr);
+	if (ret == -EPROBE_DEFER)
+		goto err_free_firmware_files;
 
 	ret = ath10k_core_init_firmware_features(ar);
 	if (ret) {
-- 
2.50.1


