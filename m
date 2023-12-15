Return-Path: <linux-wireless+bounces-842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D796B814C31
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A8E1C23316
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8837E39FC3;
	Fri, 15 Dec 2023 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnMuWxHY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F173381C8
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 15:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEDCC433C7;
	Fri, 15 Dec 2023 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702655887;
	bh=+SRuaRH9TFJnZpf+5dCEqvsOBgddW5XNqa4kkhWfp5Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DnMuWxHYPQ1SWa74i4dIJR9ddfxawsxak03jSekaF2Pt2+9EqPz5WJdQjQQZ+/Qe4
	 IFQQUINLMnk6k/VnXoYMDFEtNJzAWwoVeUM2TuOURg84QwS5atbe93SScSl6naR0Yz
	 yUwwPmU52mTMECqWm6ujM2WDcUK8HAlfZs5TRBM80oZY9lqD0QwOwj8lv3KmceWKq7
	 BbrP2cYJShUkJYTd1nTTFJNJVSFYCZjC1krW2MVEQ+xFkto6DLLdlkDCscckaYsv/8
	 seWdelRLTGkJvoheAH7CGQS53SEN4T/y3vYkPa/U3VHR4QFNsSER3vWaDgjJpVHWUv
	 LjFKmuS7JGXQg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP
 IRQ"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231214053215.2087308-1-quic_periyasa@quicinc.com>
References: <20231214053215.2087308-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>,
 "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170265588405.1834402.8684389045597196068.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 15:58:05 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> This reverts commit 1f1f7d548a00ebe50808cb1f580df9693e194a7c. The commit
> caused bootup failure on QCN9274 hw2.0 platform. Incorrect hardcode DP
> irq offset overwrite the CE irq, which caused the driver to miss the
> mandatory bootup message from the firmware through the CE interrupt. This
> occurs because the CE count differs between platforms. The revert has no
> impact since the original change was based on an incorrect assumption.
> 
> Log:
> 
> ath12k_pci 0000:06:00.0: fw_version 0x1011001d fw_build_timestamp 2022-12-02 01:16 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> ath12k_pci 0000:06:00.0: failed to receive control response completion, polling..
> ath12k_pci 0000:06:00.0: Service connect timeout
> ath12k_pci 0000:06:00.0: failed to connect to HTT: -110
> ath12k_pci 0000:06:00.0: failed to start core: -110
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e75fda64f0fe Revert "wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231214053215.2087308-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


