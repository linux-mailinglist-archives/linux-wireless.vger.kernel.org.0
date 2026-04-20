Return-Path: <linux-wireless+bounces-35007-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePyhKrKg5WlMmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35007-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47847426989
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D79A53011BF5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121C2BDC0F;
	Mon, 20 Apr 2026 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BbtJEzjw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBB2FD1B1
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656547; cv=none; b=f5bn/sD0E55911vNSqVLwiGXZp29QMx1VXOsxllfHPuLDTxiIu697flnBnUwq6sHmD5DqlUZ4KfTsWNNXqP72bijKL+fuBa0tMLZmTl8F8PwQJ0sCRU02dATomF/mWGvs5NGSvQTN0c9j982mLfIiNJAxtjvtLfN3Fsw+vV2fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656547; c=relaxed/simple;
	bh=LNOQ5xY0efQmuwcIQgEo70ed5J1FgNZnrzAEDKFm244=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k68vrAF+eu9ZVUI6Uz4de6J567wp8xZP3e4UwzdgTcSd/+RWEc724mE9m8EeK2tOScyy4v1O3VpGTOl9QUcW1CjK+dJAfwgA3aRojLBCXe/fsg1Tvcb/tBIVTq3uWxsGB3NTlMMjlCEq0+Y5NsAik8G5zE9k1RObxLEryTfxhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BbtJEzjw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3gNcfD427937, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656543; bh=IKstxsktR4gQDqu6LktmpOCFTOGsK7B3YioiQV8g3B0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BbtJEzjw/uqzrSt/S9TnYfn6OK8/lrY2at8t7aRQIUr3lBkdn20s9IOlgDCpKlfUr
	 5JBXAcEJU+imEPLLfzN1mZpvUX/bhQuUpPCq4mdPDe3tws4vDYcjNAbkTnJ52NM4eG
	 J1/RUpXwJW4UblktjGbjheEyCgKS4xDpN7bX8KYAHjlgNau6dI4LRpFhluflfw4gme
	 GBTsE6TQeQYuBUylaa5QwFapC9Ln6eFvIssESdPqjQWewxS9phfyVUR18aAPz7ZmYs
	 jc+YFt/S8T656R+w5xhF4yEyfQTSOElEcWyINoblNr1DAVqGp0McxGGJ4LIAySG04Y
	 XEgWj6iYSMWMg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3gNcfD427937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:42:23 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:42:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 11:42:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:42:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 14/16] wifi: rtw89: suspend DIG when remain-on-channel
Date: Mon, 20 Apr 2026 11:40:49 +0800
Message-ID: <20260420034051.17666-15-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35007-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 47847426989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chih-Kang Chang <gary.chang@realtek.com>

The PD (Packet Detection) lower bound is set after the STA interface
connects. When the P2P interface attempts to find peers, it enters
the remain-on-channel flow to listen for probe requests. However, if
the RSSI of the connected AP is too high, the P2P interface fails to
receive it. To resolve this, suspend the DIG during the
remain-on-channel period.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7fe979e47ad5..41eefe901ab2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4474,6 +4474,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
+	rtw89_phy_dig_suspend(rtwdev);
 	ieee80211_ready_on_channel(hw);
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
 	wiphy_delayed_work_queue(hw->wiphy, &rtwvif->roc.roc_work,
@@ -4518,6 +4519,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	rtw89_core_handle_sta_pending_tx(rtwdev, rtwvif_link);
 	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
+	rtw89_phy_dig_resume(rtwdev, true);
 
 	if (hw->conf.flags & IEEE80211_CONF_IDLE)
 		wiphy_delayed_work_queue(hw->wiphy, &roc->roc_work,
-- 
2.25.1


