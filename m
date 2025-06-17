Return-Path: <linux-wireless+bounces-24169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85810ADC10A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 06:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC21F188D23C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 04:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C10157493;
	Tue, 17 Jun 2025 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UM6LQH/z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36502CA9;
	Tue, 17 Jun 2025 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135606; cv=none; b=aW82af2e3VwnNqNCcd3+k5tmdHvGVHWhzF8Vwomss/zCkSYQPlRBpZnkFVqVxI3p7QNxvoWkXZ/Lu944MCe06vh9bwC4xiTUiIdZ6yMJAlckZ5gCnWCAt067YvcUh9cpRSnvZ5nEtFLvWBGpUnIxAX3NchFqkYnhVIAmNW6ad6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135606; c=relaxed/simple;
	bh=T1FS5bOw12EMeQrXS4zYruYJW1j/vmZ5iYm5L4YXz0U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZU/9olDIa1IkLM+Y4a0/jI4BXqptY5/Xo/H6VW1zC3i5VQFmSjbwFlSoNhlh2sYsCSw38D9oi7d8ZrzvrupZF2bIbQt5+cew2NukmAxsOaDZtTXJt+wsUV5ZyHlL8KytN819S8KbggTfAAW8a7woRxhceksPC2cQeEsQqJlUzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UM6LQH/z; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750135295; bh=h6NaYKLpNKZfedR+1l0CbMwHGilSw7Fyy67VZ3T6rO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UM6LQH/zrFgEnXgxH0oW4lHq1lP6ezo2+WTsgXcMxoei0ZuHQRXKRShXuI8NysgJZ
	 zolLsSOcqHhzabjpaO56/lrxYRreToorvC40m16DxGu+zhVfxZnUEpSXOTakIwIrZU
	 dCk270X3WZNK81Rq5zzhK7Rfu7BEPJRFEpbGloAs=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id A6100AFD; Tue, 17 Jun 2025 12:41:33 +0800
X-QQ-mid: xmsmtpt1750135293tb58raf7j
Message-ID: <tencent_8DCFF079526DB42E796E5095C0E8E2EE1E0A@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XncdsREuesUUT9jLDeIPY6j+Ui4GFkCoT2SKGK35ah+McYra3Si5
	 aq7fOqoG50h8Y6kzkzeK4cm0qUQ3EEtEWHtCYvHPVv6BafqNf+ZI1egQA74x9mHKn7bqax0NH7MY
	 SnlVECdkWL/LexD4ATPZl/+t8KCfimyXq0XZDGL9/Qb+wrl/HD7wCYteoAHhah3mPh5CZoFMPK+2
	 4Wgh4sGrhzPBEELxk90Us+1Gmdu8n5CfATV5XtVFWO5FMdmf0ba0B8xfYw8K8iTFVT5Jtet2bcH1
	 v1AqSxtwyADnkBc1MRDR4MoZEGKDulvmOTIviKlCSqnzDg3rknaZt+ovIDCvgvotzd5e/+alTgTl
	 ltK6lvMZsWuYhE7Y7BYiBu345GaR6p32AggZA1PVmGJ6nUXlYYVHaSsoReoozR2AysAN9EaNrhpI
	 DXw+MlVaEfhAAv4wYHGgfkNnxInJI5iswtPoiilAo7KaZCiiUNTrpoBX/12baaWRFaDzvXEZtH+t
	 zZtMv4fJ4Ba26m5jppWgWiwgu9QCorxJCyjIqmsIuld3Qn47T6BmQXokTmSWTiN/vbS5PKDRAqGh
	 TWNvsxc5E3YjgJkg7ZF7YcuvhUYTSRU2AIfpAQ4NmxMYUeW7yC+7P4jv3YZXJ4Qs7JB6gAjHkQqc
	 Zzp6Yoz9XtnND8/fb/1YfOFePZ/c/c+X+18SpYNb74sm/CdyAB0GD2I4i86J49pRZQeVv4Ovd6VX
	 IMTedDFcQfaUD+ui9Bh/luRrYV+FSJzqqDw5O9wZ+j4+XA2LwQKTVCi4h0eoeQDaM75bW5Ee5i5h
	 wS6F0/t5NhAI/TkIqZ8rSVLCB6anfoPrbfW9fnmc8fTrgqeXiJWdfCZUl7o64X7/EQVOxaRCuzsS
	 Q2cYW6nQxDAF038Jmyy93uNug9wbPAOKu+j+jpuXeYjvjttHD1LPRfjdIO3+NInMuWAGyd+7M8Nc
	 +xmg77AzMa4cfrB7AU4bBny3S0CSqv
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com
Cc: johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] wifi: mac80211: fix oob in ieee80211_rx_mgmt_beacon
Date: Tue, 17 Jun 2025 12:41:33 +0800
X-OQ-MSGID: <20250617044133.408443-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68504add.a70a0220.395abc.01e7.GAE@google.com>
References: <68504add.a70a0220.395abc.01e7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to ieee80211_s1g_optional_len(), it can be clearly seen that the
maximum size of variable is 4 and it is an array. Based on the above, the
parsing of the frame control field and optional field is optimized.

Fixes: 1e1f706fc2ce ("wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements")
Reported-by: syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6554b492c7008bcd3385
Tested-by: syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 include/linux/ieee80211.h | 2 +-
 net/mac80211/mlme.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ce377f7fb912..556ce95e0b0f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1278,7 +1278,7 @@ struct ieee80211_ext {
 			u8 sa[ETH_ALEN];
 			__le32 timestamp;
 			u8 change_seq;
-			u8 variable[0];
+			u8 variable[4];
 		} __packed s1g_beacon;
 	} u;
 } __packed __aligned(2);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2d46d4af60d7..fb7bf95ee87b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7222,7 +7222,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		struct ieee80211_ext *ext = (void *) mgmt;
 		variable = ext->u.s1g_beacon.variable +
-			   ieee80211_s1g_optional_len(ext->frame_control);
+			   (ieee80211_s1g_optional_len(ext->frame_control) - 1);
 	}
 
 	baselen = (u8 *) variable - (u8 *) mgmt;
-- 
2.43.0


