Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB548AD92
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 13:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiAKMZ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 07:25:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:39722 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239858AbiAKMZZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 07:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641903925; x=1673439925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kOjWqaiFV0550xr2J2a2u0K/5EnSRW3Wa7Fgol+iQZ8=;
  b=Hu8EmNEmGxNhRUIjs6Aju16b/rkabiWhwkWgaHXVvxiFJma+9u44ACDB
   eyNkfin8aHENJ6a/wvLuS7DgymGZQ5lWCpTSLE73/kT2OZjS8rAW30+mt
   2MQdAf2jbDNUn08Gs0c5bU5Ur3OMswWPwHX4x+UmXuzuzzYTPWIf+OONS
   t3lmlmRo+xMQ6JUYHSXilmrXiZIB6QcPCgoQuMcnoe6TATWFhCLN8lKwr
   dJjv/VGKkO0az8TiV6QL6SQRZ42ZqJjhm2uq6WYDi0GrV94qMS2Z1vCMr
   x8VRFRvIPB+ymkSkiCo6JTTQckByupHUbXxm9E0nFnxFIS6wffAokhkFy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242285049"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="242285049"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 04:25:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="490361877"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2022 04:25:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7GDL-0004s2-2K; Tue, 11 Jan 2022 12:25:23 +0000
Date:   Tue, 11 Jan 2022 20:25:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Seevalamuthu Mariappan <quic_seevalam@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: Re: [PATCH] ath11k: Add debugfs interface to configure firmware
 debug log level
Message-ID: <202201112056.3dHmkXvo-lkp@intel.com>
References: <1641793281-7957-1-git-send-email-quic_seevalam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641793281-7957-1-git-send-email-quic_seevalam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Seevalamuthu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kvalo-ath/ath-next]
[also build test ERROR on next-20220111]
[cannot apply to v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Seevalamuthu-Mariappan/ath11k-Add-debugfs-interface-to-configure-firmware-debug-log-level/20220110-134225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220111/202201112056.3dHmkXvo-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 84654f2733f63dc725a7b3d7c55d56849d2d9358)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bde7e10605a2c55ec1c333ad64e0f6e2634f4d4a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Seevalamuthu-Mariappan/ath11k-Add-debugfs-interface-to-configure-firmware-debug-log-level/20220110-134225
        git checkout bde7e10605a2c55ec1c333ad64e0f6e2634f4d4a
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath11k/wmi.c: In function 'ath11k_wmi_fw_dbglog_cfg':
>> drivers/net/wireless/ath/ath11k/wmi.c:7833:25: error: 'struct ath11k' has no member named 'debug'
    7833 |   memcpy(tlv->value, &ar->debug.module_id_bitmap,
         |                         ^~
   drivers/net/wireless/ath/ath11k/wmi.c:7836:13: error: 'struct ath11k' has no member named 'debug'
    7836 |   memset(&ar->debug.module_id_bitmap, 0,
         |             ^~


vim +7833 drivers/net/wireless/ath/ath11k/wmi.c

  7800	
  7801	int ath11k_wmi_fw_dbglog_cfg(struct ath11k *ar, struct ath11k_fw_dbglog *dbglog)
  7802	{
  7803		struct ath11k_pdev_wmi *wmi = ar->wmi;
  7804		struct wmi_debug_log_config_cmd_fixed_param *cmd;
  7805		struct sk_buff *skb;
  7806		struct wmi_tlv *tlv;
  7807		int ret, len;
  7808	
  7809		len = sizeof(*cmd) + TLV_HDR_SIZE + (MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
  7810		skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
  7811		if (!skb)
  7812			return -ENOMEM;
  7813	
  7814		cmd = (struct wmi_debug_log_config_cmd_fixed_param *)skb->data;
  7815		cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_DEBUG_LOG_CONFIG_CMD) |
  7816				  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
  7817		cmd->dbg_log_param = dbglog->param;
  7818	
  7819		tlv = (struct wmi_tlv *)((u8 *)cmd + sizeof(*cmd));
  7820		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_UINT32) |
  7821			      FIELD_PREP(WMI_TLV_LEN, MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
  7822	
  7823		switch (dbglog->param) {
  7824		case WMI_DEBUG_LOG_PARAM_LOG_LEVEL:
  7825		case WMI_DEBUG_LOG_PARAM_VDEV_ENABLE:
  7826		case WMI_DEBUG_LOG_PARAM_VDEV_DISABLE:
  7827		case WMI_DEBUG_LOG_PARAM_VDEV_ENABLE_BITMAP:
  7828			cmd->value = dbglog->value;
  7829			break;
  7830		case WMI_DEBUG_LOG_PARAM_MOD_ENABLE_BITMAP:
  7831		case WMI_DEBUG_LOG_PARAM_WOW_MOD_ENABLE_BITMAP:
  7832			cmd->value = dbglog->value;
> 7833			memcpy(tlv->value, &ar->debug.module_id_bitmap,
  7834			       MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
  7835			/* clear current config to be used for next user config */
  7836			memset(&ar->debug.module_id_bitmap, 0,
  7837			       MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
  7838			break;
  7839		default:
  7840			dev_kfree_skb(skb);
  7841			return -EINVAL;
  7842		}
  7843	
  7844		ret = ath11k_wmi_cmd_send(wmi, skb, WMI_DBGLOG_CFG_CMDID);
  7845		if (ret) {
  7846			ath11k_warn(ar->ab,
  7847				    "failed to send WMI_DBGLOG_CFG_CMDID\n");
  7848			dev_kfree_skb(skb);
  7849		}
  7850		return ret;
  7851	}
  7852	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
