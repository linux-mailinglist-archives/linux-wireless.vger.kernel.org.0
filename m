Return-Path: <linux-wireless+bounces-16553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9E9F701A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F701633AC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 22:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F016A92E;
	Wed, 18 Dec 2024 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBGnTzzy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C835948
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734561288; cv=none; b=fRZKIud0pExOOcDFJS2NSj3EdRuKiRxAYQl5ZWzeEcFAkAjiu9J0GyTRz1imqHCnyYOX/1n3tIpai9QCXUTCGu6Z5aNvNqiR70DCIjga0DCu4Mw75J5aGEOmjpH7ajMJ8tllaK8Cm34Y+WwUo9uY/1Ixb1n/a1KfypMLkbnpkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734561288; c=relaxed/simple;
	bh=A5qPgCfwF0amE9jjgnUEWoMGM6d2vSeguLtLEuXbRsA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tQmAutGza2GnFzGvOqaHi6Zyjt3MbjUeNQ2M2yNmg+8qhRNq0gpq7M0YXZUQRfbnnKgKPYZRIF8mdKHimeFyIZ4LaMvcbj3A2bcE+2I80yHj1qJHKSdpDuilc2xYJoDkaeUEvupJps8osa9DQ90QTviv1D5RBM++cIp5WBW3vck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBGnTzzy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aab9e281bc0so22460966b.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734561285; x=1735166085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UC/89hyJasDnNRzp7vVO2ZMP/Krjl65TO8/+3e7IHBk=;
        b=SBGnTzzyUDYg5/nUdK9+ljt+zNrItNfhjTn9dieyIwSWMG7lmll1qpEj1E2p8ANN13
         8PqzA7w/38KIDNBRg/gKZywrCrS5s1dRxFGuZHAxqX+JqzZLQrZErC09Cp/F4HJnIx4W
         +gN70/CefztLZdHM9tlgCSKZGKwXlfZMqv1Wma/m/gUT9uFOH6XHqj7ylFFuIwLUyO4s
         QyRfUZdCQm9Ky7zcbSETRFhW5X3Dhj9VMvXgTWPSAsJTuIu49dm4hzO2KV49FidG3dir
         5Z1DQPULo5BQq3jDtPQSsXTUEDqYuYMV5mCNuJONstKiT2dJ18QiuXlNaBvNvBRDV6yb
         ArNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734561285; x=1735166085;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UC/89hyJasDnNRzp7vVO2ZMP/Krjl65TO8/+3e7IHBk=;
        b=gtjgI/w7SfqLeRWxcmsdvs8m5mpawJA5BKUT0hZ/dW6BeCeBlCk9NMLFVToRtIE+GG
         FSjRmARgRvv7kUMo48diLrWmf3Z3X/UroWToXqESlzzeAKgbCSadPCzhThOhsJWNJPY6
         0iUWp6+0Gjdo7YB/60wBeE1CKPCBmIcsWFzqd7riC3kn3MW4yOtUNzpMDFXDHd86/S6W
         HRyFzrVegahKeXStVVDW8ozC99Gm5MGzfVuZdkMAPYdblZhYr+gZ2lq32NptB2Yq/ils
         Hb6L3lI/i2n4DGk+jq2Fvq50/7EQKzwjzj+64UhGUAVgGToQ90AN3e8lEeVMz5AxhJk3
         eFAQ==
X-Gm-Message-State: AOJu0YykYnnITLEN+jIFGISu/KiO1wRQALw2iAdttN3I80XFE7ZNqNLP
	BTCZ0vYVj26mesY1QhNjrJyYoJrdDLNf4TbQPa8CE4uFuGiF5pCezIDaKg==
X-Gm-Gg: ASbGncs8RBrwLxDGsrHKCwy7J8mkbuzTBRmgdeiQW7zX/fDXik6OXTJwNdL9FjKdVd4
	WPx8ePVpQmok7/anieMBwTSyPS9T10+XZA6jlwVvG4BjKjQnO/5CMSAaOgtVHAX5XnmtAhnRzni
	rU7jG2C1vHFWxStX8282vxQZdPMZB4OYyVa+ydtZELYURlKTDhsz16qZ3IqBmmUzl55nMgwCsmV
	Cz2wic3Y+ZgiQLH9vzOijcy4H/MW6zBlRj82zScEY52dLgq27B0co/4UwrNsXOs
X-Google-Smtp-Source: AGHT+IE5URIzi5Q7++wdklzH8ktmZ3V8ZeHTPRoa1qWclNria/12XUfDfooxQYHI3r1MQE9f4Ev6CQ==
X-Received: by 2002:a17:907:2d9e:b0:aa6:4a5b:b729 with SMTP id a640c23a62f3a-aac079611fdmr85204866b.33.1734561284795;
        Wed, 18 Dec 2024 14:34:44 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b268asm593441766b.176.2024.12.18.14.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 14:34:43 -0800 (PST)
Message-ID: <96e52b03-be8d-4050-ae71-bfdb478ff42f@gmail.com>
Date: Thu, 19 Dec 2024 00:34:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] wifi: rtw88: Handle C2H_ADAPTIVITY in
 rtw_fw_c2h_cmd_handle()
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
Content-Language: en-US
In-Reply-To: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The firmware message C2H_ADAPTIVITY is currently handled in
rtw_fw_c2h_cmd_rx_irqsafe(), which runs in the RX workqueue, but it's
not "irqsafe" with USB because it sleeps (reads hardware registers).
This becomes a problem after the next patch, which will create the RX
workqueue with the flag WQ_BH.

To avoid sleeping when it's not allowed, handle C2H_ADAPTIVITY in
rtw_fw_c2h_cmd_handle(), which runs in the c2h workqueue.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Patch is new in v2.
---
 drivers/net/wireless/realtek/rtw88/fw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index e6e9946fbf44..02389b7c6876 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -332,6 +332,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	case C2H_RA_RPT:
 		rtw_fw_ra_report_handle(rtwdev, c2h->payload, len);
 		break;
+	case C2H_ADAPTIVITY:
+		rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
+		break;
 	default:
 		rtw_dbg(rtwdev, RTW_DBG_FW, "C2H 0x%x isn't handled\n", c2h->id);
 		break;
@@ -367,10 +370,6 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 		rtw_fw_scan_result(rtwdev, c2h->payload, len);
 		dev_kfree_skb_any(skb);
 		break;
-	case C2H_ADAPTIVITY:
-		rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
-		dev_kfree_skb_any(skb);
-		break;
 	default:
 		/* pass offset for further operation */
 		*((u32 *)skb->cb) = pkt_offset;
-- 
2.47.1


