Return-Path: <linux-wireless+bounces-13632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA499362C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D741F2286A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06131DE2AA;
	Mon,  7 Oct 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m+9VDH9h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6941DDC3B;
	Mon,  7 Oct 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325634; cv=none; b=B9Q/eNrybUe+ISxD4GWtTML4GIpf/c8/6/KdXhTy1nc53q3fgRMw/geugm7MGj6yUroo/IS8j7R7bKkexUi7laT37vJU69/0tu43lSyTN7fYIOt4b8uFZpImL5KR/4r4NMWAW/y4o25n2t2RRlax+iFVQklJji7KVJ8t5kcjzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325634; c=relaxed/simple;
	bh=/EkMCLx0AbP10BCKySQUIgQd8w6wQL20RgEYBd7heQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBxLaVWS5RzXHeGflCdLaiS9x3V0lpW+2sikacB4scmRoGjAGzzk9Ga3zYEFAbEBbGF80eD2/k+rNf++5J3+F2tZFs9VI8jdfiWSLw/G5Ernde0cTl/FxkMm0pfqMxQouYBWhlj306FNsoUhPIyuqNbfNFlrV99L7wV2/a7VmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m+9VDH9h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L/qJQRiy1F0iW63iLg2xKj6+4X+m0wja3F7ZSKNSsKo=;
	t=1728325633; x=1729535233; b=m+9VDH9h3MCI6zJXHgu2sPiitgIAdrWR4z9RN0V7d3KPyZG
	3N/7wMYacNSzv/OvBBCvv3FAichCgwjOIWtgMWb19R8ox9E8seiOpUY5Q4dDgFCsyg+B5qLhN3aYW
	ZFKIk2coBbVmCWlCqe3bYLGOfGcwI006VibeBhhDsC4N5ujm+6kbsNy/NHNdu+qabPsZQ5OfBdT70
	5QzYMZOjoZxsuJ4gWxP22FHjlvOuu0Avvb62UvGO/llvI9EE/Kt+xpg6CgXeAMGZxoewcInr7PwDh
	tnfxrDIIdqTBdivaZeuRIRZSkaSU6KZ/WqNqQbIP425tX3f5uJFX2isxPy4yqa0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsRq-00000003U6n-1oFB;
	Mon, 07 Oct 2024 20:27:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/6] wifi: mwifiex: don't include lib80211.h
Date: Mon,  7 Oct 2024 20:26:52 +0200
Message-ID: <20241007202706.74be9cca3eb8.I47b2e8e2d09c0a0be1f8346478d3d908b4021abd@changeid>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007182706.66888-8-johannes@sipsolutions.net>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
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


