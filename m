Return-Path: <linux-wireless+bounces-11039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAED949703
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B23F1F214F0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94ED4D8A7;
	Tue,  6 Aug 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVnqE+Ha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D022066
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966111; cv=none; b=cRmYtZcVdyl9N92DAsb0JW9vxpb2QajxtxzFYxG4wmQsCYRUW60fUXjHP9OnHzu4G9PH6l/wKysgkVjm37WIA19TAPf/J/1pNz6DbjJQm8SUAoPh4P0S1KvcoB4rQ4YMHm6kxY72adtaXdlcEAwbZonHFjV0/LpmI4ZBkRVbDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966111; c=relaxed/simple;
	bh=upiTBLlg7VxCx0CSSAePmJDlnlqmRC56LZHzO+bM1KU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J/36g8vsI1+ayleKoF56M91IODVLWZkyrtt0O3hNFEqVqARbBJcrBc+mWi6/cNXliuCbNXZ7MFubtqN13BssxlZQSGKN7jgBa+Mae1YBjduXrUhGtYTyX2/LHnzpZ5LMiP3UbZsbjECnDe6W5iExCNTZRHMaSD0gjCUvEQerJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVnqE+Ha; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so15516811fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722966108; x=1723570908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=slI+qX01R47ENT1ojgGknQ5DSnRZOPUCXDhz08hB2tY=;
        b=LVnqE+HaBWImyiCPWEmF7EGcQ6tLWsc2bK9IEclb3X2UldMDz/m36Y5hSfkHPDj+3I
         f6Zqc6BP8qF4a0q2EJDZnS8B69/lTk9X8WqRsI4DP27R6UQXfIvvIGWwI0kUwCecIVZ+
         rbmb+JdE0BeDt3vDlzqjVAnzaQodGYhyZ/mCbfwXZWNe/ue13qsaMpcSKm5UYLHxj5af
         1YuJf2fdnr3OIiv/+flA14KY3jIaIxnprXoKwPOExPVY86e+06NkDhBTCE8/0jUEQD4S
         HbIFVq5GdIfTI3QDKt+NudOttuNMsW6QNHSBN8a3N2Uwju12nd9CeDOQXTGDjqw22iQD
         JGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966108; x=1723570908;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slI+qX01R47ENT1ojgGknQ5DSnRZOPUCXDhz08hB2tY=;
        b=lU7J14HZicFB5KVBjmXJJe87KxcyV/w2aQFqUTRbEc5Hw1PtzQp3YStus4E7lVVZU4
         noEb3SgRXoD9pXLYLBgSPku48msha1u9x8HgYhtwiFNAWiFJonX5bEn0EsAzBqbAi6PS
         gc8PyuEx0scBc2LJcnuqc5VX6B0HADugZbfX/qgeh5b6vkJYkg9bC1GmnhNsqXoIvSUT
         B/LerDALHzrGktET11zGAInEWpizcNoCa+Zv22KCSd4xMQwoOqJLyWiuIq/pb5OnkExp
         QzRM7TWWRzoqSuArrgUz0PDv6Gsces95nKuGxjKktmF13ioYmgikPSPdVIcaPKk8jhlx
         BcJQ==
X-Gm-Message-State: AOJu0Yy11itWhMGcqKUTMSBuQSd+vuFl/GvAhRY/dhZZv6mkfDDyi3qf
	EMnOzhKajIfo5ricwLc49KWk5aUQpSBv12u26pHe+1hw1O6hD8o9iycUGA==
X-Google-Smtp-Source: AGHT+IHVE00Mt0v1z5+mmTTNYLPe5UK8SIPVyMKl2n4GRwE7HrCnlmo7SOyLRDVqCwMYKt+bhmYgSQ==
X-Received: by 2002:a2e:9804:0:b0:2ef:24f3:fb9c with SMTP id 38308e7fff4ca-2f15ab2a4a3mr129487251fa.38.1722966107467;
        Tue, 06 Aug 2024 10:41:47 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3cfesm567908966b.2.2024.08.06.10.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:41:47 -0700 (PDT)
Message-ID: <780fc4fa-ffe6-40d9-b5f1-ae7efb9289aa@gmail.com>
Date: Tue, 6 Aug 2024 20:41:46 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/4] wifi: rtw88: usb: Update the RX stats after every
 frame
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
Content-Language: en-US
In-Reply-To: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Update the number of received unicast data frames and bytes every time
a frame is received. This is what the PCI and SDIO drivers do.

This has an influence on the power saving, bluetooth coexistence, and
(in a future patch) the use of RX aggregation.

Tested with RTL8811CU and RTL8723DU.

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Add Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

v2:
 - Rebase on top of the latest rtw-next.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 1c40d46a7eb4..10f1d724370e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -581,6 +581,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 		skb_reserve(skb, pkt_offset);
 
 		rtw_update_rx_freq_for_invalid(rtwdev, skb, &rx_status, &pkt_stat);
+		rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
 		memcpy(skb->cb, &rx_status, sizeof(rx_status));
 		ieee80211_rx_irqsafe(rtwdev->hw, skb);
 	}
-- 
2.45.2

