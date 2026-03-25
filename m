Return-Path: <linux-wireless+bounces-33903-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOwFDYthxGkuywQAu9opvQ
	(envelope-from <linux-wireless+bounces-33903-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC0332CF71
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C089E3067593
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D034753C;
	Wed, 25 Mar 2026 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHLyN2tH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D2322B7B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477385; cv=none; b=uhN/pDY94sNLH7zcjBHxBIlvRjfZ2ntORHInPdyZwC979lSbQPZakWSntGY9/ZNuNQS92OlaGzZN9AKBvlSpweInuNEinASCeI8X6AcsXftU+mqx7+M5JbUZdalSfOltUgdXl8x7iwKrXE5bOIZmSaVxp7619fitErzRMrK86co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477385; c=relaxed/simple;
	bh=4mCo1B9oGELRCRHK8IpvVydSTLTqKQvpRhF/UTBjfis=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KN+CzzRmaIUqaJRrWZfs63f39sgIRe30cI+tb6JC3YN+V5+GXmz6eZae6w7z1XDkOZcnI+RmQg1RIruS3Lm92PcXM8GO/Jio/HfteXZwv1I6Y92earXhV9wrAF9h21q5zsE1DYQ5BggO2zpbjxbzL0+Tc5lAU3joSNGvAgDMM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHLyN2tH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so2364775e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774477383; x=1775082183; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5dlCxbXlO9FLttl8zhdD3K0KJSbOTVc1u+e1uevTx0=;
        b=OHLyN2tHeab2WsO0g7LTsLZTzWDQAJNjNoMbsZvN7yi63qDIFpuliGZobKGnpD1kHc
         7l2Z/6RMHH9GaqRbwcght5N3WHbmzeTerLocioBnEVVpE+jQqSTeGEUSBKj4jqgPlBvU
         Fi0YKo4uWk0PFCPqtfVYAaaACw4F1xOUvTs4oNqrhCDmEtKMxA1Taqu/y6wxAZG6sTL0
         wgpezdmnLClhl7kuQQJy1RnXcWAMQPSHtAySWlDMR971j1kPa3fzsCOUUboNDkFb6MRR
         UupUXwoMvPZuEz59vSnB9EEC0bmZ227qRJgR3ZEJlRvVrXWGQY0Qi00JMr8OOgITdcha
         s2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774477383; x=1775082183;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5dlCxbXlO9FLttl8zhdD3K0KJSbOTVc1u+e1uevTx0=;
        b=qDTVOidZ1JGF4GqMXnJ8AqCzrX0jDi+OTQs2yeuVdCaEE3O+sOyHZDJ8+j7W7UMYj9
         5BkIzhfUaVtMQ8HH8dsoAN4hPohlsZtQouI4Z85pSg0gzKZSAqVdmiN2R2sdpLCwcgjc
         2MdooIjzuPHn+nKnLYwZBgGdx9NIPfRlGIiNczKX/Ed1htiKueMJ68UgPALbYM38d9pt
         xT/ZkRCvd9RtHTnTqEu1th9VjGNSER8cSwCJA1iOMkj6UCiyEU1aueRFFK3hHrufUuZS
         IrdCVPaqkC8l+Z+mv+hlHJfg12CRnB017WeaY6qiT2wV4+HcHY2kn0ZUXmeAAi7rErpT
         nYSw==
X-Gm-Message-State: AOJu0YwCGEyeS1ZV0/C17ZWUa8O3CjkULasMnaeANZB15T5vRpviiQEe
	Y7/+bOHag6PCaV+C8mba9vU6dYmVBvV2of1YUP+keTLgBA7+k/7I8Fm2Y6GT0w==
X-Gm-Gg: ATEYQzxycy2EPSjyH0fMVFAukdek9c46TRTdwXlLtxGtA53pnf2SlDI6oTqWYRXCDkM
	gn87Q5yPJFq61lbcj2PzJznkBUDnoKAmzjLgCBM15nDYISEFMnd9AQOvH/WM21sr9w2psHDwpUg
	TOfwreJzZ+DjTe4y1kT+uHp913g+tMBR89ACy/odLWGs+qC7/rrfYROQX7SOwQJy3Xe9v5/Le5T
	YGQ5dIabh346nNxByjDwAlIrxCOnZnakDty+0ECgskjOY7adEePtoG+1wQn5JcNo65LwCBMPmTh
	Yxt2qVe/H1AM1Bf/lFenlusAMzg5jBQlKH5BALJcm0I46vwBByjohNIPQUzzBupKmWQDz2RO463
	JNs5jMq0dW09gimjwboEjbOXDFu4MbOHLtwtcXT0jjZpBEmJrPxGPyEitsEo0y/grPTt34fNyno
	oorEIjCcxImnqiHgHN74V7eb9l2vQ3+xSK1bloXl/N
X-Received: by 2002:a05:600c:524f:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-48715fc76bdmr69490075e9.1.1774477382478;
        Wed, 25 Mar 2026 15:23:02 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487209204d5sm1812745e9.5.2026.03.25.15.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 15:23:02 -0700 (PDT)
Message-ID: <c25a7fb9-4f33-451c-9025-48d8904b53c8@gmail.com>
Date: Thu, 26 Mar 2026 00:22:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Fill fw_version member of struct wiphy
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
	TAGGED_FROM(0.00)[bounces-33903-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CC0332CF71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let userspace tools like lshw show the firmware version by filling the
fw_version member of struct wiphy.

Before:

configuration: broadcast=yes driver=rtw88_8814au
driverversion=6.19.6-arch1-1 firmware=N/A link=no multicast=yes
wireless=IEEE 802.11

After:

configuration: broadcast=yes driver=rtw88_8814au
driverversion=6.19.6-arch1-1 firmware=33.6.0 link=no multicast=yes
wireless=IEEE 802.11

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c4f9758b4e96..0bcd2c064106 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1819,6 +1819,12 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 	rtw_info(rtwdev, "%sFirmware version %u.%u.%u, H2C version %u\n",
 		 fw->type == RTW_WOWLAN_FW ? "WOW " : "",
 		 fw->version, fw->sub_version, fw->sub_index, fw->h2c_version);
+
+	if (fw->type == RTW_NORMAL_FW)
+		snprintf(rtwdev->hw->wiphy->fw_version,
+			 sizeof(rtwdev->hw->wiphy->fw_version),
+			 "%u.%u.%u",
+			 fw->version, fw->sub_version, fw->sub_index);
 }
 
 static int rtw_load_firmware(struct rtw_dev *rtwdev, enum rtw_fw_type type)
-- 
2.53.0


