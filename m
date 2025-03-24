Return-Path: <linux-wireless+bounces-20784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B8A6E548
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 22:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB0718906F3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4931F1E3DFD;
	Mon, 24 Mar 2025 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="a5EijJrJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEE1EB180
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850665; cv=none; b=U/oQaevFPnrEZCM599MPkYIusRBC/JGhuirQXJkPfrNdbUxGodCbNwHvn9ErrccNJ4kRpjC4duQo5NECMFotUl1NQbh9YqZqbDSjSb3Yv9kePBapdOXBut8tRpjTb68TJ3Flj8USk1FieQH+udVJ82YW/rA7q7kY3ntxoIXyLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850665; c=relaxed/simple;
	bh=x/QWNNdQ84ZdZZgbi2Ug1TQkE5jLOUSlBi3kXHYTJnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rtpc9DPKGioHsPgPteEdNRdzEZaVOu+doLO5Kb8gvw41AtVfYQvgnPAxuqpRQlSwAun9WuUbwInRJdWam9lGSYKK1Jw9GTwYEWmI7guo46MECqi5c8IkkyLvAx0oziTKjQIPFNzhUyGW6lummetbc7GCPMFxrIcrFrnceXk1vMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=a5EijJrJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so8673689a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1742850661; x=1743455461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmL+riJd4lYn72ibOTR8bk8FMeky0ZyyKRZN5rYZjVk=;
        b=a5EijJrJbgCxGWTotb9FEIZCle8Brg9mBTEYZmZcHg48wAN/wvhSQXN2jzypGUaZVt
         7wwHNqkg+nbOQkyw01DBV3HF18mjsxpcNGft4M02OvFBjHxN0ayPZWTqKqUTrS0S9jY9
         4yhpDfQYCWQ/xrgaGVNjuzCM3sAXpg/6+tsUukogPVZgq6kcDfSCW1yRXJ11vyGBM9tj
         vR/g2RGEd3tzAgSHlEJPesP06Wgkxc2Bap++3Jno8GwwSjexHrKiAIHOe7dWOWwQsJBf
         3Bdp8eVHBYMnMD+49eWwCNnUZjF/rrgED+JEt91b4U2T8hYUMUjIIyVDUDD0hS6zJuc+
         8rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850661; x=1743455461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmL+riJd4lYn72ibOTR8bk8FMeky0ZyyKRZN5rYZjVk=;
        b=vZWCKEsA3BR+waqlx/dBaprY+fc8UY34ofOCvhz7UzjYerwd7TsAwdkppdvs8RcBdb
         kgWTBKCdggZd/Hf+7KFiwJOWcv/+RF4PHbde2pMpzWDmVAMYBlt6EFFJbYZr4gaPEuPW
         ZjwEuRXTvClwJlW5iDt4vf6tKOIFfI+kFGocAE3nNHeYWHumOztvOfukmX7AxxUJhgci
         trNx70ldNy8uWnXTuU/wiWHiTxmENTFdHwiv1Hd7EhVEAxJlZ7Z1TKAD9BNGs/On/rAS
         eifXtyAXBwOmkNaGhBMdIUL/1xWwoFYxg77a3Jo1naLmzGu32jfydEE515XN/HFEr2s9
         upAg==
X-Gm-Message-State: AOJu0YyWk8BWt2CQUe1JTgdiYcfhWs2mkfAUTjWVMhhiWhFWbanmvJ/H
	pAFQCXonPW+kdYnptyY8AuW1Q2lvRn4CI2Po9HQAddKwXOqJ0u9FhxNsbELffLU=
X-Gm-Gg: ASbGnctBkZvDzZNDrfR7QNQH8pIN3CRMvNlcBst1C1KBRkMBUnXGfbozFfXI3CqLLrS
	gjUzaiLAQYuA/uVYoLBDLi3Z48zcxF3wzuoT98YwCZTkSzEQiR4C3GLxzTIyPjbM5KASRbT0v6u
	1N65/Zg4ojcIvxUTO+/9su5/BlvUdrtULuiZkOitFWAqbQMK3SpsNQGbrrrTXbqzSrzXhvzLc7f
	TdtqKbkXLlLgE0iKI/JlGEOgUN5NTKzQm3Ej51S+T/DuLOl+XVSgJnODqN0vX/BOoNLRsYfJj3r
	DM+yEqOjwp/gIGxV0QyqG/3DLCvvsV8nikRQYD+XfH/8ddptYjGdHSTRjg9JUsMGV+w3KwojeyE
	1GMBX7lVRtx7B
X-Google-Smtp-Source: AGHT+IGJ5Jkgg8cGpDgOqjr54pJZGIZgx+uLuozmAB5iji1PofNCt1obvYaUo/uzYo92PG04DdE6Bg==
X-Received: by 2002:a05:6402:2753:b0:5d3:cff5:634f with SMTP id 4fb4d7f45d1cf-5ebcd4f3255mr14044465a12.24.1742850660772;
        Mon, 24 Mar 2025 14:11:00 -0700 (PDT)
Received: from wiesia.conclusive.pl (host-89.25.128.123.static.3s.pl. [89.25.128.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0e0cb6sm6537097a12.79.2025.03.24.14.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:11:00 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>,
	Artur Rojek <artur@conclusive.pl>
Subject: [RFC PATCH 0/2] Nordic nRF70 series
Date: Mon, 24 Mar 2025 22:10:43 +0100
Message-ID: <20250324211045.3508952-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

this patchset introduces support for Nordic Semiconductor nRF70 series
of wireless companion IC. 

Nordic nRF70 series are FullMAC devices, which communicate over SPI or
QSPI interface. This driver provides support for STA, AP and monitor
modes, in combination with up to 2 VIFs. Throughput of up to ~16 Mbit/s
has been observed while using QSPI.

Patch [1/2] adds the nRF70 driver.

Patch [2/2] provides related Devicetree bindings documentation.

As this is our first Linux WLAN driver, I am tagging this as RFC and
looking for any sort of feedback, before I turn it into a regular
submission.

In the meantime, here are some pending questions that I have:

1) Nordic gave us permission to upstream the firmware blob [1] required
   to use this driver. As that needs to go through separate
   linux-firmware repository and is subject to different licensing,
   should I try to upstream it in parallel with this series, or does it
   need to wait until the kernel driver gets in? 

2) In AP mode, for each connected peer I maintain a pending queue for TX
   skbs that can't be transmitted while the peer is in power save mode.
   I then use a wiphy_work (nrf70_pending_worker) to move the collected
   skbs into a single hw queue once the peer is able to receive again.
   This means there can be multiple workers putting skbs onto the hw
   queue at any given time. As this scheme relies on the wiphy_work
   workqueue, can I assume that multiple workers will be able to run in
   parallel, even on a system with a single CPU? If not, what would be
   a better solution to the above problem?

3) nRF70 hardware communicates using byte packed, little-endian
   payloads (documented in nrf70_cmds.h). As these can get very large
   and complicated, I decided against writing some sort of endianess
   conversion scheme, and simply dropped big endian support by this
   driver. Is that acceptable?

4) Please put particular attention to the wiphy configuration. I am not
   100% confident I got all the flags/features/band caps right.

PS. checkpatch.pl spits out what I believe to be a false positive: 
> ERROR: Macros with complex values should be enclosed in parentheses
> #5914: FILE: drivers/net/wireless/nordic/nrf70_rf_params.h:85:
> +#define NRF70_PHY_PARAMS \
The above define is used for generating the nrf7002_qfn_rf_params array,
and as such cannot be enclosed in parentheses. 

Cheers,
Artur

[1] https://github.com/nrfconnect/sdk-nrfxlib/raw/refs/heads/main/nrf_wifi/bin/ncs/default/nrf70.bin

Artur Rojek (2):
  net: wireless: Add Nordic nRF70 series Wi-Fi driver
  dt-bindings: wireless: Document Nordic nRF70 bindings

 .../bindings/net/wireless/nordic,nrf70.yaml   |   56 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nordic/Kconfig           |   26 +
 drivers/net/wireless/nordic/Makefile          |    3 +
 drivers/net/wireless/nordic/nrf70.c           | 4671 +++++++++++++++++
 drivers/net/wireless/nordic/nrf70_cmds.h      | 1051 ++++
 drivers/net/wireless/nordic/nrf70_rf_params.h |   98 +
 8 files changed, 5907 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
 create mode 100644 drivers/net/wireless/nordic/Kconfig
 create mode 100644 drivers/net/wireless/nordic/Makefile
 create mode 100644 drivers/net/wireless/nordic/nrf70.c
 create mode 100644 drivers/net/wireless/nordic/nrf70_cmds.h
 create mode 100644 drivers/net/wireless/nordic/nrf70_rf_params.h

-- 
2.49.0


