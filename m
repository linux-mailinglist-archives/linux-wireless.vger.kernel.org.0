Return-Path: <linux-wireless+bounces-19730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BDA4CE47
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6D7188F55C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5281F1301;
	Mon,  3 Mar 2025 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X08N3H77"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224E1F03C0;
	Mon,  3 Mar 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040823; cv=none; b=Hk0Wfetma++yBa8TuQKGCxodpo6YrVhsv9mWVpJPIpN2hufehMylO/nufq2IB7p0RfI/z6XoCRSvPU7BAqbR9zxCj8FnONSltKdWzom8xJQcsFynUoEHlcb3AIIPM2e74+ZJQWMkOR3HiD3I/lR2+YtN/ehuH+D1ILYP2pgc8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040823; c=relaxed/simple;
	bh=nbQ+GTtR9+WtDAUfLtWWJMdNyA5rS1jCv0pKqdQLtDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aLYXyk/l2I0Ly5I4ZOsEFJMdsVimsh8ejpMU4EdmEglTpKMt9OjLdcXskMTLUTx25SKQiJCkQXuj8+kknOZCzKapWzzc/1ca3jskE2O7/baEbLGHDEDyWdqLN/PqfjCR8CKuyENzDBd7EzUIH313BVv7knA2W2P8gHSyeEGPqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X08N3H77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A465C4CED6;
	Mon,  3 Mar 2025 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040822;
	bh=nbQ+GTtR9+WtDAUfLtWWJMdNyA5rS1jCv0pKqdQLtDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X08N3H77tknBP9x4lqnFGW4CaHWFeDKNKP1igDYF204C7pKJbY+xitfSAIR5knMmQ
	 y6nIab/jmsU3gdNNJYmBFqSez5VRrlMDN0IHf+yI2T6H062HjW9SUS+Vsp07d0Zv76
	 m4RW12dy3UqpiR8bQqXzRmAPJVxq7Z6CBWlXqQtB603JZOHyoddCUdtVr2zMMdRqI1
	 /3vavvzTFGdXes5n2c11rxW83tJmnG+SDXz8ENdzslFMXUt2agFxP27U793nOq1bSf
	 tT2P89sqQVnlWBV+kHt4XXvdFmyyWa6RtoH8mpaHRtpGZ221ai/8PxxsBzs8i1VAPg
	 HkTFERsTkyrcA==
Date: Mon, 3 Mar 2025 16:27:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Matti Gottlieb <matti.gottlieb@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] Significant WiFi Speed Reduction with Kernel
 Versions > 6.8.12 on Intel Wi-Fi 6 AX203
Message-ID: <20250303222700.GA202089@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225182514.GA512422@bhelgaas>

On Tue, Feb 25, 2025 at 12:25:16PM -0600, Bjorn Helgaas wrote:
> On Thu, Aug 08, 2024 at 08:43:53AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 07.08.24 11:12, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > 
> > > Mukesh Sisodiya, I noticed a report about a regression in
> > > bugzilla.kernel.org that appears to be caused by a change of yours:
> > > 
> > > 099a47dbe71b75 ("wifi: iwlwifi: Add support for new 802.11be device")
> > > [v6.9-rc1]
> > 
> > For the record, turns out the bisection went a bit sideways and the
> > problems apparently is caused by 84ec2d2e960f33 ("wifi: iwlwifi: disable
> > 160 MHz based on subsystem device ID") [v6.9-rc1]. For details, see
> > https://bugzilla.kernel.org/show_bug.cgi?id=219114#c8
> 
> Browsing the regression tracker, this seems stalled with no responses
> even though the submitter (bcc'd) has bisected it.

FWIW, it looks like the following commits are relevant:

  https://git.kernel.org/linus/d6f2134a3831 ("iwlwifi: add mac/rf types and 160MHz to the device tables")
  https://git.kernel.org/linus/568d3434178b ("iwlwifi: pcie: invert values of NO_160 device config entries")
  https://git.kernel.org/linus/4886460c4d15 ("iwlwifi: Fix IWL_SUBDEVICE_NO_160 macro to use the correct bit.")
  https://git.kernel.org/linus/84ec2d2e960f ("wifi: iwlwifi: disable 160 MHz based on subsystem device ID")

4886460c4d15 ("iwlwifi: Fix IWL_SUBDEVICE_NO_160 macro to use the
correct bit.") updated IWL_SUBDEVICE_NO_160() to identify devices that
should not support 160MHz:

  -#define IWL_SUBDEVICE_NO_160(subdevice)        ((u16)((subdevice) & 0x0100) >> 9)
  +#define IWL_SUBDEVICE_NO_160(subdevice)        ((u16)((subdevice) & 0x0200) >> 9)

The submitter's device has Subdevice ID 0x1652.  Prior to
4886460c4d15, that did not match IWL_SUBDEVICE_NO_160(), but
afterwards it does:

  0000:00:14.3 Network controller [0280]: Intel Corporation Alder Lake-P PCH CNVi WiFi [8086:51f0] (rev 01)
    Subsystem: Rivet Networks Dual Band Wi-Fi 6(802.11ax) Killer AX1650i 160MHz 2x2 [Cyclone Peak] [1a56:1652]

But apparently it wasn't until 84ec2d2e960f ("wifi: iwlwifi: disable
160 MHz based on subsystem device ID"), that 160MHz support actually
got disabled for devices that match IWL_SUBDEVICE_NO_160():

  @@ -1061,6 +1061,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,

  +       if (trans->no_160)
  +               iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
  +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
  +


  @@ -1394,6 +1394,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

          dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
                                           ...
                                           IWL_SUBDEVICE_NO_160(pdev->subsystem_device),
                                           ...);

          if (dev_info) {
                  iwl_trans->cfg = dev_info->cfg;
                  iwl_trans->name = dev_info->name;
  +               iwl_trans->no_160 = dev_info->no_160 == IWL_CFG_NO_160;
          }

84ec2d2e960f appeared in v6.9.  Per the submitter, the speed reduction
appeared in v6.8.12.  Maybe it was backported?  I dunno.

If 160MHz is disabled on that device because of regulatory
restrictions, and it worked when it should not have prior to
84ec2d2e960f, I guess the submitter is out of luck.

If that's the case, maybe we could at least update the bugzilla with
the status to close this out?  The submitter has done a LOT of work to
isolate this, and I think we owe them the courtesy of resolving it.

Bjorn

