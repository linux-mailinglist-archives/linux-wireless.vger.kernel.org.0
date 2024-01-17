Return-Path: <linux-wireless+bounces-2083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69076830160
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 09:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078121F24EE7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA011C86;
	Wed, 17 Jan 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRGZW1wa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58311C80
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480626; cv=none; b=EKmBYamQXcVJ5N7D/5HqoofucvykQtXTA71IhqkEQhOETEYBEv4hvN1HQxwGrr2dMV3ktYBatYk35nlEpB2PD6A+H5yMcnjOI/oOqCXK9oCGy3M5O3CZMn/JYvSVLbTePg/F6rd4JMLkay1dxEjGmBy3oxyhW7pqRm8fEX3RAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480626; c=relaxed/simple;
	bh=MKbTbRKPfN38VHeTcWKyXE+ujHLjEE8z4beHkJvR7Ac=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=RpIn3rpRuaRVZFFO3D6CieGBR2lZl9u4qDrZ2Abv3bIHq1OrK6dykUzH54KTnvJ5B6B6pkSk9NS8v/QVtVMv3y3NQWvjaGnsVVej6J5/VSsZZaKERLMcjrNJ2/pxmlGv1N5QhOHZvhxt6D/jnEqAb1tGaM1bzQo/YJGOCgFUB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRGZW1wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5A9C433C7;
	Wed, 17 Jan 2024 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705480626;
	bh=MKbTbRKPfN38VHeTcWKyXE+ujHLjEE8z4beHkJvR7Ac=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=dRGZW1waSpej3L+HTY7TGR56vLV8+drTEW6ZiAnrCYzjWddGpBAzUx54ekrUncvoq
	 tYH4DEEeWFb4Boj7BnDLATCj77QXnOzE8chVlGku4mqtn37W/jxunI0/XoAeOvLdGp
	 DEGPDdlwFrHh4oPWoSWSn/1ZnWod/1xbQmwsuYNnUv6hFZ4I0vsxwd7uvQe/N/SWCI
	 7iw9qwkoUVQUoYhn1NW2UzPhSboHfFbwXjkRO0WmBWCGUIhFhvb/F7+JOwspSiNYiy
	 3MqzIvYq8v9xZYjz1j+CGBJAl/OwgyS/9lgnO9QhGxwNwl+RuDw8SqtHMxuEDLeoSz
	 lNPXPZQJbhVcg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: Refactor QMI MLO host capability helper
 function
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240113001659.1022465-2-quic_periyasa@quicinc.com>
References: <20240113001659.1022465-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170548062319.2185974.9158849020666419595.kvalo@kernel.org>
Date: Wed, 17 Jan 2024 08:37:05 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, QMI MLO host capability parameters are specific to the WCN7850
> platform. To make use of this helper function across all the platforms,
> move the platform specific MLO capability parameter to the HW param
> configuration.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

76fece36f17a wifi: ath12k: refactor QMI MLO host capability helper function
53a65445c144 wifi: ath12k: add QMI PHY capability learn support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240113001659.1022465-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


