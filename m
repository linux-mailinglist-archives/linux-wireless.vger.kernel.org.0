Return-Path: <linux-wireless+bounces-31875-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG6wJzgIkmn+pgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31875-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Feb 2026 18:54:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F8813F4D9
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Feb 2026 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAEA53001F8C
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Feb 2026 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1326FD93;
	Sun, 15 Feb 2026 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9uFP9Il"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94303946C
	for <linux-wireless@vger.kernel.org>; Sun, 15 Feb 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771178034; cv=none; b=MQkR+4Blclst6480o6T88Ug2+uObr3QOn75Qpws35J0IlBuTBRoB0G9k4eZ6afgwvH5imegcJbpYdOQxsc73oce/YaPIR6CUlpse7T+fZU/Rz7dfG/sjkXhUwZENiUN8Du1lTLQA1Wf8X49U403tjCwT0g6dUzQ6LO+R0AFHdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771178034; c=relaxed/simple;
	bh=hXOlYDzkGeHdSnx/HxwTez3vHrXkvJwme569VZU5k80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wocrdekdq4lQUyL7wXBihjDnlweeqXbYd+fwB2OAGsb3LT2dtuGi3LnHFx8iDnAkNvH0dMFFPqrrKWYgvIbGHPlwDqTbEZCsPce1vQ1Z0RvVIS2SjqPKZsnmzaTnNI7QGLdoyVHBDT4MOTPuWLP5k8JE2z5xCjRB9SKchWkpMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9uFP9Il; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771178032; x=1802714032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXOlYDzkGeHdSnx/HxwTez3vHrXkvJwme569VZU5k80=;
  b=i9uFP9IlV5gC0t+vCZS1c/ziauqeSW5nPGCpEtxGEb7W/YQnnybon2wQ
   Snp2k8Lp4lTX792Ig4w8pDikOx9oGYJbQ9eiwqDshJuR5X0hWZGHQiNot
   KBfj6/FKKoF1TDgDgqXqeYAv43/i+ruSbXZZfRQSuG7HJpXbQYXYiI9uT
   FGVwKVxU/Yjat/GicNy0Al68E2IfYCI+/M8Hy5CHPIbwlc2nrhYHDblJu
   Is8NU/eyl8yEjS3LKIQ2dAlZp/5hw+A9ntQFvkeYcGgmhBMp1cSbeNp1h
   jNK5jpCs6Vl5lzo5uVNQCAjYogdqHgic4GOLnGCWwJURQVeUsRnIQFIfy
   Q==;
X-CSE-ConnectionGUID: GBcSZxTLQ0qXxluHyd36eA==
X-CSE-MsgGUID: qwn+f2pUTu2lVJeqI/UM1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="75902219"
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="75902219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 09:53:52 -0800
X-CSE-ConnectionGUID: jJMFrSu/Qn2e0t5khQiiFw==
X-CSE-MsgGUID: QhR4QmFQSZiO/izzqqUGow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="212449286"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Feb 2026 09:53:50 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrgJX-00000000yye-1ZjV;
	Sun, 15 Feb 2026 17:53:47 +0000
Date: Mon, 16 Feb 2026 01:53:31 +0800
From: kernel test robot <lkp@intel.com>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
	ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
	Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: add basic hwmon temperature
 reporting
Message-ID: <202602160145.YQdvbqYY-lkp@intel.com>
References: <20260214035947.44671-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214035947.44671-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31875-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0F8813F4D9
X-Rspamd-Action: no action

Hi Maharaja,

kernel test robot noticed the following build errors:

[auto build test ERROR on 37a93dd5c49b5fda807fd204edf2547c3493319c]

url:    https://github.com/intel-lab-lkp/linux/commits/Maharaja-Kennadyrajan/wifi-ath12k-add-basic-hwmon-temperature-reporting/20260214-120212
base:   37a93dd5c49b5fda807fd204edf2547c3493319c
patch link:    https://lore.kernel.org/r/20260214035947.44671-1-maharaja.kennadyrajan%40oss.qualcomm.com
patch subject: [PATCH ath-next] wifi: ath12k: add basic hwmon temperature reporting
config: x86_64-randconfig-075-20250806 (https://download.01.org/0day-ci/archive/20260216/202602160145.YQdvbqYY-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260216/202602160145.YQdvbqYY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602160145.YQdvbqYY-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `ath12k_thermal_unregister':
>> drivers/net/wireless/ath/ath12k/thermal.c:118:(.text+0x2df8112): undefined reference to `hwmon_device_unregister'


vim +118 drivers/net/wireless/ath/ath12k/thermal.c

   106	
   107	void ath12k_thermal_unregister(struct ath12k_base *ab)
   108	{
   109		struct ath12k *ar;
   110		int i;
   111	
   112		for (i = 0; i < ab->num_radios; i++) {
   113			ar = ab->pdevs[i].ar;
   114			if (!ar)
   115				continue;
   116	
   117			if (ar->thermal.hwmon_dev) {
 > 118				hwmon_device_unregister(ar->thermal.hwmon_dev);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

