Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498551086BF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 04:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKYDLl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Nov 2019 22:11:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:4925 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKYDLl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Nov 2019 22:11:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 19:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="358704140"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2019 19:11:38 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iZ4mo-0003KN-Cg; Mon, 25 Nov 2019 11:11:38 +0800
Date:   Mon, 25 Nov 2019 11:10:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     kbuild-all@lists.01.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 4/9] rtlwifi: Remove dependence on special bit
 manipulation macros for common driver
Message-ID: <201911251026.5x4ZT5uH%lkp@intel.com>
References: <20191121215514.5509-5-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121215514.5509-5-Larry.Finger@lwfinger.net>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-drivers-next/master]
[also build test WARNING on v5.4-rc8 next-20191122]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Larry-Finger/rtlwifi-Complete-removal-of-local-bit-manipulation-macros/20191124-123220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-36-g9305d48-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/realtek/rtlwifi/ps.c:772:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/wireless/realtek/rtlwifi/ps.c:772:42: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/realtek/rtlwifi/ps.c:775:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/wireless/realtek/rtlwifi/ps.c:775:42: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/realtek/rtlwifi/ps.c:778:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/wireless/realtek/rtlwifi/ps.c:778:42: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/realtek/rtlwifi/ps.c:867:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/wireless/realtek/rtlwifi/ps.c:867:42: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/realtek/rtlwifi/ps.c:870:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/wireless/realtek/rtlwifi/ps.c:870:42: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/realtek/rtlwifi/ps.c:873:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/wireless/realtek/rtlwifi/ps.c:873:42: sparse: sparse: cast to restricted __le32

vim +772 drivers/net/wireless/realtek/rtlwifi/ps.c

   705	
   706	static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
   707				   unsigned int len)
   708	{
   709		struct rtl_priv *rtlpriv = rtl_priv(hw);
   710		struct ieee80211_mgmt *mgmt = data;
   711		struct rtl_p2p_ps_info *p2pinfo = &(rtlpriv->psc.p2p_ps_info);
   712		u8 *pos, *end, *ie;
   713		u16 noa_len;
   714		static u8 p2p_oui_ie_type[4] = {0x50, 0x6f, 0x9a, 0x09};
   715		u8 noa_num, index , i, noa_index = 0;
   716		bool find_p2p_ie = false , find_p2p_ps_ie = false;
   717	
   718		pos = (u8 *)mgmt->u.beacon.variable;
   719		end = data + len;
   720		ie = NULL;
   721	
   722		while (pos + 1 < end) {
   723			if (pos + 2 + pos[1] > end)
   724				return;
   725	
   726			if (pos[0] == 221 && pos[1] > 4) {
   727				if (memcmp(&pos[2], p2p_oui_ie_type, 4) == 0) {
   728					ie = pos + 2+4;
   729					break;
   730				}
   731			}
   732			pos += 2 + pos[1];
   733		}
   734	
   735		if (ie == NULL)
   736			return;
   737		find_p2p_ie = true;
   738		/*to find noa ie*/
   739		while (ie + 1 < end) {
   740			noa_len = le16_to_cpu(*((__le16 *)&ie[1]));
   741			if (ie + 3 + ie[1] > end)
   742				return;
   743	
   744			if (ie[0] == 12) {
   745				find_p2p_ps_ie = true;
   746				if ((noa_len - 2) % 13 != 0) {
   747					RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
   748						 "P2P notice of absence: invalid length.%d\n",
   749						 noa_len);
   750					return;
   751				} else {
   752					noa_num = (noa_len - 2) / 13;
   753					if (noa_num > P2P_MAX_NOA_NUM)
   754						noa_num = P2P_MAX_NOA_NUM;
   755	
   756				}
   757				noa_index = ie[3];
   758				if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
   759				    P2P_PS_NONE || noa_index != p2pinfo->noa_index) {
   760					RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
   761						 "update NOA ie.\n");
   762					p2pinfo->noa_index = noa_index;
   763					p2pinfo->opp_ps = (ie[4] >> 7);
   764					p2pinfo->ctwindow = ie[4] & 0x7F;
   765					p2pinfo->noa_num = noa_num;
   766					index = 5;
   767					for (i = 0; i < noa_num; i++) {
   768						p2pinfo->noa_count_type[i] =
   769						 *(u8 *)(ie + index);
   770						index += 1;
   771						p2pinfo->noa_duration[i] =
 > 772						 le32_to_cpu(*(__le32 *)ie + index);
   773						index += 4;
   774						p2pinfo->noa_interval[i] =
   775						 le32_to_cpu(*(__le32 *)ie + index);
   776						index += 4;
   777						p2pinfo->noa_start_time[i] =
   778						 le32_to_cpu(*(__le32 *)ie + index);
   779						index += 4;
   780					}
   781	
   782					if (p2pinfo->opp_ps == 1) {
   783						p2pinfo->p2p_ps_mode = P2P_PS_CTWINDOW;
   784						/* Driver should wait LPS entering
   785						 * CTWindow
   786						 */
   787						if (rtlpriv->psc.fw_current_inpsmode)
   788							rtl_p2p_ps_cmd(hw,
   789								       P2P_PS_ENABLE);
   790					} else if (p2pinfo->noa_num > 0) {
   791						p2pinfo->p2p_ps_mode = P2P_PS_NOA;
   792						rtl_p2p_ps_cmd(hw, P2P_PS_ENABLE);
   793					} else if (p2pinfo->p2p_ps_mode > P2P_PS_NONE) {
   794						rtl_p2p_ps_cmd(hw, P2P_PS_DISABLE);
   795					}
   796				}
   797				break;
   798			}
   799			ie += 3 + noa_len;
   800		}
   801	
   802		if (find_p2p_ie == true) {
   803			if ((p2pinfo->p2p_ps_mode > P2P_PS_NONE) &&
   804			    (find_p2p_ps_ie == false))
   805				rtl_p2p_ps_cmd(hw, P2P_PS_DISABLE);
   806		}
   807	}
   808	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
