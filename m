Return-Path: <linux-wireless+bounces-1473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB390823C14
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 07:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26591C24AB3
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 06:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C8518EC3;
	Thu,  4 Jan 2024 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC75+Ocf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E518EA8;
	Thu,  4 Jan 2024 06:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5395C433C8;
	Thu,  4 Jan 2024 06:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704348552;
	bh=Ko5iXtApY0EshgnOz1TdDJDaIgaK62Wjlz/YlsDmp/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZC75+OcfCxOYgSYIsmIqVLQPOXEK02OfoMCF4zLeWMpoOc9hce4fEKk09/oCVdbj0
	 jfNJc+AsT43AjBnCpcgcL5YCEs+2tPJlJG5VGGESkQwdsGH38JgIXfR2RswM6Cn6ht
	 mNfTIb/8JvEMElb+XNCVBDYBTPLw3O/V53NvJt4FQE6PZ7VzlcMzkkoDnow/4uTgmH
	 XTLhxbiBJ4QwEdILJfH4mSEXyCOINZrZPYDbXzZvCvZl08VKuLC/nFUYcu1Si/SPey
	 3OKXBBKXZMHaTKUVSW3z74P0XHoSN0E7IhZ+dATWdi1+lbcOpchX3AzcHuLIkfJm2W
	 JUpTHlVHvNfJw==
Date: Thu, 4 Jan 2024 11:39:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	mhi@lists.linux.dev, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] bus: mhi: host: add
 mhi_power_down_no_destroy()
Message-ID: <20240104060904.GB3031@thinkpad>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-2-kvalo@kernel.org>
 <20231130054250.GC3043@thinkpad>
 <87v89cq1ci.fsf@kernel.org>
 <20231220163209.GJ3544@thinkpad>
 <20231220165113.GK3544@thinkpad>
 <7a31696b-cf2b-48c0-bad3-327e9ce47172@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a31696b-cf2b-48c0-bad3-327e9ce47172@quicinc.com>

On Thu, Dec 21, 2023 at 07:05:09PM +0800, Baochen Qiang wrote:
> 
> 
> On 12/21/2023 12:51 AM, Manivannan Sadhasivam wrote:
> > On Wed, Dec 20, 2023 at 10:02:25PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Dec 05, 2023 at 02:29:33PM +0200, Kalle Valo wrote:
> > > > Manivannan Sadhasivam <mani@kernel.org> writes:
> > > > 
> > > > > On Mon, Nov 27, 2023 at 06:20:15PM +0200, Kalle Valo wrote:
> > > > > 
> > > > > > From: Baochen Qiang <quic_bqiang@quicinc.com>
> > > > > > 
> > > > > > If ath11k tries to call mhi_power_up() during resume it fails:
> > > > > > 
> > > > > > ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
> > > > > > 
> > > > > > This happens because when calling mhi_power_up() the MHI subsystem eventually
> > > > > > calls device_add() from mhi_create_devices() but the device creation is
> > > > > > deferred:
> > > > > > 
> > > > > > mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
> > > > > > 
> > > > > > The reason for deferring device creation is explained in dpm_prepare():
> > > > > > 
> > > > > > 	/*
> > > > > > 	 * It is unsafe if probing of devices will happen during suspend or
> > > > > > 	 * hibernation and system behavior will be unpredictable in this case.
> > > > > > 	 * So, let's prohibit device's probing here and defer their probes
> > > > > > 	 * instead. The normal behavior will be restored in dpm_complete().
> > > > > > 	 */
> > > > > > 
> > > > > > Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not called and
> > > > > > qcom_mhi_qrtr_dl_callback() fails silently as qdev is zero:
> > > > > > 
> > > > > > static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
> > > > > > 				      struct mhi_result *mhi_res)
> > > > > > {
> > > > > > 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> > > > > > 	int rc;
> > > > > > 
> > > > > > 	if (!qdev || mhi_res->transaction_status)
> > > > > > 		return;
> > > > > > 
> > > > > > So what this means that QRTR is not delivering messages and the QMI connection
> > > > > > is not working between ath11k and the firmware, resulting a failure in firmware
> > > > > > initialisation.
> > > > > > 
> > > > > > To fix this add new function mhi_power_down_no_destroy() which does not destroy
> > > > > > the devices during power down. This way mhi_power_up() can be called during
> > > > > > resume and we can get ath11k hibernation working with the following patches.
> > > > > > 
> > > > > > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > > > > > 
> > > > > > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> > > > > > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> > > > > 
> > > > > Any reason for reposting this series without discussing the suggestion from
> > > > > Mayank?
> > > > 
> > > > Baochen quickly sent me fixes for the v1 review comments, as I have been
> > > > out of office for some time I didn't want to sit on Baochen's fixes for
> > > > too long. Better to get them out of the door as soon as possible. I will
> > > > definitely look at Mayank's proposal but that will take longer.
> > > > 
> > > > > As I said in the internal thread, this patch breaks the Linux device
> > > > > driver model by not destroying the "struct device" when the actual
> > > > > device gets removed.
> > > > 
> > > > This patchset has been tested by several people, I'm even using this
> > > > patchset on main laptop every day, and we haven't noticed any issues.
> > > > 
> > > > Can you elaborate more about this driver model? We are not removing any
> > > > ath11k devices, we just want to power down the ath11k (and in the future
> > > > ath12k) devices for suspend and power up during resume.
> > > > 
> > > 
> > > Devices (struct dev) for each channels are created once the device (WLAN) enters
> > > runtime mode such as (MISSION, SBL etc...). During hibernation, ath11k stack
> > > calls mhi_power_down() which essentially resets the device to POR and also the
> > > stack powers down the device properly.
> > > 
> > > In that case, MHI channels do not exist as the device (WLAN) itself is powered
> > > down. As per kernel driver model, each struct device is tied to its reference
> > > count. And the reference count should be decremented whenever the actual device
> > > is not in use. Once the actual device is removed from the system, then the
> > > respective struct device has to be destroyed altogether.
> > > 
> > > So in this case, even though the channels are not active (present) in the
> > > device, the device itself gets powered off, you want MHI stack to keep the
> > > struct device active, which is against the model I referenced above.
> > > 
> > > To fix this issue properly, we need to investigate on how other subsystems are
> > > handling this situation (device getting powered down during hibernation), like
> > > USB.
> > > 
> > 
> > To me it all sounds like the probe deferral is not handled properly in mac80211
> > stack. As you mentioned in the commit message that the dpm_prepare() blocks
> > probing of devices. It gets unblocked and trigerred in dpm_complete():
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/main.c#n1131
> > 
> > So if mac80211/ath11k cannot probe the devices at the dpm_complete() stage, then
> > it is definitely an issue that needs to be fixed properly.
> To clarify, ath11k CAN probe the devices at dpm_complete() stage. The
> problem is kernel does not wait for all probes to finish, and in that way we
> will face the issue that user space applications are likely to fail because
> they get thawed BEFORE WLAN is ready.
> 

Hmm. Please give me some time to reproduce this issue locally. I will get back
to this thread with my analysis.

- Mani

> > 
> > - Mani
> > 
> > > - Mani
> > > 
> > > > > We should try to explore alternate options instead of persisting with
> > > > > this solution.
> > > > 
> > > > What other options we have here? At least Baochen is not optimistic that
> > > > using PM_POST_HIBERNATION as a workaround would work. The issue we have
> > > > here is that mhi_power_up() doesn't work in the resume handler and
> > > > that's what we should try to fix, not make workarounds.
> > > > 
> > > > -- 
> > > > https://patchwork.kernel.org/project/linux-wireless/list/
> > > > 
> > > > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

