Return-Path: <linux-wireless+bounces-33989-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE1XA2JoxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33989-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:09:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74137338EE6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F8C0304C104
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EC41C2F3;
	Thu, 26 Mar 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXomoRsP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0E27FD75
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544616; cv=none; b=XGqWyw+AMpk51eNVACfRKu6PB8xmuY7U53zmt6IV5smwsnTcP3f7KKQjszEE3jhnQpkWWpUX2otVfv/ldr6hULMty4xag0fa/W4GE5hZwK0ajLar/TVAr2xv1sG/KgSsYfazPTXzCUzROF1QC4o+YcGiK5lGnJVorcLyI7CW+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544616; c=relaxed/simple;
	bh=7x/jKENK9I09Oetj9dx28SpTQmQOGoEU4e6h7qbsGGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MTP0eaa8hZdpQTZapbt7H3j1CuG4PwXEOtqbz6KBemTTK/cZNyOVJysz8i67xYNX5sqZWKTz9J0PETBJ/f1FGiop1crV/VRybE8fyB9LEyKnBg4yVuNV9e9BAdxekVfVjWzXxVzT8G2YBDc0wljNgqab1R/2LGfYn45gJzMpdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXomoRsP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so11389405e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544613; x=1775149413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZTEOswdRhtKKDkdXolqm95+3sw1A19qFgw7JwHVhcaA=;
        b=XXomoRsPW6qqXhMixksr6YPtTkNp1wbRRRZjyxEk+IWUJ6WxzbHCxOolYxf3p6Zzlo
         +OGo+ERXy+lSjQLma34rPBsY6cpaVuJe1HVmSWrzXYcgzek8Nq2e/BBxsEWF7C9Kdkd4
         oBpwSQt5u39emyj3DMZda26rO0lqu5x/ORQeOkTSx9N8r2Mt1N0AkdMok1KN2ex2wSPs
         FJA5X6ibFt572Za+Z2frtlBKV1RDXc9fbsaMXyV+jTs2hcSv+84TTW6yaLFLG4dsk+/h
         dm5xXkainTvLeHejEJ6J+VYYGzVAJUwDcXeRhStyg+ZjKGL7kyw2aVc3aUdOnSTVAxca
         0Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544613; x=1775149413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTEOswdRhtKKDkdXolqm95+3sw1A19qFgw7JwHVhcaA=;
        b=KYcBmrWtAiqgNEgN5+deZ8ltRzjZyW9t+TqPoSTpQ+tbKrWxaKrapnwRH2pQE6QlOS
         z2NF0/l+qxmPbGvrGYYHTZWLeJsh7oqhKmKc6Zp+6hF4vNR+mNlrXTWTLJ532kRbpB93
         x+vyRa5bIVrYt2YztdIPMolqWNgVPB7KLPeiDNPryYoP1ExLHNmwbHMGu4KStFDnadTD
         BjmenBJHMXH+nARRNyZMr888nuilbQETqIlmBrw/oMed0rTcGiRg0OYDeDjJMa59IE55
         H9mE1ZVyxJMshsYE627c4qS93jJGTUU+REifJQuEAsBNzjz3cI1MvkSq2P3TacSdHUDu
         wuuw==
X-Gm-Message-State: AOJu0YxcaiuUpBE/EMke0lciXFsuB9rgLpNk8VAKn2KdiO7PFCNuEsKb
	TxdsM77sTweHy0o5GgUROpQ2stO8ntkWYhGDUEMJKKz42TTHFtGIK4p5X40ILA==
X-Gm-Gg: ATEYQzwMQt9tVg4m9wlNfMvC8XrZ/G3oBu3bP2VSiEvVu5oiUMxbutDX3gFHrXXbi0l
	8eAb1gM2f+EOcNlflpNYGK7+s1KV+R9eHXjoSh9nunmxZvrl9OymSIVwcxunLbSlWiueO3CfEMW
	WIQvfL1i5GbCJVPOY0+ydItnqNLbde7SiMNFT0taR+loImxTBSyZPHBuCifLmBXwlOTQ5rUCNsA
	K+Ux6p0UG/TNMXFL100Y/D6+Dg8HuI1Bq+jY01mZ1FtbabaYS/Djq86ZX4tcdumfoUB8Gs135rR
	ICMGJ0thiQGWMTTxRQdZ0/VfMBX+VDJk9qZdf6wpV4MtSeucaZaG5RQP3VZN+6nsvMtijIPFVWN
	chgruwhV9B2wBxpQYSAbvt2HNMTdXKnAPJwHUU0M4KCmpTPmvpfHwLzA5KVNoWw3EoIFNfY5RYY
	jNnwbddgW+2qfPkH+wDRESmLP8ePDe4gU6Hw66R67X
X-Received: by 2002:a05:600c:47c7:b0:487:20ee:bef6 with SMTP id 5b1f17b1804b1-48720eeca1cmr27306035e9.11.1774544613177;
        Thu, 26 Mar 2026 10:03:33 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e68a6sm11012075f8f.33.2026.03.26.10.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:03:32 -0700 (PDT)
Message-ID: <eb447efe-466d-4494-86c2-2e4d2b882fce@gmail.com>
Date: Thu, 26 Mar 2026 19:03:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 01/12] wifi: rtw89: usb: Disable MLO for now
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33989-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74137338EE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's not yet clear how the TX queue/channel selection is supposed to
work for RTL8922AU with MLO, and I can't test MLO anyway.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 581b8c05f930..7a46ace34c25 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -1029,6 +1029,10 @@ int rtw89_usb_probe(struct usb_interface *intf,
 		return -ENOMEM;
 	}
 
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "%s: disable MLO for now\n", __func__);
+	rtwdev->support_mlo = false;
+
 	rtwusb = rtw89_usb_priv(rtwdev);
 	rtwusb->rtwdev = rtwdev;
 	rtwusb->info = info->bus.usb;
-- 
2.53.0


