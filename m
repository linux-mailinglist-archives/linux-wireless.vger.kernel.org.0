Return-Path: <linux-wireless+bounces-13274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C981D988ECD
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061861C20C11
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8BE19DF52;
	Sat, 28 Sep 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4CXk5OR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD519D8B8
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515541; cv=none; b=r3z9iAzpfNR09KaVHOZRx7ocaCkKJJVKET15LvRXJeFZoRM6W16mxkBf3nBeqH1/bvIWEI4rRWFmRlxK/E09XEBe/PwO488ywyChmoSpQJRWotWesSs/Azj3RI9OqroptXviJE42bH7+ZY1G4eG5PSghxlcXqpzhYOCAqHtRBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515541; c=relaxed/simple;
	bh=RTSIXYJVg1J54Vg06POAlgZCyQjSmDNTebc8pUKwVBM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ta12MB29KVNhjbyUkakLhuxRY+TSPNW9dcG5IzowF08mo8NpPeDC+siu3etxDWubCNj03m+a4iY8+rUFpblCAExGrNF1lxJPMLtoMBfaFdeQM66gRBuO92REIg4OnAci550eKtrPpMqKvZVGt1tFmWFa1arei30LZc0cS9ffFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4CXk5OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C7EC4CEC3;
	Sat, 28 Sep 2024 09:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727515540;
	bh=RTSIXYJVg1J54Vg06POAlgZCyQjSmDNTebc8pUKwVBM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=s4CXk5OR/xvxQxhkkFARzng/rb28T7m5tXVBACpcPX5EtRa+dNABTVRNsSIHHoJHx
	 7RAn2h73/H3xKBOhLTzxIv1jro2a2sOR+Y90JCa3VRg6nEWxr0Z1TXOj/HOUih5Rm1
	 DkJXErxujRFelBazG2tK6MyFCrrJMMY9T/fIUbprwrBksIDxPeGIHWNufvAzaPjtjC
	 e4Js/TQI5k1/IF2g1f9llNdzJs9viVhZYFCjsd/2QfnK3YSZvZkG4oh8sp03ItQAMv
	 MTIn/+YaVcFF2/Ib5hQxvNLiCdwvzjavRM21iN0QhhgOKPBd58bq0EfxZi9Dll5fr+
	 0/GnbJWcL5iXw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Skip Rx TID cleanup for self peer
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240905042851.2282306-1-quic_rgnanase@quicinc.com>
References: <20240905042851.2282306-1-quic_rgnanase@quicinc.com>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751553827.2272178.15822222576794808433.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:25:39 +0000 (UTC)

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> During peer create, dp setup for the peer is done where Rx TID is
> updated for all the TIDs. Peer object for self peer will not go through
> dp setup.
> 
> When core halts, dp cleanup is done for all the peers. While cleanup,
> rx_tid::ab is accessed which causes below stack trace for self peer.
> 
> WARNING: CPU: 6 PID: 12297 at drivers/net/wireless/ath/ath12k/dp_rx.c:851
> Call Trace:
> __warn+0x7b/0x1a0
> ath12k_dp_rx_frags_cleanup+0xd2/0xe0 [ath12k]
> report_bug+0x10b/0x200
> handle_bug+0x3f/0x70
> exc_invalid_op+0x13/0x60
> asm_exc_invalid_op+0x16/0x20
> ath12k_dp_rx_frags_cleanup+0xd2/0xe0 [ath12k]
> ath12k_dp_rx_frags_cleanup+0xca/0xe0 [ath12k]
> ath12k_dp_rx_peer_tid_cleanup+0x39/0xa0 [ath12k]
> ath12k_mac_peer_cleanup_all+0x61/0x100 [ath12k]
> ath12k_core_halt+0x3b/0x100 [ath12k]
> ath12k_core_reset+0x494/0x4c0 [ath12k]
> 
> sta object in peer will be updated when remote peer is created. Hence
> use peer::sta to detect the self peer and skip the cleanup.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1a0c640ce1cd wifi: ath12k: Skip Rx TID cleanup for self peer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240905042851.2282306-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


