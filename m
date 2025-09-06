Return-Path: <linux-wireless+bounces-27042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA2B46AB2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Sep 2025 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A001BC651A
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Sep 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9B2C032C;
	Sat,  6 Sep 2025 09:42:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EF315D4A
	for <linux-wireless@vger.kernel.org>; Sat,  6 Sep 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757151775; cv=none; b=Ilos9Nif5W/DdWb9dn1kzrYJ9P7WmvFZhyCsD2r14cmZvc+ZltWje2nVPvl2OprOqp8lojL+H+uj2h7qOWbHiKsGzydxoDGP+Wc9UYGNBGA5srl7X05brNYNv1AKi3vsoJuVdIMFrcfBUxU0xUlMoOoAY6CfASNet6zmYtOnA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757151775; c=relaxed/simple;
	bh=WwmeFPN0P9lMslONo+33s81pcN6Blgc7kKJ8CknvZBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1i8Q1/zEp74N6z38Rhz4Ygg+D6WuZP5rXI0i8RWX0WsDTbAM2tIhndo27FFJF51uQn+uRhDRWkgLm0RWCHh0elA4i9Imxdew4gYR1UKV/1nwOlFzlS9a4rxYwuQKxKKVc044nyYhjN1z+ImNCqEtCCVmzcH5YqUFKThAAp0rLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-05 (Coremail) with SMTP id zQCowAAHqRITArxo2s8KAQ--.48009S2;
	Sat, 06 Sep 2025 17:42:45 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] iwlegacy: Sanity check for sta_id
Date: Sat,  6 Sep 2025 17:42:32 +0800
Message-ID: <20250906094232.1580-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHqRITArxo2s8KAQ--.48009S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8Gw17XrW8Gr4xKry8Krg_yoW5GF48pr
	1UGw1jka48JF4kuayDJF4xAFy5C3Z7tw47GF9Ykw10vrsrJw4Yvw1Y9a429ay5GrZ8XF12
	vF1qqw1fCF4jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
	uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjItC5UUUUU==
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiBwoREmi7k07PyQAAsG

This patch is similar to 2da424b0773c("iwlwifi: Sanity check for sta_id").
`2da424b0773c` introduced a sanity check to prevent potential memory 
corruption in function `iwl_sta_ucode_activate`.

In the iwlegacy driver, the function `il_sta_ucode_activate` shares 
a similar logic with the `iwl_sta_ucode_activate` function in iwlwifi. 
Initial observations suggest that the function may not adequately 
validate the range of the `sta_id` parameter. If `sta_id` exceeds 
the expected range, it could result in memory corruption or crash.

Although there is no confirmation of a similar vulnerability in the 
iwlegacy driver, it is recommended to adopt a preventive approach 
by adding range checks for `sta_id` in the `il_sta_ucode_activate` 
function. For example:
```
if (sta_id >= IL_STATION_COUNT) {
    IL_ERR(il, "invalid sta_id %u", sta_id);
    return -EINVAL;
}
```
Adding such boundary checks can effectively mitigate potential 
memory corruption issues.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index b7bd3ec4cc50..a3bcf9d9ffa2 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -1735,10 +1735,13 @@ il_cancel_scan_deferred_work(struct il_priv *il)
 EXPORT_SYMBOL(il_cancel_scan_deferred_work);
 
 /* il->sta_lock must be held */
-static void
+static int
 il_sta_ucode_activate(struct il_priv *il, u8 sta_id)
 {
-
+	if (sta_id >= IL_STATION_COUNT) {
+		IL_ERR(il, "invalid sta_id %u", sta_id);
+		return -EINVAL;
+	}
 	if (!(il->stations[sta_id].used & IL_STA_DRIVER_ACTIVE))
 		IL_ERR("ACTIVATE a non DRIVER active station id %u addr %pM\n",
 		       sta_id, il->stations[sta_id].sta.sta.addr);
@@ -1752,6 +1755,7 @@ il_sta_ucode_activate(struct il_priv *il, u8 sta_id)
 		D_ASSOC("Added STA id %u addr %pM to uCode\n", sta_id,
 			il->stations[sta_id].sta.sta.addr);
 	}
+	return 0;
 }
 
 static int
@@ -1774,8 +1778,7 @@ il_process_add_sta_resp(struct il_priv *il, struct il_addsta_cmd *addsta,
 	switch (pkt->u.add_sta.status) {
 	case ADD_STA_SUCCESS_MSK:
 		D_INFO("C_ADD_STA PASSED\n");
-		il_sta_ucode_activate(il, sta_id);
-		ret = 0;
+		ret = il_sta_ucode_activate(il, sta_id);
 		break;
 	case ADD_STA_NO_ROOM_IN_TBL:
 		IL_ERR("Adding station %d failed, no room in table.\n", sta_id);
-- 
2.34.1


