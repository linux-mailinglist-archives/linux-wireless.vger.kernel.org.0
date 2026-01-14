Return-Path: <linux-wireless+bounces-30804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7917D1BF94
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98D563054945
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6531E1DEC;
	Wed, 14 Jan 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FrGzgUYF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6062EC09D
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354887; cv=none; b=brRwwLxnuvwQ0UcZskrpmicjjzORXqpnLaJuVBYqX4G9vcEqPnVJtyCuStgn4/+ml3YpRsCEthQLuFlGEHPiP801m0CHs9s3rXR1De4UH36CI6AdoNPVGq+kVH1zVaTtApUwFZldQTomMn/IIMKZswfdzQ+Z9Ju5/tbcPmswRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354887; c=relaxed/simple;
	bh=wKtJbp4D1a4OpWWMsZn8Itj8INrtcTnohWuweUqrzMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBg9ldR/1CyTSLNfIOQJihsWIUUzuvfK2NYNx/ulKTt4aP5qnHcJiLchykiG9NttvYagkupuQNp3Zcy45U8mVyhz8ELAa9Uk6Usa9a3FhOdEaU+D+PnqU/DOg088jQUTVMNo4bzCoae2QXChaPxTOjJMKO0B0eVRgf85pqTWoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FrGzgUYF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1fMZl94168750, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354882; bh=vAB9QZfufYU/HR8k94oOHkqNieOxiK7aqrUK/SANeBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FrGzgUYFXxxHSHOHqOPAbKebQt46F2hwCjdBwZ7gL8xnNAcxw/G+WVsuZQ8T5FE7/
	 Xn+3yF4gIuITyEykxnp71qDAXSQ+bhOTgkkQ7zTyekyDNMlJwmB/mFYJdODw7zqDHS
	 To8inH43YtOkqKex0eX3gC5WJZtJHy1HtZ7B//BfeQqdX0q/YiHaQh8mPy9UmEb1c3
	 g0I3ui6iECjDIJAVwjg/rUFZGCjUvBwzhTcdctKrl3dcbbkjTatK3dZ8NIVygrigRs
	 WQs9o4n+VBHvhT/NSEkYWNZGvq9fSIw+UJMjllfG1Z61c+G2uIFLfEXfDzJAuV1pFc
	 tGGRyIeYV4zVA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1fMZl94168750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:41:22 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:41:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:41:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:41:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 12/12] wifi: rtw89: fix unable to receive probe responses under MLO connection
Date: Wed, 14 Jan 2026 09:39:50 +0800
Message-ID: <20260114013950.19704-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Po-Hao Huang <phhuang@realtek.com>

During MLO connections, A1 of the probe responses we received are
in link address, these frames will then be dropped by mac80211 due to
not matching the MLD address in ieee80211_scan_accept_presp().
Fix this by using MLD address to scan when not using random MAC address.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f09387e089a2..0691341b9c83 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8779,6 +8779,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	struct cfg80211_scan_request *req = &scan_req->req;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_chanctx_pause_parm pause_parm = {
 		.rsn = RTW89_CHANCTX_PAUSE_REASON_HW_SCAN,
@@ -8807,6 +8808,8 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		get_random_mask_addr(mac_addr, req->mac_addr,
 				     req->mac_addr_mask);
+	else if (ieee80211_vif_is_mld(vif))
+		ether_addr_copy(mac_addr, vif->addr);
 	else
 		ether_addr_copy(mac_addr, rtwvif_link->mac_addr);
 
-- 
2.25.1


