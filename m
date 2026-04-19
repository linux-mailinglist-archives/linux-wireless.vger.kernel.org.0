Return-Path: <linux-wireless+bounces-34980-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFu+Lfrb5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34980-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:43:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F842436F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C09883004063
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C5355F4F;
	Sun, 19 Apr 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFdjwGOb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D583603EE
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606196; cv=none; b=L4imuMioJcQEHUVPWt4yFtEHTFo+FsFD0jDjh8gSa1MppTHI70Z+5+XJY7IbDVbQ5x9yVuRhlIhj/jLsw6bKaHMxHhcj24qJFLZBBjRxLcsyqFh9e7ot93FqgU56AAALSPZGNDC8A59C2Sxa/RoSoK/4AWRyi/8HBQNEg3mXSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606196; c=relaxed/simple;
	bh=/W/xQWxuRyekOfUk2MM9rRDdIpSy7OkiURUP8YYP98A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AnkZkI0h4zaxU/IS3gfyVg8c/U+G93jbELTr62qsbsOL4v7+PypXT84OsnlICYmigw8TiObGKNLycvIJGXPFf0uqRaURfZE9qekGLEydB13xm+nK3yerYX5M+o1YbbtfXobi5KmJwbGM6IBEvexeT2IL/uYfRprntvuEz30oOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFdjwGOb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so1983440f8f.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606194; x=1777210994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a4FNimMzzMcnYmx/gdThNI9iI1OQsfJlG4qvhRFpkJI=;
        b=sFdjwGObl7Fo7NsUs95TIPG7RnALUSfwL5QLDSKfgD+fYX40lAKw9ZL1z5J7P18Zaq
         tvYRn7UKPUxrln8ZEF7iVi0xyQogXSL2jWpJKXqdf27f0S8SpFwkoIPdAWdfwitytwEL
         687lv2LCukCfpbOnACMfAt96CTe0WXojZuOnj2wiZWnTwAVDO8v4QuEraNE79vp/Y9QH
         CiuQb70p8dgrGUiMYOLeMO2zxUUdNDOwfnZU8NPVsLZkauD8yJb28cj5Q2uTbsOxEqyA
         3JxpUjJWTwARyp9GmUIUf4qlhajMEuGCkuaoi5B3m89qxUMUCE90p8gI5L03I7p3YBBJ
         fNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606194; x=1777210994;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4FNimMzzMcnYmx/gdThNI9iI1OQsfJlG4qvhRFpkJI=;
        b=d1HTeMmnxMp35nwNv4mf7A6J6lmpJZU/jlPJEv044qIVoP4ND109t+2khBvB32othl
         THigwLi95uivWLg2SB6K33n6GucLOfw5UsAdKQlM54j6klyxSn1QEsCw6tnYqG4OKDeP
         KLvGb8V8WsbosecqE721UlC4v9HKhdz0pawVqToYMABxZpAahgy9wEG8+jhs1tT8Qshc
         Mjo9xJBzRYz7yKOGAC1pI6juc3nCuJhq5ZtsTviij7SmtmPyBjEWzxg/qCrtLWZDMBtI
         kCz98DElQUXUXuJ1QuSA6bCBZycvffozOaMpVqOT1vrk+o/8YaVsGDEsX/pUuR30AWzv
         p2lQ==
X-Gm-Message-State: AOJu0YyJJQ6yhDtDLARbeU31stWBsN05xgkxxUT9XHvIVF/ojtWMCZUc
	dQ2Tb2TQQOBl20ctrHEZBrJM3lyxtKYQYxNcE2qMTD6RK8++80PSu0/t+i31RQ==
X-Gm-Gg: AeBDievxek9M36Xm8Vb4xBMxTuoqQJpijABS1TcjD3L7YvyEZF6lCbSKEuETSMVtjwd
	zUf2WEgHWfOw5pq6H38CbZYx3ipkI6nH/v4q3IgWBL+e10LiEqjcx0xCMBD1KBHoHLXncjalpnm
	rqBkQKSPw9p72aFNr9/KX6SiyyNxUZQ6cl8v+Y18HXq8KHJwQqHR7W/OX07UemBl/OX1Nej1Zqo
	lgqGsjHFKVHswxHgCRyYIvWjwUOWeyXIavSEtYaLxxr8/ciZqbf3bi5NpfIwRSXka3JvwF7kC9+
	AD6ROezOp0484OgWsk7/z/ygQnKNSeCBMaTQ1mgYKNzIdC8tAwqgOodfUMvaaUzHXJij+uimsiU
	h4PyhWgrrR00m2CV5Z0c+Agtom1BmneNgOiuSSKJ+r/hQ4/0GCzcXfkdQQrQG4QRSfIfiWXEXHI
	+yj3ulRQ4KhccUXiI2bhC/TeeJglyrMDeIRlwvIXY8
X-Received: by 2002:a05:6000:610:b0:43d:4df5:3de with SMTP id ffacd0b85a97d-43fe3e0b5fbmr15190024f8f.31.1776606193562;
        Sun, 19 Apr 2026 06:43:13 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e44f69sm22358638f8f.25.2026.04.19.06.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:43:13 -0700 (PDT)
Message-ID: <71329cd6-0249-4654-be1d-74c8823f4888@gmail.com>
Date: Sun, 19 Apr 2026 16:43:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 04/11] wifi: rtw89: Fix
 rtw89_usb_ops_mac_post_init() for RTL8922AU
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34980-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD2F842436F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip most of the function because RTL8922AU only needs to configure the
RX aggregation here.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 3d9113ae7fb4..a08e43c8275e 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -827,6 +827,9 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 	enum usb_device_speed speed;
 	u32 ep;
 
+	if (rtwdev->chip->chip_id == RTL8922A)
+		goto rx_agg_cfg;
+
 	rtw89_write32_clr(rtwdev, info->usb3_mac_npi_config_intf_0,
 			  B_AX_SSPHY_LFPS_FILTER);
 
@@ -848,6 +851,7 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 		rtw89_write8(rtwdev, info->usb_endpoint_2 + 1, NUMP);
 	}
 
+rx_agg_cfg:
 	rtw89_usb_rx_agg_cfg(rtwdev);
 
 	return 0;
-- 
2.53.0


