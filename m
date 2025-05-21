Return-Path: <linux-wireless+bounces-23222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3EAABF165
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3D3B22B6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 10:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF023D285;
	Wed, 21 May 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="EVT8lniS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sC1Gpnwl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49225C82A;
	Wed, 21 May 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822838; cv=none; b=YG6uComjCJkFAwzCLvYuAWgyWIBtRKJq/maG45S4B0nGW1qY6BU+T8h8Co4QDFcEnA2uX174a7TLOcwbUa+Mh0g6MzUCnJLQafSpTmCfu5pqEgqFGTb+JVyjT3s2WtoFoBTMPU1KcKberYXqKtXxESrej151/Ba90uqk987f47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822838; c=relaxed/simple;
	bh=hgO/tUb6I/7A3eZ1GUbTujtom76PxW0NEx2daJdEgWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gX+t8GLzPeMm25dWrXF52AeSdA7icBHitb02+yop7IJsRzDcDU/7Xl552DTyGlp2IvRl4KWF9cW0zo02OYAhUhbMPewr1fUnKKF5J2RH+8wVsO91FzPrrOvZ9a0hyBwDJaUglmaLterWsO0ppYYkiqpJRmJfEJv0MFegA24YqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=EVT8lniS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sC1Gpnwl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED6731140190;
	Wed, 21 May 2025 06:20:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 06:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1747822834; x=1747909234; bh=NI0XmhRBWdAqcvMsZeFHc
	aGIu0yjQa3Cy0NnWsMz3rg=; b=EVT8lniSCPgfDyLQ1Lspm/w/jYrWcwxsH0Xe6
	8ixtSSbBCu9RIh/usUv+0yDw/nRgtaZxJo192xQFhDtAGhguaIgvuVhs3/QSqZmJ
	iphgGjNL7k/9Gd25sbQFHPt8zVH3Zyn7wzcCbM7si3oSHXMux80iN8kQUhZVyb9o
	aEURQlzmAViU2EmqMXB894yKrD1s6XzPsXOHUxiepikin7ssVm7FU885bkoMtD4T
	54ObH/ur5AGebLLQqv/xpwFdTSz9sqd+Uw2jRlPhqQ4fLduWMr5n+fBIxvkTG3hA
	G81VkilFCaagqEpvx0u0aXTiz8Rwcej55KLXh/i8uc9ypIhvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747822834; x=1747909234; bh=NI0XmhRBWdAqcvMsZeFHcaGIu0yjQa3Cy0N
	nWsMz3rg=; b=sC1GpnwlXsv+sJmUWcqYB5mQdmopYM9YWyz4RZ88SVrP2NBJuyx
	KK7URAMsB+iFnI+f1V7U3u5uGTUhsWetMgLChXhmH06AnIBNaaHLhFrRpGK//6Fi
	LV5mIslWVh4HvE7h3khw7lphJFa9QHUQVPqtCTXwIW6u6BS8ucHTWvqPF7dUIF1e
	krUMsvbYVmQbpRScXyqKAuSs4jGengUITE7db8TQH2+0e2Zipw8ywU///ZzuYTSy
	96KB+ayykj79fCZXSsfZndtaM53xO+d0rtrbFP2O/T+FCLUXkpF12nFz/hbPup8B
	ulLJUg2uIXcPK8z+sUqpu6pNFDP4IHDdMuA==
X-ME-Sender: <xms:8qgtaILJWD_JFiHGSL8H3qeu7jyX4uM1raZzkPebppDEOp5h1007hQ>
    <xme:8qgtaIK0poXZPxP4LwpSNwY5q4-Bbz5oGO9N45h8rjyvaCOfzH1qkMfArdUIJJ_Pj
    X92DW22fOJWCiP5OBQ>
X-ME-Received: <xmr:8qgtaIv_X8m9g5-774kU2f3p9njcz5D7sfqQv6LYcT0rNWHv4SdUdR-y-6g5xJLZp0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgg
    gfestdekredtredttdenucfhrhhomheprhgrfhgrvghlsegsvghimhhsrdhmvgenucggtf
    frrghtthgvrhhnpeefkeekgfdvhefhfefgleethfduudeuffejvedvkefhgffhleejgeel
    keehtddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrrghfrggvlhessggvihhmshdrmhgvpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsrhhirghnnhhorhhrihhssegthhhrohhmihhumh
    drohhrghdprhgtphhtthhopehfrhgrnhgtvghstghoseguohhltghinhhirdhithdprhgt
    phhtthhopehrrghfrggvlhdrsggvihhmshesthhorhgruggvgidrtghomhdprhgtphhtth
    hopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8qgtaFYcfmDzKsVfb6NNKlJpCqH3_2zdBaYns1sEyK6wSfFtQL1gOg>
    <xmx:8qgtaPYYs1LVwecx6sScTahQSi4JCFTz3YzYfq8vHt0PCQW25ZDz0g>
    <xmx:8qgtaBBBXfa1cpepqC9CTgwrg8_AeS8Z9x7G7dTBFCgQ2bdtoV6eTA>
    <xmx:8qgtaFalhvtHZCK2cP0PDjKq9ftjw1h0Vad-8FQ4CijvNmZ_KSmuUA>
    <xmx:8qgtaB0n4Zwsg4SH8nC1jwfN80F83nq7q0W1IKGNPlXLVQbP3XUqdaTm>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 06:20:33 -0400 (EDT)
From: rafael@beims.me
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: enable host mlme on sdio W8997 chipsets
Date: Wed, 21 May 2025 07:19:34 -0300
Message-ID: <20250521101950.1220793-1-rafael@beims.me>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafael Beims <rafael.beims@toradex.com>

Enable the host mlme flag for W8997 chipsets so WPA3 can be used.
This feature depends on firmware support (V2 API key), which may not be
available in all available firmwares.

Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
---
Tested on a Verdin iMX8MP (SDIO-UART) and Verdin iMX8MM (SDIO-SDIO):
    - created AP's requiring WPA2 and WPA3 authentication and successfully
      connected clients to them.
    - connected as a client to AP's requiring WPA2 and WPA3 authentication
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index c1fe48448839..f039d6f19183 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -438,7 +438,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
-	.host_mlme = false,
+	.host_mlme = true,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
-- 
2.47.2


