Return-Path: <linux-wireless+bounces-29003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF8C61C3B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCCEE35E42B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386223A9BE;
	Sun, 16 Nov 2025 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPm7UMSi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFC246BD8
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324755; cv=none; b=cfdgez1E0dm8O+f3dgK0mMSLPDhAuZZ8YoWqIAiRwsf+3vBgu/yueBhCvNHFqZbdtYNt7UxsHsQwHs4NSnjsc9wQd3WuMmaWwRYbWI4K3nOMq4UFLO71eHqN5teQJoFHJWkvDUqXvYGOtL2mtqytBoVwX54NGhs6pz15HoYBVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324755; c=relaxed/simple;
	bh=vibwsAnQ6TYmoFkktmbskn56ULj4gx9ASdbsuW6hj9g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ME2WGKPW/RVgfY3xVoTaZiDX40HWYdbs9nHLlMgBMPezkMNjz1sd3wAV2I1H7tLKfvWliPmWqZQFUx2KzHUwG3vmqNcq+E3hBJw1Hu3LWN3hnx5nHCqAZB1Z0E6jX40UkGsxF28RaPZjT87N2QlTkiId53EObwww3KNPDxnj51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPm7UMSi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b32900c8bso2016926f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763324752; x=1763929552; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epVDC+bKYkldVxgN+BZjvFP0+vBZAwWRj11JJDkU83U=;
        b=MPm7UMSiKUYb7C8aSG2o3A5OHaxKzd8ox0UKvl6ZWnViVwFFhNjLQ7uufGcYIJ/n8f
         izecC7N18Mf8b6VJtfN9WVUwcHNqNX5si2/DD1Hi9nCLI6CO8zFxZkkOv81pIL/GU+KP
         LR6gJ001i2PNAu32RikWSDyEM92MLEkCsNRnacRrBJzzJiiS9mi4oR3VypCWiZXD6Kna
         sidQkPe6UO5ZJveRPuzWcZkeli12MDnaAl/gyn5F3+ZhjioyHyV063N5h0/4xzZTBwK2
         PKNrxh2ENRzIevurX+6ijCyPfdOfaI1TIfoyUPIDgVeOGc0FO+ILLwACCVYMMhATRjGy
         RI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324752; x=1763929552;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epVDC+bKYkldVxgN+BZjvFP0+vBZAwWRj11JJDkU83U=;
        b=fcZWFgH71b8Bnj0k9SPQbAx4Rf7r3yVcgShHivWnShjPGBMuljL47Ya26lu9sw6OFP
         /3eZiqT4TFweN8qIC5uHYjGFWxkqqtOJt0iRRbvH/X79y+T0aO4kwMZbBIOOlaCWaubX
         JQWoA6JThldOZS1tlZniRtzU/Cz+gr8SsDcLBiTJawLuuRI+WTkO6kuB7AUDSERK8ZuR
         3u4SbPbGK0Uc1gwULc84W6aYbeuxi69W62tcifuV7siVdYWnh05n/8WLFX0kM71A9fir
         n4D1Sti3r4ZMw4dMZK/Dfs5hCS89ej25LXZLcbGfOfl8x1lheFpw8nnIaoJFOdiwBPsz
         xWRA==
X-Gm-Message-State: AOJu0Ywmz0oGxerSyyAC/mkotxFNxniln2sgAgM+s5Y9s62MYI0WBlkH
	Elu0RM0mN39WMkI654rpajgI3ZdnVQ6mrA9GB9CmTBXNhZDKcfR7M6PaqjTbrw==
X-Gm-Gg: ASbGnctRx1gS940MLiQN0x4YsmolbszK8TUZUVDOBnTo7cIA+GefWPq0uOA5hTtTnvn
	fzxBojvzcg/8dY5i2dEbByo2q3QeU6wIhGCuvQOS31VpAOx5rczHYth+NC/wFf6pd0AdQSFUq76
	eGCn3VUvKjIzKL3qhXxr1+v+kwwbijVPe/EFJBsQO4E9QBU5sg2bIJjVpUGfcTTBd6w0hrihmFg
	rp1Ghx+tB0XBQhvXs6UvZ24dfsMTTMqZkJsPf8PpYbWGkDzHj1C0mb0wFYij59GKZzJrBy74FY+
	00cnVIyAW66GTNA2YMhqLYyq19RECzx7b3giRPgUMxmNSaWrR2wC7o3zghnzsv4j9KXPkkgvneA
	V2qAgnPMGPspiDC0YsIopNM/YdM2sWW6/1w/43kBNBPbBUccnyWOJQ00QxFQsZV/baH5LM5CbAP
	AIu8f0ABK0uHN26mYOfCY=
X-Google-Smtp-Source: AGHT+IEzqUwothMId/1JEGll6Y7XItZ+w9yD9izcnUPN4Xgbe0geWiWPnf0eQ8JTy/7ogTjSLrIvPA==
X-Received: by 2002:a05:6000:2882:b0:42b:39d0:638d with SMTP id ffacd0b85a97d-42b59345451mr10652335f8f.28.1763324752089;
        Sun, 16 Nov 2025 12:25:52 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787daab3fsm294075045e9.0.2025.11.16.12.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 12:25:51 -0800 (PST)
Message-ID: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Date: Sun, 16 Nov 2025 22:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 0/5] wifi: rtl8xxxu: 40 MHz fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All the chips should work with 40 MHz width now.

Bitterblue Smith (5):
  wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
  wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX with 40 MHz width
  wifi: rtl8xxxu: Fix the 40 MHz subchannel for RTL8192EU, RTL8723BU
  wifi: rtl8xxxu: Fix RX channel width reported by RTL8192FU
  wifi: rtl8xxxu: Enable 40 MHz width by default

 drivers/net/wireless/realtek/rtl8xxxu/core.c | 52 ++++++++++++--------
 1 file changed, 31 insertions(+), 21 deletions(-)

-- 
2.51.1


