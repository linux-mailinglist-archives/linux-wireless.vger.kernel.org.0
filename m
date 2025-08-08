Return-Path: <linux-wireless+bounces-26212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CFB1E1D1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 07:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5431518A139B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 05:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB78204C0C;
	Fri,  8 Aug 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="oYqLZcy5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BC1F4C84
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631901; cv=none; b=FgAYVdBGWovPVVwePfHXJ8esLhtkDcIwZ0W/MIaWLa7TWouDVpFmm0MbMCe0TxZ+OL55suNZ25sE4+Ithcz60XJ/yznsdxHnClQaokUERiVKMfBBVHkv3zyfJR65fK29vRitIo1K6KrOu7j69FvIsruWlhEMKdI96Ks0XZNCamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631901; c=relaxed/simple;
	bh=FZfUcVWCj3I2r+zl2/DkcarFQJD7ycsvbbR2LoWlsT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oA01b5P4GumpyUsHW8IpbLxuLvI9PaJ6x0JHQ8+zFD3C0oAQJrLYialABSoSlMXBp6CwbaSlM3bO23y58PbPZrSHwgclvjF9dMeDrkIuK/yGpcsIVIGPWXXKQM/J6TPdDo0MIfiNFF+q7h9gTa5RANZVmqpjyhXhS4Z1WrPRNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=oYqLZcy5; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 5F5431006D5B
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 11:09:29 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 5F5431006D5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754631569; bh=FZfUcVWCj3I2r+zl2/DkcarFQJD7ycsvbbR2LoWlsT0=;
	h=Date:From:To:Cc:Subject:From;
	b=oYqLZcy5JnTck7cxlqcD92EA4+qGyIiQALGz6T4m+qpJgs+lOvX5UJYF+Pl7J7Kfe
	 wF4x/uYYP+Tbj6pN5tsZKzNdanQhi9qLeXlPyUG+yqTzLPI2Bv9HM+IQW84pFyRq4H
	 y2/5wTM9oR2ONDjUgzGccqLcDzuYdxW5CfFKqzH8=
Received: (qmail 17226 invoked by uid 510); 8 Aug 2025 11:09:29 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.427798 secs; 08 Aug 2025 11:09:29 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 8 Aug 2025 11:09:24 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 3B52D34155C;
	Fri,  8 Aug 2025 11:09:24 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 0C00F1E814A8;
	Fri,  8 Aug 2025 11:09:24 +0530 (IST)
Date: Fri, 8 Aug 2025 11:09:18 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: pkshih@realtek.com, johannes@sipsolutions.net, rtl8821cerfe2@gmail.com,
	kevin_yang@realtek.com, ku920601@realtek.com,
	gary.chang@realtek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] net: wireless: rtw8852bt: Use standard helper for string
 choice
Message-ID: <aJWNhu9bAkcjEyb4@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use standard helper str_on_off() defined at string_choices.h in
_dpk_information() to improve code reusability. Reduce hardcoding
of repeated use of the same strings to save code space.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202507282341.drTGfLWA-lkp@intel.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index d0e299803225..b01f921b4224 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1883,8 +1883,8 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
 		    path, dpk->cur_idx[path], phy,
-		    rtwdev->is_tssi_mode[path] ? "on" : "off",
-		    rtwdev->dbcc_en ? "on" : "off",
+		    str_on_off(rtwdev->is_tssi_mode[path]),
+		    str_on_off(rtwdev->dbcc_en),
 		    dpk->bp[path][kidx].band == 0 ? "2G" :
 		    dpk->bp[path][kidx].band == 1 ? "5G" : "6G",
 		    dpk->bp[path][kidx].ch,
-- 
2.34.1


