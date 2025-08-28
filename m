Return-Path: <linux-wireless+bounces-26836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D46B3AC8B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 23:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA8201BA8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 21:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E329AAF7;
	Thu, 28 Aug 2025 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jLNIDucL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274E2877D6;
	Thu, 28 Aug 2025 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415585; cv=none; b=Nlp25zw9GPQxu0GVQIZ4mgoDyHTpVBO1CZxAY6fzYRK6QjINTzP3dTqPzTqUhTGV4kePiZYBDex8Zb/jBRyEN0JK2r7gwpF+u7VXbiCd5rD/6zhW//jkP/IrBlMMtVXJIRHEAKf17HD0L8ZJcHiAu9+bF4DWjzt7OIDHYZQLBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415585; c=relaxed/simple;
	bh=YRZXTvxoXTQPEnWn7auw4Pay3xEKIhw1cMd5jGw06NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrKMlh+TVhDbX12zy++lOB/xrhiJXmiCWdNtUczrV+cWRErFlcj1USPkBVr/Alap/K9cNVSSMVXpk9BNd6J+ySRrvXKiP74Wbu2QdsCE+dFal85AXKfRoUFQ/L9RCCcQS1B4qe89aRfTH7Vosit9EYTekytqtP8UTtdvr3diYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jLNIDucL; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9EA67406C3E6;
	Thu, 28 Aug 2025 21:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9EA67406C3E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756415581;
	bh=NjOV+/52p6JcKU2GFjZtvMQSSL9FFi8reWwcdTySwxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLNIDucLUoWopjmx6rGJmg2okljVYUb5zSf2dqQN6pNX4E+mXLkc7y1iBEH6KWnwD
	 ONEus3Dfj5FcIb7CZX7vW1dcXz2mX1QVGiIqni9nEwBxy62xVBhqqGms9MU6kuUC/J
	 IUudu5Bd8T3r19DqZrgiIbid8+eeBNDH1+dgs0qg=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v3 4/5] wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
Date: Fri, 29 Aug 2025 00:12:00 +0300
Message-ID: <20250828211245.178843-5-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828211245.178843-1-pchelkin@ispras.ru>
References: <20250828211245.178843-1-pchelkin@ispras.ru>
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
index 57f20559dfde..0076dae4572c 100644
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


