Return-Path: <linux-wireless+bounces-4083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0B869045
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B41F26369
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239891420C9;
	Tue, 27 Feb 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c77viuDl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F0145B3D
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036362; cv=none; b=e3Mj6OmIYsRNgcpRZ2Hai+d1CTs9IOmFxAyEfpOi+oVeMv8l2+hr1TPG8xRu9Cf1D+1lo6hkIHi5bztXZlRijBNOw7Zg/4s20HUs9QB66EPiHXpf7q+Y7gnzfaoHEGX90XSi8RVqv/ZVshUnXH2+IIEF3MovFhIOaJbHKb2UJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036362; c=relaxed/simple;
	bh=BuQblpNofFIXtFSoVAR2IqO+QKBFrm+5UqSx6NOMM7I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jqRznN4l2FfDP7kk2aA91gV6XXEw2AACw2IKXezt+w7x8d3+rYxvoAtUE+uOJb5uM9/T/braPn/hqpkx70CvkRg2+o6FvblfmiQW1gWRzCEPDw8GmvXLJsFSbJwdov7MHG+t2FUcdv39EGqX3ye69xLKPrtjVTYmRc+5l+3iOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c77viuDl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513031ce058so1237590e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036358; x=1709641158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E/wiSc2z1aN/zk1ViOrhWJAnNttJ2qgcDzL0//7StTs=;
        b=c77viuDlynL2FWQc9R03/OMO81p+hZM5cBZNrU2PbjyMSNPeexAYrbDonX/1F/g1Cw
         8ZBvIziNRpate/n/dJ714vlPyg/BbTcGldViE7Ynn1cWKBHvqCYKxKMgJgr9Ho7XCeNh
         5v8hOOBs67g9fRWMB/VuBPnyF2JE+ajua0CAgbK7qtB0QBrC3dVtvxGGihkFcxrpKixm
         pRXwRqtGMZ1NRsoMwK9fUzGKA90sXhWX4WoY3pDcMxxLSkcn/qB7XFi3PhDhjYZ5xT+G
         ObcCqN5efF5cVG/sXDmFJkmo+qILX077cyCom6L+AvO0M0LicEw6gRpGG40reTLV5evi
         NFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036358; x=1709641158;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/wiSc2z1aN/zk1ViOrhWJAnNttJ2qgcDzL0//7StTs=;
        b=rNkBBGWlVepJtj+TwxO7rRVp2NhMEBDyB0Vpmcy0/hVh/Uz9pcuIUmQ+CnsI+vTS2L
         kzGH247E4BuS8jNJCeXZYprpIIwBH7Sd9d3pSY8bHZWjVNt8AfkW8n9wpMfMRCznUe3Z
         nujtRHS0o9kqY1/AFrQmr8cA3Mhp97gCkN4+eATETsm9sughHopdA8VnKFb8xEAO95LJ
         k5sDfzg+CAplrN1qZUFeUxuWKjLwliwTswb2empBQ02Jcl6S7v8gtFzWklNxQXET+RQL
         FCmaC1DyQANRqKMGwTGc6BT7sMXW9PLotWd1Y+5Fd0zO3CnrJqbUjFIW17x5kc0MJlkG
         izuQ==
X-Gm-Message-State: AOJu0Yx19AHI4/v8J8vtKf0V/bw0CtCfIxo02rqIEosxNZ+T/5hIZlXG
	zvNsseLYjhBM3OSPyJdzxGR260IDqUHPGxs9ccKD1yGW24Yb3WmF521sqP8C
X-Google-Smtp-Source: AGHT+IG4SCMGqbTXJnpi3xk27DeNK4mIe+TUyAzAmJo7cjR5mY1nzu2t2gggz04LG7pEqACP6XN78g==
X-Received: by 2002:ac2:4204:0:b0:513:1169:af0a with SMTP id y4-20020ac24204000000b005131169af0amr609229lfh.11.1709036358262;
        Tue, 27 Feb 2024 04:19:18 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id dj16-20020a05640231b000b00566317ad834sm681406edb.49.2024.02.27.04.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:19:17 -0800 (PST)
Message-ID: <8770f25c-1dcb-48c6-9279-cd6de158dfec@gmail.com>
Date: Tue, 27 Feb 2024 14:19:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 2/4] wifi: rtw88: 8821cu: Fix connection failure
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
Content-Language: en-US
In-Reply-To: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Clear bit 8 of REG_SYS_STATUS1 after MAC power on.

Without this, some RTL8821CU and RTL8811CU cannot connect to any
network:

Feb 19 13:33:11 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 1/3)
Feb 19 13:33:13 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 2/3)
Feb 19 13:33:14 ideapad2 kernel: wlp3s0f3u2: send auth to
	90:55:de:__:__:__ (try 3/3)
Feb 19 13:33:15 ideapad2 kernel: wlp3s0f3u2: authentication with
	90:55:de:__:__:__ timed out

The RTL8822CU and RTL8822BU out-of-tree drivers do this as well, so do
it for all three types of chips.

Tested with RTL8811CU (Tenda U9 V2.0).

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 298663b03580..a3b2c57c5503 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -309,6 +309,14 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
 	ret = rtw_pwr_seq_parser(rtwdev, pwr_seq);
 
+	if (pwr_seq == chip->pwr_on_seq &&
+	    rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB) {
+		if (chip->id == RTW_CHIP_TYPE_8822C ||
+		    chip->id == RTW_CHIP_TYPE_8822B ||
+		    chip->id == RTW_CHIP_TYPE_8821C)
+			rtw_write8_clr(rtwdev, REG_SYS_STATUS1 + 1, BIT(0));
+	}
+
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_SDIO)
 		rtw_write32(rtwdev, REG_SDIO_HIMR, imr);
 
-- 
2.43.2

