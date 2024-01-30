Return-Path: <linux-wireless+bounces-2827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2F8427C7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEEBB2925E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1EA6D1A8;
	Tue, 30 Jan 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxHQKXzj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28581AB6
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627760; cv=none; b=L9+xXqvR3medVx+f90aebC9laYN3YM1Gfx/G+197E2DVgZLKzMaM6V3yJOQtHex13BcEppff+kfFw0Xr+ZIfH1kExppLERpHgvVEJd6qv8pmw/Cif3ynfu12QrIzK88lPYH7vhzPDCZ4gcrZ8jM+mtbag3gOBEOa4ML+whtJ2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627760; c=relaxed/simple;
	bh=sEVJJm4UKZVfvmZUWFRBTTWSMsrevLrRpTcncgmRbuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzI68OU48Xy78tfA29zw+gNliqgR1NcHqVHlqQp8a7I70eAgRkj/k9I+aWXtPFbambJNbTEvuJ+YueR3ZZtUYqRf8Fr5tM4yTAiTi9o3g6T42tTQ96JjJDVBc5i4dUlLu8lGBmFdbkIDPaHEBHJBWA3D2wjgyrJrZQu24AYcc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxHQKXzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C459C433A6;
	Tue, 30 Jan 2024 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627759;
	bh=sEVJJm4UKZVfvmZUWFRBTTWSMsrevLrRpTcncgmRbuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxHQKXzjQO01K8aC0cwHeVTVoU50V9S1XN17T36oxEd2ojzgninbO2MbUdrBCAYF8
	 pUzYZgevgicdiTQn6210Wm6FfHABBpujlU/3twHxMMfOY870PYFLOnv40I6humbNn1
	 2H70YO3zyanfMlFHd8TTrnQU26p/U4JplFB83z4syhCQ1IT0vck3gHLCy49vH76cp5
	 Z+xSXbHkaqQznSYzf5YVC74PFePa+2ycbbMVfANb5p1D41SYidOLcu1l4mJLs+UTz7
	 BEBUKn2wXUuh5zXu1zkPPEPyanPIqYYsZtTMbRamH+BCf2dRWz6PoubUrTUFe+ZZEK
	 /9QCQDC3H+I3w==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: xl@wp.pl
Subject: [PATCH 1/4] wifi: zd1211rw: remove __nocast from zd_addr_t
Date: Tue, 30 Jan 2024 17:15:53 +0200
Message-Id: <20240130151556.2315951-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130151556.2315951-1-kvalo@kernel.org>
References: <20240130151556.2315951-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse warns:

drivers/net/wireless/zydas/zd1211rw/zd_usb.c:383:24: warning: implicit cast from nocast type
drivers/net/wireless/zydas/zd1211rw/zd_usb.c:419:24: warning: implicit cast from nocast type

This is an ancient driver which has not have any meaningfuli changes for a long
time and hopefully removed soon. So just remove the __nocast to get rid of the
sparse warnings.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/zydas/zd1211rw/zd_def.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_def.h b/drivers/net/wireless/zydas/zd1211rw/zd_def.h
index 8ca2d0aab170..2f55e8deee82 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_def.h
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_def.h
@@ -12,7 +12,7 @@
 #include <linux/stringify.h>
 #include <linux/device.h>
 
-typedef u16 __nocast zd_addr_t;
+typedef u16 zd_addr_t;
 
 #define dev_printk_f(level, dev, fmt, args...) \
 	dev_printk(level, dev, "%s() " fmt, __func__, ##args)
-- 
2.39.2


