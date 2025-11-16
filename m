Return-Path: <linux-wireless+bounces-29005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB6C61C4D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 21:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4B028241D3
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF62475E3;
	Sun, 16 Nov 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6OhlMI3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D9222578
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324903; cv=none; b=MDUENdGz1mP576surMH2I2Utvk+guJeeBA5WCOPDIe1gBafcuAQ4fgHf1c0wWpU3BeeSELxYLYuFhmJugDzUzVLqXh3lZZrTtpMg4rhdsn2+HJsJWaM7vF6Zankq/6RBYZHMXVarPmxIM0FCzLq8Ocm4haev2lZC8lierPHOM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324903; c=relaxed/simple;
	bh=vbhgVQO06GSnthtPEuWeCI8XwyEKlSZ5L5vVf5B57KI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mBtI36PkrB4y4CwfArcY22DBHnxuMGC2jkK8PLpfBMTX7/AjDrtKjxZdb3/Z5Z535P/gkWbGJtcrnfTpsYbxo8v08sAG3CW9RZHIuvReKzk5KVgsswV0DMJdUdMmv04VbS8mLgOd2NQhHMUMjxNEW/2wiiosGyYKNX8IXntPkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6OhlMI3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477549b3082so30031875e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 12:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763324900; x=1763929700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOphB4Wc/M6RMk3ur1iLH1Mw+cdbPUOqZFLTZa2SQyc=;
        b=a6OhlMI3P+kFXiW+kC2eKdY/+NqUOhv30adNdrynG/5VAyznefRSIq+ECh9hJC4K1N
         JfrNc8FiKlbLnQzd75Dwmrw7/dz8l0boDeHLZ6kmz5Z/NjKsgn+VZ2VIWcbwZYNJyIuB
         5aiP9/3/MIpKnSFmGrhlf71oBx0dlbzqe6tEmil2PkNB1dBkdZLUMhNe/9EI0FkOgK0a
         Wjcwy/ec8r4wKQ+JeM8KaJYrjHxxoKqrgiY6CU+HK66vGKhQhe+0piZdd6DEQG/0DO9u
         pAYImUegDj38aKcN22UPJ+zZt3BULtyXTk2tAVOzruB0qw+6ppYojVU1Ptx/qzlXsb3b
         b7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324900; x=1763929700;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOphB4Wc/M6RMk3ur1iLH1Mw+cdbPUOqZFLTZa2SQyc=;
        b=QvP5Kze26QAyQq/PVStr2PAHEvidfiy3rM3uHpOmrQPgA1Purl/rws29IRS12b9tUp
         YrWt0ZsmJAmAkXF+rjVBPeQWPsjTVOtTxPfhzn1rMk6cLbKgXtaiqym0hx9iTbgPwEGE
         uSWKGPQ5+/rOFRl/MCp5uNHpQ1HtTI7NJMHSiaEheCQdShkH0+WlezBFI+gEFRWMS5co
         wu5amo/9dBerf/hYkmqJQwQDhspDRsD9sPX2Ke0TBEuC0rbzvgvW7CbUHBmYBfypQZy/
         FRbfdB9lAckx2PB7I/npFnPGhqMu6nuTA3fOabQEnBi0I6PLtN8ytcqMdytb1agcPmAY
         S5Nw==
X-Gm-Message-State: AOJu0YxM10sXqTh7dvsx/pDUhlziNO+CzR1BijPhWOvQeQSocsoXljWC
	FGZ2akUSOCSahwjSNw1e4+sp9FcVaNVffbOaNQqwwTTZZ4FRKj5ihD4CSK2sgg==
X-Gm-Gg: ASbGncvIhtLsJPKarXBSZYKMXiHI1xj/3uiQK9DMMt9g0+pK5zn7ZPuvA2EbGN22Chc
	b8+7C93tguvdv+Vfq12SaHig5tbzFThY/orWQBNEsfqgBxXexuqUWNy/H1fVdEglwdyAYaPkNrY
	UFhHVMXvnJJvbeaNLLsaklSgwvRFkTR2V4vhvTqgZANgSVajm9+MLzqFcRMfn9/LHqm9KE0INEh
	XUbUZOPymac+DPNmu0F2V2MjWCO/5BBaT4oCtxyrysPJ1DHsB998oO8VxNlG87/Gj67Im4KP+8E
	u579QE0fgIjv3HyTSw5r5Ff5ICXl/z5MzIiFD/Lrpwb/SwCCIe8uTqfHO5s82qzaPX41UFvCAwr
	zZhaOsvi+eSOIfJTu0VuDkpAMEAfAw6Iz0OMHvDN1lRxAzkeuEb/pqIPQRHV/R8/C8XsKNjyw+w
	c/w9FoRZIQK4KyH5+PozQ=
X-Google-Smtp-Source: AGHT+IE/KbiwA49psPf/hcuSVTjC8sIcjjDCcPydcBr3YFmmOG5B1ku8TbzTKmMDE3O4cNMMj9a2pg==
X-Received: by 2002:a05:600c:8b43:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-4778fe521d6mr96396995e9.8.1763324899980;
        Sun, 16 Nov 2025 12:28:19 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a684202sm92284925e9.10.2025.11.16.12.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 12:28:19 -0800 (PST)
Message-ID: <393fd2fd-9724-4e3b-beda-e871fe402b66@gmail.com>
Date: Sun, 16 Nov 2025 22:28:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/5] wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX
 with 40 MHz width
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Language: en-US
In-Reply-To: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the required fields in the TX descriptor to allow these chips to
transmit with 40 MHz channel width when the access point supports it.

Tested only with RTL8192CU, but these settings are identical for
RTL8723AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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


