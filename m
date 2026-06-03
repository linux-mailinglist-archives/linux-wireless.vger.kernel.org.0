Return-Path: <linux-wireless+bounces-37355-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8FukOtArIGqRyAAAu9opvQ
	(envelope-from <linux-wireless+bounces-37355-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 15:27:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDE7638095
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 15:27:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BNZ9f9kK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37355-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37355-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FC7530B0F60
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34D481673;
	Wed,  3 Jun 2026 13:20:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3748165D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 13:20:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492846; cv=none; b=EsR2PGQdcprsJmX0hNXNRyDr21eEpFErjZSaH9Ipo9BRIaFsSwVhtgSjIPcV5D/uLMWSJzEYq3SIq4QB6SfSqasYN4cXPETOO/E0L6fcIeGUYKlb8FK/kOKGN2XKY2nNOwIc+oSoTopN6rcOsedwZ/03tgGvM8cgs8rc1EnIRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492846; c=relaxed/simple;
	bh=H2D3DsKMJCLENkE7pbhgaFA9ecmOaFqrZUFkLfrN59c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOXBfHVWOjDen/wloJvR6UV9hYYtn9yhCd5O7CsFtsnAFMT8GzDKNiEhkgX/YV+fbLZdSejZ4UQ8S1dL1jzNPo9A6Mo9xZri3zY5J1xorXiE6CWu2PdrXzKgard0izpDIqdhU4VHuHWJoHRw0nnV9GOcGOP5M+8yY9aC+xOwuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNZ9f9kK; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780492846; x=1812028846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2D3DsKMJCLENkE7pbhgaFA9ecmOaFqrZUFkLfrN59c=;
  b=BNZ9f9kKDy3MCCWaO3tZRmwETxxedoDm8WGHBhb2v2vlkk5AelYIZdtC
   9/gooo1/tf6ZLEjtSJHf3upPMB2Kmf4GEFshg1umlsy0Bhk6cyrFXpvVs
   odqQEBRJie+aS3qsmImyK6zr+HeBprLsu8dr48+IR0pnwKAejXKbnzGnU
   vq8PcTyLD8Xl3y5HiESgdsUb7EC6rADobc2RJLknOSpotPuOh5sg2WQvB
   AO2W9GUct/Ml5mhgjIzQ7IcRpuJM0U94B9Uq0UDEKhbPqpgvsOFVbyXTm
   WhFplw+Ii5y1f/+v54eogCrfD8wBjiZmk02y/wWokIcPvWzdaTqmc/uRU
   w==;
X-CSE-ConnectionGUID: MDlrgCP4Qga2gv2gZyqbbw==
X-CSE-MsgGUID: mIMMlCCpTNumfOR/erzHjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80336205"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="80336205"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:20:45 -0700
X-CSE-ConnectionGUID: Ebk5Hf5QTWK1EMkeaBwsBA==
X-CSE-MsgGUID: Q9LWzdFPTaqwCb2KRD1JNw==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 03 Jun 2026 06:20:43 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUlWT-00000000241-186f;
	Wed, 03 Jun 2026 13:20:41 +0000
Date: Wed, 3 Jun 2026 15:20:39 +0200
From: kernel test robot <lkp@intel.com>
To: Jason Huang <Jason.Huang2@infineon.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, wlan-kernel-dev-list@infineon.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Kurt Lee <kurt.lee@cypress.com>,
	Jason Huang <jason.huang2@infineon.com>
Subject: Re: [PATCH] wifi: brcmfmac: add DPP support and fix
 fw-supplicant/P2P interop
Message-ID: <202606031541.hOnf0Qnq-lkp@intel.com>
References: <20260603035722.145894-1-Jason.Huang2@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603035722.145894-1-Jason.Huang2@infineon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37355-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Jason.Huang2@infineon.com,m:linux-wireless@vger.kernel.org,m:oe-kbuild-all@lists.linux.dev,m:wlan-kernel-dev-list@infineon.com,m:johannes@sipsolutions.net,m:kurt.lee@cypress.com,m:jason.huang2@infineon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CDE7638095

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v7.1-rc6 next-20260602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Huang/wifi-brcmfmac-add-DPP-support-and-fix-fw-supplicant-P2P-interop/20260603-115824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260603035722.145894-1-Jason.Huang2%40infineon.com
patch subject: [PATCH] wifi: brcmfmac: add DPP support and fix fw-supplicant/P2P interop
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260603/202606031541.hOnf0Qnq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260603/202606031541.hOnf0Qnq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606031541.hOnf0Qnq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c: In function 'brcmf_p2p_tx_action_frame':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1593:13: warning: variable 'action_frame_len' set but not used [-Wunused-but-set-variable]
    1593 |         u16 action_frame_len;
         |             ^~~~~~~~~~~~~~~~


vim +/action_frame_len +1593 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c

  1570	
  1571	
  1572	/**
  1573	 * brcmf_p2p_tx_action_frame() - send action frame over fil.
  1574	 *
  1575	 * @ifp: interface to transmit on.
  1576	 * @p2p: p2p info struct for vif.
  1577	 * @af_params: action frame data/info.
  1578	 * @vif: vif to send
  1579	 *
  1580	 * Send an action frame immediately without doing channel synchronization.
  1581	 *
  1582	 * This function waits for a completion event before returning.
  1583	 * The WLC_E_ACTION_FRAME_COMPLETE event will be received when the action
  1584	 * frame is transmitted.
  1585	 */
  1586	static s32 brcmf_p2p_tx_action_frame(struct brcmf_if *ifp,
  1587					     struct brcmf_p2p_info *p2p,
  1588					     struct brcmf_fil_af_params_le *af_params)
  1589	{
  1590		struct brcmf_pub *drvr = p2p->cfg->pub;
  1591		s32 err = 0;
  1592		struct brcmf_fil_action_frame_le *action_frame;
> 1593		u16 action_frame_len;
  1594	
  1595		action_frame = &af_params->action_frame;
  1596		action_frame_len = le16_to_cpu(action_frame->len);
  1597	
  1598		brcmf_dbg(TRACE, "Enter\n");
  1599	
  1600		reinit_completion(&p2p->send_af_done);
  1601		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
  1602		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
  1603	
  1604		err = brcmf_fil_bsscfg_data_set(ifp, "actframe", af_params,
  1605						sizeof(*af_params));
  1606		if (err) {
  1607			bphy_err(drvr, " sending action frame has failed\n");
  1608			goto exit;
  1609		}
  1610	
  1611		p2p->af_sent_channel = le32_to_cpu(af_params->channel);
  1612		p2p->af_tx_sent_jiffies = jiffies;
  1613	
  1614		if (test_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN, &p2p->status) &&
  1615		    p2p->af_sent_channel ==
  1616		    ieee80211_frequency_to_channel(p2p->remain_on_channel.center_freq))
  1617			p2p->wait_for_offchan_complete = false;
  1618		else
  1619			p2p->wait_for_offchan_complete = true;
  1620	
  1621		brcmf_dbg(TRACE, "Waiting for %s tx completion event\n",
  1622			  (p2p->wait_for_offchan_complete) ?
  1623			   "off-channel" : "on-channel");
  1624	
  1625		wait_for_completion_timeout(&p2p->send_af_done, P2P_AF_MAX_WAIT_TIME);
  1626	
  1627		if (test_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status)) {
  1628			brcmf_dbg(TRACE, "TX action frame operation is success\n");
  1629		} else {
  1630			err = -EIO;
  1631			brcmf_dbg(TRACE, "TX action frame operation has failed\n");
  1632		}
  1633		/* clear status bit for action tx */
  1634		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
  1635		clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
  1636	
  1637	exit:
  1638		return err;
  1639	}
  1640	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

