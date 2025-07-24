Return-Path: <linux-wireless+bounces-25989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC9B1074A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A1D5868D5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F0242D6C;
	Thu, 24 Jul 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="k+XEtvH4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F678F51
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351395; cv=none; b=Cka4P09yPqi6Fj6YCBzoLMurlxiE60aQZZJHpVcht2kCjwiManP2FFuvO7i2fiA3K7h54etb4uHSwxHDSls8rUmAsjnDDoQXiuKNqUiyZGFw53mI72vnFP7tG0ZeblfSQj4b+n4wkgbYmj+kx6qiVxKO+8giDevxM3zP83pGUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351395; c=relaxed/simple;
	bh=ptT1zoAqPii7EeHZ39Zr6sDYfhlB7eKzhp7y7BMyhAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyyasqZ+0ZNP4ImN9NiuoK4kjwpFmpOJ2wFWyG0IFn9q+zLbSXllwtlvlYjGlwm2l+yD9OlKkhSj+w5DuixnENYf5SJqpiZuwRja6LGEYfyx3fVjlvI1m1X0jV2Y378FwNrVbqhaT+vCGiIejmqnqD7dIxH3dJz7KuJclsH1MLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=k+XEtvH4; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1753351394; x=1784887394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptT1zoAqPii7EeHZ39Zr6sDYfhlB7eKzhp7y7BMyhAI=;
  b=k+XEtvH4ZJDXuEH6+8lVEezjL6x1MYDd3g5SGDTE5pL8H81DPUeiFTHo
   nxAIzUx/ic/7P9knvFsT6+QXKw9mf+G1XQDYWPq12DLhjP0nn6v8i6tPT
   5oFreE8HrvMvGxZyMuMyk7iaqhB8RRHI+rVgK1Z+DLI75dzvZ75YLMfOK
   k=;
X-CSE-ConnectionGUID: N6Jbso52Tx6n7Nt36byzCA==
X-CSE-MsgGUID: o5n959voQC6dVuYrZf/21A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58680006"
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="58680006"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 12:02:03 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 12:02:03 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Jul 2025 12:02:01 +0200
Date: Thu, 24 Jul 2025 15:31:54 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH wireless-next v2] wifi: brcmfmac: remove 43752 SDIO
 incorrectly labelled as Cypress chip
Message-ID: <aIIEko_R94DVBDGY@ISCN5CG14747PP.infineon.com>
References: <20250724084613.6336-1-gokulkumar.sivakumar@infineon.com>
 <432d50a2995dee6c421aad6bd21acceec191990e.camel@sipsolutions.net>
 <084b0c7e-1ef4-4522-b671-d9dab84537dd@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <084b0c7e-1ef4-4522-b671-d9dab84537dd@broadcom.com>
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

On 07/24, Arend van Spriel wrote:
> On 7/24/2025 11:15 AM, Johannes Berg wrote:
> > On Thu, 2025-07-24 at 14:16 +0530, Gokul Sivakumar wrote:
> > > Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
> > > has not officially released any firmware binary for it. It is incorrect to
> > > maintain this WLAN chip with firmware vendor ID as "CYW". So relabel the
> > > chip as "WCC" as suggested by the maintainer.
> > > 
> > > Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> > > Fixes: f74f1ec22dc2 ("wifi: brcmfmac: add support for Cypress firmware api")
> > > Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> > > ---
> > > 
> > > v2:
> > >   * Relabelled the 43752-SDIO chip from CYW to WCC instead of dropping the
> > >     support for this chip as suggested by Arend.
> > > 
> > 
> > Maybe update the subject now?
> 
> That would be nice. Please not that the vendor ID is more about the
> firmware API that should be used for the device and not so much about
> maintainers.
> 

Will send the patch again after rephrasing the subject to indicate that the
incorrect firmware Vendor ID (FWVID) is fixed by this patch.

Gokul

