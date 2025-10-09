Return-Path: <linux-wireless+bounces-27918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9134BC8E70
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA501A620F7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44CE2E0B74;
	Thu,  9 Oct 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdcFiVMY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6392DE200
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010765; cv=none; b=TVoD2SNEseE/34vsYxUfv5hedDrIP5fBVWcAA8mafyTAbuiex9wCwLP6P2/cpOrvSmwXPE6/p0+nMF1PhdgAmZ0BvENlGEPcUpfe7L4tuiIJmosFqpDI8DLYkyZ/TX9giCWgn7paztSarVZvtQZhBeXEGvkNcDpatb9LbWY65t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010765; c=relaxed/simple;
	bh=BV6e2QnKr1AMpC5GfbOm42i0jcGvMZZkTiGXfVZbie8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aypzAuVVhoth3y3v8uUcAvaR1GAedYVmBc5kPNunY2JyCObR49wpgbTSrc2Ee2BktEaX5BklVrDg3XeIUukeXfxf09RzxsD7zEu0P5TmrvJ8KYHb/moOwCPeKyCMnUrYMcPSa3jhnWAChJEZnaAgkb3XdAWHfxxpc/wHAU15hTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdcFiVMY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3fa528f127fso681684f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 04:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760010762; x=1760615562; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I+YrXNgE5+PJW3iwPFZwKxHZ//cIiUUBSujWDpwEQY=;
        b=AdcFiVMY8YdMM79w5388+D+O7ggQUqhOU7il2n1BbX4xS7Re2edDcM2kmoiJdN+93B
         E3540LG6MgcVouQdoPsK45hiwMIFcTSOgGfAmTF7qVlCTp7Up5nheykBzaDoBug7n7OR
         jysRq0nHCNXaXRODDoV70q7tVAl4JBtR7p6Nq0TPk+xueugAd9nk2NdozYpUMg0pWxIy
         HEpT8gIH3JSdyigbGjJQpRP2+QbbyQn9mtGTewXgMTR3p2sHEpfbu4dRB3iSzAm3l7GR
         Wnrl5eKp2VuDz/bRtapk9NS8s6YO9slAZLYdwyYXX0yNzhharDLoMPgG0kPTpbJwtAhf
         sLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760010762; x=1760615562;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2I+YrXNgE5+PJW3iwPFZwKxHZ//cIiUUBSujWDpwEQY=;
        b=HXC+DtZebTNy7HtiHuKvOjarmqKz9Kh05kwjKBnwJ0i/8gni66v9FQDUx4oOrKGNZ5
         yzr28J5F976VcoczVXoxns97NnIqXQefit8KqGCVsilHSkQG/1pvp4eEfvhomsjvG3r1
         3t3PQSjLfjbUKlD8lNxEPj39LQzb8YvpMZZ47cmPj0+nbMnxhNWS3CgxmyRBKC+sQ1mG
         z6yEOH4KS9ZujA7JXpcQo13cbxQArwJIrqWAV7rqyGYpqp41Y0QQEc3B8g+QBNFIBvu4
         aNLsEpX5WxtbSs43lC4w+DqyiA3lxvvoQTvyEHdvW0n04l924h6U/cXPt4TQyvCklSma
         eCig==
X-Gm-Message-State: AOJu0YzEC19DBqrtQ6JWx6+3n38PoLOIKH7Q73J7DMuzCzoxkHbSiD9f
	Mo7JyPx0rJoTW1a2ptRor9P9pZFdzzwrnMk+xcfIvE8iFQ/8hdK1dAHvAYskyw==
X-Gm-Gg: ASbGncvxeYWrs9el0ao69/rTVC0ELYVgfTBG3GfUeKBOMQ2DPtI+zfL89TF6b9pLodV
	1S3ATNNI5e69bDG1rejT/ymoY9UHKyipUKGcpKmsptcyUYMvA1tosG9QUWCJl3rehxatTXeOdkG
	4Lc6JkvRqGrEBUOmK7Cpf6FjjeyMXBGpT1DgRRgUMRl42le3g8EwkVAuV8KIp2bYSm+79qCbu2E
	jms6tYDoiyeXj01B4+BG0nQP0vTGOWT8yKTglsa13YmoEBd3SoYJ9mkVqy1HstXK1U/3D857Bsk
	CTNU74K9Y6HGmeK4TULJAuiYNYgGtOCfQDt7t6SmoACgl0GUnRubloJzKVYu09bkjGj1CmD9HLi
	+16kOJJb7l2zbDpKsaWD2E54OG71KYy61yJVduk4ovea6g+cPYizdbGUgRgK6NCC+Lw==
X-Google-Smtp-Source: AGHT+IH2r/Tgfhpi/OELm2tffgght5sudDfSrccYNJUqXDDEdkzqzGzF3ZgTchjnZ8VqLOdhH74jMQ==
X-Received: by 2002:a05:6000:4027:b0:401:2cbf:ccad with SMTP id ffacd0b85a97d-425829e78e9mr7823712f8f.17.1760010761787;
        Thu, 09 Oct 2025 04:52:41 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm37478108f8f.36.2025.10.09.04.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 04:52:41 -0700 (PDT)
Message-ID: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
Date: Thu, 9 Oct 2025 14:52:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/3] wifi: rtl8xxxu: Report the signal strength only
 if it's known
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These chips don't report the signal strength for many (any?) data
frames. When the signal strength is not known, set RX_FLAG_NO_SIGNAL_VAL
in order to avoid reporting a signal strength of 0.

Tested with RTL8192FU and RTL8192CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 3ded5952729f..f083429fb507 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6454,6 +6454,8 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 					rtl8xxxu_rx_update_rssi(priv,
 								rx_status,
 								hdr);
+			} else {
+				rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 			}
 
 			rx_status->mactime = rx_desc->tsfl;
@@ -6560,6 +6562,8 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 					rtl8xxxu_rx_update_rssi(priv,
 								rx_status,
 								hdr);
+			} else {
+				rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 			}
 
 			rx_status->mactime = rx_desc->tsfl;
-- 
2.51.0


