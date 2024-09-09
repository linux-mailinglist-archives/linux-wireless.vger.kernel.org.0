Return-Path: <linux-wireless+bounces-12656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21D897157B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C89280EFC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415A1B2EFA;
	Mon,  9 Sep 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs4Y4l7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00814A0A7;
	Mon,  9 Sep 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878343; cv=none; b=DegffEopqvtzFs3GxAH7QHL1yAoZl/2ckneR9RFUJ30li3BOXvXL4ja+rAlZiU51WIklcgJ6cNjvUM+25C9aTJkEBpBiriLMOxPUk9Nk92zHfkcmP5hERLVPnncf2BMw/h4dSmIJxx4mPoYeKCzTvdJmpd24edpZoMsZM9+bagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878343; c=relaxed/simple;
	bh=3qGW/jJ/a46v1rtkfPaHnzDyLEQV+/5lVmsWFmM6csM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r5PlU60M+cIIK7/caGcinD2GTzHTSh3RQhJiSSwYycEkK0+m5D5jb8DiNmN3lH7EhZ60jF5q26hFKIQVqIyo+C0fb6+ryCMnHfuwSFCzSrvxNnSpRNqm7xXg2YvycHuOql7iArCHasBa0aRI4000QkOJ6obEd/LgZQv87+th+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs4Y4l7E; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd967d8234so2659117a12.2;
        Mon, 09 Sep 2024 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878341; x=1726483141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ornEzSeXHPiB1e3E0cRa8rt+d/rG1qSEbEsiaLiH85E=;
        b=Gs4Y4l7E6vOrxQW0Fiw3yG+IlWqLbql//Q9UnwJ0ba+S4JeHRCyvI4Be2RnMHwFjDB
         7oxeYvieycQ9g7zrP1oFpCd8R2dSwUF1DtoDUurgxP3vUhdZumdfejSqQUvGhq/7C/6n
         wXpJ9tk93Qj12LiMLw4QBtGxxB5E3Eog9T8PYIIGtBA73t1bJzANvYCi912QDRhjzwzX
         1DWlQLeEbFlAyFk5DxK7x/RfLbs13bbaR5Df8W9RsH0KZw58oUR2QsY0BC7U4hQAUQYv
         YkQ86akzakr+kHzeLOiQqeFDDSKG7muXBfy+8dr+k5VgEGnrNwuVy6jWEVjnbRtyIjh7
         Bn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878341; x=1726483141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ornEzSeXHPiB1e3E0cRa8rt+d/rG1qSEbEsiaLiH85E=;
        b=VKRIydaZQ1PUswZZKvaSqbrFSb2HmGuPYVMT5vojjx8qWy9aD4YYQaRIbtmWH6AkxI
         SiZqqcldzGOYSI17WIeMoElhhyo4N11DiqSxy2YO3tDo14htOjlDEDeUVJ4qKR2omG0m
         9VQLDFTqkE2o+oME5fp766oi73r9c5TZqI4TXN5nqavjTzasCYReEUwrdqoBTotNOwYp
         cZj2/pkW+ORp4eUPWium6IK1JTsmwMyDun3HgEuOFY/rNao5dFvcppO5Fyo6QdeAFlGR
         AQbYjS9hNqOh9aDWym0TH+ix5w7+5Phbo71txNMiyMLcsCyUekJ7FkO3MdXLkBWWm1U+
         K5rA==
X-Forwarded-Encrypted: i=1; AJvYcCV6yYHFYNL5RzbzKGJwc4sy6aQ5IWydLi7r0apHLWsF9eQ4d2v8jIbsHdCjd/udebynRYT3cfauor0WcuA=@vger.kernel.org, AJvYcCVTFYFJO8trJVhmsz2jsipqFsn+rZfNCecL49hDc3JhbV18I33A0RVUwP99KeWOeN5fwB11dyKzaVHeaVKhdKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywouu2w1ZR1hYqefLWGQtPv0+roJBmR98jTR7Z2bXISfuhVbK/0
	SRrbKYADlPj5zUo9D95mDJ5yh/cTYKcn5pxEdFVzCY/dNTbxLRQR
X-Google-Smtp-Source: AGHT+IGN3mrXN+JnRCWPu7dvRrdL7oJXnPc28vxzrFU+vWmKgcjFXynVQCCNmDILg/lBM50zGexwpw==
X-Received: by 2002:a17:90b:2d92:b0:2d3:b438:725f with SMTP id 98e67ed59e1d1-2db4211cacfmr2119732a91.24.1725878341248;
        Mon, 09 Sep 2024 03:39:01 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04987403sm4151891a91.48.2024.09.09.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:39:00 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: toke@toke.dk,
	kvalo@kernel.org
Cc: Sujith.Manoharan@atheros.com,
	senthilkumar@atheros.com,
	vasanth@atheros.com,
	linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
Date: Mon,  9 Sep 2024 19:38:55 +0900
Message-Id: <20240909103855.68006-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found the following bug in my fuzzer:

  UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
  index 255 is out of range for type 'htc_endpoint [22]'
  CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Workqueue: events request_firmware_work_func
  Call Trace:
   <TASK>
   dump_stack_lvl+0x180/0x1b0
   __ubsan_handle_out_of_bounds+0xd4/0x130
   htc_issue_send.constprop.0+0x20c/0x230
   ? _raw_spin_unlock_irqrestore+0x3c/0x70
   ath9k_wmi_cmd+0x41d/0x610
   ? mark_held_locks+0x9f/0xe0
   ...

Since this bug has been confirmed to be caused by insufficient verification 
of conn_rsp_epid, I think it would be appropriate to add a range check for 
conn_rsp_epid to htc_connect_service() to prevent the bug from occurring.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..b5257b2b4aa5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -294,6 +294,9 @@ int htc_connect_service(struct htc_target *target,
 		return -ETIMEDOUT;
 	}
 
+	if (target->conn_rsp_epid < 0 || target->conn_rsp_epid >= ENDPOINT_MAX)
+		return -EINVAL;
+
 	*conn_rsp_epid = target->conn_rsp_epid;
 	return 0;
 err:
--

