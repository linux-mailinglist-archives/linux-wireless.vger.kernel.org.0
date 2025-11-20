Return-Path: <linux-wireless+bounces-29168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C63C74830
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D416E4EC3D0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F6270541;
	Thu, 20 Nov 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzzvO6Wn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D809337BBA
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647925; cv=none; b=m3I3m/ynxGfJ7XAOjv02V5XS2t7RwBgNFic/iSHiVcGxwsPF8nCvhmgx+NELhsmsbrIIzfHxjWFATH1P8fAL/nheNpmtmjAoqpWbYRPuy9hbuQFBl1v9s7H03qlaZKR3VKXxu6YR7l8wT9JBzRA8aNz06lFyeGfIomkXamYpnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647925; c=relaxed/simple;
	bh=9kddK90IUWPQk2tAOJDznHHm6LAE/7YbVB2EXWdnbvM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q7ngQoLC6A1HbWm2iayPd3uAj3qtsYQ9DfErx2Ayh57VYhWlc58PQxUTt6wvJwy58cMmT324Ytta+d8adskA3J5NqcdZYDgZgs5mSt0vJkrcqYTdTumOf6P2fQ3ZhNDuPw4goAIvdquSe5sEuMAQFi/9HUJfN3RT4nmXQIMbljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzzvO6Wn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3b29153fso556552f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647921; x=1764252721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JqjJqJCdKoMS5mdcOKqtGwJw3nfT2dp7eytmZ2DDgCg=;
        b=WzzvO6WnO2+JPgx4RVh9/BASuHpTXfPO8c80ebJd7/Umrw43cxuaoqrgb/hKhnIGpT
         xhG8KhgSsIKa7brtLsXohjxTwdnTpzCRJcz9/BBWJ+gJgim0flwC6q3Ylhgj4jxVpwS5
         YMMWIAGbeWR+hXENJSaKOylIx6+as+IjBV3+gqOXf7lPtF6SzgLIUecPJZOWsug1blTk
         5gAEp9sEaMTnloi66B5JbRSeayOZOREChQQEYyf6cbsPj62jzvDKHqyYHWcYmAytN7s6
         Rr4x2JK2Vca0qNqkMc5hj6nRkhHr+8eds6n6oeR3HMvpeM33jLO1mUGZKTwQNdj7YMVC
         2ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647921; x=1764252721;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqjJqJCdKoMS5mdcOKqtGwJw3nfT2dp7eytmZ2DDgCg=;
        b=Ix9UFkneG0jNnydCo+rh7i2/JC9n1mj9w9QO8/m6Bpy8KnmCZtCcaAavqIE0mkWf8y
         /FA9VdOJksg5YA8cxAVEdOrokBoy7zJJYYnPf14ox03f7TP0Qv3SctFuLb37GjGx+3n2
         8hSAD2c62MxAXu57BKqmtxdCTAY0R5uLapZfjpKYHZ3OIlLtoFD+oL9oEfgI/uFt2ZFR
         vqnJczp863ajb52rx+jLcdrojmansetnrmKWiax+jSHLmz6YG3sU5deiHVKQ+RmD9P49
         RMyqBY6rAY/8gqqd4bbrdsI8D6+wuvP501vcXOQlEeAKLUV7l9iVDgg/ZjnolPnjscSa
         AIFA==
X-Gm-Message-State: AOJu0Yw5D8fWMNHMNwa+S6di1vllwAA/+RGAQOAa9PWOeFCCK9RKyzuo
	sGU0/B+sZf6A0EnRwXCTi/otmCg8udhlSsQ4U9neKtKKGmNu/EiBqPAps8f0Fg==
X-Gm-Gg: ASbGncsSRGEhnc9/RclPOJ/cfPjJ4ruV0+dndzyfz2+1jbVNxueJordbzSigzcriEqa
	oO8sYCBMSYp4RGelBo072xl/8jCRPQy99LAsCXWZNV9WtJe2lqKINMnF7lpeWpQa8fCDA2DHYBU
	fqTJL8hDvOzwlWgQpwE35TJopcbbkn2o6DXfPYP/hh4YXVti5Nn+/XszrJJnLB27xBfpavWmR0t
	iS4fktPfv16384lBauWtt1gzRQO9B45kiem0+P5TtmTIBc0w5r1JFqNbU8sNeL/rz2VL3awbqJE
	Zc0hdwepukGw9JAAwtF3CKXlGf5oCIw4TslkdYgqP9TPIHCqPBHY9cAmTkNXIy3zN0kmBZAVUhW
	YV694REzlWcjIe42j7R1sClW1RJRxlEHi3f9ydARaDNnaT+GD01DyM/WsWDXj1MAWB6TlqiupbB
	h+Lx1PVfVFVJVOccsBn/4=
X-Google-Smtp-Source: AGHT+IHocf+gnQXRXv4qkkwlv2SJ+mNyZHqtxv7uPNBnQCNOz//T8bApZK3h1gOcdlwk0eTuVuQ7Iw==
X-Received: by 2002:a5d:584e:0:b0:429:c4bb:fbd6 with SMTP id ffacd0b85a97d-42cbb2a5307mr2110382f8f.31.1763647921350;
        Thu, 20 Nov 2025 06:12:01 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm5658637f8f.36.2025.11.20.06.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:12:00 -0800 (PST)
Message-ID: <30d95228-69b2-48f9-8854-c98d2408c4d3@gmail.com>
Date: Thu, 20 Nov 2025 16:11:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 2/5] wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX
 with 40 MHz width
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Language: en-US
In-Reply-To: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the required fields in the TX descriptor to allow these chips to
transmit with 40 MHz channel width when the access point supports it.

Tested only with RTL8192CU, but these settings are identical for
RTL8723AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Reviewed-by.
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index be8ee6c30034..7700e4074dc3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5221,9 +5221,19 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 		tx_desc->txdw5 |= cpu_to_le32(TXDESC32_RETRY_LIMIT_ENABLE);
 	}
 
-	if (ieee80211_is_data_qos(hdr->frame_control))
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_QOS);
 
+		if (conf_is_ht40(&hw->conf)) {
+			tx_desc->txdw4 |= cpu_to_le32(TXDESC_DATA_BW);
+
+			if (conf_is_ht40_minus(&hw->conf))
+				tx_desc->txdw4 |= cpu_to_le32(TXDESC_PRIME_CH_OFF_UPPER);
+			else
+				tx_desc->txdw4 |= cpu_to_le32(TXDESC_PRIME_CH_OFF_LOWER);
+		}
+	}
+
 	if (short_preamble)
 		tx_desc->txdw4 |= cpu_to_le32(TXDESC32_SHORT_PREAMBLE);
 
-- 
2.51.1


