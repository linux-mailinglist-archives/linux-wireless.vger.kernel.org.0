Return-Path: <linux-wireless+bounces-27709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D93CBA9D65
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62497A4AC6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F0E30BBA5;
	Mon, 29 Sep 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="qwjyo2QM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFMOEHwR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22730ACFB;
	Mon, 29 Sep 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160765; cv=none; b=AOucTVBPPpaIcN41CNF8e7I4QKoklBXaA3KwOmcjct2epZZpQknQ2QMNBV3yPSHLdCdf4p04HPoQFpLPKyIdxWZf7+dg4ezBlc+wLwhQx2OZZhwvujnstxlDttgJhKKvU5GeArYEmPfI1bn64Zly9up7VewU8sNe8T9V5X9g6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160765; c=relaxed/simple;
	bh=fdJU7/rAkC3Jin5ZCdOTV8sRbt0d4RYheJqpv/mxPWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfBMq8XTN8gpxdly5+3H8f5EydfZCiXEAf+X6OoNiMDSbzlHEqX5r0o/8YSG+SY5ddAviFDO11rHdqiZDqceA1CXtY3Hh57tsLolkVZ+8zoTC+/4Ci0o4ML3AU/DW06jRnIcWle4SesSsQj/qyjmomJlB3vA8NHmheyCgmUYNN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=qwjyo2QM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tFMOEHwR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADC2E14001B6;
	Mon, 29 Sep 2025 11:46:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 29 Sep 2025 11:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1759160761; x=
	1759247161; bh=OH9gS0WyF6Y5N3hZ19bcz7x/JgfGUQ35qPgdNIfFgk8=; b=q
	wjyo2QM+heQYr3gZpm2yOe8ZgxjiTyWgfft9CZAuVPgPa2p7VyJ0yAKfrIR6H05W
	eNXA90ktIVsKnHaJWiijJ5jM8+0K7PwuoLMGKRu8o5bolcrQWGxNn4tU/4nfs7UJ
	yTn+Aq/m3nIvpQSqC4waFqEzElRY2wvo8oBLboIC/KFhXWupGR1hRARn0M5dSyLR
	sFVPW0S0vmiT+E9IaLAOWKMWRx3lBe1b7oxzBUah0LhRQ7zH1IU8tSYvrp3eFZa5
	4eq9v1DPIOcuR3OfSayC+A7YVWNdBjpAPjP4Jqp8+F9kvWWY3ltGXMY0vo3ytwUc
	btKP6eFgGNF7+Cv1ZWiyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759160761; x=1759247161; bh=O
	H9gS0WyF6Y5N3hZ19bcz7x/JgfGUQ35qPgdNIfFgk8=; b=tFMOEHwR1o+E/B6Hx
	r4JGBMAiKC8LyZTZqs2iKnRU0+IcehmDgNOW01ayHqhfjmycvJTvVA0uV+R3k9oX
	nUx2Zn75Hmd8drhcvZt1IJW0tb1ofV49UxZ5stX9GUPWWcTeKrOLrVz/LwzcEUhc
	l7EguD/xNmJtEm0jQOV2ZxCZ07Vn9nvPG67w5V+UePv1/UnlP4Mu/n5v9+UtaULX
	j4etLq77UaojNJpW47nVY+Xxg+Sedqf0QFoz+q3Mw9eHDge/+MQw143sX4ibJM/K
	mt/9d7HpJ0jTMEdx7aJ7jUEt+cbreq5Bdl/sLxxq5nGe+4jLDdCPeoVTn6xviI9j
	L84jQ==
X-ME-Sender: <xms:uanaaPJeXUVgMwxbOnCAJX1MU5TSaEN1RV3NED_A8ryN_h-No561AA>
    <xme:uanaaMEyI9MRiIha3ssISZq_8qwWPYZqNmEG0WKmEvBwL4k-frKZnjGTygtkXMVun
    hYTqUf8YIfRBJ0pnbu0Rkh3XUk5Nn2p_s4NzAQwkKMv6-EGU5NpZeE>
X-ME-Received: <xmr:uanaaDRKuwNg09E3hXVMoZXZn3tZTPUx7WtILydYTK7K91j7APg21IIm8-T-4wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghrshhonhcu
    oehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtth
    gvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeuteehgfdv
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmph
    gvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovh
    hosehsqhhuvggssgdrtggrpdhrtghpthhtohepjhhjohhhnhhsohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrthhhuddukheslhhishhtshdrihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:uanaaIeRylIWtEDvv1KMsX0le7yrxgUI5MBHZK0V5BzFmjtW5M2knA>
    <xmx:uanaaCqbNsItPrpVTLs6-6dMWCFszFq9g-n1vqcDQUoDE4wgnZa9vA>
    <xmx:uanaaJ88TRtSDZeNK8sKw0WxI3tKG_TTGGCjtvxiMkFW1YK83Y4k7A>
    <xmx:uanaaOd4Yy-vSz3OFuBTVyL04QOy6wMh9USyNMsoT0g69rivru0QDQ>
    <xmx:uanaaL6zzTymZgwFTXU8GQT75QXETI0IVVTTBH4z2_h_Ur9yHesG-xrR>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 11:46:00 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: jjohnson@kernel.org,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath11k: Add missing platform IDs for quirk table
Date: Mon, 29 Sep 2025 11:45:47 -0400
Message-ID: <20250929154557.1530818-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo platforms can come with one of two different IDs.
The pm_quirk table was missing the second ID for each platform.

Add missing ID and some extra platform identification comments

Tested on my P14s G4 AMD.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/net/wireless/ath/ath11k/core.c | 54 +++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index d49353b6b2e7..ff8d016256f1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -912,42 +912,84 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
-		.matches = {
+		.matches = { /* X13 G4 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J3"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* X13 G4 AMD #2 */
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
 		},
 	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
-		.matches = {
+		.matches = { /* T14 G4 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K3"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* T14 G4 AMD #2 */
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
 		},
 	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
-		.matches = {
+		.matches = { /* P14s G4 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K5"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G4 AMD #2 */
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
 		},
 	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
-		.matches = {
+		.matches = { /* T16 G2 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K7"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* T16 G2 AMD #2 */
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
 		},
 	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
-		.matches = {
+		.matches = { /*P16s G2 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21K9"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /*P16s G2 AMD #2 */
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
 		},
 	},
 	{
 		.driver_data = (void *)ATH11K_PM_WOW,
-		.matches = {
+		.matches = { /*T14s G4 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /*T14s G4 AMD #2 */
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
 		},
-- 
2.43.0


