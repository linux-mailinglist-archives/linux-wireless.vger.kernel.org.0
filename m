Return-Path: <linux-wireless+bounces-34981-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPlbFCDc5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34981-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:44:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8DC424377
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D11300A12A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E173750CF;
	Sun, 19 Apr 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU5ZAkt8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432053603EE
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606237; cv=none; b=AWCU8lBxjGMyXl/dOzA6dth+Ii5q/6jK8SP2+hDpmJ6gZtvP5dkZ/CADeGQ9ar7yyh29gyG8KiGAwWKOYcYPNZ6vL0Yv9X5azJd3T8tvhALBSkA0XRaMUw3B1+3pA9vWDcUSAw9lc0vuCi1j7pWb4BoEiJMNW9Eo6UW3Nm01mwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606237; c=relaxed/simple;
	bh=rk0nbl+igoA4InoTCD7j4t3slo9p0dgDZMQIBQ71PhY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IU1fL9yoqqC7iHjK7c7fRzHXl4aE0LBqBpcil47FOrAIsMQ3K8CYL5KJ0qf0hmRtDJAuy3xlFhnA5gUkY0g3lZcf3X/hF4XM8Ci0iYVmPSPozWax1b6o6qUOLACo83QiGAiU5MDXS8C14Lrcvzm4x/5zrA5ZMXtSSIW+1zXBCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU5ZAkt8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d70b3e159so937027f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606235; x=1777211035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zWzTTyffXGicXlWBuM3VvQvmDsbhJvxErVyKsHQ4vE=;
        b=lU5ZAkt8pyTPfeQfrM+qNkvg+MImUWgYaQeN8flCEf5CSjf9aW7czc4xctXi5tmvnp
         PUPiWoCN5esZdYi9G/S1VCxygN5YvJeW9OaIj3DCcShs4062OEqvlVZabbR4d2tDkFnl
         nc+qWYJ2m7zZ/th8ULCoWLk5rkjbIPJ5mvNxb+5CNOozDKii49B7h1U6VLogOtK08MQW
         IFpDkfAK584WyA0+KYNkA9CizaTP/j3LabdulDXWieq4AO5wGcaTwSzwszcxE9qfwYKf
         0BMGFW4+73vqa/kFn07flykYOs/j75EcDaoQrfNj4PyIjj5Uc1HSFXKY9Br4E+9AsRT7
         DaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606235; x=1777211035;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zWzTTyffXGicXlWBuM3VvQvmDsbhJvxErVyKsHQ4vE=;
        b=kdug9K6wWaXMrzfkVWdXcb+QNCGYUUzKoDG7K0XhwWkG/ck2wMz46QBhQliFjINaxZ
         dvjQmsbhsbxAzDGyoPBtDYxZ05AXTaC5E/dfeP9RvB8s8bv1b52j19S+Z9Q7uJFe0Pqb
         W2nGbk44Fsm0Pvld8DjhYmQvdlXj6vGYJWxXY6S50wU2N3iMZIpSaOU9csz/3q3tRDMq
         p3aqk4cYxoZhIXEp7QoWDh8uOdlwMgA6yHgkT9oKdcTnsPYS3Ax7KwsRi3rKXyjUnMQY
         IdJjCEakilo7zHxpQnmy1DVyfuXVo571MtYeoNACDlMYLlUxF7KGagNZXpqaHW778TZ0
         +LVQ==
X-Gm-Message-State: AOJu0YyWCs7jLoqNLWFqrV7Ftwf+lFl6qCIsW0gx8lgAgttLcHSwY3yE
	/V/lta3/IFemsxkLG5SCuYqytPa2b1jt4xIhbja8LhylTI1/cmJDYG1EAfzg9Q==
X-Gm-Gg: AeBDieu+Kkclra8flQrO8upZvdt9g3HZ/oNwBoV2+HMemrawlqFccrCFYtDHhzZsSyJ
	n0T3EwRK1Ikk85FK8/NyvJHpcMIIpOWznJgqKvya6eF3y0TqRg3JnMIXVnJeLJVCn4HjCgyc3lG
	tRZvQCXLnEpSo3HAVDBp2eJCYo7ocQuAEnFUHx88NdZDPY87vOvt3uY41ev7iy2+rqAphuKJFv6
	wvNQWqQNqdO4IzzXwUnwi3sbaGWbJP4Kzd2ArdrHH3r3lPUxlD+e23ICwFP+ogdXWyzLgpGLKne
	WWdvyVdtGV2ayXRP7yRlRl2444z5YjTkF9IXVWzpF9deYAbJyocGxwU59ex93+YtlYRfVh/DKq5
	RjYE0tWzZpYIhWg8uwyGEC8DiEPEx80IdByeNJVyil5FzDv1ArSQhqmL2UHO+dZNRzDpTbtabWp
	V3Wk49HZDKN1J+HVBUAtsXjQPz2mYUo7XLFveqfdzH
X-Received: by 2002:a05:6000:2087:b0:43d:7403:4b5d with SMTP id ffacd0b85a97d-43fe3dc49ecmr15179256f8f.15.1776606234493;
        Sun, 19 Apr 2026 06:43:54 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a397sm22503812f8f.23.2026.04.19.06.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:43:54 -0700 (PDT)
Message-ID: <bd9e444f-257c-48c8-8adb-f58432b2c5c2@gmail.com>
Date: Sun, 19 Apr 2026 16:43:53 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 05/11] wifi: rtw89: usb: Enable RX aggregation for
 RTL8922AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Language: en-US
In-Reply-To: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34981-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA8DC424377
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It uses the same settings as RTL8852CU, but the register and bit names
have "BE" instead of "AX".

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Add rtw89_usb_rx_agg_cfg_v3() and the register and bit definitions it
   uses, instead of reusing rtw89_usb_rx_agg_cfg_v2().
---
 drivers/net/wireless/realtek/rtw89/usb.c | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index a08e43c8275e..c6d55e669776 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -803,6 +803,17 @@ static void rtw89_usb_rx_agg_cfg_v2(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_AX_RXAGG_1_V1, 0x1F);
 }
 
+static void rtw89_usb_rx_agg_cfg_v3(struct rtw89_dev *rtwdev)
+{
+	const u32 rxagg_0 = FIELD_PREP_CONST(B_BE_RXAGG_0_EN, 1) |
+			    FIELD_PREP_CONST(B_BE_RXAGG_0_NUM_TH, 255) |
+			    FIELD_PREP_CONST(B_BE_RXAGG_0_TIME_32US_TH, 32) |
+			    FIELD_PREP_CONST(B_BE_RXAGG_0_BUF_SZ_1K, 20);
+
+	rtw89_write32(rtwdev, R_BE_RXAGG_0_V1, rxagg_0);
+	rtw89_write32(rtwdev, R_BE_RXAGG_1_V1, 0x1F);
+}
+
 static void rtw89_usb_rx_agg_cfg(struct rtw89_dev *rtwdev)
 {
 	switch (rtwdev->chip->chip_id) {
@@ -814,6 +825,9 @@ static void rtw89_usb_rx_agg_cfg(struct rtw89_dev *rtwdev)
 	case RTL8852C:
 		rtw89_usb_rx_agg_cfg_v2(rtwdev);
 		break;
+	case RTL8922A:
+		rtw89_usb_rx_agg_cfg_v3(rtwdev);
+		break;
 	default:
 		rtw89_warn(rtwdev, "%s: USB RX agg not support\n", __func__);
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index 82de700eb142..bdf312559743 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -29,6 +29,14 @@
 
 #define R_AX_RXAGG_1_V1			0x6004
 
+#define R_BE_RXAGG_0_V1			0x6000
+#define B_BE_RXAGG_0_EN			BIT(31)
+#define B_BE_RXAGG_0_NUM_TH		GENMASK(23, 16)
+#define B_BE_RXAGG_0_TIME_32US_TH	GENMASK(15, 8)
+#define B_BE_RXAGG_0_BUF_SZ_1K		GENMASK(7, 0)
+
+#define R_BE_RXAGG_1_V1			0x6004
+
 #define R_AX_RXAGG_0			0x8900
 #define B_AX_RXAGG_0_BUF_SZ_4K		GENMASK(7, 0)
 
-- 
2.53.0


