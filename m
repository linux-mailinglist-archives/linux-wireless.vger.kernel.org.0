Return-Path: <linux-wireless+bounces-2082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB04683015F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 09:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00881F24C23
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA31170D;
	Wed, 17 Jan 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtnA9CuR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1411707
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480578; cv=none; b=eEvbz7FBoELzA2i6yIW8uy8e7rnFPZ6TnPPmlKnR7Q0m8L08RNRKJEBC+fhx2d8QuqWXI/DmkRo/3VnI440DJ5sk5X02NHpn3VpdD/F9f4Uec7d8Ju8+iODYz34rJX5tx+lRcPgCgt/O/VTGgNeYVozwqwqBfWZTK9tCUljTTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480578; c=relaxed/simple;
	bh=EhFtoGKibbkyyMB2iwpWCPpm9o6LfTvX0EBzHsQvWBM=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=PxZ6rMWnoM9H1RZL+jOWCcKR4nyV391lEA3dZBQ+Az4e8Hg8e3NKbgU1W7y7LeNfMLzvqkvQqIaTbML85c4UT3xM2+p46fc03yeBxNx1VKATWFfrcpRJ6XfuFy9CFmoJJplOK6aSHGvCRc+TNRx6TczuCPsY7vny01B1MnA1lTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtnA9CuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD34C433C7;
	Wed, 17 Jan 2024 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705480578;
	bh=EhFtoGKibbkyyMB2iwpWCPpm9o6LfTvX0EBzHsQvWBM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KtnA9CuRxHW/UDmEOttHymayv16A/bQdS9pAJVbuxOcwAeVGzEyHDYXwaKSJMdvVE
	 BjpMAGSytWHG46sTXVIUnPjfPfIiWrEV67bzckMvNbso4pg51hSTUW9jFagFPEPi2f
	 3HqlTdqHBTX0Syf2nbrnR9x2uxCqosI/asotiBq002MS1O7rNrT0caRo+8wjBTF+3q
	 9qoXGJa6JWZgaqoPIlNfa+OtT/pw2VpMNtaxO8c8XPk/7vKcx9RutoMCc/mLUiStb5
	 FXXToqBh3cxsPYUWlFW3O4aUOgo+IQlwetNFjc9nuM73wPpTAKIdN2ZEfwCUL3Hn/a
	 epmLOyJtrPxTQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wifi: ath12k: Add QMI PHY capability learn support
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240113001659.1022465-3-quic_periyasa@quicinc.com>
References: <20240113001659.1022465-3-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170548057504.2185974.5246732710512983160.kvalo@kernel.org>
Date: Wed, 17 Jan 2024 08:36:17 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, the number of PHY is learned from the firmware service ready
> event message. However, on the QCN9274 platform, number of PHY is a
> variable parameter. To enable MLO capability in the QMI host capability
> request message, the driver needs the PHY count information earlier than
> the firmware service ready event. Therefore, a new QMI message,
> "PHY capability message", is introduced to retrieve this information.
> This message allows the driver to fill in the MLO parameter in the QMI
> host capability request message. If the new QMI PHY capability message
> fails, the default configuration in the HW params will be used.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

I did some cosmetic changes to this patch: s/{ }/{}/, lower case debug messages etc.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240113001659.1022465-3-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


