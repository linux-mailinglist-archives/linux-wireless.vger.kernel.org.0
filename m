Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA847917A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhLQQaV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 11:30:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:11541 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238012AbhLQQaV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 11:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639758621; x=1671294621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFj8DfNA2kAP3BcoR5goffl174HWF3Nwjrrtclqjq/8=;
  b=hrkUXukzueoukB4lWpczN3VSBp/EUdkpybeuWhKR7LUL9HSEl75vx7JO
   YafEKT21yZNSZBbyZN6euzN/+bQDzBS4CISOS7LItCpEkPu8ySjiKgv4J
   0OiVr/ZA9M81bLPz4oMasOtND0V+gTehBRBIJi9/SgMreKhADn31RDaA/
   posb0oCTe0KBwCFt9usvzOEV+XfXzBKjji++055QoiTSUJi54V2GRR9mZ
   Z2PvvHa3WwOtqTzToRXbxuNKde1OoKBKq0XQUendUElHFWfgu9X3N61zq
   yIqzje8SXgYJyALpaVPhRw6ukSJ40t19qs86dPfoEROYejVUSyEQ1AJ1h
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="300557931"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="300557931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="662883221"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 08:30:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myG7e-0004vq-RD; Fri, 17 Dec 2021 16:30:18 +0000
Date:   Sat, 18 Dec 2021 00:29:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cheng Wang <quic_chengwan@quicinc.com>, ath11k@lists.infradead.org
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        quic_chengwan@quicinc.com
Subject: Re: [PATCH v2] ath11k: add support of firmware logging for WCN6855
Message-ID: <202112180012.UCXm8ASb-lkp@intel.com>
References: <20211217112605.2823570-1-quic_chengwan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217112605.2823570-1-quic_chengwan@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Cheng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvalo-ath/ath-next]
[also build test WARNING on next-20211217]
[cannot apply to v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cheng-Wang/ath11k-add-support-of-firmware-logging-for-WCN6855/20211217-192713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
config: mips-randconfig-r023-20211216 (https://download.01.org/0day-ci/archive/20211218/202112180012.UCXm8ASb-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3c8528cf3263af58b974c4fdc3a2d3d0ea32bc3c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cheng-Wang/ath11k-add-support-of-firmware-logging-for-WCN6855/20211217-192713
        git checkout 3c8528cf3263af58b974c4fdc3a2d3d0ea32bc3c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/qmi.c:2542:5: warning: no previous prototype for 'ath11k_qmi_wlanfw_wlan_ini_send' [-Wmissing-prototypes]
    2542 | int ath11k_qmi_wlanfw_wlan_ini_send(struct ath11k_base *ab, bool enable)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ath11k_qmi_wlanfw_wlan_ini_send +2542 drivers/net/wireless/ath/ath11k/qmi.c

  2541	
> 2542	int ath11k_qmi_wlanfw_wlan_ini_send(struct ath11k_base *ab, bool enable)
  2543	{
  2544		int ret;
  2545		struct qmi_txn txn;
  2546		struct qmi_wlanfw_wlan_ini_req_msg_v01 req = {};
  2547		struct qmi_wlanfw_wlan_ini_resp_msg_v01 resp = {};
  2548	
  2549		req.enablefwlog_valid = true;
  2550		req.enablefwlog = enable ? 1 : 0;
  2551	
  2552		ret = qmi_txn_init(&ab->qmi.handle, &txn,
  2553				   qmi_wlanfw_wlan_ini_resp_msg_v01_ei, &resp);
  2554		if (ret < 0)
  2555			goto out;
  2556	
  2557		ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
  2558				       QMI_WLANFW_WLAN_INI_REQ_V01,
  2559				       QMI_WLANFW_WLAN_INI_REQ_MSG_V01_MAX_LEN,
  2560				       qmi_wlanfw_wlan_ini_req_msg_v01_ei, &req);
  2561		if (ret < 0) {
  2562			ath11k_warn(ab, "qmi failed to send wlan ini request, err = %d\n",
  2563				    ret);
  2564			qmi_txn_cancel(&txn);
  2565			goto out;
  2566		}
  2567	
  2568		ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
  2569		if (ret < 0) {
  2570			ath11k_warn(ab, "qmi failed wlan ini request, err = %d\n", ret);
  2571			goto out;
  2572		}
  2573	
  2574		if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
  2575			ath11k_warn(ab, "qmi wlan ini request failed, result: %d, err: %d\n",
  2576				    resp.resp.result, resp.resp.error);
  2577			ret = -EINVAL;
  2578		}
  2579	
  2580	out:
  2581		return ret;
  2582	}
  2583	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
