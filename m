Return-Path: <linux-wireless+bounces-9613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E8918820
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 19:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BC928233B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9918A930;
	Wed, 26 Jun 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEjtRCca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626E13AA4C
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421439; cv=none; b=m5gQJ+RE4es9WG1RQkY/hoOlcIagpycnjLPX9+7/ks31CIUEv5JVmeRtTo9L69BdCXyUtNmTlytANSHSryZztWR4b8F/ZF6yMCRKDnqYK0TFMN+QobQaxEmbhrohDipViSks4caK1Ocip+SU+wuV83kyP/Rbn3n1phoPK+gPsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421439; c=relaxed/simple;
	bh=O/JMJLqh89mNtl6LKLku7p7JoYjoNabBTBJGMNJ9xV8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=j7xEaLIF/VE/GJqgkt4I50bI8uXddUUXa8QNnzhu7PO22PXMYJ3CdRBuwZFvMxnbAsjuXRP8jrDmYXBIpp92nFCrfOZ52qVqWzycV4HAyh2yESyXd0ajGYUPJpXN6kXW1SNQbR99Fb4Js8yQrVcxTOAgV1H0PwmHcZz1+pBcXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEjtRCca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32165C116B1;
	Wed, 26 Jun 2024 17:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719421439;
	bh=O/JMJLqh89mNtl6LKLku7p7JoYjoNabBTBJGMNJ9xV8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pEjtRCcaVMK3g0o0DgpUtD2426dTbxm+qQJubHIWJFd4gKoJMseBiWG1fKAKAYKay
	 zl9g0U/+giszXpRRQBjrOLIl/9//hc0V5Oc3qICA4PmnFMfSJURKKoaEUjTAP5ZDFm
	 KZKvHM6UTw2PT5L4bTLQNU/UdNceNnujZwqZLoAf/rNFDdma9ZftqrLikm893T2J14
	 dnrtVbbEfIeErg9xAu10qKL/eptEV/MuNzZkD3u5M3VwTNCEakeYmipS3RhkVSSM46
	 VG8ei1wmzTH+bYrMZi1FNB32b2l6BrhJOm7ypzk+9Kgnv+xeFpK71ac3B2cxbjuyON
	 6NjuP+eZKB1qg==
From: Kalle Valo <kvalo@kernel.org>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] ath12k: Factory test mode support
References: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
Date: Wed, 26 Jun 2024 20:03:56 +0300
In-Reply-To: <20240611083427.881443-1-quic_aarasahu@quicinc.com> (Aaradhana
	Sahu's message of "Tue, 11 Jun 2024 14:04:23 +0530")
Message-ID: <87v81vhc03.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaradhana Sahu <quic_aarasahu@quicinc.com> writes:

> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
>
> Also added changes related to correct pdev id access for
> fw test cmd.
>
> Aaradhana Sahu (3):
>   wifi: ath: create common testmode_i.h file for ath drivers
>   wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>   wifi: ath12k: add factory test mode support
>
> Rajat Soni (1):
>   wifi: ath12k: Fill pdev id for fw test cmd

BTW these are now in pending branch, there were some conflict but a new warning
because of wow patches. No need to resend because of this, I'll fix the
warning later.

drivers/net/wireless/ath/ath12k/wow.c: In function 'ath12k_wow_op_resume':
drivers/net/wireless/ath/ath12k/wow.c:982:17: warning: enumeration value 'ATH12K_HW_STATE_TM' not handled in switch [-Wswitch]
  982 |                 switch (ah->state) {
      |                 ^~~~~~


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

