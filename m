Return-Path: <linux-wireless+bounces-13962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF899E86D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE39D1F22AE8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7BD1EC00E;
	Tue, 15 Oct 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEnPS1QB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6211D4154
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993943; cv=none; b=NPjgimbj+5hlJlGh81jYQw7MkR//7Y2uaVaiIJdjh9HqIRB0HFpLjwQHORS7k3gX9ooNl+iXJ9xJSW/cJtyQ2pY0Lfpraq0Lm3/edKRzxIj9yt72UTEbiSc+IjoLXJEMzP2gvLvkLW2jG5d52kqcqRqXLnVfg88RvexxbyyK8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993943; c=relaxed/simple;
	bh=UJKVhbeRIiOGF1J+mTwVp9aDBm90PBLdKOcf+W03cOk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AT895I6+ksGy9CK2VlpSnBO9Pu/Xw5PfixtwfCA/L1JObKNiv6eeTguEdrwS/n7Pp1PQxWbyN839pSSJel3lHqRr9EBq0k2XkxUVqnXNsN9/7VmJuPhoVuAbToUK+HNS+aw3Mv/W5mRHzZyDrdP5ulBLro+ER63hzS255IqXssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEnPS1QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B708C4CED0;
	Tue, 15 Oct 2024 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728993942;
	bh=UJKVhbeRIiOGF1J+mTwVp9aDBm90PBLdKOcf+W03cOk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kEnPS1QBblLRhq+g+Q5kBeYY4g9DpLs5zf+M6qp4t2G/K2lAZizIP21xGH8PZstFK
	 Lno2HjOFpNXV0iEAqCl4mFOUbEbeCNzPTcXPm1L1sGi9JF5n5Fx+hTGQdwTeEOiMrN
	 cYLxqNnCH6U4xVFMzJFgpkyVY2EFMqNtgWF/rYPfVpsI94Gkv9+TIuEOG6TN8gDgK+
	 gYLvbdhqYICM+HGBktwU19gskxo+DjndEcnEBkuwoXYloxOto8cKdWR/2wTK8Ixf1T
	 UNSsoIkmpbioPl6yV6/LD2WwN9o2iTe/0mnHTWSgF/+g3AfueDiip1v5XiunsINomx
	 3Czhb+WYpICFg==
From: Kalle Valo <kvalo@kernel.org>
To: Allan Wang <allan.wang@mediatek.com>
Cc: <nbd@nbd.name>,  <lorenzo@kernel.org>,  <deren.wu@mediatek.com>,
  <mingyen.hsieh@mediatek.com>,  <Sean.Wang@mediatek.com>,
  <Soul.Huang@mediatek.com>,  <Leon.Yen@mediatek.com>,
  <Michael.Lo@mediatek.com>,  <Eric-SY.Chang@mediatek.com>,
  <km.lin@mediatek.com>,  <robin.chiu@mediatek.com>,
  <ch.yeh@mediatek.com>,  <posh.sun@mediatek.com>,
  <Quan.Zhou@mediatek.com>,  <Ryder.Lee@mediatek.com>,
  <Shayne.Chen@mediatek.com>,  <linux-wireless@vger.kernel.org>,
  <linux-mediatek@lists.infradead.org>,  Hao Zhang <hao.zhang@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: introduce mt792x_config_mac_addr_list routine
References: <20241007071349.4626-1-allan.wang@mediatek.com>
Date: Tue, 15 Oct 2024 15:05:37 +0300
In-Reply-To: <20241007071349.4626-1-allan.wang@mediatek.com> (Allan Wang's
	message of "Mon, 7 Oct 2024 15:13:50 +0800")
Message-ID: <875xpt606m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Allan Wang <allan.wang@mediatek.com> writes:

> From: "allan.wang" <allan.wang@mediatek.com>

In the SMTP header your name is in correct format but not here. A
problem with your git configuration?

> Add mt792x_config_mac_addr_list routine in order to set
> the mac address list supported by the driver. Initialize
> wiphy->addresses/n_addresses for mt792x driver
>
> Change-Id: Iab64d938449380d88bf839ddf5e0f136728a391b

No Change-Id tags, please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

