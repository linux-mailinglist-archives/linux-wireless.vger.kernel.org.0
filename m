Return-Path: <linux-wireless+bounces-4563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95046878207
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92811C21969
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78013F8C3;
	Mon, 11 Mar 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVVFqa3a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B65446C8
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168530; cv=none; b=ezTkFYl5bS8f/8ER8MRT8jDsPKRZMVHPLcMZVwmkDbqX8Q4orkZAVLcSJIILHen6i+UIkMuVO8QDQ7YJc6DB/K2TUGmFSHhDKteELHamfpq27h3tvQMx39ryaVplYV0umZY9A3DUTTH9KL8SRiJEgsWhQulw3m+BGQGGeFu3zzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168530; c=relaxed/simple;
	bh=CmGx9CWDygzXxazngc7QrIPW7cV1sd5RtAweTNrEerk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzC+OaKWUPpr4VmVj+TCnlTZQcL3VIVNeLExbG7/XyHC51uJefXrPxsdq+bwKhLGoHojozllBk5XFKwSMIb+H+fyX7JViwff7wDJUIAqGIQbZYUF1PKRDJaP+azhU3/UVq5kPhEgPjlfeyJiSgQPw3W8aZKuThr2v4FR2rZEjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVVFqa3a; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710168528; x=1741704528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmGx9CWDygzXxazngc7QrIPW7cV1sd5RtAweTNrEerk=;
  b=AVVFqa3axeH0r9JKPmK6tchnjyJKLd7VDb9IUBS/+t9DLhpIgdl++TDr
   hn46jStXLQ8p2kbJ1Z4nNow4UANQT4FT/tMA+wSU51Q2XnR/jIndo9ZH4
   S4V8bYMorE/W4uVjSzDmrUOi4l/Xk27gURS68pzlbrWoLhrfoaAJXvjFk
   1cmXkjKIPnnHiW/vU5FKrbrEN5dTR6xko9VUHKB4nAYnAkwb2EqGAMsC4
   yq2DryxgwisYoysjT6ho7f7CzweY+ohGkfWStxzmoGKbzxibOpoyAROfe
   rseYDMlOHQ0WKpLOzJO/UNfYFIZ89pJqPERNNQDUZTjvzSBV6RsKn2dR6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15972703"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="15972703"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="42105222"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Mar 2024 07:48:46 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjgxH-0009BT-0n;
	Mon, 11 Mar 2024 14:48:43 +0000
Date: Mon, 11 Mar 2024 22:48:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ku920601@realtek.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/6] wifi: rtw89: coex: Add WiFi role info format version
 8
Message-ID: <202403112247.DlQU3eaG-lkp@intel.com>
References: <20240306034558.19648-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306034558.19648-2-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on next-20240308]
[cannot apply to wireless/main linus/master v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-coex-Add-WiFi-role-info-format-version-8/20240306-115058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240306034558.19648-2-pkshih%40realtek.com
patch subject: [PATCH 1/6] wifi: rtw89: coex: Add WiFi role info format version 8
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240311/202403112247.DlQU3eaG-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240311/202403112247.DlQU3eaG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403112247.DlQU3eaG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/coex.c:5480:20: warning: variable 'cnt_2g' set but not used [-Wunused-but-set-variable]
    5480 |         u8 i, j, cnt = 0, cnt_2g = 0, cnt_5g = 0;
         |                           ^
>> drivers/net/wireless/realtek/rtw89/coex.c:5480:32: warning: variable 'cnt_5g' set but not used [-Wunused-but-set-variable]
    5480 |         u8 i, j, cnt = 0, cnt_2g = 0, cnt_5g = 0;
         |                                       ^
   2 warnings generated.


vim +/cnt_2g +5480 drivers/net/wireless/realtek/rtw89/coex.c

  5467	
  5468	static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id,
  5469				       enum btc_role_state state)
  5470	{
  5471		struct rtw89_btc *btc = &rtwdev->btc;
  5472		struct rtw89_btc_wl_info *wl = &btc->cx.wl;
  5473		struct rtw89_btc_chdef cid_ch[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
  5474		struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
  5475		struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
  5476		bool client_joined = false, b2g = false, b5g = false;
  5477		u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
  5478		u8 cid_phy[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
  5479		u8 dbcc_en = 0, pta_req_band = RTW89_MAC_0;
> 5480		u8 i, j, cnt = 0, cnt_2g = 0, cnt_5g = 0;
  5481		struct rtw89_btc_wl_link_info *wl_linfo;
  5482		struct rtw89_btc_wl_rlink *rlink = NULL;
  5483		u8 dbcc_2g_phy = RTW89_PHY_0;
  5484		u8 mode = BTC_WLINK_NOLINK;
  5485		u32 noa_dur = 0;
  5486	
  5487		if (role_id >= RTW89_BE_BTC_WL_MAX_ROLE_NUMBER || rlink_id > RTW89_MAC_1)
  5488			return;
  5489	
  5490		/* Extract wl->link_info[role_id][rlink_id] to wl->role_info
  5491		 * role_id: role index
  5492		 * rlink_id: rlink index (= HW-band index)
  5493		 * pid: port_index
  5494		 */
  5495	
  5496		wl_linfo = &wl->rlink_info[role_id][rlink_id];
  5497		if (wl_linfo->connected == MLME_LINKING)
  5498			return;
  5499	
  5500		rlink = &wl_rinfo->rlink[role_id][rlink_id];
  5501		rlink->role = wl_linfo->role;
  5502		rlink->active = wl_linfo->active; /* Doze or not */
  5503		rlink->pid = wl_linfo->pid;
  5504		rlink->phy = wl_linfo->phy;
  5505		rlink->rf_band = wl_linfo->band;
  5506		rlink->ch = wl_linfo->ch;
  5507		rlink->bw = wl_linfo->bw;
  5508		rlink->noa = wl_linfo->noa;
  5509		rlink->noa_dur = wl_linfo->noa_duration / 1000;
  5510		rlink->client_cnt = wl_linfo->client_cnt;
  5511		rlink->mode = wl_linfo->mode;
  5512	
  5513		switch (wl_linfo->connected) {
  5514		case MLME_NO_LINK:
  5515			rlink->connected = 0;
  5516			if (rlink->role == RTW89_WIFI_ROLE_STATION)
  5517				btc->dm.leak_ap = 0;
  5518			break;
  5519		case MLME_LINKED:
  5520			rlink->connected = 1;
  5521			break;
  5522		default:
  5523			return;
  5524		}
  5525	
  5526		wl->is_5g_hi_channel = false;
  5527		wl->bg_mode = false;
  5528		wl_rinfo->role_map = 0;
  5529		wl_rinfo->p2p_2g = 0;
  5530		memset(cid_ch, 0, sizeof(cid_ch));
  5531	
  5532		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
  5533			for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
  5534				rlink = &wl_rinfo->rlink[i][j];
  5535	
  5536				if (!rlink->active || !rlink->connected)
  5537					continue;
  5538	
  5539				cnt++;
  5540				wl_rinfo->role_map |= BIT(rlink->role);
  5541	
  5542				/* only if client connect for p2p-Go/AP */
  5543				if ((rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
  5544				     rlink->role == RTW89_WIFI_ROLE_AP) &&
  5545				     rlink->client_cnt > 1)
  5546					client_joined = true;
  5547	
  5548				/* Identufy if P2P-Go (GO/GC/AP) exist at 2G band*/
  5549				if (rlink->rf_band == RTW89_BAND_2G &&
  5550				    (client_joined || rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT))
  5551					wl_rinfo->p2p_2g = 1;
  5552	
  5553				/* only one noa-role exist */
  5554				if (rlink->noa && rlink->noa_dur > 0)
  5555					noa_dur = rlink->noa_dur;
  5556	
  5557				/* for WL 5G-Rx interfered with BT issue */
  5558				if (rlink->rf_band == RTW89_BAND_5G && rlink->ch >= 100)
  5559					wl->is_5g_hi_channel = 1;
  5560	
  5561				if ((rlink->mode & BIT(BTC_WL_MODE_11B)) ||
  5562				    (rlink->mode & BIT(BTC_WL_MODE_11G)))
  5563					wl->bg_mode = 1;
  5564	
  5565				if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT)
  5566					continue;
  5567	
  5568				cid_ch[cnt - 1] = wl_linfo->chdef;
  5569				cid_phy[cnt - 1] = rlink->phy;
  5570				cid_role[cnt - 1] = rlink->role;
  5571	
  5572				if (rlink->rf_band != RTW89_BAND_2G) {
  5573					cnt_5g++;
  5574					b5g = true;
  5575				} else {
  5576					cnt_2g++;
  5577					b2g = true;
  5578				}
  5579			}
  5580		}
  5581	
  5582		if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT) {
  5583			rtw89_warn(rtwdev, "not support MLO feature yet");
  5584		} else {
  5585			dbcc_en = rtwdev->dbcc_en;
  5586	
  5587			/* Be careful to change the following sequence!! */
  5588			if (cnt == 0) {
  5589				mode = BTC_WLINK_NOLINK;
  5590			} else if (!b2g && b5g) {
  5591				mode = BTC_WLINK_5G;
  5592			} else if (wl_rinfo->role_map & BIT(RTW89_WIFI_ROLE_NAN)) {
  5593				mode = BTC_WLINK_2G_NAN;
  5594			} else if (cnt > BTC_TDMA_WLROLE_MAX) {
  5595				mode = BTC_WLINK_OTHER;
  5596			} else if (dbcc_en) {
  5597				mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role,
  5598						 &dbcc_2g_phy);
  5599			} else if (b2g && b5g && cnt == 2) {
  5600				mode = BTC_WLINK_25G_MCC;
  5601			} else if (!b5g && cnt == 2) { /* cnt_connect = 2 */
  5602				if (_chk_role_ch_group(&cid_ch[0], &cid_ch[cnt - 1]))
  5603					mode = BTC_WLINK_2G_SCC;
  5604				else
  5605					mode = BTC_WLINK_2G_MCC;
  5606			} else if (!b5g && cnt == 1) { /* cnt_connect = 1 */
  5607				mode = _get_role_link_mode(cid_role[0]);
  5608			}
  5609		}
  5610	
  5611		wl_rinfo->link_mode = mode;
  5612		wl_rinfo->connect_cnt = cnt;
  5613		if (wl_rinfo->connect_cnt == 0)
  5614			wl_rinfo->role_map = BIT(RTW89_WIFI_ROLE_NONE);
  5615		_update_role_link_mode(rtwdev, client_joined, noa_dur);
  5616	
  5617		wl_rinfo->dbcc_2g_phy = dbcc_2g_phy;
  5618		if (wl_rinfo->dbcc_en != dbcc_en) {
  5619			wl_rinfo->dbcc_en = dbcc_en;
  5620			wl_rinfo->dbcc_chg = 1;
  5621			btc->cx.cnt_wl[BTC_WCNT_DBCC_CHG]++;
  5622		} else {
  5623			wl_rinfo->dbcc_chg = 0;
  5624		}
  5625	
  5626		if (wl_rinfo->dbcc_en) {
  5627			memset(wl_dinfo, 0, sizeof(struct rtw89_btc_wl_dbcc_info));
  5628	
  5629			if (mode == BTC_WLINK_5G) {
  5630				pta_req_band = RTW89_PHY_0;
  5631				wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_5G;
  5632				wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_2G;
  5633			} else if (wl_rinfo->dbcc_2g_phy == RTW89_PHY_1) {
  5634				pta_req_band = RTW89_PHY_1;
  5635				wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_5G;
  5636				wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_2G;
  5637			} else {
  5638				pta_req_band = RTW89_PHY_0;
  5639				wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_2G;
  5640				wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_5G;
  5641			}
  5642			_update_dbcc_band(rtwdev, RTW89_PHY_0);
  5643			_update_dbcc_band(rtwdev, RTW89_PHY_1);
  5644		}
  5645	
  5646		wl_rinfo->pta_req_band = pta_req_band;
  5647		_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
  5648	}
  5649	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

