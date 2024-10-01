Return-Path: <linux-wireless+bounces-13380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B42798BE25
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C881F2217B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0C1C3F3E;
	Tue,  1 Oct 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6Kb64Xf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B51A3BAD;
	Tue,  1 Oct 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790078; cv=none; b=pTBj0BcM6fHTw7gKjfz4FEHzdb6LCP5oOIYhNNHAuhewAKlb7RoaSBvv7C6l71wB2PtcIp2b3IBGOOTYSMK0bkE62s9YJ+6rnwPApMRJPzQitTlnU7SiAWC6epyjTvTsTH9xMm7ict5dTEoq2TiUYLBEicsFUQ/ooxgPUU9zCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790078; c=relaxed/simple;
	bh=4v3ujJmrw8t7HXafYzpQ8qHUdGbFJB3gZEk1rs3PORA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8PvzXWdeHJiBhxxuR5B/LkcpsarHZxZFq5KvHnWOOrfwfy+4DcE/F8/ec19gqsU2BmFm0TLw23s1FpCrqS9buAfQbX0bsnLJmfzYZVvfs1jpXjwtQbxto0SV36o6+e8L4iI26iAPNfQQHqi3r2wibk7H5auF0YFEbH7GVmpNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6Kb64Xf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727790077; x=1759326077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4v3ujJmrw8t7HXafYzpQ8qHUdGbFJB3gZEk1rs3PORA=;
  b=R6Kb64Xf2+0mB13GgGwRGyf3f2Zh6Ru9/LFQJGVlyxm/XSkWvciR7xjJ
   CdmMnqlCpCHizl8WigYZ744yr4RVq1svIZZzZFcoxJ5UxB7digaSA6Ixk
   ve+VpQqi59RRjEDQLaYMrZArWH9Ur39DLXoX2WQS+9sw81QZHf4+vIYhA
   mJ111TxsVcWYwayUnwHRY2Q+xzbzorSFF0H8AGNJrlSLflxV6Ov6wnsJy
   sNuPqHXvYl+Mva2chhjZbN/Tm7Ib+wf2oDqDPOoHJn1xMVR+DWcPdixWv
   ZMy6KyYUTDM0Me/J57jpadufojKpDJIFDcY9sOLo9Jo4qDSL7ZycQho3J
   g==;
X-CSE-ConnectionGUID: 2s712ZVaRr2SM2A1ZFlW4Q==
X-CSE-MsgGUID: nC+2wDWMSGaBCtxBEmMdAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="49446688"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="49446688"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 06:41:17 -0700
X-CSE-ConnectionGUID: 3xxN3efdSFaNwoIMKmCtKA==
X-CSE-MsgGUID: b+H69q+MTd2T66oSkW69Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73790598"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 01 Oct 2024 06:41:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Oct 2024 16:41:13 +0300
Date: Tue, 1 Oct 2024 16:41:13 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org,
	Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH] iwlegacy: Clear stale interrupts before enabling
 interrupts
Message-ID: <Zvv7-YLhJ3EgaxiN@intel.com>
References: <20240930122924.21865-1-ville.syrjala@linux.intel.com>
 <87r0908fuf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0908fuf.fsf@kernel.org>
X-Patchwork-Hint: comment

On Tue, Oct 01, 2024 at 10:03:36AM +0300, Kalle Valo wrote:
> Ville Syrjala <ville.syrjala@linux.intel.com> writes:
> 
> > iwl4965 fails upon resume from hibernation on my laptop. The reason
> > seems to be a stale interrupt which isn't being cleared out before
> > interrupts are enabled.
> 
> Is this a regression? Do you know what version still worked?

Looks like the oldest kernel I have around on that machine is
5.0, and a quick test says it's broken exactly in the same way.
So if it's a regression then it's an old one.

-- 
Ville Syrjälä
Intel

