Return-Path: <linux-wireless+bounces-3616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9BE856101
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A21C22547
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E0D12BE9F;
	Thu, 15 Feb 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDS8xUCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0812BE96
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995366; cv=none; b=ipRdNdkrd4nYg3olKh0LDDRPQ9li0uetdtpiFJNSC6gcq+SVgWe0cQTCn+YYS+0f6kWnwXwPx2//+CZE07Xo9zHk2nxDWikUdROFJxUZ481AmcFL6xrw8/8s1dgUdIxREBOu6in9el+IxcIxcBBPWJE8zReHhrlliwErnjmuCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995366; c=relaxed/simple;
	bh=mrbyT+ZJGucWlYyTSOMKu3Any2Zl95VPi65+m2R6PPU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=InuDJk8x0IF8wyCq/P5u4kFRWjHFTnOKQoNiwrrh+9WPtDbw5nALg4Ldo3O4N/q5atMc/vPEtgrbOysSJWF44XE7TC18Xt0FbW1ZdKPx2WBqlGaOilNJe6c6rtHg8H/GtxGBoklRPqdmCb5T3tCF+p81pkgRSk3MCrnwg2pHVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDS8xUCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F1C433F1;
	Thu, 15 Feb 2024 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707995365;
	bh=mrbyT+ZJGucWlYyTSOMKu3Any2Zl95VPi65+m2R6PPU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BDS8xUCTi4Vxa1Aj+pbeusbRmrOaGQ0S4gajqlxJEsh3zauSJTARuLRouC6lXyIV+
	 JMiT0tgXBESA3jufFWs+Op+ayCUCcI3L38cWyrEZLBTQSTIIOfQ2HodHP21Tr8RGcb
	 qObZ5afNDyCnkv0YB97fKsqnB0pRLePMkgGd90w2C1dmn4BaDTco7lIDLH22GHU0oC
	 IBlTPmgXq6X+WISP2bk9X6gfBf3MA8XgWLbDNRgLzIGwEz73G6/P9ODZcBfSVbuVE6
	 VnTAZT8t7wNnl+33AkQ4HlEs+sUyQoEfmfdMKToRXQqVgiZcxKw1YJWqVBvYwi0+Bm
	 BXpGuLnwl7WlA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240212202057.3468714-1-davidm@egauge.net>
References: <20240212202057.3468714-1-davidm@egauge.net>
To: David Mosberger-Tang <davidm@egauge.net>
Cc: linux-wireless@vger.kernel.org, Ajay.Kathat@microchip.com,
 alexis.lothore@bootlin.com, David Mosberger-Tang <davidm@egauge.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799536268.3764215.8647449120013652102.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:09:24 +0000 (UTC)

David Mosberger-Tang <davidm@egauge.net> wrote:

> Previously, the driver created a net device (typically wlan0) as soon
> as the module was loaded.  This commit changes the driver to follow
> normal Linux convention of creating the net device only when bus
> probing detects a supported chip.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> Tested-By: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

dd2f633eafa4 wifi: wilc1000: validate chip id during bus probe

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240212202057.3468714-1-davidm@egauge.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


