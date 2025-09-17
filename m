Return-Path: <linux-wireless+bounces-27438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B901AB7D315
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840911C077FE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972834F48A;
	Wed, 17 Sep 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="t1tE9mLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845334AAF8;
	Wed, 17 Sep 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102809; cv=none; b=S93M2kbomJg8anMUvSWvHSLH7+bdKHWbGfrbWq+ntzkluC5R+xfZEZVAhYrA8bOp8KK0uDK6AzGWJtetdJ/tyVxIapOnwntk0Ff8/KH2zqJgLimS+PPcfDUSUr0rsfZF5eU13lbJx8ThpEVZFBxglorY9ZoftCp5/G9KykgWjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102809; c=relaxed/simple;
	bh=Z6WFa63zjsc+Is008WcLAUC1CBEJ8Rp//U3P7D7Or6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+cDKc+VI/77G4qTogQPwJ+MoBbXe+36VJyosM+LEmY1u40aMFPQw+iuFyvVMhW8y3jxBOfNSw0ZD+iA2Ee2eYm+P3nvsyWM7W+t8lK++3qEt2o/3TL0p8ZmV7uthavjgnABbAIT6YlLAK32WS4VmoGIDasoy1XWd4EFU4oY4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=t1tE9mLS; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 645FA40762FA;
	Wed, 17 Sep 2025 09:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 645FA40762FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758102805;
	bh=f/YEzLdxm8kSP50ULaxs2lF1wtYhmnUu1ouQXHI1fuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1tE9mLSLjiQdO/WF0UGGBZRn4IoPZY9PkO435TveymGy+DjgDHnfPKYTCSGRgv2l
	 ljH0EeiRecwWWASldont4czzIom7oQHkyi2S3lIBdBieLwibV35jGmG1JRVYANafqv
	 EvwQDGHYVhimdAvur1kd5O/5ghuUfCopc/gDAXf0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v4 3/4] wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
Date: Wed, 17 Sep 2025 12:52:54 +0300
Message-ID: <20250917095302.2908617-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917095302.2908617-1-pchelkin@ispras.ru>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is no rtwsta_link found in rtw89_core_send_nullfunc(), allocated
skb is leaked.  Free it on the error handling path.

Found by Linux Verification Center (linuxtesting.org).

Fixes: a8ba4acab7db ("wifi: rtw89: send nullfunc based on the given link")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v3: - use dev_kfree_skb_any() directly on error handling path without
      extra goto complexity  (Zong-Zhe)

 drivers/net/wireless/realtek/rtw89/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1efe4bb09262..4310ef839dd6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3460,6 +3460,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	rtwsta_link = rtwsta->links[rtwvif_link->link_id];
 	if (unlikely(!rtwsta_link)) {
 		ret = -ENOLINK;
+		dev_kfree_skb_any(skb);
 		goto out;
 	}
 
-- 
2.51.0


