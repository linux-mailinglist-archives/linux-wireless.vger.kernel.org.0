Return-Path: <linux-wireless+bounces-13742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D3995C63
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B641C2208E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589267462;
	Wed,  9 Oct 2024 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Jki9N6sr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25751C8E0
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434600; cv=none; b=B9uiW2UWTv65P79WRnBt3sTeo8I6bPcTq5fkqKc3hKRXyo/O78Dk83aOi0YCIoY2miaUxLZ23jCBUvJFcqNoYK0fSz8Kdfm96tFO/FbJj/jbN0aBT9RbNhOP6F8RXZ61rMiXgIxKxoob/8GDTvLqJCGl/aC/coiBnHsEu89SGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434600; c=relaxed/simple;
	bh=FY7w+vVAbCzgJu9YFIPfaETGWxcRscSrJmXcsYltC0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOa4eiFlv03O8O3edvEuL4DSyxOTcmI14y+nmqhF5oGsNYHgN8nkIdAt4n5kw9varjk0McVWWXpl5UMxQ/Btp3oASVj7hx6FoaUqOmUxbFusunyhmRK7qsQMkCKgP0RaVcFm+yf2WB5axf9r1zeOr2+Ku+ld6t5nVCpwrOQw9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Jki9N6sr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990hF8M14153164, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728434595; bh=FY7w+vVAbCzgJu9YFIPfaETGWxcRscSrJmXcsYltC0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Jki9N6srvGjT/722ycYn30vXQPYp1RWTY004MmVC6DzxxzdONH9QLsm3jYNJNE7S8
	 GRs/zaD/w7UuWghBltdRRhbBkwTExy6kWTv7e653RxzZNg9uqWyr7191lDB7sSZi+A
	 hZJli76qatNvKPS7SYmMmGRZoxy/1Z1XkltG6I1DVqksTfH8Wz2c0n+5c640HBOzCS
	 ksiCIqKBRgACoJ1Ety+NXioqyfwgkfGVYYa+pYWkc846sysepmJg2VAefZkv9xT/Dr
	 fb/5JvJizAi7HKmM6PFRQL1DK5eM5/ngvBufGPSVuYCrcNNnbeSTkmFZHQO17FYLXY
	 SC7RvcLEjRh6A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990hF8M14153164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 08:43:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:43:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 08:43:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: wow: cast nd_config->delay to u64 in tsf arithmetic
Date: Wed, 9 Oct 2024 08:42:55 +0800
Message-ID: <20241009004300.8144-2-pkshih@realtek.com>
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

The type of tsf arithmetic is
   u64 += u16 * int;

When (u16 * int) is larger than 0x7FFFFFFF, the value casting to u64 with
sign-extension will become all 1 in upper 32 bits part.

To meet the case, u16 value should be larger than 20491
(0x7FFFFFFF / 104800). Fortunately the meaning of 20491 is delay time of
WoWLAN net detection in unit of second, so 20491 seconds (5.7 hours)
might not a real case we can meet.

Addresses-Coverity-ID: 1620910 ("Unintended sign extension")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 752a3c2536d4..252812781514 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4963,7 +4963,7 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 			scan_mode = RTW89_SCAN_IMMEDIATE;
 		} else {
 			scan_mode = RTW89_SCAN_DELAY;
-			tsf += option->delay * RTW89_SCAN_DELAY_TSF_UNIT;
+			tsf += (u64)option->delay * RTW89_SCAN_DELAY_TSF_UNIT;
 		}
 	}
 
-- 
2.25.1


