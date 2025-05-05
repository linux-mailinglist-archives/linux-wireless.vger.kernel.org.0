Return-Path: <linux-wireless+bounces-22492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB8AAA220
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA616A97C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C22D7AD9;
	Mon,  5 May 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbHWwtXe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2A2D7AD5;
	Mon,  5 May 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483664; cv=none; b=lof3qJDP2kdI/u5PQwnmlxHxCD5+qjxVMfJjz90w9IlYXtya+M3HSKZJPgYSAcea9lwx0U2uMwqHsoXL7Mbfpun7sqz77ASrmUVATuCQ9Rvz10Te8HSzx1GKCJ5HPnALrS9yQpynmR8/oB9Wx3IMLK9nNsoWxUF2+W54636/yYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483664; c=relaxed/simple;
	bh=V3N9B1GPFmarQsHtIPAMBXStWUKv7ZT6DTFhLmt8XTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJhicPtJeWQpMZ+lV322zqNP5jM6+SkxaZAKN50v5q7RRNL0x1sh4C8H2SXoAf/px2pFZkaNLW8Jc7np38Kw3qPF7Y5pkzWOLtegBnpH9FvFLwDkjEDEEDXENh/WCEMWEId4Hno+WCg9So2HKR5Vyu+mgNlrRwjdIcjU9AaKmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbHWwtXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B896DC4CEE4;
	Mon,  5 May 2025 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483664;
	bh=V3N9B1GPFmarQsHtIPAMBXStWUKv7ZT6DTFhLmt8XTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbHWwtXefvuKBveh4rEWsHf5BLDusttgnK8JzM+Sz3tON77nYzDoHOzVTpoO3DTQJ
	 vwZjqpmSdD5Yjuz/EnwDZI7GDMI8coIcruxpo3pPBUKIRdFEO+T+kfoTrRcKTpV+JR
	 VqCu82aNH0hVzAFSZe5UTQ67vQm/I9u/5YWd80pp48PAK23J7omJcP1l8sJR0Wy6Kg
	 6S3fJjGTUTIVKx1q07/1mHXNiVJCA/Qgll84jX8cBk5Kr8EW85WNNhZR+oB9Xa3mvv
	 g319V3T7WM2Gq+s3oPCeBnCz9OkmiD3kCnpz6At9lZTa8cMjrJbHZpOB9Jdoca5XNx
	 /Z1udgi/EfZXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ching-Te Ku <ku920601@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 167/642] wifi: rtw89: coex: Fix coexistence report not show as expected
Date: Mon,  5 May 2025 18:06:23 -0400
Message-Id: <20250505221419.2672473-167-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ching-Te Ku <ku920601@realtek.com>

[ Upstream commit a36230aa5f5efceaf5f81682673732a921b91518 ]

This report will feedback some basic information from firmware(PTA counter,
report counter, mailbox counter etc). And the report version need to match
driver & firmware both side. The original logic break the switch case logic
before driver update the report version. It made the report can not be
parsed correctly. Delete the break at the version 7 and 8.
Add logic to count C2H event report.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250308025832.10400-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 68316d44b2043..9e06cc36a75e2 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1372,11 +1372,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		} else if (ver->fcxbtcrpt == 8) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v8;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v8);
-			break;
 		} else if (ver->fcxbtcrpt == 7) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v7);
-			break;
 		} else {
 			goto err;
 		}
@@ -8115,6 +8113,7 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		return;
 
 	func = rtw89_btc_c2h_get_index_by_ver(rtwdev, func);
+	pfwinfo->cnt_c2h++;
 
 	switch (func) {
 	case BTF_EVNT_BUF_OVERFLOW:
-- 
2.39.5


