Return-Path: <linux-wireless+bounces-12460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DE96B34A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F4D1F26715
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4C4148833;
	Wed,  4 Sep 2024 07:48:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FE146588;
	Wed,  4 Sep 2024 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436095; cv=none; b=hm8WuoNgHWrEjQMMEolCYbTUakHaF72aVx9DQr05KeYlIo4j1nfpO1+34LSe2w8ctF7RMtdx08G09cmiVOHTTCtuqPfRUXAyxUmR4PbWh0xgt7aQo2Sa539fgvXjBiRewxhH+rX9AzJ1MXRpUMHW4cgOuEXJo2xsNIKOI1tZZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436095; c=relaxed/simple;
	bh=jPUHbEFRlioacszj1Y1QLmf9zGOBWuwFLQ3AY59fBGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RBi1gOlXKdp7Pu2LvhAX0kUwUL1HqzfcaWW3FEz0yaAuKG8AD05Xf3pk403EuLQ/3pfwLCzVLnO5SNQkIN0MxQfcD5UgP63+aYwajGoOPmDc0LOYcaSy6buPprQWZdTkxrH9dfYMowAjhhackh7/rF5vAUBmnPOpaprq3/uA8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABHLiGXENhmb0EmAQ--.3968S2;
	Wed, 04 Sep 2024 15:47:35 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	johannes.berg@intel.com,
	kees@kernel.org,
	a@bayrepo.ru,
	wsa+renesas@sang-engineering.com,
	quic_alokad@quicinc.com,
	marcan@marcan.st,
	j@jannau.net
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] wifi: brcmfmac: cfg80211: Convert comma to semicolon
Date: Wed,  4 Sep 2024 15:46:37 +0800
Message-Id: <20240904074637.1352864-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHLiGXENhmb0EmAQ--.3968S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoW8Jryrpr
	W8Xa4qyF1UWws8Ka1fKFs7Aa4rtanxGas2k3yjyas3uFyDXr18Ja1v9Fy3Wr1kAr4Iyay2
	9Fs0qFnrXrsxGrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4xMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbp6wtUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 815f6b3c79fc..349aa3439502 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1135,7 +1135,7 @@ static void brcmf_escan_prep(struct brcmf_cfg80211_info *cfg,
 		offset = offsetof(struct brcmf_scan_params_v2_le, channel_list) +
 				n_channels * sizeof(u16);
 		offset = roundup(offset, sizeof(u32));
-		length += sizeof(ssid_le) * n_ssids,
+		length += sizeof(ssid_le) * n_ssids;
 		ptr = (char *)params_le + offset;
 		for (i = 0; i < n_ssids; i++) {
 			memset(&ssid_le, 0, sizeof(ssid_le));
-- 
2.25.1


