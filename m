Return-Path: <linux-wireless+bounces-27713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC49BAA71D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 21:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528C97A3AFF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E82417E6;
	Mon, 29 Sep 2025 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="QXEsuj1X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgmlHyFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A119E967;
	Mon, 29 Sep 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173712; cv=none; b=D/bpdX9ESUEAnsiDNXGb8uLjfyT/ScuiX+/1DPohxCjlMfiGhsqH5UmTQ0tH3rkm4DF8XPH+iq9yEfCopM1Js3rZRM/E78fkjoyTlrHnLtiBOiYoHV0cn5OUGo46IZbjkPnEqTN0NjRw2ovicWMcigl8O/uVtLOIeh2cfoF08pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173712; c=relaxed/simple;
	bh=ujDbkHw/xdsvbIV0XdkfukeD3oLBVhwFpdNItyGewBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWyiflk+QrYSOnmKKPu7gkCZjvDFH/bAdITfy4Le/trdPXi+M++MtSnpHmTKIC7t5Tt0rPgJcH/fil+Js59wIS1zmWWsNm8rjWojdDVja1XsKKuUwA6jpT5FYcgiZbqtYh2qcIr8O2BGxrmzK9mwaC4UZ+h41PRFSQCh86EfbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=QXEsuj1X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgmlHyFV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A9E5EC0170;
	Mon, 29 Sep 2025 15:21:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 29 Sep 2025 15:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1759173709; x=
	1759260109; bh=bfQKgoj9sFKuTXtBwbqoDkLJI+gJiyffPRmuhrKgtQc=; b=Q
	XEsuj1XK0ok5o6RDn6FbMiz5tz1Ufhy64qZUXxr23JT0UQ4ZR5ko4By1j1fBo1HG
	udaiUNM+iffAF3RAdJIIAWhE1FZESSzFgt/zj5F+JaKUEuAYGaay71d57hudcL9Z
	IUIKZDoUi1V29vX29F714hXAIKTTRwkmW4o1lpIxQCHSG9qDNu2Sa7pnKFisTvpL
	PEW82mO7QlBwcnRr4CKwHizcgZxPRql6jrg+YTAkuPfLgDs7GpLro4rXMeTop/qa
	Jj2QVi7JZJQl79r2/DxgQpRieZMejLwdrJXuJqiOKmP8E4oTLcVpUCWR8RIMmFkH
	XDidxyySGep6F7qyK3yaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759173709; x=1759260109; bh=b
	fQKgoj9sFKuTXtBwbqoDkLJI+gJiyffPRmuhrKgtQc=; b=HgmlHyFVsQtqRHdfg
	nnTkHgq8pVT/703XJvGcMGpQGSrhNrFoewFvHoE4E+SEoXwvg8vqMs9CFp5AVvsq
	WpQCNVDbshXiMrszVDLwe7TbvOoiXz0EGdM4C396ytPMum0NXwjSHVi83AQPL5Fa
	C2O5r2tsQQp0HOXhW5K1BFv+jPCIES0qcY/Za8W09eNz92YhgTZK6fS+ltzeF9Vh
	vG8rZ/8b6RSx1zdL4qlv2ynsoYcCv2AxjoyAwrhb1guZ43ZG5DVI8BenMkQUJZ7F
	me0LHnTAYdNmMezOCFZag0e0G7klsMpR87EEtwdmwOwrep0ptGQquSgFSGNazXAY
	p/aug==
X-ME-Sender: <xms:TNzaaC4TNlQkS4doqlyd0ucV2hJ9LZe21LruayHQT4SoTvqa7VakbA>
    <xme:TNzaaE3YpQaY8HS5jX5NDd-I9uWsjEtU6ZMHkNJZCvtNHbx2_050meXQPbfq17Nb0
    geyWSI9P-t1BFWPXWQ1Pup0pgZysOve8YfJkx8JTZMgTg3GUtC2I8Y>
X-ME-Received: <xmr:TNzaaNCOJ1jnkXl0uociQJPCDth7P2e4e4blxYmFRiseY3UKhO_YUdphKVAZfHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghrshhonhcu
    oehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtth
    gvrhhnpeevtdelgfeggfejtedtvdfgkefhuefguedtkeeffeduueduvdeiuedtleejvdfh
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhq
    uhgvsggsrdgtrgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdprhgtphht
    thhopehjjhhohhhnshhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghthhduud
    hksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidq
    fihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TNzaaPPvVxKVDzHu4qWCm3xqLRPONgJa5nIh2p4dex0gk7iWxZGJsg>
    <xmx:TNzaaCbXzAedOiNXkBZAVavcHL5MWE-m5CgU3DP2QoOmORHWlK0l4g>
    <xmx:TNzaaOsueYrO-BZwkIXiP1Dqog3nTGM3JPhr2JmaBTEkk_Rw2OjQOA>
    <xmx:TNzaaEPr2UZerHWnhKUBo9BJp3UZM3eiLvKYuEVY4xBzDkSk6oZBNA>
    <xmx:TdzaaOoYBrfZ47_QNhXSi0-3gff0j-bnt1AdM33PueMXnxDPphjZsfxB>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 15:21:48 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: jjohnson@kernel.org,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk table
Date: Mon, 29 Sep 2025 15:21:35 -0400
Message-ID: <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
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

Add missing ID and some extra platform identification comments.
Reported on https://bugzilla.kernel.org/show_bug.cgi?id=219196

Tested-on: P14s G4 AMD.
Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
 - Correct typo for T14s G4 AMD to use correct ID. Sorry!
 - Added in Fixes and Tested-on tags correctly.

 drivers/net/wireless/ath/ath11k/core.c | 54 +++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index d49353b6b2e7..47522fa186a1 100644
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
+			DMI_MATCH(DMI_PRODUCT_NAME, "21F8"),
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


