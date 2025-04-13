Return-Path: <linux-wireless+bounces-21474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E140FA870DB
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 08:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935647AEEAE
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451CEAD58;
	Sun, 13 Apr 2025 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xWPsdl8R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86C196;
	Sun, 13 Apr 2025 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744525029; cv=none; b=GxnW7niT8uBnEc+JC65IW4bByrkPwHbzZmQHQebGilGwygrXxfdM/1fHSZ+U8d72VJFMfyj4RMPHfGdLWGdOCjkUlEQQZOhjDTcS7kK/lSjqBt9dx3RUeuDafp1nXVCRCXMOU/7giLHF0jptBKYRlW5HBJcj5aJMWwkz+Hebm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744525029; c=relaxed/simple;
	bh=tfgZ0BsmebPGyP+hnJzfD3u1IrF86k7T+2KsIICZjiE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=st0td+TEBe1Qgx6Cf/ve5NO59UCyvCwuL+/Iq7gB6Et7kKpFAg5oHwhP2od295UnLX2C+uM8jHfKoYlcycXjh2QWfE/FFpUrAOSJu0uVNqxJ0wpULIu2OOEIfK5HXSMns9plfJDS1C8qUg4ekAdc5qC2WdglB57b6fK7NflS/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xWPsdl8R; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744524712; bh=MatRmkigavgeDx2al6JKbHirPWoFnOIOxPf5mkGIqKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xWPsdl8RhpXZ0QdDQgvtnhMfxdPKzIhHmd8N2ZOiHdKH29A3e7Ec5tLIwrvZKhEeg
	 XZxb3dq5PoF4BHzs5jLRvC5CpG/wtENjjBMpSqEIHo8lLKFZUGtLc/Wm6udqDf5bCA
	 hX8ch/PjGPQoRo8sQ88i4IJx20Xp49mH2JRlRKb0=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 2F200E04; Sun, 13 Apr 2025 14:11:50 +0800
X-QQ-mid: xmsmtpt1744524710tucimj4y1
Message-ID: <tencent_096EDEEED78C81A7D006E812E4C66E898A06@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQuG9ID9fs3lgwFJlpAkloCusXfj6XywK/krceRr5aj+De4T9e43
	 QHZRIACoGhjmZIbvPEDxbIfzMVUEZIdUKar0Yrx5k0Bt6IHWDlRGzh7Wse1Wu+6/3BWZ5ZXQ5Cnb
	 I/SUKeYdvvOE0LP5opEN55NNGWQql8a/3hCYu9MxDUQl+avI2/0p4M8vO2Np1H8kuOFT271h0wkY
	 c+ovYYJgiDsH3j2sd8nKygznDP8jYkWGSsfAdhYdKCO4OoFFyD0PXRrwGl4HruQ5/qE+JEFMPYxE
	 2YnxpcdV8pSXrRzZAroGZAnWMVSeBsh7sA3kDgnkeuUwFJt8AywijdTO+Qf3q2KRdWmFWij1JN9S
	 7hszCzWELcwQDyKdSrBdBNFjEroWxXG2HlO7b3zIh783CGHM8AVz4HcQ2ppV9t+Ch8ANKy8itf9x
	 YzPNiSsa8mU0XgQ6SHK/dqnqZUmp00eIwBlmCE0L4Knf5mNYfMCZS17WbFny8IfddfZ+cBTN3eZ5
	 LGVipkVp+SH2juz8BR/Uhz1EK4zQmbSY16Vx7kZbVyl2UkctqymNm0/MENol07AMxoEvOpWl9SJt
	 K1cWAwl2hGKMA4goGet0q58zcUB7Y+a2auB7RP3MaLefk3AlrHHujNxEkgr1lWLIwE3Q6Fu+RS+k
	 wKfPMVBxVwQy/OImMnMZBpkP2kSsYYzd37AlBaC60jD1NMjqqHI0GYbZCbqG/leZdYYTWAo4SziH
	 MKRvwUKrIWn1k1fNV8LgOelxflJO6PEU95hyuzpMdQVyLXhRLuNknAbJiLhxsmKE0il7Z1L61Qup
	 IndwKxEUi/yKiqo+uDf3MKgKeMFzNS4JbDlipFsG6jUVHlqSg5RUMDGIzUOBCu8XtT/QcFxj8J2c
	 PtFvCrJyX1Q85cfaICn57RkU1cnvVuVLx/i6wuyUue+oNXPv55agU=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Cc: johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] wifi: mac80211_hwsim: Prevent tsf from setting if beacon is disabled
Date: Sun, 13 Apr 2025 14:11:50 +0800
X-OQ-MSGID: <20250413061149.184475-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67fac9a6.050a0220.379d84.0016.GAE@google.com>
References: <67fac9a6.050a0220.379d84.0016.GAE@google.com>
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
 drivers/net/wireless/virtual/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf3e976471c6..cd9e89aebb83 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1226,6 +1226,11 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 now = mac80211_hwsim_get_tsf(hw, vif);
+	struct ieee80211_bss_conf *conf = link_conf_dereference_protected(vif,
+			data->link_data[0].link_id);
+
+	if (conf && !conf->enable_beacon)
+		return;
 	/* MLD not supported here */
 	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
-- 
2.43.0


