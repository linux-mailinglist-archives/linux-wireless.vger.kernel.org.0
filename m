Return-Path: <linux-wireless+bounces-34001-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAU9IL5rxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-34001-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:24:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A03391BC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEC6D300D4D5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1B3F7E9B;
	Thu, 26 Mar 2026 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8u0bgEd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA1421F06
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545001; cv=none; b=HCvEU053qwZOiFmCo22zAlCWUWqnEm4FImQc0SPYoWOiutwYl+wJmn42hHS1rpUzUHBASHHdomnd+SbHTQOsv0dXYvAiQp8IldZTcXTruAZ7nggOGEQunCa6pUH7r3VF45WMy6BvDVQd0rCblMbhx3x4skSqivWOwmQmNBJodLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545001; c=relaxed/simple;
	bh=N+oxf1pfj/1VStVT3NCmgaOk0BLID6fROhKWRradiK0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D/C0pc3EjQglqZVejMXcoHvrSCkp1zTOV7X1vVleNbGGhDS5AoI1stnzlS0wdxaMj9gXiz+mrm2QRziBd89qFTyag6A8E1cSxNV/2lJ3vC3WGxQlgMbtiIm5hTzp3p7gqvvrdy9B6Ec4ZDOMIKZOvQV1M2Rj3yTyA1WyThbmHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8u0bgEd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b982d56dac4so193098066b.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544997; x=1775149797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K8M2jcu4AVQyFWgJOgsaj8UvZ+S94r1J7lEmamkkVUU=;
        b=i8u0bgEdMEU+H+RjVJ2+7RR1PtoymaB88kgogexskUTogcJoaAWRmnr4oMspgWNtmF
         dSe1sse8vSJ3yHkAsuaUojwXOffRGARu4f9Kd4zoo7ukwcfY/OsvNyHtfswpXvdgegGE
         s7BkFLqQiSJ0OhVPOnA+9y9hwtixaIXhjEhYMlNv35oVV9vLl0NwHJv8wlREHRS/AYHQ
         yOd8IoVmaUgqYI6BkfgQYBamtHIBFL3M7dsZbGmiAgguojIj6CtoBzPJUstRVlXSuW4B
         FQEbUwWAm2ZzQYMjJSIXAEle4RhOBVOfdbV7TD6UIyWpeVC2uiMp/k4qjDozHjWYnGwB
         z23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544997; x=1775149797;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8M2jcu4AVQyFWgJOgsaj8UvZ+S94r1J7lEmamkkVUU=;
        b=rtFsoxScA/JgYD/+ADvR7bH6TOFDjqq8o+vtb75Iorev0Us0ElOYrAfc0u38NIiS74
         VHP6RkUx5WLLmj9D/wlAIzvb3slOIMsMGceDl8kSepxmHSflzqPuOipPG6sqZ8A8pYCE
         k+omUAsWCnWSPcS232qyh9xTODl/lcsOGZnIee8c03foPSxtje3OBrI5PM+l+Be1F9iZ
         gdrSNyJ3VvzbteBfuJze+qDk4ZOBvFYIhelNYId/szjz8V1HLfRerUlJmnW1yXZlsnfn
         RfqkqXWbN28Pqrg8/99RPgRHxjfkQ5jCmt71cgc1mURst4pJ6gQRsGHqqLcXzvcu2XAT
         vekg==
X-Gm-Message-State: AOJu0YwiqDNVLQoip5Pu17GMPZV9Q95EWv8V6IywTpOqmVt63Z7ayKlz
	qPJm414DPaIl6B1KIrx+8TFmoJg/krwHCwTF1033pnkvvxwmsa9ZVN0tkSJm+Q==
X-Gm-Gg: ATEYQzwuBz32Sc0KVsP3Y1jgfmc5F+O/x7WnLVqlpxPXY7OpZwBtcPrpu+ex3RVxX5M
	gyhu6ROnqK/in8kz/w55YGw8tBeatVtmKGFVUq3xYZZMsrH1ZiFhYff5mBOCyZpNcAq3Lt+uMZQ
	Sd7cS2uztRdLcwuKN3JdpJfNtnNt0tzMEbah7nNd7utmh3YPhW0w1kLf4m2GTakR3YTQW0osaiM
	PUQ9AqwKYIozPKuZfzVmdFv5e0RHYJvUPB8vBMkcRc3GNNaJbxgB3wIWVWKmdPFhnq74GM0LXYo
	3AcfhMQzmu3Gjk/xOKh08fAoldoHeiteo9gZSXy6tmetrdLsL1Zp/cRZlHeFHFGhAYHLfB74dWs
	suzZj/0sfAnwVMdxTlNO+CSuaMGr5fuzb+X5wwN6atXGi5W9zBVyaYUVdzt4v4U4NW6QgL0NVaX
	1qN6oxuNSmr/vKZG+xlCkiwXaE9NXqVg==
X-Received: by 2002:a17:907:944f:b0:b87:7485:b4a8 with SMTP id a640c23a62f3a-b9a3ef6a325mr488542566b.0.1774544996572;
        Thu, 26 Mar 2026 10:09:56 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203c2231sm147387266b.38.2026.03.26.10.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:09:56 -0700 (PDT)
Message-ID: <99125850-8dee-4a98-ab68-5d171449a2e0@gmail.com>
Date: Thu, 26 Mar 2026 19:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 12/12] wifi: rtw89: Enable the new rtw89_8922au
 module
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Language: en-US
In-Reply-To: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34001-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 840A03391BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested without MLO, mostly in station mode and a little in AP mode.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 44d8a7f32bf2..43e3b0ef44da 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -157,6 +157,18 @@ config RTW89_8922AE
 
 	  The variant 8922AE-VS has the same features except 1024-QAM.
 
+config RTW89_8922AU
+	tristate "Realtek 8922AU USB wireless network (Wi-Fi 7) adapter"
+	depends on USB
+	select RTW89_CORE
+	select RTW89_USB
+	select RTW89_8922A
+	help
+	  Select this option will enable support for 8922AU chipset
+
+	  802.11be USB wireless network (Wi-Fi 7) adapter
+	  supporting 2x2 2GHz/5GHz/6GHz 4096-QAM 160MHz channels.
+
 config RTW89_DEBUG
 	bool
 
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 1be81f254fca..475bad743d75 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -88,6 +88,9 @@ rtw89_8922a-objs := rtw8922a.o \
 obj-$(CONFIG_RTW89_8922AE) += rtw89_8922ae.o
 rtw89_8922ae-objs := rtw8922ae.o
 
+obj-$(CONFIG_RTW89_8922AU) += rtw89_8922au.o
+rtw89_8922au-objs := rtw8922au.o
+
 rtw89_core-$(CONFIG_RTW89_DEBUG) += debug.o
 
 obj-$(CONFIG_RTW89_PCI) += rtw89_pci.o
-- 
2.53.0


