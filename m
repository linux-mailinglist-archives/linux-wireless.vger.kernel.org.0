Return-Path: <linux-wireless+bounces-24840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE41AFA170
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 21:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7B01BC4F4B
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8721FFC5C;
	Sat,  5 Jul 2025 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7WLgkiK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79D2E36E6
	for <linux-wireless@vger.kernel.org>; Sat,  5 Jul 2025 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744076; cv=none; b=Kq5dVj5s3Q77KVRMEOfWBotTeGhlr7QlI8I+Z5WpxvRkchoxPGcJ+JwLyOJIjIWgRH9t2dw0VZNg3NtB0dsGu/UQQIobopeb+tT0LsU/iZURXdEmQBn2KcIJ86D8lvS3bj6V8wsv5ruswLSvTVskrdSFnL9icd4kNha+oAw0qFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744076; c=relaxed/simple;
	bh=3xL1p3mPUTVYc8+eVfyy3bbsiNwM8OMifuX5E0jU4UQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=t6w3IpBeher7IHq6SC0WLNYZLFcV/JsO4ZV5NWRzUK8tEVps25hU1ESpdxV1RaD8wXJH5VSmG27J8y2//ulm1RcI/jMvCMtWwj5x8RuGVaHUrpryVe2z7byXYlSHUn9P+DBfGVO2qNAp816LHqnSQlsF5yOFh0zZdtN1zIKjyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7WLgkiK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45348bff79fso20429215e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jul 2025 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744073; x=1752348873; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukOPCl/utUo85uecROv5QiyAZ7RX8Apb3AgvwepshQs=;
        b=Q7WLgkiKGXtZ5udgQxg7p8oVVkzws9V2X8LJmJAGsmYvQ8fsSojWab41XxCqg9EhSD
         FW74fak3NEzDRu33jUjs30OFkWasD+hL5KmMesuDekcIJl5VY+Z8NF1SfOKmxxZHX6kO
         y8EHa8cguZE0bAwJzfavdgJbaEAGdevDx6P+fkgzsoNyB+W5h892wGqZGipFCYUCvz9L
         ghbGak9YM8LPhwslgJBa9uUtnbq8HWoHOVaYhtOM3Nz+Y0u7Etl506F7whKSSp6eu1df
         JwPtDSzN7B1sYMn+auTRtJspYaS68CMD+M5GcJIud4Q+3tDRFfvv+IrQ3jr4oRy8V3X6
         A4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744073; x=1752348873;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukOPCl/utUo85uecROv5QiyAZ7RX8Apb3AgvwepshQs=;
        b=u8hn378f8nXomhZaDl/0DL4AQoUWu+dATnQwLqnqMZD/wRCu5+ufNINcKEBWiK/HH/
         5uIz5W0m4z6oKwtQtbwi+OdvE4GdWNOyUzXljYbiSK2XjKR93C7rFSmUA/LgkmMa2ZCF
         ux9lphpCrNrU73T5tet/gMK6p5+2ATTXj1kGY8AOjMXYQqOclEkeB5cTZQTAdwgvaQoZ
         eg9/yRlG8vP04dp74VDBs5Gly1EdAzJh2ckFuyxYZ/Nivy/RLPF9WoICuFgtJ1jwte2k
         nMHpwdohyDiIuiyj0uM4iKeVWyO33H93S8zCfxnCcQjR/pOeJkrliQjZBUE/P7HMhsUT
         MVoA==
X-Gm-Message-State: AOJu0Yw/6oEcNNTVjpVLjt7/8egQ06lzyd3anZQey8HVW4ueDTgzS2wy
	UsD7FjiCdktdQ0Gk1r0tNZnFAMtPp3YdqxskgXdBFVZNZosUkS8AS6IEjMVdOA==
X-Gm-Gg: ASbGncs4FAUy0tnesHuhnBhD/vCZED35u/v5tmcofQIfVzhwp53y9VE8JXsqN2QzhFj
	dQxerRlUssllvPXwxv/o5+xWS1m6Y/W2eOvUNTCAZZz8zGn5yhfW2MYS91py480tMrvEmarhdDP
	1Vus7Wg6WWAGp4BTRNZ6ZTBuUMNn1+Mb/eh/krt9EX9diqZLOk8ljWdHDyzrr43139PhIcAR2/e
	PbPDoNEWoD3GnC5VLUifBtpINlM6b9H4NvaMev0ellZMvBBis9f/1X5z9+1l6owb5l/iHzy1Rh3
	R+TaLIVor4haIFfbSskY7pHpdVZANwPlbVoLwCe1XVgcJMW/2Y/PvJv+cjN2FlrhfEeHog==
X-Google-Smtp-Source: AGHT+IGT3F5LSne/hN1uaCKr6+SayhFnl0qcsyCaeX6Dst79oES6lc6Cey51QyxsUx5+kCF0QTJftg==
X-Received: by 2002:a05:600c:a108:b0:442:f4d4:522 with SMTP id 5b1f17b1804b1-454b6a9534bmr39171815e9.5.1751744073309;
        Sat, 05 Jul 2025 12:34:33 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b161e4dfsm62990945e9.3.2025.07.05.12.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jul 2025 12:34:32 -0700 (PDT)
Message-ID: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com>
Date: Sat, 5 Jul 2025 22:34:31 +0300
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
Subject: [PATCH rtw-next v2 0/6] wifi: rtw89: Add support for RTL8852BU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for RTL8852BU. The changes needed for this chip are very
similar to the changes needed for RTL8851BU.

Bitterblue Smith (6):
  wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
  wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
  wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
  wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
  wifi: rtw89: Add rtw8852bu.c
  wifi: rtw89: Enable the new rtw89_8852bu module

 drivers/net/wireless/realtek/rtw89/Kconfig    | 12 +++
 drivers/net/wireless/realtek/rtw89/Makefile   |  3 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 85 +++++++++++++++++--
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 16 ++--
 .../net/wireless/realtek/rtw89/rtw8852bu.c    | 55 ++++++++++++
 5 files changed, 156 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bu.c

-- 
2.49.0


