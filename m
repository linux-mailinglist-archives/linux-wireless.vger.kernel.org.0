Return-Path: <linux-wireless+bounces-9816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B09923B39
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62101F220C9
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B0E157492;
	Tue,  2 Jul 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Mu1rdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504912CD8B
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915526; cv=none; b=IfMQXvsuVvwE0vgc304MDtHlLv3UyQwm0CKlhzld0qa77DKjLTytOCvGAMSVy4B98x9WeXyXhqrwx3sC7QgqhzLPrYvJZd+FscYzW/33igGEhmqPQgaooyhua/4C1Df9PhQenOS9BzslpWO/XkWt3y2qnRVvAh7+d1x0gmM3mRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915526; c=relaxed/simple;
	bh=CRjzfm/cbEoxLAEG2O4pIEn5GWYKGji12h6CpdySr1M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dgRTc5Mxj/ACIAiXBa0FM1RaWA4Zav1o1+K5VVGIjj7WiAhANzojmMckw46fgB546ZKfr8SMbxOGNOiMqX5QL1e0LQN1czwvpPD9gjnxDAd+H00uWTdtALur2plNWZ+QylxZ6j8y/F2Us/G1dzTuFUZRNvxUX3iaqc3mRuI0yDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Mu1rdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23ABC116B1;
	Tue,  2 Jul 2024 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719915525;
	bh=CRjzfm/cbEoxLAEG2O4pIEn5GWYKGji12h6CpdySr1M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=o3Mu1rdm/jyfR8imds6yJmp1ckZY8qpqs0xLnpN1v9tGkY0kLbHPEOw/h2dFnbW5I
	 DFKLaE9xulAi2BAkwdQHWzLEKhv7/ez4B5ydj4Y+E2ujG9YFGvqisKKBd3VKb+ZRSG
	 m84xM5UVXmeaHf8/KfXqnmibLkjUwDKWork34nTIkxegWj9LO01pmII/C4Ka3YKRG/
	 e+EJ9wH/DvLLLw4y4egojSFk/NOL1FgPadfw5BDSg4ikCj8f2y4bEiXoJpsKvypS7J
	 2bBFUKAJ9JSIOZPLg/TzOnwrQD3vfdzevd9ZhNGZMSUDdkL8WVd+iK+OC8t2lnBWPi
	 8H1M/L1YebmwQ==
From: Kalle Valo <kvalo@kernel.org>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] wifi: ath12k: add factory test mode support
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
	<20240624095305.37189-4-quic_aarasahu@quicinc.com>
Date: Tue, 02 Jul 2024 13:18:42 +0300
In-Reply-To: <20240624095305.37189-4-quic_aarasahu@quicinc.com> (Aaradhana
	Sahu's message of "Mon, 24 Jun 2024 15:23:04 +0530")
Message-ID: <87plrwf665.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaradhana Sahu <quic_aarasahu@quicinc.com> writes:

> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with MISSION mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
>
> All ath12k test mode interface related commands specified in enum
> ath_tm_cmd.
>
> When start command ATH_TM_CMD_TESTMODE_START is received, ar state
> is set to test Mode and FTM daemon sends test mode command to wifi
> driver via cfg80211. Wifi driver sends these command to firmware as
> wmi events. If it is segmented commands it will be broken down into
> multiple segments and encoded with TLV header else it is sent to
> firmware as it is.
>
> Firmware response via UTF events, wifi driver creates skb and send
> to cfg80211, cfg80211 sends firmware response to FTM daemon via
> netlink message.
>
> Command to boot in ftm mode
> insmod ath12k ftm_mode=1
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -42,6 +42,10 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
>  	return ret;
>  }
>  
> +bool ath12k_ftm_mode;
> +module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
> +MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");

In the pending branch I moved these to the beginning of the file,
otherwise they are quite hidden:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=0006b23098b2cb0dded6c650ef9b5a590bfb5a3c

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

