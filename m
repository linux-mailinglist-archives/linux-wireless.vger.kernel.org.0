Return-Path: <linux-wireless+bounces-27529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BEB8B489
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39204A80CCE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7632C15B4;
	Fri, 19 Sep 2025 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Wd87HB0u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B028DB54;
	Fri, 19 Sep 2025 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316174; cv=none; b=Fl+kAqz1BwOzC7761joCRErkPg0ay7C6BIPjsQarrOEgR5tUtDRUGoE0F/cOIDAc37MPy1WuAmT4EoNmqpixUJ6Ce8qMkxSUmFIdMsIFguDjFtUVkWbBhseoPpLytDUjZVm7zf5brb0sZXU1OUFOHvsGI2naQJQy71IfvcVXLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316174; c=relaxed/simple;
	bh=cG3vmSe6SxklI3ueJ9M2OA0WGfCITGkIas8B4xIdNTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEaibPrMTMLQX6S3zB0h2PHD10opxLTld76MdaslyUjTRQlTqGDTNcywBAikOfW3/MBnpn5JVXLjB1Rel5tegj1uftEhFft660K4fY48H1Ib/Cf+iYOwEg9g3vseod0iZQMunt2SaK9FoWPrQ1j/LeHsYez98h3f9ord+3db0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Wd87HB0u; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6D8AD4076729;
	Fri, 19 Sep 2025 21:09:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6D8AD4076729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758316164;
	bh=BA5tqSvBSp4kXec7WBC70HwJ6Ad9Ag1iFAokhWm+jcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wd87HB0uEvzQLj532giJgSbV9deUMLDJarwSXqjAK5ofYzc4/TAnZIVasLp6pJBcm
	 RhphrtnNrHpKueTdP7sMJDNlpJcltjnB7nXyjW/+NJt9zi2gkMnLYgx07NlwmgF+CI
	 1mw5a2vKG57W+igXGOkpdc+pBrSsbHDvTsCpCjS4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 3/4] wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
Date: Sat, 20 Sep 2025 00:08:49 +0300
Message-ID: <20250919210852.823912-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919210852.823912-1-pchelkin@ispras.ru>
References: <20250919210852.823912-1-pchelkin@ispras.ru>
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---

v3: - use dev_kfree_skb_any() directly on error handling path without
      extra goto complexity  (Zong-Zhe)

 drivers/net/wireless/realtek/rtw89/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1f44c7fc1c5e..917b2adede61 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3961,6 +3961,7 @@ int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rt
 	rtwsta_link = rtwsta->links[rtwvif_link->link_id];
 	if (unlikely(!rtwsta_link)) {
 		ret = -ENOLINK;
+		dev_kfree_skb_any(skb);
 		goto out;
 	}
 
-- 
2.51.0


