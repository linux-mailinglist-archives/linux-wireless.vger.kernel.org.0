Return-Path: <linux-wireless+bounces-3388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177884F4D9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 12:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07042832EF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B52E40D;
	Fri,  9 Feb 2024 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3Yz7oRJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9F2D05B
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479668; cv=none; b=KbcXLovOaq/zznG4547pnXF4y8cw/Fh2rdyI/RBEI9RbT5X7Dk6YiPTs59+WZz+uap8ajtVoarjMVSvwpN52OqWBZfP/SXiFTIhd1nmeeViBBZ2Tq7c8B7UDj1pOIi7dlF2FNL+nVGNJ291yXAsU79bxlC8+slGnQoi1vGRpppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479668; c=relaxed/simple;
	bh=1tg2ZQsPNiTX9bLV9ejW+T1gcQKjTAmtU84wJculzqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eVr5D7ekCNlKHFebXULcpQyNlhuMN03c/lIhk1C5RJ8UGmg5YVxowLuCoUxZwCTiNlTsSLzAcPK5dacm+q5y/rXzR2iCCOxvTcm/ZMka3bo4JQVfxTW4mvxtf/fnm0HOdJYzDY4vLGQeRINwa8O0t5bRp6pjskupQpwSxLmy2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3Yz7oRJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707479666; x=1739015666;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1tg2ZQsPNiTX9bLV9ejW+T1gcQKjTAmtU84wJculzqs=;
  b=G3Yz7oRJ2AefHXd0JJRxbLdddVSlicVbfznS3fCCBVhxw16+5fpJUW8P
   jFhRgI8qmKdiwhDwX84q/NKVDecxP5+7vyqUZZcQSvhDuGTmfKJ3WTA9c
   xBEXkViqoJn2jFOm6CJpkSHoZCZAeb2d+Y8vV0WN37OfDnjSbQidkQgwj
   ZPuvzfwVuTz1NQv9qFgeeHICyZvR4r2pCn3PU/fSByAiSjuoI2M0Vb/gj
   l7u3hoYwkPjXv1HcEw518S/Qkm1SKFOXMjIrzg/AWS7PtpaoohyISe3RE
   d9bjTn+zxFF/V+l76ZeTkh1ivjzonGC1fl2LD39uc42UsecITwMfP0++8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1555290"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1555290"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 03:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1906510"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Feb 2024 03:54:24 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYPSX-0004gM-2A;
	Fri, 09 Feb 2024 11:54:21 +0000
Date: Fri, 9 Feb 2024 19:53:44 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [wireless-next:main 62/81]
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c:359:6: error: redefinition of
 'iwl_uefi_get_sgom_table'
Message-ID: <202402091914.TvQ2OSQY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   d4655db0a1e11eeacc55c44c81121c83b087982e
commit: 74f4cd71070538bd9a8b6686fc53e7b77d510afa [62/81] wifi: iwlwifi: take SGOM and UATS code out of ACPI ifdef
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240209/202402091914.TvQ2OSQY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402091914.TvQ2OSQY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402091914.TvQ2OSQY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/fw/uefi.c:359:6: error: redefinition of 'iwl_uefi_get_sgom_table'
     359 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/intel/iwlwifi/fw/uefi.c:11:
   drivers/net/wireless/intel/iwlwifi/fw/uefi.h:294:6: note: previous definition of 'iwl_uefi_get_sgom_table' with type 'void(struct iwl_trans *, struct iwl_fw_runtime *)'
     294 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/fw/uefi.c:392:5: error: redefinition of 'iwl_uefi_get_uats_table'
     392 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/fw/uefi.h:299:5: note: previous definition of 'iwl_uefi_get_uats_table' with type 'int(struct iwl_trans *, struct iwl_fw_runtime *)'
     299 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/iwl_uefi_get_sgom_table +359 drivers/net/wireless/intel/iwlwifi/fw/uefi.c

c593d2fae592ae Ayala Barazani   2021-12-04  358  
c593d2fae592ae Ayala Barazani   2021-12-04 @359  void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
c593d2fae592ae Ayala Barazani   2021-12-04  360  			     struct iwl_fw_runtime *fwrt)
c593d2fae592ae Ayala Barazani   2021-12-04  361  {
c593d2fae592ae Ayala Barazani   2021-12-04  362  	struct uefi_cnv_wlan_sgom_data *data;
0c4bad7f47c4e5 Ard Biesheuvel   2022-06-17  363  	int ret;
c593d2fae592ae Ayala Barazani   2021-12-04  364  
8ae3e23195188a Gregory Greenman 2023-06-06  365  	if (!fwrt->geo_enabled)
c593d2fae592ae Ayala Barazani   2021-12-04  366  		return;
c593d2fae592ae Ayala Barazani   2021-12-04  367  
a6dfe1e7440308 Miri Korenblit   2024-01-28  368  	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_SGOM_NAME,
a6dfe1e7440308 Miri Korenblit   2024-01-28  369  					      "SGOM", sizeof(*data), NULL);
a6dfe1e7440308 Miri Korenblit   2024-01-28  370  	if (IS_ERR(data))
0c4bad7f47c4e5 Ard Biesheuvel   2022-06-17  371  		return;
c593d2fae592ae Ayala Barazani   2021-12-04  372  
c593d2fae592ae Ayala Barazani   2021-12-04  373  	ret = iwl_uefi_sgom_parse(data, fwrt);
c593d2fae592ae Ayala Barazani   2021-12-04  374  	if (ret < 0)
c593d2fae592ae Ayala Barazani   2021-12-04  375  		IWL_DEBUG_FW(trans, "Cannot read SGOM tables. rev is invalid\n");
c593d2fae592ae Ayala Barazani   2021-12-04  376  
c593d2fae592ae Ayala Barazani   2021-12-04  377  	kfree(data);
c593d2fae592ae Ayala Barazani   2021-12-04  378  }
c593d2fae592ae Ayala Barazani   2021-12-04  379  IWL_EXPORT_SYMBOL(iwl_uefi_get_sgom_table);
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  380  
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  381  static int iwl_uefi_uats_parse(struct uefi_cnv_wlan_uats_data *uats_data,
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  382  			       struct iwl_fw_runtime *fwrt)
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  383  {
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  384  	if (uats_data->revision != 1)
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  385  		return -EINVAL;
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  386  
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  387  	memcpy(fwrt->uats_table.offset_map, uats_data->offset_map,
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  388  	       sizeof(fwrt->uats_table.offset_map));
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  389  	return 0;
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  390  }
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  391  
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22 @392  int iwl_uefi_get_uats_table(struct iwl_trans *trans,
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  393  			    struct iwl_fw_runtime *fwrt)
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  394  {
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  395  	struct uefi_cnv_wlan_uats_data *data;
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  396  	int ret;
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  397  
a6dfe1e7440308 Miri Korenblit   2024-01-28  398  	data = iwl_uefi_get_verified_variable(trans, IWL_UEFI_UATS_NAME,
a6dfe1e7440308 Miri Korenblit   2024-01-28  399  					      "UATS", sizeof(*data), NULL);
a6dfe1e7440308 Miri Korenblit   2024-01-28  400  	if (IS_ERR(data))
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  401  		return -EINVAL;
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  402  
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  403  	ret = iwl_uefi_uats_parse(data, fwrt);
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  404  	if (ret < 0) {
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  405  		IWL_DEBUG_FW(trans, "Cannot read UATS table. rev is invalid\n");
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  406  		kfree(data);
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  407  		return ret;
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  408  	}
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  409  
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  410  	kfree(data);
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  411  	return 0;
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  412  }
4a9bb5b4d94999 Mukesh Sisodiya  2023-10-22  413  IWL_EXPORT_SYMBOL(iwl_uefi_get_uats_table);
427661e4c48887 Miri Korenblit   2024-01-31  414  

:::::: The code at line 359 was first introduced by commit
:::::: c593d2fae592aefaec86f012e1354400b8ac4715 iwlwifi: support SAR GEO Offset Mapping override via BIOS

:::::: TO: Ayala Barazani <ayala.barazani@intel.com>
:::::: CC: Luca Coelho <luciano.coelho@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

