Return-Path: <linux-wireless+bounces-11354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE60C95092E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F301C22B4C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD219F479;
	Tue, 13 Aug 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Xe0yMTcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWKqJyeJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310EE199245
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563173; cv=none; b=ekjKIwS2FnV/RV7R5w4oDLGp9SHoS+cVLcmfGvcJeOR13eASUrhKmzF68QpTBhOS8jzvlbuzuRy18tdIZjwpaPfY6/Po+gXQENfcb6/pZyqaZKg+vxZth/GNR0P+S80AzPEQmuu619gg7eyQ6odP3nSKKXWsTwOxHRvrj2g/Hjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563173; c=relaxed/simple;
	bh=7DlHDxlDY4MoD53shscyNHKMwraC0ta/6d02GQOSNpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sU4xjYUsK4bScZLz4Fxr8sxUKvlcADh49gtKQPhyDnvIZp4g/gWrwy06vPUg8gASh7Kip4NcMYtzsAGJe4IOJlGFYuf8zakCjT3/axNqCke225vHIiQOTLvJ6TdGjWpCnZPN41e2IUgojM0rHquRNSxXGQXEoDEH5LE3McmKJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Xe0yMTcO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWKqJyeJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4913D138FCCC;
	Tue, 13 Aug 2024 11:32:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 11:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1723563170; x=1723649570; bh=k+
	yX1WpSaGHAtYow8al5sKIJrowAE3TzPlezeIcRAV8=; b=Xe0yMTcOV5qbcSchxM
	xwQl5fXZEb3C6W850V8PjjfA9sN8fowdZd91UUUbmE2VP0xx6dDI22n9ZaVCFbk+
	ZNXhfT081f1WoKJ1ciGIxMuHBj6o23htu4LCjWBE5AFXRKYbPtYAVr70ka1U4biB
	MHINY0aGT5QHL1SDAfhTbe1GNFPmjzSWabzwuC2js2y/pBMlfvrn90Y4uUvLmaPX
	Uo2h/Z4BYJUueokBF7+spN/v28ZBoV5o/ABFzVUNx1M4+Zy9q2owJGCGBNPUi36W
	AfkEG/k55FAQDECU5zvidX/iRZHJ+OEi/d8Ia/DjAw+hV8B6Xu46RHiQAw8cODpi
	2Gag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723563170; x=1723649570; bh=k+yX1WpSaGHAt
	Yow8al5sKIJrowAE3TzPlezeIcRAV8=; b=YWKqJyeJ7p2+j964aNs1OaVnspWse
	GcuuTwlJqihYaNw8Hvs2Bf0sYNZnI3Lm1LUewLsl3WPZhfWoi2lm4AEL1or7X1pO
	VolAoRmQq30S6ZKeO8b4/vE1MR0viEXdc2D/3ypjrzK/VvdgW0F2Z+ArlDIH0/Pq
	R3HKZ5suT12diOmm5sX0aFCGtLFSQSge+R/dCvY0gJsPpHV8o2z7H381XIYyXggE
	wL5ZcpU4pn5luOmT2a8sjiO0zKLKRVtPlmMaTd139qOZFZBT++HwGTm0pNiAsvBu
	74rHyzOqfMjQUelVAQAK10s1Kg4v9/7ef8qY761xZLv/GPhVb566D2Zmg==
X-ME-Sender: <xms:ony7Zoq6fdSXEX8uZO8c4kS4sUiTa8Li3ul2AzKjS5zFaxMvaA4wrg>
    <xme:ony7ZuqETloze62z_gnUT1j85PXqdsdGV5ZR0gjct5M6zTDp9bl9Gxh-9ixc6AKqd
    1EKbKh2GfwOtOWYSwM>
X-ME-Received: <xmr:ony7ZtMr8WlsR219QwnRZiOcEDECBDt_JXCDGDxbg51hS8567oCcfpknAVJPiVdTxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkvfevofesthekredtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehj
    ihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpe
    eigeelteehtdelueefgfegleeivdeggfevudeuffffvdehgeduvefhueelhedtleenucff
    ohhmrghinhepmhhiihhtrdhgohhvrdgtnhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgt
    ohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlvghslhhivggpshgvnhesudeifedrtghomhdprhgtphhtthhopeifvghnsheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomh
X-ME-Proxy: <xmx:ony7Zv6mdm4OLY_vhuw9dICVRan_vI4oge3QeVFeLnxFM2qnitEO_A>
    <xmx:ony7Zn4S-RSTzE3YrKl5Sm7VhQcFQgDwrWtzGtIMv-sWn9uoPp73uQ>
    <xmx:ony7ZvivuIXgtFSOEC2e4cWvYFIKtWOfBeZrrUpfWx2s4H17g2uluw>
    <xmx:ony7Zh5O-Zh_eSO4bsOrvPcWWFBAMiI0kz99DKLBBCGQp7VAU6cljA>
    <xmx:ony7Zq1C79CO-hFtQABnpn0n5vhThEgI535moi3dCHdcmuHUaHgdOPau>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:32:49 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 13 Aug 2024 16:32:45 +0100
Subject: [PATCH] wireless-regdb: Correct regulatory rules for China (CN)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240813-correct_cn-v1-1-26dec3cecc38@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAJx8u2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Nj3eT8oqLU5JL45DxdwxSjVGODJBPDVANzJaCGgqLUtMwKsGHRsbW
 1AH/FYANcAAAA
To: linux-wireless@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>, leslie_sen <leslie_sen@163.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7DlHDxlDY4MoD53shscyNHKMwraC0ta/6d02GQOSNpE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTdNQv/yhm4JTCf80yr+lp4Z5LYxnkFR7M6arde9PwSL
 X2g93dxRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExET4jhf+GGWQnZ7jv8XNx+
 1/85NeXfp8UP399ryp8ZIf3tlqb8+30M/9PfFbu9k8r4WW8rcHMV18GbU5cf+Wqj3ls845BYzBI
 fFj4A
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


