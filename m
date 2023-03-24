Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB186C7F7C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjCXOGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjCXOF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 10:05:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240F1B2FD
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679666701; x=1711202701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3nImKI8eGuJ2BCUd714yeyqn0z1Xx7ywtWUfvVU6L4=;
  b=Vd2hTW21T6H5GLFv+z4X4/mOFfJ5KqlnyCInws3np8ttg3c+Y14QmjzZ
   y3G885d7EdYCCFiB1f6GzmNMlKm2Xb3RTwf5V5OUCCIGTFv3Z3EZYnVcL
   PJp+A/5CX+HJOGv6AjQHHvMUU4Ab/0vY5TNOvLoQx2WC1wwumE0/M6IDH
   zQiLYaK4LZdtTi7I1E4FiezBZHG0mV4ibTisuCkX+2CLr/SDkPECTQKlB
   p5xtmKy8hF431MqRhXlhfZXJOkRdQL18mT9NyGDnF3va8qPN3eZEUcFyQ
   ca8skP9zhxVqpjadHh2p+k8HkEf72E4GC6tKbcl6PkxVuLZiKfanwM3aC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="426051922"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="426051922"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 07:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="856865022"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="856865022"
Received: from rosenbaf-mobl.ger.corp.intel.com (HELO [10.252.63.223]) ([10.252.63.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 07:04:58 -0700
Message-ID: <fecbddb2-e729-f9db-8426-a598348e26db@linux.intel.com>
Date:   Fri, 24 Mar 2023 16:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 7c4a254d78f89546d0e74a40617ef24c6151c8d1
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        amd-gfx@lists.freedesktop.org,
        sound-open-firmware@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <641cc5da.LRhzzaC4RvFK5EH/%lkp@intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <641cc5da.LRhzzaC4RvFK5EH/%lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 23/03/2023 23:34, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 7c4a254d78f89546d0e74a40617ef24c6151c8d1  Add linux-next specific files for 20230323
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202303161521.jbGbaFjJ-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202303231302.iY6qIfXA-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202303232154.aXOXAWhg-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
> drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> gpio.c:(.init.text+0xec): undefined reference to `of_mm_gpiochip_add_data'
> include/linux/mmzone.h:1749:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
> 
> Unverified Error/Warning (likely false positive, please contact us if interested):

...

> sound/soc/sof/ipc4-pcm.c:391 sof_ipc4_pcm_dai_link_fixup_rate() error: uninitialized symbol 'be_rate'.
> sound/soc/sof/ipc4-topology.c:1132 ipc4_copier_set_capture_fmt() error: uninitialized symbol 'sample_valid_bits'.

These are false positives, the copier which is used in these functions
always have input and output side, the be_rate will be initialized:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/sof/ipc4-pcm.c#n485
on the first iteration.

the sample_valid_bits will be initialized:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/sof/ipc4-topology.c#n1310
on the first iteration.

-- 
-- 
Péter
