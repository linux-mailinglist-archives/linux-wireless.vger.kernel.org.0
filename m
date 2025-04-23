Return-Path: <linux-wireless+bounces-21917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59AA98CEB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F230188495B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1227EC9F;
	Wed, 23 Apr 2025 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LpeSQ0HC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE727CB3F;
	Wed, 23 Apr 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418267; cv=none; b=bCPJOvRcUxoCkHno6sBTnrl5i5gUQjFxdkXM022+9zdgo3uwyLCvwnXAAEkmvXXG76ywcxkTNrnuYRzPuM1KRLnkTPx/lFrSiUxIuc/BDqFPrwWeUjEdfqF/gM2QUjtqyDVK7f/SPXK2qVnMXgRIuyqsKa06JWn0XS7j17L1DkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418267; c=relaxed/simple;
	bh=ldzeL9n6n8UvujH+BjibWdqnkQGbQXwiwE01NjFC6Fo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fhCQk7hrhhMTZwxppZWO/DMdLR/xOIQ53pWxk3O7mCAnj56cSz58c2TRMA61hMIKvQ7i8IuMyJG96wcveqIo4Hm6IQ03834v4+PgIxzFejqjpYCRRctht3jGJ4/ARQbrc+nRdjiTR9sxATnr75X1Gp6BSTLBJbnESpdTxqJWsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LpeSQ0HC; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1745418254; bh=DXlNwRWPJdq2HN9HaKgCtPRCmH7GpcacN5PhDHtMBG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LpeSQ0HCffaFkGxhi5zTmYGdvbklvf7QzxSHMSEYvnLbbrvltOBOsc0SLwNyXHf1w
	 k7ohgY+KTyw2E51tCfOgvDSLMpuQyElIpYKwop1GCTtytK7IFe8NBzlaLtv7EV8LVo
	 UP9KogicAy7LlpPYE4Z5tU1+kjfeodlrlVC4WVRs=
Received: from pek-lxu-l1.wrs.com ([114.244.56.254])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 3F508A12; Wed, 23 Apr 2025 22:15:53 +0800
X-QQ-mid: xmsmtpt1745417753t5uvaf95q
Message-ID: <tencent_3609AC2EFAAED68CA5A7E3C6D212D1C67806@qq.com>
X-QQ-XMAILINFO: ND42uzdxTIzrKj80Eu0Mf7sTW28VA2jR1s1E1YOE68DdUEDtpm/A2uWsdVOKyz
	 Wg17hGcmzIn728olpWXVbaNrowbYq1+rvL6YyvjmjbDDD08t5gqMAJVJZgt/nCOVBnFHp86WJ+Yr
	 skUmJHGoikM6Iq4Eqk9++AaNwL392txDZuiUj9r6D3Y3O4z9C1Z2KVe8mv+4J5EPjyoySCT2CNIE
	 0UDYdJiNhRv/H0gxt9k6U0Am2f6fa0FD9DmUlQJw6aNmLYpYPSfRup6MPI/WvTbswlA/ubV/lRnB
	 3ZlWvNo47ZfjzvxXSxv4kHf1PUp6d0aKCu50z1u2JbtZ/veuRWWhw0meP7kuY3PDepf9y0AJvOTl
	 PrGRVP41O+Jy6BinV8maHuMXLyOsWbtKPUxq1X8w+paXMyZMC3aoT0LhX/KyXlgJmN+QQXa9+cUt
	 aLRmicNo+J5iTw75IrnV3a3zLJ9k735ZYHvQ2N8suoHGOYCKXVwqQA+Kpq7Z4AjqZaQlGyolsNRK
	 Lcbaj2yzJcdfNOtwd/TBUfEgsq0TwW/ItYYcKspzqP3E0jOqa6jI37n4J9vk9dvANWZXYbmaXzEY
	 1f+XVnn+VU0vHNNTvceXgr0gGTUDZm3Zi4iwTRYt20oNTbySpojdVYzn40JbxRCPDIxLuRqKGuFa
	 GgrYlB0Zm7QEOqtmC5kKAdGZOv3GEOwkwVeDyPi6uA8319D6PrEGab2jT8Jf+U8cehDbsDSL5nKk
	 kU5pt6Y4DpqOnWtlP0LkVs2yK6g5ADIk+M7X+Hv7f2jNlc21QKhpTW6PhFL1QXEgs5peNGJ8llm2
	 aWFZmZWz+795JOJVk3iZNPW3hNV6+wcy5A/2ZBgJTwOaSokKS/OHPMBpE5vEFO/qGLkSP6PRWirF
	 LbsaC69mMVl7C+te9WUJLC5upQBXoLn5iy/Ec7C3KgDUw9/JiXgAXoNFiErDZMjckhy+8Bfi5aAx
	 44UhZJOXsZE6Lkk9iYfnqqv/j9a2NjhK65AT41kPH0txQ+ZBDGO5sY7TBddODY
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: johannes@sipsolutions.net
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
Date: Wed, 23 Apr 2025 22:15:53 +0800
X-OQ-MSGID: <20250423141552.2598995-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <ff63580712b8f20b4be7b38a31bc3bb9d69a4820.camel@sipsolutions.net>
References: <ff63580712b8f20b4be7b38a31bc3bb9d69a4820.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting tsf is meaningless if beacon is disabled, so check that beacon
is enabled before setting tsf.

Reported-by: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=064815c6cd721082a52a
Tested-by: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: Move initialization and judgment to after delta.

 drivers/net/wireless/virtual/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf3e976471c6..6ca5d9d0fe53 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1229,6 +1229,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	/* MLD not supported here */
 	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
+	struct ieee80211_bss_conf *conf;
+
+	conf = link_conf_dereference_protected(vif, data->link_data[0].link_id);
+	if (conf && !conf->enable_beacon)
+		return;
 
 	/* adjust after beaconing with new timestamp at old TBTT */
 	if (tsf > now) {
-- 
2.43.0


