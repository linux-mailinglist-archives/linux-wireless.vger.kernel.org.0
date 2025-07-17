Return-Path: <linux-wireless+bounces-25589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12CB087FD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 10:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F148BA4023D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C4279798;
	Thu, 17 Jul 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgwbKFlQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7711EF0B9;
	Thu, 17 Jul 2025 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741239; cv=none; b=S5pl5FDyaVnHFq2KHbkzAWtVQkZqRE6MGK4snC2bo4V2GW728hDP+FwQ+dHr11If+YWpZWTvEUbmzQB5hmKskClID7GQ2JH+NQ7yVgjhjPzqfOEEkhw5loJBuEpQGS9aSZTodnDTlV0SuAMnHYXoeLjc4pvhD7krenSURFGso/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741239; c=relaxed/simple;
	bh=yLCrBOZm7Q9yTCeRS40yaLfmpTFicj1UCMT0A5NRQmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtzmL+GArHalHPuKC3Np4dtRy5bksteW4EvS78K6CJzU6eNHPAfJ2mOpsk10WNRQxCMmNA66zQk9RLHVYT2wtbScYPr9aUYRRh3DoJt8ypS44f846pmwll5WYEzavIqT0GG+1ThfnpxGkt+4ia4Rm3z+A+4QhN+/yGkdIf0yDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgwbKFlQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752741238; x=1784277238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yLCrBOZm7Q9yTCeRS40yaLfmpTFicj1UCMT0A5NRQmA=;
  b=RgwbKFlQNwRkttxuUiiaEJhBj2pBvwQeByE0F/0E83RlQiNjBo9+S/lD
   tzgINOFJyFpjhtWV8yZTs/VQUvmVZfJ6pSJ/dUhHz1FO3SsyfDazgFz29
   FREuPVbGKU0wVT1S69WHcwEaSC+zueH/oYzgYPUAjL4C5XmgemlOMWc/n
   xEC2sGc+pt/tMzvVLJqftWezO4nEkYHymnwtgNPbWDQNuoNsazUtka0JY
   kG4F3W4U3YZd2QegDYdNqGkY/LXu3x1gYVjLHyZeDU7lIkpu9qeXC84lI
   goZTkFbRTSCvmvHjCmcRUyaVQUfnUDgXbilP0oo9g0QGjF4NXBqBjqNgI
   w==;
X-CSE-ConnectionGUID: X0Zl2uv8SfmSCywEJoeWEw==
X-CSE-MsgGUID: An/PyB/yTt+Uoz3vG/4LVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66456965"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="66456965"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 01:33:58 -0700
X-CSE-ConnectionGUID: BZcksriHRYi9EJu3ijnb3A==
X-CSE-MsgGUID: kJOhJ3oaRfqvVgtmVOxesg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="163265703"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jul 2025 01:33:54 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucK3s-000DNP-0o;
	Thu, 17 Jul 2025 08:33:52 +0000
Date: Thu, 17 Jul 2025 16:33:09 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 11/11] wifi: ath12k: fix endianness handling in QMI
 response
Message-ID: <202507171640.30pUvpPv-lkp@intel.com>
References: <20250716075100.1447352-12-alexander.wilhelm@westermo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716075100.1447352-12-alexander.wilhelm@westermo.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ath/ath-next]
[also build test WARNING on linus/master v6.16-rc6 next-20250716]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Wilhelm/wifi-ath12k-fix-endianness-handling-in-QMI-host-capability-request/20250716-162058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20250716075100.1447352-12-alexander.wilhelm%40westermo.com
patch subject: [PATCH 11/11] wifi: ath12k: fix endianness handling in QMI response
config: mips-randconfig-r123-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171640.30pUvpPv-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250717/202507171640.30pUvpPv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171640.30pUvpPv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/qcom/pdr_interface.c:612:22: sparse: sparse: restricted __le16 degrades to integer
   drivers/soc/qcom/pdr_interface.c:613:22: sparse: sparse: restricted __le16 degrades to integer

vim +612 drivers/soc/qcom/pdr_interface.c

fbe639b44a8275 Sibi Sankar           2020-03-12  549  
fbe639b44a8275 Sibi Sankar           2020-03-12  550  /**
fbe639b44a8275 Sibi Sankar           2020-03-12  551   * pdr_restart_pd() - restart PD
fbe639b44a8275 Sibi Sankar           2020-03-12  552   * @pdr:	PDR client handle
fbe639b44a8275 Sibi Sankar           2020-03-12  553   * @pds:	PD service handle
fbe639b44a8275 Sibi Sankar           2020-03-12  554   *
fbe639b44a8275 Sibi Sankar           2020-03-12  555   * Restarts the PD tracked by the PDR client handle for a given service path.
fbe639b44a8275 Sibi Sankar           2020-03-12  556   *
fbe639b44a8275 Sibi Sankar           2020-03-12  557   * Return: 0 on success, negative errno on failure.
fbe639b44a8275 Sibi Sankar           2020-03-12  558   */
fbe639b44a8275 Sibi Sankar           2020-03-12  559  int pdr_restart_pd(struct pdr_handle *pdr, struct pdr_service *pds)
fbe639b44a8275 Sibi Sankar           2020-03-12  560  {
fbe639b44a8275 Sibi Sankar           2020-03-12  561  	struct servreg_restart_pd_resp resp;
a161ffe4b87772 Tom Rix               2020-08-19  562  	struct servreg_restart_pd_req req = { 0 };
fbe639b44a8275 Sibi Sankar           2020-03-12  563  	struct sockaddr_qrtr addr;
fbe639b44a8275 Sibi Sankar           2020-03-12  564  	struct pdr_service *tmp;
fbe639b44a8275 Sibi Sankar           2020-03-12  565  	struct qmi_txn txn;
fbe639b44a8275 Sibi Sankar           2020-03-12  566  	int ret;
fbe639b44a8275 Sibi Sankar           2020-03-12  567  
fbe639b44a8275 Sibi Sankar           2020-03-12  568  	if (IS_ERR_OR_NULL(pdr) || IS_ERR_OR_NULL(pds))
fbe639b44a8275 Sibi Sankar           2020-03-12  569  		return -EINVAL;
fbe639b44a8275 Sibi Sankar           2020-03-12  570  
fbe639b44a8275 Sibi Sankar           2020-03-12  571  	mutex_lock(&pdr->list_lock);
fbe639b44a8275 Sibi Sankar           2020-03-12  572  	list_for_each_entry(tmp, &pdr->lookups, node) {
fbe639b44a8275 Sibi Sankar           2020-03-12  573  		if (tmp != pds)
fbe639b44a8275 Sibi Sankar           2020-03-12  574  			continue;
fbe639b44a8275 Sibi Sankar           2020-03-12  575  
fbe639b44a8275 Sibi Sankar           2020-03-12  576  		if (!pds->service_connected)
fbe639b44a8275 Sibi Sankar           2020-03-12  577  			break;
fbe639b44a8275 Sibi Sankar           2020-03-12  578  
fbe639b44a8275 Sibi Sankar           2020-03-12  579  		/* Prepare req message */
26bc7a6a0beed8 Len Baker             2021-08-08  580  		strscpy(req.service_path, pds->service_path, sizeof(req.service_path));
fbe639b44a8275 Sibi Sankar           2020-03-12  581  		addr = pds->addr;
fbe639b44a8275 Sibi Sankar           2020-03-12  582  		break;
fbe639b44a8275 Sibi Sankar           2020-03-12  583  	}
fbe639b44a8275 Sibi Sankar           2020-03-12  584  	mutex_unlock(&pdr->list_lock);
fbe639b44a8275 Sibi Sankar           2020-03-12  585  
fbe639b44a8275 Sibi Sankar           2020-03-12  586  	if (!req.service_path[0])
fbe639b44a8275 Sibi Sankar           2020-03-12  587  		return -EINVAL;
fbe639b44a8275 Sibi Sankar           2020-03-12  588  
fbe639b44a8275 Sibi Sankar           2020-03-12  589  	ret = qmi_txn_init(&pdr->notifier_hdl, &txn,
fbe639b44a8275 Sibi Sankar           2020-03-12  590  			   servreg_restart_pd_resp_ei,
fbe639b44a8275 Sibi Sankar           2020-03-12  591  			   &resp);
fbe639b44a8275 Sibi Sankar           2020-03-12  592  	if (ret < 0)
fbe639b44a8275 Sibi Sankar           2020-03-12  593  		return ret;
fbe639b44a8275 Sibi Sankar           2020-03-12  594  
fbe639b44a8275 Sibi Sankar           2020-03-12  595  	ret = qmi_send_request(&pdr->notifier_hdl, &addr,
fbe639b44a8275 Sibi Sankar           2020-03-12  596  			       &txn, SERVREG_RESTART_PD_REQ,
fbe639b44a8275 Sibi Sankar           2020-03-12  597  			       SERVREG_RESTART_PD_REQ_MAX_LEN,
fbe639b44a8275 Sibi Sankar           2020-03-12  598  			       servreg_restart_pd_req_ei, &req);
fbe639b44a8275 Sibi Sankar           2020-03-12  599  	if (ret < 0) {
fbe639b44a8275 Sibi Sankar           2020-03-12  600  		qmi_txn_cancel(&txn);
fbe639b44a8275 Sibi Sankar           2020-03-12  601  		return ret;
fbe639b44a8275 Sibi Sankar           2020-03-12  602  	}
fbe639b44a8275 Sibi Sankar           2020-03-12  603  
fbe639b44a8275 Sibi Sankar           2020-03-12  604  	ret = qmi_txn_wait(&txn, 5 * HZ);
fbe639b44a8275 Sibi Sankar           2020-03-12  605  	if (ret < 0) {
fbe639b44a8275 Sibi Sankar           2020-03-12  606  		pr_err("PDR: %s PD restart txn wait failed: %d\n",
fbe639b44a8275 Sibi Sankar           2020-03-12  607  		       req.service_path, ret);
fbe639b44a8275 Sibi Sankar           2020-03-12  608  		return ret;
fbe639b44a8275 Sibi Sankar           2020-03-12  609  	}
fbe639b44a8275 Sibi Sankar           2020-03-12  610  
fbe639b44a8275 Sibi Sankar           2020-03-12  611  	/* Check response if PDR is disabled */
fbe639b44a8275 Sibi Sankar           2020-03-12 @612  	if (resp.resp.result == QMI_RESULT_FAILURE_V01 &&
fbe639b44a8275 Sibi Sankar           2020-03-12  613  	    resp.resp.error == QMI_ERR_DISABLED_V01) {
fbe639b44a8275 Sibi Sankar           2020-03-12  614  		pr_err("PDR: %s PD restart is disabled: 0x%x\n",
fbe639b44a8275 Sibi Sankar           2020-03-12  615  		       req.service_path, resp.resp.error);
fbe639b44a8275 Sibi Sankar           2020-03-12  616  		return -EOPNOTSUPP;
fbe639b44a8275 Sibi Sankar           2020-03-12  617  	}
fbe639b44a8275 Sibi Sankar           2020-03-12  618  
fbe639b44a8275 Sibi Sankar           2020-03-12  619  	/* Check the response for other error case*/
fbe639b44a8275 Sibi Sankar           2020-03-12  620  	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
fbe639b44a8275 Sibi Sankar           2020-03-12  621  		pr_err("PDR: %s request for PD restart failed: 0x%x\n",
fbe639b44a8275 Sibi Sankar           2020-03-12  622  		       req.service_path, resp.resp.error);
fbe639b44a8275 Sibi Sankar           2020-03-12  623  		return -EREMOTEIO;
fbe639b44a8275 Sibi Sankar           2020-03-12  624  	}
fbe639b44a8275 Sibi Sankar           2020-03-12  625  
fbe639b44a8275 Sibi Sankar           2020-03-12  626  	return 0;
fbe639b44a8275 Sibi Sankar           2020-03-12  627  }
9b09c0f289c5a8 Unnathi Chalicheemala 2023-09-22  628  EXPORT_SYMBOL_GPL(pdr_restart_pd);
fbe639b44a8275 Sibi Sankar           2020-03-12  629  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

