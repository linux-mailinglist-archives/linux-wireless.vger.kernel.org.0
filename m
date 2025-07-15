Return-Path: <linux-wireless+bounces-25449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D351B05493
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5441B1AA4087
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3C6274FC6;
	Tue, 15 Jul 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnGW+Fpp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3611DED5F;
	Tue, 15 Jul 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567496; cv=none; b=TYoPOaPYjENW8krnwzydO4zVjPD96hR11JjGDwKAIYu5i0wp8aQMGjaUQqTiM+GcneWFdQN/Fp2jRfNIyhtKDNukjqekGJODq23JLRka533s6puoaNOCE2mNgXlUUPxlzHxvGD88e92bfy7TyVuWpUTncFUPxX+oeEOp2z1PcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567496; c=relaxed/simple;
	bh=MFb8FgT6fSDI2D8rxvLxQMAJT9ijx7F8oDCj6Wg1Pro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiQmoaX+quGhyebJ7F05e/Q0os1lkYbgR23Efm41GWRLyUw5swBLJUFQZsoiVDoplJtI1jKcQjD+G1vn/5LIajXZePv2AYAe6nYPQdYzveX6tI6/4wMDr5mvQ4erS2BQJo4WA8cJMND3UNSxM6uCZs1RryJb6SYLuaJ497Y0k04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnGW+Fpp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752567496; x=1784103496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MFb8FgT6fSDI2D8rxvLxQMAJT9ijx7F8oDCj6Wg1Pro=;
  b=cnGW+FppetSHosplfASeZhSs+YWKh1nguWcCgPodNn+7a55XT2iEP8j/
   7jjK8QVmss7GoU+z8TRuUfjJj7UwHt9TujfypCrqvJnNfuO3VT3LwHz4u
   ktg4jTmkXETieTZPqyXyWrgf0LWVmR8coD06skgTbVUDpuKQu9CBQDhVk
   Cl21CViB36QdHb8ZYHIOi4lZqnDehqWowBcCqNkEl50tEWJZgQAZl3Asi
   tfV93K9SMB/F4MLehra7jKhWbtTluTAzedTvWEEI7FC11FgG3ZT+P4L02
   BJc08U/Ceq1M9BUjXi4vvy1QNyB4HPji2BsZs6kfe7Zs14zbf7cQvaDwJ
   w==;
X-CSE-ConnectionGUID: MH3lyqtWTlOTEaCLCT9xRA==
X-CSE-MsgGUID: NudytUpiRXup5AMsAvhw/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54923253"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54923253"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:18:15 -0700
X-CSE-ConnectionGUID: hVIFMryWQF+6/SHveef8aw==
X-CSE-MsgGUID: Sqi4fyYWRDecr+pZkdKjEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="188149175"
Received: from ettammin-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.145])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:18:13 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E08FA11F87A;
	Tue, 15 Jul 2025 11:18:09 +0300 (EEST)
Date: Tue, 15 Jul 2025 08:18:09 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Greer <mgreer@animalcreek.com>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 50/80] nfc: trf7970a: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aHYOwbFImJdf8RvK@kekkonen.localdomain>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075439.3221036-1-sakari.ailus@linux.intel.com>
 <51feb545-42a4-4f8b-a983-59104980f97d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51feb545-42a4-4f8b-a983-59104980f97d@kernel.org>

Hi Krzysztof,

On Fri, Jul 04, 2025 at 10:03:27AM +0200, Krzysztof Kozlowski wrote:
> On 04/07/2025 09:54, Sakari Ailus wrote:
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > pm_runtime_mark_last_busy().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> > The cover letter of the set can be found here
> > <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> > 
> > In brief, this patch depends on PM runtime patches adding marking the last
> > busy timestamp in autosuspend related functions. The patches are here, on
> > rc2:
> > 
> 
> You did not send cover letter to people, so this changelog should
> explain what I should do with this patch (what is the merging/dependency).

I didn't as it would have had too many recipients (more than 200 in fact).
As you may have noticed, the URL for the cover letter is a few lines above,
also its Message-ID can be found in the In-reply-to: header.

-- 
Kind regards,

Sakari Ailus

