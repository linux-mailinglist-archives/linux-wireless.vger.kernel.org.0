Return-Path: <linux-wireless+bounces-34976-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCU1CRXb5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34976-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:39:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85122424316
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78C79300B775
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FE733689F;
	Sun, 19 Apr 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxZDBoha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A733998
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776605970; cv=none; b=q3CcXmX6THME8NUvs+oLqDA3MXFWyrClsgDYHhVPntEsGEj0V6HL5RpermkedeVXGS9WYSt7U6av9HLOXWN9YZsufBRVOZHnNQpBWTUmwp5bICn7U7dYG0tv2I0KkKsnOeql0SulslvQSJBQttfLLbuY9T0gYVvn5BR8DldGd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776605970; c=relaxed/simple;
	bh=9fLukUFo+UpqX4n77RVrQDGUrV3cAiZV3JfIup2UUzA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iEOjmnfdYvs2YZD4+EzcQk1iZLv90upfrOoB+nqXe2nRQzKcNNYy3WBz2op6qSKQx6HcMp3BLtojpjw8EoZHXRLq5xU2AqMsCLY2YqobQngFJ2EVmfT+Kp7ELrP2ISUaTmsT7rsnRy4oPFYvavGnsIAxMzK92/d9UPZBuOWh2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxZDBoha; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7650202fso1737266f8f.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776605967; x=1777210767; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ6LWd26xEUVUD3Im8mCf9l1O0Klcw1kufpPaBAGolU=;
        b=MxZDBohab2Aa9iuZUDUbqH4fFzOxR0zPBXpZyQDFkB4PVRC5JINu+j0PCniTx/pLrk
         4uZPFhaH5LeXdzc5bTr+n5w1rxqwb66nQw1Ulq2OvduJ9GMrxCU0lUIZOaJx7ZJA+T2e
         vNYqasodoA7jEkRmODlnQ/dHk7zDyAKVyVPpdkEjWwHdFDdtivOQ9bkOnTw5UfIP3ZTu
         n/817ualaVGDuOnsC2sgw00h67dipjEIaNcMwHpID7QLsGC3+NPLuWML5EuppLLlgsbt
         5CvCWKdwAhZTYZy2hcUIEKSxwlK4IUGTOcQhGLFqfngyextngpCnJtce+AJtQ8HcP92E
         Mcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776605967; x=1777210767;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJ6LWd26xEUVUD3Im8mCf9l1O0Klcw1kufpPaBAGolU=;
        b=WGjSflCY9x9hw4DUfdjn6t8MCAIlYB4DlS8jHPSBIGtrgLLU5Yfi2r5g37F7OAZxqo
         Cr4gjJDOrz2KJJ2jKY/sx6Vk7Z/plvzIc0JqNNTkO7gqaGh4lkWgMpvv9pJ36WsyFZ46
         uYM2CHo1zJ1fc5oEkKHX/cbfBYtXOQSRvJinvnNxshsVJlZEBGDzBiHNDROtdiZdg3ek
         L9y+OavStTmnBkfS0JvdAaPfpnZ7DDWm8vgc1g66VIvnpKEpQgJGFx0O5Dawl8sn3z/B
         esMnmzZE/LbEqBJ6My0RKkQkbemvVznqMpd0LwPK9zDgxp9AS+ryk5GZjgyDlSuIg+CM
         4pGA==
X-Gm-Message-State: AOJu0Yxz8/1CQ8bDQeHsWou2Si5sYMIlbklxN6Z/zhrHUS3WGc1nLXNN
	Dck+9ibkz9FpJ6fFgABCYRlCymMk0+vcpD2ZwRjmzWuPW9s8YDLZO4+NLqVM8A==
X-Gm-Gg: AeBDietkoCTbg88ZMaXAObwZ3iENMdMMOEJiqzp0n7+AsGhAN/2CleoBJuXmYCu9mc8
	krIHapitvcLsgd05Y1Z9p6hMzAQCbfaP1PVbeJcwiqn1a47ez9mis6abVPDM4aMOYWny8TlzwX+
	ohjpy0oxO5LmxQXCVbYpb8xfU9O9fheFjp9IAlELZkaaGpnsvbfBeYCdl57WKqFq8bsko+o0qxM
	AX5Q/xTxkespWVRggFiUlheUSY8SSxKOTzMEZyR0svVB9nu8paXTSRcbMOEyi+9lgcyJpmdN0XK
	SgMjaIoIaMQVUek3Aimgjxh56oVxJhm/E1NkxcNCNPfblGfZjZOBNsGBoKZX/S/n8ExLAfzMOx1
	fEin9HjvU/pY5eljmp/CndIyA6P/z5x2W+LROK11KelAwt1HVWGlBr+/dV5W8AAXvrrE/4DAJAn
	MWnAXCzmdNv7D09Jhd+qcucGSgIGjlkBoFzlg7fg6Z
X-Received: by 2002:a05:6000:2887:b0:43f:e99a:ff91 with SMTP id ffacd0b85a97d-43fe99affcdmr9892533f8f.4.1776605967249;
        Sun, 19 Apr 2026 06:39:27 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm21158517f8f.9.2026.04.19.06.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:39:26 -0700 (PDT)
Message-ID: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Date: Sun, 19 Apr 2026 16:39:25 +0300
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
Subject: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34976-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 85122424316
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two people have tested MLO since v1. It doesn't explode, so I dropped
the patch to disable MLO. (It doesn't work very well with MLO, but
¯\_(ツ)_/¯)

Bitterblue Smith (11):
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
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |   2 +-
 drivers/net/wireless/realtek/rtw89/usb.c      |  40 ++-
 drivers/net/wireless/realtek/rtw89/usb.h      |  11 +-
 16 files changed, 448 insertions(+), 42 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922au.c

-- 
2.53.0


