Return-Path: <linux-wireless+bounces-33997-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCeZBCxrxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33997-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:21:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A62339153
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FF953004DB4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8331E83D;
	Thu, 26 Mar 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcdG81Ms"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA393C3425
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544858; cv=none; b=k7UGSY/LVzDloBQhFKk55bU9B6tU/eGdqiPmFlXiqLSoD4ukaakzX0s6vkQq6ZbahFhQD28nMmGnJ/Fyuc5y01L4oSD/NC5jsGfrvOtipxml6Mxr585lQxFGCZ51zzc7EhVJgF7h0auLY+9JkYQ6rkWnr1WYogj8SuFSD0JGzGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544858; c=relaxed/simple;
	bh=C155tWIWT4JeNniOyuatpTRGW7MZT7Vnsd4jTQZgZj0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JuGTujMZ3auaZz46IVIuSYuGKHbdX3GlH1D2ganqNf+3r/0i+0oYdsTSS66hUcnMCqLXAIzc/msPcaPHrzHL4VWP9t6zq7yfc196Fg3icX37Yp/0L9OGTwLOe3HveTQvBC20rKw6jHQCcpnWHuHQ8Bcy6fpkzKNt9Ms6M3txOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcdG81Ms; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso1206317f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544853; x=1775149653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4w3oExgm8pJcvcwVn4GCPAhxA1y4VO2PDHYidUj22gc=;
        b=mcdG81Ms4Fe0eagZy0lUP3ZzL3VDRKc5IF2Eu4KN1v3S2iIUbBn2YVo6xvt6ZfZejj
         hncnr0X+B4cUhwAk51Wsf9q1pv+/+Ekty82mtyaGotPHttht9STVhaUWNN9uuEdkX3Zx
         1KjzIcXlYzVyCRUdETvQenH4IwCgOqIDnErcbXAuvuXSsl7Chd3oad+CzquVB7CyksXl
         HH6dRBG2EGGFSHEoRUw52sfniSTvdiTvtKxsrqotG3yswx3a4XHmpkjf6b7zRRwp36Zb
         QAitx5go7xi1OwtPi3MtjZMlQ8oMKOb06C9ooYzwxrI84OehnFJMW91iIVi6Bxh4KfQt
         opdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544853; x=1775149653;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w3oExgm8pJcvcwVn4GCPAhxA1y4VO2PDHYidUj22gc=;
        b=eLsMzJvpwo8upVZjuiGVUbaNOY9RRw9rRk0uejrV8P4pbFYOjAHATbsES43r/1/Q6l
         Ukdaglzu8KKOn++3LT+YK+j7W8uRsm5mA/GXLG6ew8pmPD3o6Hh0wuTT5Bi6cUxQfCwd
         mpfat+6U8/9ggQRebieuDIvH3cDfT0z/KCu5I1enH2J/Z7sigTVMeiTJz3vN1ZreX7Uv
         agCFbweQoKuPkCpSugjBXI+FOfhI5Odkt+EPMctsg1huEUIb++XOdJ4fgseVeFVvInnl
         D5l5FoJZY9wbLdVtsG5PNbSsojwzBpvg4NYYDBhgJfpsL6CTm/yb+3z8je4LB/DH2gRO
         cuag==
X-Gm-Message-State: AOJu0Yxx5XSP0lWUnYooiA2OqX84GtnV3/kD87kb7jwizLD5KTWELbwo
	plYyp1AeJEqHN1pWVT/O9lc7wLHm2G6pZuryA/LqJh5XAyD6qvzVjNAHN3f6nw==
X-Gm-Gg: ATEYQzw2slyHcM+BV6kDVjsWuzlavvbWvsKbCnaqjBHOk1Mord+w67VUiX/iTs40edq
	HXR239wBhItHnsPC6206QHxKQAQhHBf4T59GoWcQNOkBaamtr9it4kU0HWCxp63ETLMfbpE1NWl
	okktN8JM35IWQPzeclsr6ibciT/TcB9C29GTl2FjtuZQp/RFTzBN6d5reVbKyPWuVF4ukBg9JIr
	isOKkE7jk2aIZtMFqarp9qjBTD2JqdcF3A13vPOBpiagV+Vo8yRbZkKt00yeeJW4idPc4mlMM/5
	5TC5P4wKSsbwIxyadMcH57o6XlG4S5eLLmSijDlfbr4jN/PtHlVc/q3xY29EVp7iFIRaXuRLfIo
	CLg5NDhWDLkgk/WNjyvNNczbO2i7Y13fYJp36x1Ma8Xte9T5ZLBnK2dYm/lMm84SMIKvJPotmIy
	FU+cDwk8+NAP42CfUstADaP3C5jXVJqw==
X-Received: by 2002:a5d:670b:0:b0:43b:998c:9bbe with SMTP id ffacd0b85a97d-43b998c9bedmr2087170f8f.13.1774544853213;
        Thu, 26 Mar 2026 10:07:33 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e5f0sm9047216f8f.4.2026.03.26.10.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:07:32 -0700 (PDT)
Message-ID: <f6c8001f-caf1-4094-b1c7-c654f205613f@gmail.com>
Date: Thu, 26 Mar 2026 19:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 08/12] wifi: rtw89: Let hfc_param_ini have separate
 settings for USB 2/3
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33997-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 08A62339153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTL8912AU needs different settings for USB 2 and USB 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      | 2 +-
 drivers/net/wireless/realtek/rtw89/mac.c       | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 2 +-
 8 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 94e4faf70e12..f462eb632eb0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4525,7 +4525,7 @@ struct rtw89_chip_info {
 	u16 max_rx_agg_num;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
-	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_TYPE_NUM];
+	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_DLE_TYPE_NUM];
 	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 35fd18fe6470..3320797be26d 100644
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
index a3a5b6fbe46c..1c968484a823 100644
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
index 898c534a5762..39b7b4da8d89 100644
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
index 19a9f07e8714..bf802d7ec733 100644
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
index c86b995a7cb1..021c2a668d5b 100644
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
index 7ea0a8905282..a13e576e200d 100644
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
index c745e5a58d12..83497b4d7992 100644
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
-- 
2.53.0


