Return-Path: <linux-wireless+bounces-27682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA366BA6C50
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B64189B2BC
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D105A29E11E;
	Sun, 28 Sep 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F82fZ/Ov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E6220F29
	for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049903; cv=none; b=j+oE2RkNW+9dV2yUrvrdqb4LoHVQKYM+hUwpmRi6wItAqhfj/hn1IX9ulfEWyvLx5lmgQcvZy1VscWfatjGwB6yrkBgLa0YIeKkxweBtTGpwh/EiJ5rn2hc+IcmWrWOqbd0ohnjq9w/5F3j/4sWFluLp0dFCddD3IwpO/fRTEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049903; c=relaxed/simple;
	bh=n/CYU6XJ7EXuyYL/4R8INs3KNybIO1oJqRqDiB1jhAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CseZ/yPAD6axUORMVuDhfJyw4Z2a05qNBDqv9/+ykq5Z8IbV9OGXa8thet6i6R1iDaxpfdEaaJ9pwlpiliZ3sMlTW969NQn2J+Aj6E9Y/naeG/+IsND7HLgRNqJWSveCwjbMkX0lcPwNiE2oCDJ+rsoH+3MJ22IS0vZ0nWNi9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F82fZ/Ov; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759049901; x=1790585901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n/CYU6XJ7EXuyYL/4R8INs3KNybIO1oJqRqDiB1jhAM=;
  b=F82fZ/OvCWX9IKsM7qhNOq+ePyYXh+QIIez/lL8UIdr6fskq1Ea3Z/kZ
   y+uQ4os36w29x5TPPVwKI902frSyR/+qpOSh8aBtQX6Wwn+JvuViAYbgu
   umihyefW9V0tdqvleN69GZoOh0/fkt8RnYc9+OUUfgX9IwHfrIkkoTg9Y
   CPwnDsMmwJLxdH/kXZFk7wW68dShvbHnzRLl4qqXNIYLO+Ukx1OSUo0dK
   +TMXstlKh88RB4Fh2M09SWkceU8hisgNmrqylWeXIHicskh32tYXkKpR6
   g4u07LCO2HGkFHDD5f7/lJfsGPwduxrgI+Opgixx7Em5A+9OxoPlU4TVK
   w==;
X-CSE-ConnectionGUID: sr/7PKzDQJOQjPmr5NDnkg==
X-CSE-MsgGUID: o5bEPMCIQ7Cm66IZao3wyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="83932575"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="83932575"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 01:58:21 -0700
X-CSE-ConnectionGUID: FyDcOJrtQmKJYH43A1yfKQ==
X-CSE-MsgGUID: ysjf69TMRyysG77FYOM9dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="177243145"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2025 01:58:20 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2nEW-0007f1-1L;
	Sun, 28 Sep 2025 08:58:16 +0000
Date: Sun, 28 Sep 2025 16:57:17 +0800
From: kernel test robot <lkp@intel.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: Support for FTM TLV test commands
Message-ID: <202509281616.IKHm5zbZ-lkp@intel.com>
References: <20250926201303.194029-1-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926201303.194029-1-loic.poulain@oss.qualcomm.com>

Hi Loic,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ath/ath-next]
[also build test WARNING on wireless/main wireless-next/main linus/master v6.17-rc7 next-20250926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Loic-Poulain/wifi-ath10k-Support-for-FTM-TLV-test-commands/20250927-041539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20250926201303.194029-1-loic.poulain%40oss.qualcomm.com
patch subject: [PATCH ath-next] wifi: ath10k: Support for FTM TLV test commands
config: x86_64-randconfig-121-20250928 (https://download.01.org/0day-ci/archive/20250928/202509281616.IKHm5zbZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250928/202509281616.IKHm5zbZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509281616.IKHm5zbZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath10k/testmode.c:93:23: sparse: sparse: cast to restricted __le32
>> drivers/net/wireless/ath/ath10k/testmode.c:93:23: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/wireless/ath/ath10k/testmode.c:93:23: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/wireless/ath/ath10k/testmode.c:94:26: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/ath/ath10k/testmode.c:94:26: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/wireless/ath/ath10k/testmode.c:94:26: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/wireless/ath/ath10k/testmode.c:585:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] tlv_header @@     got unsigned int [assigned] [usertype] hdr_info @@
   drivers/net/wireless/ath/ath10k/testmode.c:585:37: sparse:     expected restricted __le32 [usertype] tlv_header
   drivers/net/wireless/ath/ath10k/testmode.c:585:37: sparse:     got unsigned int [assigned] [usertype] hdr_info
>> drivers/net/wireless/ath/ath10k/testmode.c:586:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] len @@     got unsigned short [assigned] [usertype] total_bytes @@
   drivers/net/wireless/ath/ath10k/testmode.c:586:38: sparse:     expected restricted __le32 [usertype] len
   drivers/net/wireless/ath/ath10k/testmode.c:586:38: sparse:     got unsigned short [assigned] [usertype] total_bytes
>> drivers/net/wireless/ath/ath10k/testmode.c:587:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] msgref @@     got unsigned char [usertype] ftm_msgref @@
   drivers/net/wireless/ath/ath10k/testmode.c:587:41: sparse:     expected restricted __le32 [usertype] msgref
   drivers/net/wireless/ath/ath10k/testmode.c:587:41: sparse:     got unsigned char [usertype] ftm_msgref
>> drivers/net/wireless/ath/ath10k/testmode.c:590:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] segmentinfo @@     got unsigned char [assigned] [usertype] seginfo @@
   drivers/net/wireless/ath/ath10k/testmode.c:590:46: sparse:     expected restricted __le32 [usertype] segmentinfo
   drivers/net/wireless/ath/ath10k/testmode.c:590:46: sparse:     got unsigned char [assigned] [usertype] seginfo

vim +93 drivers/net/wireless/ath/ath10k/testmode.c

    77	
    78	static void ath10k_tm_event_segmented(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
    79	{
    80		struct wmi_ftm_cmd *ftm = (struct wmi_ftm_cmd *)skb->data;
    81		u8 total_segments, current_seq;
    82		struct sk_buff *nl_skb;
    83		u8 const *buf_pos;
    84		u16 datalen;
    85		u32 data_pos;
    86		int ret;
    87	
    88		if (skb->len < sizeof(*ftm)) {
    89			ath10k_warn(ar, "Invalid ftm event length: %d\n", skb->len);
    90			return;
    91		}
    92	
  > 93		current_seq = FIELD_GET(ATH10K_FTM_SEGHDR_CURRENT_SEQ, ftm->seg_hdr.segmentinfo);
    94		total_segments = FIELD_GET(ATH10K_FTM_SEGHDR_TOTAL_SEGMENTS,
    95					   ftm->seg_hdr.segmentinfo);
    96		datalen = skb->len - sizeof(*ftm);
    97		buf_pos = ftm->data;
    98	
    99		if (current_seq == 0) {
   100			ar->testmode.expected_seq = 0;
   101			ar->testmode.data_pos = 0;
   102		}
   103	
   104		data_pos = ar->testmode.data_pos;
   105	
   106		if ((data_pos + datalen) > ATH_FTM_EVENT_MAX_BUF_LENGTH) {
   107			ath10k_warn(ar, "Invalid ftm event length at %u: %u\n",
   108				    data_pos, datalen);
   109			ret = -EINVAL;
   110			return;
   111		}
   112	
   113		memcpy(&ar->testmode.eventdata[data_pos], buf_pos, datalen);
   114		data_pos += datalen;
   115	
   116		if (++ar->testmode.expected_seq != total_segments) {
   117			ar->testmode.data_pos = data_pos;
   118			ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "partial data received %u/%u\n",
   119				   current_seq + 1, total_segments);
   120			return;
   121		}
   122	
   123		ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "total data length %u\n", data_pos);
   124	
   125		nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
   126							   2 * sizeof(u32) + data_pos,
   127							   GFP_ATOMIC);
   128		if (!nl_skb) {
   129			ath10k_warn(ar, "failed to allocate skb for testmode wmi event\n");
   130			return;
   131		}
   132	
   133		ret = nla_put_u32(nl_skb, ATH10K_TM_ATTR_CMD, ATH10K_TM_CMD_TLV);
   134		if (ret) {
   135			ath10k_warn(ar, "failed to put testmode wmi event attribute: %d\n", ret);
   136			kfree_skb(nl_skb);
   137			return;
   138		}
   139	
   140		ret = nla_put_u32(nl_skb, ATH10K_TM_ATTR_WMI_CMDID, cmd_id);
   141		if (ret) {
   142			ath10k_warn(ar, "failed to put testmode wmi event cmd_id: %d\n", ret);
   143			kfree_skb(nl_skb);
   144			return;
   145		}
   146	
   147		ret = nla_put(nl_skb, ATH10K_TM_ATTR_DATA, data_pos, &ar->testmode.eventdata[0]);
   148		if (ret) {
   149			ath10k_warn(ar, "failed to copy skb to testmode wmi event: %d\n", ret);
   150			kfree_skb(nl_skb);
   151			return;
   152		}
   153	
   154		cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
   155	}
   156	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

