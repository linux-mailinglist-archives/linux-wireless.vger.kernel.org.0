Return-Path: <linux-wireless+bounces-14762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513219B7285
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 03:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDED282363
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174C28FD;
	Thu, 31 Oct 2024 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kBBjg+Rl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D91BD9C0
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730341862; cv=none; b=snT9OZcqTutGKD77EVUNpTA31LQ5JEpXc3rT/fgpc3qD45WkBfGGZyJLllsXTI/G5GmDiFWrig+MsfTfWOSaz2N6n27PcKrOb1r6p1pspj7PDHA2XYj3eobe+uWr1UuBlPlTpy0PpOXXfszhoaK5Ed0WlYHbSmf0cMEuhsibE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730341862; c=relaxed/simple;
	bh=uorFnVsI21cQre23bxkI+Ju3qK56sBdA902eOCRRAd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DVTbvVj9BeUBTyekV9ePN++MxpUUiUqnjNG1xzo+J1O8zeFm/ic6ajQ87uxVjte9l62H5dXBf9qjVsNBiT1VQPB7INhUSUvq7NtGHgQ8R20HspU+N0MYn3DYLQSnHbt6l+OmIcQBby10TRWaG7anJnbgiwD8+dhNFKBJSuyMls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kBBjg+Rl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49V2UvGqA715358, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730341857; bh=uorFnVsI21cQre23bxkI+Ju3qK56sBdA902eOCRRAd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kBBjg+Rl54/kgkA61A+nN6u6cLGPsCFTY8uR5qAqX2HfjvhTCsRb9wPB3XIyFNBr+
	 1PXeMBfMczaZZKw1BSPO2lH6zkTu5VxkaKFgA+K4BWnNbSnu3O5aBvqR/p1iz0wbVZ
	 NIofxQvUg7U+aHb2bGbsF+HMymmiu351rmxiie3YCQu0Y2NjRvc6z6FaMr/XMmElkH
	 wZbi6LgmB+rKjGFq/MShMLPBtguzDvdRBmdAzw6wuWnRSd/OMnhfL70WfWf7aDFLVe
	 rW3qsng5dwDA87XWqFaNCOfSKl/0qo+I8IoUG846eAVibikL8Ztlwc1wfNVXWWun3b
	 LeRBjWfb9+E/w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49V2UvGqA715358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 10:30:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 10:30:57 +0800
Received: from [127.0.1.1] (172.16.17.143) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 31 Oct
 2024 10:30:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH] wifi: rtw89: coex: set higher priority to BT when WL scan and BT A2DP exist
Date: Thu, 31 Oct 2024 10:30:32 +0800
Message-ID: <20241031023032.7102-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Ching-Te Ku <ku920601@realtek.com>

If WiFi operation channel & scan channel both at 2.4GHz, original will keep
going at WL > BT priority table for a long time. It makes A2DP can not sent
audio data to SUT device in time then performed a lag audio. Assign
a BT > WL priority table when A2DP exist, to avoid the issue.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 8a65722dd1fd..544f390596df 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3695,6 +3695,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_fbtc_tdma *t = &dm->tdma;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &btc->cx.wl.role_info_v1;
+	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
 	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt.link_info.hid_desc;
 	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt.link_info.hfp_desc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -3853,7 +3854,10 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
 			break;
 		case BTC_CXP_OFFE_2GBWMIXB:
-			_slot_set(btc, CXST_E2G, 0, tbl_w1, SLOT_MIX);
+			if (a2dp->exist)
+				_slot_set(btc, CXST_E2G, 0, cxtbl[2], SLOT_MIX);
+			else
+				_slot_set(btc, CXST_E2G, 0, tbl_w1, SLOT_MIX);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			break;
-- 
2.25.1


