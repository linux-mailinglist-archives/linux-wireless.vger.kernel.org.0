Return-Path: <linux-wireless+bounces-9985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D028C9272A8
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8757C1F21766
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0231A38D4;
	Thu,  4 Jul 2024 09:07:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576AE1A2C1E;
	Thu,  4 Jul 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084030; cv=none; b=lGR+Khc6kC5b3Qpf3vB86/wkIxMavzpj95ZWDaS5l/axFtegGrzbMHO1HdhWyPxNKu2HymEb2nYQotyYKyuHmYm3TzeXIvVOOSciX736rZWvNJiPQLmoctrB3jaTc9fcS3VwdBFpMvOBGFWQhDIxE8JRDlvXVWvgPWG6g5cHybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084030; c=relaxed/simple;
	bh=m3qFZFHHNn0awE1fYsv7m1+rjLeG0ckAedaj9ES3qEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ku6Y+quOWmptR0qaECjrbQSdxg/yAFdhGQJoICfFSTFoW4mBoA9GyPxdF7Xd4EEEfWavcP5yrY6XLZFKpukiv36J2kV15LA2No2GocivsZ8toRNxiPAdJ2Bv8eeqZMYJ0XAYJqCuYtaqQT1V7ARGzd/YOvfcMo9ach2svxkE6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADX3eUvZoZmvmd4AQ--.29228S2;
	Thu, 04 Jul 2024 17:06:55 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: stas.yakovlev@gmail.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ipw2x00: Use kzalloc instead of kmalloc/memset
Date: Thu,  4 Jul 2024 17:06:22 +0800
Message-Id: <20240704090622.2260102-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX3eUvZoZmvmd4AQ--.29228S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr18Xr4fJw15GryUWryUJrb_yoWftFg_Cr
	1IkFn2yr98uwsa9r4UCF4fC3yjkFWDWr40qryIyr98GFWDArZ5C3s5Zry7XrW5C343AFyU
	A3sxZr9rCrW5ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6rWrUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

replace kmalloc + memset to kzalloc for
better code readability and simplicity.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
index 4aec1fce1ae2..e22a6732a4c3 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_tx.c
@@ -180,11 +180,10 @@ static struct libipw_txb *libipw_alloc_txb(int nr_frags, int txb_size,
 	struct libipw_txb *txb;
 	int i;
 
-	txb = kmalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
+	txb = kzalloc(struct_size(txb, fragments, nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-	memset(txb, 0, sizeof(struct libipw_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = txb_size;
 
-- 
2.25.1


