Return-Path: <linux-wireless+bounces-11723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB3959528
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 08:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9168F1C223E9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 06:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681DE193420;
	Wed, 21 Aug 2024 06:55:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40644193415;
	Wed, 21 Aug 2024 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223338; cv=none; b=PdNzwn7fT70gAYYMvaomf2Iy7Pu9VWx8sLkL3V7Xxpy3HQR4QYg0aYXpTnzESESnUANPSUoVK7U0k/Q4LgWXQ8pz79RcAe+N4p+Pd0mNeOEfBMeNE5yGTdp+p2r6ZAJByr2mOHqTwdV/BeRWRUG1noSdvBsru9Uwa9QW5J5VhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223338; c=relaxed/simple;
	bh=gIYMljte8VXdR795wUANfiJ4XNEzXf2GpQMeByB4BoQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LZEzKrlbBl9bMw4NB+amDV3YmKIGUh8NoZ+ywxLoFuIFJmd/Q3OVypbfZRt1spXYeoB6tRZmHLrMfwnZakvaplVy1oY3QWRrQcQADUOVJMOs9gRi4TO9B0HFBiDnSOFYW2G3B4E29+k8/O4ZVs8v3aNz/HgPWqG8Y8OdbDI1qwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WpcVp1lvHz1xtyn;
	Wed, 21 Aug 2024 14:53:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id AC7901A016C;
	Wed, 21 Aug 2024 14:55:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 14:55:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <arend.vanspriel@broadcom.com>, <kvalo@kernel.org>,
	<johannes.berg@intel.com>, <miriam.rachel.korenblit@intel.com>,
	<erick.archer@outlook.com>, <ruanjinjie@huawei.com>,
	<emmanuel.grumbach@intel.com>, <linux-wireless@vger.kernel.org>,
	<brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] wifi: brcmsmac: Use kvmemdup to simplify the code
Date: Wed, 21 Aug 2024 15:02:57 +0800
Message-ID: <20240821070257.2298559-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.

No functional change.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Update the commit subject.
- Remove goto lablel and retun -ENOMEM instead.
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c  | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index d86f28b8bc60..5b1d35601bbd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1611,10 +1611,9 @@ int brcms_ucode_init_buf(struct brcms_info *wl, void **pbuf, u32 idx)
 			if (le32_to_cpu(hdr->idx) == idx) {
 				pdata = wl->fw.fw_bin[i]->data +
 					le32_to_cpu(hdr->offset);
-				*pbuf = kvmalloc(len, GFP_KERNEL);
+				*pbuf = kvmemdup(pdata, len, GFP_KERNEL);
 				if (*pbuf == NULL)
-					goto fail;
-				memcpy(*pbuf, pdata, len);
+					return -ENOMEM;
 				return 0;
 			}
 		}
@@ -1622,7 +1621,6 @@ int brcms_ucode_init_buf(struct brcms_info *wl, void **pbuf, u32 idx)
 	brcms_err(wl->wlc->hw->d11core,
 		  "ERROR: ucode buf tag:%d can not be found!\n", idx);
 	*pbuf = NULL;
-fail:
 	return -ENODATA;
 }
 
-- 
2.34.1


