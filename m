Return-Path: <linux-wireless+bounces-33990-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF+ZFd1pxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33990-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:16:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E133233908D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC1CC30D20FD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFDB41C30F;
	Thu, 26 Mar 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itnf0UZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BC3ECBDA
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544658; cv=none; b=aeLnJkudkZh0SEulmhLEpInj8XLkk7gW4SnA9j50QY8mJ61at4OhONwv5QNAgeNJv7H+KyNc8lNBTvz5Utyyu7KvENm4kU+PqJW50PGSQWbDRvxj5+bCrBc+OREfh1AZiSgMVSE/SCwXxIeNdZRN/OefFuFn6ICJT8aJ3Xnd9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544658; c=relaxed/simple;
	bh=q8aTJNDO89YEiLzIwOGK6Z9R0jJTH0QlcZEwdXLHS9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h8EyIDbeA+LTZ1Vw3AusliMJZzrppeTzSHlHdl2Scptou1ukGTKTB7guEKrFYCWvT5+okN3WxrNgmVVI18kL5AoSoxurmNmGa3k7yv3Ym/6320qcrw/5nRZbOjwA6+io76tAtztVXyY2xKTLWFJhoZpk80REuud0wftnUo1xox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itnf0UZZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fb439299so11518485e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544656; x=1775149456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ziab67NmFDeZI4vud0RfL4gqwGP+oIQH3tL2HbrS7lM=;
        b=itnf0UZZ7clk+4cbgBEFghOjvDXlk6FOgNKBWtQIpbwpMEFGWtzmvNTQC6rqwBqlwv
         wSKEQyhDlQJ8SN0DBaqmT+uSb/1n6JJsGOCj7cW/g+dvwRT91MMjCYk6Zyt/1hG9Yj3h
         TjxuPxoXMcrOrgiNcvS3QIrqxhyQ7ORE/AUvo/QKOyerj5lD3evXp16HTb+iRxlfdXum
         iytjcqnbf3B+ZtgAgOiQJJE0Cv2Ltr14AEnzP5x6dLnkKeoiCpAU13Pfcx+2RREbw9yx
         FCukJ9HbCboNmcWQwCIj2jfh7OUpsVFlDZT9pxymvXvrUqkyZRKp0ihWjfUh4NsVw7SM
         PX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544656; x=1775149456;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziab67NmFDeZI4vud0RfL4gqwGP+oIQH3tL2HbrS7lM=;
        b=fEQm6mni7Ktp3gmZ+wHYpgERDZawD+OfNV0DQVMlVqLyxdBaEHnjNIDajjJsTr0PlG
         S5cCYmBoY/hlA/FJRmvW9uwXOLSEu6lsN3j037xylRDfTMYvUwoncHQYQHvzRB+6W1SR
         M2oWx2Nj7q6feED1jTm3xyIofJ0/1cVZV1vuStB8DNvpZcBypa2SR24sXXVwegAiYG7D
         wTqBW1qj3ptQiMosPEs6gJWZ4JSRo4M4FTx5w/aRnYX7YMZm1A8AOPGzSlln4MJ29aXM
         rVGG6uSGGh7YNWm5xiHKHl78vRYwsO4ivzvS1t9HEsP43euX9g619uJazeQp6ELBd9FS
         PqsQ==
X-Gm-Message-State: AOJu0YxDTjFLFBi53kMRzoJPTz34fYog+mq874mMqUF9rGVFycc3nwFV
	4gu430embbYVBQfo5WuCD2DM/tS2qpa4OUbtWpCMyKKTlGhpk/bM0yZTqHx1AA==
X-Gm-Gg: ATEYQzx5ugTJqJmFd5Av1PK80bTtVAGkuHWHCxwuwq1Tld/EHMJaz9vD8BpG56WfQbu
	ykpSYkjFyeFrn/zzAe2XspUjo2pp6bSonak5P7oF9OzhEWNDMiGERub7/i8cjWx/x1+CwLiAv54
	sjVZa/zDOpSTPN/HhnsGBST/1rd+gENJmSvzNm7CZkCGNoxElbj7iwcnUIBzcnaqtWaIaTy/E9L
	+wwnFiQQ+XJ8dgjU6D9f0pOi9VJgeM1ntZ1taL09zHlRb9YfUpXp0r3k+Eyw24dB/00ZW5rzK5/
	enn/mswccOak3eALO9246V32yseVWOHLkNqd04BGZ6T1mUH2f4a8t9/id6DOaS4XNPLVW+Wehwq
	4DsjyJRAIh/3L3ht/Rt0F0wwKUmDd4kOkgSPlJHlThFsryhLgQMbpzEonBsBtAlMxPNjkwWAyfe
	NTBB09UurfbXR7vB+r3j72QM0GzwISdw==
X-Received: by 2002:a05:600c:45c4:b0:485:3c8f:e4d9 with SMTP id 5b1f17b1804b1-48716067413mr125295025e9.26.1774544655324;
        Thu, 26 Mar 2026 10:04:15 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d38f52sm4611215e9.0.2026.03.26.10.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:04:14 -0700 (PDT)
Message-ID: <7cb8e2b1-0f87-4ef9-9dc0-f4ceda5cdd8e@gmail.com>
Date: Thu, 26 Mar 2026 19:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 02/12] wifi: rtw89: usb: Support 2 bulk in endpoints
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33990-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E133233908D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RTL8912AU has 2 bulk in endpoints, not 1, so raise the limit.

It's not yet clear what the second bulk in endpoint is for.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 15 +++++++++++----
 drivers/net/wireless/realtek/rtw89/usb.h |  3 ++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 7a46ace34c25..327449141d8d 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -497,7 +497,7 @@ static void rtw89_usb_rx_resubmit(struct rtw89_usb *rtwusb,
 	rxcb->rx_skb = rx_skb;
 
 	usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
-			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->in_pipe),
+			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->in_pipe[0]),
 			  rxcb->rx_skb->data, RTW89_USB_RECVBUF_SZ,
 			  rtw89_usb_read_port_complete, rxcb);
 
@@ -932,6 +932,7 @@ static int rtw89_usb_parse(struct rtw89_dev *rtwdev,
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	struct usb_endpoint_descriptor *endpoint;
 	int num_out_pipes = 0;
+	int num_in_pipes = 0;
 	u8 num;
 	int i;
 
@@ -947,13 +948,14 @@ static int rtw89_usb_parse(struct rtw89_dev *rtwdev,
 
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
@@ -969,6 +971,11 @@ static int rtw89_usb_parse(struct rtw89_dev *rtwdev,
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
index 3d17e514e346..7cb690f961bf 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -18,6 +18,7 @@
 #define RTW89_USB_MOD512_PADDING	4
 
 #define RTW89_MAX_ENDPOINT_NUM		9
+#define RTW89_MAX_BULKIN_NUM		2
 #define RTW89_MAX_BULKOUT_NUM		7
 
 #define R_AX_RXAGG_0_V1			0x6000
@@ -63,7 +64,7 @@ struct rtw89_usb {
 
 	atomic_t continual_io_error;
 
-	u8 in_pipe;
+	u8 in_pipe[RTW89_MAX_BULKIN_NUM];
 	u8 out_pipe[RTW89_MAX_BULKOUT_NUM];
 
 	struct workqueue_struct *rxwq;
-- 
2.53.0


