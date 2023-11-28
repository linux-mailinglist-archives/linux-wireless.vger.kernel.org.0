Return-Path: <linux-wireless+bounces-161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690007FB623
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B8628260D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B94D29A;
	Tue, 28 Nov 2023 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtpQb0UL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B3DE;
	Tue, 28 Nov 2023 01:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701164626; x=1732700626;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FZXwYPux8v3qXqso189iJLVxfKNYIPXcudfEW5b3mrY=;
  b=YtpQb0ULzt4eREZLsGlPRWJUPdJYF44/bLUtVXFSG0td6yLT4CpQQCRr
   uQb/AwlVMITcw0kvN6XV8+cfxRxPmGqiWQOQV1Rbv23u3rRkPmeVDz79k
   ZtbGR9YVgMkwf8KOv8IgmZD6C2YogwbGF7jixdjyhf0w6KzZfA6PYn6GX
   dykgAqfwi7P9PdOGyiUjPdbo8AwzVJwU+VZaXo16SHXurMDeLSwDq4Hhn
   tURUJ75N80LODH10ROmkgzv5tkpTYrj6dqqRutmRPEpzcSn+9P2jqlNHL
   48MadI8kYSJZI6FznHzQSvwmygfPanAnH9/+7CmgTRh3C9AegfGBj/uls
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="392636957"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="392636957"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:43:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="839010677"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="839010677"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:43:44 -0800
Date: Tue, 28 Nov 2023 11:43:39 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Kalle Valo <kvalo@kernel.org>
cc: =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>, 
    linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] bcma: Use PCI_HEADER_TYPE_MASK instead of literal
In-Reply-To: <87a5qz7itw.fsf@kernel.org>
Message-ID: <8ed249a4-89d3-2f31-6ce1-d38131d632f0@linux.intel.com>
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com> <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com> <87a5qz7itw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-922961056-1701164625=:1797"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-922961056-1701164625=:1797
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 27 Nov 2023, Kalle Valo wrote:

> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:
> 
> > Replace literal 0x7f with PCI_HEADER_TYPE_MASK.
> >
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I couldn't find the cover letter. Should I take this patch to
> wireless-next or do you have other plans for this?

Just take it through the normal trees, so in this case wireless-next. 
Thank you.

-- 
 i.

--8323329-922961056-1701164625=:1797--

