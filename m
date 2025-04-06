Return-Path: <linux-wireless+bounces-21165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93647A7CD45
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 10:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D54167AC7
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DF3198E9B;
	Sun,  6 Apr 2025 08:20:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3C14F90;
	Sun,  6 Apr 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743927631; cv=none; b=muJUQnQsgGQAN2ar+LQhIn4KQlmwAHtcc4brWx6vs7Avkfn8oiAIGcDhRc2fQ4NKKd4G37oznNX40+XaGCctA9fb24PA8Iu2ClE4IGWU4Ka5qvYoalI54zHt6YNPHLQcXSTBZbtXIBUkvF2xGPycURsdK24Bm8MRrQhSsLFNaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743927631; c=relaxed/simple;
	bh=rgQGGLxGQ04eBTfkJXililQx1XDOFfLjUpGHn05Kjr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwPAluXjp9GYzQNQSNCLFhAvsrYFdbD6BlX1SGKneAGELe2auSgkK4umy38RLqWc+Itx30vBDRl6T35lB+nNQdzoS3ERbo2GaVgymQgSbMpOvG7c8Z1jL2+aOUH25hofo67LRF9FUr2INWEzANgS9VeTjgv6rcPu93PKb+2OPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [221.222.48.127])
	by APP-03 (Coremail) with SMTP id rQCowAAnzzs6OfJndDaNBg--.39362S2;
	Sun, 06 Apr 2025 16:20:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: christophe.jaillet@wanadoo.fr,
	megi@xff.cz,
	saikrishnag@marvell.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] brcm80211: fmac: Add error check for brcmf_usb_dlneeded()
Date: Sun,  6 Apr 2025 16:19:30 +0800
Message-ID: <20250406081930.2909-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnzzs6OfJndDaNBg--.39362S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy3ur13Jry7uF1rCF47CFg_yoW8WF4Dpa
	y7XFyUZr1kWrWrK3y5Jws3AFy5tw4rGa95Cay0vas3WF4kAw10kr4FgFyF9r1DCF4aka17
	XF45ta4Yqrs8GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8EA2fyG7wugQAAsc

The function brcmf_usb_dlneeded() calls the function brcmf_usb_dl_cmd()
but dose not check its return value. The 'id.chiprev' is uninitialized if
the function brcmf_usb_dl_cmd() fails, and may propagate to
'devinfo->bus_pub.chiprev'.

Add error handling for brcmf_usb_dl_cmd() to return the function if the
'id.chiprev' is uninitialized.

Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
Cc: stable@vger.kernel.org # v3.4+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 2821c27f317e..50dddac8a2ab 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -790,6 +790,7 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
 {
 	struct bootrom_id_le id;
 	u32 chipid, chiprev;
+	int err;
 
 	brcmf_dbg(USB, "Enter\n");
 
@@ -798,7 +799,11 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
 
 	/* Check if firmware downloaded already by querying runtime ID */
 	id.chip = cpu_to_le32(0xDEAD);
-	brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
+	err = brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
+	if (err) {
+		brcmf_err("DL_GETID Failed\n");
+		return false;
+	}
 
 	chipid = le32_to_cpu(id.chip);
 	chiprev = le32_to_cpu(id.chiprev);
-- 
2.42.0.windows.2


