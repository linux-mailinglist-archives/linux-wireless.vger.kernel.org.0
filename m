Return-Path: <linux-wireless+bounces-12816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523CE976C71
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857BF1C236F6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAD1B982F;
	Thu, 12 Sep 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/iSK80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9719C554;
	Thu, 12 Sep 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152302; cv=none; b=n/TzPhiopRzROBn5lOFvEzZXsRhaFVL6kPcqcWnFwQSYe7sc9iEw3+6RMSkoa87n9q822FbHuSAgF0wgdYApauTmwwOVZhyDzTfTJb1ykxutnJ5CXdjA38otoKNm3T1EW7BTlBX2TuKypO7L+ByBP13xz0H37OAzLwiIt7hiv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152302; c=relaxed/simple;
	bh=OoCVxY+UyBsd7hQhwjtSIvbxU0H/X7QgOk7aNI2FNlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VtZWo68bCH76wIgLuM/S5cL+iTGgXmZ7ynQ6AfRcbCQHosvlr45VdnNE/gwxAtVvzZCNujlsi6itEAU5vM9R9IDHBFuuZleFCu9r8srfgGmemLJkmLZgZp/AoaLl1Lec6cZ6jZXb+F7HKjIiBVeaXolYu656OkOVXD8dzenlGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8/iSK80; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so12065895e9.0;
        Thu, 12 Sep 2024 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726152299; x=1726757099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DvJH9T+GARTJc/xZ32XfwCd/eQ9HgrjmZYLyaD3YQ0=;
        b=H8/iSK80S4svGRCQ04rFlLBIs54VBNwvZcn6RoGGbTuX74aE9NUFUJ6ZRtRUxIj3kU
         W08Xu3WaSgf8ECouhsHtJ755T0VlJdw7in0zsdocpLd0FuUzcVkM4PXe0sMsB+GLRu2u
         5PrhQY0ZvTnMAAdBi0qoC1oQDm4EdXPQ1UBa/BUdcGQIVhxJcDBApOSVTbgSVQjYn95J
         tRZBmI3C/WWvnGpO+IkPZNrOQq1ivYNpcPeW8+Sg0N0MQAhI0zrr6quEy5LaM3QlUWtq
         YSVhXCkluQYSI/Q5DKed+2U66htADYJpZZmBiVYX3urhe9FprY2JeSfV3+nwiRoPeNZv
         t5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152299; x=1726757099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DvJH9T+GARTJc/xZ32XfwCd/eQ9HgrjmZYLyaD3YQ0=;
        b=niTIcCCtbOhDJEGUEipBgz4Ja9b7qcEJ4UE93ZmLNh4PPqys+bkOPlXRlD6/+NTm6u
         Tccu9udSuUx53dG7Au3AZxIjKV92A6eQqNy9NvbxdIvt7xuXmGcfy8wv/JI4DDmK7MFL
         7kCjwQY303x3A5wcDKGO41Lxz+pmCCsmMz9frIr6QRRqf/5iuyMXsvM9aXI66+O6Gm+/
         IP+rrIwjj+gFNPjisRTJ4SbbACmC92Acgq1zXnwBb2Yy7jMWJoriumi7qQjv2c5OBuxp
         GuNXKrbp9Ops9VMkgBvaBy8XeP8QBTfgq17hBBnLqEPnTPCzAct5CluMJxzJlkKMcZcH
         tx2w==
X-Forwarded-Encrypted: i=1; AJvYcCUeCqbyHjQSeABPYJr2L0lXe8jOfzGyBPLissqNZ9MsG6lIX0XAPVI1NGrOpMjA59S8YYhuNp1TlHNucfc=@vger.kernel.org, AJvYcCXSH7J9p1RyQyZIOgrEAUWYCQJvVdJ021V9Ys4GgG7vrt+LDgawJ6kH2TPLZtvzXysidCuj7414Svl0yfqrN1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNdULpevDkRJsk0wWF0PRDoFi8LrtOdPJrC5iIa/mNIAU4KB/
	51Di1aD1tJS4ngt+svk2lCQHhAwPmjbzCvDjX9XJZbaGShAcl5QK
X-Google-Smtp-Source: AGHT+IE7/+KbvjyDtDww2TnU/fgs3cYgIf8LCVqZiRkkY4lpwUWmwI+I9g8/8f4mhbJiYx97aotJCw==
X-Received: by 2002:a05:600c:6b15:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-42cdb673849mr31883895e9.26.1726152298494;
        Thu, 12 Sep 2024 07:44:58 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7fcsm176962995e9.47.2024.09.12.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:44:57 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: mac80211: make read-only array svc_id static const
Date: Thu, 12 Sep 2024 15:44:56 +0100
Message-Id: <20240912144456.591494-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array svc_id on the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 2cd3ff9b0164..190439ad7f23 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7284,9 +7284,11 @@ static int ath12k_connect_pdev_htc_service(struct ath12k_base *ab,
 					   u32 pdev_idx)
 {
 	int status;
-	u32 svc_id[] = { ATH12K_HTC_SVC_ID_WMI_CONTROL,
-			 ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC1,
-			 ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC2 };
+	static const u32 svc_id[] = {
+		ATH12K_HTC_SVC_ID_WMI_CONTROL,
+		ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC1,
+		ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC2
+	};
 	struct ath12k_htc_svc_conn_req conn_req = {};
 	struct ath12k_htc_svc_conn_resp conn_resp = {};
 
-- 
2.39.2


