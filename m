Return-Path: <linux-wireless+bounces-27241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D3B53407
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 15:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E69A82AEE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90933A029;
	Thu, 11 Sep 2025 13:40:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D2311958
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598024; cv=none; b=bO0SZ+W6bPiJIPTYwg9eAvkGJUFQM0LLd2hAOE7imTN0R/yFU93CMWYFoa0/B4FuuIoIrYR8O+VrgyshZkVHZQOce7X8vlzr5qlxp14sEZ67WciOtIr1iBnznFuvZyQ46D/gXU/7aFtzp/ZubFZUYdfYO5DfAD5vl4uSpnB8Zu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598024; c=relaxed/simple;
	bh=niwqshIc15PLuc/Z8gv0gIQ83Ajcp/nAomTGK0AAQ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuAcoVM2/F/yk2Q2F51GSWBUltOan1RRE/TPEh2qV24mLSbOl4zQHWnEbJBzIzVn4uSHJw4iy5VwoQdo7TXFlL+783dMbmnU0z08hpWZDDlRB/0AvnCcO7RrSTsZeRqN2VfmCYfDwN7QVzVfbTjy0nMZ+pz1ZzxrOkD/fxx29Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-01 (Coremail) with SMTP id qwCowADnQKM20cJo2jdKAg--.17425S2;
	Thu, 11 Sep 2025 21:40:06 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: stf_xl@wp.pl
Cc: chenyufeng@iie.ac.cn,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] iwlegacy: Add sanity check for il->stations[] array index
Date: Thu, 11 Sep 2025 21:39:50 +0800
Message-ID: <20250911133950.1152-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnQKM20cJo2jdKAg--.17425S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fAr1UtF17Ar18ArWDurg_yoW8GFy8pa
	1UCw1j9a4rJr4Du397Ja1SqFy5G3ZxtrsrurZYkwn5Zr1Dtr1Fvw1Y9a4293yFgrs8X3W3
	Zr1qqw43Cr45ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry8
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU838nUUUUU
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiBwoAEmi-5-bK1QADsF

In the il_process_add_sta_resp function, the index sta_id in 
il->stations[sta_id] is not validated, which may lead to memory 
corruption if the sta_id index is out of bounds.

Fixes: 0cdc21363cc2 ("iwlegacy: merge common .c files")

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
Reviewed-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
Changes in v2:
- Add header file commands.h to get IL_STATION_COUNT
- move the validation of sta_id to il_process_add_sta_resp

 drivers/net/wireless/intel/iwlegacy/common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index b7bd3ec4cc50..2840d0935650 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -22,6 +22,7 @@
 #include <net/mac80211.h>
 
 #include "common.h"
+#include "commands.h"
 
 int
 _il_poll_bit(struct il_priv *il, u32 addr, u32 bits, u32 mask, int timeout)
@@ -1766,6 +1767,11 @@ il_process_add_sta_resp(struct il_priv *il, struct il_addsta_cmd *addsta,
 		IL_ERR("Bad return from C_ADD_STA (0x%08X)\n", pkt->hdr.flags);
 		return ret;
 	}
+	
+	if (sta_id >= IL_STATION_COUNT) {
+		IL_ERR(il, "invalid sta_id %u", sta_id);
+		return -EINVAL;
+	}
 
 	D_INFO("Processing response for adding station %u\n", sta_id);
 
-- 
2.34.1


