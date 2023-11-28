Return-Path: <linux-wireless+bounces-177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B27FC9F2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 23:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E253B21A2B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9915027A;
	Tue, 28 Nov 2023 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h13GWqP4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461EC83;
	Tue, 28 Nov 2023 14:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701211873; x=1732747873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BfsQFqH8yTLhtbLWXXB3YNrz20Sdtdytf4Ae2smnkM=;
  b=h13GWqP4C9I+WmCOPDSL9+UpD/oQ3yrLvzcRHPV80KNYgclESJZVkmBs
   TvWbHSHfjBbWZvJYhPmUmMueFWEzEHZarxY9RiWtWZptmzn8Oajr7DW8o
   FeTSmQ8XRH3d4/0cvwWXmXewiMxx5jCFCLsabzQ0GGywXMnPIPkE+zTNY
   C+ZaXdFSYbV/ZEeO1QdhijjD+UzuTormYy7Hg7xojhtO8QBwlOGycXyiE
   aCQ34d7qxvIpzciJpGo+gFMedhlGfs4wH81xE6i0YJKjTkJXK+9vyFqSc
   KUU6kzFKIicEsnKYvXDjv7sCVWhpkEMYZVDfmv8CpI8OC6+kw/rSb6ivC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392797073"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="392797073"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="942106672"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="942106672"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2023 14:51:09 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r86v4-0008E8-2Q;
	Tue, 28 Nov 2023 22:51:06 +0000
Date: Wed, 29 Nov 2023 06:51:01 +0800
From: kernel test robot <lkp@intel.com>
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH v7 01/12] wifi: mwifiex: added code to support host mlme.
Message-ID: <202311290333.3zOCFRnN-lkp@intel.com>
References: <20231128083115.613235-2-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-2-yu-hao.lin@nxp.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lin/wifi-mwifiex-added-code-to-support-host-mlme/20231128-165820
base:   783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
patch link:    https://lore.kernel.org/r/20231128083115.613235-2-yu-hao.lin%40nxp.com
patch subject: [PATCH v7 01/12] wifi: mwifiex: added code to support host mlme.
config: parisc-randconfig-r112-20231128 (https://download.01.org/0day-ci/archive/20231129/202311290333.3zOCFRnN-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311290333.3zOCFRnN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290333.3zOCFRnN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/marvell/mwifiex/uap_cmd.c:754:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] size @@     got unsigned int @@
   drivers/net/wireless/marvell/mwifiex/uap_cmd.c:754:19: sparse:     expected restricted __le16 [usertype] size
   drivers/net/wireless/marvell/mwifiex/uap_cmd.c:754:19: sparse:     got unsigned int
>> drivers/net/wireless/marvell/mwifiex/uap_cmd.c:757:76: sparse: sparse: restricted __le16 degrades to integer
>> drivers/net/wireless/marvell/mwifiex/uap_cmd.c:761:27: sparse: sparse: bad assignment (+=) to restricted __le16
>> drivers/net/wireless/marvell/mwifiex/uap_cmd.c:764:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] size @@
   drivers/net/wireless/marvell/mwifiex/uap_cmd.c:764:21: sparse:     expected unsigned short [usertype] val
   drivers/net/wireless/marvell/mwifiex/uap_cmd.c:764:21: sparse:     got restricted __le16 [usertype] size
>> drivers/net/wireless/marvell/mwifiex/uap_cmd.c:764:21: sparse: sparse: cast from restricted __le16
>> drivers/net/wireless/marvell/mwifiex/uap_cmd.c:764:21: sparse: sparse: cast from restricted __le16

vim +754 drivers/net/wireless/marvell/mwifiex/uap_cmd.c

   745	
   746	/* This function prepares AP start up command with or without host MLME
   747	 */
   748	static int mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
   749					     struct host_cmd_ds_command *cmd)
   750	{
   751		struct mwifiex_ie_types_host_mlme *tlv;
   752	
   753		cmd->command = cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
 > 754		cmd->size = S_DS_GEN;
   755	
   756		if (priv->adapter->host_mlme) {
 > 757			tlv = (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + cmd->size);
   758			tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
   759			tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
   760			tlv->host_mlme = 1;
 > 761			cmd->size += sizeof(struct mwifiex_ie_types_host_mlme);
   762		}
   763	
 > 764		cmd->size = cpu_to_le16(cmd->size);
   765	
   766		return 0;
   767	}
   768	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

