Return-Path: <linux-wireless+bounces-19075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79BFA38F9E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559F43A1D9D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0B414D444;
	Mon, 17 Feb 2025 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXHCdmcO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5855748F
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834871; cv=none; b=TmM9ValsAg2V/OVP7EvXvESpI/uuoXyzScmSDO7CNzpRlrRNoFitNJBmvr3Ilv6Dim5U/FXAFA0yRpJOMj6WUGcxcgAkAFpq8eJn20RyX9f3cjl3cQjtyTihSr1BKvwx+kQOBKMcF6z2qOsAaehWaUMkkU3gY2Z4YQv5ImaBaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834871; c=relaxed/simple;
	bh=IBDJpAMbQaoTeaWB9L+UeBgVKDvJr90XoyQktSgKayc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SE7zNJPU91uGQd2ZSTt2WkWKh7TZMeBUZOhX2Pqc8a5koQ9jQWI1LHK84em9H5yqrGn9pG1OEIqTc4mFaNnZtiQnPjBjC2b3v3hKKUmY9Wx7I0FF93eJZ51b11qlgE+BtSBS5ODpMz1B5WBT2iN80Ey/gTB7QyKVbtPMCo961OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXHCdmcO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb7f539c35so484686666b.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739834868; x=1740439668; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwttdV5p+BCxtEVazybxyyErhkw9LQF/724Iv5cOIO8=;
        b=aXHCdmcO/ROeAPM2UpgSrO/UVVe8mzfdrhPuze7LgHcddm62YNC91dOrl/xAo2oM0s
         g8lcCgD3g5BmxW7rOgNcA0FnmX9te259jW+nGTcbSub5nHtTgM7cIZnwYC0d7EIwZZRs
         IrUTENw74lVHOvFQI4cboWl7Mw2UBFsl+QO4oc3gR6qUOS4nXaAqd+zOStd0m/9/ScSU
         Uw9OB562rPcWAdeLh6ZflJNFTg+Afp7+ABPxgX2SdkhRPtCNJwvtaUM0DV4pMt45t59b
         uPJHV9og1W39WL/B/e3sDPnO/0iP+EXFRVEMwPtSXRqglCQH+SsHKbAvE9ybdo8KDuJO
         W1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739834868; x=1740439668;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rwttdV5p+BCxtEVazybxyyErhkw9LQF/724Iv5cOIO8=;
        b=pY6QErTvwrHy42a2/iyaT64qKMbH4MI0B9XyVQMiRbdUlLP53gqXGhx2PPPKlnPlIA
         mlP6DOpDNkso7hW0lG1GlDZVtc+rqvyZjptTafOP+ff0uLr63DhQJ8y5yKAtu0IdvNVS
         tSBxRshLEbwswoXhQkyh6baa2+Jb5R5SydL6QURXDp8JnRZO7MEOX64x/z5Tlq5XxRhQ
         2qHZcKSN7j+D3/FI3324b5CAEJk6yRSnk+UZxdsWHJLIREHLMtI74T+vUpDUhk9cNw3u
         9XAVbQTB0++L/2t0q0+iIyCjSJP4t284wkhG1RpMBVK4WZOmOISBeLdPgkQQmC3O4Abx
         2WZg==
X-Gm-Message-State: AOJu0YwX/HoWJxsRp7B/Cs4azAQVKHXqQI8d6nO/0UVRmKg71hnmKwVJ
	TinNvdkqfob+BlG62rFVBuDqYkNiJalyZWvDeUqxTxk0GfN36DCKpLHBAw==
X-Gm-Gg: ASbGncuxdQcKknNWntas4Eu6KMvJJhZRvrjaAj6VO2+/1rZjbNxE7O+4kH9+doDiFcO
	MZhiYYtm0GtckXQ5Q4hLtFL3FIW1ZeeDwjgI96e7uVDSUEaICivPxYpWDp46rhpCoGZZfb+n3Q5
	NzMhjsrBfJUr7EpRLXOkBzC9hiNyiD+UNU7YRNXzK7JErYRoJa6ICQ0e2awlIoAVS0hdSJ2TdAC
	TUj5vg32CuptcO12g55jqaIsMriiLTM47JV47ROfCgYp9O46vpglxb1uDojJrO1bTz4HzbcTQtI
	cpS+PCW12PZ537uLXEbyzyDr
X-Google-Smtp-Source: AGHT+IFZqXi6aUJiJlkbSAEoFJpOM1Ma8Owu/EWjB7/geKIIa7ZUV5SHp+nXMPfqGBT97/PEErCWFA==
X-Received: by 2002:a17:907:da4:b0:ab7:a5f2:ed22 with SMTP id a640c23a62f3a-abb70a7c9b4mr1135181466b.1.1739834867665;
        Mon, 17 Feb 2025 15:27:47 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb961594absm326197966b.111.2025.02.17.15.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:27:46 -0800 (PST)
Message-ID: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Date: Tue, 18 Feb 2025 01:27:45 +0200
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
Subject: [PATCH v3 0/8] wifi: rtw88: Prepare to support RTL8814AU (part 2/2)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few more changes for RTL8814AU. Fix power on/off, the HT/VHT
capabilities advertised to mac80211, RX statistics, TX power tracking
stuff, debugfs stuff.

Part 1 was here:
https://lore.kernel.org/all/9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com/

Part 3 will be mostly the new files for RTL8814AU.

Part 4 will improve performance.

Bitterblue Smith (8):
  wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
  wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
  wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
  wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
  wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
  wifi: rtw88: Extend rtw_phy_config_swing_table() for RTL8814AU
  wifi: rtw88: Extend rtw_debugfs_get_phy_info() for RTL8814AU
  wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU

 drivers/net/wireless/realtek/rtw88/debug.c | 57 +++++++++++++++-------
 drivers/net/wireless/realtek/rtw88/mac.c   |  1 +
 drivers/net/wireless/realtek/rtw88/main.c  | 40 ++++++---------
 drivers/net/wireless/realtek/rtw88/main.h  |  7 +++
 drivers/net/wireless/realtek/rtw88/phy.c   | 24 +++++++++
 drivers/net/wireless/realtek/rtw88/rx.c    |  6 +++
 drivers/net/wireless/realtek/rtw88/util.c  |  3 +-
 7 files changed, 94 insertions(+), 44 deletions(-)

-- 
2.48.1


