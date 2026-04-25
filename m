Return-Path: <linux-wireless+bounces-35295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c0EECvQW7WmzfAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:33:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB54678AE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD54300B110
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90131C01;
	Sat, 25 Apr 2026 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsS4k85V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70534191
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777145583; cv=none; b=r1X3pRUY7Su5uXG1U+I3ZapIZKKDSnYKQGnWDfOG+MzCjhMt6uX6j/IYWugDSHU3rTbyvhtwQiKqxCCBhM8HYAfnL6gClJmGxHEEijJqZ0tdBHheHuzA2rIVG5c/xGalLFH2Y4sh1nrIvTmjKmiZJVlWn6mje4e1e14q2YFtNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777145583; c=relaxed/simple;
	bh=xCfS/t8KBvI/wloTIevyzM6XpGIjI5dbikcGzLVhs9A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=p7Qna1A8PGDJul5YnI+nh9HYoQJyOZuCDmGi0w47lLvz3Fla+f/FFNy1KykgKXm3yVY+FoD0wCqHYehAekvM3bmm43U3iZ1bintyWEQdaB7L2qOBRyxAIHzPPjVTWDYFj+9QZN6LxAbAwM03PuOGSo9mQIuvmdZgD5oF+mSJ9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsS4k85V; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so43509935e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777145581; x=1777750381; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttfAqYiDUQBV4gMUBFI6xmNOsNlZXLG8gPmSldOa/iE=;
        b=NsS4k85VQy0OQIl42X7G6sVzICH3YCeGYkQlJizC6TRoNpd2D3zNsGNbMgwJBBeyQD
         TqWHBq+qEQsK7WUNXRZyT4Y/6DsinjaGJRfPvPTL+KijC3+9+Z6lfPgmUPTQeOWdXn0t
         ZUf6JKe0fOXmpGyypH4pYOBJwgCktMfpZdPLqliHwLT3+FQ4j3ezPZwceVHdKnp5QNgz
         J0unQQF9K1flgNV9rGrndcsICCqWDg/yYeD8KClnROXc+CKQKLa5tGctSrhpkrkQ8ZTg
         cfekm697P6O2jDoYaUMsK7SWKi/VQtCze2AIQ14VTX9QgMayuEE9nym9HDpnP56X0VQx
         iGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777145581; x=1777750381;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttfAqYiDUQBV4gMUBFI6xmNOsNlZXLG8gPmSldOa/iE=;
        b=nc3vMmBznfSbYP3NBvt1dg0mcl8tDhccPAqffNA8hfR5chAqAxReNz+Y2g9yxdXOgW
         wEoucFNKbeu6SlzFUTJQ6Ff4t90GIClQAyS/et2izY4Z+2nX7MqeeU8ujnc4se87cm45
         URWhbZ4GpmiDFLzRdd7xPtNtmssr4Xyrmur1fmgwGdh0bJCyn5CRQix99fX8teQc8USv
         PX3+cbapWQE07yc/hnNlATuoaD6RbNDV+FCFKKGbPXNUCrCjHicIqscm9c1IpvSN2lrB
         jubaFkg4kdyqkOnG3KIGiJO69rBJpAi3mht+1ZkF7OjZ5tRTtdkW24s0XOLAwqC2QnGU
         9kEA==
X-Gm-Message-State: AOJu0YyxBfOmXMTn7+nhmdJOB8G0G7dFyU+FWJvZlbw7Epvbz9Sntx/V
	zGXDtPIvMwcDMNsXHeymUkq3MO3Q2q7mUio/M0UVOtaEyLZoAjf0HTtoAc/WyQ==
X-Gm-Gg: AeBDies/S2ioNGmhRxLs3XeR9CjLNv+hJfueyA8bVGg2DFxK23/yVzh49LLZsAx3Xbz
	UU1kXLUnFJP/OTkS41OJgqKeQcKHn3aTpSu+KipNUe7nWKKXvUZYoCnhesBavGdbSpalLpGryY9
	ufS+IoSf2WaZjr/O6tgfwVmquibnE6zbe74Sgb2JF21eeJYJuWnUxA1jFVqIhLeUf7zyyl0xHUP
	etRIiM30iwVVJOu/Sl2uj5NIBBf15OmCi8Di0F0MJAQnSvwDIpjYyJ95iHJgw+S0nOvguc6UtqP
	WF2v1GH81nw6vQ+znUg0PQPDgd3L4/3KCZlPshQwft+cWFPQSMhKYWC4VMSZUtUccaQGlbUm6rL
	lMvMQ57Efo5kBfrBQi4gcG7Ci1EZTYyyN9DbTRhoA1Cafj9ZUtDNAfMVtKzgIOF5/USsPnBMkW/
	r++eSWTpJDexZHQ+AoHElo61plKAoB1TehqFLupLce
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48a53cb8949mr242786425e9.14.1777145580614;
        Sat, 25 Apr 2026 12:33:00 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm735355225e9.6.2026.04.25.12.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 12:33:00 -0700 (PDT)
Message-ID: <04da7398-cedb-425a-a810-5772ab10139d@gmail.com>
Date: Sat, 25 Apr 2026 22:32:58 +0300
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
Subject: [PATCH rtw-next] wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX
 descriptor
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 68BB54678AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35295-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

Bit 28 of double word 2 in the RX descriptor indicates if the packet is
a normal 802.11 frame, or a message from the wifi firmware to the
driver (Card 2 Host).

Commit f5678bfe1cdc ("rtlwifi: rtl8821ae: Replace local bit manipulation
macros") mistakenly made the driver look for this bit in double word 1,
causing packet loss and Bluetooth coexistence problems.

Fixes: f5678bfe1cdc ("rtlwifi: rtl8821ae: Replace local bit manipulation macros")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
index 0609039b5322..17d37433e312 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -291,7 +291,7 @@ static inline int get_rx_desc_paggr(__le32 *__pdesc)
 
 static inline int get_rx_status_desc_rpt_sel(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__pdesc + 1), BIT(28));
+	return le32_get_bits(*(__pdesc + 2), BIT(28));
 }
 
 static inline int get_rx_desc_rxmcs(__le32 *__pdesc)
-- 
2.53.0


