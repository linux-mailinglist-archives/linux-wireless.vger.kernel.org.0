Return-Path: <linux-wireless+bounces-3142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1184A026
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 18:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6A31C21A2C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C613FE5F;
	Mon,  5 Feb 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1FkzKYi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764463FE44
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152459; cv=none; b=m8hde0PX3H2hRQEv6dCG+M9qYH7WfuEzU26vyza0lus3vgdWcZwKMiq1alYgR0SAz+VRcW2J+bS7rVQviZHJ+lF3DbHpkNyJgcfzH+T9kNpT62yNS8UVbnwSLxd+MA+8sDDKK75ZUU3lx35MPow6pkb+yb2preVRQgJE2+svB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152459; c=relaxed/simple;
	bh=ZrSDvmtwP1vUXi1nbdBJZyeQyjUOwBdLUaOYkUs5j0k=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=dvtjPdEDCxtVdrRUXgGdWXIzpkuZGowS9RuAaoyWXYoBo8S6vmzUaN7QoLpaxe1Mwdlkbg+4g4M8X2q79XXXqXkZWRpuR/t6hIRKyD4266cWZNVaZ+nbnlnw7XiqhjpX+l7uCWekXoxURCv7GFS251Wr7kU5/gHgKeqsMnqD59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1FkzKYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C174C433F1;
	Mon,  5 Feb 2024 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707152459;
	bh=ZrSDvmtwP1vUXi1nbdBJZyeQyjUOwBdLUaOYkUs5j0k=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=u1FkzKYiHwLYISmv984jE0qkxNgKLJWgFDoUEY9K7+WnbNaQxTj/J56f3i6HFsK7w
	 rfOIUBIfFkBRHsKHL6IbhSX+63JNSmWiXzhUEZ0Yl5EkP3+7f3PucYtAYfY9cNR+x2
	 QmCuGkZPBP1GIgqvBmR3Vp7WbMDedJ+9jYNkwBdmrS/UhmLTAuHh4hCRnFR+GIg0UG
	 j62KPnb0AgBwX5PyUVXt8EktY0U0tZL5HVZG6/kjmknHsx3CHjVC6kPWu5uOr1q8r/
	 5Kj4jlnCkdYfJDuh5XXXRdQ1W+3uPvlwQvIWxxMiZwxToieswDqYwMpau/4oiiM3BF
	 CDiWT8C3L14JA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: initialize eirp_power before use
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240202024011.11341-1-quic_bqiang@quicinc.com>
References: <20240202024011.11341-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715245648.1233901.14417827801031466925.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 17:00:58 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently, at the end of ath11k_mac_fill_reg_tpc_info(), the
> reg_tpc_info struct is populated, including the following:
>         reg_tpc_info->is_psd_power = is_psd_power;
>         reg_tpc_info->eirp_power = eirp_power;
> 
> Kernel test robot complains on uninitialized symbol:
> drivers/net/wireless/ath/ath11k/mac.c:7949
> ath11k_mac_fill_reg_tpc_info() error: uninitialized symbol 'eirp_power'.
> 
> This is because there are some code paths that never set eirp_power, so
> the assignment of reg_tpc_info->eirp_power can come from an
> uninitialized variable. Functionally this is OK since the eirp_power
> only has meaning when is_psd_power is true, and all code paths which set
> is_psd_power to true also set eirp_power. However, to keep the robot
> happy, always initialize eirp_power before use.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: 92425f788fee ("wifi: ath11k: fill parameters for vdev set tpc power WMI command")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401311243.NyXwWZxP-lkp@intel.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b82fb7ef690b wifi: ath11k: initialize eirp_power before use

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240202024011.11341-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


