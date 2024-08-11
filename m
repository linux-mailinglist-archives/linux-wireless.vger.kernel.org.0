Return-Path: <linux-wireless+bounces-11282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9794E331
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126051F21D84
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8EC18E20;
	Sun, 11 Aug 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkXQzNsA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448212595
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410137; cv=none; b=BaRXEIzIMIbvbI5yZKUQiSPb5rUYhPj2f6dIMkJrEL0QAPcsOHoeGQ+Q3ycbNHhlHdGdEtiByYYxHJ1dkHEZ6Yiahje4DS/ZE6/Yfy6RZhVT9SNHY3VcwHyKW9WZS/znX0GSp/AA2jdb8Gj5HpRXPNZ5PzaH/5ogvllq4hFrubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410137; c=relaxed/simple;
	bh=aTgs4JwFBeONwXm3TxpVAMbXvZbD/Aku3jIvw+Z/FeU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qBi8naj9WhuIWuRGB8uQjAekSY5eqaYbnAz5h3cCPSwbKQk6mYmmglv1CwGVnwVrmA4vqWS2oEPwO00J2rECtQ37JNne5nrA9B8ZuG9vMRhThsknM5D0L6ez/KkarzDJbOoQgl0mEIG+OlleiQMEclBNdp576xjOyhpLvmi7s0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkXQzNsA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso4405834a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410135; x=1724014935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uIT03ew/2RCkfypARb1Bv6fKteQamDMApLKyfunwRzg=;
        b=KkXQzNsAiHj7732I+VnL8ImjKPve4UHmpDL3AR0kJeZK/b3219NHIVh73ZjlA+Psgi
         yh09/bnqzX7HuDtX/+LBZ1qDQXEquiQ6SIs+fgHszvyl9R6o6ozvX4/uU1+n7ddILLbu
         8YTMZxgBjOWYORy4/5Pr7o6QotEo9hB+BOBEFgzTfmbRxkYX49k0Md0AKodwGBpovv+Y
         X+n3Wui7MgyqO15Ud3AG23DTtDCYf8gRc8R7dcLAq504w5iIiRIo9MAgTvnSaRXYFKQg
         ilC6yvyu/8FKIQfqcGKYMji0yZF99sk9A4lL3SSUHFzDvnwHcKs1527fpLqZDZ3B4da5
         bKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410135; x=1724014935;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIT03ew/2RCkfypARb1Bv6fKteQamDMApLKyfunwRzg=;
        b=MwhcmDLtRg5s+UfwNzNEjMRHOK7K+aASJkVZdfDZus1Hl+l9G+u0n8Jom+01DYVgeJ
         kQjczHMgf+/pxICdoBA9uPZvfQS1W+u7W9qLTV92qi2JmqOnMR3OKfEvkZPZ2YgfQl0f
         SK0804oTqKlz0R1lTsDnDjZY3jmLJQdZ9FYfD08Tg9pdClCC5ciYT20F4mbMyuBVQdqZ
         SL33VBmutQwgWrlEoZnrXBszOGnCc+st8o+6zJJTproWfDWytoT/Si/NR/pJzqiWV1iu
         81lDNJxAPIfdgM2HuOmWBx/cRKo84DdfE4CjMEmDgt5c+P9rAcqtHeNVFSBy/GmB0U85
         9uxw==
X-Gm-Message-State: AOJu0YyzM2119NH1eD8QQyu4YnBWhpdZXyvRdEtvo7kCtRnKgQVYCgqL
	1+9V0gf+1Q8AYIoNI1X1xvf4SW8YKFEhiaJFINelsb4ALyX+hit8MTYehQ==
X-Google-Smtp-Source: AGHT+IGNEMMylFD5ahKlVxysZ2pquanm0/I5K4kQR3WBI/I38PPSHcFkmCDXQ4Ml8Zi9xd5sXSgLrg==
X-Received: by 2002:a05:6402:5186:b0:5a2:eeeb:9470 with SMTP id 4fb4d7f45d1cf-5bd0a5a4b2bmr5018807a12.18.1723410134477;
        Sun, 11 Aug 2024 14:02:14 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e07a9sm1582529a12.78.2024.08.11.14.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:02:14 -0700 (PDT)
Message-ID: <b4bd2f17-1a4a-4b1e-b858-7f8b1cd37dfd@gmail.com>
Date: Mon, 12 Aug 2024 00:02:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 11/20] wifi: rtw88: usb: Set pkt_info.ls for the reserved page
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"ls" meaning "last segment". Without this RTL8812AU can't upload the
reserved page in USB 2 mode. (Somehow it's fine in USB 3 mode.)

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 05aa8ffe7d8f..df190a31f930 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -477,6 +477,7 @@ static int rtw_usb_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 	pkt_info.tx_pkt_size = size;
 	pkt_info.qsel = TX_DESC_QSEL_BEACON;
 	pkt_info.offset = chip->tx_pkt_desc_sz;
+	pkt_info.ls = true;
 
 	return rtw_usb_write_data(rtwdev, &pkt_info, buf);
 }
-- 
2.46.0


