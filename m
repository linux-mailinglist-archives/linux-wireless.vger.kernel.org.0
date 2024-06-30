Return-Path: <linux-wireless+bounces-9721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA6091D096
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 10:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5108C1F2153C
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666784DF5;
	Sun, 30 Jun 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Pj5nU6pK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF765464A;
	Sun, 30 Jun 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719736576; cv=none; b=D9hJGGsgm9N9Y8DR1U1tBDejLlAmXMRucjEN6+/QiYR547meGN/CL6Qm5s+7jCvZvmZeVMD4mMNRUqpaqJwyZ+KOUSCgL1lwQvtB0nwQQA5Q4Nl0RQT0DAyaafTT16PX8uuWCU7jR8HmOi7BzX4BDjQd+nQk8vOm2L+lmHCyo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719736576; c=relaxed/simple;
	bh=0StuoGjbrD4oDSBobaaH63XsFE4dUsBxLVctILZFj5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbH5rZ5gfUj0zidR6yU1ESgl7/rM0ZdzCUaDz5ivlr41BA/nKDT6FZmAdrtV6hB8qb5L2XuAoUVEZuwgKktdtXA0YjVwPkLI2siU/Wc/JrsaSKXjpvI+G/KQcUt+bcpMl+IH1v0ZUoUF/BdnpZ+0t+Wbavb4rWIGkA/ewmyxd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Pj5nU6pK; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1719736564; bh=0StuoGjbrD4oDSBobaaH63XsFE4dUsBxLVctILZFj5w=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Pj5nU6pKDi1X7cD2NrdFh6JBXsg3ybQNDFRy5JdVdFJSBnHmbgE9N2uAJo7t6Drm9
	 CtCxaDBF5NTTqtmTxmN5a7ERhDlTyGVcKqioJX3PhCGdDryXl+8D9igDt9MgyKDkJx
	 nnCZYPtxgu9hz2Dbz5LBKf/U6gXBOxtBg8lcaLq0=
Date: Sun, 30 Jun 2024 10:36:03 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, 
	krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org, 
	efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
Subject: Re: [PATCH v3 5/5] wifi: brcmfmac: Add support for AP6275P
Message-ID: <4x6n6pfvcth7hih2k22e5kljoietqzrk34xwqgwtlbpx3dnbvj@lkuidevipsua>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Stefan Wahren <wahrenst@gmx.net>, Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, 
	krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org, 
	efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-6-jacobe.zang@wesion.com>
 <54132213-d81a-49b3-939e-17ff755e39c1@gmx.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54132213-d81a-49b3-939e-17ff755e39c1@gmx.net>

On Sun, Jun 30, 2024 at 10:34:39AM GMT, Stefan Wahren wrote:
> Am 30.06.24 um 09:36 schrieb Jacobe Zang:
> > This module features BCM43752A2 chipset. The firmware requires
> > randomness seeding, so enabled it.
> > 
> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > Link: https://megous.com/git/linux/commit/?h=ap6275p-6.10&id=1a99573bc8ed412e60e1969c0b29d53a0e5782e0
> > ---
> >   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c      | 5 ++++-
> >   .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 2 ++
> >   2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> > index e84f562fc91b8..f427d664cf3a5 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> > @@ -71,6 +71,7 @@ BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
> >   BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
> >   BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
> >   BRCMF_FW_CLM_DEF(4387C2, "brcmfmac4387c2-pcie");
> > +BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
> > 
> >   /* firmware config files */
> >   MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
> > @@ -105,6 +106,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
> >   	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
> >   	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
> >   	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
> > +	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
> >   	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
> >   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
> >   	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
> > @@ -1721,7 +1723,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
> >   		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
> >   		brcmf_fw_nvram_free(nvram);
> > 
> > -		if (devinfo->otp.valid) {
> > +		if (devinfo->otp.valid || devinfo->ci->chip == BRCM_CC_43752_CHIP_ID) {
> As a reviewer, i would expect an explanation in the commit message or in
> the code for this quirk.

That's the "The firmware requires randomness seeding, so enabled it." part of
the commit message.

> >   			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
> >   			struct brcmf_random_seed_footer footer = {
> >   				.length = cpu_to_le32(rand_len),
> > @@ -2710,6 +2712,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
> >   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
> >   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
> >   	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
> > +	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC),
> >   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
> >   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
> >   	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> > index 44684bf1b9acc..c1e22c589d85e 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> > +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> > @@ -52,6 +52,7 @@
> >   #define BRCM_CC_43664_CHIP_ID		43664
> >   #define BRCM_CC_43666_CHIP_ID		43666
> >   #define BRCM_CC_4371_CHIP_ID		0x4371
> > +#define BRCM_CC_43752_CHIP_ID		43752
> I think this should be converted to hexadecimal to be consistent.
> >   #define BRCM_CC_4377_CHIP_ID		0x4377
> >   #define BRCM_CC_4378_CHIP_ID		0x4378
> >   #define BRCM_CC_4387_CHIP_ID		0x4387
> > @@ -94,6 +95,7 @@
> >   #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
> >   #define BRCM_PCIE_4371_DEVICE_ID	0x440d
> >   #define BRCM_PCIE_43596_DEVICE_ID	0x4415
> > +#define BRCM_PCIE_43752_DEVICE_ID	0x449d
> >   #define BRCM_PCIE_4377_DEVICE_ID	0x4488
> >   #define BRCM_PCIE_4378_DEVICE_ID	0x4425
> >   #define BRCM_PCIE_4387_DEVICE_ID	0x4433
> 

