Return-Path: <linux-wireless+bounces-421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B6805426
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 13:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E5928172A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28C5B5B9;
	Tue,  5 Dec 2023 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1PNPdrg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED913B798;
	Tue,  5 Dec 2023 12:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC69AC433C7;
	Tue,  5 Dec 2023 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701779376;
	bh=sQfnpXdP3ZuhtY6P7yHJiQsXf+TlE9wlb2bR43cDiMM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=K1PNPdrg+nKHRnEPaHvq1lvbaaQs0VkDae7/YEVtktDoMCG2Tr3gdxOH9//bWObym
	 PsvVVgP13UrWiGV6TdoSBtPHPli0/bosbyB0QpnCAmQabrMlHd47JcIh52KySaYm3z
	 pGCpKvalVR3vVO1O9/fDjnWoQCjlH7Crw9fJiCCkwymSEoaxL7hge3t/AdgtscjjFP
	 Jm6Zs2Z4vhqF9slH2xwgIIDvNasmugdaxDMDimVwGr4xP9nqeH7jAzxwQR/ysVmbtC
	 UI4hSONLCyr5EyX+UDz02VjQr98cvXEq3vr+dzyHz20HRhxu5VU4bH75hZ6/NxVmVJ
	 ZI+pGsw38nKMA==
From: Kalle Valo <kvalo@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev,  ath11k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] bus: mhi: host: add mhi_power_down_no_destroy()
References: <20231127162022.518834-1-kvalo@kernel.org>
	<20231127162022.518834-2-kvalo@kernel.org>
	<20231130054250.GC3043@thinkpad>
Date: Tue, 05 Dec 2023 14:29:33 +0200
In-Reply-To: <20231130054250.GC3043@thinkpad> (Manivannan Sadhasivam's message
	of "Thu, 30 Nov 2023 11:12:50 +0530")
Message-ID: <87v89cq1ci.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manivannan Sadhasivam <mani@kernel.org> writes:

> On Mon, Nov 27, 2023 at 06:20:15PM +0200, Kalle Valo wrote:
>
>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>> 
>> If ath11k tries to call mhi_power_up() during resume it fails:
>> 
>> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
>> 
>> This happens because when calling mhi_power_up() the MHI subsystem eventually
>> calls device_add() from mhi_create_devices() but the device creation is
>> deferred:
>> 
>> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
>> 
>> The reason for deferring device creation is explained in dpm_prepare():
>> 
>> 	/*
>> 	 * It is unsafe if probing of devices will happen during suspend or
>> 	 * hibernation and system behavior will be unpredictable in this case.
>> 	 * So, let's prohibit device's probing here and defer their probes
>> 	 * instead. The normal behavior will be restored in dpm_complete().
>> 	 */
>> 
>> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not called and
>> qcom_mhi_qrtr_dl_callback() fails silently as qdev is zero:
>> 
>> static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
>> 				      struct mhi_result *mhi_res)
>> {
>> 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
>> 	int rc;
>> 
>> 	if (!qdev || mhi_res->transaction_status)
>> 		return;
>> 
>> So what this means that QRTR is not delivering messages and the QMI connection
>> is not working between ath11k and the firmware, resulting a failure in firmware
>> initialisation.
>> 
>> To fix this add new function mhi_power_down_no_destroy() which does not destroy
>> the devices during power down. This way mhi_power_up() can be called during
>> resume and we can get ath11k hibernation working with the following patches.
>> 
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>> 
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> Any reason for reposting this series without discussing the suggestion from
> Mayank?

Baochen quickly sent me fixes for the v1 review comments, as I have been
out of office for some time I didn't want to sit on Baochen's fixes for
too long. Better to get them out of the door as soon as possible. I will
definitely look at Mayank's proposal but that will take longer.

> As I said in the internal thread, this patch breaks the Linux device
> driver model by not destroying the "struct device" when the actual
> device gets removed.

This patchset has been tested by several people, I'm even using this
patchset on main laptop every day, and we haven't noticed any issues.

Can you elaborate more about this driver model? We are not removing any
ath11k devices, we just want to power down the ath11k (and in the future
ath12k) devices for suspend and power up during resume.

> We should try to explore alternate options instead of persisting with
> this solution.

What other options we have here? At least Baochen is not optimistic that
using PM_POST_HIBERNATION as a workaround would work. The issue we have
here is that mhi_power_up() doesn't work in the resume handler and
that's what we should try to fix, not make workarounds.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

