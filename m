Return-Path: <linux-wireless+bounces-21483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D634EA875D8
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 04:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7973AF5C6
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD318D65C;
	Mon, 14 Apr 2025 02:29:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A49DDD2;
	Mon, 14 Apr 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744597772; cv=none; b=RAN+HwI6O7l9ppqLf8WAOHzoygjC3nUZz1nKPgYn9Sw/A0zBAOEFnYEcGuDDuq11MGwPRrRvgdQUUE6tU5r5B7C/bPADAIFCeQmop85LqKPJ/hXRq6b/+ZIaTG36E5F4i/9Oygt0h+HXCd/3S9AeifEuiIuNzEFPKW+Qc6Ek9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744597772; c=relaxed/simple;
	bh=8e43JfZtGPIrrAReIU0/vZ4SrcKs4H6mn59ZlV59EOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzVX70ZRie0+E1FPda2oSkVeU9LkVB1TtHn6k7rus0KFgXqt3aven1T/Aur2Eubf/dxaJvD6z5rxOM/y67kRmLCp9kqcgwCyFKY68M5clwB0XuY+9+VGbG/dPvR6NRG6qgMP2rDswMwJqczmPrMLwMk2EQEB0fIB6sIw8fb54G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAXUwv2cvxneIncCA--.64253S2;
	Mon, 14 Apr 2025 10:29:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] brcm80211: fmac: Add error check for brcmf_usb_dlneeded()
Date: Mon, 14 Apr 2025 10:28:53 +0800
Message-ID: <20250414022853.1795-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXUwv2cvxneIncCA--.64253S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4kAF43WrWUXr13Ww15Jwb_yoW8XF43pw
	4xXFyUZr1kXr4rKw45JrZ3AFy5tan5ta1kCa10v3Z3WF4kCw10kr4YgFyI9r1DCF4Ikay7
	XF45t3s8Jrs7WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbvzutUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREMA2f8Wy5sYQAAs0

The function brcmf_usb_dlneeded() calls the function brcmf_usb_dl_cmd()
but dose not check its return value. Though there is an error log in the
brcmf_usb_dl_cmd(), it is not clear enough to describe the error state.

Add error handling in brcmf_usb_dlneeded() to log the error message if
the brcmf_usb_dl_cmd() fails.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Remove redundant bailing out code.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 2821c27f317e..8e2b41cfe5cf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -790,6 +790,7 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
 {
 	struct bootrom_id_le id;
 	u32 chipid, chiprev;
+	int err;
 
 	brcmf_dbg(USB, "Enter\n");
 
@@ -798,7 +799,9 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
 
 	/* Check if firmware downloaded already by querying runtime ID */
 	id.chip = cpu_to_le32(0xDEAD);
-	brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
+	err = brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
+	if (err)
+		brcmf_err("DL_GETVER failed: err=%d\n", err);
 
 	chipid = le32_to_cpu(id.chip);
 	chiprev = le32_to_cpu(id.chiprev);
-- 
2.42.0.windows.2


