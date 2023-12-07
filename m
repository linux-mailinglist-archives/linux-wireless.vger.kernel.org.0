Return-Path: <linux-wireless+bounces-535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86866808557
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 11:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B8D2840BF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 10:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE30B358AC;
	Thu,  7 Dec 2023 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rReyZYmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D672FE31
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 10:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B360C433C7;
	Thu,  7 Dec 2023 10:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701944523;
	bh=HfPeOFXnUyuobRLGh3W2dRopxfDShSw6rxFDu6ydUzg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rReyZYmKGctYOoiHMZyyNdgA7LMBvTHwPxA+WYebfYZ8c7PuP+33wgVihL3wZTFGe
	 AbAS9cWfJnLjWet2QBj1gUOnijwDbfT4GUIYSvzbsbT255PP6bEuzmtks+jJkAF8WR
	 o3ZPPMIzzd2YUwmgKztv/YzOI8krgGYit9I0j1NRBu7Gf9rDd6nQCRmmqYG2V4FDAk
	 fs5Dr349vDUYLeFpOaIwh6VJNBFqGX8vDaJmFpQjTWXwXG356YQ5j5DQapcEWGCqrd
	 BBkM8L+r5NTHbbOY8bQ7A+yh0oNXkzuDXvUxebvyhi/3wwQYtoEF4e40Qd3xeZz6Gk
	 d1/8TTQqf/1jQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231206134654.24662-1-quic_lingbok@quicinc.com>
References: <20231206134654.24662-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170194452077.2749331.9096558532469392640.kvalo@kernel.org>
Date: Thu,  7 Dec 2023 10:22:02 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

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
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

Fails to compile. Makes me wonder how did you even test this?

drivers/net/wireless/ath/ath12k/mac.c:7743:20: error: conflicting types for 'ath12k_mac_he_gi_to_nl80211_he_gi' due to enum/integer mismatch; have 'enum nl80211_he_gi(u8)' {aka 'enum nl80211_he_gi(unsigned char)'} [-Werror=enum-int-mismatch]
 7743 | enum nl80211_he_gi ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/wireless/ath/ath12k/mac.c:9:
drivers/net/wireless/ath/ath12k/mac.h:79:5: note: previous declaration of 'ath12k_mac_he_gi_to_nl80211_he_gi' with type 'u32(u8)' {aka 'unsigned int(unsigned char)'}
   79 | u32 ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[7]: *** [scripts/Makefile.build:243: drivers/net/wireless/ath/ath12k/mac.o] Error 1
make[6]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath/ath12k] Error 2
make[5]: *** [scripts/Makefile.build:480: drivers/net/wireless/ath] Error 2
make[4]: *** [scripts/Makefile.build:480: drivers/net/wireless] Error 2
make[3]: *** [scripts/Makefile.build:480: drivers/net] Error 2
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[1]: *** [/home/kvalo/projects/atheros/ath10k/src/ath/Makefile:1913: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231206134654.24662-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


