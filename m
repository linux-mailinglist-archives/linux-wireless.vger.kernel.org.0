Return-Path: <linux-wireless+bounces-1976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2027282EED7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 13:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4268A1C22E92
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62C1B97B;
	Tue, 16 Jan 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXYZrAAg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C731B96D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 12:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEACEC433C7;
	Tue, 16 Jan 2024 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705407721;
	bh=dR8CBQ3B2SO+JTqS8n8ZkaY08urpncIcQX5n8mMD14I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HXYZrAAgTzgRtdedMEO6qtsZk9H9tShl1+DbO23j7R174H6j7RUK5TVwkoJ7YjlxL
	 sKgp0H2TKNHZCJpjCXG0JLJkgFUVoOG/Vdc0YL/uSmI0E9ieMS5r2O0xHYVheJXioO
	 ddMYtMVq52Ve7cdh17svYu6PouBdiG1MHKcXdTuiSpwLvpu4y3s2VYo9OjkPxcGar8
	 jJY0UOy6bg3UPebcZMVFxumX7zRLritzzNBQul61NATWWFKgCVrcmcR9anPR4VR7ed
	 JL0ixTHT3/UH+4iItKi91EYUCvQ/kZo/tAlZ9dUtRuSKexvGEOgbRQ/f8BVmXR7De3
	 rBcj3y5WAIsRQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] wifi: ath12k: Refactor mac callback of config
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240103063731.3356060-2-quic_periyasa@quicinc.com>
References: <20240103063731.3356060-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170540771884.1846129.16513288629933447199.kvalo@kernel.org>
Date: Tue, 16 Jan 2024 12:22:00 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> To support single wiphy abstraction, introduce link/radio specific helper
> function in the mac80211 callback config(). This way, the callback can be
> extended to handle multiple link/radio in the future.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

10 patches applied to ath-next branch of ath.git, thanks.

3e141f0034d5 wifi: ath12k: refactor ath12k_mac_op_config()
ce20a10fdff4 wifi: ath12k: refactor ath12k_bss_assoc()
00c9b1a6d21d wifi: ath12k: refactor ath12k_mac_op_conf_tx()
e1e275a69906 wifi: ath12k: refactor ath12k_mac_op_start()
3bbc9c7429ff wifi: ath12k: refactor ath12k_mac_op_stop()
92b30bb39786 wifi: ath12k: refactor ath12k_mac_op_update_vif_offload()
d629b0c149c9 wifi: ath12k: refactor ath12k_mac_op_configure_filter()
5b1b5dbfd6a6 wifi: ath12k: refactor ath12k_mac_op_ampdu_action()
b33dcbe8d53d wifi: ath12k: refactor ath12k_mac_op_flush()
5bdfb8c9db22 wifi: ath12k: ath12k_start_vdev_delay(): convert to use ar

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240103063731.3356060-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


