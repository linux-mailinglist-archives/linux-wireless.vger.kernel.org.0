Return-Path: <linux-wireless+bounces-6771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023938B0E7C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F36B23248
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897A16C87E;
	Wed, 24 Apr 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXL8SPOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465916C868
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972746; cv=none; b=vFkudybWg+myCUiNgeOYBKPRBe2hdR2yuVFRvU/L4/oMqtpdL0OFu17jSutsQf3cJ/CfB0ow8UeY1jDQpndeADMPZcdkR2zYdrqyPNiyL1KA7exHrSoOUNOw4m4dD92GlSWAE7aOHZy+jJy6Sr0i09+ISuJIcr7mr/GVsZmDQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972746; c=relaxed/simple;
	bh=XrkNSGs3Aj/yb8aXtepxwow2X1by+i5AVY6vSibR06Q=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UMeKWdhMCaMe8MriqFlmddZnaInt6zcSu53DbPkDWq9mXleJIlAydgkzBvXsU9K7Vir1gBLhqyKHRYnW61Ug/yUPsf6pScIH24seT40uhj6IAyQZOL/SlKxZ3yqqeiRVm3vI3y+JhCDxYyznNNAUr79lqVYdDn2PIaHbp7kqs4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXL8SPOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A4C113CD;
	Wed, 24 Apr 2024 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972745;
	bh=XrkNSGs3Aj/yb8aXtepxwow2X1by+i5AVY6vSibR06Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rXL8SPOiImbcI6Bgo9igIAdFFaWx4cUTjjxmI7akFGVewG1l+s3sioGMyDzBIfemO
	 5hu02/2kQHjqE5rnq/9Bgi3j0pU/0sWBmV6GZI2+QttJKMWYE7VFvT7lJDamf1nmsm
	 fY4bCE1MkvRWpFLKbP72Fd7G1BSv7cxLTh/qQJXDJ+6ACo+OhjGgJyJp0h5FQ80YMx
	 oLEwTXYROpgq6Z3E7cvlMhuRqccNBW2h3GKlTibncjZBVDhyGsVVStbr1eyU59/XM5
	 CB4sq9qtTSt8aQMQgXTDsDOG2Th+JEgSQcc4H2X0jx7fZ9leeD/asEVM9AH+F/gHEb
	 rEYmgV8DDqvJA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath12k: add support to handle beacon miss for
 WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240412094447.2063-1-quic_kangyang@quicinc.com>
References: <20240412094447.2063-1-quic_kangyang@quicinc.com>
To: kangyang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171397274283.2560403.15597584841282293691.kvalo@kernel.org>
Date: Wed, 24 Apr 2024 15:32:24 +0000 (UTC)

kangyang <quic_kangyang@quicinc.com> wrote:

> When AP goes down or too far away without indication to STA, beacon miss
> will be detected. Then for WCN7850's firmware, it will use roam event
> to send beacon miss to host.
> 
> If STA doesn't handle the beacon miss, will keep the fake connection
> and unable to roam.
> 
> So add support for WCN7850 to trigger disconnection from AP when
> receiving this event from firmware.
> 
> It has to be noted that beacon miss event notification for QCN9274
> to be handled in a separate patch as it uses STA kickout WMI event
> to notify beacon miss and the current STA kickout event is processed
> as low_ack.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Reviewed-by: Nicolas Escande <nico.escande@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b0afabc4d7e0 wifi: ath12k: add support to handle beacon miss for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240412094447.2063-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


