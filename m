Return-Path: <linux-wireless+bounces-3292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C70684CDA8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 16:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334811F238D6
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DED7E77F;
	Wed,  7 Feb 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryM9v1pm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404DE76C6F
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318448; cv=none; b=ojiGNfAug+J+op0UP+QIRa6xgO7IeubS4QY/bBQB+MNhbQ4L9cawrcPpcaVMT4dwP59I1kHvXiw8ggOw7jSuabG7BcRwFWPcPkga5rVTMDE8qJGZ79gr2Q5Hqw/HFNkxadvDqxP/20D8Gx1Yd0TnCOC/itcVKoCJjUZnKJiZqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318448; c=relaxed/simple;
	bh=Uan/Q0Q/Kd3LAVTiDWGEOTgNM9yrcvXDA8uVoN+txvs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Tj6CdbNE2U7R4ySaTVfweJNIOPWzMdhiwjFfoXzeCTwGZ8K0gkWq8spqfyVsSBd2qk6fU8lcyEz2U4HpL+lEuQ3Vpj6iN0iuIACvw0X75G8If12DarmFA6j/jotyiVR+bmG8R/Wo/ua3ySVyDdbiimpNw3blEpLOIFlPWk27Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryM9v1pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C404CC433C7;
	Wed,  7 Feb 2024 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318447;
	bh=Uan/Q0Q/Kd3LAVTiDWGEOTgNM9yrcvXDA8uVoN+txvs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ryM9v1pmg05T+lGq3uWagDc6CPJIPOSNi6YpyOlZErZ3WQ/nm+zM4sdBouNbnsL14
	 iFrKkQlPSkfZ3R27P7crodhPfE0U/JLSxFnBHYC5Yq8N64ALCuxG++9Xig3p3994rt
	 TgQzQRtsWs9AGHIHsufaX0mvhz8U3GuvcQoNeIxzaGGyb1AvET79yjB6u4s973YqQ7
	 G+tWyc567A4+J+duliNfrQj5gqvNPoxtSpaylI8cv95jxvOsNML09JTbUs9CbYYV5w
	 HcBdLnWPtUdMtznlw1S5vq+Bw4lL+pxjm4U3LcXsS5LRIWdrkX8Ly2eBUejjvgWi06
	 hkz3BphPc5v2Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/11] wifi: ath12k: fix broken structure
 wmi_vdev_create_cmd
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240130040303.370590-2-quic_kangyang@quicinc.com>
References: <20240130040303.370590-2-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170731844476.2220494.14154220146045485839.kvalo@kernel.org>
Date: Wed,  7 Feb 2024 15:07:26 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> Current structure wmi_vdev_create_cmd is not matched to the firmware
> definition. So update it.
> 
> And update vdev_stats_id_valid for vdev_stats_id.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

11 patches applied to ath-next branch of ath.git, thanks.

4f684533afe2 wifi: ath12k: fix broken structure wmi_vdev_create_cmd
019b58dcb6ed wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
ef860c6a3adf wifi: ath12k: change interface combination for P2P mode
575ec73cb880 wifi: ath12k: add P2P IE in beacon template
9411eecb60cb wifi: ath12k: implement handling of P2P NoA event
2830bc9e784f wifi: ath12k: implement remain on channel for P2P mode
28035a88f8b3 wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
32e7b12e2611 wifi: ath12k: allow specific mgmt frame tx while vdev is not up
c9e4e41e71ff wifi: ath12k: move peer delete after vdev stop of station for WCN7850
cf0425eead75 wifi: ath12k: designating channel frequency for ROC scan
e65a63986575 wifi: ath12k: advertise P2P dev support for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240130040303.370590-2-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


