Return-Path: <linux-wireless+bounces-25612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD35B0913B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 18:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040615A473F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0232F949E;
	Thu, 17 Jul 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBMpdII8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8722FA65D;
	Thu, 17 Jul 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768009; cv=none; b=EcF4dUyjsJ+mZLPpRqiVoO0WzGzn77r5nAB510WBD33t2ox8WARhuFHE5cSmGL8OH851tDa78cQS1JYqivaekzunoZk2nE5g7dbyowXicJhfwGGrUlztHaYRGTRwqaXWDf9eiOe925plf8nwgpqXcLwepEIfaADCbkfV9O2pVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768009; c=relaxed/simple;
	bh=ozatPYm8SkCRErUJZAqo7DV6TZZ+7eY1RkGwfl3kkqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY4Vk93ylDiQ/n+04GQ+53i1yX8ecCoMRnKPUBBwWE4OkUtd1ZBbPNFtv8AybJdJShtU6YzmFwSwa2mneksD+kzNlR9GHyxVlHEe1nwXUcy3FZsF/EVx005/ZXPooJOih9MKC5Ygzuzs/Y9Gp0jekgyZ1yent4B/+euycL8qNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBMpdII8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752768008; x=1784304008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ozatPYm8SkCRErUJZAqo7DV6TZZ+7eY1RkGwfl3kkqY=;
  b=gBMpdII8leJoqx20gWOm0EuFjd9CWG8e4hcSyECr8ZTM8StgkccOpdFR
   GtbUpI2y909DxEb5SnvvYk0ZN80R4ZqsIe1x5joJY1LI7h87VpDNitki4
   CjV5wRMYkVKt/hcQA9aLZaiFuVQQ5Co5pbXmBxezZkWPPecjviZQf2yil
   pRIpXBvzBEsB20ozg34NjNC1n6Uf0s96qMmAFWqn5vNPNfVQ8fLUSM5rV
   WmlDhWIFpZrgsvtOx3BNO+dYCe0P0D2c34KMMnpLPd2pQI12dUchpz2+N
   rmoI012qH+d3Sv521yYRVs5JbLrAz6uIuDu3UfiVUP1lsyhBjCgSQz2l2
   Q==;
X-CSE-ConnectionGUID: TBqp/MerR9KJHRBpiJPuFw==
X-CSE-MsgGUID: XilDiSxZRnSGomzjdaaLHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="77585774"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="77585774"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 09:00:07 -0700
X-CSE-ConnectionGUID: r095Z+45RpqpTaJi1g3AEg==
X-CSE-MsgGUID: Nm1YwRngSc+K7tDnca0fbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157501256"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2025 09:00:01 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucR1a-000Dmh-0F;
	Thu, 17 Jul 2025 15:59:58 +0000
Date: Thu, 17 Jul 2025 23:59:43 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 07/11] wifi: ath12k: fix endianness handling in QMI bdf
 download
Message-ID: <202507172333.LZcmFwWs-lkp@intel.com>
References: <20250716075100.1447352-8-alexander.wilhelm@westermo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716075100.1447352-8-alexander.wilhelm@westermo.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ath/ath-next]
[also build test WARNING on linus/master v6.16-rc6 next-20250717]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Wilhelm/wifi-ath12k-fix-endianness-handling-in-QMI-host-capability-request/20250716-162058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20250716075100.1447352-8-alexander.wilhelm%40westermo.com
patch subject: [PATCH 07/11] wifi: ath12k: fix endianness handling in QMI bdf download
config: alpha-randconfig-r122-20250717 (https://download.01.org/0day-ci/archive/20250717/202507172333.LZcmFwWs-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250717/202507172333.LZcmFwWs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507172333.LZcmFwWs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath12k/qmi.c:2996:37: sparse: sparse: bad assignment (+=) to restricted __le32

vim +2996 drivers/net/wireless/ath/ath12k/qmi.c

  2919	
  2920	static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
  2921						   const u8 *data, u32 len, u8 type)
  2922	{
  2923		struct qmi_wlanfw_bdf_download_req_msg_v01 *req;
  2924		struct qmi_wlanfw_bdf_download_resp_msg_v01 resp = {};
  2925		struct qmi_txn txn;
  2926		const u8 *temp = data;
  2927		int ret = 0;
  2928		u32 remaining = len;
  2929	
  2930		req = kzalloc(sizeof(*req), GFP_KERNEL);
  2931		if (!req)
  2932			return -ENOMEM;
  2933	
  2934		while (remaining) {
  2935			req->valid = 1;
  2936			req->file_id_valid = 1;
  2937			req->file_id = cpu_to_le32(ab->qmi.target.board_id);
  2938			req->total_size_valid = 1;
  2939			req->total_size = cpu_to_le32(remaining);
  2940			req->seg_id_valid = 1;
  2941			req->data_valid = 1;
  2942			req->bdf_type = type;
  2943			req->bdf_type_valid = 1;
  2944			req->end_valid = 1;
  2945			req->end = 0;
  2946	
  2947			if (remaining > QMI_WLANFW_MAX_DATA_SIZE_V01) {
  2948				req->data_len = cpu_to_le32(QMI_WLANFW_MAX_DATA_SIZE_V01);
  2949			} else {
  2950				req->data_len = cpu_to_le32(remaining);
  2951				req->end = 1;
  2952			}
  2953	
  2954			if (type == ATH12K_QMI_FILE_TYPE_EEPROM) {
  2955				req->data_valid = 0;
  2956				req->end = 1;
  2957				req->data_len = cpu_to_le32(ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE);
  2958			} else {
  2959				memcpy(req->data, temp, le32_to_cpu(req->data_len));
  2960			}
  2961	
  2962			ret = qmi_txn_init(&ab->qmi.handle, &txn,
  2963					   qmi_wlanfw_bdf_download_resp_msg_v01_ei,
  2964					   &resp);
  2965			if (ret < 0)
  2966				goto out;
  2967	
  2968			ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi bdf download req fixed addr type %d\n",
  2969				   type);
  2970	
  2971			ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
  2972					       QMI_WLANFW_BDF_DOWNLOAD_REQ_V01,
  2973					       QMI_WLANFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_LEN,
  2974					       qmi_wlanfw_bdf_download_req_msg_v01_ei, req);
  2975			if (ret < 0) {
  2976				qmi_txn_cancel(&txn);
  2977				goto out;
  2978			}
  2979	
  2980			ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH12K_QMI_WLANFW_TIMEOUT_MS));
  2981			if (ret < 0)
  2982				goto out;
  2983	
  2984			if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
  2985				ath12k_warn(ab, "qmi BDF download failed, result: %d, err: %d\n",
  2986					    resp.resp.result, resp.resp.error);
  2987				ret = -EINVAL;
  2988				goto out;
  2989			}
  2990	
  2991			if (type == ATH12K_QMI_FILE_TYPE_EEPROM) {
  2992				remaining = 0;
  2993			} else {
  2994				remaining -= le32_to_cpu(req->data_len);
  2995				temp += le32_to_cpu(req->data_len);
> 2996				req->seg_id += cpu_to_le32(1);
  2997				ath12k_dbg(ab, ATH12K_DBG_QMI,
  2998					   "qmi bdf download request remaining %i\n",
  2999					   remaining);
  3000			}
  3001		}
  3002	
  3003	out:
  3004		kfree(req);
  3005		return ret;
  3006	}
  3007	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

