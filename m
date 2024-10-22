Return-Path: <linux-wireless+bounces-14337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0D9AB4DC
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2BA285590
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0B1A726D;
	Tue, 22 Oct 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux5a7iru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F8199937
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617631; cv=none; b=GDrWYnBPKONRPPdLy5kOpQap52ZKIa+aH3Wihpil+Adg3ymhpTQ/4NiZgjAecTrvfQz4y9zEVJLrPJqto61RrQmDJU1KeTjOVX7CJ/NyL7w/E6GF/adOinLWYvpVYDEOz5aifcrQN3Uufqze+dQQtNBDzHgypMmrzo11egDvRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617631; c=relaxed/simple;
	bh=vh+R1Zd4MTAaZaAju8U8hIov+Y1RPNtcyZfp/WzqES0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JI4g+V8uIPDtPmYKIkjhEZnxdH/RE6hakeQXG1W1W8NB8nf1QnPfwWhigkcKgoF/C5RP4/GLV+PFlRaCNgah4r+BX6PDm+2TRPcC/IetMX8rO1SzbM5gA4TtE2JD+fKEGBfLynHUHaK2QmzAFGnS0C1vExebNDSrTz8YgDmc29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux5a7iru; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so6247266b.1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729617628; x=1730222428; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzoS4n/QIruBE5n7YwqmKIU7X7obCPkyIMQstWa5DMQ=;
        b=Ux5a7irulCs5RB3ECkg5ZHZkqYHSI6kW9C4wtVgqku9UOH2dF5eCMDcY+aBH/v2aSW
         DFbEh7aC9qQbAjrOR97wLu8U+xE+Me2oFRDrtIsD669m8s+RhpP5QHfP4b7xuAhFv7Jl
         DWYppKELFSF82iu9GUK7QWh0jIVwjH7El8wMTVGAIO3dFjruOSBcNa9er1TdRJnDuulj
         UgRXhESB1zGKFNLw8WgJlAhhR/3HvxMh2Fa2GOjv/ObxLeccJl2kLk/zrXx+qrGiBd18
         IAf0sSZ1IfvI1WLiXxfBhKj24t8cMRlnUex4bvGagvsvs+AsSTrrptG6IzD2Hv/c0zMB
         ggbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617628; x=1730222428;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vzoS4n/QIruBE5n7YwqmKIU7X7obCPkyIMQstWa5DMQ=;
        b=DbmTaHeaEJiXaCl6lQyBz6yR+89y18/VGvw0W8RJBRNR9DlE9OrqzdQze3inTzEaJJ
         A5h+5kdCe5Y5UiK389PlDYipGzO1dAR458/7yZe6pfPrcxQOBACkPMNNoJsOQMk4HN4G
         e/O2bBztYOuLHpQokG2rNhawno61L87YcZTuv5t20eivv9oPp/5D5cYgwm0hAcXeE9DR
         GDa6SO+/PxYvt/WmC+a/Fn2J4YwuksjvRjWs5krBOKRfTnyHHFVyCM2W6cJxkzvLo5uh
         XnMdyfxREivs5f0CL8aW+UKUILq7jaBlWubSh8kC+f1F8MnIrDD5aJ7JPQugeBv69kgy
         Q4oQ==
X-Gm-Message-State: AOJu0YwzTTVOzonsKfWtRvEcEZnZjpkIsCjtlWJFTV+Tk7sfnqf1Ql9b
	3P7SkvK3E7eRR55Gd4x8VREyJN8Fa2uRXxWNSWK22FQbNMZL98WaHciX2w==
X-Google-Smtp-Source: AGHT+IH+fV2P0Y+5LSZIjeAJde2PrRGFLFDOlzUWwYBkCHJXvd3ba0nTBpowDIHLlM4ecfJz0rCBYA==
X-Received: by 2002:a17:906:c116:b0:a9a:1575:23e3 with SMTP id a640c23a62f3a-a9aaa5428e4mr364704566b.19.1729617628069;
        Tue, 22 Oct 2024 10:20:28 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e54sm363413966b.102.2024.10.22.10.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 10:20:27 -0700 (PDT)
Message-ID: <f7e1e448-2c9b-498f-b8b1-a14dd967d7d3@gmail.com>
Date: Tue, 22 Oct 2024 20:20:26 +0300
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
Subject: [PATCH] wifi: rtw88: Report the signal strength only if it's known
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8811CU doesn't report the signal strength for many (any?) data
frames. When the signal strength is not known, set
RX_FLAG_NO_SIGNAL_VAL in order to avoid reporting a signal
strength of 0.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 1de93fc9efe9..90fc8a5fa89e 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -234,10 +234,14 @@ static void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 	else
 		rx_status->bw = RATE_INFO_BW_20;
 
-	rx_status->signal = pkt_stat->signal_power;
-	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
-		rx_status->chains |= BIT(path);
-		rx_status->chain_signal[path] = pkt_stat->rx_power[path];
+	if (pkt_stat->phy_status) {
+		rx_status->signal = pkt_stat->signal_power;
+		for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+			rx_status->chains |= BIT(path);
+			rx_status->chain_signal[path] = pkt_stat->rx_power[path];
+		}
+	} else {
+		rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 	}
 
 	rtw_rx_addr_match(rtwdev, pkt_stat, hdr);
-- 
2.46.0


