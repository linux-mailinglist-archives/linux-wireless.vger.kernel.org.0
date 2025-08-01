Return-Path: <linux-wireless+bounces-26083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D9DB18832
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF481889C23
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27E1F4628;
	Fri,  1 Aug 2025 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh6Z1bKf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580F15539A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080625; cv=none; b=ibYLx9AMRwblh2Vh5R0lT/k8fgBFp/anj54HHD3U3zmu+cGd+/Zc6BzI5svnM1vPLPUi314e5MWwEa6ja54GJlpbj36+8pQsgRTu7uOnZJNTo4+yBSfZlSYSC1lByeM4Y7z+Pa/v/7Y/X/+uECzl8snjb4qNnEIUeb+pGRhn2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080625; c=relaxed/simple;
	bh=QhsOjUysw6N/nbNicJF2ysnth7ET6Ex+QphPALMdrUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XL6zQtZkMXk630Fyx9HJod64fmW9FEinsgeGyit59qaJkutlKDHfsi7VVpO3dGMvcgmyJOvlP32LFZH2PSmrUM+XetPuwDH/lXXw2FAx8iZNOQiJwq720jozOsKyjSXtzlFKR+p9P+Un/aHBqpyNffdkNLAIFdCtNXF0PdLaTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh6Z1bKf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so3556653a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080622; x=1754685422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gkr96SgxxE2n5pKl85HzsaRr4cV/4F7PHe/kvJPQLTU=;
        b=Kh6Z1bKfYiDZaXKKzkfgGmXmhzffr0OY3U1WgLeChwWGwU8IdrSx8G4fIo7f2+D2O+
         K/cO6pcY3ONjADX4yJ8sH40s6uXRTysKDRYr56z2O4j/DBC5hRCIQ19DRV5GZ8bLQgcL
         XCIrv9bjXn1c/YAqoMx0TjV+KEQZahVsifU12cQoHfK/UJFTlCyAn0o5/ssxRdX0JbA6
         ZvmwukISB0pF00Al+7mXn5/bpNWmTTVBVGC1XtH9VzlTRm9dg0CYuaCitqg6jt6wSVL2
         Hjo0ptNlA6y/UIrV5mrA877HZT533E34yr0+oHQ6O01KCthyYX0vHPi4RhBfNKy18Axe
         Wt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080622; x=1754685422;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkr96SgxxE2n5pKl85HzsaRr4cV/4F7PHe/kvJPQLTU=;
        b=ncgoojj8Olgjn26sK89wgivicS7HZXc74kkkpcZaH0s8W4dzPqhXkAVCU2Z4v4jzAg
         p0WLj6LZlCtfoYpFRXsr83PD/Ns6M/CZcgKsYwXwysKloO32Uada/BxY1PHMiDPdzlBv
         pY3zGGwLNC5o1NERg2mHD86vrLZPP7gPACYLsztDmvaeRJqjw0J+gcsyjl+Cv1zTGYqO
         uRL6C353cYSWc8AiQMEDD2YfZNwjwIv9tDzE4W5Ww2bGeATqihdq6GvNWo72tvlR6p0N
         /UDmC/vjwuGHF27UZ5Qk1uMTUCF2XXHPtxzS8U8SJtzOTNtsFNn5Kt9F8ytL1aSpYFA9
         dQWQ==
X-Gm-Message-State: AOJu0YxUlcyXmxA336ZjFKGT8HPvdoor5OWKjqXc6NGlxe4Gm0YgwTwr
	yHwEbc6AeXKfvYcDgPYqK/DNdviC04VJKyKlBuDOisQjDjM8osDGK4BdrdSCxg==
X-Gm-Gg: ASbGncuKUvC+ePNCKFoDyml6+wSM+1K0l9zVt/jn1PVVikf9Okur8bkrcd0jOXQbZci
	VSey8tA9j+50clERtFEpMWtWyqZ8BaEJizFimVBEnQP3oCWLVBOBtf60O8wA7VccHNoiL4gc4UK
	+9n627lzIXEwA3ix1IstXpYwTA1YFqMG18zuVt1g9shTpHjyOQjAxrq8XOlf9t4Kmh5oMbMhBsr
	/DpgVO+wfgBRZMuPMYsGMCOTc42WURmetUeuaYtYHggeeVPRhDubm74rt4cklTI53e8gh/0fcgP
	sQ6wzHLbBm8jW2kttADCNGhgZ9B5VbiET67vz3LPHVfLv6zqvfq3coP/3faYOCv3jf/z2WfYsS0
	NhLZYfZo14AUnxI+V9AGnEPwR8JpBxg==
X-Google-Smtp-Source: AGHT+IEhdKUwUxXigVeLmxrJ9nQux5wx2lkZ4vVSKEWTlJIzmLrt84DmlWRkAk0GClDjAE50CnoOXA==
X-Received: by 2002:aa7:c64c:0:b0:615:b6b9:d877 with SMTP id 4fb4d7f45d1cf-615e714dc7emr471850a12.22.1754080621983;
        Fri, 01 Aug 2025 13:37:01 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15a66sm3256471a12.16.2025.08.01.13.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:37:01 -0700 (PDT)
Message-ID: <f7cd0c5f-e670-4091-9b4c-de1a869ebea5@gmail.com>
Date: Fri, 1 Aug 2025 23:37:00 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 01/11] wifi: rtw89: Fix rtw89_core_get_ch_dma() for
 RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It seems RTL8852CU can only use TX channels 0, 2, and 8 (for band 0),
otherwise the chip stops working after downloading at maximum speed
for a few seconds.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/txrx.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index ec01bfc363da..318fd0ac8726 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -734,6 +734,25 @@ rtw89_core_get_qsel_mgmt(struct rtw89_dev *rtwdev, struct rtw89_core_tx_request
 
 static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
 {
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB &&
+	    rtwdev->chip->chip_id == RTL8852C) {
+		switch (qsel) {
+		default:
+			rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n",
+				   qsel);
+			fallthrough;
+		case RTW89_TX_QSEL_BE_0:
+		case RTW89_TX_QSEL_VO_0:
+			return RTW89_TXCH_ACH0;
+		case RTW89_TX_QSEL_BK_0:
+		case RTW89_TX_QSEL_VI_0:
+			return RTW89_TXCH_ACH2;
+		case RTW89_TX_QSEL_B0_MGMT:
+		case RTW89_TX_QSEL_B0_HI:
+			return RTW89_TXCH_CH8;
+		}
+	}
+
 	switch (qsel) {
 	default:
 		rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);
-- 
2.50.0


