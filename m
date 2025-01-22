Return-Path: <linux-wireless+bounces-17811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E8A189A0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 02:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C90F16631B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8B06A8D2;
	Wed, 22 Jan 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtL47FYz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849897462
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737510006; cv=none; b=FA3EuaytCC88xE3Jkq2RUomElvNvbTl7Eb8ihcJz3xiPkSlz+V1HbsTN1uFVHQZQI6fI6CgJOFKiPkrlRLqZJNxci7LAZm8sQSlUxbmXcngT8x9apuA3NHIXC9LhAFcFLrITJoAVnNFchfKb0ZvAFG3LrIbXAkbtwJtEcJYITVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737510006; c=relaxed/simple;
	bh=X8svDz7HtPQcW44cGU47R6oNOze1fOKboudbN+MY4wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP/B0gdbvhzK7pniVe0Ku+c9rKVieaZsnTWrl+8RU0cwovkaCO4DpbKOy3UWMbIFX4OMKetboPWSZixOo56+pKp1BxKbjqZyQJ6e0mQmNc6Uj9dnZqutX+5zp6swmcczM4TZaoTdQLW3yBu6CZ3RR+8ucX/1t49/pjUDEn60oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtL47FYz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737510004; x=1769046004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X8svDz7HtPQcW44cGU47R6oNOze1fOKboudbN+MY4wY=;
  b=QtL47FYzUjfb+QqEkfWS9BYRS6aqnS+udJ7MEBWU5N+MU2h8Uxdw8Ptg
   XfjyJP1JqRX23TBO+qrV8NEu+WE7Ph3of77ZLoN78+nRO7f0XD1t3enls
   RB72rsWkfSAbzMRow6Ym1GADscQaPNllnflHm7Sl7ibF6Vplrj1AoAfWE
   eQ80ckvpi2LULWAqbl+nxN9TumaeZYgIUITOPE1osLMx99KsrtByPJRC4
   VeaCwB447Ntfjx9VgFgbUSFL8VJo8Cv2SZIH68eqErZ9RuJqejNESoblL
   hMubLGLy27Ttnb7YPITZlx9z4vEitopH8cYN/S8KgCpwlGz2vmOrayYz4
   w==;
X-CSE-ConnectionGUID: 7Y/WfgPxSB2CUuZCcbMMfw==
X-CSE-MsgGUID: yv7q84nKShSIQrwzaItcvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49366758"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="49366758"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 17:40:04 -0800
X-CSE-ConnectionGUID: wuHn2nd+Rk+Hj1FK4AmuRw==
X-CSE-MsgGUID: PWNJUa90RTefNNVdM3knSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="106900654"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Jan 2025 17:40:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taPip-000ZGJ-2h;
	Wed, 22 Jan 2025 01:39:59 +0000
Date: Wed, 22 Jan 2025 09:39:39 +0800
From: kernel test robot <lkp@intel.com>
To: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
	ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Rajat Soni <rajat.soni@oss.qualcomm.com>,
	Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Subject: Re: [PATCH v3] wifi: ath12k: Add WMI control path stats infra
Message-ID: <202501220916.o70hNSkA-lkp@intel.com>
References: <20250120184447.658660-1-ramya.gnanasekar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120184447.658660-1-ramya.gnanasekar@oss.qualcomm.com>

Hi Ramya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d7bef42fc98f2d8f67546d1ea1a3f2c2932fd72b]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramya-Gnanasekar/wifi-ath12k-Add-WMI-control-path-stats-infra/20250121-024618
base:   d7bef42fc98f2d8f67546d1ea1a3f2c2932fd72b
patch link:    https://lore.kernel.org/r/20250120184447.658660-1-ramya.gnanasekar%40oss.qualcomm.com
patch subject: [PATCH v3] wifi: ath12k: Add WMI control path stats infra
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250122/202501220916.o70hNSkA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project c23f2417dc5f6dc371afb07af5627ec2a9d373a0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250122/202501220916.o70hNSkA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501220916.o70hNSkA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath12k/wmi.c:6:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/ath/ath12k/wmi.c:6:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/ath/ath12k/wmi.c:6:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/wireless/ath/ath12k/wmi.c:7504:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
    7504 |         case WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:7518:9: note: uninitialized use occurs here
    7518 |         return ret;
         |                ^~~
   drivers/net/wireless/ath/ath12k/wmi.c:7501:9: note: initialize the variable 'ret' to silence this warning
    7501 |         int ret;
         |                ^
         |                 = 0
>> drivers/net/wireless/ath/ath12k/wmi.c:7597:7: warning: variable 'ar' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    7597 |                 if (!param.ar)
         |                     ^~~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:7638:16: note: uninitialized use occurs here
    7638 |         spin_lock_bh(&ar->debug.wmi_ctrl_path_stats_lock);
         |                       ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7597:3: note: remove the 'if' if its condition is always true
    7597 |                 if (!param.ar)
         |                 ^~~~~~~~~~~~~~
    7598 |                         return;
   drivers/net/wireless/ath/ath12k/wmi.c:7562:19: note: initialize the variable 'ar' to silence this warning
    7562 |         struct ath12k *ar;
         |                          ^
         |                           = NULL
   14 warnings generated.


vim +/ret +7504 drivers/net/wireless/ath/ath12k/wmi.c

  7496	
  7497	static int ath12k_wmi_ctrl_stats_subtlv_parser(struct ath12k_base *ab,
  7498						       u16 tag, u16 len,
  7499						       const void *ptr, void *data)
  7500	{
  7501		int ret;
  7502	
  7503		switch (tag) {
> 7504		case WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM:
  7505			break;
  7506		case WMI_TAG_CTRL_PATH_PDEV_STATS:
  7507			ret = wmi_pull_ctrl_path_pdev_tx_stats_tlv(ab, len, ptr, data);
  7508			break;
  7509			/* Add case for newly wmi ctrl path added stats here */
  7510		default:
  7511			ath12k_warn(ab,
  7512				    "Received invalid tag for wmi ctrl path stats in subtlvs, tag : 0x%x\n",
  7513				    tag);
  7514			ret = -EINVAL;
  7515			break;
  7516		}
  7517	
  7518		return ret;
  7519	}
  7520	
  7521	static int ath12k_wmi_ctrl_stats_event_parser(struct ath12k_base *ab,
  7522						      u16 tag, u16 len,
  7523						      const void *ptr, void *data)
  7524	{
  7525		int ret;
  7526	
  7527		ath12k_dbg(ab, ATH12K_DBG_WMI, "wmi ctrl path stats tag 0x%x of len %d rcvd\n",
  7528			   tag, len);
  7529	
  7530		switch (tag) {
  7531		case WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM:
  7532			/* Fixed param is already processed*/
  7533			ret = 0;
  7534			break;
  7535		case WMI_TAG_ARRAY_STRUCT:
  7536			/* len 0 is expected for array of struct when there
  7537			 * is no content of that type to pack inside that tlv
  7538			 */
  7539			if (len == 0)
  7540				return 0;
  7541	
  7542			ret = ath12k_wmi_tlv_iter(ab, ptr, len,
  7543						  ath12k_wmi_ctrl_stats_subtlv_parser,
  7544						  data);
  7545			break;
  7546		default:
  7547			ath12k_warn(ab, "Received invalid tag for wmi ctrl path stats\n");
  7548			ret = -EINVAL;
  7549			break;
  7550		}
  7551	
  7552		return ret;
  7553	}
  7554	
  7555	static void ath12k_wmi_ctrl_path_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
  7556	{
  7557		struct wmi_ctrl_path_stats_event *fixed_param;
  7558		struct ath12k_wmi_ctrl_path_stats_list param = {0};
  7559		struct ath12k_wmi_ctrl_path_stats_list *stats;
  7560		const struct wmi_tlv *tlv;
  7561		struct list_head *src, *dst;
  7562		struct ath12k *ar;
  7563		void *ptr = skb->data;
  7564		u16 tlv_tag, tag_id;
  7565		u32 more;
  7566		int ret;
  7567	
  7568		if (!skb->data) {
  7569			ath12k_warn(ab, "No data present in wmi ctrl stats event\n");
  7570			return;
  7571		}
  7572	
  7573		if (skb->len < (sizeof(*fixed_param) + TLV_HDR_SIZE)) {
  7574			ath12k_warn(ab, "wmi ctrl stats event size invalid\n");
  7575			return;
  7576		}
  7577	
  7578		param.ar = NULL;
  7579	
  7580		tlv = ptr;
  7581		tlv_tag = le32_get_bits(tlv->header, WMI_TLV_TAG);
  7582		ptr += sizeof(*tlv);
  7583	
  7584		if (tlv_tag != WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM) {
  7585			ath12k_warn(ab, "wmi ctrl stats without fixed param tlv at start\n");
  7586			return;
  7587		}
  7588	
  7589		INIT_LIST_HEAD(&param.pdev_stats);
  7590	
  7591		fixed_param = ptr;
  7592		ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
  7593					  ath12k_wmi_ctrl_stats_event_parser,
  7594					  &param);
  7595		if (ret) {
  7596			ath12k_warn(ab, "failed to parse wmi_ctrl_path_stats tlv: %d\n", ret);
> 7597			if (!param.ar)
  7598				return;
  7599			goto free;
  7600		}
  7601	
  7602		ar = param.ar;
  7603		if (!ar)
  7604			return;
  7605	
  7606		tag_id = ar->debug.wmi_ctrl_path_stats_tagid;
  7607		stats = &ar->debug.wmi_ctrl_path_stats;
  7608		more = __le32_to_cpu(fixed_param->more);
  7609	
  7610		switch (tag_id) {
  7611		case WMI_TAG_CTRL_PATH_PDEV_STATS:
  7612			src = &param.pdev_stats;
  7613			dst = &stats->pdev_stats;
  7614			break;
  7615		default:
  7616			goto free;
  7617		}
  7618	
  7619		spin_lock_bh(&ar->debug.wmi_ctrl_path_stats_lock);
  7620		if (!more) {
  7621			if (!ar->debug.wmi_ctrl_path_stats_more_enabled)
  7622				ath12k_wmi_ctrl_path_stats_list_free(stats);
  7623			else
  7624				ar->debug.wmi_ctrl_path_stats_more_enabled = false;
  7625	
  7626			list_splice_tail_init(src, dst);
  7627			complete(&ar->debug.wmi_ctrl_path_stats_rcvd);
  7628		} else {
  7629			if (!ar->debug.wmi_ctrl_path_stats_more_enabled) {
  7630				ath12k_wmi_ctrl_path_stats_list_free(stats);
  7631				ar->debug.wmi_ctrl_path_stats_more_enabled = true;
  7632			}
  7633			list_splice_tail_init(src, dst);
  7634		}
  7635		spin_unlock_bh(&ar->debug.wmi_ctrl_path_stats_lock);
  7636		return;
  7637	free:
  7638		spin_lock_bh(&ar->debug.wmi_ctrl_path_stats_lock);
  7639		ath12k_wmi_ctrl_path_stats_list_free(&param);
  7640		spin_unlock_bh(&ar->debug.wmi_ctrl_path_stats_lock);
  7641	}
  7642	#else
  7643	static void ath12k_wmi_ctrl_path_stats_event(struct ath12k_base *ab,
  7644						     struct sk_buff *skb)
  7645	{
  7646	}
  7647	#endif /* CONFIG_ATH12K_DEBUGFS */
  7648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

