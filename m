Return-Path: <linux-wireless+bounces-34979-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKltNNfb5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34979-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:42:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15642435A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C60C6300D63C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B192367F22;
	Sun, 19 Apr 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0hE1tZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A103603EE
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606163; cv=none; b=ApFb4SRyPgVGT8fYs3JJ1yylAvthRQaQDiT/LiLheC+qHnB/dN+fQGPRVqtnhZwoOEOgZ7HjhdBVU9YFFm8rZMWiFkmZ+2Pp+ku2SsWVtELg5Z+rP04rDtNICxc4GC0Kj+8bkIq3ZARGPsSAeAJA8uOJGIWPEZrnrnVjgl7hNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606163; c=relaxed/simple;
	bh=bwn2gMEpJPK9wseKQCEi2PCgzFG4pDBCdPBnoQqD/tg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nT6igZnBR/f2KAVaIQ0FIeuZDbwElVAuc/E6tmN5p74xfeFWRjhcD8waM2JpdL953xkRGUreJCBwA+hluIOTI1ia8jQLkH9BC77ka/SKYPgr3CGUOuRsBJI+sUvusx+RXWa8ExTPQ+N6pKXmoswRbCvN8CsU29d+duuSowxF+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0hE1tZP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48896199cbaso23285915e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606160; x=1777210960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6OyBmMco9iBjMhr9ITIos6wpgoIJ9Kyp3I9WZPwqSmc=;
        b=l0hE1tZPaoM8djM8AlG/ByOJkry2utTg7R1y2TDmaL6g+PFRpDBubA5OyS42SKuqH8
         9V3KjZGS7mUFZzyG37pjoVRa5C1aTA1MxYqEqdeLnTYZHN+D4yM6bea0Y56DV38m5szw
         0rAY/67QF16RMNokPgBEH/nX1ftWzWGTklclqr7WO6hd3o4LJEgJd5tD/4fiPj1puWJ4
         LhXvhhPmObEm3XSuRDa6iYwDBR/nmzVATkZ1j5vOuNdHDHprREBluj5Ada1OvvF/opQ7
         9hZ5rhQR2CambQ+CnQ2Trfch5cmU4KzL4eSA0RXBbqTY8kh0eoQe5Whk68E6kYnv1fml
         SRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606160; x=1777210960;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OyBmMco9iBjMhr9ITIos6wpgoIJ9Kyp3I9WZPwqSmc=;
        b=dSTnybKFN1iChily6TKKbwt5JYaokzpPQuEAArsmr5M2rfLWSx87PmwRCU6EZ1gNMH
         AQy/KEZ+18BQOmS1ifj1vmz8oMmAk6KcGn4XqbPfWHF7drFystN86Gfv/fjo+ypovdEc
         UYpk//EY9VLakdwUyGXCaQRQC6fQnik6yzQ7F4Hsv8kskMIGC/BwD/g8aLGG00Mm5T9S
         r+0994HmLkWVfHYmtcYNzw4TjofI9uwfHv1UZIGrW87YS1h+QTLqeab4vq5GPJysckVM
         DaYUE6ALJ+lJ8I466QkonVVe3vA/UrbSDHqVjmK9ZALyYKZkgnlha2DyGgBMDRMCcMxY
         5myA==
X-Gm-Message-State: AOJu0YwrzwnVEg/VlE0qKlWDoAglq6yuKld7CtaprWk3ppCKhsUaQlgx
	k8jOKPaCkhCDyZA+v8EDUVaqTealBWMxz6mvCXSO11nmp43Do4KS9oqvh64rkQ==
X-Gm-Gg: AeBDiet/fUSHqxGbzq+wOfABkdBuZSyD6NnVkFAUYU9lfcuhXCWgQ59MZkCFPR7Dtrm
	5hsbRCt26tGAv/k2L4PYV5wTR8l4rH9D/WTHY/nkVZq1+xMPH2RmrL/s5VASMbgjGjjLxGszUZp
	39bQDzE8rACt+uETXmTtU9m0aC11qJB6Prvpb+U+8VXg60hj3k1aJxeouNy6pRVgUQuY468LRFy
	vguM7xs9kdOr35pAcXmRx3qrpD7mtbZya9Ze7WopdqhbYUuyomsDzeO8mshsjMHV0IR0wRVHTw3
	i6qPqm1DAAW6Gb6FifKjqDLX+9Foumdo7orh5/HyIo2BOqgNJuukg2ka33UdG8E5G7Zd5+QPRsc
	J9skJc6/+DmChWZMi/VGT3KVEIk1q/bDznUIQG/C9sw+0xsmTfRm2TKcsKPpAtwpjsukNDlPK44
	jg1tQwJAMCZ8oWPhWDzBz4OpJMWkS9ca7LyFbvzDxL
X-Received: by 2002:a05:600c:4ec8:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488fb755caamr147876555e9.13.1776606160144;
        Sun, 19 Apr 2026 06:42:40 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm19899033f8f.4.2026.04.19.06.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:42:39 -0700 (PDT)
Message-ID: <58bf4dc4-dd4d-4caa-b6c0-e90749769cea@gmail.com>
Date: Sun, 19 Apr 2026 16:42:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 03/11] wifi: rtw89: Fix
 rtw89_usb_ops_mac_pre_init() for RTL8922AU
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34979-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D15642435A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Return early because RTL8922AU doesn't need to do anything here.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index fafc2b33e561..3d9113ae7fb4 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -756,6 +756,9 @@ static int rtw89_usb_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	const struct rtw89_usb_info *info = rtwusb->info;
 	u32 val32;
 
+	if (rtwdev->chip->chip_id == RTL8922A)
+		return 0;
+
 	rtw89_write32_set(rtwdev, info->usb_host_request_2,
 			  B_AX_R_USBIO_MODE);
 
-- 
2.53.0


