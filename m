Return-Path: <linux-wireless+bounces-29007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD524C61C53
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 21:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6FDD4E0544
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137482940D;
	Sun, 16 Nov 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqric8hP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7620311
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763325045; cv=none; b=fnimqIfyjUX5xCGCRJ/y6kYyQuh8I0DJ0ZDcWOM/fazC8RqHUbc/peaAgXVrfR29k+FfX9pRbPNYTMlAIBXInP8SQnLs590F2qGV2HDXCH/yoYQcUpe929QxhVCW+HAzmMRrhNSwoZHFCMFkoBdNX3uYOGSbD52PW2R+M+zEH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763325045; c=relaxed/simple;
	bh=rRrqBXVFuSIvKEyRxl7F526z15z7MZMNba8xgDzDQmw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=el5FTVLHc+bmZy9HYutfDey46RQOz1vjWeEbkIL7aspodx82EhxPaDLF6V47Up+m0B/JdUGnXS20gFWpt0EhzP59ZmnIiDdvxRoPVucYylFZCkPRmrtxJlb2FJvm38Pq5TxQKyBvAPpXNUDhMPCEAjk+91itffa2IxW1sXFBDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqric8hP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so39478145e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763325042; x=1763929842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cgzbLah/uAt5JqJcxgq+1a/AJt/05dqIP3RoGU2zJtM=;
        b=Rqric8hPqszjXPLGp0SsIS6ljcrImuwKuTBHH3zRD8+twlYfnVy5ArIlQGAP5rC05P
         C98iihOqkRlb6Ax7b8XWapuN58YfyW/f0LluP/MFqF+ZCRBEqH5BA7YX0b657A3WGsZL
         3Wmoi8F5eGAopBY0C6fE2grZJZo/XhSKwINrpgiTJFMq8GDn0flrpdB5VO2JRV1wT0yo
         N3zLrdihmYHcSfz8DKfYOfutgyP+ivLJv9beOXH+MgyZQzF5Mv6+xygAJN/GgVL5LlK5
         NydbzGB3SgY35YWH0pT5lgIn7XjrpdH22SEeHAz5+k43aC6DhytbJPYtTSAQTYhfygcz
         gf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763325042; x=1763929842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgzbLah/uAt5JqJcxgq+1a/AJt/05dqIP3RoGU2zJtM=;
        b=XYLxCYY0Rr9e770OEWKJkUL3oFpvTG5eRZW4dhNgCErxf3EhDImsEIXSnUEOYokkZs
         Ti+fl16/gNb95UMx0RlvxvtvxHFKvfutYW8FeIuoLZKGJmkvwD+tvgN9sjqK/MwieWON
         NryezMr+vKzrzG1VBli3JJDY2p6ejlFwP+OvWnrvaDHzhEPPaRuJaukjEMfqAwZbSSrQ
         TWkJaeCRnNHokmL3wEpyt5mczya6ZpftjocnfC8tIVWPrMYgpHmLX+TsIyEwvMHlf2qK
         AJLmeWJgAuYwqLfDJWlKrcy0qSbhOt23CDQr83i9ayMDKV+oqOZA++8EqLXfVEVWULXp
         GsJQ==
X-Gm-Message-State: AOJu0YwednEgs5WCJyMAxprbfMyx3aclVt6FyGJCSmgEyniTkzgVSTd5
	lszOaDygYpdaT8tFlNi94SWmZBLVhHzbpobTzz6mhhkizFK2usH5iHGHfvDe2Q==
X-Gm-Gg: ASbGncsm3/sQcvzIM7Avt14o20fe5DLrkeaVSJJYgp4B7RYPe/zV3oe7qkTt5KkHv08
	zRKXpu+evQjeloCPMBPDlKXj+upysBZjJOOpKaZnBMddTsknaslktDas4XCem0AmAcjzDrHdXZJ
	foPMYGgGY7K0vW2yOfk+/uhGwy+4lZmZeYlXe3BqDBhbbWLzlwz5tqdv7bZAt+Cy/sjv/pfMWpa
	9n1lrgt79Z8Fuhmh5djAvNFYxLce4lb4yKw9bR8TUjnYhIGyAF5+k9HOofmLKUhROda0ecyckS2
	yMQOFCyEVR1EPjCm1HVSVjPGx5VLIMOxvppuEdubrHevZAr6kMhy8xe/RPb1bDmO04CNpw7m/20
	t4zdkvyZdB4u2lRPgbtoguloN/WfHgMWsIcEop+hbyH4HpsYOmwTZDVwli8XTb9yZQvPOtJKzlT
	eAqoTQ7kFo
X-Google-Smtp-Source: AGHT+IF8vRO87ePRWUVilu0+iEEL3TPJfS0AEbNEA5AJPefwuvh02sJuaXtHqTE7eRJWzEp67rMcZw==
X-Received: by 2002:a05:600c:5254:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-477a36f1d1bmr5684305e9.3.1763325041577;
        Sun, 16 Nov 2025 12:30:41 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm23161546f8f.17.2025.11.16.12.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 12:30:41 -0800 (PST)
Message-ID: <afd60ba6-4af8-4944-a915-4e2b814bbed3@gmail.com>
Date: Sun, 16 Nov 2025 22:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width reported by
 RTL8192FU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Language: en-US
In-Reply-To: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The other chips report the RX channel width in the RX descriptor,
but this one doesn't.

Get the RX channel width from the PHY status.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 739456640ca8..668018229f7c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5701,7 +5701,7 @@ static void jaguar2_rx_parse_phystats_type1(struct rtl8xxxu_priv *priv,
 			 !rtl8xxxu_is_sta_sta(priv) &&
 			 (rtl8xxxu_is_packet_match_bssid(priv, hdr, 0) ||
 			  rtl8xxxu_is_packet_match_bssid(priv, hdr, 1));
-	u8 pwdb_max = 0;
+	u8 pwdb_max = 0, rxsc;
 	int rx_path;
 
 	if (parse_cfo) {
@@ -5716,6 +5716,16 @@ static void jaguar2_rx_parse_phystats_type1(struct rtl8xxxu_priv *priv,
 		pwdb_max = max(pwdb_max, phy_stats1->pwdb[rx_path]);
 
 	rx_status->signal = pwdb_max - 110;
+
+	if (rxmcs > DESC_RATE_11M && rxmcs < DESC_RATE_MCS0)
+		rxsc = phy_stats1->l_rxsc;
+	else
+		rxsc = phy_stats1->ht_rxsc;
+
+	if (phy_stats1->rf_mode == 0 || rxsc == 1 || rxsc == 2)
+		rx_status->bw = RATE_INFO_BW_20;
+	else
+		rx_status->bw = RATE_INFO_BW_40;
 }
 
 static void jaguar2_rx_parse_phystats_type2(struct rtl8xxxu_priv *priv,
-- 
2.51.1


