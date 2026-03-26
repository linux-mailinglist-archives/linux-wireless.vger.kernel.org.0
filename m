Return-Path: <linux-wireless+bounces-33992-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBJSIlhnxWkn+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33992-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:05:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01845338E16
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C69AD3034530
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253FB421893;
	Thu, 26 Mar 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6/mAzv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BE42189E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544687; cv=none; b=mLVfmMEEzxPmUeEG3Rb/XwmowoFi/hLXuHyYaVmdoOgtjCIJr+Hri/JWhmLYFjcPTQvnlbfi7VxMqOZFmcfkmzPIy8SYyJ9NfNgIKSP6hSZfS5Svit478Loa6KP2qqHcx+RPNFtLLCh076GdorFJX5fwNIGyC/n1JWNaXskLOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544687; c=relaxed/simple;
	bh=kJLAFNTCR5dulPOLBF3J3PDAqPSgWvgHXqw+44Umz2I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=irHqlWr5gIHjy2r+ppwY4p3OIiAQaWbh4AyNikRlIwjQxZE05wLUIVEgfCArhTpi0OaeiOflFScym7jvF4f3UExbxVreOeACLn2DOhnbIVj30dVfckpIdOwl9jpvTUDewURNCKvaYNS5yNcFoWcYBMthGMDlt4b1Cmop4lhzzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6/mAzv2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483487335c2so14217335e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544684; x=1775149484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hy/GeqkAFLDnWJCP8C9Frz6efgp+ZKkvHBiM8u3dibg=;
        b=E6/mAzv2iVkKJw8o7do1mV/m2B7TxY7Iimim4UvdunNyHKUzK/Qzi9y5j99exMNkln
         bvy63TA1IlxN0+hlWelyAR+kALSlva8IsZjpj4WqtA3GtBmbqRQsq0v7DduZm1hXkCMw
         NmUsrj5tuJcMMITZnGMHtihDuF4AXjo8vf7cpGygH4aiR340I/SnOQqZ4NR8IJGyn0iA
         kNOqxr56BkS+HQpxhCjFBhFSiF5fpPEq5S/iOdeFsA19KaTIKeD+KFRpBp+lXRu9Yrq/
         7rK4IalP7/LEv3pRHAVk40w+NYHvTyy0Gf6WO9sD5TqknQH1k97SE4lyPTQw3E61dx0d
         4ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544684; x=1775149484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy/GeqkAFLDnWJCP8C9Frz6efgp+ZKkvHBiM8u3dibg=;
        b=Ad/pU2isw3v+1cyQfhIxYfTi9D1/0CTQIv3SubKo6pY9geM3dVhizrmMuuDDkmoMQ4
         2bfA6jSbXopMGD6zWN7A3PrFjz1CE8HbyJkubivRyEmoyC4a6i6q6yLGaCeiVVhw44Kp
         pSLA5DMLTRPUkyozG18bD1nWCUP0CA6y9r68rgomdn/psjzdJW9XeIEW0DUfV2iP1A0p
         GRcQG0Nj85S9esT8rLcewG0zB0096n6smcxW4HdQsfxckFSxKvZTC2T0dsVuk/5uqKH7
         25iPJ5k1PubXPEEOxWsoZDg9sGoIVSBRMdyXAhwnDqxfuMNo4r3S1U6B5/Qj1mj/px1n
         fvCg==
X-Gm-Message-State: AOJu0Yxz5PHIFRupUeb4Hst7DuXW7NUGM24cP2dsuovqOAFfa6msKEJ4
	o0NQjUi0ujXbqdzJyTlweqcGmbuqVHQuNdzmSp/rkTrvHtzwaF8ITvmt8uQfUw==
X-Gm-Gg: ATEYQzzn/QHgPwsAXc0I5p1g1Lvu4arDzluWCouZDr/mMi1MGp4PhnZ7Owl3kFQBx5W
	hehb6s05zlPOWMdcae1S8aiNQA2k+mYdWEAH9BWmrOyiMwFfN2cJPbX7GznyZ0TgApRWlPHKp2g
	hIlABgDAPTvU6531cGfbavvyff1FluyLOA4UyXtRmWzxB9+2GjwVWMnjDaUR578K5Q6iqi+N0yf
	nwcjPPqQ+1eoAK3EImO/phGx0UMmhdzFVrwGNNR15MD92WZ4ZmTaRRPKUMQ2lKqS4eWI3hlDiYn
	zcLzsZrschnyEzVj/QY+fcTzMBtd6uhQnpPg+ra2l4KwdK4yOH5uyB95okt5Ry3qngOisIrrjtY
	r19HB4oytQlpJJ12JsnPtKjouYIFXxWI5jyr0kg+XTVF3fFwfLzvwtjHuadPn5CTRBkcc9ibVhX
	yc/GQUdSjiAbFj0CCfs7/Ywe78V3hi/A==
X-Received: by 2002:a05:600c:33aa:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-4871607e25amr69551405e9.31.1774544683893;
        Thu, 26 Mar 2026 10:04:43 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725da0333sm919655e9.2.2026.03.26.10.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:04:43 -0700 (PDT)
Message-ID: <78bddba4-d87b-4081-b110-8ddf7fb48d93@gmail.com>
Date: Thu, 26 Mar 2026 19:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 03/12] wifi: rtw89: Fix rtw89_usb_ops_mac_lv1_rcvy()
 for RTL8922AU
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33992-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01845338E16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTL8922AU uses a different register and mask to reset TX/RX. Add them
here.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h | 4 ++++
 drivers/net/wireless/realtek/rtw89/usb.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9b605617c3f0..200c08c97ad1 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4729,6 +4729,10 @@
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
index 327449141d8d..eedc8dd2b070 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -855,6 +855,10 @@ static int rtw89_usb_ops_mac_lv1_rcvy(struct rtw89_dev *rtwdev,
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


