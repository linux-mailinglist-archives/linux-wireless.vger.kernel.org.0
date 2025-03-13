Return-Path: <linux-wireless+bounces-20350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7798A60249
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 21:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1F5168D71
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3583157E88;
	Thu, 13 Mar 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtkWWwMu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55A1F30DE
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896931; cv=none; b=JavhhQx1to2EgemKFX9/ejZA2hj75eo/MLFhBSoVoS9Q7g3DdjcdJV9QrYyIIO2edzpoeqImcwsKnPRQlTyrWFdeQHLmMPAY03bu7scMj8qDc6E/ac+e6hGtI4ekaeMb7Vw5nTrpj4FWWCg0WQVW4nc2P9461+SoDfebcOyuu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896931; c=relaxed/simple;
	bh=QngvfZ6/rx4mQFlwr+5LOMxitE/J5+iTWWkzfPldOps=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LJJ2nftLVQILF0ZHP+sd3e3KPz+S0zu5mB6Hx7IOs+z18fmVkcNJ6Vgq3ug5TyAtrX/kRpUHXh96j6YLTelISt4mNeOSpQoRSFlhlRfwQt4eerAAwV0wX6T3XaYI46A1vs+atjdAaoci8RIMsBRGTufZsyrpQ7OUApkLanJ7Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtkWWwMu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so2455212a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741896928; x=1742501728; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvULWRitkY8gBIJc8clZwEO8hikNtsML5HXcDGE0pS0=;
        b=BtkWWwMuLhMJGYMaTmhSR807BqinHFyoEXBfHNYve98cbS8DM7XxkVKR/GIX6VQqp2
         EqBNIPgSDPpNp2h6AcvwIj5LRImLD1Jd2VLO9zQNgu3H4t/pkftWPeS8t08wN9GjX1Dw
         Nzc+FXZs5wiUU3K+iRPYooXVufM0wvAGD/19Z2JBNGmnATgHlDsRdiR7t2IW3V+wG0/l
         wQ0JDQ8rqQTCQTmwY9bn159qaAJKn602YYiEUFU9voFIhBwTa7ViOmWBw5puenAf3eHC
         OJxX5+mehg/9mFGerPII6QqmaPSKX1Z/AYHKg1Y8pTtwRxA0rm/RuLGXRRClfe952/Tj
         b74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741896928; x=1742501728;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rvULWRitkY8gBIJc8clZwEO8hikNtsML5HXcDGE0pS0=;
        b=ZisfnOkv5Wz3aPVuYCGv5PlXZwrw7aPqXPz3+X6CR5lyTjvVdno9ol2Q+Ab2m5dr1F
         UeZl7Ij/HYxU0Wzn9qZlrKATyNsdW1xVK6/qxz9x0h3BCH72gDPaLkGC+8/0dHzjWrX9
         9cLQ/+UvB2oEaQQs0JDDikZFQU8l3xoidWeG1rWAVS00804rMWnd40DpEWRoZLrCZmv2
         0Pf9FNeCwlVsPn31DUfbbLblNQzZEQXKBZSHej9FNwqI8kZVGv9o7zMeIKx4A+CdbeVn
         jPXeERn1ucTxQN3Bx54CFFYDKmXRfQue+4TBnOAeIIylt5Svym79h1Un9k6Aj6XLpViA
         ECFA==
X-Gm-Message-State: AOJu0YwpD2FYzDjL5nNwD61ju13lxDEGC85Iwb7d3BgSNhmZJQnXcRNj
	NrRg/EQTb6cNnKkOs4EhXHfdO+0kUmV5RdK7/TdOLugEijYdyr7L6FYN4Q==
X-Gm-Gg: ASbGncsgX4b6Q7of+vzl8c3C43jc+J+VW1F/O4dH7JtJZ/nl6G8N9zr2soogLzFs2lK
	7f1SpMQvBVPrbYT5SO2Pss+igVoOH3Sdo9DAHO0O8mM/3TFzldQxaHPRTEZICAvvYco1nW5CfKX
	YR0+SqjJJK3Jj06Qga/Bc8sBMPCWw7GggEH/HWS4+gG4WnYzlsR9Ihg8WhHfHrwyDhv4+wt3Z99
	vJWQI7Pisk3iOJ8yuhlnAGfUtl1xoiBc2RI3JexjQCHvYaK37656PnCnihZzH3UTJv3Amk3O9Kv
	6ZtYA51DiWWypIt/qy6OaKc6N92j8fraTDX0hHGqtOULXlBuqc8UcQ==
X-Google-Smtp-Source: AGHT+IExDFIne8yUiqFByz+Ni9xSmi4ecK4EmrDVUwnuTGKReDD35gKonp1Ru/VKnaumiPQ6G76yfQ==
X-Received: by 2002:a17:906:dc89:b0:ac2:7d72:c2aa with SMTP id a640c23a62f3a-ac3296a3967mr81724266b.51.1741896927824;
        Thu, 13 Mar 2025 13:15:27 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6083sm119073566b.182.2025.03.13.13.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:15:27 -0700 (PDT)
Message-ID: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Date: Thu, 13 Mar 2025 22:15:26 +0200
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
Subject: [PATCH rtw-next 0/4] Improve RTL8814AU performance
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is the last set of patches for RTL8814AU. They make it go faster.

Bitterblue Smith (4):
  wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
  wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
  wifi: rtw88: Set AMPDU factor to hardware
  wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU

 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c     | 35 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  4 +++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  8 +++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  6 ++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 12 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8814a.c |  9 +++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 12 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  7 ++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  7 ++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  7 ++++
 drivers/net/wireless/realtek/rtw88/usb.c      |  4 ++-
 14 files changed, 113 insertions(+), 2 deletions(-)


base-commit: c61da149b9c2e439abe27845a71dae5ce5f5985c
prerequisite-patch-id: cbbeefd71b59d1fcea72cda22b1eb0e62b40a751
prerequisite-patch-id: 18beb866f984f1ed6769d95b3ab7894d75b3e7d1
prerequisite-patch-id: e1e0ceb709fe71d6c48e063768698c78558f11c0
prerequisite-patch-id: 17ec15a2287ce8766e35b1113fd043d25ebba9ed
prerequisite-patch-id: 36ff8f0da543fbc931db6cad60d8512dba82ecd0
prerequisite-patch-id: 0b5c2a854227b26491421be28b9348e098195881
prerequisite-patch-id: aef15a0990448c435356fe7631ddafbf35606731
prerequisite-patch-id: 56dda569e509fef7403a02d4700b22f27301ea37
prerequisite-patch-id: 0cc73f75273b064d6e8783b8ac4ed06a1025ced2
prerequisite-patch-id: 04fd029f6ae8a5f3d944ecb4c959e55d2599dd87
prerequisite-patch-id: fd5c77b6933048355029ecbcdaf3107183c26aba
prerequisite-patch-id: 6f50c5e526f96008b795477ce97e3c75845f113f
prerequisite-patch-id: 6d85bbc95c0eec75de67992a176907afa1fdbd4e
prerequisite-patch-id: 1e4fd27474a3622807b7fe5bfd3a5a09261fba46
prerequisite-patch-id: a762f356fc162e29375af231beedfc06dc3a4fc2
prerequisite-patch-id: 1c68d0186aabcd2c7ae21b605288aaa872651307
prerequisite-patch-id: b0c4ae910737add0d3068aa92efa265d11dd66e4
prerequisite-patch-id: 5b58a4a0870850a6768eca1a2e9d1523dfdeae84
prerequisite-patch-id: aa98043b8ed5ddaba365c045aaf0466213d18dcc
prerequisite-patch-id: af6b19b41c6357b9ff8714639465b8e95f74bf73
prerequisite-patch-id: 2855bad33fc600e2d5145902462f0e20d6d92e0d
prerequisite-patch-id: 70c46911f78d2e88af8ed220cb692e098e1572d6
prerequisite-patch-id: 2321dc9826f91f47d58605b810b626842dbc4312
prerequisite-patch-id: 55be10515d0350bcbfb3d42fd085e1492041aeb1
prerequisite-patch-id: 0cdc30856400ecfeba230ed9b794829afda6a4d5
prerequisite-patch-id: 1c806351ccc18effddcfd95b0115a6c3ffe29361
prerequisite-patch-id: d0db802298a4b1560837503141307f0868d14227
prerequisite-patch-id: d4e1536329aa0b1f5c31380a6ebf55d53eba4371
prerequisite-patch-id: 0fefff4d672b523926a8d34b5d7ee3f0f8dfc61f
prerequisite-patch-id: e1abf7108e47677f5250c07e9efc019bec5be7db
prerequisite-patch-id: 8364569d4b619093d9edb6f9c080997986a8c71b
prerequisite-patch-id: b27f8b4a034b5460ce690085cc1eaa1938828355
prerequisite-patch-id: a4d92512d9ed4e7c9203c3e4fcb0beed9fb3c569
prerequisite-patch-id: 3f906d3cdfd1b89152e6d101807dd6784eaad9bd
prerequisite-patch-id: 1784c002daf8d090cd51385d2d05e21578971a51
prerequisite-patch-id: 9856826f786413a6924dbae33e4b32df90cbf6a7
prerequisite-patch-id: 5641076795d7ffeffd074392e9555bdb33dc1f50
prerequisite-patch-id: fcaa46bee8a8ed931144e3ae5d148b9dc1d26511
prerequisite-patch-id: 561ac59d3eb36fe9795c46ff9df87a98d59d38b9
prerequisite-patch-id: 168a0efb34774ea5e586a49c611739177977c03f
prerequisite-patch-id: 5f6c96da03f26a152993e0e04d25683fd6ebef8d
prerequisite-patch-id: 97d74ae58e8d1086da32c2a2036bb38aeae87c10
-- 
2.48.1


