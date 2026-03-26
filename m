Return-Path: <linux-wireless+bounces-33994-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPX4ARpoxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33994-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:08:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C4338EB8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5CCD303E7F6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC642188F;
	Thu, 26 Mar 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRssjRei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E6325485
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544756; cv=none; b=SJ7GErGY+XWoNUuVW3QB3fdPip9AnZTnQ7jC+nCEjlAuBy/yakFz1e/kj2BTxH19z16Cjp5OPVQ+NlM417AAOCv1VB8VZI4LafhFONNK6f++u33thpHP2MjgmWzi75dr//GnqPb7wCJdb6WlvFVS16W4zj3CrRA4B3FXf392EiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544756; c=relaxed/simple;
	bh=hCiY4J3iK6tzGhYACidWbzJrJnUlduqL9izCgQw2hh8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nEiVfCKhi5denRNJtncSsN8GA09gpM4flJgt6S1Tx7n0ocUEJwqmO5XOLd+qYInQoUbgY6iXryftFboU0R3OJjiR6cQzbBMpTpf/vxB2TdjFHRNVhcZV8Bpu1G9oGv59z2dZfiT3ghTcyW+w2a3sD+4Db9/2ehLNREo14HDLEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRssjRei; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48704db565eso17450155e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544753; x=1775149553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzzitJqwIjJVQBxUTvX/u/sRajYdwXIxHl+E9fAGSjM=;
        b=lRssjReicy1ExXIPpN/btZxop35iYTavW2LmqP0hmFjADdcjMiKOwBZU9139CjyS7j
         X07fXvtbtoT/qavjRPI61J1fyDHz8TOxTVVYS1hjAtSWHS/vFMUzkyaXIPvXaZrZ5NFD
         kcjYFN8JtOTbP/azn2ujwOWvCX8mFwZ1M28NmKSVO2wT61cRreT0TyYuCFntSgbpIT58
         0ZAu9zRQqPJkb+QUsfMIZ4Wzm/D3G8Tv9XdbzZq4C8gJnsY50LnmA6D/LzksXrlGxpFf
         5U0HEaqdZTdakj4juRiV/bXNO3KaQjSDAMPkN9s2wzfaG93teuOC6eU5cLPG7f+CCs9t
         K5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544753; x=1775149553;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzzitJqwIjJVQBxUTvX/u/sRajYdwXIxHl+E9fAGSjM=;
        b=ljoAfShZMGFEDKVj/kCBDDbV5J7hEtgNLH7s8x4JtM/6L27jcBIPqDZNtVieBk/XVX
         8KKOmXSisx47stpaVBz8vf882ax/fF6FZJS+dvJbFd5CgpOYpQERxpY8s4KQ4WoNDUM9
         8QZ+idK2Qtwr12VS3/qTUmzRR6O9mAAdbK/2fTwc408Jv2ACEYBmC2IcTq7r7nQdTzwV
         WL9NNuYoVOUbjN9BUvObA8iWWqjRG1iGa9DWt/uIKWcSjQSGSLNYWctOWq9QdMztd4F2
         dY6vbEGVgafM65grcyRkqlG0zTkeyKZ+debkZA2Q46WH6i7eK0LkTVXNKWz1hqtsGMKk
         8pQw==
X-Gm-Message-State: AOJu0YxgPdRVNTJfZrjW+9nT6IaPu7yvdkNeR7q7RtArUzhqMhUe0QAm
	L92f8f8rrVv3dHhkiq3NIL845KRUaswGZfyxdK6D07tXe83qcD9QLEl1a+RSoA==
X-Gm-Gg: ATEYQzye3QiTzO9JIMJQr0diEGPBdDDJLOBgD0TuG9fubPvi9deBH3VaU88tKAbGqah
	+BW0J05N6NPS7X1qRbQKTuUxEg3Wo3J3j3xqJcXuY+NJKYuGFF69zyEudgBQfhnK9Fs4ZG6t1uv
	Y1kFum/EGfpqAjQ6o7bqfRBSTyLzq9y6j0jAA5+G1F9WRuVppFWhHdiwOQJLIxbZxx/vlVFOjLF
	c5Q0detvf0i3bqiCuHVdGhxSFz485ZLXVK/r7yZweMHARVUNlcFlbndRiKYNX1fyxbfqZtZrO7G
	vH28zNaVJ2n6fm7s9Z1FEXgVDVWGVNuT8hVWhCTtgomDIHo530LvwS2NT5tyo3H9DjomjDlosan
	fSXo/24yfF6KBUdEhpSDa8Y7UOnUXqRzPDwlrnYUJKJ7NxsupOzb+Q2u9UaTHdATscZdHPGVWRU
	ajPNNjN2Noa2h2vrW/5NlHny2etzZcWw==
X-Received: by 2002:a05:600c:524b:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-48715fea90amr132824865e9.11.1774544752990;
        Thu, 26 Mar 2026 10:05:52 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm39179385e9.10.2026.03.26.10.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:05:52 -0700 (PDT)
Message-ID: <560b65f9-5e60-4a42-8661-fd98eea6e9d7@gmail.com>
Date: Thu, 26 Mar 2026 19:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 05/12] wifi: rtw89: Fix rtw89_usb_ops_mac_post_init()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33994-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 999C4338EB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip most of the function because RTL8922AU only needs to configure the
RX aggregation here.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 9bd91dc1bb46..f058a8e9f818 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -811,6 +811,9 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 	enum usb_device_speed speed;
 	u32 ep;
 
+	if (rtwdev->chip->chip_id == RTL8922A)
+		goto rx_agg_cfg;
+
 	rtw89_write32_clr(rtwdev, info->usb3_mac_npi_config_intf_0,
 			  B_AX_SSPHY_LFPS_FILTER);
 
@@ -832,6 +835,7 @@ static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
 		rtw89_write8(rtwdev, info->usb_endpoint_2 + 1, NUMP);
 	}
 
+rx_agg_cfg:
 	rtw89_usb_rx_agg_cfg(rtwdev);
 
 	return 0;
-- 
2.53.0


