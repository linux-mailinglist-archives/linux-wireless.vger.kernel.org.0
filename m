Return-Path: <linux-wireless+bounces-295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E0800B39
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 13:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66E4B21181
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6181CF87;
	Fri,  1 Dec 2023 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaGNG6Ko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE15954E;
	Fri,  1 Dec 2023 12:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D35AC433CA;
	Fri,  1 Dec 2023 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701434509;
	bh=imMZhfTtyyGFtFcaYBtnqz4qJYY6QUgBBX1z+Bcmn78=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OaGNG6KoKebXZRxH+/ZzHRN3G7Und64V4LWYAEwksUBOhkovG8ua4z9z9GooqAs+j
	 N6CNHSflRxHdz+mHZyXsvpWHy+jEZ5ixIUvVTBMqrv3cU7kLpB+U0lxeuyRobCikPX
	 VTHvEu2CxYIVQvKMwUB6il4hiMgmU6+67vGr/JRw0XwEAuhHu9r7SSTjn/7jFJ+zcg
	 sN1ab4TSp6b+GsWDPWyfdtFmqGgS9yXEmuBSkEa1Y6fjHeBtF0tT1bHuMci799Ncio
	 USHE0ASdS78KNCU7GXR27jHCIFRW0+fvy501KVas50Yg1Hx+DoZ+kkkuKnkdHMe+Lo
	 9L8mJICKTParQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/10] wifi: rtlwifi: Remove bogus and dangerous ASPM
 disable/enable code
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231124084725.12738-2-ilpo.jarvinen@linux.intel.com>
References: <20231124084725.12738-2-ilpo.jarvinen@linux.intel.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
 Larry Finger <Larry.Finger@lwfinger.net>, linux-wireless@vger.kernel.org,
 Ping-Ke Shih <pkshih@realtek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@kernel.org>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143450482.2072551.1616110971687036096.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 12:41:46 +0000 (UTC)

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Ever since introduction in the commit 0c8173385e54 ("rtl8192ce: Add new
> driver") the rtlwifi code has, according to comments, attempted to
> disable/enable ASPM of the upstream bridge by writing into its LNKCTL
> register. However, the code has never been correct because it performs
> the writes to the device instead of the upstream bridge.
> 
> Worse yet, the offset where the PCIe capabilities reside is derived
> from the offset of the upstream bridge. As a result, the write will use
> an offset on the device that does not relate to the LNKCTL register
> making the ASPM disable/enable code outright dangerous.
> 
> Because of those problems, there is no indication that the driver needs
> disable/enable ASPM on the upstream bridge. As the Capabilities offset
> is not correctly calculated for the write to target device's LNKCTL
> register, the code is not disabling/enabling device's ASPM either.
> Therefore, just remove the upstream bridge related ASPM disable/enable
> code entirely.
> 
> The upstream bridge related ASPM code was the only user of the struct
> mp_adapter members num4bytes, pcibridge_pciehdr_offset, and
> pcibridge_linkctrlreg so those are removed as well.
> 
> Note: This change does not remove the code related to changing the
> device's ASPM on purpose (which is independent of this flawed code
> related to upstream bridge's ASPM).
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@kernel.org>
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> Fixes: 886e14b65a8f ("rtlwifi: Eliminate raw reads and writes from PCIe portion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

10 patches applied to wireless-next.git, thanks.

b3943b3c2971 wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
5894d0089cbc wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
a4fcac11a25a wifi: rtlwifi: Convert to use PCIe capability accessors
6e071ae899f1 wifi: rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
760bfed91201 wifi: rtlwifi: rtl8821ae: Reverse PM Capability exists check
9dcc75e0b7d0 wifi: rtlwifi: rtl8821ae: Use pci_find_capability()
7bd350d2ac91 wifi: rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
05b311a3f915 wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
217fbc032eaa wifi: rtlwifi: Remove unused PCI related defines and struct
874a0eda000d wifi: rtlwifi: Remove bridge vendor/device ids

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231124084725.12738-2-ilpo.jarvinen@linux.intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


