Return-Path: <linux-wireless+bounces-11379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104D950D4A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE645284A17
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0BE19DF49;
	Tue, 13 Aug 2024 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="cVEQ9Q2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BVYgS0Vx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B543AB0
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578260; cv=none; b=lq94kgL/WhvbMoXCHkJGqu0b5XJitz7Td9S50JIYogZEr2YEMMTE3b0GQlWE1fqfEdR9lRcGrgp6jV0oWpj3we0N5xqTBx53OOiUS89TPLEJKC3Jgqs2XcqgaNqT8VFV3pGlATSihi66lpR02KpR2OflUu0HLjO+c1r4OP4G7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578260; c=relaxed/simple;
	bh=7DlHDxlDY4MoD53shscyNHKMwraC0ta/6d02GQOSNpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VkZT59Wi86trc3FR+vn5EqzVmzx2Dh09Ys0h2dVQ+HTMOhdSUUcz/93KZIEOC4V3qh4Ej/5C2fnjTcgf8l2ZjXsdMcS9rBqQ5vu8r301pwgqBpMPArOWTLL3vp++HHiXPqyedyTvMy9Uv4lqOM1F4BJ9U6LEHMgO0d9oBGSEkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=cVEQ9Q2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BVYgS0Vx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A1A39138FC39;
	Tue, 13 Aug 2024 15:44:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 15:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1723578257; x=1723664657; bh=k+
	yX1WpSaGHAtYow8al5sKIJrowAE3TzPlezeIcRAV8=; b=cVEQ9Q2pzy3wQRfCVV
	qNUc6eIhrkLu+XDIoZCvMrMTU8bWxXE4XEEKy5HWBOPuJHlYsCYnr/XYtX6I3XVB
	5PCyvc/g7poOBrL76FH1rR+JFQUjcYPaqJfsvv/TCdGzI8kpeMrwmb8fuVtWXa+l
	+aijNuGHzuvvQotYdblwPBaKuWT3H85k6g6t/BIDEnFLhMgTADrFbzz8wWAUaSUP
	oF/OKQ5fm77W52/CDmLRREr+4KvbOBvo8NRV4CXqU8QlKocL44cyJ7/FQYUvWZGN
	z62FvqJfrGchKvHAw5qjzr7gJtWiKdM6n8u5qJMnAX5Wo5g3qGi+f8gKVF+CN/1L
	omKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723578257; x=1723664657; bh=k+yX1WpSaGHAt
	Yow8al5sKIJrowAE3TzPlezeIcRAV8=; b=BVYgS0VxI7Rde19e4W8tUwHhzb2hh
	kOWrZABxkTXVYH+z0zyGCL7Cb3OSMc9dOIxYsYqKWqhQh605D0zu9kUjDvBgGuNA
	/gWx4y3bFdxUCr4GC9cTLc60IWVGwLANJ8v+bjxM79bvzCdHEDDyK0zRd93CPa51
	x93uHrcgzlBhBpXgNJ1Rp7AMBMuM9meFNrC+v3CoZy3I4qOw/C12CDtjUFKZ3Ifk
	CEJEhkdXtadu43QzWXYzpfiwhnR18z3W5Wnv/UWHveN3OVeswl2Axk8+NdJ3xwJc
	ibs4qg9eUvcSGbjPubMVctfSOHVqsECHc7uLd+7x6CDtPN6+gkUwAbXQg==
X-ME-Sender: <xms:kbe7Zo2njP1WNmBezVc2mxDpmpWoQHLK4ZOIBJEsAxheyEyNFUuSFw>
    <xme:kbe7ZjEhXlcR4yyfEgkXTMk99kIDUEZQ8vR7p4h9h8KEul3sLcqA3qX6Kyfakfq3y
    JC0A8K3jcwgJaqiy4w>
X-ME-Received: <xmr:kbe7Zg6ActOu0uPlP6pC_V6d2KR5pEpLm5jC-rik9Q-2VGGhySbjeTZa8cTGJJSWHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpeflihgrgihunhcujggrnhhguceo
    jhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnh
    epieegleethedtleeufefggeeliedvgefgveduueffffdvheegudevhfeuleehtdelnecu
    ffhomhgrihhnpehmihhithdrghhovhdrtghnnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epfihirhgvlhgvshhsqdhrvghguggssehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepfigvnhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtoheplhgvshhlih
    gvpghsvghnseduieefrdgtohhm
X-ME-Proxy: <xmx:kbe7Zh2GmFxRvsiszwzTFh7XIOaLWHeVGCNjXcB25zS6PS4HO-MrUQ>
    <xmx:kbe7ZrHsbnqV10K-mz3OkDbjqDROmjlb4hqPMG8qhUPplsfiWLd83A>
    <xmx:kbe7Zq9p9PsNvhKqOrUV0iQsUcjOsI2yG7jPlt_mvpMGpv8OIoIyhw>
    <xmx:kbe7ZgnL9X8tSpEjTn1ofU6sChyc1Lyxk0NIybLMlR8QaUtss9U2iQ>
    <xmx:kbe7ZsOsGE5sNUqwnSDIk5EFs_aMWaJvXpV1cBiluXZtVE3Zb-9amx-2>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 15:44:14 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 13 Aug 2024 20:43:59 +0100
Subject: [PATCH RESEND] wireless-regdb: Correct regulatory rules for China
 (CN)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240813-correct_cn-v1-1-91275dc00d9d@flygoat.com>
To: linux-wireless@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>, wireless-regdb@lists.infradead.org, 
 leslie_sen <leslie_sen@163.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7DlHDxlDY4MoD53shscyNHKMwraC0ta/6d02GQOSNpE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTd2/vm/jY+ZjRLJ+V/qZluhqGw2OqpFfanhQtWpfHlt
 by/cbK8o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbyuoLhr+DtouPfT589PIs9
 p/7/ipeq3AxeBWsWmJ2a8kztz6nMTcsZGfac44y/7um/p6+K5fv9tN08H/n3TP6Y4v3WaJms2I8
 F7/gB
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

As per "工业和信息化部关于加强和规范2400MHz、5100MHz和5800MHz频段无线电
管理有关事宜的通知" ("工信部无〔2021〕129号"), only 5250 MHz - 5350 MHz
band is required to have DFS / TPC.

This is slightly conflicting with is attachment "2400MHz、5100MHz 和
5800MHz 频段无线电发射设备射频技术要求", which stated that all devices
working at 5100 MHz band should implement DFS/TPC.

After consulting authorities, we determined that the requirement in
attachment should be interpreted as DFS/TPC is only required if the
device will work in DFS/TPC specified in the article.

Correct regulatory rules to opt-out DFS and revert TPC power deduction
for 5150 MHz - 5250 MHz.

Reported-by: leslie_sen <leslie_sen@163.com>
Fixes: e427ff2a592e ("wireless-regdb: Update regulatory rules for China (CN)")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 db.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 788cd049ec21..9a55f6b8cc98 100644
--- a/db.txt
+++ b/db.txt
@@ -416,12 +416,14 @@ country CL: DFS-JP
 	(5925 - 6425 @ 320), (12), NO-OUTDOOR
 
 # Source:
+# https://wap.miit.gov.cn/zwgk/zcwj/wjfb/tz/art/2021/art_e4ae71252eab42928daf0ea620976e4e.html
 # https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
 # https://www.miit.gov.cn/cms_files/filemanager/1226211233/attach/20236/d1dc19424d5a4cfe90d631adeee8dd58.pdf
-# Note: The transmit power for 5150-5350MHz bands can be raised by 3dBm when TPC is implemented
+# Note: The transmit power for 5250-5350MHz bands can be raised by 3dBm when TPC is implemented
 country CN: DFS-FCC
 	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5350 @ 80), (20), DFS, AUTO-BW, NO-OUTDOOR
+	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
 	(5725 - 5850 @ 80), (33)
 	# 60 GHz band channels 1,4: 28dBm, channels 2,3: 44dBm
 	# ref: http://www.miit.gov.cn/n11293472/n11505629/n11506593/n11960250/n11960606/n11960700/n12330791.files/n12330790.pdf

---
base-commit: 003c282a297f8cec06a576fe1434c94353d14610
change-id: 20240813-correct_cn-1d2e30b41e07

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


