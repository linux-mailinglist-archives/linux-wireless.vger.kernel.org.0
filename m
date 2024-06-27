Return-Path: <linux-wireless+bounces-9670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F591AE5F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 19:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3BF28235D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E098199EAA;
	Thu, 27 Jun 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSsLewCq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F81C6A7
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510240; cv=none; b=WQyvmNa70HAVPuaDhN+YiLV6ZBo67hPc8MvNp+DolMvg4GVmC+anplaQC6jgAKV+f5MFyX/wDnVCRaknd4W60wVCtLgS2NHrFbK5T36NgCVYmQNSRbRnUqs7eEDTci9WkI+pF59ZpwZ9EIfErbdZxLhFMU+888s7+nfGHqX+6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510240; c=relaxed/simple;
	bh=XGBF4GFzPS+lpA68bAhNFUcHmk0+0gf0K6RVl3Httmw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=I/t3ZXv1eiwSLdNxyVnV8Nn0tnOOAE4Pr4e3P9aNmUkDqpG+koKxdkzZXD4cbY5yf9xywXHymEGKcpQ7lP5k7kSmghmjlif7AjKdFqC/igjC+p1WFQqTWyHxH8q9GtJjHy1aLKhHnlLpFaKNaXz/pgSVIuNPWwchAE0sxqjjfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSsLewCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8566DC2BBFC;
	Thu, 27 Jun 2024 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510239;
	bh=XGBF4GFzPS+lpA68bAhNFUcHmk0+0gf0K6RVl3Httmw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NSsLewCqmaIaii72vpwEpE8/Nly5FkRszug9HhMhN1+TT7EcnnnOWJtXUyVhWzsF0
	 kRAidIj34Jadp77iomLAMxoDT9KgkqDU/uXPg+v+rv/jlc84ZvaEUTSrpvxZ5D0pCd
	 1BbPhvTKVZekbnbRJ6KizUy7LhyVfQSf+UqsyFBQcWDCBB4YLXtdQ7KhXyxgPNP3MF
	 6LvR1BUjSMf8qJI3lrZh441669FctXoCYzRsaaUgKjHQ2mZyvunlNsAYOj4EWDYSbv
	 C63gCc5rqE2e+dE+2Y8veu+PIp8izs0Uy6/oAhZIrTVFPAh3CrktsdrIz+/+H1Vt/e
	 C3ccZUzg9eGRA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/4] wifi: ath12k: add factory test mode support
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240624095305.37189-4-quic_aarasahu@quicinc.com>
References: <20240624095305.37189-4-quic_aarasahu@quicinc.com>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171951023642.2426772.2204079316674415145.kvalo@kernel.org>
Date: Thu, 27 Jun 2024 17:43:58 +0000 (UTC)

Aaradhana Sahu <quic_aarasahu@quicinc.com> wrote:

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
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Now that the wow patchset was applied I saw a new warning:

drivers/net/wireless/ath/ath12k/wow.c: In function 'ath12k_wow_op_resume':
drivers/net/wireless/ath/ath12k/wow.c:982:17: warning: enumeration value 'ATH12K_HW_STATE_TM' not handled in switch [-Wswitch]

I fixed it adding the new state to ath12k_wow_op_resume(), please check:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=882f310572b27564412e1d6158d1e9709861b7a7

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240624095305.37189-4-quic_aarasahu@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


