Return-Path: <linux-wireless+bounces-16511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3CD9F5B2D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 01:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF167165D85
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 00:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F296191;
	Wed, 18 Dec 2024 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbR9+iy5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479AE29A0
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480810; cv=none; b=TpUHuNMHVC5yfEuIWWu7QbyJHJaINEFpEHmH2AX/jJe6IEJNF5R6vqR2AxGHJ/PAgwFYiEHpco1o7fHOHv1Dz7I699tRgxSabBAKctLBq+xm8XYlid3X4cOUiNTGsSjg7zN8Lz4g7sQaQkX078FCuVqHBq8FrHMSNfseyJD9lWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480810; c=relaxed/simple;
	bh=YFrnMAyfFtZa331ayGh3RBw9vMgn+T51YGp4Z+POn8w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fAGZFsQZggzbdgHI65eNhPBID8aGt/lzjjSc6lke71asV/8b20/HybwpDSbapaOw727KQjdzXDaR1ZV/BAwsrvQ0k3LpY09o8m/GWtJxgVE44iLmrxtvbntGG+jrTM3hDoumw7m2w+Plsf/+PkBVGX1rRgylQj7kDepbSMLH+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbR9+iy5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so789313166b.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 16:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734480806; x=1735085606; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6n5gHgY+iqgzlaFN0q19qbYskqGbJ8ZoOD2IP/mjS4=;
        b=XbR9+iy5kKYPCbblqGnpYI5C5qwyKTFBv+fqiZ1/N3L5DjxRknOklDul+UX1P4kmuB
         82sNwRRZYya8bxwYQN35bTBgszOHk1sLNUA4Q5nDwuqOwCCyyUoEJJQxU71L4h8VP6tF
         MXz9qNfUgD5uswqTxEfNOmFcKeje3pt5mh0+gMILz1J/1fPxu0quiXxIasezLApLqS44
         VObqae9Afo5DDeR58sKL4ANFJl0/EO5lNAJslgu4dXFcmnNlaq6LEx9kwkXFjACshfeW
         jRMmp5vLpItV5nXU0uy3oVvDYdvurM0G29rFoeIq/uLzvXf/HwbG97aI8+YEIo9dKhqx
         GfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480806; x=1735085606;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q6n5gHgY+iqgzlaFN0q19qbYskqGbJ8ZoOD2IP/mjS4=;
        b=VoeEyGRe1b9QFsFNVVhARgBmhkOfVn6MncUgMtSAvZxuLgrOe/bP+gfGl2mHu2vOt9
         8CgsGGWE3GurCv9JWwV7ugeTwlV55HOu2BRdG2fPS1LvjykTERLJtE8dPVklCf4g5g3C
         jaddaB76S751Ehl5XDpObn6FgnKVBPeh8iE8c1GEtEqHE+0Ya4ybIS3GwtKQWkfDQLF9
         iqxzdYUfOjFRhNJ98CWs8axX+tkh5zMdfg/mtK8JqUg1cO+LDSkQzl/IR00KnHDAISkO
         t1+Wpm+W2HkEVRDh2iruVUvJiHzu8qg6ooiGUZNpVn/o+zMZY+w1N5KWATko2kwm9lkp
         M4MQ==
X-Gm-Message-State: AOJu0YzL5ha/Y2r0zezCpcC9bBtp7OA+/c+5nPrqoMa/z3AkJYegxhSr
	/pDoEEsRjomA/8GANosmn508iyrlU7hHWzs49kgTPxVpnFLSfe1vj1+Qeg==
X-Gm-Gg: ASbGncvdGrR8bGX0yNBl6e3qS2nciJ208GarxCQmrD31UDfu6p6N5HtqtaRr5U4AYqy
	p7P5bxQhfsoMMhbKtEp8/xXGZROKPtG5aGmNS0Kky+jFa1bIK17XF6PxJG7+6/e68n+4crC6WwL
	Ui5lhVU4hipF0yl0mfaDWgW59NSB/5WJKputLN8se12wqbobcREbzvU7AnDChYWniS1Hb5Gbaqg
	qTxM5NvyYmvt7PSNexc5C3SaMSBbqPUDcrN0rI+OpXXVKKodRAK7o17Ju/KP5Rt
X-Google-Smtp-Source: AGHT+IE5gUQIxmh6FW86fTLyRNJDYiaFnon/aJyE9s+lLPLmqK0C5/glz1dHandZ3YbZacV21uB6tw==
X-Received: by 2002:a05:6402:43cb:b0:5d6:688d:b683 with SMTP id 4fb4d7f45d1cf-5d7ee390c65mr1881573a12.9.1734480806227;
        Tue, 17 Dec 2024 16:13:26 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96088154sm493865866b.90.2024.12.17.16.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 16:13:25 -0800 (PST)
Message-ID: <2917c7fc-6d88-4007-b6a6-9130bd1991e5@gmail.com>
Date: Wed, 18 Dec 2024 02:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtw88: 8812a: Support RFE type 2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RF front end type 2 exists in the wild and can be treated like types
0 and 1.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index 482edd31823d..d8f0ed70777f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -985,6 +985,9 @@ static const struct rtw_rfe_def rtw8812a_rfe_defs[] = {
 	[1] = { .phy_pg_tbl	= &rtw8812a_bb_pg_tbl,
 		.txpwr_lmt_tbl	= &rtw8812a_txpwr_lmt_tbl,
 		.pwr_track_tbl	= &rtw8812a_rtw_pwr_track_tbl, },
+	[2] = { .phy_pg_tbl	= &rtw8812a_bb_pg_tbl,
+		.txpwr_lmt_tbl	= &rtw8812a_txpwr_lmt_tbl,
+		.pwr_track_tbl	= &rtw8812a_rtw_pwr_track_tbl, },
 	[3] = { .phy_pg_tbl	= &rtw8812a_bb_pg_rfe3_tbl,
 		.txpwr_lmt_tbl	= &rtw8812a_txpwr_lmt_tbl,
 		.pwr_track_tbl	= &rtw8812a_rtw_pwr_track_rfe3_tbl, },
-- 
2.47.1


