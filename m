Return-Path: <linux-wireless+bounces-25611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75FB0911F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783671C42E2D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C852FE391;
	Thu, 17 Jul 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="NPng9LZM";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="cemtNlFI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i105.smtp2go.com (e3i105.smtp2go.com [158.120.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229762FE333
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767761; cv=none; b=o2ZQAQHDc8Ln1yID3kp951nPcyCYLcpZyWFPhz5Gcu9OOHnwmL1ujV5cedgKjB3YJ0bjGZf5lzzNnufj6IZZ1cxEx+CHUWUILKkEDADV5c85LhFrpEB9otgTkAblsuigUP/c/rh2AIXalZ803X9lsemdO7MWDFVpx3YiFRgCtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767761; c=relaxed/simple;
	bh=U47f9WVWX49XwgYkmvGT+3joZrWkuzftZnBDgHqGLyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKWGMHCF+UAoEqX6rt6l8UjDu9IaGdQSaAjdvV97hV4oWnsQ11TIMpc71KLsfsVWoV0WAvz1I+SmLTSBEbTYzicfQt4MqKio9hQRYK36PZ6ZOiNJG+mMXTk87Zuj31Tn5DgqtxFKyW5UZVj7UZkQgEEZInSmuoKPOfbluO1QRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=NPng9LZM; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=cemtNlFI; arc=none smtp.client-ip=158.120.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752767753; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=OYtEACTZzGea53FbOPy1SO3CM3inWtkbAiQquRgeXPc=;
 b=NPng9LZMj7Ry49FungneUI525kgnJne7+dUqzYMZ7TgSWcVtjWeDC/9frPXkXdI/Nps0Q
 ZCmRozsBmUS2vET0I5TcNq5PCwmwUbbazWbiPtwjOurYlSftFrjzBvmb6ZadVXpmCAKrcnH
 6vtJn7A7sUwRUlrvj58ea86swu8rjmAVX5HiUTcxoh3bRNzhDRKqxSnfTxzQTf99zULHaj/
 K5ME/H7NKjLMdBD6kepBDhkVAsQua+c+/TvfCHPGWGbb/cPLHWSvi4/AiaQ5kVxusHj32pz
 k1n8jYfwYlOUkEbDCo5bs4AE6rNT7EHHrOT0jMW2Q9YU0qKD//UN1fihdMyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752767753; h=from : subject
 : to : message-id : date;
 bh=OYtEACTZzGea53FbOPy1SO3CM3inWtkbAiQquRgeXPc=;
 b=cemtNlFIKk/b8gNlyC8ZgLHBIalBVGRRuXbLtKsVKcDuIuNduAK6UCds2jU4jb/J25QVP
 SfSgayqEOD7T73yIUMbpCTa1+g6ft39ekQwGcLoY/JBNQk6yIRpSf0RLDjRQYj20NUMhnN7
 GdcKiNsYh6yvuO2LdFmasJ4fdGj4Q73MalK+FkVsHzMbfFBBnoZGfZ1Mgc8PWweuekpyMEr
 Qt5zcwHKTun16/JhiyKpurxpw1PP4xq0TqnfR6v7QMRRaMv9Mzyb2539rEbBo/xkqGAYTkH
 dYS5ZmvTo14gihhnSbeMOOEOjRJDMs/lJnUlKxsmeZjpejZNMwwLbyapd+Kw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ucQxZ-AIkwcC8pXvG-HvHi;
	Thu, 17 Jul 2025 15:55:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless 0/2] Fix ieee80211_tx_h_select_key() for 802.11 encaps offloading
Date: Thu, 17 Jul 2025 17:45:27 +0200
Message-ID: <cover.1752765971.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sQtDXqd4MU
X-smtpcorp-track: 6yQpQZZNUOwW.5Q1-VyjFVtNd.2ftShAW6Ue5

The fix in [0] introduces issue with mt7921 chips (at least), due to the
802.11 encapsulation offloading support of those chips.
ieee80211_tx_h_select_key() treated 802.3 frames as if they were 802.11
ones causing the skb's control block hw_key to be invalid.

The first patch fixes the root cause of this issue and the second one
reapplies the initial use after free fix that has been temporarly
reverted meanwhile.

[0] https://lore.kernel.org/linux-wireless/06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt/

Remi Pommarel (2):
  wifi: mac80211: Check 802.11 encaps offloading in
    ieee80211_tx_h_select_key()
  Reapply "wifi: mac80211: Update skb's control block key in
    ieee80211_tx_dequeue()"

 net/mac80211/tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.50.1


