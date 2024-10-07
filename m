Return-Path: <linux-wireless+bounces-13627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7749935D8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEFBB20CEA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FA1DDC19;
	Mon,  7 Oct 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WplmWmq4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD861DDA3B;
	Mon,  7 Oct 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324957; cv=none; b=ky1Ehy3GhWhub7TclFT4GHw4kAg3Sum95p35OevOqPumqwmF8BfxXpGPv2CIrFZRSYifb5KG6ErRUaStpRPxwTSzcQSWhoXWlvpjB/CKQ4u0ycQ9z05ufUs6rigU0Sa2KAqegiTsORd/thIVvYnuag/V51Fzh+KIerHzred7QV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324957; c=relaxed/simple;
	bh=/EkMCLx0AbP10BCKySQUIgQd8w6wQL20RgEYBd7heQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0LuUZyElVfJQVbEL9IGVZzIJ0czGvwpVFkk2PP775zFjXO52+2V5agpKHuOC+KUW9KCoNGcPdL0OocnjUW4y0UYezUPqIiemv6HDGOXkmn0s2U3dChIjh+N/zDgexK9D/YL7rMWVLsCd7upof8Qi8L/Oeqc9kbyPe/+6txZE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WplmWmq4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L/qJQRiy1F0iW63iLg2xKj6+4X+m0wja3F7ZSKNSsKo=;
	t=1728324954; x=1729534554; b=WplmWmq4t8tMfinw+Lv8YxvClK6/RiwUt8rg6xrlf45b/2C
	Nr48a1p9vVTZ8fompag3mgmvKewFkgz+RiOyl8I3O0KcHfeBD9jDFSFfmh48o9OfTdRmIreRgj43I
	H8wtMG3K9BxPRKSeWYYWKuu/naiXyC/3Kz2ghu5ZHlA5EuxmMOPQDOR/LRuKPFiIIrxHY3bct0NXi
	XiLTwJjEdRWvAyoJUKvS4QSqGnYJVRVr1ZWw3lS+mcZyYvax3Y9P3Rdg7zTXy+dCZPsjR8gr+6cXz
	dgzp1i6/qSnySLlRSDhQg8eEcuYx98oNMMGXZR3ObmFYAgxdd6CH1f/kcbK7DTBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsGt-00000003TpG-38rP;
	Mon, 07 Oct 2024 20:15:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] wifi: mwifiex: don't include lib80211.h
Date: Mon,  7 Oct 2024 20:10:52 +0200
Message-ID: <20241007201545.74be9cca3eb8.I47b2e8e2d09c0a0be1f8346478d3d908b4021abd@changeid>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007181545.63207-7-johannes@sipsolutions.net>
References: <20241007181545.63207-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This really should never have been used, it's ancient code,
but then the driver needs its own define for NUM_WEP_KEYS.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/mwifiex/ioctl.h | 2 +-
 drivers/net/wireless/marvell/mwifiex/main.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index 516159b721d3..74747d3a379a 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -8,7 +8,7 @@
 #ifndef _MWIFIEX_IOCTL_H_
 #define _MWIFIEX_IOCTL_H_
 
-#include <net/lib80211.h>
+#define NUM_WEP_KEYS	4
 
 enum {
 	MWIFIEX_SCAN_TYPE_UNCHANGED = 0,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 566adce3413c..366590236ed7 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -19,7 +19,6 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <net/sock.h>
-#include <net/lib80211.h>
 #include <linux/vmalloc.h>
 #include <linux/firmware.h>
 #include <linux/ctype.h>
-- 
2.46.2


