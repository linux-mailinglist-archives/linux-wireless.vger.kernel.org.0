Return-Path: <linux-wireless+bounces-34978-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BWmAnPb5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34978-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:41:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A59424326
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D29300950F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932ED358381;
	Sun, 19 Apr 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4qLY2Ns"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4533998
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606064; cv=none; b=njaoBoyhE3XB19+eLfTMOF+ezBKAuuyKst7bpi86vYfYI30xQ+mO0IwhM8sZ9KgKCKOpVypSbV6OuNwKM26U9s7eoru+kG4QrQUnoc6t48pjiUowiPK9pY+S7WpDBgeGz1619T+eSEOFkXJF/+Z4IaEoAcS3SYEfzBtg/EYg2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606064; c=relaxed/simple;
	bh=ECqJ8RE8LRh2qHpsXITunOrXiNbwPtrdvsnw4kHM3NE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vAFSIvBv4u4BpRBOJzptd5zG0cGffJx78cbZJoiAXFqd59WX9WXsw3JlsTyjp+fI6SSnlJzYbtH9XHeydN/T2uqixs3VkGKoQHihruWNJpdbnLcKJXYCo2l2aOvTIYIpPBxtPNCbw8PlDzXVsSCSPQq/aoP+hUyqLUAXtLL4d6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4qLY2Ns; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so32343065e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606061; x=1777210861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fa/R2XrCAzHLKgZyq3ituLeYn5rGVTUYFSXsny/Rst0=;
        b=Y4qLY2Ns432l2STvmLr83Qz/XMlkBxEApuWx5LDjaSoHKdVhhHoeM4U2w44fktkxQJ
         Iw8IM8QiIkBOAeJvwtBrXt5XjXrmpCnfuzhJJ3qqxJBuj7LWXaKdwdTB1ITAomxGuNAl
         7GcPpGq6mOYreZAUVwI3Kxi5k8ePbaQHf9dWmU54SONzk3S2ZMhNM1v4PBz98V31Ugk2
         fsq4Llq8N6fZN9YnK3zZTT3kgLVmKQpcfIdl/VCRGTZvQBanrWuvqHNK7RRyUi5RbjiJ
         y0EmEwL978YKy7agZoPS6IN29kABrPOITDGQ1cOJgymZKaai4rbZB+H3HwVNaja+me+a
         BQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606061; x=1777210861;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa/R2XrCAzHLKgZyq3ituLeYn5rGVTUYFSXsny/Rst0=;
        b=i2cHJX3Je4EdLDTugryLcWZkd0j4pLRs5WGxlUFKVi34Ap+ijJTsCWKmayAhZW8H8y
         MSOW5F+91t4b+M1DoP6vYTPadNb9wUxdx1LJzcFY5s/n6qA98bijnsEF9UFn2+NLOm/E
         91Gm5VpKgDjnXZ9HJSGFTXW8NQWCBwcUujrlM+P+MWk+W4XslOC45sTEebGIyIWHegtz
         cxEggDWYNey2j+GbRkzDBFmYxo9LFW2n5toqhSOgutiac5LjtP77baiVxGbT1Ez6d5Hd
         B7QhRN0oH1+k8JeYcJCyz3ZHStJJ5VIe6q2tEq1GHsaVqE7WxEfO6PGA1FFDMfj8V2na
         rz+Q==
X-Gm-Message-State: AOJu0YyP4MkPLQnvKrz5v0V+V2U05AA7dJ1rM384lrFN2KhAFYnmBtZJ
	lB+zyKtJle+YaJwz8qtD4CG5rKm6XAj1THrdiexOGxDa+yyIPQZnGmB/Z2ED2w==
X-Gm-Gg: AeBDiesH2wvcLyMiRfgGMhcOYNGjOLh1iAYSveifEbMb43BUpfk8JnOR04Vj4Ssp2WU
	fLEfPoHtfPbGmZhlHRQZutC2tnwvtLyzm5yhIdgoXJiWbTrgH7QcGWE3HeOIR619rn9Vq+Js+Gh
	Kxcmuf1T5wzcTioLa/MQueiOnbpIUebpujhiDJifMR9BzLM8qZ94/Qq6q9mEgl8+chjqog9rgIF
	osJGiUL6jErMW0GWrxo2HuDWdYc3kTFlAXD5hfK2JzXl7edsJUy3uQDO4LM50jmvqsPbRmlUAcf
	u02IO491SeuHbxe+FVSa6yDJPOAZOuEGDHDjCRgW/d0drbpXGhEzbgx562wPyBn5w8kRvXSZFqr
	ptNxk53wtLDJOwG1aowBi3ZIc/2hS9N0gNZX7LRTKBC4hOKdLJ73A5ibn6XL/X9/AA5T+2JIRke
	rjqaoXg07F0foxdZCVM3RxvdtkWV7GemjQI51yr0Wb/wobWNtZEXo=
X-Received: by 2002:a05:600c:8588:b0:488:9619:9bf4 with SMTP id 5b1f17b1804b1-488fb771b04mr106280535e9.20.1776606061358;
        Sun, 19 Apr 2026 06:41:01 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f93dsm322447945e9.3.2026.04.19.06.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:41:01 -0700 (PDT)
Message-ID: <fd6ae7f6-0035-45d8-8832-49a053fd217d@gmail.com>
Date: Sun, 19 Apr 2026 16:40:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 02/11] wifi: rtw89: Fix
 rtw89_usb_ops_mac_lv1_rcvy() for RTL8922AU
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34978-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55A59424326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTL8922AU uses a different register and mask to reset TX/RX. Add them
here.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/reg.h | 4 ++++
 drivers/net/wireless/realtek/rtw89/usb.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 42ffe83931a3..570d5883761b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4806,6 +4806,10 @@
 #define R_BE_LTR_LATENCY_IDX2_V1 0x361C
 #define R_BE_LTR_LATENCY_IDX3_V1 0x3620
 
+#define R_BE_USB2_WLAN_TRX_OPT_PAR2 0x41BC
+#define B_BE_USB2_USBRX_RST BIT(1)
+#define B_BE_USB2_USBTX_RST BIT(0)
+
 #define R_BE_HCI_BUF_IMR 0x6018
 #define B_BE_HCI_BUF_IMR_CLR 0xC0000303
 #define B_BE_HCI_BUF_IMR_SET 0xC0000301
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index d3c7ed29cfe5..fafc2b33e561 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -871,6 +871,10 @@ static int rtw89_usb_ops_mac_lv1_rcvy(struct rtw89_dev *rtwdev,
 		reg = R_AX_USB_WLAN0_1_V1;
 		mask = B_AX_USBRX_RST_V1 | B_AX_USBTX_RST_V1;
 		break;
+	case RTL8922A:
+		reg = R_BE_USB2_WLAN_TRX_OPT_PAR2;
+		mask = B_BE_USB2_USBRX_RST | B_BE_USB2_USBTX_RST;
+		break;
 	default:
 		rtw89_err(rtwdev, "%s: fix me\n", __func__);
 		return -EOPNOTSUPP;
-- 
2.53.0


