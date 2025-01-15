Return-Path: <linux-wireless+bounces-17521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE274A11644
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 01:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544EE3A1269
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 00:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEEDDBB;
	Wed, 15 Jan 2025 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IK8H7Dy6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C681EEF9;
	Wed, 15 Jan 2025 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736902485; cv=none; b=sF3IuRfGKzYQPPu67CoBb3VtixWYZBnbGZsJSiWy8yxvq3mx/BB5r/hs05r1coEtc4GJwrqrHvS5ko5DEKJcz3qRWLKqoWTtl2N8fRd8TEgDE4Tl0LLV9zphgwLb/oqeKtQz3cn6fFtVvePrFB7sZqyWxZ+pkYGbs1EapF+otBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736902485; c=relaxed/simple;
	bh=2o+41miWswVgS+q1cOSp6cT5IRL3G7k/qmupwxLiEQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cuWIUTpgIU2d7nlP4r7aJJpsAhdjOtRL4k9/lImLrxd1SPWAuHJeKfTT16v6HZJbkPvSqx7lkwEQopEGQdD1mU5kQ/YNJAKLx2zwTXwNZQKwZaVkVJ/MUVuXoGUy0GFfKYKVCD0IomKNH63t0KkTBbRUV5R1DMaazWD4Dzd/8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IK8H7Dy6; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736902473; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QOXScRW+5dK8a4MtczJp8IWbnnyzoaFQV8tOwaQius0=;
	b=IK8H7Dy6Q49652bnpw1Zw4/UHDaMbDEvVoG+xKRjj6cko5kL0eiMvjpuJ+8LsjjGEkISj9X407wYA2p84zGmOZcZ6bWG7bcwoYCN1h8HHod21ts8BGq9N0Oemx2AdnmeCpuJRYr6gkKzV/SWUUGBj5w36RnD4Azg92nyrBmEUTk=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WNgcabi_1736902472 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 08:54:33 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: kvalo@kernel.org,
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] wifi: iwlwifi: mvm: Remove duplicated include in iwl-utils.c
Date: Wed, 15 Jan 2025 08:54:31 +0800
Message-Id: <20250115005431.89510-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files net/gso.h is included twice in iwl-utils.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=13555
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
index b14ec98e28b6..c5b49851e4b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
@@ -4,7 +4,6 @@
  */
 #include <net/gso.h>
 #include <linux/ieee80211.h>
-#include <net/gso.h>
 #include <net/ip.h>
 
 #include "iwl-drv.h"
-- 
2.32.0.3.g01195cf9f


