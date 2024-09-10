Return-Path: <linux-wireless+bounces-12761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05F973771
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 14:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8321C23FC3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE11917C4;
	Tue, 10 Sep 2024 12:34:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4718C002;
	Tue, 10 Sep 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971661; cv=none; b=EB6Dw0qk7LuRNZUHtFI+06elnCh+j7rzJC0HXmZ96F9fIx9wBd6TV2C3EAXjqnA2ePErENH/jsrlJOvDluTKTdB77iYZR+HvN3R6DXFyWScyup/JJzr1I4kZXNEm0JrQCcU2xpiWjxQWRT1WUKf2VX8kJpGbNvjhYk7ww3WgCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971661; c=relaxed/simple;
	bh=K85PMxn9HYgYf8DC9w76B88UKSX5Pc3De2uallcJgnU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/0wrEdQotVJQBHeR3Pga0msQWwDzNzjBn9PQV0wahLP3ATz2JVHbYso1mWvkcWP+1q5uqMaefaOsSNkCE00e8WZjaUytUJQ9RATbcD0AVX9IinXD7KdktXKv1woUi+owUOUVCH0p6VcyEUPGQdjOYHBvd0MHiTIVLRj0zPQhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X336W26WKz20nms;
	Tue, 10 Sep 2024 20:34:11 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DE6C140138;
	Tue, 10 Sep 2024 20:34:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Sep
 2024 20:34:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chunkeey@googlemail.com>, <kvalo@kernel.org>, <briannorris@chromium.org>,
	<francesco@dolcini.it>, <krzysztof.kozlowski@linaro.org>,
	<leitao@debian.org>, <linville@tuxdriver.com>, <rajatja@google.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH wireless v2 0/3] wifi: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Tue, 10 Sep 2024 20:43:11 +0800
Message-ID: <20240910124314.698896-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

As commit cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
said, reqeust_irq() and then disable_irq() is unsafe.

And the code below is subobtimal:
	 irq_set_status_flags(irq, IRQ_NOAUTOEN);
	 request_irq(dev, irq...);

IRQF_NO_AUTOEN flag can be used by drivers to request_irq(). It prevents
the automatic enabling of the requested interrupt in the same safe way.
With that the usage can be simplified and corrected.

Only compile-tested.

Changes in v2:
- wireless prefixed subject and submit them in a separate patchset.
- Add fix tag.

Jinjie Ruan (3):
  wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
  wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
  wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()

 drivers/net/wireless/intersil/p54/p54spi.c  | 4 +---
 drivers/net/wireless/marvell/mwifiex/main.c | 4 ++--
 drivers/net/wireless/ti/wl1251/sdio.c       | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.34.1


