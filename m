Return-Path: <linux-wireless+bounces-21487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A230FA87948
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 09:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562873B2A5C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EBD1F3FD1;
	Mon, 14 Apr 2025 07:43:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425E259CA0;
	Mon, 14 Apr 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616602; cv=none; b=f8/P8j6QEhO1fbXzqJHRIF7VZcTc2Mm9vyM1gehJ5QZteJC+HEgBN38pVP87OR9dLTZT4UWtVRSbg5OVWh/7mn4NH4bI3vcNMXgU07wEEJJYGl1+oTBetA18wWlwV4r1qIVXIG7ryu5hhOnRS3hxxs1r6GanNoUrtc5KlXg+v9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616602; c=relaxed/simple;
	bh=QAa+J/meRHMtog91cSwrp/o8jck/81Pbje00Mrsvge8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3/8KkUlgtdYUWnvlGTbRKv97nYSbN5rLe2rdBeprVOS83oTs5OY7EuTCy7CByY9FHvSYeuRsQJhAtw6ND3QzvlcEpEvgaTHnoCoaoJJ2FiI/xaTGCvXLLyy//9BGgS3wb/gK5FxIL3sLmOMLlXXkvuDmm+dTF9bu3rPimoo+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowADnGwSIvPxnXNrnCA--.16539S2;
	Mon, 14 Apr 2025 15:43:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org,
	sebastian.reichel@collabora.com,
	erick.archer@outlook.com,
	megi@xff.cz,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH RESEND] brcmfmac: Add an error log for brcmf_sdiod_ramrw()
Date: Mon, 14 Apr 2025 15:42:32 +0800
Message-ID: <20250414074232.2342-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnGwSIvPxnXNrnCA--.16539S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4xur47KF4fGFyxWw43Awb_yoWkZFbEqF
	savrnxX34Sg34kuryDAFW2vrWvk34qqw1vgr1ayayfKr1IgFW3KrZ7ZFn5Jw17WF4IqFnx
	Cwn8AFyUG3Z7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj_b15UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoMA2f8nOl0JgAAs+

The function brcmf_sdio_buscore_activate() calls the function
brcmf_sdiod_ramrw(), but does not check its return value. Log
the error message to prevent silent failure if the function fails.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index b1727f35217b..dd683c2582fb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3898,8 +3898,9 @@ static void brcmf_sdio_buscore_activate(void *ctx, struct brcmf_chip *chip,
 
 	if (rstvec)
 		/* Write reset vector to address 0 */
-		brcmf_sdiod_ramrw(sdiodev, true, 0, (void *)&rstvec,
-				  sizeof(rstvec));
+		if (brcmf_sdiod_ramrw(sdiodev, true, 0, (void *)&rstvec,
+				      sizeof(rstvec)) < 0)
+			brcmf_err("Fail to reset vector\n");
 }
 
 static u32 brcmf_sdio_buscore_read32(void *ctx, u32 addr)
-- 
2.42.0.windows.2


