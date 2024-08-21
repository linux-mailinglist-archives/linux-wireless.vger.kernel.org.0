Return-Path: <linux-wireless+bounces-11717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601839592B7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 04:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0920D1F24285
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 02:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83061803E;
	Wed, 21 Aug 2024 02:26:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D391CAB8;
	Wed, 21 Aug 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207173; cv=none; b=GkmMFTClOkOT5JLkOEBFPmvCeDJmYFxX+dhSMDI3DaXM+ixSHP+YGSgCuQix4JeT/9gtTvt8wcDdPLExfDVHUe9SpNHSQEZs8+fH1SNp2YpY4hqBsbcNvkHOjATX3RfnZDieDZaGOvEOjuGOjbHLn9/SvR+GSPPpMNXSwgmT99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207173; c=relaxed/simple;
	bh=yQMJjuO/BJYdld1tuMGXVh9vgQ8x/bEM2wmjjr8ymoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnM3DZ4CGF/gLkh/8dAyScHpVq5mRUpqTzkUoVyAJh15npmfjQbT/i/avUHzyQ7KaKJgs382owW/dI+wdY3CHn294cAFTPdrQM4ET61m4B17AR0UgrU8+NExuzFX1C4bVo8QVwYFo1iXb15DqsWptvTz4UT3K6SzN7KFu8+1S5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WpVWp4BDmz1xtrJ;
	Wed, 21 Aug 2024 10:24:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EAC50140154;
	Wed, 21 Aug 2024 10:26:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 10:26:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <arend.vanspriel@broadcom.com>, <kvalo@kernel.org>,
	<johannes.berg@intel.com>, <emmanuel.grumbach@intel.com>,
	<ruanjinjie@huawei.com>, <erick.archer@outlook.com>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] wifi: mac80211: Use kvmemdup to simplify the code
Date: Wed, 21 Aug 2024 10:33:25 +0800
Message-ID: <20240821023325.2077399-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.

No functional change.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index d86f28b8bc60..7717d7764d2d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1611,10 +1611,9 @@ int brcms_ucode_init_buf(struct brcms_info *wl, void **pbuf, u32 idx)
 			if (le32_to_cpu(hdr->idx) == idx) {
 				pdata = wl->fw.fw_bin[i]->data +
 					le32_to_cpu(hdr->offset);
-				*pbuf = kvmalloc(len, GFP_KERNEL);
+				*pbuf = kvmemdup(pdata, len, GFP_KERNEL);
 				if (*pbuf == NULL)
 					goto fail;
-				memcpy(*pbuf, pdata, len);
 				return 0;
 			}
 		}
-- 
2.34.1


