Return-Path: <linux-wireless+bounces-1709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D282AD13
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29101C22513
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914E156E7;
	Thu, 11 Jan 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQSfgGDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB8156E6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 11:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF248C433F1;
	Thu, 11 Jan 2024 11:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704971580;
	bh=sVv7j68dcdbBAftknGw/qL2roISAV1FGQQP7EEfzQHI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GQSfgGDwku3tLvXFbKAQRUyRlpv1bIgp8C2oXJbtTMlqvVqvsnQrGjEG2A5aVQaxe
	 Mt/8/Vx3EabQa1YZGyUpSRFQ4YB3lTsLfJGeprQTe76kgXFQRGeKgB/U2qyMXd/g1v
	 WD7RkSTESsnY525HC//GVeqiiuq6RCPdE7e5SapJqs+TIV5s+aD+yUH08RvKgISNjd
	 AYfx9zztaiUSeQdymzS8Cz3sVCGq9QnKmB/BMGWODctrFKc5oYW+LXGAJt1/i/wfMu
	 +a4vb7rV8HFVjNP2rCnCvUxaIl337gbtEqn/lrVeloMmaDAkGAtNXWqnEkCsyPc45b
	 thDVjPvPBb0Pw==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] wifi: ath12k: report tx bitrate for iw dev xxx
 station dump
References: <20231225080723.9518-1-quic_lingbok@quicinc.com>
Date: Thu, 11 Jan 2024 13:12:57 +0200
In-Reply-To: <20231225080723.9518-1-quic_lingbok@quicinc.com> (Lingbo Kong's
	message of "Mon, 25 Dec 2023 03:07:23 -0500")
Message-ID: <877ckgazt2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> The tx bitrate of "iw dev xxx station dump" always show an invalid value
> "tx bitrate: 6.0MBit/s".
>
> To address this issue, parse the tx complete report from firmware and
> indicate the tx rate to mac80211.
>
> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
> tx bitrate: 104.0 MBit/s MCS 13
> tx bitrate: 144.4 MBit/s MCS 15 short GI
> tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
>
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

[...]

> +static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
> +{
> +	if (!ar->ab->hw_params->single_pdev_only)
> +		return;

I'm not really a fan of using single_pdev_only to check for other
features. Basically what this check implies is if we are using a mobile
chipset or not, right?

I can't test QCN9274 right now but why do we need this check? I would
hope that the firmware interface is designed so that this check is not
needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

