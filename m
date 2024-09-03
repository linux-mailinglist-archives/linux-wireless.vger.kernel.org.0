Return-Path: <linux-wireless+bounces-12384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D4969AFC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48721C2365E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16531B12D0;
	Tue,  3 Sep 2024 10:53:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD901B12C5
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360816; cv=none; b=ryllQHgPMo8JTw5RnWRxOrZUu2M/H4PQ4cTDvTVzVBE+5G31VcPOxkL8qZrB+QLJa/mDsZxt7U/I1JrH7it8M1itOxiwEGOHHNQCY7uuzMsHgjPu4p32k9UcGDWX9yDeguI5eepQePI/DnxGNP10NnTEcPCQ+Q2CDX26HhYZKyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360816; c=relaxed/simple;
	bh=4dBUev4Zn36bnH1+LjpIgPLws1TWN0/Mu9Xq2Dp3C6Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i+6LaY80hHE5qI8J+MBSpP7x3/MJ6XYGM025qPEKIPEtLMQTq9DZTu7rm6HyckGBhYQfFuS408glEIdbsUPxPpCUglpdYhESaqjttUjXk1dV19Nz05wFv8l8oimlKIGJmRbkHgPxDgx2dgTKy0Jr9ASeaGOw1Y1OgvcwknwznaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wyj7f0CRXz1HJ2v;
	Tue,  3 Sep 2024 18:50:06 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 65EE31A016C;
	Tue,  3 Sep 2024 18:53:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Sep
 2024 18:53:31 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<kvalo@kernel.org>
CC: <lizetao1@huawei.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH wireless-next 0/2] wifi: Convert using devm_clk_get_optional_enabled()
Date: Tue, 3 Sep 2024 19:02:03 +0800
Message-ID: <20240903110205.4127706-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

There are many examples[1][2] of clk resource leakage in LTS. The
reason is that developers need to maintain the allocation and release
of clk resources themselves, but this will increase the burden on
developers. Using the API related to devm_clk_get_*_enable ensures
that the life cycle of clk is consistent with that of the device,
reducing the risk of unreleased resources like clk.

[1]: https://lore.kernel.org/all/20240812160128.338041191@linuxfoundation.org/
[2]: https://lore.kernel.org/all/20240812160135.992451065@linuxfoundation.org/

Li Zetao (2):
  wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in
    wilc_sdio_probe()
  wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in
    wilc_bus_probe()

 drivers/net/wireless/microchip/wilc1000/sdio.c | 10 +++-------
 drivers/net/wireless/microchip/wilc1000/spi.c  |  5 +----
 2 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.34.1


