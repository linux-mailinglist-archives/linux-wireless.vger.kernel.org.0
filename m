Return-Path: <linux-wireless+bounces-34977-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kASzEkHb5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34977-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:40:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2242431D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 428803004DFE
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B2533689F;
	Sun, 19 Apr 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEIdygzN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CB33998
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606015; cv=none; b=MP6FCnhwBh+KE/ceiRjrYQS4AqEgfA54QhrTP/Ej7/PkCSlcMcNZq7oHpkHheja4ga3fH/WEoa/FNPL7nBnnDHShStR5AqSzWsn7fVsh4t2W1LFDbaHZYDYNyy+loTPb/gSJV1x8Jx1VF7A2kruYrJjoa3k6CKkG3Kynse53LFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606015; c=relaxed/simple;
	bh=7/pOYJhsYbAAm/U1Ay0liPX8N/WcSVsXklGOWLXR+ms=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HOyRwK1FFvkAL7DRNlWrnitHgwQT7IltURMg4ulCMT2jYWpKXbjWR9MRj8ewRUhI5MI6E4Ina1zhunYv/Gm5MT2t+J+3y1bcQhF7o6nP4Dr/qgpCRm9UvegCI1kXW5OCUdGtNhm1ehbxUpC9CKxiYhcTnPm/+Ev2/vU3Q2EizHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEIdygzN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso616185e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606012; x=1777210812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rwj77vyvZ1Y20AOaRXqfzF8i0rbAp0jmrjvrwbf1y08=;
        b=JEIdygzNpIrsONO4UkNRZn18q+xJ2uG7ruJdoJZjNq5LXL1Gb+w6SfsxxUiHq5Iss0
         PPbhaTkjlsvOJdnpqMpa493iLkwHEs46eA1UwGVzQF3XgSdYbrz4kQeJMm88TUT6SkXF
         waBqh3SaQuih8E35ZGCcKeoEtSOt18w0fwcWlOi2o0hWY09ZGVJ1fRlkUPaXW5HSTMyP
         aWa2daFGQ6fOwjQAHXZosQ321kJAZow/5mVLsp4pVak5QF6rlbxhUHf3vK3/zHxk88nI
         YHMdpP+7fG1JN4Gb3Gk7HyFJ0juf5c1W8NavQm432kywKatcSCXkpzWDQ0ONGG0XKzQB
         Tz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606012; x=1777210812;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwj77vyvZ1Y20AOaRXqfzF8i0rbAp0jmrjvrwbf1y08=;
        b=Bs3wCo+GOqhcsa9CTUIe4Q2cqhNgIKiopdw8m275uOdNqKab/DiYKh6Bdh13gHFW5e
         zxKAmPp3HENaDa/mKwu96I2u8kXoZYiqbWPvawD7WfkWIB6QoVFE4JkN4qKfp4Ocl59T
         u9Yi2zI4v31/EZElO4I2hLsp3lBVKJhojY1vzd98pxDggc5XXFQx8uK+cKoU6fJMWGMu
         00C7MYE47dJUIbElaKVKPo8uPsGNv4+623rjFTRV2M8LfsoRNq+ZeXfYHbd/1Z8KoVDV
         Y5h7XWIIkwsBF7aZC8tSrtzbuikOtOlbXEWX1RlkYCdHO2amt+/UW/ZHMg0+KuoW16+B
         Mbkw==
X-Gm-Message-State: AOJu0Yw9/Of+hKcWwcXm0bpoe5a+MF6uf7bUZVg06ur2YE17oBba7d13
	aoJ8sHIyeJzDNznD44NtMgFn11eAQZdfYxRda3bDEsfa0qG8hvIQnKiNEKj5ug==
X-Gm-Gg: AeBDietTOxzC2f+R2hwKpdxIecaNZMn3UdZpOmaf+v1XCwmTgyxKBQxeUfxEID44+tu
	pkp17RsDkh8NRZQMoADjj7ibqo3UdIYoKUK49KysTcAz2DyrIDpQem4e86+9xiaPu0QZnvEOZoM
	QJWYVc5Z82MKbXvgCPsnw0a3HUOtPnMfk6vombD5z0L98kRt//4XNUbH6gV6c2YOEsliZdC0sSp
	ZGf+YvEKpTsON47G6CX+OFrkHlyeBxPHIgbxo0vqfaR6X20Ivzp6vwOSNapKw1Yds4j3U/y4A7B
	PV35bkR/ytIaIUEL4rnKLAUbAu4d8/Vds9tTHlPSt7iXllYru253d/nyEPdTCWlBt4GdwiAV8kJ
	z6TzVJhJP1qmI8jX0R3zOaavO0b8RAC1Vt49ZpPYHbKIHMpr0XaKGIwPodagMXLdEjHSGdE/Jqx
	VZqIOAjBcSFTCzzG0s3QyzjFooYtE74yCkN8OeobSw
X-Received: by 2002:a05:600c:4f0e:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488fb6e8491mr152070665e9.0.1776606011882;
        Sun, 19 Apr 2026 06:40:11 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f93dsm322382035e9.3.2026.04.19.06.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:40:11 -0700 (PDT)
Message-ID: <3d30c8d1-fa25-48d0-b27d-7d634c5aa005@gmail.com>
Date: Sun, 19 Apr 2026 16:40:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 01/11] wifi: rtw89: usb: Support 2 bulk in
 endpoints
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34977-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: D5A2242431D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTL8912AU has 2 bulk in endpoints, not 1, so raise the limit.

The second bulk-in is for USB interrupt mode for SER (system error
recovery) flow. SER is not currently implemented for USB devices in
rtw89.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
 - Add more information to the commit message.
---
 drivers/net/wireless/realtek/rtw89/usb.c | 15 +++++++++++----
 drivers/net/wireless/realtek/rtw89/usb.h |  3 ++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 767a95f759b1..d3c7ed29cfe5 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -511,7 +511,7 @@ static void rtw89_usb_rx_resubmit(struct rtw89_usb *rtwusb,
 	rxcb->rx_skb = rx_skb;
 
 	usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
-			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->in_pipe),
+			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->in_pipe[0]),
 			  rxcb->rx_skb->data, RTW89_USB_RECVBUF_SZ,
 			  rtw89_usb_read_port_complete, rxcb);
 
@@ -948,6 +948,7 @@ static int rtw89_usb_parse(struct rtw89_dev *rtwdev,
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	struct usb_endpoint_descriptor *endpoint;
 	int num_out_pipes = 0;
+	int num_in_pipes = 0;
 	u8 num;
 	int i;
 
@@ -963,13 +964,14 @@ static int rtw89_usb_parse(struct rtw89_dev *rtwdev,
 
 		if (usb_endpoint_dir_in(endpoint) &&
 		    usb_endpoint_xfer_bulk(endpoint)) {
-			if (rtwusb->in_pipe) {
+			if (num_in_pipes >= RTW89_MAX_BULKIN_NUM) {
 				rtw89_err(rtwdev,
-					  "found more than 1 bulk in endpoint\n");
+					  "found more than %d bulk in endpoint\n",
+					  RTW89_MAX_BULKIN_NUM);
 				return -EINVAL;
 			}
 
-			rtwusb->in_pipe = num;
+			rtwusb->in_pipe[num_in_pipes++] = num;
 		}
 
 		if (usb_endpoint_dir_out(endpoint) &&
@@ -985,6 +987,11 @@ static int rtw89_usb_parse(struct rtw89_dev *rtwdev,
 		}
 	}
 
+	if (num_in_pipes < 1) {
+		rtw89_err(rtwdev, "no bulk in endpoints found\n");
+		return -EINVAL;
+	}
+
 	if (num_out_pipes < 1) {
 		rtw89_err(rtwdev, "no bulk out endpoints found\n");
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index 507f61f58ed9..82de700eb142 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -18,6 +18,7 @@
 #define RTW89_USB_MOD512_PADDING	4
 
 #define RTW89_MAX_ENDPOINT_NUM		9
+#define RTW89_MAX_BULKIN_NUM		2
 #define RTW89_MAX_BULKOUT_NUM		7
 
 #define R_AX_RXAGG_0_V1			0x6000
@@ -65,7 +66,7 @@ struct rtw89_usb {
 
 	atomic_t continual_io_error;
 
-	u8 in_pipe;
+	u8 in_pipe[RTW89_MAX_BULKIN_NUM];
 	u8 out_pipe[RTW89_MAX_BULKOUT_NUM];
 
 	struct workqueue_struct *rxwq;
-- 
2.53.0


