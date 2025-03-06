Return-Path: <linux-wireless+bounces-19868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647EAA547F7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70D916EC7C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF32080D4;
	Thu,  6 Mar 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Rvc93h64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1A201034;
	Thu,  6 Mar 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257481; cv=none; b=A6YUJ9PlhS7/4i8A8ZEYLF0qCaD6R18Aoe1Bm6nUF3TaW8i1CNatkFuA3OXgffbMwT7tBiIHh1ivoaPKEat6m7/7lob8/L4/enjBjZUywBO0zkQZmNd9x1L9bkRcKw44RYO4YnkLmUTUfd7ZznPiyQw5Nq1OLbhwpDQJVNspawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257481; c=relaxed/simple;
	bh=NA/C/lQQJ7iC/V1D5CSud13PQVeHlXko0a0LHmZiKSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNWhMKhPsM7e/rhm0nLhiZwxp9UtDNfU0PJ6UbyyRmBk/bPm2cVvPo9Oz+y4YMgzbbeers7FUqaIJWwUjr5ONtoloRlhcEUxV8pcrTi6C1+R/7JasNp5Nb1utE7/twsfbL+3YZaE6qVcyN+V1xd6MltJHlALBLI7itn/EVOCnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Rvc93h64; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 379E61F96B;
	Thu,  6 Mar 2025 11:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741257476;
	bh=huaQNZUNLgBibcGAgOaoxe/NMXk/qcXn/Hj7HWtKGS8=; h=From:To:Subject;
	b=Rvc93h64us6VwiXxhDBjO1m+aq7C+7yP5RrdvrIZcavhVkM0KgHGEDnGcbcLpuU6N
	 VzMjGqsQSHBW4FXQOUHEoHxgdQ32XgJajInJ8lW489Nj5hZNmOHFX/0EC/S7JT8L3F
	 g8GI706KyFHEwIz3Csz6kfcO4S0E2uZ28kZV5dD3gKbRNqgidIjfskocn4GtbtISEg
	 +n/KJTE2VPjnID+Pf3R0u9tbtfpohoFTUnLJ7ciTFs4n+8Ih0024zcdst+uJ6qy7wp
	 SUsCkEFxXEiQvRBcTI3qPgKh+EBcloVQGthU0dA1Q/wQFg9RDfOQ0HBp2r+0YnyuVx
	 mlvNP4qKSucVQ==
Date: Thu, 6 Mar 2025 11:37:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: Fix HT40 bandwidth issue.
Message-ID: <20250306103754.GB19853@francesco-nb>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
 <20250205012843.758714-2-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205012843.758714-2-jeff.chen_1@nxp.com>

Hello Jeff,

On Wed, Feb 05, 2025 at 09:28:43AM +0800, Jeff Chen wrote:
> This patch addresses an issue where, despite the AP supporting 40MHz
> bandwidth, the connection was limited to 20MHz. Without this fix,
> even if the access point supports 40MHz, the bandwidth after
> connection remains at 20MHz. This issue is not a regression.

As you know this patch came after us (Toradex) reported some issue
connecting to 2.4GHz network using IW416.

However according to this commit message this actual fix is not related
to the issue in which it was not possible to connect at all, but it's
just an improvement. Can you confirm this?

Can you please also answer the last comment I had in the previous version of
this patch, see https://lore.kernel.org/all/Z44vj59nWIiswq7s@gaggiata.pivistrello.it/
?

Reported here again for you convenience:

  setting `radio_type |= (CHAN_BW_40MHZ << 2)` seems the only real change on this
  patch, correct? Anything else is cosmetic, correct?
  
  would doing just this change be equivalent, right?
  
  	SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
  			  radio_type | (CHAN_BW_40MHZ << 2),
  			  (bss_desc->bcn_ht_oper->ht_param &
  			  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));


Thanks,
Francesco


