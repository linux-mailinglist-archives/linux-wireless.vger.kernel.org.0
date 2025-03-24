Return-Path: <linux-wireless+bounces-20744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A203BA6D5BE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 09:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D86616B4BB
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB125C71B;
	Mon, 24 Mar 2025 08:03:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB630EEAB;
	Mon, 24 Mar 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803391; cv=none; b=lsCHq+6xTSJHNvA/kkHb+GoseFZxusF86LSsz9MmYiIrAqcaOHuvoZ2a3KFIixOSEpqPFgAlIl6vhKauZcrsEKi/vjOkwh0RLIsZ4IIFwdkQmF9GozVKOQArmTXcZs0ySWAP0/bI9IEkN70pIRhemr1j2sWdHIBgUij84hxr0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803391; c=relaxed/simple;
	bh=FJY3fJQcYQfxI8Zea0PmPCWsuDdPzJkMEb6ylvOn5V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BAjlI2ZpOYkRAnDwR/DhE/xSXkMmiYkS/NzYy3xrYRhwY0Vf9gpWtIfkukCKgfrB9Xi/QeBHR6I6teREAAz3x6cnV1jUgsznyQG125kfgUha825jqrGNHEJaBynciBdZfKbk224TrkmLFVpMNhuF9gyH+ODUbae4MU9ZbPTVv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADnkj+5EeFnzivTAA--.3732S2;
	Mon, 24 Mar 2025 16:03:05 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] wifi: rtw88: usb: Remove redundant 'flush_workqueue()' calls
Date: Mon, 24 Mar 2025 16:03:03 +0800
Message-Id: <20250324080303.408084-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADnkj+5EeFnzivTAA--.3732S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1xZFy7tr1DuryrtFyxZrb_yoWkuwbE9r
	WxKFsrKFWUGr1S9w4Utr1rZFy0vrWDZF43Xa93try5K3yjq3y5Zrs7Zr1kGrWDWw4UCF17
	C34kX3W8X393WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjnXo7UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@

- flush_workqueue(E);
  destroy_workqueue(E);

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index c8092fa0d9f1..667473b7a9f5 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -948,7 +948,6 @@ static void rtw_usb_deinit_rx(struct rtw_dev *rtwdev)
 
 	skb_queue_purge(&rtwusb->rx_queue);
 
-	flush_workqueue(rtwusb->rxwq);
 	destroy_workqueue(rtwusb->rxwq);
 
 	skb_queue_purge(&rtwusb->rx_free_queue);
@@ -977,7 +976,6 @@ static void rtw_usb_deinit_tx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 
-	flush_workqueue(rtwusb->txwq);
 	destroy_workqueue(rtwusb->txwq);
 	rtw_usb_tx_queue_purge(rtwusb);
 }
-- 
2.25.1


