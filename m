Return-Path: <linux-wireless+bounces-33963-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD/rGxYNxWkI6AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33963-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:40:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE93339A3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3E033033276
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7B3BED73;
	Thu, 26 Mar 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sh2ubX9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7616396D0A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521141; cv=none; b=MV+wumjYAEK1a7nrHeKOertj9gdhWz8qeQhrAF7nzZ6nv+NDuUMLzdg8sxZGLDn58iBK7X/xuO7as+2/I7IxUA8Ijxm7Jwoucw/8grIQx/9NlwJbDB1E/pX4x4PycM0n9f02Cw889O3EH55VamTwURHDEpuLjY3wiRTJxIg3KAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521141; c=relaxed/simple;
	bh=XLArEAmimxaRm+qdFedIgU5DmZ4+ND0uqiqPffSdh80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/0QhqACTtz1FxNYkEARXqo7BCNd7A3hpL8XJUTRhgaHdfIAcIx1iYNWfYrW8dltifjQNuYhOd2YUJMU5COS3j0zj8WmGMVroHV/GywWYWmEbszWuKEFVI9ZcVgya/pN5QvKncIomfxIiu+uopvKU/BRqtnP3ASHppkStPFxv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sh2ubX9I; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774521140; x=1806057140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XLArEAmimxaRm+qdFedIgU5DmZ4+ND0uqiqPffSdh80=;
  b=Sh2ubX9IPVjfzxJbXv32diF48cTeIypPaI0RK+DWqF0sp+iWLOLTDDxA
   2J3pKbHzBhmKgWXE05CdUizKyND7JsWu4HFTqWN0g6xModCse99Jbt/HT
   amGSAi6CgC1MRQFHNjyZ+9BeSOI5J+5xb1CgwMLtNUHMcjtj1UCkF3oi7
   GQhpj46WCD+j0XIPjy3jR1DDqLUKZnePyFZiw+s14jdaUcjsoCIUKRyBN
   iS7N2L7zQ6sGKzxB2idVXxCBOw6iRfZqYDiZlt41qO3SdP2IaDaksjbXP
   2UP555xHlvgpDBzCzx0VIT/qrzRzNhaBKfyFL6EzwMEYwKm4K45gBAXg/
   A==;
X-CSE-ConnectionGUID: pASTuaXuSvKFyiloLxCZuw==
X-CSE-MsgGUID: r4IleGMFSu2Aq1urW1PGqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75770229"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75770229"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:32:19 -0700
X-CSE-ConnectionGUID: ZzBQ2d0aRbWp7Idnj3yU9A==
X-CSE-MsgGUID: fcjuZRMlRTyM/BViI3pbvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="262879485"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Mar 2026 03:32:18 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5i0d-000000008lh-1OIb;
	Thu, 26 Mar 2026 10:32:15 +0000
Date: Thu, 26 Mar 2026 18:31:32 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Fill fw_version member of struct
 wiphy
Message-ID: <202603261814.fyYqPTNZ-lkp@intel.com>
References: <60bdb2f8-d5dd-46a3-8679-5b4a5fd0604b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bdb2f8-d5dd-46a3-8679-5b4a5fd0604b@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33963-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: DAFE93339A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bitterblue,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v7.0-rc5 next-20260325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtw89-Fill-fw_version-member-of-struct-wiphy/20260326-082721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/60bdb2f8-d5dd-46a3-8679-5b4a5fd0604b%40gmail.com
patch subject: [PATCH rtw-next] wifi: rtw89: Fill fw_version member of struct wiphy
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260326/202603261814.fyYqPTNZ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261814.fyYqPTNZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261814.fyYqPTNZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/fw.c:759:14: error: use of undeclared identifier 'RTW89_FW_NORMAL_B'
     759 |             type == RTW89_FW_NORMAL_B)
         |                     ^
   1 error generated.


vim +/RTW89_FW_NORMAL_B +759 drivers/net/wireless/realtek/rtw89/fw.c

   726	
   727	static int rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
   728				       enum rtw89_fw_type type,
   729				       struct rtw89_fw_suit *fw_suit)
   730	{
   731		const struct rtw89_fw_hdr *v0 = (const struct rtw89_fw_hdr *)fw_suit->data;
   732		const struct rtw89_fw_hdr_v1 *v1 = (const struct rtw89_fw_hdr_v1 *)fw_suit->data;
   733	
   734		if (type == RTW89_FW_LOGFMT)
   735			return 0;
   736	
   737		fw_suit->type = type;
   738		fw_suit->hdr_ver = le32_get_bits(v0->w3, FW_HDR_W3_HDR_VER);
   739	
   740		switch (fw_suit->hdr_ver) {
   741		case 0:
   742			rtw89_fw_update_ver_v0(rtwdev, fw_suit, v0);
   743			break;
   744		case 1:
   745			rtw89_fw_update_ver_v1(rtwdev, fw_suit, v1);
   746			break;
   747		default:
   748			rtw89_err(rtwdev, "Unknown firmware header version %u\n",
   749				  fw_suit->hdr_ver);
   750			return -ENOENT;
   751		}
   752	
   753		rtw89_info(rtwdev,
   754			   "Firmware version %u.%u.%u.%u (%08x), cmd version %u, type %u\n",
   755			   fw_suit->major_ver, fw_suit->minor_ver, fw_suit->sub_ver,
   756			   fw_suit->sub_idex, fw_suit->commitid, fw_suit->cmd_ver, type);
   757	
   758		if (type == RTW89_FW_NORMAL || type == RTW89_FW_NORMAL_CE ||
 > 759		    type == RTW89_FW_NORMAL_B)
   760			snprintf(rtwdev->hw->wiphy->fw_version,
   761				 sizeof(rtwdev->hw->wiphy->fw_version),
   762				 "%u.%u.%u.%u",
   763				 fw_suit->major_ver, fw_suit->minor_ver,
   764				 fw_suit->sub_ver, fw_suit->sub_idex);
   765	
   766		return 0;
   767	}
   768	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

