Return-Path: <linux-wireless+bounces-22409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36008AA8946
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313861881FBD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0823AC18;
	Sun,  4 May 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtQyGRVt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1268224CC
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391895; cv=none; b=SdklAC/QW3BHEHntsxzcvMwClnqNDVb8M54sJg6zqlDyS/HnGRCi5wdbZg70qhsVOq2l91YpFNyNBx5qh3L8Ob0ZXxz0tI7UqMDMkFbi8D2wVj6HMx/8phNFxlz1cDQ0zTOa9GhRO6rJq58sXfD+qAbS+DNR5DlHl+PvYOdh67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391895; c=relaxed/simple;
	bh=I2KYgc+Myx3VK15cYHu/Xjk57JCiHQj01b8kSRse93g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c6Fnvp6FKKV7jKAivJ46V+m/k0WjMEJAVlKb1ouXT/mnp/FfxB6dkx4vtotz5JaR4ygpOJeUNh9qk9A6PRQ7OJEFZ1l2LZnGWAU6XcCrQWv/+15OmUufoZJpvQvEbHXn4Cb4jRwrCdnGUmB6UKywmaYNt4cRMR920P909TGBhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtQyGRVt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f861d16622so6402070a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391892; x=1746996692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EVCFQR5wD/7/Ss788JkIlEqGPkx16YFTui3Jp46J4w=;
        b=GtQyGRVthF5RQjxUwIgm4dsFuYG135JXXuWq2lhBfbiyd5GZDgcG9jGrrbp8kCVLX9
         1Gl319UgnroOeAMTMArY7sj/pGC8kPyETCOKBdrFIhFaNtQUYEtj04LiDPFMWwQ+jbin
         2LnBFFZlVzltsMjWK8KhwvcOkcGsW166y6eVOzFWZiXyd3SAtvP3ii2Qjd8kipeCOdkG
         Ke2hangceaybkGi/XJI2YbR4nFMPS7nR4/FJmsrDjkwUz03wyayukQfkxcamxABdSLtI
         OOddxxAlEp0S6SJl6Qd5DxtY/2OzyKOl6pSHyl4zuOaHvNiv/6fU5Y/F8LDIIofKzxpX
         XTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391892; x=1746996692;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EVCFQR5wD/7/Ss788JkIlEqGPkx16YFTui3Jp46J4w=;
        b=k9D1inZSQNL1YPOQC1IuXanIXjV7WfwecgSxi3+oy89J4D2lOiZyMCFc1gzk6DYHAr
         BY2UT3WdemcdJ3K6y1mdWV7fxWIipIRiiSQiU2R3zC5CD1t7mlFte7OAv79jz6qC0lbV
         jsqNVCz41lJMWp8qtPyfH3KBxBzibNAqNTxEbRqWzGguM+FtsqpgP+rRqXdpgglYyZJT
         wqQaixJswjOtOPu9xVTgv2TA7c2V/WneEZJmrwCruzOOAmbwxNK/wprDCHw94GQuvafQ
         u3Yj/WfB6CuoP3oUP6D8TsKF2fn0SwHwBgi4m0fNQe2G2dJlQC3a8T+vpO/8SRusK+ic
         4/pg==
X-Gm-Message-State: AOJu0YwL4SAsN6ISzh9O9fo/omthjXh7clT8FzrC3WAD7f9PHv7kUq1d
	fEqwisaXZfZkA5dNlke35GBrI4Ro7C8kjDluTzKu46YXO4ZuBmEBUgCNog==
X-Gm-Gg: ASbGnctG5025luiq7G5UMq/GNOKk/ffVAWrPSAIIT444nDfRffHFZbGdPJ04VZ/dXaY
	kJSHW4mpZT6sbTLPMrBfaAx/yNkEMk5EL8i+tV5U1kY7HIbc0jgoW+jG8JOjd00b3cA2Io+xRHf
	ETyYyc0gX8V020KoVCda0R/+i8cxtQ6dVaKh4Ds3Tnrk4+7cryrAPcSISt7hun9pndxU8kRtALt
	IrQA5Xo4CtFj88FIIM6SULcBbo/Vl1y9f8PUjYftGre+2y0q04CUxsEjKdBQ98xdgiy6gsazGMO
	ebwTA3KZRdcCR2fU5dnK7OtXK5n3UiC4MDqLAMfHDl/IcM+tTA==
X-Google-Smtp-Source: AGHT+IGUl+xF7EldV0gC8AXBn0BeiVyS2qCzcJKbUY8twEo/ecvlymJY+RWwUWr6SIDn0B5vNrHWog==
X-Received: by 2002:a05:6402:13c7:b0:5f8:5aea:4ad9 with SMTP id 4fb4d7f45d1cf-5fab057d01cmr4545277a12.17.1746391891813;
        Sun, 04 May 2025 13:51:31 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm4228055a12.51.2025.05.04.13.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:51:31 -0700 (PDT)
Message-ID: <c64fe6a4-b48c-4a80-9d6c-5c90fb7f7bbd@gmail.com>
Date: Sun, 4 May 2025 23:51:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 06/13] wifi: rtw89: Disable some power saving for
 USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Disable rtw89_ps_power_mode_change() and rtw89_mac_send_rpwm() for
USB because they are called in atomic context and accessing hardware
registers results in "scheduling while atomic" errors.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 3 +++
 drivers/net/wireless/realtek/rtw89/ps.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a316864ad137..1a03355b340f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1338,6 +1338,9 @@ static void rtw89_mac_send_rpwm(struct rtw89_dev *rtwdev,
 {
 	u16 request;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		return;
+
 	spin_lock_bh(&rtwdev->rpwm_lock);
 
 	request = rtw89_read16(rtwdev, R_AX_RPWM);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index ac46a7baa00d..edff9f8e1016 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -56,6 +56,9 @@ static void rtw89_ps_power_mode_change_with_hci(struct rtw89_dev *rtwdev,
 
 static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 {
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		return;
+
 	if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode) &&
 	    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags))
 		rtw89_ps_power_mode_change_with_hci(rtwdev, enter);
-- 
2.49.0


