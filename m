Return-Path: <linux-wireless+bounces-32816-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCXCIsXQr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32816-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21006246EC3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E5B830B7C6F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590928640C;
	Tue, 10 Mar 2026 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PyL7qaRL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD63ECBE1
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129754; cv=none; b=TR75mR9T7XLuSYEw6iLn04gHuJEitvInfiSV4lzOJGo8HdyF/VD1is09kctEXTk1+BbOREU+kEOMCf6uWfYbre+SNQluRyb2eOumIc2GKkEDLpT/HzCAltWPeO9xVTSzDYYNdsuMS1/BQZ5LxH6Se7hFvoSaghDUdRIyHYHpTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129754; c=relaxed/simple;
	bh=SAV2Os7YLYc7DWFgxO19KqSMCswQegZ4lc26CMippDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDTRT5jhHOE9iF6KyqpGL5+BSQesOJH7NrAbHcVnntQQenj95SnvmHNoYoCj+IQYtpfeYEpXUVqpqhXWaYHmqCb1LiRwjBG/puzWWOLGCyrvJaNtWzHp2qxILchn9C/cK5jOH4RdZZkXdzTqLTQz2tbBuJ7SZ4OhZPuwBVcMq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PyL7qaRL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82Vb942210622, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129751; bh=cKiXX9QCjPdLCfJNtHWVpx3+nJg9c24+AwKEg7mhJzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PyL7qaRLW+njS8a6mHXEBOwIMCu9W6RZ0iNGuPCVPCHkoUDSUyKZHHCiCl5e/F937
	 XQtIxe13hgmljlubclR2UfYwmBaw87YyKp0iB5HwtWINoxMsn8NnCDLmAjU1Zha1PD
	 pjHTTqKaa9KRuT1Tbj2mBcPNh3VYT3sTnZppwK5xJphG2E7FBgkyH41VHXEHdqOQwD
	 WuwuqKBOLFz3l+d0+aP9HHmpTaAzyKEYShWdICgLtoGvr3hqAb8JokxmxLptObIi8R
	 ExetO6ggMv06671acM7fmVlKJSxxRuaPjFQHIButFhp/Jlsh3D4DDekFAahWEe8WiL
	 3H9qocf6PMbLw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82Vb942210622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:31 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:31 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/13] wifi: rtw89: chan: simplify link handling related to ROC
Date: Tue, 10 Mar 2026 16:01:40 +0800
Message-ID: <20260310080146.31113-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 21006246EC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32816-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The original channel is swapped out for the target channel during ROC.
And, all vifs/links accessing the original channel will be marked with
off-channel. So, it doesn't seem necessary for chan.c to determine which
link instance it is.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 11 -----------
 drivers/net/wireless/realtek/rtw89/core.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 9b2f6f0a00fd..def9e4f3af59 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -276,7 +276,6 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 		}
 
 		hal->roc_chandef = *chandef;
-		hal->roc_link_index = rtw89_vif_link_inst_get_index(rtwvif_link);
 	} else {
 		cur = atomic_cmpxchg(&hal->roc_chanctx_idx, idx,
 				     RTW89_CHANCTX_IDLE);
@@ -389,7 +388,6 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	enum rtw89_chanctx_idx chanctx_idx;
-	enum rtw89_chanctx_idx roc_idx;
 	enum rtw89_entity_mode mode;
 	u8 role_index;
 
@@ -419,15 +417,6 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 	if (chanctx_idx == RTW89_CHANCTX_IDLE)
 		goto dflt;
 
-	roc_idx = atomic_read(&hal->roc_chanctx_idx);
-	if (roc_idx != RTW89_CHANCTX_IDLE) {
-		/* ROC is ongoing (given ROC runs on @hal->roc_link_index).
-		 * If @link_index is the same, get the ongoing ROC chanctx.
-		 */
-		if (link_index == hal->roc_link_index)
-			chanctx_idx = roc_idx;
-	}
-
 	return rtw89_chan_get(rtwdev, chanctx_idx);
 
 dflt:
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 05f8ad6d3034..01573150ab3c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5170,7 +5170,6 @@ struct rtw89_hal {
 	bool no_eht;
 
 	atomic_t roc_chanctx_idx;
-	u8 roc_link_index;
 
 	DECLARE_BITMAP(changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_CHANCTX);
-- 
2.25.1


