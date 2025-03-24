Return-Path: <linux-wireless+bounces-20722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0195A6D328
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 03:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A66A16CD76
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 02:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8017C68;
	Mon, 24 Mar 2025 02:49:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EF4C7D;
	Mon, 24 Mar 2025 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742784592; cv=none; b=HH8hGWMjbG/o7NB/YY+WjKGMy/Lnn6ucW0umMMSgcxTxGXJpikykARmY8I40VKTSfabjkRbdwMHnItmSArQwgvicaTteUuPJzLz5TNsrR+D4w3qQ6yXYUqhztaqzvBFAa5kB3jOA26BwKV8ejQsTNdDfR/ZSiNXCr4omSR403u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742784592; c=relaxed/simple;
	bh=pVH4l5IuDX06XKsi3JiroKLp+jhVtYNElgaivoHzWEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gUJl1xKEKwuUWSZnSQzLNh5N0MkuPg3VyvKmHjmBUKZt92rT4qzGO8sWrMa5ySNOdTxHLP5ml2FGsFSW9RB8o0FhiG7UpiSsEOn1ID5S0CsaZk85x+/bBx/zkquDpdPzRrJBpY938xsHqCgr6boGQbVXclehaVu1UR5IeT3kPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZLcqg3VQPzvWqL;
	Mon, 24 Mar 2025 10:45:51 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B264140132;
	Mon, 24 Mar 2025 10:49:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Mar
 2025 10:49:46 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <miriam.rachel.korenblit@intel.com>, <johannes.berg@intel.com>,
	<ganjie182@gmail.com>, <emmanuel.grumbach@intel.com>,
	<avraham.stern@intel.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH wireless] wifi: iwlwifi:: fix spelling errors
Date: Mon, 24 Mar 2025 11:00:21 +0800
Message-ID: <20250324030021.2296493-1-wangliang74@huawei.com>
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
 kwepemg200005.china.huawei.com (7.202.181.32)

Fix some spelling errors in comments:
 - configuraiton -> configuration
 - notificaiton -> notification

No functional changes.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 3af275133da0..b4528668478d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -364,7 +364,7 @@ struct iwl_fw_ini_error_dump_register {
  * struct iwl_fw_ini_dump_cfg_name - configuration name
  * @image_type: image type the configuration is related to
  * @cfg_name_len: length of the configuration name
- * @cfg_name: name of the configuraiton
+ * @cfg_name: name of the configuration
  */
 struct iwl_fw_ini_dump_cfg_name {
 	__le32 image_type;
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 2081775e0ec9..71adbe844060 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -475,7 +475,7 @@ void iwl_mei_device_state(bool up);
 int iwl_mei_pldr_req(void);
 
 /**
- * iwl_mei_alive_notif() - must be called when alive notificaiton is received
+ * iwl_mei_alive_notif() - must be called when alive notification is received
  * @success: true if received alive notification, false if waiting for the
  *	notificaiton timed out.
  */
-- 
2.34.1


