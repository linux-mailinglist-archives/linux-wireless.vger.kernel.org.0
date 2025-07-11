Return-Path: <linux-wireless+bounces-25273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F9B01E85
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41371CC07AC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E672882AA;
	Fri, 11 Jul 2025 14:01:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DD3C0C;
	Fri, 11 Jul 2025 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242510; cv=none; b=Lw5sZ+0vaD1ETposNNu5GIVqFzwctKY3+SHsrp7K0wiEIc2RUK+tPWo+gR1TabqUNejxqmLYHDWLb9n7JAOW0vfgo+ulhR0uegAdl6ZpU7tPuAIOfGuI+u77YtuQZaYpjvcXsw2WZDBfmz65ScecJtavgsl7w9N2HlBwsKipRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242510; c=relaxed/simple;
	bh=Uz1eXuBKNQnp+xOcTOUkqNk4+RTyfPHyVHy+l6nWgJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iugUJcXNlS3F1Fdv49vbMCT3nIHnETomIpgS+xAL0XKy/bOufpyeNU+CC/eiCdxuaftqExANH3bWrbn7f7h3K7QdrM8Vej1wRu9pojvIAIdta6nVwSWx93lsAJ+s9ohSiL474UQ6YlHYFeFzHEGkjwbciNaCo8U+UcD5SkYoPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: u+J0B6+/T5uGFOGm+7BUCQ==
X-CSE-MsgGUID: fr8Dn2H2TS+aGBD12MXJ3g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Jul 2025 23:01:40 +0900
Received: from DESKTOP-I3G733R.localdomain (unknown [10.14.100.10])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A31B7424DFE3;
	Fri, 11 Jul 2025 23:01:32 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: rosenp@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	johannes@sipsolutions.net,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	stf_xl@wp.pl,
	tsbogend@alpha.franken.de
Subject: Re: [PATCHv3 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Date: Fri, 11 Jul 2025 17:01:30 +0300
Message-Id: <20250711140130.378067-1-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710200820.262295-6-rosenp@gmail.com>
References: <20250710200820.262295-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rosen,

looks like here are memory leaks in the patch, PSB.

> +	eeprom = devm_kzalloc(&pdev->dev, ops->eeprom_size, GFP_KERNEL);
> +	if (!eeprom)
> +		return -ENOMEM;
> +
> +	rf = devm_kzalloc(&pdev->dev, ops->rf_size, GFP_KERNEL);
> +	if (!rf)
Here driver must freed eeprom memory resource.
> +		return -ENOMEM;
> +
> +	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
> +	if (!hw)
Here driver must freed rf and eeprom resources.
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate hardware");
> +
> +	platform_set_drvdata(pdev, hw);
> +
> +	rt2x00dev = hw->priv;
> +	rt2x00dev->dev = &pdev->dev;
> +	rt2x00dev->ops = ops;
> +	rt2x00dev->hw = hw;
> +	rt2x00dev->irq = irq;
> +	rt2x00dev->clk = clk;
> +	rt2x00dev->eeprom = eeprom;
> +	rt2x00dev->rf = rf;
> +	rt2x00dev->name = pdev->dev.driver->name;
> +	rt2x00dev->csr.base = mem;
> +
> +	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
> +
> +	retval = rt2x00lib_probe_dev(rt2x00dev);
> +	if (retval)
> +		goto exit_free_device;
> +
> +	return 0;
> +
> +exit_free_device:
> +	ieee80211_free_hw(hw);
> +
Here driver must freed rf and eeprom resources.
> +	return retval;
> +}

Also need to check the rest of allocated resources: mem, irq, clk.

BR,
Alexander

