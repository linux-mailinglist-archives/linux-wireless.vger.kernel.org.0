Return-Path: <linux-wireless+bounces-36510-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLRuDdhjCGoQmAMAu9opvQ
	(envelope-from <linux-wireless+bounces-36510-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 14:32:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBAC55BC62
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 424493006038
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF51DED40;
	Sat, 16 May 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2GMWrD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F571C5D72
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934737; cv=none; b=iLQuts6utjrUk6wJ396Ha1beAHmu/acLKV8pbBmhxiZ3bX2fziZhGD1mNG2qSUv/ftwk+SY2jZWOZfCii/1VRIJWxOQog6nnGoJz0rRC32NQdSe1ko9mA/Xe719btgtXAaFzuJVJOHcuLlsZgocIQWK2kBZXsUp98PKq0OAUfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934737; c=relaxed/simple;
	bh=QMUkT4N2a8PoJET3/9dopLGW6y/Irf6RMHjGFwjxeAU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pMWgbfpoDBv1+oIi169Jy4+Wjh6fkghq4dAbEvgQhu9dplfUrhuLHrrO14PdYDVFi/72oEbxZ8OHxWsI5Nex9o7dXhs73JEHtr//O2NCjDMcP8vyeQgW9n7w7KKCU49MUun7vG6h1ym3XF1PrKvbQMi1ZFpZ2Ub/aJ7LLr1/qVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2GMWrD3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0046078so5921255e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778934734; x=1779539534; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu+0i3burGzSu+GRGlH3AsPtWTpcj2oG1kS3CMN0aoo=;
        b=o2GMWrD3tb7/XGJfXRLLJNjtmBLeGiRa5tEjk2uWfyvABvl49spBYJUkuNi64Zr6+I
         MDyTNxTUSTxlDoffG1yns5ieI7wTRVH9oRjGOGpbA+w6TTNkIYmzYmizGRBlna50h5kV
         WvXsi24vxeUCm+oqK1fDh1rzKELuy17OyyZaqyuJIIa0u5giPZXJ5yRiT3PwGfUoz1ow
         Drxk30hufjWgJfCkmNuF3qR0e60ljwxIuOiu8HKj+po6HYVAFPZwJ1bwMY31SK6+3OQf
         PvLDCWk2C4KFA0YVbm+rhOKG3p64RGsDDVyekFPz2ubNyuIQ9mgYu15WrMtuq3XUuq4W
         ZNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778934734; x=1779539534;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mu+0i3burGzSu+GRGlH3AsPtWTpcj2oG1kS3CMN0aoo=;
        b=EaoszI6lpt9YFzY6uLI4Viw3X6eGicRi2YWJmxrqhxJVP32/v2zSNovFqOH70QRGJ4
         gmI9R+Xne64+wnUxk/GjSKgW/Htr/7vCW67oA3HKYM5NpudVFgDDL08jU5yfSU5Q+vcj
         s3jGjCYKwcQDbGKPHGgcjNq9q4FrvqovRePMW4iBfN1J3zK+cDo3k2lWM0+DdT1lTUhw
         bDzWg0jexe+Q+vU83yz7cRir+kG/TKsw7thXF7LUR7Yu5EP+8ExXQ1TGXspkll/J5bBW
         ApeeLGb5kSuoxLeQ9gSh1faneuTgUF1A156b51L+kkOYpaIJQLqJ8lcGBy0jzIYO8bX/
         NMaw==
X-Gm-Message-State: AOJu0YyfY6U65wBQNLm89GnEkQhLxcDDWn+gLKlXpQam9icyb1RgHA9I
	YxjsoHoYAVSlmYPzcPcQgXXxxnq9FZN/OZrx+229t+AKt47s81dw64duEevFUw==
X-Gm-Gg: Acq92OF2pZEMddsTQZVwg+QvgWdtZ0bKz5BSlNRzdnvHnjONWZ42Kxndo9+BuygwW9u
	CNeU5rBKkSCqmgSVvg9iXyf9K9Ai6pl3V8LqJx9Y4gaySTya+V6iUIxxcwViFmXYpTzmHHWkiS/
	gd54wEibBLyUUHezNbYGZPN68nfCUzxCszsbn8S2GiEDn2ZuMAvgx5zcZscKN6k3ntZNXgYJ9rk
	qCbb7XUcLngut5JXmxyvcBde1YAFDdW1k00rgisYA3f79DFkd7y/WOF7/TzWYs7UQ0oVxvyiSTU
	QWK4JAC2vyUBFZbO+zOysKHN31iTmKpMlM0FVZTGyp1OS6hunuG3S/emYISedmYPlwW8Ocopk9H
	fQgs/+gWxmWxDznLM+vErZ3IF7ssD4suXugQl0xp/az2BenlPPO9E2vukwH15TFapf6LdwRqlEJ
	VW1nxzUAj2GhMty8ivqg7unDengVEAzA==
X-Received: by 2002:a05:600c:8b18:b0:48f:e230:1d14 with SMTP id 5b1f17b1804b1-48fe632a187mr118856625e9.33.1778934734381;
        Sat, 16 May 2026 05:32:14 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm146249675e9.15.2026.05.16.05.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 05:32:13 -0700 (PDT)
Message-ID: <0c8e0cf1-13e9-4c67-a67f-5f6f79fd0658@gmail.com>
Date: Sat, 16 May 2026 15:32:12 +0300
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
Subject: [PATCH rtw-next] wifi: rtw89: Add missing TX queue mappings for
 RTL8922AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2CBAC55BC62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36510-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A user with MLO-capable router reports:

[ 753.080409] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
[ 753.080417] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
[ 813.649426] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
[ 813.649445] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26
[ 813.855983] rtw89_8922au_git 2-2:1.0: Cannot map qsel to dma v2: 26

Map RTW89_TX_QSEL_B1_MGMT and RTW89_TX_QSEL_B1_HI to RTW89_TXCH_CH10.
This is probably the right channel for these queues.

This function is also used for RTL8852AU and RTL8852CU, but those
currently aren't used in DBCC mode with rtw89 so it makes no difference
for them.

Link: https://github.com/morrownr/rtw89/issues/83#issuecomment-4314735734
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 432d46dfd26a..e370339569f1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -854,6 +854,9 @@ u8 rtw89_core_get_ch_dma_v2(struct rtw89_dev *rtwdev, u8 qsel)
 	case RTW89_TX_QSEL_B0_MGMT:
 	case RTW89_TX_QSEL_B0_HI:
 		return RTW89_TXCH_CH8;
+	case RTW89_TX_QSEL_B1_MGMT:
+	case RTW89_TX_QSEL_B1_HI:
+		return RTW89_TXCH_CH10;
 	}
 }
 EXPORT_SYMBOL(rtw89_core_get_ch_dma_v2);
-- 
2.53.0


