Return-Path: <linux-wireless+bounces-21540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B4A896F7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 10:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0C8189DC42
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7B1DDC18;
	Tue, 15 Apr 2025 08:43:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DC1AF0AE;
	Tue, 15 Apr 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706605; cv=none; b=Liu86L2bshNTYmlh1IEgdcQqu3K4795O5n93lg1RspaIQEb/tAFMzyL+rd0CNIYqf4ATGVMfygFyllGfpoQghr26jKBN2F8VLkXLdvp4zjCujpB+s8PUyVWrVzA8QecOSFxz5VTKKzoBBMtg8DIU3YxWIdNBVA68sU+/k5UfWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706605; c=relaxed/simple;
	bh=HtsOkMq+WLgJHrBJNsrJTc1wbQ/EcZYFGAgOXBZbQrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fb4Ye/nQcliAp/DdSredi9TcSLaFYSaZZ1pvrEUK48aOR6TDTrqeX8dzAaNBYKApXKJRz8V+evCUEy7mx+f6Mj5Nf1RCSKSVamNzbrqAeYIEKRfonXMxmtOb5Za0NKLbypFDwBHmZjVtRiDXscabziUF8cWCPqGWOCOMhMCac/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowACXOTYgHP5nYXz5CA--.18019S2;
	Tue, 15 Apr 2025 16:43:13 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v3] brcm80211: fmac: Add error log in brcmf_usb_dl_cmd()
Date: Tue, 15 Apr 2025 16:42:39 +0800
Message-ID: <20250415084239.2906-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXOTYgHP5nYXz5CA--.18019S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4kuFWkAFWrWF4Dtr4fXwb_yoW8AF1fpr
	4xXayqyFy8Xr1Sgan3trZxG3W5K3WkJayvkay29wn7ur4kCw10gr4rKFy09r1kCrWxA347
	ZFWUtF1DXr17GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfU0_MaDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgNA2f95Gzj0wAAso

In brcmf_usb_dl_cmd(), the error logging is not enough to describe
the error state. And some caller of the brcmf_usb_dl_cmd() does not
haddel its error. An error log in brcmf_usb_dl_cmd is needed to
prevent silent failure.

Add error handling in brcmf_usb_dl_cmd() to log the command id and
error code in the brcmf_usb_dl_cmd() fails. In this way, every
invocation of the function logs a message upon failure.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v3: Change patch name and comment. Move error log into brcmf_usb_dl_cmd().
v2: Remove redundant bailing out code.

 .../wireless/broadcom/brcm80211/brcmfmac/usb.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index d06c724f63d9..a11a6d9f3c2b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -744,12 +744,16 @@ static int brcmf_usb_dl_cmd(struct brcmf_usbdev_info *devinfo, u8 cmd,
 	char *tmpbuf;
 	u16 size;
 
-	if ((!devinfo) || (devinfo->ctl_urb == NULL))
-		return -EINVAL;
+	if (!devinfo || !devinfo->ctl_urb) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	tmpbuf = kmalloc(buflen, GFP_ATOMIC);
-	if (!tmpbuf)
-		return -ENOMEM;
+	if (!tmpbuf) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	size = buflen;
 	devinfo->ctl_urb->transfer_buffer_length = size;
@@ -783,6 +787,10 @@ static int brcmf_usb_dl_cmd(struct brcmf_usbdev_info *devinfo, u8 cmd,
 finalize:
 	kfree(tmpbuf);
 	return ret;
+
+err:
+	brcmf_err("dl cmd %u failed: err=%d\n", cmd, ret);
+	return ret;
 }
 
 static bool
-- 
2.42.0.windows.2


