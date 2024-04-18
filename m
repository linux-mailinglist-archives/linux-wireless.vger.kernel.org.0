Return-Path: <linux-wireless+bounces-6532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8791E8A9FEA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0812836D7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A526216F84D;
	Thu, 18 Apr 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVnsRrlN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BA1635A6
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457222; cv=none; b=KxqtuP0z0YjNyked3+y9wKC1E4N/VlLxMUIaU7a3VAgnUrYKK80nkRTxbz4o4S/c+3PFxScdg5CD6WgOx077UNNPSS2yi5yhU5Bcov4LU5/VkiOmnUQ17L+u1f8iNMMYNoM1kYUgJ+fwOUvQ4wY0j5xfmOeMdimOLvBNx9StIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457222; c=relaxed/simple;
	bh=L/q/SEyMvrP7DvPROUW2dF6DzmVYdZULYChsgCNQMBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mF1e3AOqiXwrCccbkhKJdHU0jq84nd6owkxDeGJX5ZTdFpPItBGdoRi7VA9eWIe4R/OZHtNANOz8/HRcP9hrX+9lMNctAFaocJYFPVaA+uLOfHjz6TtLb2R78J6wQXkzdsCasUr7EGGhLzGJ0AEIR7Jc5+fmOwwGj0reQZkh7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVnsRrlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE90C113CC;
	Thu, 18 Apr 2024 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713457222;
	bh=L/q/SEyMvrP7DvPROUW2dF6DzmVYdZULYChsgCNQMBg=;
	h=From:To:Cc:Subject:Date:From;
	b=UVnsRrlNsqRHfWDScviRGPsLpVSihu5HcfJgZvVzJC36U9gwdvpmzly5fxNJFt5Og
	 7AoOHE1Kef+6ctGV1LDFmFRV+PU1DD0VjlKaG04gY93k7Fw9gIec7tW+4nZGwbrbTw
	 GK3WjroIDq/Wvz6gJ/FmOEKCOUABzlCGq8eUf3Ie44I65ShWwH4K5tOb2XBmG4EKrD
	 ZGHXphc0+engD3oHNslPG3BNo2pODHYTfoEtakkhJaSp3nTcHsy8EBk6AhLRu4d4Q4
	 +ka4MhLADNkeG11yHosL4hjZOr6uS+rl14sVecp2DcBO0dhGIwQB5lRiocL5lBW5OT
	 04gpeKG6Ob3Gg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v8 0/4] wifi: ath12k: ACPI support
Date: Thu, 18 Apr 2024 19:20:15 +0300
Message-Id: <20240418162019.1246749-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Through reading ACPI tables, implement Time-Average-SAR(TAS), BIOS SAR,
configuration of CCA threshold and band edge channel power functionalities.
This is enabled only on WCN7850.

TODO:

* test with ACPI support in hardware (I don't have such hardware), especially
  suspend and hibernation

v8:

* rebase to ath-202404181528
* rewrite commit messages
* cleanup and improvements all over to match the ath12k style, including
  error handling, naming and so on
* locate new place to call ath12k_acpi_[start|stop]()
* move wmi functions up in wmi.c file
* consolidate WMI functions using WMI_PDEV_SET_BIOS_INTERFACE_CMDID into ath12k_wmi_set_bios_cmd()
* ath12k_acpi_stop(): don't call acpi_remove_notify_handler() if we never installed the handler

v7: https://patchwork.kernel.org/project/linux-wireless/cover/20231013114434.81648-1-quic_lingbok@quicinc.com/

* adjust the length of line
* add cpu_to_le32()

v6:

* remove code that is not called

v5:

* rebase to the latest tag

v4:

* revise commit log using imperative voice
* delete guid_is_null()

v3:

* remove unnecessary cpu_to_le32()
* adjust the order of the macros
* apply jeff's advice

v2:

* put <linux/acpi.h> in the include guard

Lingbo Kong (4):
  wifi: ath12k: ACPI TAS support
  wifi: ath12k: ACPI SAR support
  wifi: ath12k: ACPI CCA threshold support
  wifi: ath12k: ACPI band edge channel power support

 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/acpi.c   | 394 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h   |  76 +++++
 drivers/net/wireless/ath/ath12k/core.c   |   7 +
 drivers/net/wireless/ath/ath12k/core.h   |  18 ++
 drivers/net/wireless/ath/ath12k/hw.c     |  10 +
 drivers/net/wireless/ath/ath12k/hw.h     |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 143 ++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  41 +++
 9 files changed, 693 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h


base-commit: c416602943dd36fbd13af7496430723935c867a3
-- 
2.39.2


