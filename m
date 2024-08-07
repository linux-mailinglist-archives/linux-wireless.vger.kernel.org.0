Return-Path: <linux-wireless+bounces-11082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41594A782
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 14:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0591C2084C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FE11E4EF5;
	Wed,  7 Aug 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6RAR6/Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D11E213B;
	Wed,  7 Aug 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032542; cv=none; b=j/vKX5MSknVFmkiJk3kvvT+OF/Cv5t2fVytGsNQzGK/P/pboHhyQrpItn6hMVJE7YjdGjCBU14u8MiXZUhbmckdxeBXEHemVt4W+JpsRlDn8SXP3Sy9hXtRf+aNOYwr2qx9veSg68rzY+QXVVfSiFRNbQi9gSF+ensWPs9xZclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032542; c=relaxed/simple;
	bh=artTwD2nsy2eklPPMWNHy14zX1ZDoUqCGhD8PD+B6nU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AoQp25qbDnbfbRa1QKq1Fvw+rE3OJIZtyk3D954bweS/kexXiNA89EsK4dygQhtAJEUc9+t/42wo/3Wh+O/jwTPxblDtDAt1+EDAeJPQS2WScCWtJ1hUqgu/PdpOu4tRzmWQlE/BTRqiRrj6tA8aBev636MCxRstvXrRGTw6GSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6RAR6/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2D9C32782;
	Wed,  7 Aug 2024 12:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723032541;
	bh=artTwD2nsy2eklPPMWNHy14zX1ZDoUqCGhD8PD+B6nU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=s6RAR6/Y9y2lhzyd+QZjcJpW//3W19Fn9TOCsKF0LdEsYNz/z2arMDMKXJAbrR0Uj
	 4SzdJSBO7+PqyHAhaJtigZCUuJpfA4ukutmKRjlT9CUqv4GHuYgE9Hy8y+HLgpypHA
	 YinAC0kDClsQLUj0CUFC0bY+7ngDmL38SOJWI30hHdmKMEfCqZMW3eO2IGeRYNfXk/
	 opaaDOB+kCRvud4KkVdVxTM2yQBliS1Nn0yvOgHTxartctEIZOCfvGybX8oY2VNhQM
	 xV7eqhakL0v1Sb+bIDOVB65BqvscNSckGUHIuhkfjVlvTad6YeDL/Ey3z+WJBWH8yv
	 ziqNsLRA3vE/g==
From: Kalle Valo <kvalo@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: David Ruth <druth@chromium.org>,  nbd@nbd.name,  lorenzo@kernel.org,
  oe-kbuild-all@lists.linux.dev,  linux-wireless@vger.kernel.org,
  timvp@chromium.org,  sean.wang@mediatek.com,  ryder.lee@mediatek.com,
  shayne.chen@mediatek.com
Subject: Re: [PATCH] wifi: mt76: mt7921: Cancel scan work on unregister.
References: <20240806222113.2689446-1-druth@chromium.org>
	<202408071730.Ux9Cr643-lkp@intel.com>
Date: Wed, 07 Aug 2024 15:08:58 +0300
In-Reply-To: <202408071730.Ux9Cr643-lkp@intel.com> (kernel test robot's
	message of "Wed, 7 Aug 2024 18:31:09 +0800")
Message-ID: <87plqkilgl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> Hi David,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.11-rc2 next-20240807]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

I suspect this should be tested on top of Felix's tree:

MEDIATEK MT76 WIRELESS LAN DRIVER
M:	Felix Fietkau <nbd@nbd.name>
M:	Lorenzo Bianconi <lorenzo@kernel.org>
M:	Ryder Lee <ryder.lee@mediatek.com>
R:	Shayne Chen <shayne.chen@mediatek.com>
R:	Sean Wang <sean.wang@mediatek.com>
L:	linux-wireless@vger.kernel.org
S:	Maintained
T:	git https://github.com/nbd168/wireless
F:	Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
F:	drivers/net/wireless/mediatek/mt76/

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

Yeah, using --base is very much recommended.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

