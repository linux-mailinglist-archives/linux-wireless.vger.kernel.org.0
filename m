Return-Path: <linux-wireless+bounces-12118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D58962160
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF930281468
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBC1607A7;
	Wed, 28 Aug 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2ar1Yok"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1715F3E6;
	Wed, 28 Aug 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830611; cv=none; b=AzCHQndHG4tzVrHL2wF/X+x/YTGeKa1ACEV8IrkQDMcfRH1HFZbxiYWkvP01RklDf3Equo3hiqTlgXEKjLVekxs2xNYSVtSUrwz7xtRUF2rnLqwqRjpDTnTKsf5cmb5NX2IcP7BZprIuZ0O9WG/c5gDeTvXfsFEhJYhwBFKIOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830611; c=relaxed/simple;
	bh=/xq+keQ9L4ZNt85CyDSNycADysq9RCBUiBxhtxa/Iwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7B7Pqc62m+pvxfblADHDc9bcUPu8PxUFqZpUiu8XNKD5/i358YzGAM3QdB3sQdrx6EY8Tj1yv92f0xeoSioOEaafDMAqg1igVO8ludvFM8ILJBmXHwxZfoQF3uX5aErje0QIOYnFRBW5F1GdYuLM+d4m+msgH22dEvzDj3Ue9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2ar1Yok; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724830610; x=1756366610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xq+keQ9L4ZNt85CyDSNycADysq9RCBUiBxhtxa/Iwk=;
  b=H2ar1Yok25pi+Kjooqsv1UczyAUUlNoP8bWM4FBSDuXXlf2rKPyeXym4
   jqA6UcFci2qzgKZnw1yoSHKHKABImBJ9G6xqR3YWbq+wSCmvrLs/2AZ/a
   qhbdbcU7IYn7pKk5IEuQ9B0RaLELQ32DVviI7p8ft/0FhNHvQ6IJ2XDhE
   0nX990KVtMq6JUOpAcr0cTQPt0Btt1zVS1vt5Ov5sOvW9TmaVrjv38CN7
   x64pK57CAiOF74wYbPiYiDBt0/n/qPXcdYv2zkPLDZsEQwNeT6Z0o4M3L
   9ReesIR2X04F0GLeIhk+DVHkaeEE4lKHasXeN76D/IN3npLtSjt844LhP
   Q==;
X-CSE-ConnectionGUID: 2o/aJOm2S6anlSvglcOjhA==
X-CSE-MsgGUID: oAsKtUhtT++quR74AO8GTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23505455"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="23505455"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 00:36:49 -0700
X-CSE-ConnectionGUID: FA6h6co/QC6+TreJRX3JCw==
X-CSE-MsgGUID: rt6KCRb7RfqPS0cb8yUseA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63475108"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Aug 2024 00:36:45 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjDEQ-000Kbk-0Y;
	Wed, 28 Aug 2024 07:36:42 +0000
Date: Wed, 28 Aug 2024 15:36:28 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allison.henderson@oracle.com, dsahern@kernel.org,
	pshelar@ovn.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, dccp@vger.kernel.org, dev@openvswitch.org,
	linux-afs@lists.infradead.org, lihongbo22@huawei.com
Subject: Re: [PATCH net-next 4/8] net/core: Use min()/max() to simplify the
 code
Message-ID: <202408281516.thVNxpEo-lkp@intel.com>
References: <20240824074033.2134514-5-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824074033.2134514-5-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/net-mac80211-use-max-to-simplify-the-code/20240826-154029
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240824074033.2134514-5-lihongbo22%40huawei.com
patch subject: [PATCH net-next 4/8] net/core: Use min()/max() to simplify the code
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240828/202408281516.thVNxpEo-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408281516.thVNxpEo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408281516.thVNxpEo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/pktgen.c:126:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/core/pktgen.c:129:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/core/pktgen.c:129:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/core/pktgen.c:129:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> net/core/pktgen.c:2796:14: error: call to '__compiletime_assert_743' declared with 'error' attribute: min(datalen/frags, (1UL << 12)) signedness error
    2796 |                 frag_len = min(datalen/frags, PAGE_SIZE);
         |                            ^
   include/linux/minmax.h:129:19: note: expanded from macro 'min'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^
   include/linux/minmax.h:105:2: note: expanded from macro '__careful_cmp'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^
   include/linux/minmax.h:100:2: note: expanded from macro '__careful_cmp_once'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |         ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:6:1: note: expanded from here
       6 | __compiletime_assert_743
         | ^
   7 warnings and 1 error generated.


vim +2796 net/core/pktgen.c

  2769	
  2770	static void pktgen_finalize_skb(struct pktgen_dev *pkt_dev, struct sk_buff *skb,
  2771					int datalen)
  2772	{
  2773		struct timespec64 timestamp;
  2774		struct pktgen_hdr *pgh;
  2775	
  2776		pgh = skb_put(skb, sizeof(*pgh));
  2777		datalen -= sizeof(*pgh);
  2778	
  2779		if (pkt_dev->nfrags <= 0) {
  2780			skb_put_zero(skb, datalen);
  2781		} else {
  2782			int frags = pkt_dev->nfrags;
  2783			int i, len;
  2784			int frag_len;
  2785	
  2786	
  2787			if (frags > MAX_SKB_FRAGS)
  2788				frags = MAX_SKB_FRAGS;
  2789			len = datalen - frags * PAGE_SIZE;
  2790			if (len > 0) {
  2791				skb_put_zero(skb, len);
  2792				datalen = frags * PAGE_SIZE;
  2793			}
  2794	
  2795			i = 0;
> 2796			frag_len = min(datalen/frags, PAGE_SIZE);
  2797			while (datalen > 0) {
  2798				if (unlikely(!pkt_dev->page)) {
  2799					int node = numa_node_id();
  2800	
  2801					if (pkt_dev->node >= 0 && (pkt_dev->flags & F_NODE))
  2802						node = pkt_dev->node;
  2803					pkt_dev->page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
  2804					if (!pkt_dev->page)
  2805						break;
  2806				}
  2807				get_page(pkt_dev->page);
  2808	
  2809				/*last fragment, fill rest of data*/
  2810				if (i == (frags - 1))
  2811					skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
  2812								pkt_dev->page, 0,
  2813								min(datalen, PAGE_SIZE));
  2814				else
  2815					skb_frag_fill_page_desc(&skb_shinfo(skb)->frags[i],
  2816								pkt_dev->page, 0, frag_len);
  2817	
  2818				datalen -= skb_frag_size(&skb_shinfo(skb)->frags[i]);
  2819				skb->len += skb_frag_size(&skb_shinfo(skb)->frags[i]);
  2820				skb->data_len += skb_frag_size(&skb_shinfo(skb)->frags[i]);
  2821				i++;
  2822				skb_shinfo(skb)->nr_frags = i;
  2823			}
  2824		}
  2825	
  2826		/* Stamp the time, and sequence number,
  2827		 * convert them to network byte order
  2828		 */
  2829		pgh->pgh_magic = htonl(PKTGEN_MAGIC);
  2830		pgh->seq_num = htonl(pkt_dev->seq_num);
  2831	
  2832		if (pkt_dev->flags & F_NO_TIMESTAMP) {
  2833			pgh->tv_sec = 0;
  2834			pgh->tv_usec = 0;
  2835		} else {
  2836			/*
  2837			 * pgh->tv_sec wraps in y2106 when interpreted as unsigned
  2838			 * as done by wireshark, or y2038 when interpreted as signed.
  2839			 * This is probably harmless, but if anyone wants to improve
  2840			 * it, we could introduce a variant that puts 64-bit nanoseconds
  2841			 * into the respective header bytes.
  2842			 * This would also be slightly faster to read.
  2843			 */
  2844			ktime_get_real_ts64(&timestamp);
  2845			pgh->tv_sec = htonl(timestamp.tv_sec);
  2846			pgh->tv_usec = htonl(timestamp.tv_nsec / NSEC_PER_USEC);
  2847		}
  2848	}
  2849	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

