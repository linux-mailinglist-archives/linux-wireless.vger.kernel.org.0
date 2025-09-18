Return-Path: <linux-wireless+bounces-27463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B7B83113
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702843A8245
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 06:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1502D838B;
	Thu, 18 Sep 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMEmJTd0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C32D7D59;
	Thu, 18 Sep 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175215; cv=none; b=o102ROSfNrNkwWkKDQplcnDaMXE8s7W+iKcRwDxg2KK/mdvH8ZDlX97Lza/hVdY4oSvYsDDnmGK7+7OKAyaAlCIYvBMAW/clgtTMyVWWNsqQBVreInSeIhLghMm2DcTMK2IYEGvSeQCX3mpHfAgTN57yTDIwqRofjlzCa2hr1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175215; c=relaxed/simple;
	bh=0old9ctTyJsH/xFzWRZPdPpfchK49uoPWBzcpSBTL70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbY20LoljbBNmOp3iij7+DPI/JmXAbu+mYqIcilpTH4Ykk3rmil/xHsjYT+1sTue5JIyi2hB/83iXWYZsqaxueSXbm2sPsPgND0C6Fg8BBCEOuQrs1AYnjiyiyy+GiTEBLZIEaF2vyzyK0zyl95A86/uzx39PlDZez9qCgAbgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMEmJTd0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758175213; x=1789711213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0old9ctTyJsH/xFzWRZPdPpfchK49uoPWBzcpSBTL70=;
  b=mMEmJTd0/o4yamQdDZHyRV2YSB1YQAzi+sDhOWuL0NtBBliwa/36RWkj
   uavc1r1cq5mN6/Qt0FaNjXh2VZJzhArFjhiUgeJkzovwPT6Y7RUwbGDD6
   9EB+Ahzl1MqJfI2vVVfL3Mu6qlbWrHzh8SYeg6upQmdd4C51w/tYnTV+x
   zFVMJRBWcAJvbR4yYParWjgW2TZ3TRL5sC5Z6Jjrpp4x3q2GA6jcn1tTq
   JJADchVF/EgeH6w2bzEgVDINrdzlwO45ZnCu7xTb9Q8NEozqr9HCaI/Pl
   5bNs9KqqJnLQco8K/ZgVEsifedgM/5VZa9TUZYBvDgs3b1gBkki1yrsC6
   Q==;
X-CSE-ConnectionGUID: UdGRbL31QfCR58r4ZDvPSQ==
X-CSE-MsgGUID: kELJzKH9TqeLzGWN3YEEfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60606193"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60606193"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:00:12 -0700
X-CSE-ConnectionGUID: HqVbENHoSCCstfpcc2jBfA==
X-CSE-MsgGUID: O/WEU7TfQCO7wMt5r4e3QA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Sep 2025 23:00:10 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uz7gd-0002oN-0f;
	Thu, 18 Sep 2025 06:00:07 +0000
Date: Thu, 18 Sep 2025 13:59:15 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 2/4] soc: qcom: fix QMI encoding/decoding for
 basic elements
Message-ID: <202509181302.j10W2wCw-lkp@intel.com>
References: <20250917070428.2909-3-alexander.wilhelm@westermo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917070428.2909-3-alexander.wilhelm@westermo.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ath/ath-next]
[also build test WARNING on linus/master v6.17-rc6 next-20250917]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Wilhelm/soc-qcom-introduce-generic-QMI-encoding-decoding-macros/20250917-150826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20250917070428.2909-3-alexander.wilhelm%40westermo.com
patch subject: [PATCH v2 RESEND 2/4] soc: qcom: fix QMI encoding/decoding for basic elements
config: openrisc-randconfig-r132-20250918 (https://download.01.org/0day-ci/archive/20250918/202509181302.j10W2wCw-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250918/202509181302.j10W2wCw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509181302.j10W2wCw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/soc/qcom/qmi_encdec.c:384:55: sparse: sparse: cast to restricted __le16
   drivers/soc/qcom/qmi_encdec.c:384:55: sparse: sparse: cast to restricted __le16
   drivers/soc/qcom/qmi_encdec.c:384:55: sparse: sparse: cast to restricted __le16
   drivers/soc/qcom/qmi_encdec.c:384:55: sparse: sparse: cast to restricted __le16
   drivers/soc/qcom/qmi_encdec.c:715:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val32 @@     got restricted __le32 [usertype] @@
   drivers/soc/qcom/qmi_encdec.c:715:31: sparse:     expected unsigned int [usertype] val32
   drivers/soc/qcom/qmi_encdec.c:715:31: sparse:     got restricted __le32 [usertype]
>> drivers/soc/qcom/qmi_encdec.c:188:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/soc/qcom/qmi_encdec.c:188:25: sparse:     expected unsigned short [usertype]
   drivers/soc/qcom/qmi_encdec.c:188:25: sparse:     got restricted __le16 [usertype]
>> drivers/soc/qcom/qmi_encdec.c:191:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/soc/qcom/qmi_encdec.c:191:25: sparse:     expected unsigned int [usertype]
   drivers/soc/qcom/qmi_encdec.c:191:25: sparse:     got restricted __le32 [usertype]
>> drivers/soc/qcom/qmi_encdec.c:194:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __le64 [usertype] @@
   drivers/soc/qcom/qmi_encdec.c:194:25: sparse:     expected unsigned long long [usertype]
   drivers/soc/qcom/qmi_encdec.c:194:25: sparse:     got restricted __le64 [usertype]
   drivers/soc/qcom/qmi_encdec.c:485:25: sparse: sparse: cast to restricted __le16
   drivers/soc/qcom/qmi_encdec.c:485:25: sparse: sparse: cast to restricted __le16
   drivers/soc/qcom/qmi_encdec.c:485:25: sparse: sparse: cast to restricted __le16
   drivers/soc/qcom/qmi_encdec.c:485:25: sparse: sparse: cast to restricted __le16
>> drivers/soc/qcom/qmi_encdec.c:488:25: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/qmi_encdec.c:488:25: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/qmi_encdec.c:488:25: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/qmi_encdec.c:488:25: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/qmi_encdec.c:488:25: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/qmi_encdec.c:488:25: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64
>> drivers/soc/qcom/qmi_encdec.c:491:25: sparse: sparse: cast to restricted __le64

vim +188 drivers/soc/qcom/qmi_encdec.c

   161	
   162	/**
   163	 * qmi_encode_basic_elem() - Encodes elements of basic/primary data type
   164	 * @buf_dst: Buffer to store the encoded information.
   165	 * @buf_src: Buffer containing the elements to be encoded.
   166	 * @elem_len: Number of elements, in the buf_src, to be encoded.
   167	 * @elem_size: Size of a single instance of the element to be encoded.
   168	 *
   169	 * This function encodes the "elem_len" number of data elements, each of
   170	 * size "elem_size" bytes from the source buffer "buf_src" and stores the
   171	 * encoded information in the destination buffer "buf_dst". The elements are
   172	 * of primary data type which include u8 - u64 or similar. This
   173	 * function returns the number of bytes of encoded information.
   174	 *
   175	 * Return: The number of bytes of encoded information.
   176	 */
   177	static int qmi_encode_basic_elem(void *buf_dst, const void *buf_src,
   178					 u32 elem_len, u32 elem_size)
   179	{
   180		u32 i, rc = 0;
   181	
   182		for (i = 0; i < elem_len; i++) {
   183			switch (elem_size) {
   184			case sizeof(u8):
   185				QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u8);
   186				break;
   187			case sizeof(u16):
 > 188				QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u16);
   189				break;
   190			case sizeof(u32):
 > 191				QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u32);
   192				break;
   193			case sizeof(u64):
 > 194				QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u64);
   195				break;
   196			}
   197	
   198			rc += elem_size;
   199		}
   200	
   201		return rc;
   202	}
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

