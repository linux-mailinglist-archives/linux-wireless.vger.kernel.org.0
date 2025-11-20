Return-Path: <linux-wireless+bounces-29152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345CC72BFC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 811AE28A8B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9A7372ACC;
	Thu, 20 Nov 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NH+OXqkW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0813D638;
	Thu, 20 Nov 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626600; cv=none; b=Fx9dChtMOtOQ08K+OaALUTRfMPpNUpLQdyX3S8ii38pqEcq86pj75/gn3TuhZJiaAKhf6LHSd/MqXt8xmtjIpEzFxhBYf02rMim/W3ew6kfoZZxhSRaiiBMLcCoywEXhyiv9vSc9RnqllFpoy+bCnDS3EGlBW5H0sC/WTyfShx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626600; c=relaxed/simple;
	bh=hEynGrgvxjhXh4ciJJ0GdACd5m6a2EMpALqpP/Hi2FY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sW/Z0R/Htdsz84FFW7A8mgjtj0ij8GjfgWzs4UcRF+mQQjsBM5GjkWe659ct+OufetASPd2EVqMjAlkV1snneBMOSSQ06UwSJsxcWJ7lhADZHmBCfucZWfQmLb52qtAoPOWPgyxt7ynAjn+7OvV+zizm5oiQ6Wn51UVVjnX9bh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NH+OXqkW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ks
	F16UAWth3gRWpMdRmDZ6klErujz6BFF7fsNjVIEAQ=; b=NH+OXqkWb9e5oGHSwY
	7cty+WHvpxOvobImPBuAoSDm22lAjUhvx0pGvvnEPaCxi9eruClM5ze0q4T6Wrqj
	Us5zw39Npm8ee/gPMW9IRpBXjOm7MlxZ30tNgfuY5YigkPbFDlhKuZxtl0MeytKp
	C46UayIE5E2ffztK513TQWoMo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD33_FZzh5pKlVZEQ--.59614S2;
	Thu, 20 Nov 2025 16:16:27 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH 1/1] wifi: rtw89: Add missing NULL check before __skb_unlink
Date: Thu, 20 Nov 2025 16:16:23 +0800
Message-Id: <20251120081623.1273490-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD33_FZzh5pKlVZEQ--.59614S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyftw47Aw13urW5Gry8Zrb_yoW5Kw45p3
	y5t3WxGrs5tr47X3W8A34fJr1fJ3WqyayxJFn7try5GryrW3s5tFy8Ja4UXF1jyr4rJFy7
	Crn8Xw47Kr1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jThFxUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXAAMumkey0lWggAAsL

From: Gongwei Li <ligongwei@kylinos.cn>

__skb_unlink(skb, list)) attempt to access skb->next,
triggering a NULL pointer dereference (Kernel Panic).

[  541.001831][ 7] [  T273] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  541.011776][ 7] [  T273] Mem abort info:
[  541.015697][ 7] [  T273]   ESR = 0x96000046
[  541.019873][ 7] [  T273]   EC = 0x25: DABT (current EL), IL = 32 bits
[  541.026302][ 7] [  T273]   SET = 0, FnV = 0
[  541.030476][ 7] [  T273]   EA = 0, S1PTW = 0
[  541.034733][ 7] [  T273] Data abort info:
[  541.038734][ 7] [  T273]   ISV = 0, ISS = 0x00000046
[  541.043689][ 7] [  T273]   CM = 0, WnR = 1
[  541.047779][ 7] [  T273] user pgtable: 4k pages, 39-bit VAs, pgdp=0000002610943000
[  541.055341][ 7] [  T273] [0000000000000000] pgd=0000002610948003,
pud=0000002610948003, pmd=0000000000000000
[  541.065173][ 7] [  T273] Internal error: Oops: 96000046 [#1] SMP

[  541.220794][ 7] [  T273] Workqueue: phy0 rtw89_fw_c2h_work [rtw89_core]
[  541.227407][ 7] [  T273] pstate: 20001089 (nzCv daIf -PAN -UAO)
[  541.233339][ 7] [  T273] pc : skb_unlink+0x68/0xa0
[  541.238164][ 7] [  T273] lr : rtw89_fw_c2h_work+0x3c/0x88 [rtw89_core]
[  541.244686][ 7] [  T273] sp : ffffffa6c998bd40
[  541.249124][ 7] [  T273] x29: ffffffa6c998bd40 x28: ffffffa6db4ad200
[  541.255558][ 7] [  T273] x27: ffffffa6dc810000 x26: 0000000000000000
[  541.261996][ 7] [  T273] x25: ffffffa6dc810090 x24: 0000000000000000
[  541.268432][ 7] [  T273] x23: ffffffa6da902be0 x22: ffffffa6da903140
[  541.274877][ 7] [  T273] x21: 0000000000000000 x20: ffffffa6ca2a2900
[  541.281313][ 7] [  T273] x19: ffffffa6da903970 x18: 0000000000000000
[  541.287749][ 7] [  T273] x17: 0000007fb74284b8 x16: 0000000000415090
[  541.294184][ 7] [  T273] x15: 000000007fffffde x14: ffffffa59082bc1b
[  541.300620][ 7] [  T273] x13: ffffffa59082bb16 x12: ffffffa59082bbfa
[  541.307058][ 7] [  T273] x11: 0000000000000000 x10: ffffffff9b08a8a0
[  541.313494][ 7] [  T273] x9 : 0000000000000000 x8 : 0000000000000000
[  541.319928][ 7] [  T273] x7 : 0000000000000000 x6 : ffffffa6ca2a2600
[  541.326363][ 7] [  T273] x5 : 0000000000000060 x4 : 0000000000000000
[  541.332796][ 7] [  T273] x3 : 0000000000000001 x2 : 0000000000000000
[  541.339229][ 7] [  T273] x1 : ffffffa6ca2a3600 x0 : 0000000000000000
[  541.345666][ 7] [  T273] Call trace:
[  541.349254][ 7] [  T273]  skb_unlink+0x68/0xa0
[  541.353720][ 7] [  T273]  rtw89_fw_c2h_work+0x3c/0x88 [rtw89_core]
[  541.359907][ 7] [  T273]  process_one_work+0x1c0/0x340
[  541.365050][ 7] [  T273]  worker_thread+0x4c/0x488
[  541.369845][ 7] [  T273]  kthread+0xf8/0x128
[  541.374117][ 7] [  T273]  ret_from_fork+0x10/0x18
[  541.378817][ 7] [  T273] Code: b9001260 a9400281 a9007e9f f9000420 (f9000001)
[  541.386039][ 7] [  T273] ---[ end trace 1c8ff29ce038612f ]---

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ab904a7de..d00e97eb4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6895,6 +6895,8 @@ void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work)
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
+		if (unlikely(!skb->next || !skb->prev))
+			return;
 		skb_unlink(skb, &rtwdev->c2h_queue);
 		rtw89_fw_c2h_cmd_handle(rtwdev, skb);
 		dev_kfree_skb_any(skb);
-- 
2.25.1


