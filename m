Return-Path: <linux-wireless+bounces-3683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D448581AE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 16:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A631F21D5F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7F212F395;
	Fri, 16 Feb 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+ak1HYb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0412F373
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098501; cv=none; b=NbGWYFYhfotEZna6pvVVugcTZi1Mh/+xhibSpaXumzY5uZZyTXx66Vryq0AHOiN1H/J+i4VwlRshxTVaiAEvS3IVClUp+oDaiOWovvDL7DrRjURPI2Lf4v4x9JZYi6UJg1uQvjodFBa9JsuAczH1KfmK7N3cKrsbXKGIVA3y7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098501; c=relaxed/simple;
	bh=5UBfHLNZbAkY2bhnUTtNXgqZI+KqQD4ETcUNh2WvWNQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bPvvgpBD52M+Ipl7Wqw2ydBDKch0ca31q7NEjUjgHY9BxyCModKDNOl2GAq4OBNpMWnL7Z1UscxNlZYgoW1+3RDuC1P0qfRKogb5PEY7d5cJynJj80t0mn0X2+mxL6GE+3LHLlKOk+J7DSDp/MjRI8316xhhUwxe+bFBLEDl+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+ak1HYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDB9C433C7;
	Fri, 16 Feb 2024 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708098500;
	bh=5UBfHLNZbAkY2bhnUTtNXgqZI+KqQD4ETcUNh2WvWNQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=D+ak1HYbG/Z6ndyQhtAvtbPfZyvN3gAoply2nCBseKpfUVBnJon31UyJlNzuHkEJq
	 +LaHqmc+oYvHCGd0ZbeMhQAo14H28iVO6qeqRijoNrySyy80BAgbvAE4jmrFv5JT3K
	 wOWp2l8Diqtgk+2kZ6rVFozuiT2573mjyaFdCdQ4TA9IVEfS1njZG0Lf1K+IGGEbBd
	 5BOIfb5i9OWxWSsiOsnhVhRya3LH21YuxQ9htl2CJFwXDkWHfp5fxaXEnbV4mT0NIf
	 xqPZJHLd1MQFsmOKJSkiuy9Ogu3KN78RR5w7HCv24HbDy2vvaP1MhBYU8pFmCRismy
	 /09RRPFA4R4/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wilc1000: fix sparse incorrect type in assignment
 warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230830042300.87184-1-ajay.kathat@microchip.com>
References: <20230830042300.87184-1-ajay.kathat@microchip.com>
To: <Ajay.Kathat@microchip.com>
Cc: <linux-wireless@vger.kernel.org>, <claudiu.beznea@microchip.com>,
 <Ajay.Kathat@microchip.com>, <lkp@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170809849714.4095987.15396075980743029393.kvalo@kernel.org>
Date: Fri, 16 Feb 2024 15:48:19 +0000 (UTC)

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Remove unnecessary byte order conversion for 'key_mgmt_suite' since
> wpa_supplicant allows any byte order for AKM suite value. The change
> also helps avoid the below warning:
> 
> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int key_mgmt_suite @@     got restricted __be32 [usertype] @@
> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     expected unsigned int key_mgmt_suite
> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     got restricted __be32 [usertype]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308290615.lUTIgqUl-lkp@intel.com/
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

New version available:

https://patchwork.kernel.org/project/linux-wireless/patch/20240215-nl80211_fix_akm_suites_endianness-v1-2-57e902632f9d@bootlin.com/

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230830042300.87184-1-ajay.kathat@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


