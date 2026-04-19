Return-Path: <linux-wireless+bounces-34983-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKfgL4Dc5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34983-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:45:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FAD424388
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 040A5300406C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542592AEE4;
	Sun, 19 Apr 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl5P4Ptm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A640DFD7
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606329; cv=none; b=petXnWE9sQrCY6IA3ojTzV7t3nGBZz1iOsfpoCnpVQRoK/aaXV4KyMXk6lh06eW1ZuofW5STaW0AbvKEKoziS+sCKG/IKpJR4sjNNBy5LQruWDgjqSJdYAkn6ROxC7555GTFA2MC/yLENlwWMJ/Hh+PWr0PygL/V1FUm6Ngbc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606329; c=relaxed/simple;
	bh=qJBN5H7Zm98IhZDmdkMdmPHVj1bXlko3j37s3hrweYY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mkn3P5c0S+zJQ2/SF2uFc39JxaHy9gy1jkR9r3AC9va2PUNia8ddLJAL2vl0843EPYK1p2M/0hfdZ8v781+TtLNu1iS2aCHUuJAAS8e6hhN4L/zegNwLa0mVN0nOA23MsoQgrqGDHwWl3F0y2x9TDOMd2JBkVKHdH5RNGBPO0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl5P4Ptm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso27698815e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606326; x=1777211126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7jNP8v6Bek5z8UAdzzdRvsvic2JgUGUi+8GH9YGUvZc=;
        b=jl5P4PtmUN5g1xMm1Fa7xb76aLA2SGb9b7m2XknxY8bXCB9Xa89T0TVvguuH3kleGo
         JG6d6VLPY6aV4oni5lQnOLTH7uX5WqwV8ThlMi1265O0cg9R+g2z4s2dqJLbZF5Zzhep
         B5OP+uXtVFpt2zaLo7Fgok+D+1E1t2fOTbVpM69zXVzupwycfVA2DPYYytoy+RWIGdyI
         tLbyhWPTVKiMh7uWlIDQ95Kxk5sWuu6eAlRvBoGoDxNtqCTh1C0XLKA53CSuDqHM/YlA
         3GoLxFi6TEYhig5aZAbtR6Ef0mwIn7mk14IIKhUj98Yo+uFleVNxFKnY0fyfr9Kbo6RE
         jylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606326; x=1777211126;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jNP8v6Bek5z8UAdzzdRvsvic2JgUGUi+8GH9YGUvZc=;
        b=TiTH090QQWsDFh9qhHLtzUtnpm4prituUJ5OaAcX2fQMEohXppa8GXy6ekJ8R0v9CP
         WlIOOwlHNAzBQoXTJFaF/EIXuMu3+YPX8zaKaziCtZ+GI3JrUBdsYGFC1MPX0qN8oZEm
         YIHyjR9nEXBykwXn79trMMHNuHYXyVsRC1aTMEwlltpoSATzycJyfNjhJXXBGGCRbiyR
         6+eJHROcPtX5gpI9AOf+8PoWXSjSSAQmx+2zl8i5w1m5yQSB0h7ZYB/spup0h44h4F10
         HDotj4C0EjAIZXzFAXi6NHNQPV/uVdrKS6sKDcWD6jNKSaTAB0PJbW+NjfNspVN2owas
         YiPg==
X-Gm-Message-State: AOJu0YzMuhBAvdNJAqgslLMDApqUqTl5kJ1+90EGQYKgPFfTa8MnDMh0
	6N0zCRvVp0iMOxUjlvsTkN7EDBPsh+sXb7GWQD70Lig5U2Q0zKVOGH7PZHJ9DQ==
X-Gm-Gg: AeBDiesC02xZuJvYXE/04eUrxwnmKmqJXafgI/hOrDo0CLwRDFtvaLArgpUPjwiWxCk
	nOQzU1xjjW0C96si6jyNAX+H1C+EbJANu1F7c6f+397YjUrPRB2xrYI2c1vDgRCRlxzdT9mUgOi
	yFIBpSOxLsZ1kgERVPgZsSdheppdkloYuiGyhIVim0I+qurHGgW8z99YBEmw4sAQaQwzqpUBC/e
	xrNhsVjEg0Kd3SEHlax5emczpvzPjSq9vxgC2GuCm5InJLqqlzmS4lY9my0C4FrnGOYxS4BbGGC
	VdOKVB5/UttvDZKfou89IV1lvHu0lqMOhfUcYYp9pe5rdhMtSH4DOE67zT/YnkH2WD8WvWkdgqy
	LWIyp4kZizH61jORSNUrPo3/lKAB+z5Rq9nplnpi3VRot2KFy0FfdjZSHKo8bQnF+7z9jA85PkI
	4SHnQ/ZFAzynRGwd0SNaDkEwlX+GVcHz6x2ZizgmVp
X-Received: by 2002:a05:600c:6089:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488fb8ba594mr132467065e9.14.1776606326047;
        Sun, 19 Apr 2026 06:45:26 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c789sm64310235e9.5.2026.04.19.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:45:25 -0700 (PDT)
Message-ID: <588bf309-4b92-454f-bfd6-5e81248abee3@gmail.com>
Date: Sun, 19 Apr 2026 16:45:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 07/11] wifi: rtw89: Let hfc_param_ini have
 separate settings for USB 2/3
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Language: en-US
In-Reply-To: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34983-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: B8FAD424388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTL8912AU needs different settings for USB 2 and USB 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Change rtw8922d.c as well. It didn't exist when v1 of this patch was
   sent.
---
 drivers/net/wireless/realtek/rtw89/core.h      | 2 +-
 drivers/net/wireless/realtek/rtw89/mac.c       | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c  | 2 +-
 9 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fd29dbbb120d..2d7d3a11be16 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4544,7 +4544,7 @@ struct rtw89_chip_info {
 	u16 max_rx_agg_num;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
-	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_TYPE_NUM];
+	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_DLE_TYPE_NUM];
 	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 54aad37485d6..8d5375ec33a2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -898,7 +898,7 @@ static int hfc_reset_param(struct rtw89_dev *rtwdev)
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	u8 qta_mode = rtwdev->mac.dle_info.qta_mode;
 
-	param_inis = rtwdev->chip->hfc_param_ini[rtwdev->hci.type];
+	param_inis = rtwdev->chip->hfc_param_ini[rtwdev->hci.dle_type];
 	if (!param_inis)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 84bdd39b3ceb..ff4113eb9114 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2600,6 +2600,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie,
+				   rtw8851b_hfc_param_ini_usb,
 				   rtw8851b_hfc_param_ini_usb,
 				   NULL},
 	.dle_mem		= {rtw8851b_dle_mem_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1d4f1df524a1..ea4d22616512 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2336,6 +2336,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie,
+				   rtw8852a_hfc_param_ini_usb,
 				   rtw8852a_hfc_param_ini_usb,
 				   NULL},
 	.dle_mem		= {rtw8852a_dle_mem_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 5e8738bb2dc2..417b1502a2dd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -931,6 +931,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie,
+				   rtw8852b_hfc_param_ini_usb,
 				   rtw8852b_hfc_param_ini_usb,
 				   NULL},
 	.dle_mem		= {rtw8852b_dle_mem_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index ab4263bc8b9f..7d86e9598ca8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -776,7 +776,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= {rtw8852bt_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8852bt_hfc_param_ini_pcie, NULL, NULL, NULL},
 	.dle_mem		= {rtw8852bt_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 40db7e3c0d97..9c2c05f80393 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3126,6 +3126,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie,
+				   rtw8852c_hfc_param_ini_usb,
 				   rtw8852c_hfc_param_ini_usb,
 				   NULL},
 	.dle_mem		= {rtw8852c_dle_mem_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 2bea44faa109..b247980cc9ec 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2969,7 +2969,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
-	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie, NULL, NULL, NULL},
 	.dle_mem		= {rtw8922a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index e3b77cd23514..96e7b70a3b93 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2948,7 +2948,7 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 	.max_rx_agg_num		= 256,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x5f800,
-	.hfc_param_ini		= {rtw8922d_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8922d_hfc_param_ini_pcie, NULL, NULL, NULL},
 	.dle_mem		= {rtw8922d_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 8,
 	.wde_qempty_mgq_grpsel	= 8,
-- 
2.53.0


