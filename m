Return-Path: <linux-wireless+bounces-22413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5ABAA894A
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946A617353E
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F794224CC;
	Sun,  4 May 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrH993wA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33D23A6
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746392009; cv=none; b=dxYvZLcl2m8tb5X/qQ47QuyWDeuz7rhDL7wx1GCbAgCMp4vkJKuQ6ygLQigNmumzBmJilGn2KCl0cbwvh4OrUBjFuROQpeote3CmOX3s2eAWfEkYlmLo24lLL31sr10TaBz5VPaVQrLx7BgdfD+01H6EVZ7IBqB2mhVKfY8MUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746392009; c=relaxed/simple;
	bh=L3eqjb7L8REoZjzuR6jADa+RoQj/meG4Zws/NchX5uY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GnLpamtcBe66OoNQw5EglAbSgAb/NQSuoQb+gRIDtXtzU8/GBMpohzAnt4B92LhQxXZ+FlfQaRWtHoMEFasn+dK3GRCfTR8iZcYKBw7PZvHrOBr5SwHbCQFH57JmThNNx3JO6736T47pyP4CvdxjHR/XIBPKgF8T+uiw7w8fjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrH993wA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acec5b99052so713239066b.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746392006; x=1746996806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+SO12d9JOJmBU9OT5wDbnW1N1cVoFUqJduzlNA0CIkk=;
        b=SrH993wAtNrEM0BWHUaXEUSy6MXyZXoDFNQXO7tOnEJTw5ES/i/lURgiIOB1wL2Vn8
         x5RwyZpKGczwDdfGMTKhHphZT/zupL/gmI4vtCzVaPxBabSzd+DmcABAEdcABf2gP0L4
         xRewTJv/DcQFXVasLjPFIezPIo+mk+Uha3nPSPDwTXHKbGZXDJodxEhz1zeHx51yLR4A
         chLwXK0lAOZNis4l45LsYBAB3L8xd2LjuH3/VB2HlS/gE1rfe4uSfELiamt9ciPYPIq5
         ii3CY0JOETcDmsZnEH69Jjin/UD1wZlsrmxnz8BeynT3lD5ult9T/UdQzqnvfVpPOPvP
         DRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746392006; x=1746996806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SO12d9JOJmBU9OT5wDbnW1N1cVoFUqJduzlNA0CIkk=;
        b=wQajbtVtWhTyBwcK1ZFZkxKnwAhZik/U3LMoQ2hBYz142wLvPcK2lBmgcdEDqPWPuK
         hQhDvO2fQPgps4OllG7RniSRQ7UN+9ZOFBsYf44F1ZLgrSliZiM/CYYm3PJRscOl7kCX
         NT+X17Ft4KwpfasgvzXPOkcNKaaLsdQD9oDNUEZUpnfdd2fz9i6kqBa5VDImO/TD48fL
         8HuSiXA88l8rJVKYcyHQqJ0uScor/apF6GdQC/ISxcwwPqmHFQ55bo0w3evSvXXN0iO4
         ATs/9pq4Ye5bCP8COefxfP/fekc/n0Ke+w8aUruBjRFSUbA6DtXTYNi6rJidT+NBjT1j
         Z7dg==
X-Gm-Message-State: AOJu0YwnfnOsdrfRKEcFF2BCrSc/IEtpoyNuK4Dez79jU26Xlqczla/C
	7/ySxYIDiaqMHI7UEN5STSGWU5nUetOWuhYes4iA9VtgjfyHaMKTnKjVvA==
X-Gm-Gg: ASbGnctcFh3nDMvLQ4daEUm7eEEmd67NVJPDFdL5UrymMWjlatQ0jvzUrJ2Acn4cEZB
	H1z6IyGZ1o9JlaMK9LWpIE9eKmSV5iMNmwS8+dpyZHjE9bIlnIETK3z/KO9KCqNkZlsiVZ7BXVm
	BJuosSTxVJ8dOf/cQA3Oai3aKUB3eLzobUaKHSOqpBFuSI7k1ZvBvFx6hgn+Qw+xTUNmKP8msib
	bq358eayTwNFCKUcLf6tqlUbC4k+TW0Khd7YgzpG33aC0SgrRYNhvyEy3ZQRgERB03+2ni2UVQE
	9azOYm+ByEHy9Ywv08Sz3+Mtg8oA5ARwKw9yC7Sj79+xzOKciA==
X-Google-Smtp-Source: AGHT+IHhk5l5Q6SKtm0+68Puz9W0LeQiWFxxf/jTwBxJMNzuxyhr8auCdOhhw28kqvhbDBck27Fzgg==
X-Received: by 2002:a17:906:c10b:b0:abf:6d24:10bb with SMTP id a640c23a62f3a-ad1a4acf9a7mr468771966b.44.1746392005593;
        Sun, 04 May 2025 13:53:25 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895402c7sm367419166b.164.2025.05.04.13.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:53:25 -0700 (PDT)
Message-ID: <5be206e0-a8b1-4500-ba65-6e6427f84bc0@gmail.com>
Date: Sun, 4 May 2025 23:53:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 10/13] wifi: rtw89: Add some definitions for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add various register and bit definitions which will be used by the new
USB driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h  | 29 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9d9e1b02bfc7..a3b83b1a92eb 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -381,6 +381,18 @@
 #define B_AX_ACH1_BUSY BIT(9)
 #define B_AX_ACH0_BUSY BIT(8)
 
+#define R_AX_USB_ENDPOINT_0 0x1060
+#define B_AX_EP_IDX GENMASK(3, 0)
+#define R_AX_USB_ENDPOINT_2 0x1068
+#define NUMP 0x1
+#define R_AX_USB_HOST_REQUEST_2 0x1078
+#define B_AX_R_USBIO_MODE BIT(4)
+#define R_AX_USB3_MAC_NPI_CONFIG_INTF_0 0x1114
+#define B_AX_SSPHY_LFPS_FILTER BIT(31)
+#define R_AX_USB_WLAN0_1 0x1174
+#define B_AX_USBRX_RST BIT(9)
+#define B_AX_USBTX_RST BIT(8)
+
 #define R_AX_PCIE_DBG_CTRL 0x11C0
 #define B_AX_DBG_DUMMY_MASK GENMASK(23, 16)
 #define B_AX_PCIE_DBG_SEL_MASK GENMASK(15, 13)
@@ -460,6 +472,17 @@
 #define R_AX_WP_PAGE_CTRL2_V1 0x17A4
 #define R_AX_WP_PAGE_INFO1_V1 0x17A8
 
+#define R_AX_USB_ENDPOINT_0_V1 0x5060
+#define B_AX_EP_IDX_V1 GENMASK(3, 0)
+#define R_AX_USB_ENDPOINT_2_V1 0x5068
+#define R_AX_USB_HOST_REQUEST_2_V1 0x5078
+#define B_AX_R_USBIO_MODE_V1 BIT(4)
+#define R_AX_USB3_MAC_NPI_CONFIG_INTF_0_V1 0x5114
+#define B_AX_SSPHY_LFPS_FILTER_V1 BIT(31)
+#define R_AX_USB_WLAN0_1_V1 0x5174
+#define B_AX_USBRX_RST_V1 BIT(9)
+#define B_AX_USBTX_RST_V1 BIT(8)
+
 #define R_AX_H2CREG_DATA0_V1 0x7140
 #define R_AX_H2CREG_DATA1_V1 0x7144
 #define R_AX_H2CREG_DATA2_V1 0x7148
@@ -1026,6 +1049,12 @@
 #define B_AX_DISPATCHER_INTN_SEL_MASK GENMASK(7, 4)
 #define B_AX_DISPATCHER_CH_SEL_MASK GENMASK(3, 0)
 
+#define R_AX_RXDMA_SETTING 0x8908
+#define B_AX_BULK_SIZE GENMASK(1, 0)
+#define USB11_BULKSIZE 0x2
+#define USB2_BULKSIZE 0x1
+#define USB3_BULKSIZE 0x0
+
 #define R_AX_RX_FUNCTION_STOP 0x8920
 #define B_AX_HDR_RX_STOP BIT(0)
 
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 70fe7cebc9d5..3c3819973daf 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -73,6 +73,7 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 #define RTW89_TXWD_BODY0_FW_DL BIT(20)
 #define RTW89_TXWD_BODY0_CHANNEL_DMA GENMASK(19, 16)
 #define RTW89_TXWD_BODY0_HDR_LLC_LEN GENMASK(15, 11)
+#define RTW89_TXWD_BODY0_STF_MODE BIT(10)
 #define RTW89_TXWD_BODY0_WD_PAGE BIT(7)
 #define RTW89_TXWD_BODY0_HW_AMSDU BIT(5)
 #define RTW89_TXWD_BODY0_HW_SSN_SEL GENMASK(3, 2)
-- 
2.49.0


