Return-Path: <linux-wireless+bounces-33981-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBALBAlTxWmD9QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33981-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:38:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE68337B23
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42B7F3002903
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8231F9B1;
	Thu, 26 Mar 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb77q9dO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9BC334C27
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538485; cv=none; b=ON1eu+xq+P5vL4vGFQkRCGwCeCbURdMO+9tvbq94RPnqM7L9AbYU/neWm3G26F9Qcdze01ppuGf85CrdBuz/hYBYveYxeAhi/Ofv77eyGAK0kUUQcrSvEVHNJADPmw2Sd+zzZ6LMY1hXfQeVREILdix27no7maIGySisAtCN0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538485; c=relaxed/simple;
	bh=3TKHKV+pJMntE9082+8bkW8CCU7tTUstc+TIFFXlXMU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GcAYup17g46YMR/1628zN9diEKk71zygDvldNq99JBX5svqF6K549DxGSOKCb3R8L3gmEX4ii5OZZeuhIulbd9PHfoVNYuu+qgox1ITLZV0CgYWYQMkUS+Pf+kNkkfhcfkmvj7H37D81fGkzyRG0Yd1bKWdJZG8Vq2JRKV9u2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb77q9dO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48538c5956bso10008075e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538482; x=1775143282; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjF0i7CbUFZknrCpt5GaVeCWnETCD2UgDsURBuaQ0/w=;
        b=Jb77q9dOQWkOJdUH1YFtrGwd8/NkBOeGpEgV5JLxRFPntJTCehWmywPIYR5ANRcAUa
         0X31ZPpuv/47RoQMq0zMvbtNgva3ov47iTg6AXnFCsun3UQ1YDcl3ukXDslKSMj//Jke
         zdcJtDtPOE6q8CRzgESMaBT+scKFLYlO0k5yEh2CNspwvoKHzqOPEuXVhvx/7qCHNhxP
         brBev6kMuq8vqiRYD6OQuwS7eGY2qDgbna5sW942ZCm4cNJ2L3EuAvySyWaSeabrXCg2
         75FbU9KWLkC4fkvHw4P6woHKdfJQx5Y3HiWw6QyoUNEBUKn3l8/TvXy2bl1cKRFnL01v
         FIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538482; x=1775143282;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjF0i7CbUFZknrCpt5GaVeCWnETCD2UgDsURBuaQ0/w=;
        b=bhcswvB3JupAKOlUE704Of8f0Jx2umwjHZK/U+nPS1yzg6X6qB5r/fPD4/E3Qsujh0
         zSLtYWNSker0lLfV1leJ86mWHwSFKF0zCcDeXOECuji0LB+mJ3mJAmdr6HmgUEMnoTAX
         gNBWXZwztSc8kpslJwSfSqfWYGYdKgW2XCs3IXm8K8zJ2hWFbMxExb2Qon36KP4Vt4Zj
         fkmXHL5GKlSTFAdmhsZ4w++1THFD88XBi5M73rB/bfGSfmD7yTwtDcDdTTG3ErWMU4wX
         a0KpvHj+fQoMUqWJXmW4lB2bFq9bi9yKTfPyMxUsRNIiLadxlgWz7SsK49RXw1vv0UI/
         KtAA==
X-Gm-Message-State: AOJu0YzBzWJcn1Z88ZTPUG4b+ny1PxOLqRVNnVC0xvQii4pwMZuEssiQ
	SQO/HhyVVgcFx67IANp7LWAPQCEGD2vmprh/dVM/0RIKQCG+a4IEYb4HZz3hQg==
X-Gm-Gg: ATEYQzzJfwjkhnrXUuBIuumcRCjVoQBRaB0bJ45Ailxs3FOJ9oFG08Rb2hq0fngT23z
	b1azBiJ0+MNDSBKVEsxU6Hk3DL7HIp+pdYIH6Rzm625jjeZqmQqGoEXIitpLXAHDgh+NWH0XUfi
	+EVCZHb0JnDiRTntsxBj86Qox9XbdAh179yZndYcRJyYVjBBKkwMBULBFa5J54KW74wtLzcjS2t
	eE/TC6E1MOfqvMMEaJyvTAvq3elRbIAVGlDGoA9ZXNwGSekRVLh7OTLzsJXad9FCvLg4JvTK+fd
	Oelj51VfsbkhAUU9pwzbL+NxThOrvPoSvl49r4iPChGmMRLw12g4Iwgmjh+qA5Ytl86nFjTTPlj
	BtUMLEsdAtMywJU4oLwAsPCXYP4t5DzxYbk0itt1aiRW3ECKwRlNpNrz0qB6OM5vvFaKy2u1gTO
	BpVTbn2brbU00Ayt62AsyQtEhfIJAtgQ==
X-Received: by 2002:a05:600c:a30c:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-48722b92f7emr27046095e9.1.1774538481754;
        Thu, 26 Mar 2026 08:21:21 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb4bf57sm33930895e9.0.2026.03.26.08.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 08:21:20 -0700 (PDT)
Message-ID: <3701cce1-42c4-4382-9120-cd21012c1b21@gmail.com>
Date: Thu, 26 Mar 2026 17:21:19 +0200
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
Subject: [PATCH rtw-next v2] wifi: rtw88: Fill fw_version member of struct
 wiphy
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
	TAGGED_FROM(0.00)[bounces-33981-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 3EE68337B23
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
v2:
 - Use local wiphy variable.
---
 drivers/net/wireless/realtek/rtw88/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c4f9758b4e96..cd9254370fcc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1805,6 +1805,7 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 {
 	struct rtw_fw_state *fw = context;
 	struct rtw_dev *rtwdev = fw->rtwdev;
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
 
 	if (!firmware || !firmware->data) {
 		rtw_err(rtwdev, "failed to request firmware\n");
@@ -1819,6 +1820,11 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 	rtw_info(rtwdev, "%sFirmware version %u.%u.%u, H2C version %u\n",
 		 fw->type == RTW_WOWLAN_FW ? "WOW " : "",
 		 fw->version, fw->sub_version, fw->sub_index, fw->h2c_version);
+
+	if (fw->type == RTW_NORMAL_FW)
+		snprintf(wiphy->fw_version, sizeof(wiphy->fw_version),
+			 "%u.%u.%u",
+			 fw->version, fw->sub_version, fw->sub_index);
 }
 
 static int rtw_load_firmware(struct rtw_dev *rtwdev, enum rtw_fw_type type)
-- 
2.53.0


