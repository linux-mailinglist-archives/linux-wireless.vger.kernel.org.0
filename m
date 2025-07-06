Return-Path: <linux-wireless+bounces-24850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DAAFA62E
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D823BBA01
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6396B285CBD;
	Sun,  6 Jul 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dfk/LZlw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AF1482E8
	for <linux-wireless@vger.kernel.org>; Sun,  6 Jul 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815805; cv=none; b=WtO+pyCkoFFPmU9pdBDYMxgcI5GQENuVXhDD8xIHm5UWT1oDRS71KsJOK7t/4CmPpvf7qaY7XEZBu2+PAT3Eu8OcVaI7pnweA42SpL9PD1pAIH6gB1NRZ2lhREfaxzwLmaTeKYaZ/lK1wcWX9DaIB1Oqa8xNLcNvdX9FSYMka98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815805; c=relaxed/simple;
	bh=hXxpxP3r6USDwbJPV6SqHo7rk/wp740Agncua43aQb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT0Yub0qQhfOYUVnnFfOotlqH6MQkO6HuGNDJ/m1KGBOPfmc/JZDSVtzgiZ3Glt80qhPdnWtpzxI7fBNW/zkDpcyvwHpXk4a3A5Pl58KwRP9D+HcJScOlmzumr6mXXrg6D6a1KEJbzUicUj1HNNFPUIFdh5ngHqwuvHwZxQGwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dfk/LZlw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751815802; x=1783351802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXxpxP3r6USDwbJPV6SqHo7rk/wp740Agncua43aQb0=;
  b=Dfk/LZlwbkJjZPSQ8fJ4jKZN55lyxNFW2wHpgB4EtK8YGYryt05dMM6z
   9Eda4CPZ7qKFkftFBLIeHH/eyxH00FTWyXhWTSbl0syc+3Xxdss371DZX
   bpSeKpgTgOI6Vs0qIjBi66uEuFUUSiRswe8YgrfmdKWOJfMS5H5lBfojV
   IjjxrdQkUkV8A3XBUMgIFowAHphmu2ZFqIkX/A4ueooh/RZckR904FTvJ
   vbeKfY9vhf5v0BaqVD//jPPSyIl/wEdZbMqM1pqa7c1JQt9iSjSEe78mF
   n52qhyU4MIuxnxPkECZManZ2XoIhIhLCfeHHLXb4hitVzvALNYVFVXEZF
   w==;
X-CSE-ConnectionGUID: J+4JyrqNQv+YZxc665dLXA==
X-CSE-MsgGUID: T/iZXkpFSH21+4QGX6c/Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53175703"
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; 
   d="scan'208";a="53175703"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2025 08:30:01 -0700
X-CSE-ConnectionGUID: x1z/klDhSlmx6BOMRHviwA==
X-CSE-MsgGUID: vuLjyKkDRwGbyRsUrex4mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,292,1744095600"; 
   d="scan'208";a="154435374"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Jul 2025 08:29:59 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYRJV-00057H-0S;
	Sun, 06 Jul 2025 15:29:57 +0000
Date: Sun, 6 Jul 2025 23:29:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, wlan-kernel-dev-list@infineon.com,
	gokulkumar.sivakumar@infineon.com
Subject: Re: [PATCH wireless-next v2] wifi: brcmfmac: fix EXTSAE WPA3
 connection failure due to AUTH TX failure
Message-ID: <202507062346.dYsnIxdD-lkp@intel.com>
References: <20250703135307.7433-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703135307.7433-1-gokulkumar.sivakumar@infineon.com>

Hi Gokul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gokul-Sivakumar/wifi-brcmfmac-fix-EXTSAE-WPA3-connection-failure-due-to-AUTH-TX-failure/20250703-215456
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250703135307.7433-1-gokulkumar.sivakumar%40infineon.com
patch subject: [PATCH wireless-next v2] wifi: brcmfmac: fix EXTSAE WPA3 connection failure due to AUTH TX failure
config: sh-randconfig-r121-20250704 (https://download.01.org/0day-ci/archive/20250706/202507062346.dYsnIxdD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250706/202507062346.dYsnIxdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507062346.dYsnIxdD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:5620:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] channel @@     got signed int [addressable] [usertype] hw_ch @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:5620:52: sparse:     expected restricted __le32 [usertype] channel
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:5620:52: sparse:     got signed int [addressable] [usertype] hw_ch
--
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:156:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] channel @@     got signed int [addressable] [usertype] hw_ch @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:156:44: sparse:     expected restricted __le16 [usertype] channel
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:156:44: sparse:     got signed int [addressable] [usertype] hw_ch

vim +5620 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

  5528	
  5529	
  5530	int
  5531	brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
  5532			       struct cfg80211_mgmt_tx_params *params, u64 *cookie)
  5533	{
  5534		struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
  5535		struct ieee80211_channel *chan = params->chan;
  5536		struct brcmf_pub *drvr = cfg->pub;
  5537		const u8 *buf = params->buf;
  5538		size_t len = params->len;
  5539		const struct ieee80211_mgmt *mgmt;
  5540		struct brcmf_cfg80211_vif *vif;
  5541		s32 err = 0;
  5542		s32 ie_offset;
  5543		s32 ie_len;
  5544		struct brcmf_fil_action_frame_le *action_frame;
  5545		struct brcmf_fil_af_params_le *af_params;
  5546		bool ack;
  5547		s32 ch, hw_ch;
  5548	
  5549		brcmf_dbg(TRACE, "Enter\n");
  5550	
  5551		*cookie = 0;
  5552	
  5553		mgmt = (const struct ieee80211_mgmt *)buf;
  5554	
  5555		if (!ieee80211_is_mgmt(mgmt->frame_control)) {
  5556			bphy_err(drvr, "Driver only allows MGMT packet type\n");
  5557			return -EPERM;
  5558		}
  5559	
  5560		vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
  5561	
  5562		if (ieee80211_is_probe_resp(mgmt->frame_control)) {
  5563			/* Right now the only reason to get a probe response */
  5564			/* is for p2p listen response or for p2p GO from     */
  5565			/* wpa_supplicant. Unfortunately the probe is send   */
  5566			/* on primary ndev, while dongle wants it on the p2p */
  5567			/* vif. Since this is only reason for a probe        */
  5568			/* response to be sent, the vif is taken from cfg.   */
  5569			/* If ever desired to send proberesp for non p2p     */
  5570			/* response then data should be checked for          */
  5571			/* "DIRECT-". Note in future supplicant will take    */
  5572			/* dedicated p2p wdev to do this and then this 'hack'*/
  5573			/* is not needed anymore.                            */
  5574			ie_offset =  DOT11_MGMT_HDR_LEN +
  5575				     DOT11_BCN_PRB_FIXED_LEN;
  5576			ie_len = len - ie_offset;
  5577			if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif)
  5578				vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
  5579			err = brcmf_vif_set_mgmt_ie(vif,
  5580						    BRCMF_VNDR_IE_PRBRSP_FLAG,
  5581						    &buf[ie_offset],
  5582						    ie_len);
  5583			cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, true,
  5584						GFP_KERNEL);
  5585		} else if (ieee80211_is_action(mgmt->frame_control)) {
  5586			if (len > BRCMF_FIL_ACTION_FRAME_SIZE + DOT11_MGMT_HDR_LEN) {
  5587				bphy_err(drvr, "invalid action frame length\n");
  5588				err = -EINVAL;
  5589				goto exit;
  5590			}
  5591			af_params = kzalloc(sizeof(*af_params), GFP_KERNEL);
  5592			if (af_params == NULL) {
  5593				bphy_err(drvr, "unable to allocate frame\n");
  5594				err = -ENOMEM;
  5595				goto exit;
  5596			}
  5597			action_frame = &af_params->action_frame;
  5598			/* Add the packet Id */
  5599			action_frame->packet_id = cpu_to_le32(*cookie);
  5600			/* Add BSSID */
  5601			memcpy(&action_frame->da[0], &mgmt->da[0], ETH_ALEN);
  5602			memcpy(&af_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
  5603			/* Add the length exepted for 802.11 header  */
  5604			action_frame->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
  5605			/* Add the channel. Use the one specified as parameter if any or
  5606			 * the current one (got from the firmware) otherwise
  5607			 */
  5608			if (chan) {
  5609				ch = ieee80211_frequency_to_channel(chan->center_freq);
  5610				af_params->channel = cpu_to_le32(ch);
  5611			} else {
  5612				err = brcmf_fil_cmd_int_get(vif->ifp,
  5613							    BRCMF_C_GET_CHANNEL,
  5614							    &hw_ch);
  5615				if (err) {
  5616					bphy_err(drvr,
  5617						 "unable to get current hw channel\n");
  5618					goto free;
  5619				} else {
> 5620					af_params->channel = hw_ch;
  5621				}
  5622			}
  5623	
  5624			af_params->dwell_time = cpu_to_le32(params->wait);
  5625			memcpy(action_frame->data, &buf[DOT11_MGMT_HDR_LEN],
  5626			       le16_to_cpu(action_frame->len));
  5627	
  5628			brcmf_dbg(TRACE, "Action frame, cookie=%lld, len=%d, channel=%d\n",
  5629				  *cookie, le16_to_cpu(action_frame->len),
  5630				  le32_to_cpu(af_params->channel));
  5631	
  5632			ack = brcmf_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
  5633							  af_params);
  5634	
  5635			cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
  5636						GFP_KERNEL);
  5637	free:
  5638			kfree(af_params);
  5639		} else {
  5640			brcmf_dbg(TRACE, "Unhandled, fc=%04x!!\n", mgmt->frame_control);
  5641			brcmf_dbg_hex_dump(true, buf, len, "payload, len=%zu\n", len);
  5642		}
  5643	
  5644	exit:
  5645		return err;
  5646	}
  5647	BRCMF_EXPORT_SYMBOL_GPL(brcmf_cfg80211_mgmt_tx);
  5648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

