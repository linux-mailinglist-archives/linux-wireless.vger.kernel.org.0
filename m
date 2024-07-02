Return-Path: <linux-wireless+bounces-9838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD14C923DB2
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB7D1C22BC7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC651741EC;
	Tue,  2 Jul 2024 12:25:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CEE1B16EB66;
	Tue,  2 Jul 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923141; cv=none; b=PhO5ElqUelgxmTcpm1vc4mvyQqKLnG6DozXSWXwO3HJ4uptmoXmQr1aGWq1H4h1UEGdMMjmiyVPEkDcfSahqW/XDYym2qn4Uny3CEB5zRDvPCzza0jqOgzZva0wDYKd+OldgCrr3sEjU0b68KRRHhqXv+gNTZEeLoMk8SMlTfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923141; c=relaxed/simple;
	bh=Kx4e1MpD4EQQJ0DKqYJ4N5pzOHjFrlzr5NO8css8ljM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=Hdf7xA24gnlB+4ceJvKZeU6YwAulByFDS9JUAAvdOiHylNMlssMLKxnmpyVN3qhtCtXSCfR0QaZAi3GzZnUapv7Mjer+qWfTKq8G0/Ds9XvIGp9FmgToQsNfBFpyu2A6z+tEtavUWVvhg6Fp1OqhKod0rqgaWq07le/fZP5YZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 014F56031A647;
	Tue,  2 Jul 2024 20:25:23 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	johannes.berg@intel.com,
	kees@kernel.org,
	a@bayrepo.ru,
	marcan@marcan.st,
	colin.i.king@gmail.com,
	zyytlz.wz@163.com,
	petr.tesarik.ext@huawei.com,
	duoming@zju.edu.cn,
	zajec5@gmail.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 4/9] wifi: cfg80211: avoid garbage value of 'chanspec' in brcmf_cfg80211_get_channel()
Date: Tue,  2 Jul 2024 20:24:47 +0800
Message-Id: <20240702122450.2213833-5-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcmf_fil_iovar_int_get() reads the value of 'chanspec'.
Initialize 'chanspec' to avoid garbage value.

Fixes: ee6e7aa38394 ("brcmfmac: support get_channel cfg80211 callback")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2377b88d7ee0..e672565de437 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5678,7 +5678,7 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
 	struct brcmu_chan ch;
 	enum nl80211_band band = 0;
 	enum nl80211_chan_width width = 0;
-	u32 chanspec;
+	u32 chanspec = 0;
 	int freq, err;
 
 	if (!ndev || drvr->bus_if->state != BRCMF_BUS_UP)
-- 
2.30.2


