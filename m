Return-Path: <linux-wireless+bounces-7803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFBE8C8D93
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5858B283B40
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769422208F;
	Fri, 17 May 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfMu6Hx6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18621CAA9
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980515; cv=none; b=mvICoiPbPwiGcMihawjXPyN6LJpdIVUwF4gRtByEWP5hFlzGtuLaEukjXu+KyA3W2sVqhsrS38ZuKOzw3fFSdH3dUfbhoaGKqIEnuCaHHaTp2wzGAAHCKguk+m6h7TCZM7tRvB6dR00vNVvHO3wp4zP8DeC1hUKwRkb6vK+7hC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980515; c=relaxed/simple;
	bh=N/36exLq4mBUZgL+uR2xVvYiOSDE2yGnebSwyFiSG/I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MELsX2pixilmItEEYcsqFoxYOXAhYL8DPK0owHgqhjNRnIFbuY+PzrzE0qv1FBvE0K0Bi3nK/O+3PWY18ECBjYvH50D9XomIOYah2nqZdjVy08ru+qn5ulHjrJOlpzvT1aLzSIfHHSsAaoNVph29QadplasYUT50vyHMgJyaDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfMu6Hx6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so516788f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980512; x=1716585312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7uhv22KFywiyksSinX4TQcoL6wKBthzAn+1mBtunJZw=;
        b=HfMu6Hx6SHTRiDZMBAWMUiViHEJ08WbZ3k/z84MPXkfujzPiCI23eIhindTlaGx8qg
         XZGmn61KEwhc3YY2UfjpbsLK2gv92xUvHmFUlepjhVpMX3qjcIBfHYqqxQHgyAxCFFc1
         gBTdfNe7Phg3RetlMOm0YHa8j5jbgbhgoIthXJD4tJJjJvprJDaXdmWbnSQSGhgiS8GN
         N2dCNVa+70BFDQHy8NjjNVQ79JfIhzmPn1bYlyVzWmhGXatq4GQOFbzm/sV7RR6/g/2H
         niU+vhu4+WmWPDft8jY07qh0UY/JBhG3BAkDhYhA/M7kkfXqBu8Q1lJyJscMZBjJL34s
         oWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980512; x=1716585312;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uhv22KFywiyksSinX4TQcoL6wKBthzAn+1mBtunJZw=;
        b=rRccWa+US/dRiykCXQRkbEhNDuuHsRsuFKKYTeHx9AlA9rcSxBm7RDNZpcLs6PJhFD
         6PVUBhJPODZiFR+OaJOUBNWzOAozAoW0CDPDvvpzEhPZ4DaqTDxeygbJRc8LyGna59ON
         H/SSPoSeub9piFyjAr9OeiNPni8fehldFms+PTazXEsJeVjnFEgAOZYQVt9OT6I/kcen
         ME1/cdSPr79b8xU/voHxmz9XMI+1v4bp7leJStCD9N7Vi53HAjdImGXDfZqU8ZMRTT0P
         9SPvrVpweJ6898Iy2NRErliPqwHvg36E33Ye3AfKGPUgJCJIGMb9PJ4U1vxFAM2zqy17
         OcVA==
X-Gm-Message-State: AOJu0YxiTuyOBYUHGSdbMgaRsJpjjoATnV0Hf/S7wuXmNBrWDFm0Qxvg
	ueKPCXkBLPv4tRZjQtZS3grqftgfAiDvpjsc3jOdMVlYd9Kdo20C4yeBop9A
X-Google-Smtp-Source: AGHT+IF5S2Zb/A0XTw/Wlf9wZte7tOyfX4Cw1M2jJy9glSciCO78y3sHD8/4w8VBh9S2MnP+OgjB8w==
X-Received: by 2002:a5d:6711:0:b0:352:2700:3f3b with SMTP id ffacd0b85a97d-35227004083mr3669299f8f.34.1715980511975;
        Fri, 17 May 2024 14:15:11 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bda6sm22689773f8f.3.2024.05.17.14.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:15:11 -0700 (PDT)
Message-ID: <9e515071-e77e-42ca-a5d5-59d41e43c707@gmail.com>
Date: Sat, 18 May 2024 00:15:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 02/11] wifi: rtlwifi: Add new members to struct rtl_priv
 for RTL8192DU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Content-Language: en-US
In-Reply-To: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These are needed for the dual MAC version of RTL8192DU.

The two mutexes are used to avoid concurrent access to the hardware
from the two USB interfaces.

The two arrays are filled by one interface during LC calibration and
accessed by the other interface during channel switching.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v6:
 - Add more information to the commit message.

v5:
 - Patch is new in v5.
---
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 442419568734..6a8212fd36af 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2746,6 +2746,12 @@ struct rtl_priv {
 	 */
 	bool use_new_trx_flow;
 
+	/* For dual MAC RTL8192DU, things shared by the 2 USB interfaces */
+	u32 *curveindex_2g;
+	u32 *curveindex_5g;
+	struct mutex *mutex_for_power_on_off; /* for power on/off */
+	struct mutex *mutex_for_hw_init; /* for hardware init */
+
 #ifdef CONFIG_PM
 	struct wiphy_wowlan_support wowlan;
 #endif
-- 
2.44.0


