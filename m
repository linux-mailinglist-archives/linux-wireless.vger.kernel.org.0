Return-Path: <linux-wireless+bounces-29170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27760C7478D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F035B3462C5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA12309BE;
	Thu, 20 Nov 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up7pgOaO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F149307AF7
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648003; cv=none; b=F+6cnCZ4Cjkh/+EX/dhxkF70cM+DJg4JhafLhm2ipDSkDB/j+FcXBH3ptHyYX3AWlPnnVhTBhCABihCuIeFnY5TcDpvDBWmgxYOInz0XEv31PfgI7H9Dhd+2QDCC+3fiv60nBvHW8PNAmj+AaJ710v/l2oZcHLKaFN8jz7r3chE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648003; c=relaxed/simple;
	bh=KhyvwxQOdAqSZJWlDaBDkaIWgtKjiSH3SCd/5UsxZSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QdGrHxhDclx6g+uHBUyRY01gGmB3Er5Iterl7cnV15NmzY1wDBQEJpRNPYg1TnYG7+Mc6FgvDK722apFzj+HYzijG3u8fDMrhyEDDfjad8z8abzdHQWI4vUbL0HqUw7ci0kU0eVALfsZ7Zu8XyV0J7KmqsJRoKjCXjAWZXinrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up7pgOaO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a219db05so6364815e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 06:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647999; x=1764252799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AIQ3PcLD3qT1gy+aDX3YmnDcIHZavB/Kits63+TZil0=;
        b=Up7pgOaONyKW4W9f3LApZF8f5TeIEvHDT7rKxxEWGvVEO65tBiPITIO4H3C0vBU9zS
         dSldJraWN6fUOBAA6Z/Plb6IurETj4D6yY1lm5y+H0bpr6kIRf1rwH/brtb7o7YDg+5i
         FyxPAMkgn49pbNBbdzfyEXdIQgtuGczjLD7icGOi+z94VAQ1VPuQRZWfee7VjEoplsgN
         9xg62TNH6l6M9LyRAgEIhTjCXnK4bQsScNQLPzvBfLesb1FwOPxr5nWukN2CCa7Bo9VK
         gmo9DvHswIO2heT/1vU7HJkGy/VcAwCI9R+ka4/VVzPEBNOgff6WjBYg0eLqOuodE7CL
         zSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647999; x=1764252799;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIQ3PcLD3qT1gy+aDX3YmnDcIHZavB/Kits63+TZil0=;
        b=NH3Hpt/DLUgXDrrS/itYHTVWBMjXLr+mWxAL5WH0e7x2Y6Qvg7KERuxIwqdsImuAKP
         AcOs5Z+UNq96itL0lB151g7dBSUiAwgTd8SVt8O2gOVrEKFsjbWqXO7YUHNULS4boYaW
         q5JQOZto2OWOo+CqxHQKbb0C3jWraiGdUhMN66bGb9kOU0fUEWXaP3FPBCbk3ZRSCm0A
         Py2m6I/guWU/se3ObTmlIINTRyJQFU8EKw3Nq5/oNGm0L+HpaM0LkJr0lKilBmvif/Sn
         icaoSe56ySzSdT+nWdu9Ja7V4rrJ+rDcpDYhugJLzaYL03iIwcrUHL1UYvX+xalLdTu6
         14nA==
X-Gm-Message-State: AOJu0Yy4LXTLRcGR+c6/sCdacXl99WYbdZDANYfyNx2lqLLAXsOOMBdH
	T54USGEYTF7NZNrXj7gCUgpvM9jZRnW1bscj9/ecrGzmR+bIFP0usBCd48WIsw==
X-Gm-Gg: ASbGnct2R421HSj7Poxq154OoEGkK7fn7w4rkEbAIN+6NeollrRdYoLUOmWjQRuoT26
	gYC0AP6jMjVdIL3TrM9G0rmBQik2Evm+qp8n3HMzBe1uZI1wzrR/unj3jmsP7LuxwvVEYI0OT6s
	Vkk/hZMgsUZevBiw0JdNCw5/J2ndvs8uRUVIt/ge3d3jeAb7baipS5rdH290q2FhW2RH7rMNqeh
	tb/mHS1y5bdRUSbA4XMO+QI3tL2xB/+YZ0xMULrCWwIXrCg3n7EChyytIGvPqQ2kZ9jFuXSveQB
	AkD0OErPov82tp+VuR7w14TKq+rr1iwzPYEzzzch+sZqp9MgJUcJbz16lcQcF0A9cZVgFqyi3oN
	1d8xZsxqPEP90Zpm0GaAMnAVR7p4kOdEyl3wJGCXj5/OgmlplhjnyAKyNtL4hVFlHOxzGv1fxQv
	nZrBHLq1+pdbHnUc20LTs=
X-Google-Smtp-Source: AGHT+IFCNAQo2+HVbrsvjHzI0JcKSFcZvZWkL9f+wQla0STNaBApHgQ7VLePAjCYgY8OHatxvCFZDA==
X-Received: by 2002:a05:600c:19d3:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-477b8a8f296mr36115295e9.17.1763647999560;
        Thu, 20 Nov 2025 06:13:19 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8ff3sm6012373f8f.29.2025.11.20.06.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:13:19 -0800 (PST)
Message-ID: <1c6c1fd4-92f6-4327-a24e-f0747ab21819@gmail.com>
Date: Thu, 20 Nov 2025 16:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 4/5] wifi: rtl8xxxu: Fix RX channel width reported
 by RTL8192FU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Language: en-US
In-Reply-To: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The other chips report the RX channel width in the RX descriptor,
but this one doesn't.

Get the RX channel width from the PHY status.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Compare rxmcs with the legacy OFDM rates for better clarity.
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 739456640ca8..a18f73aea837 100644
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
+	if (rxmcs >= DESC_RATE_6M && rxmcs <= DESC_RATE_54M)
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


