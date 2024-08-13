Return-Path: <linux-wireless+bounces-11378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6E950D46
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7041C23238
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B851A01CA;
	Tue, 13 Aug 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="gNB8VQvS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpB0KtCv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701F1A2C22
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578008; cv=none; b=cKYI485jzfoK7LglIvNRjtK/mdr+BZINf+e4EkW+jZjw2yM3wZqo6sLnVLvjXppQV4cQg+XlpZhsj647IIVWF8xcud+Pd02DXw2kU2I07c/ZbLO/OmD6DHw5iJ12lcCwkzEcb3a8Pr4fKLoqRmyzHFbbVix/khNoo+nhJ60k7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578008; c=relaxed/simple;
	bh=ml4CSISN8OBo/Hq60DJk2cXv8O2ztHe1PP/V2pFQ9Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sy8Cybmw+ssiYhu4VVwfHnUHDcJRonaHkm70TVb7JpPUXMr5REipJlfM9CqRjFVyuwq0VtWvgsI14TjvJKNCeVGBdCCqPqv4Zl/1j3z5lVgYEKLUbkXtynMu8cNWSiYlEBITFjH9UFw3vEOiF+FMVEEMIuCyI8FJysdcKfmSLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=gNB8VQvS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpB0KtCv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4D04B1388017;
	Tue, 13 Aug 2024 15:40:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 15:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723578006;
	 x=1723664406; bh=GpXFvMRZ5N0EtQmZyd99TLIessWi6IbG1yTj1xg8Deg=; b=
	gNB8VQvSaG8ewFkXGQujsrTG0ziJIrdpWOI6O+qCdaUnD6ZPxXPczDGVi+6lE0Ua
	X3DAFfCw8hoagFATd+T+2GHupcdzAyIRsHgewy7opFB36IMQrxVi0mJkAi+0Vt4i
	YU3XYgTtVLodxQHz6b2zFNLhn+cJFAGOa6DxZIxJ/njkVujoeDmkR2oDxRTMRlxl
	tlRDXhLLHHOBDmrpNPT26KBJ5Tsm4UBpv1plNfFYeErB89UMyoZJSTbBg46Zy6zm
	KIAUFlwQmAZQtRVPsZbw8HP80C3NWhoN2dtIPWt65gWcKtJLAXQdwmjBcSzS5XVs
	5ngsyj+dwlldlaOGojzYWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723578006; x=
	1723664406; bh=GpXFvMRZ5N0EtQmZyd99TLIessWi6IbG1yTj1xg8Deg=; b=b
	pB0KtCv72uHsd+Ze8Uu+tWKW4O3XGCs6nIc6k27xOP9eyfdmTZW0xU0vb6WsNu6L
	kLDPgICfDgcLFsuBJBXZawp0VKylns4x83bEzbCz5Z05/EaEQl36UYz7HFRxq4WB
	ECy+il1yEJ0Gk9BtiMw9R5Q/TB7rczVoVVfifmTTwzt6fNwIH7VbP0F83gkRONtn
	JvcdwEMN3THHtBYkrFWqXTt7AYdYSexZgM6rh5dRMgr36wdEmcwtZIpgyjRVAjlQ
	bi8icL4UACbuXTfCqOZGF/Ubex+5qg0H3qOlt3loyhqQmlbMJzRppAVFbRqFtklb
	6iQp7UULahyQgVzNhh4mA==
X-ME-Sender: <xms:lra7ZjCnLL9aF1jO3uzHAUmSPtqc9QCDyvrkhbG3YF8EKybrzlnpiQ>
    <xme:lra7ZphrboxaZC7urJ9NP1zygBoLoXhQjS152qgNh2VsiYmszlaOsVz0pX07aESsy
    QujFg3pWh1r-MBhS64>
X-ME-Received: <xmr:lra7Zum3LvdyIn2RFtDIc611r-n2ugHGaN9VM3Lx-h6adkYQju47RKxADlBKtgOcBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevudejhfffhfevkefhffekteev
    gfetjeekuedtudeiheeigeefjedtleevjeetudenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    jhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohephe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghngh
    esfhhlhihgohgrthdrtghomhdprhgtphhtthhopeifvghnsheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepqhhuihgtpghjjhhohhhnshhonhesqhhuihgtihhntgdrtghomhdprh
    gtphhtthhopeifihhrvghlvghsshdqrhgvghgusgeslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrgh
X-ME-Proxy: <xmx:lra7ZlwQzxUjRDVKZMHbClIsxCSB64iD7Tgwg0QFUEGgxE6om9KOXA>
    <xmx:lra7ZoRj8Gr-42huZhn5ptYkiQf1IXSmnz8wVRNKZrLsNdDQRnkCUA>
    <xmx:lra7ZoaTWTgXzNVmApxel60MbdwNyYu19fvfrujWO0U-J-t_AmgkJw>
    <xmx:lra7ZpTF0x6NlH8nM-au6AjofgcU32ToBGF-d7U5m_MPP7JjsM6Nng>
    <xmx:lra7ZtJSpBd05-Utf0VbBRboAzzwL5Dqeqz0AnOc1jqOL9ijzHcYi5Cc>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 15:40:04 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 13 Aug 2024 20:39:40 +0100
Subject: [PATCH v2 2/2] wireless-regdb: Add .b4-config
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-workflow-v2-2-6d8039283d45@flygoat.com>
References: <20240813-workflow-v2-0-6d8039283d45@flygoat.com>
In-Reply-To: <20240813-workflow-v2-0-6d8039283d45@flygoat.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=639;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ml4CSISN8OBo/Hq60DJk2cXv8O2ztHe1PP/V2pFQ9Po=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTd2/r55xx2v1ZlLjFB/fuTPdLBa1+/eZCmwFfJe2ZR2
 Ltvt9qXd5SyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEzkgzMiyqrF9sLad0el3H
 v4Adtx2i3yWtPqMlxcSel6YTvj3iBxvDf58LLikT+n7/fF+7TFN9r5jQrC+p3tEhTz/rS3tvnvG
 9jQ8A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Add .b4-config to provide default email To / Cc address.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Swap cc and to,  add wireless-regdb list (Jeff)
---
 .b4-config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000000..fb408d3f62d3
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,5 @@
+# Configuration for the `b4` tool
+# See https://b4.docs.kernel.org/en/latest/config.html
+[b4]
+    send-series-to = Chen-Yu Tsai <wens@kernel.org>
+    send-series-cc = linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org

-- 
2.46.0


