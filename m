Return-Path: <linux-wireless+bounces-426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C0C805843
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8CB281D0F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4167E88;
	Tue,  5 Dec 2023 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2bHu2G/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2555C1F
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 15:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD14C433C7;
	Tue,  5 Dec 2023 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701789000;
	bh=YpmLEyUZCZpUEOzslM23kiDsHRP5zwc+nXw2molgSLw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=p2bHu2G/hNeE3aWt/FUmXv2emFu3yXIztnALlPyTeBsZieTbj9HEH5iyLg9kKm6Z/
	 auZcN3cNcKiRe06W/n5DjLwLzla8cStz+ZJNSyDS10ApGiDtZD1oOU97h6YAZfpyX4
	 tYHLjge0rde5ZcJQHm+1KBW0tb+KjmlkxRbAsUvR0Pl6EWgdqhyaznXXZ6E2v+1AEw
	 Xi1ZFFj4nUJYneLbi2KeUM4RPz3cYkwif5D3LNZeDn4ENykYxp3PBzHbj3GDLKOR51
	 1TmVWBeu0zRmDvK92HhBYwteSNRlgJTu5mJFgoVN2k+J3lWKGPnr4JpbGh8y1/EpSS
	 bcQtYCVDBdJ3Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: fix and enable AP mode for WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231121022459.17209-1-quic_kangyang@quicinc.com>
References: <20231121022459.17209-1-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170178899778.2418939.15506998345561558345.kvalo@kernel.org>
Date: Tue,  5 Dec 2023 15:09:59 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> For AP mode, the peer is created earlier in ath12k_mac_op_add_interface() but
> ath12k_mac_op_assign_vif_chanctx() will try to create peer again.  Then an
> error will return which makes AP mode startup fail.
> 
> Kernel log:
> 
> [ 5017.665006] ath12k_pci 0000:04:00.0: failed to create peer after vdev start delay: -22
> 
> wpa_supplicant log:
> 
> Failed to set beacon parameters
> Interface initialization failed
> wls1: interface state UNINITIALIZED->DISABLED
> wls1: AP-DISABLED
> wls1: Unable to setup interface.
> Failed to initialize AP interface
> wls1: interface state DISABLED->DISABLED
> wls1: AP-DISABLED
> 
> So fix this check and enable AP mode for WCN7850, as now AP mode works normally.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ed7e818a7b50 wifi: ath12k: fix and enable AP mode for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231121022459.17209-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


