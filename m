Return-Path: <linux-wireless+bounces-23503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F504AC8B66
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 11:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA43A7A4379
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC7221D87;
	Fri, 30 May 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="XAvHduuo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/uJIY8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DEC221261;
	Fri, 30 May 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598481; cv=none; b=ksIefUdnDlyGCmqBkSqdPoDRDH5W9hh/wtYzrcYeoxnTBSXgxv+uPoYahwsRiP2XMQjY4WdDlA4boo0yiXBvytu4e1Dew31als7WCWw0gEDl1Dt/G6RNVLBQ619rQwchbQh40HjcLvWOOePRdsG1cZHuyIvWyPlu+STvh5sIvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598481; c=relaxed/simple;
	bh=KCp9L9RQvgbaMu3LuR+jivASdFZYeTKJa0e1O45qbGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7B+MOvPetfSWtjWrV3o4BFiY2mhKS6JiZtlWNH5NVVdRsbJhFChgaeMPeU/G+anqLl3BVvvsYlIYmO9zMCu2hm2faALeltiaWRJuXK9mObLroHg4V6Vmwfm1oEZjnt5v8SDBEHgXCwBrVz9dCDSj71Y/I6mXKsDtUaiX54XcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=XAvHduuo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/uJIY8K; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 74DCE114014A;
	Fri, 30 May 2025 05:47:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 30 May 2025 05:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1748598477; x=1748684877; bh=674mFWQDtM26z7fVOMpOw
	06he7VETZwS9jREHN7/lXw=; b=XAvHduuoG9i6wfwwlX5OFTKuckQjytL7rp5um
	5Kb9I0Vb4mKmUko9mJwqKqnUYxLlsHMIJyOfDQm8iaCyOVAoWFlVurL19DxKi1In
	bLISbEI9MkIvATPVwAGvNOl/T0XHXUogF9SPp5y92hc70CwLMUTr0kn+3D0POP3s
	EPr0vHSxrfv/payVcM12B1g05UMiPQUmWmOCLIiqmKO1sGSIHg5K6LsLgDwFPHNn
	rsQGhb9a5CxU+WnaZbUNsl/xSpBlbyVgalXdlgixVN8TAZzBbsvpk3TLOUp7EDe1
	QqLx+lqVWpBEifrQ4VtAUgk7CfWb5BHfOSMo9R+Zz2OMO+Rgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748598477; x=1748684877; bh=674mFWQDtM26z7fVOMpOw06he7VETZwS9jR
	EHN7/lXw=; b=e/uJIY8KTfd8RrOjZZLLVZUrWeLm9nbXN/fnZKFZaIZjmMbB5CL
	3QUTcYmA69ZEPdlqNey/BLpjiAmZiMx44V7SbW4KjHKVG3R9tWM6tyACLKCtlBgx
	2ORc+riYAXTvODLz4c1EIRALQuHsopO5WW60oefGX7eFdSctcHlLSPEqMqPP0FXd
	0puGLIAiEVi00mg4NMJ3tJm9zo11PvHBnbLWVD7BeZEgBSiAJQ6M8R+cMII862pE
	4ZrULpVrQkFnb9B2lcoTgfGhKOq5NxPitvqUGu+7eLXcC5B6wfPs2UzKmEw+dXtY
	D+iS8uZTw67O1bwRtFpvmPXhbm/n/1AWNig==
X-ME-Sender: <xms:zX45aCu3QmM6HlkC8c57JcJy5h45Hc_I0wT7ZfBdq3NeP-cuAVVVeg>
    <xme:zX45aHe7kqEY6GJMfmraUQ5ZE5GnCpC1PJVi44FLcUJkJ7KG2uG_hrzG5udaz35bj
    BW35VmalEnef-ahXwU>
X-ME-Received: <xmr:zX45aNwT-5peNmf0vgbWHUvF_2eANamZ2fEl_6LczyROL2eJ-ALtCI7t1ME3Ac4H9_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeeikeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    ggfgsedtkeertdertddtnecuhfhrohhmpeftrghfrggvlhcuuegvihhmshcuoehrrghfrg
    gvlhessggvihhmshdrmhgvqeenucggtffrrghtthgvrhhnpefgtedvueeugefgieejuefh
    ueeivefgvdduheffveehffeujefgudfgueffudelhfenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprhgrfhgrvghlsegsvghimhhsrdhmvgdpnhgspghrtghpthhtohepiedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepsghrihgrnhhnohhrrhhishestghhrhhomhhiuhhm
    rdhorhhgpdhrtghpthhtohepfhhrrghntggvshgtohesugholhgtihhnihdrihhtpdhrtg
    hpthhtoheprhgrfhgrvghlrdgsvghimhhssehtohhrrgguvgigrdgtohhmpdhrtghpthht
    oheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepfhhrrghntggvshgtohdrugholhgtihhnihesthhorhgruggvgidrtghomh
X-ME-Proxy: <xmx:zX45aNOIcuwjA0HSZmTI2R_Qmg_2BKU8WX7OYXHvp2ssV5Fr966DuA>
    <xmx:zX45aC-YeeyX9NlyNTiXI8uaFgoG7hJPK7WAi7XskzBcYhIQEPXVMg>
    <xmx:zX45aFWiunxrQ3PvV6w6JxEZlHVEduFRS0tJEsIQeLm18E9DXPZzUA>
    <xmx:zX45aLcNSZjqhUfxIXeho5vCclncOOdiWA0mqLkSLOT5qo3y0Og-IA>
    <xmx:zX45aK1aqt4ZMbRo0vPkJrI7jcYta0nlEXqxAU_7nvnS93Spmf931ZxE>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 05:47:55 -0400 (EDT)
From: Rafael Beims <rafael@beims.me>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH wireless-next v2] wifi: mwifiex: enable host mlme on sdio W8997 chipsets
Date: Fri, 30 May 2025 06:47:04 -0300
Message-ID: <20250530094711.915574-1-rafael@beims.me>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafael Beims <rafael.beims@toradex.com>

Enable the host MLME flag to allow supported W8997 chipsets to
use WPA3. This feature requires firmware support (V2 API key), which
the driver validates before activation.

Tested using sdsd8997_combo_v4.bin from commit
211fbc287a0b ("linux-firmware: Update FW files for MRVL SD8997 chips")

[    5.956510] mwifiex_sdio mmc2:0001:1: info: FW download over, size 623352 bytes
...
[    6.825456] mwifiex_sdio mmc2:0001:1: WLAN FW is active
...
[   12.171950] mwifiex_sdio mmc2:0001:1: host_mlme: enable, key_api: 2
[   12.226206] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (16.68.1.p197)

root@verdin-imx8mm-14700070:~# strings /lib/firmware/mrvl/sdsd8997_combo_v4.bin |grep 16
$Id: w8997o-V4, RF878X, FP68_LINUX, 16.68.1.p197.1 $

Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: improved commit message, add r-b francesco
v1: https://lore.kernel.org/all/20250521101950.1220793-1-rafael@beims.me/
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


