Return-Path: <linux-wireless+bounces-21181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3AA7D2E2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 06:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0529B167BC9
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 04:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4462135AF;
	Mon,  7 Apr 2025 04:21:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADA335C0;
	Mon,  7 Apr 2025 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743999664; cv=none; b=BxKV2ich+Vdjj39OkpcO1CC7HW6ObDxbjdU1TCPFdbROFv3kOIdNrx6Kv6V8bzu3zjcZm0UJRcS8gViL0qEjq/sYPYQ7jV4vwg6TodX7Sk8x7z91jOdkY+0m+GW4hObF19EysD/2eU99HO4SqgReE5hHq0VUPE2EzboyTxXRk2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743999664; c=relaxed/simple;
	bh=QAa+J/meRHMtog91cSwrp/o8jck/81Pbje00Mrsvge8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUxeXZJBGYXI+DQmlLFoGPtJmRnGj1IMIX+7he9Iu09Vl6M+6CC+CluNFWkAJAmG/Din2k3Lb+JWX4pCgsisBAWyLeEQIFE4XgMISgmaWmbmjCctLPHecm2Eptuvur/OwLeABiHVqMXe8dK4uSX/lHBV08v98lvfeC4cOTvyw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAXUwudUvNn2GrLBg--.10356S2;
	Mon, 07 Apr 2025 12:20:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: sebastian.reichel@collabora.com,
	erick.archer@outlook.com,
	megi@xff.cz,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] brcmfmac: Add an error log for brcmf_sdiod_ramrw()
Date: Mon,  7 Apr 2025 12:20:28 +0800
Message-ID: <20250407042028.1481-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXUwudUvNn2GrLBg--.10356S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4xur47KF4fGFyxWw43Awb_yoWkZFbEqF
	savrnxX34Sg34kuryDAFW2vrWvk34qqw1vgr1ayayfKr1IgFW3KrZ7ZFn5Jw17WF4IqFnx
	Cwn8AFyUG3Z7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUFA2fzOrdHTAABsc

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


