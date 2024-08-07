Return-Path: <linux-wireless+bounces-11097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB81B94AEB0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C2A1C20DA3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764DA13B293;
	Wed,  7 Aug 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDFL/52a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBA13AD3F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050748; cv=none; b=kSiPrnuG30yLgSibtGsW0YiA5vEEwNAuc4Lb8RHNBRqGmhmAQGRCjmStXrwa2g+fWebtyIgIDApFwYTUqXsJzwaehNsuiCJvE5ognSDzrs+F4A0vD7nEgt4XtzdOPnSwTvAqYYGzAS93zLDcWyy+bZytzfBrKMBpdgr/8FOZVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050748; c=relaxed/simple;
	bh=F7VgL2oyZ+TFX8Wsiz1gK9lsMTXOllcbSnFsyhd7zao=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=NtXlspIL0aSylTHS+A9hjIka9xmdlyuAo7TOuMikD3cdO44czKDxCvHM1HIR+nbNFePiyJk0K+rfv5Mb/smHZyXXb5eN5aPXBfmZ7JxMpndFzRylsPzRdyFLt6M6PixeQ8b7DWNL0ouMwa4gH0SDns9SUn+McHsADPOWO5lI4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDFL/52a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AECFC32781;
	Wed,  7 Aug 2024 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723050747;
	bh=F7VgL2oyZ+TFX8Wsiz1gK9lsMTXOllcbSnFsyhd7zao=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=QDFL/52aCU1pAcQu+TMZvsjarVu82Pz/vfk8EBMsgWhmkCqnU6pCxfJnXQOVgRKhX
	 28BgxUfN1X7O2J5dDjFkiIPu3VLWNyzAo3IA9qen4B92plgCCXCAQKgUphiz7weuIB
	 +lduZuvKTC/0E95lTypKpTNYYhr7a7Xmu2aBIi9dMj4f8FVlpwnJyQuYpBVItOCTG/
	 cO4I6qAjYaEZCBN+PdWmjwhikgejZ6kvbFgMBrjqDN1eU+oMcerIREnx8imJusiqe1
	 npyjoBmDFAucqnhWFqGg6eC+Q3KaxZjhN5jg3A8xTOM8Yi90KonyFOBBNIQPOlnKqa
	 eJ5oQCLCzweAw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192du: Initialise value32 in
 _rtl92du_init_queue_reserved_page
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <2a808244-93d0-492c-b304-ae1974df5df9@gmail.com>
References: <2a808244-93d0-492c-b304-ae1974df5df9@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172305074552.3967444.6995608528419900911.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 17:12:26 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> GCC complains:
> 
>    In file included from include/linux/ieee80211.h:21,
>                     from include/net/mac80211.h:20,
>                     from drivers/net/wireless/realtek/rtlwifi/rtl8192du/../wifi.h:14,
>                     from drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:4:
>    In function 'u32p_replace_bits',
>        inlined from '_rtl92du_init_queue_reserved_page.isra' at drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:225:2:
> >> include/linux/bitfield.h:189:18: warning: 'value32' is used uninitialized [-Wuninitialized]
> 
> Part of the variable is indeed left uninitialised.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408062100.DWhN0CYH-lkp@intel.com/
> Fixes: e769c67105d3 ("wifi: rtlwifi: Add rtl8192du/hw.{c,h}")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

f1cb9d5aefba wifi: rtlwifi: rtl8192du: Initialise value32 in _rtl92du_init_queue_reserved_page

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/2a808244-93d0-492c-b304-ae1974df5df9@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


