Return-Path: <linux-wireless+bounces-21828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF1A95ECA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 09:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4568A3A6921
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E22367D1;
	Tue, 22 Apr 2025 07:00:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08F1F92A;
	Tue, 22 Apr 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305228; cv=none; b=t2c+CVrfq9eAF4qLZybl5KA2id2vSsrONGxZZws3ZS9BeC77fR4oSBQxP29luwz3q8uGPYIyH90hwrgMAsEb0DPfVOXF0lxzBR+P5xUBF8ldt4oe9ec8jrhPvWns8zifBHYjp9IPhFwtrsbyJLlQ1oXP8fhdLRVg/r5ODaxCCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305228; c=relaxed/simple;
	bh=pMLtKo1GLVRJoMOK4cWV+nK9vCwPPRwTpuCuCCkS+ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSOEBwk1vr+5SBE/qr3A0+vbgtyZfbtb1yBBiZ3nErFlT4UEas6lhJEqt8/6Nnow74Zm5HGbAM/VTK56jlBQGa4IuEvcMZyPop52azQJJPOfQXuSO5q5ix72Fjpi/8yKMNCF1NQ1MP48whQPklDX9VqEgqnr16TmSxA7Zb/dPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABXBUJ3PgdoefoUCw--.50317S2;
	Tue, 22 Apr 2025 15:00:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v5] brcm80211: fmac: Add error log in brcmf_usb_dl_cmd()
Date: Tue, 22 Apr 2025 14:59:38 +0800
Message-ID: <20250422065938.2345-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXBUJ3PgdoefoUCw--.50317S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4kuFWkAw1UCFWrJryUGFg_yoW8uw4fpF
	4xXayjyFW8Wr4Fgan3trsrJ3Wak3WkJayvkF47u3s7Xr48Cw1rWw1rKFyF9w4kCr4xC347
	JFWDtFn8Wr17GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUejjgDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8AA2gHJ35aWQAAsw

In brcmf_usb_dl_cmd(), the error logging is not enough to describe
the error state. And some caller of the brcmf_usb_dl_cmd() does not
handle its error. An error log in brcmf_usb_dl_cmd() is needed to
prevent silent failure.

Add error handling in brcmf_usb_dl_cmd() to log the command id and
error code in the brcmf_usb_dl_cmd() fails. In this way, every
invocation of the function logs a message upon failure.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v5: Remove finalize label.
v4: Fix spelling problem.
v3: Change patch name and comment. Move error log into brcmf_usb_dl_cmd().
v2: Remove redundant bailing out code.

 .../broadcom/brcm80211/brcmfmac/usb.c         | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index d06c724f63d9..b056336d5da6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -741,15 +741,19 @@ static int brcmf_usb_dl_cmd(struct brcmf_usbdev_info *devinfo, u8 cmd,
 			    void *buffer, int buflen)
 {
 	int ret;
-	char *tmpbuf;
+	char *tmpbuf = NULL;
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
@@ -770,18 +774,23 @@ static int brcmf_usb_dl_cmd(struct brcmf_usbdev_info *devinfo, u8 cmd,
 	ret = usb_submit_urb(devinfo->ctl_urb, GFP_ATOMIC);
 	if (ret < 0) {
 		brcmf_err("usb_submit_urb failed %d\n", ret);
-		goto finalize;
+		goto err;
 	}
 
 	if (!brcmf_usb_ioctl_resp_wait(devinfo)) {
 		usb_kill_urb(devinfo->ctl_urb);
 		ret = -ETIMEDOUT;
+		goto err;
 	} else {
 		memcpy(buffer, tmpbuf, buflen);
 	}
 
-finalize:
 	kfree(tmpbuf);
+	return 0;
+
+err:
+	kfree(tmpbuf);
+	brcmf_err("dl cmd %u failed: err=%d\n", cmd, ret);
 	return ret;
 }
 
-- 
2.42.0.windows.2


