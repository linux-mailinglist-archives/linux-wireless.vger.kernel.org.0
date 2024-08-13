Return-Path: <linux-wireless+bounces-11357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9795093F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0567B24D4A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA06191F71;
	Tue, 13 Aug 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="fIbQ60DG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmSI0o+e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6751A0727
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563496; cv=none; b=DrjFTg4SMtZXglkP7VtuOxxrUUJEUKfwwdVeiQMxXgRMq5FUGnd4LogrhyuD4ez2OgFYuVXygCMsz/BXfEDA/ufzQFw7e1bctlMWpHNXvrVtdd/yB7iE11j7bPAdCx/bCxj1o2U3hsXD6Q6gC2bdesKz/7DeJGnl1VKR7i8cO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563496; c=relaxed/simple;
	bh=J13lGijdSeLxgZZPmq/ZiwWVXQqtvM4P5RP4NliHR18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPR5SsuPfXQdhSC1IeY92imHP5Qvyxlicn86qa9W1sbukU4DdFhzK9Q4T6qShrRJWYHuras25ojlCjlDoUv3Me7VoMIC+WPn5DFYZKPf8VykmBy6clhmluakxOq7N+XzVAvwncDRWfiKXsKLVi/DeMzFAv6mHGM/cK97cYQn5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=fIbQ60DG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmSI0o+e; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 96B18138FC5D;
	Tue, 13 Aug 2024 11:38:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 11:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723563494;
	 x=1723649894; bh=Lrvl0YEiKndyJlll9ipNEdp6iHkTK7p/3MoWqs6NXqs=; b=
	fIbQ60DG0iJse+U/Ve0xTRgmTtjeVC4+DJuWT76XL2k3DuxyuIttFHXarcjnBtti
	rh3KougnEd20mLVsgoZpWT8S01wmY29NBIBGpNhbfRFxifTq/oyLbAmqI2A4e9Hd
	cw2/aeh4KxV9d+W95nDp1TN5lp9smJTwFJAgYH/qmHq+Uh43mjiit9XDOnQfshBr
	lmkOGuVkpzyM424BdA4BSpOhL2ErrCyKpq5zugBx6U1aewcPs6lD/QUqkF96Qtp9
	HGsVR/ys9T+MmxdYABV9k8HYtY1A4+51BVgmFfiPxoDdHHRePTad8VhhN+Fpn2+d
	4wEu26079PYQLhEkdb+zeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723563494; x=
	1723649894; bh=Lrvl0YEiKndyJlll9ipNEdp6iHkTK7p/3MoWqs6NXqs=; b=T
	mSI0o+e2qWRflaNr/X4NrxwXBy/OwZjuzsLtVBEmi2l8RMNw2n2ylVcvRFFFVEsH
	Od3aodc0cIlEodB7W7dvYFiVYPBGDbJGwk2ETA/moA6jhWd5wJsQOeqj29VYT/HP
	wfR4qVp2QBzZe5yKqiQg7Oi/yIkRZzjNd9uITPyZlxm5PrEESLkeuLqL/cf/gn6i
	Hjmg4snZC/MbRHbCI7N6lXPqZjRwQtg8EL3lSilMT+Pwisx6RWX9UgM2xifRexCe
	X3qwDal3fgE3UmjYSZpKqL+hpC6Lav7A66BmE67A6D895ed/qrM7fsVEQmOcXhyg
	SgxcullG20X8YWIrCJFHw==
X-ME-Sender: <xms:5n27ZkK3ViroQsjdEzyl8Z5-4f0xtA1i6jokoqZt99le8tV1gbS9LA>
    <xme:5n27ZkJvX2SakYGd5Tcc7GMYDMinJYjhqHwGw5lKN1U0NOMFtc4y_2bW6WUTLCVNU
    3jTmvcTGG1vExjpU98>
X-ME-Received: <xmr:5n27ZksD0D7FFreLMUG6S5f6iUeS2tpHG4TSoTTPgXrMpzgzRlGjzZrjeMWPgmnzLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcu
    oehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrh
    hnpeevudejhfffhfevkefhffekteevgfetjeekuedtudeiheeigeefjedtleevjeetuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfigvnhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgrgihunhdrhi
    grnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:5n27ZhY1jvlnhvZwCOLZwcOs-IqV0zFj5yHUrBe2v4klBgBHVPkPfQ>
    <xmx:5n27ZrYiykXMe1f5spEuOoLd08wG1rhIcDoZ8KaQoQHjjCJHrAShQw>
    <xmx:5n27ZtDn7qazleiFh7fPDmMkGdTEv7r6TeqVKxbfnUB6y_GEdnq7zg>
    <xmx:5n27ZhYlWz7ii9rLdHSSsG35wpVzw5OPhcXxq0f7UB5zLEyPx9HFeA>
    <xmx:5n27ZnF3fn1IbaEv9BSEju17ExBuaAV42gY-J1nCUL9MA2HQoPOrWwWY>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:38:13 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 13 Aug 2024 16:38:09 +0100
Subject: [PATCH 2/2] wireless-regdb: Add .b4-config
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-workflow-v1-2-3f63f0ea9d5f@flygoat.com>
References: <20240813-workflow-v1-0-3f63f0ea9d5f@flygoat.com>
In-Reply-To: <20240813-workflow-v1-0-3f63f0ea9d5f@flygoat.com>
To: linux-wireless@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=545;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=J13lGijdSeLxgZZPmq/ZiwWVXQqtvM4P5RP4NliHR18=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTdtU/eSiRxnOCaZNAbOffC4iW1m79utNJ1/rXt/2fZK
 KPJd9mbOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiPCsZGZ68yzc4O62G4XBz
 qnPv+hMxv/MDQ+ea6TxO32jy/Lcp82pGhtPvph047+Cr6/qk/kTv3yqR2y+lmmZYZ7iFc91bw2j
 Xwg0A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Add .b4-config to provide default email To / Cc address.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .b4-config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000000..b9178abe3900
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,5 @@
+# Configuration for the `b4` tool
+# See https://b4.docs.kernel.org/en/latest/config.html
+[b4]
+    send-series-to = linux-wireless@vger.kernel.org
+    send-series-cc = Chen-Yu Tsai <wens@kernel.org>

-- 
2.46.0


