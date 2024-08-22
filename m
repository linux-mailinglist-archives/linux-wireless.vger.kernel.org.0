Return-Path: <linux-wireless+bounces-11810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826BD95BC80
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 18:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC222859EE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FFC1CC88F;
	Thu, 22 Aug 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSzsS5eg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66838F9A
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345615; cv=none; b=Ejddc6mX1TjsxqGMN6Rud03MK5XoBCtjeBai1mzkj6MalGYu/0fWNZ7ZXosG4cqO03gzs9vVMqvpFTI+y4Wl+WG3uJma1Jicl8zZCPQTb5Zq9eLnonN7QjBdOMxuZ2X41SwcJgP8z3qU4qDPU5NzjTitOyOuXQHDGf8l9iJ/gyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345615; c=relaxed/simple;
	bh=lgNdLmnukG3y6MJRdmajbF4UCZ1fFcc63MAWP3zcrPc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OdAIdClll9eilMHIoNgg4aPk6Dvbz57TjCZm1Yp3UZkkFyps26R1wb7U+heRelH3fnSoZxh31GfJbhXrsNdYPL5olNnAwPY0Sc3Zjy+3KvLCbyb4zCs8mx82GGOGMxHNLW7vUPJoevtoWGLOs5W/vVeR673AHztDnpFej5+1puc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSzsS5eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0D6C32782;
	Thu, 22 Aug 2024 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345614;
	bh=lgNdLmnukG3y6MJRdmajbF4UCZ1fFcc63MAWP3zcrPc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=YSzsS5egdRDUAUOn3dlIyIfcPzeJOX1lY3KYh0fXV0Ngier4lAtUJg5yTfmvC3MEu
	 WCRp/nDr/u9Nk0n2ZgflebL7R5wN9QvBjTH3w/IZCW1NfE7vFzd3UFgiK8zQ05cadp
	 Kk4a86wDxwc73puD/NQsNwJiWpyucg8OQ1E1NQcfc1hOOkM2ruYufOugGbfYTtrexD
	 GuYfT/Gy6hQYlv30LNuojSg7vgohfFIqDKLS4aumuo60ZF3wFiBIloHUuFS/1P36fo
	 sYYsfmAxI9DDjeQifHJ0GDvjtJKzZWXxisoPa9CilxjcgX50DfSqlG0GfQHKdhHnY9
	 /m9cyjvhXzooQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: Introduce iface combination cleanup
 helper
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240814103423.3980958-2-quic_periyasa@quicinc.com>
References: <20240814103423.3980958-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172434561175.2469785.10367608474646125650.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 16:53:33 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Introduce a cleanup helper function to avoid redundant code for iface
> combination cleanup. Remove the cleanup code from
> ath12k_mac_hw_unregister() and ath12k_mac_hw_register() and replace it
> with new cleanup helper function.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

I'll drop this patchset because of MLO cleanup.

3 patches set to Changes Requested.

13763255 [1/3] wifi: ath12k: Introduce iface combination cleanup helper
13763256 [2/3] wifi: ath12k: Refactor radio freq low and high information
13763257 [3/3] wifi: ath12k: Advertise multi device iface combination

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240814103423.3980958-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


