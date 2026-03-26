Return-Path: <linux-wireless+bounces-33988-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI29DGVpxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33988-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:14:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857E338F8F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 876D530C7E49
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157923A7852;
	Thu, 26 Mar 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSUxrCbA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AA37C106
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544555; cv=none; b=DOVj21+4xO94U8GoEEcrzqDyA9uAci5B/IqS9UFnmbPZXuN5cBUAJVRlVTxoJDo2UT92KpNxMI9XEIWpsPazHxLKHwehDSBuB85zvphq1LkIjScMT40MVGa+NSUtO6+WzCS3LoMB26qGemGNmR7Mg/UQ5jrQzLHEEp7m1+qTVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544555; c=relaxed/simple;
	bh=JAY8i1mlZ9ytB9GHeSkogaGwsnnEBQU8xR7B22Kh63Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mErSHm48e86pKOWPhRpNc17hC+2WSOJOOqCPC084Zx6P/SGYrJUsn3lR09M5KBpMx6YidB+FPsZLd2is/WvbccDDuiB1Zh6tDQsOt6zzxJj3HhHVwseuGYdeXKWjGyVopgd92ktsaIevwSA5fwpGPlWtFDPICjU3BsMMWqmwhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSUxrCbA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso11011735e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544552; x=1775149352; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CxzgmGWaKV6m/b8UjqwnsmPwTgnAEA1haYOH0pbCaE=;
        b=BSUxrCbAd8J68StW0AK8daJa9Il1Qu54LmBHUHumI35T92acaClPynxJ54D2wqOCR0
         1GeZPM5+1BDEDWEBsEvVyS22YqLmg2QHF4mcFcaBA/i1XSVlpo2Y0W3YBbq1ACKGDZWL
         0eOI/fgkoGeCEU16wEWjKEqM0Mn8zDQUbA/KdgI+v/SwalKht0SuLDurf05SM05bgYif
         JFZNoYbpMQFlI4nSn+SrRHfWYdWpUNoxElJhvINOeEHLBh9WFKArYtbT1jJoQod4KFpy
         RROW4uIjn/cqw35+LZztct8QxCU1/hXMm+EeXaZkEcqcUKEBkAt02rXOdUvepK5acFhX
         qgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544552; x=1775149352;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4CxzgmGWaKV6m/b8UjqwnsmPwTgnAEA1haYOH0pbCaE=;
        b=h8HaIYRtkwEl/yiegFZ+VIZ8m29bj2GrbIzt9vvHZQoAw7fwqL1XzADF0mtIInqRs9
         N/ADtq+5u7SYKdjkW2sUYbpCf0Yh6/TRU6YJ7dWqUPABqEaXRImCugWktT6oBecJ7G9o
         nuWnYeetej3vRll5skPJMZ5dycPUCXwDwmM6cRbyk3cNJ6PnFWcfQYE8PwD2/imiDuOs
         Vw89QXeY9ePjnjlk06ktDus+qDGpUgcM8EKfQWBmGi/2nswNqFFz0psN/BYipJCIecwp
         YhacYMCRVf5URVW+CyuedjBKuzQY7YAsm8Z357MNaetgM2wP/hRZ7t18cyTqf57QyVbU
         7AQw==
X-Gm-Message-State: AOJu0YywWXB/3Xu5j3Re9HdHhLZ65AMg+lFkFNjzEPFzG5RWzFYDNZbU
	QAiUAbAVcp4+8bIWF8H2XSXdFB/PdkYo0f5MgxdKdKf0j3faDx+bueUQlGsiSQ==
X-Gm-Gg: ATEYQzyUmQBrwH3zxuywveueCsl61KFeoeokNRGglA5coLZrG5Pc3mwwlELTk+5tth6
	07nLhuu6fcU2bp3e898xdOPe6mzUyBJf44/jY27J9ovezeVgM/qOQ+WVig9mWnlJn0M2Rk88eAa
	CMO/FNOx43FFmXT01pI19A/RL1iJV3PTuXKvANtwEbHfnAG00wCqbFMwbP1EwvOFczyJkxb1wZE
	j3lXtN6HEHcIO5HKhLv03y282iPDKSfks5wZK9nmQqbW1GAfM9+IWClDzWieCu0tBHBoXnr3OLQ
	KQifo7n+6WUAv2QxLlemVUI3WvyW0Yy2omjQCQMnc+odXvTjsapMVCBEUGmvhdps9gX7WKDwsAF
	7VblfiWSXVL59w2Ye/pO/1++H9AHyRPpRCENrE4cmhxi8+3A8+nq3V0MDor4uXm5guYccakoVkt
	4mmkoiju1/CthYqMsCt0JWridLcvfCeA==
X-Received: by 2002:a05:600c:3491:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-48715ff3363mr119122625e9.11.1774544551724;
        Thu, 26 Mar 2026 10:02:31 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720937962sm18034885e9.32.2026.03.26.10.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:02:31 -0700 (PDT)
Message-ID: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Date: Thu, 26 Mar 2026 19:02:29 +0200
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
Subject: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
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
	TAGGED_FROM(0.00)[bounces-33988-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 9857E338F8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Often one or more of these messages appears when the chip powers on:

[  +2.167037] rtw89_8922au 1-2:1.0: failed to wait RF DACK

[  +2.942749] rtw89_8922au 1-2:1.0: failed to wait RF TSSI

[  +0.019006] rtw89_8922au 2-4:1.0: failed to wait RF PRE_NTFY

[  +5.985900] rtw89_8922au 2-4:1.0: failed to wait RF DPK

It's unclear why.

It seems to work well anyway.

Bitterblue Smith (12):
  wifi: rtw89: usb: Disable MLO for now
  wifi: rtw89: usb: Support 2 bulk in endpoints
  wifi: rtw89: Fix rtw89_usb_ops_mac_lv1_rcvy() for RTL8922AU
  wifi: rtw89: Fix rtw89_usb_ops_mac_pre_init() for RTL8922AU
  wifi: rtw89: Fix rtw89_usb_ops_mac_post_init() for RTL8922AU
  wifi: rtw89: usb: Enable RX aggregation for RTL8922AU
  wifi: rtw89: Fix rtw8922a_pwr_{on,off}_func() for USB
  wifi: rtw89: Let hfc_param_ini have separate settings for USB 2/3
  wifi: rtw89: Add rtw8922a_hfc_param_ini_usb{2,3}
  wifi: rtw89: Add rtw8922a_dle_mem_usb{2,3}
  wifi: rtw89: Add rtw8922au.c
  wifi: rtw89: Enable the new rtw89_8922au module

 drivers/net/wireless/realtek/rtw89/Kconfig    |  12 +
 drivers/net/wireless/realtek/rtw89/Makefile   |   3 +
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  40 ++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  25 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 264 +++++++++++++++---
 .../net/wireless/realtek/rtw89/rtw8922au.c    |  81 ++++++
 drivers/net/wireless/realtek/rtw89/usb.c      |  31 +-
 drivers/net/wireless/realtek/rtw89/usb.h      |   3 +-
 15 files changed, 430 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922au.c

-- 
2.53.0


