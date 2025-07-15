Return-Path: <linux-wireless+bounces-25499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3741B0672F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 21:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48914E7AC7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 19:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2741B672;
	Tue, 15 Jul 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5dAkkBA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B14A11
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608785; cv=none; b=O/zwRfzl26GGI7toY7WWD6/cduZfdnQ03elQfCw0klkszUf6fLZPmyxoqu9wSHmbTlooxb4+M8MvIw84/krkJsSLzHxA9Tsy4DM22VTHxh8k3mfWldOxNnMAkJPmhZQI8vwk9pgmmSja6lYw7QSTCEEaJr1GaQof/0OK7ujthyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608785; c=relaxed/simple;
	bh=o0Dw6z999QCDssAkPgkSRmJH5p7dW98GysuPmaHNLBY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EsVwd8yKBmcf8SNkIk35rDQLZ/7rEbEDx9QELjOA0fxIyWLw4WXnQHEJUdBz6uxv+8D02VfTrXfonK6Cf4ilczo5IylZJ0exbkcS9xnk6CqiAQvIIEYNiv4TnaeCDhi8tADPwqB2pRLa1w2xzK5S0BMwhwZD6oG8MnaoZN6YgWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5dAkkBA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0e0271d82so1050890066b.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752608782; x=1753213582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eK2HCyZphB5bFqM1EjD/A+9nfXOARsTutPayGnXcX3M=;
        b=Y5dAkkBAr143aiIio4pY1PhiryyO1Qf0FRbvrfjt7DbF/tmczrPdMJDzmM9Bw+5c9t
         qHY7UkOxrNljMy0gLg0R7P7ZUjLuqI/1/lPFXrUELuEXkZJlTdjmWCOXwDvY4E3u+E1a
         /HUyRH0rNh8pqb5kbfooIGP/j4AwR39zSpiLDjzveTaxUH3q/tleMGhLm8mQqCKIs3lz
         vCg0ynqUVUZ0UdU+NwTAvSh3kqYyGqwCGZJbkt7tPf7vdKfOzQjJ8WTsWLiCQrGEVwMq
         qCj9lE/zs4VTdI+aug5JzrEz3749gzgDP77yp1to7Csg7AR3RVbQKMqLxO72AfV9e4g1
         F56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752608782; x=1753213582;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eK2HCyZphB5bFqM1EjD/A+9nfXOARsTutPayGnXcX3M=;
        b=V/0rW58tIHQvfNN9GJxzCEmH7n/KqUN9/zW0OdffVZmELXNAkFeNVBGUgxPNbqFfk1
         QaOpj6ozd7BD6A979cLLyVuYhojks1En6ZbRoCKHGzlMgWdaIsbPqTWopnYKxg32D9X0
         38yJ5y5zKdjooFzj2AhxqeEkQh83lwDuZD/WZbv+JW3T25LBi7z83W0vumyYNNaM+Ugs
         UfOtlkmonJ/k6BSfIM01uIGFj8IJJ1ld7ygjmS0ZkZTcS+tyylAqufwHgHC99VTEF4hh
         MYTwElJfUmG5tUvc3L8cxzq4v6Xua90cB0Ml97EEQiEDhBaAJGbEL5KTp489QIeKodji
         i34A==
X-Gm-Message-State: AOJu0YwBIA6RRhkzoeB94P9GIEHPEw8v+kTr6DJ35oiElDGQiTt64IXT
	QmPbdskdkRsIrF5fsmPk1uRRqygHdne/88ezHb4dzd0YCTXOwD0FgmnLTArYXg==
X-Gm-Gg: ASbGnct+Vq+ENKpaVDuF1CIF50DhNKstGv88gKpCB/Yj/bUXmDmsY1IVulwpj0F4rlk
	ElvSCeMCst4FTsiKghs5SCxY7dtFTw3HqjpxmfeKOuM31skTYuYjzd8dr4iZqqk4exvIb8Mjoxi
	FpPsgc3m13D+tNydEcUryhcGFsdDeMA1D6k3IZkdppeJPwPZUCYokSFYAvd76t+mE3u+c/mPfvr
	Z4mzddeqPwi2aYKyxe191v+q3KAxyWdqUOIWWAc61amz6+x2dcncAoHmsOCA8BovU8krfnlXY9A
	il4nSSB78oHCHvF91agxlbAgTmtq4B8DaUcSR8nGQcMfK10aXryHNdlLUk/FhRCsyJk+GRbft6M
	Bpw8i/Xe5/8l5xMKL5MLboHFxnivQLQ==
X-Google-Smtp-Source: AGHT+IFMHB7GyefuVnVGBjBGfusiZewmHiv+BdcMlMibNNIn+vjBoKCmK33DQgW6Veai1PciAYsxtg==
X-Received: by 2002:a17:907:2da9:b0:add:f191:d851 with SMTP id a640c23a62f3a-ae9c9aeb321mr80224966b.32.1752608781772;
        Tue, 15 Jul 2025 12:46:21 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645c3sm1068572666b.99.2025.07.15.12.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 12:46:21 -0700 (PDT)
Message-ID: <af0b25d0-ea67-455e-91f2-8e4c18ae4328@gmail.com>
Date: Tue, 15 Jul 2025 22:46:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 2/2] wifi: rtw89: Lower the timeout in
 rtw89_fwdl_check_path_ready_ax() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
Content-Language: en-US
In-Reply-To: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the chip is not powered on correctly (like during driver
development) rtw89_fwdl_check_path_ready_ax() can fail.
read_poll_timeout_atomic() with a delay of 1 µs and a timeout of
400000 µs can take 50 seconds with USB because of the time it takes to
send a USB control message. The firmware upload is tried 5 times, so
in total it takes 250 seconds.

Lower the timeout to 3200 for USB in order to reduce the time
rtw89_fwdl_check_path_ready_ax() takes from 50 seconds to less than 1
second.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Lower the timeout for USB instead of increasing the delay.
 - Don't change rtw89_fwdl_check_path_ready_be().  It uses a larger
   timeout than rtw89_fwdl_check_path_ready_ax(). Leave it for later
   when I can test it.
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index a731c242f389..7e07df4beba7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4697,6 +4697,7 @@ struct rtw89_c2h_rf_tas_info {
 #define RTW89_FW_BACKTRACE_KEY 0xBACEBACE
 
 #define FWDL_WAIT_CNT 400000
+#define FWDL_WAIT_CNT_USB 3200
 
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f6bbc796329c..dfaf33173611 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6932,10 +6932,16 @@ int rtw89_fwdl_check_path_ready_ax(struct rtw89_dev *rtwdev,
 				   bool h2c_or_fwdl)
 {
 	u8 check = h2c_or_fwdl ? B_AX_H2C_PATH_RDY : B_AX_FWDL_PATH_RDY;
+	u32 timeout;
 	u8 val;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		timeout = FWDL_WAIT_CNT_USB;
+	else
+		timeout = FWDL_WAIT_CNT;
+
 	return read_poll_timeout_atomic(rtw89_read8, val, val & check,
-					1, FWDL_WAIT_CNT, false,
+					1, timeout, false,
 					rtwdev, R_AX_WCPU_FW_CTRL);
 }
 
-- 
2.50.0


