Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2374E46788D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 14:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381133AbhLCNlh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 08:41:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:53177 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381136AbhLCNlg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 08:41:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="323227112"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="323227112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 05:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="513252843"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2021 05:38:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt8lO-000HdR-7k; Fri, 03 Dec 2021 13:38:10 +0000
Date:   Fri, 3 Dec 2021 21:37:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: Re: [PATCH] mac80211: disable BSS color collision detection in case
 of no free colors
Message-ID: <202112032136.n3Acqu0R-lkp@intel.com>
References: <1638506507-21139-1-git-send-email-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638506507-21139-1-git-send-email-quic_ramess@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Rameshkumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jberg-mac80211-next/master]
[also build test WARNING on jberg-mac80211/master v5.16-rc3 next-20211203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rameshkumar-Sundaram/mac80211-disable-BSS-color-collision-detection-in-case-of-no-free-colors/20211203-124303
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
config: i386-randconfig-s001-20211203 (https://download.01.org/0day-ci/archive/20211203/202112032136.n3Acqu0R-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/318efe87673a29286f893ea96b07869d9dce83bc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rameshkumar-Sundaram/mac80211-disable-BSS-color-collision-detection-in-case-of-no-free-colors/20211203-124303
        git checkout 318efe87673a29286f893ea96b07869d9dce83bc
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/mac80211/cfg.c:1096:36: sparse: sparse: restricted __le32 degrades to integer

vim +1096 net/mac80211/cfg.c

   991	
   992	static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
   993					   struct cfg80211_beacon_data *params,
   994					   const struct ieee80211_csa_settings *csa,
   995					   const struct ieee80211_color_change_settings *cca)
   996	{
   997		struct beacon_data *new, *old;
   998		int new_head_len, new_tail_len;
   999		int size, err;
  1000		const u8 *cap;
  1001		struct ieee80211_he_operation *he_oper = NULL;
  1002		u32 changed = BSS_CHANGED_BEACON;
  1003	
  1004		old = sdata_dereference(sdata->u.ap.beacon, sdata);
  1005	
  1006	
  1007		/* Need to have a beacon head if we don't have one yet */
  1008		if (!params->head && !old)
  1009			return -EINVAL;
  1010	
  1011		/* new or old head? */
  1012		if (params->head)
  1013			new_head_len = params->head_len;
  1014		else
  1015			new_head_len = old->head_len;
  1016	
  1017		/* new or old tail? */
  1018		if (params->tail || !old)
  1019			/* params->tail_len will be zero for !params->tail */
  1020			new_tail_len = params->tail_len;
  1021		else
  1022			new_tail_len = old->tail_len;
  1023	
  1024		size = sizeof(*new) + new_head_len + new_tail_len;
  1025	
  1026		new = kzalloc(size, GFP_KERNEL);
  1027		if (!new)
  1028			return -ENOMEM;
  1029	
  1030		/* start filling the new info now */
  1031	
  1032		/*
  1033		 * pointers go into the block we allocated,
  1034		 * memory is | beacon_data | head | tail |
  1035		 */
  1036		new->head = ((u8 *) new) + sizeof(*new);
  1037		new->tail = new->head + new_head_len;
  1038		new->head_len = new_head_len;
  1039		new->tail_len = new_tail_len;
  1040	
  1041		if (csa) {
  1042			new->cntdwn_current_counter = csa->count;
  1043			memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
  1044			       csa->n_counter_offsets_beacon *
  1045			       sizeof(new->cntdwn_counter_offsets[0]));
  1046		} else if (cca) {
  1047			new->cntdwn_current_counter = cca->count;
  1048			new->cntdwn_counter_offsets[0] = cca->counter_offset_beacon;
  1049		}
  1050	
  1051		/* copy in head */
  1052		if (params->head)
  1053			memcpy(new->head, params->head, new_head_len);
  1054		else
  1055			memcpy(new->head, old->head, new_head_len);
  1056	
  1057		/* copy in optional tail */
  1058		if (params->tail)
  1059			memcpy(new->tail, params->tail, new_tail_len);
  1060		else
  1061			if (old)
  1062				memcpy(new->tail, old->tail, new_tail_len);
  1063	
  1064		err = ieee80211_set_probe_resp(sdata, params->probe_resp,
  1065					       params->probe_resp_len, csa, cca);
  1066		if (err < 0) {
  1067			kfree(new);
  1068			return err;
  1069		}
  1070		if (err == 0)
  1071			changed |= BSS_CHANGED_AP_PROBE_RESP;
  1072	
  1073		if (params->ftm_responder != -1) {
  1074			sdata->vif.bss_conf.ftm_responder = params->ftm_responder;
  1075			err = ieee80211_set_ftm_responder_params(sdata,
  1076								 params->lci,
  1077								 params->lci_len,
  1078								 params->civicloc,
  1079								 params->civicloc_len);
  1080	
  1081			if (err < 0) {
  1082				kfree(new);
  1083				return err;
  1084			}
  1085	
  1086			changed |= BSS_CHANGED_FTM_RESPONDER;
  1087		}
  1088	
  1089		if (sdata->vif.bss_conf.he_support) {
  1090			cap = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION,
  1091						   params->tail, params->tail_len);
  1092			if (cap && cap[1] >= sizeof(*he_oper) + 1)
  1093				he_oper = (void *)(cap + 3);
  1094	
  1095			if (he_oper) {
> 1096				if (he_oper->he_oper_params & HE_OPERATION_BSS_COLOR_DISABLED) {
  1097					if (sdata->vif.bss_conf.he_bss_color.enabled) {
  1098						sdata->vif.bss_conf.he_bss_color.enabled = false;
  1099						changed |= BSS_CHANGED_HE_BSS_COLOR;
  1100					}
  1101				} else {
  1102					if (!sdata->vif.bss_conf.he_bss_color.enabled) {
  1103						sdata->vif.bss_conf.he_bss_color.enabled = true;
  1104						changed |= BSS_CHANGED_HE_BSS_COLOR;
  1105					}
  1106				}
  1107			}
  1108		}
  1109	
  1110		rcu_assign_pointer(sdata->u.ap.beacon, new);
  1111	
  1112		if (old)
  1113			kfree_rcu(old, rcu_head);
  1114	
  1115		return changed;
  1116	}
  1117	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
