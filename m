Return-Path: <linux-wireless+bounces-38970-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UF8sMJbRVGoEfQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38970-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 13:52:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A434374A8C9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 13:52:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infineon.com header.s=IFXMAIL header.b=p+gFikwC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38970-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38970-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=infineon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3F03009B1D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F73F44F4;
	Mon, 13 Jul 2026 11:52:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507433F4116;
	Mon, 13 Jul 2026 11:52:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943569; cv=none; b=ZSpKa7IJ8nFfR970ocIaoLbx3/UMrPXNmiQnyWv1/3tqpg9NeqzjmrF5NXdsC5/igWJx8IO1KGMuzzjSPjWhR6ht+iXAzZli1R5oYJ0TiJX2Opp69pKvDSwBK5gdEXlrDgBQjRSjyBbkEkYcG/fbpLl+3jYMKx7sSCVQ1hjyrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943569; c=relaxed/simple;
	bh=pcKVlxyOm15Z2BIGF1THFUV3ru6W5lx2ct0St2rETNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m63zwfrK6PVYqF7PxqtICvTOyC3DrZ9C8C/BQ2W7KMArHvQVKxgeFxQ7X7XbmcruOOzQx2e+W992SQzzg679o9+BrtZkSoP8z8gIazgHsQNKdKW4GXmG+D6g+zx8wtFyCIPL2m17tdJMf0EPKi/Le9JOwmxbs15h0+NnS9A3iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=p+gFikwC; arc=none smtp.client-ip=217.10.52.204
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1783943566; x=1815479566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pcKVlxyOm15Z2BIGF1THFUV3ru6W5lx2ct0St2rETNY=;
  b=p+gFikwCHdC5SbeXn9SqanMiTy2CqX/WJ9V/VW6WmGQds6gc/uykvZa2
   gapPPjOVrEa7TnIRp0EGc0aucBqTKtsvUe7XO/8nMbUGReJ2mLzRfDayb
   NqqLwZjZ6hm8EM/L9LS+O/ZXRCyOBEG8v0xCwjrQsKxJba/yiPphwolJJ
   U=;
X-CSE-ConnectionGUID: EOPx2jo/RvWnT4rZz/snDA==
X-CSE-MsgGUID: eQFU/od+TPaXooHwjBARSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="100701446"
X-IronPort-AV: E=Sophos;i="6.25,154,1779141600"; 
   d="scan'208";a="100701446"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:51:28 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 13 Jul
 2026 13:51:27 +0200
Received: from ISCN5CG54722ST.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 13:51:25 +0200
Date: Mon, 13 Jul 2026 11:51:18 +0000
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: LiangCheng Wang <zaq14760@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	"Angus Ainslie" <angus@akkea.ca>, Wig Cheng <onlywig@gmail.com>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Message-ID: <uhwfd77gkvcrs22h5h42x5ujclzrq7ru5wkixguywfej3444w2@ejmn5s2kmapd>
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
 <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE827.infineon.com (172.23.29.20)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38970-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,akkea.ca,vger.kernel.org,lists.linux.dev,broadcom.com,infineon.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gokulkumar.sivakumar@infineon.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:zaq14760@gmail.com,m:kvalo@kernel.org,m:angus@akkea.ca,m:onlywig@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:wlan-kernel-dev-list@infineon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infineon.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gokulkumar.sivakumar@infineon.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,infineon.com:from_mime,infineon.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A434374A8C9

On 07/13, Arend van Spriel wrote:
> On 13/07/2026 10:50, LiangCheng Wang wrote:
> > The BCM43752 is not reliable with the default 512-byte SDIO function 2
> > block size: on an i.MX8MP board with an AMPAK AP6275S module at
> > SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:
> > 
> >    mmc_submit_one: CMD53 sg block write failed -84
> >    brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> > 
> > Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> > set up the 43752 like the 4373 for the F2 watermark but missed the F2
> > block size, which the 4373 limits to 256 bytes. The vendor driver
> > (bcmdhd) also programs a 256-byte F2 block size for this chip and runs
> > the same hardware without errors.
> > 
> > Group the 43752 with the 4373, matching the F2 watermark handling.
> > With this change a 10-minute bidirectional iperf3 soak completes with
> > zero SDIO errors at ~270 Mbit/s in each direction.
> > 
> > Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> > Cc: stable@vger.kernel.org # <= 6.16 needs the CYPRESS_43752 id name
> 
> Looks good to me but the stable instruction looks confusion. What do you
> mean. If there is no 43752 support there is no need for this patch, right?

Arend, one year back, from Infineon we had submitted a patch [1] to correct
the vendor ownership of 43752. i.e, SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373 got
replaced with SDIO_DEVICE_ID_BROADCOM_43752. 

So in the older kernel versions like v6.16.x which does not have patch [1],
the 43752 support exists, but with SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752.
So his instruction is to, again replace SDIO_DEVICE_ID_BROADCOM_4373 with
SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 in his patch [2] while cherry-picking
to the older stable trees.

Rather than that, I would suggest to cherry-pick both the patches [1] & [2]
to stable trees, since the new patch [2] is dependent on existing patch [1].

[1] https://lore.kernel.org/linux-wireless/20250724101136.6691-1-gokulkumar.sivakumar@infineon.com/
[2] https://lore.kernel.org/linux-wireless/20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com/

Gokul

> > Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> > ---
> 

