Return-Path: <linux-wireless+bounces-11356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56C95093E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FACB24C0C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571FE1A072C;
	Tue, 13 Aug 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="EvJNuHGB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Am+hWlBZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4D1A070D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563496; cv=none; b=gO55j0cMhPhVxkxl4vv+GjafqCtmLEIO/BzT83OGBPml/IRj20vT/wyzBvGxjxySHgOxb43LtVV9HiZSONRzbKiQHbiG8Et7v2zW9uDSRgwYK4PJgfcygx487egN/Ne7GBVvsq3AVX2++xdWdbE8H3rAWr4KS3Gez1sxytb+5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563496; c=relaxed/simple;
	bh=WFEja1uNIEQQnHxNCRa/a5OW659QANnd9J89AeXwSxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlXRU3qma9agTL1s+Q2cw+l4xR/0szASg8sscnUn0618DViWFQa4fiVRlHRhqjrrCjXwxRzQo9Ys9kK72MiEzBBlkOev0yEBVUlBxc2fghuFKKJjto5vWk8MINkrdSFkljCCYhj38m0BFGttWs7X3zk84HkZ9IYE7zqZsGGjgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=EvJNuHGB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Am+hWlBZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id CB1B2138FC77;
	Tue, 13 Aug 2024 11:38:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 13 Aug 2024 11:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723563493;
	 x=1723649893; bh=A1fA0wCHKHB4VAu8A0xNIa0V/GUCD3lKKomB1JL3bD0=; b=
	EvJNuHGBi7rZEyEGD5GVkX2pkZsrQCjeiuIXLRIIr962qRrs888Atnf7INhBDUb8
	cbjah7edIF/2dQutY7GxV39gOAJmKVGSxfLqVaUkK4X6n4cmeslkiQMyN2j72VWm
	WZqfBKP22YIb0i+MxdZvRG2c3O9S3qD/2Kdkuh+Kz0GC76efELYCNcJLYtpat0q3
	Q2eRuEu3mJhxHjoSSsdr4Y/ZPHs3lwWyiUn+iIQgTzDdpG1+6Gzo9zYVgbmFut7b
	yPlYCbI2kJwNJGVr1vmII7GJEzO55NOynnByTY/3Si6PBLeVKuWWB4aJNaYj4yh0
	rcqCxAOBYfYgJDu4oMHthA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723563493; x=
	1723649893; bh=A1fA0wCHKHB4VAu8A0xNIa0V/GUCD3lKKomB1JL3bD0=; b=A
	m+hWlBZVx5Uap/TpAuuXqUkmYf5QMEnyolRwTs2f188ilC1nZgnRIwGf/h/9sX3C
	BXxSpgk1qs1kYWEa/+kTxQuyI1jQH9T9TqLiJFOeToDywAibL8r1l9vXLqTaCrHI
	B2D/brZDCXLACG1aeetFjvDu9//xXmI521Fo0AM4bhn6De9VAaNmzOdEkUth3g7M
	TRBBNOpUrzfd3qXXnHz90ZzpEKYgUQXJEY5voYXUoBYpbN3Hf1UHfpZC9SFnZyzq
	knLp4/fUoSFgSUZXcRIrc7sJmFyQSvI1EtpqiQuVtQ+DpPKWPfz8lSDkxqmDEMZb
	l4KVnonJDL1gpPyZpNUfQ==
X-ME-Sender: <xms:5X27ZlZSPc04AkncpVxzsUmIGczGiC7h0veUD9hOV8Z4uJ29P1jdbQ>
    <xme:5X27ZsZuUz6tEywkVecKwCiK-0EqJDepFL4c7qzY4Id325-zSujsiXiI5np29j72W
    aRhKHwFRxrC5mRJsxU>
X-ME-Received: <xmr:5X27Zn9m9Ei5TPeWcHPIv3PLAnLKA-vlBFRr8PEXpdXHp73QnDxVLVOsO7I-qTtDAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcu
    oehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrh
    hnpeejleeluefhjeelteeggeelteevgffffeetiedttedvvdekhffggeeftddukedtheen
    ucffohhmrghinhepkhgvhidrphhusgenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlih
    hnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peifvghnsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghngh
    esfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:5X27ZjoqHYgb6aBmRgHBtNzN8Vmk-dLIdaYmGl_qv65ymM39NwsF6w>
    <xmx:5X27ZgrbFp5nbrDaxkB4iEHA2waNQnTYvQipGKrxxoRU6Bu4TF2vbg>
    <xmx:5X27ZpTbpPIonWaEOFVO2KQuRAqqbym7fAGvkcSm1qVsX6fWkm2stg>
    <xmx:5X27ZooHhqQ_26p4yv7Yl3K24-3qMvGUg70B1YNtO79GJPPtbPKNOA>
    <xmx:5X27ZrWfrTn5V92D7G2qWjof3m1rMiczjlpRGtf8TpVA5nCfvS9ljW06>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:38:13 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 13 Aug 2024 16:38:08 +0100
Subject: [PATCH 1/2] wireless-regdb: Update .gitignore
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-workflow-v1-1-3f63f0ea9d5f@flygoat.com>
References: <20240813-workflow-v1-0-3f63f0ea9d5f@flygoat.com>
In-Reply-To: <20240813-workflow-v1-0-3f63f0ea9d5f@flygoat.com>
To: linux-wireless@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=506;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=WFEja1uNIEQQnHxNCRa/a5OW659QANnd9J89AeXwSxs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTdtU+MlF8Vh74RP7Xm8gRZA06f6oXZp7S+CFTcKPtyR
 XztBMm6jlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiItTgjw6/rHX+/1xoIrJ2g
 xrVBdceBNaqHvgd6RMota/8xR/3Yzu8M/0xWXfj3oqL5ghaHzApmk5BDD7WmKic+eef+ebedtPH
 uOwwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Update .gitignore to ignore Python cache files and other
intermediate files.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .gitignore | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index a59d40833aa0..496247bfdbd1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,9 @@
-key.priv.pem
-dbparse.pyc
+__pycache__/
+*.py[cod]
+*$py.class
+
+.custom
+!wens.key.pub.pem
+!wens.x509.pem
+*.pem
+*.patch

-- 
2.46.0


