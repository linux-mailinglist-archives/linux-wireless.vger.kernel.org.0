Return-Path: <linux-wireless+bounces-13745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB2995C66
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B251C2208E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2CA79EA;
	Wed,  9 Oct 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OL0/VP7J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408BCA5B
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434610; cv=none; b=cgMFrGI/AE5ySlbIQ9tKpioNtG3yEhRs5z0UojKYBo23jR3ciwwKIEQ3wg66ak81kqubDZtk3fi7f4+6sfVxtsJWer3ktSGa+NfPBseRokY2t/WJAjdDWCn99pAc2fui+E4N6pUV1PHRiTJ2Ecwj/AYKX4fwOrSDRsibkCGdSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434610; c=relaxed/simple;
	bh=YzLnhPQ/UzwfBaI+lhgo8XVuAN/MbqCfVvmhz89Ohdw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUX0upo/EQAImHdCUKj9/b+YvFHYWy6wJKElgrdaP9BatfN9yR37KwHYEU+3HXQyIYK2coRx7d/oMImIqfz5s7604mlTr41yW21c7kyIxe4l3hmOezRCfG0KVhchGXZLzZSFhnI1I02oENPptIMjDqj0nw6uIxoluUqaMcw1tYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OL0/VP7J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990hQqhD4153368, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728434606; bh=YzLnhPQ/UzwfBaI+lhgo8XVuAN/MbqCfVvmhz89Ohdw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OL0/VP7JyVfpTjQdf20T6ISSMS4l+fiw5Rqb4r7UYZWXn+jur7o+VZOT9geZy7N83
	 p6ecLB3o8em5CJRGD7Rx4ehc7yXuZpgQNa41UbaNIScK69PXD7X3SUZjabT4Y0StDD
	 mInJyNncnXWEX3nq+DWS9CsOmXMHDX6zbTrdyV8q39rcKV+7Sx0edEBD1xA0PCOie/
	 3Ac6+Df9NPkrcIvXTpRb6RrKZAUdrPPsTogWJK5YJIOGYYSz1voX1tIxZ8cXsjyQGC
	 VJ5QXpsEejWvwyo3yWZwJLPyM0F72y0jU6lorLfx+Nj/q2jx8WlJETOE52vp1snJbh
	 lG+JjAbQK0dSQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990hQqhD4153368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 08:43:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:43:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 08:43:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: 8852b: use 'int' as return type of error code pwr_{on,off}_func()
Date: Wed, 9 Oct 2024 08:42:58 +0800
Message-ID: <20241009004300.8144-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009004300.8144-1-pkshih@realtek.com>
References: <20241009004300.8144-1-pkshih@realtek.com>
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

The return type of error code of rtw8852b_pwr_{on,off}_func() and its
callee is 'int'. Correct it.

Addresses-Coverity-ID: 1622433 ("Overflowed constant")
Addresses-Coverity-ID: 1630710 ("Overflowed constant")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 364aa21cbd44..ef1656991d0a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -254,7 +254,7 @@ static void rtw8852b_pwr_sps_ana(struct rtw89_dev *rtwdev)
 static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u32 ret;
+	int ret;
 
 	rtw8852b_pwr_sps_ana(rtwdev);
 
@@ -383,7 +383,7 @@ static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u32 ret;
+	int ret;
 
 	rtw8852b_pwr_sps_ana(rtwdev);
 
-- 
2.25.1


