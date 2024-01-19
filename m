Return-Path: <linux-wireless+bounces-2270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154A832E49
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3400F1C20EBA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA4755E66;
	Fri, 19 Jan 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPrpfTnx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6055E5D
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686044; cv=none; b=sMVknKm6pOw2wzmhMW//wXOki8XAz0Nu/5BJWBaBahUEYx8JWaYQtfQhfz/BbRV9Stpl6GvUWrMAdLnEmBVjkv3+HQZH9MyGvZKJAwGvSDnngXFtS39+vAtlQs/FpvzS8QjsY8estdTDqVQpEhwZdKZrQ8pEqRbpC0UyTjTlQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686044; c=relaxed/simple;
	bh=9ZC5lpAq+brLDF9QYvgZJodAtrcRqMAVlasT0Wxje4g=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oKmqgmfbbkH/t3XcZ8Z/Zlr6MDHh57v9NKsAsdi4smM75eEv/l2Df+eEpNhhC4+1o41WnQyXpKFo/zHkwnwrmj6XvahWEFRNIyzeudq+qHChBDD8kjerkfy7xIfh2DdvEuEhS6EE6RzoSYTIW1IMDsOpcO11VsSTP1Keh47RiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPrpfTnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDA4C433F1;
	Fri, 19 Jan 2024 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705686044;
	bh=9ZC5lpAq+brLDF9QYvgZJodAtrcRqMAVlasT0Wxje4g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mPrpfTnxTa2gdl00xoW4NfwBCP1Tlq463XSwhCmZ67K+e8sSHMNYQH6lrK6xjH0qu
	 M68JN7BpA9IUghZCQ3VnSuTAdwmGq2T4CqER0ISE/SKWB3Hx+N9UqFZIcjASGBefNV
	 pc4IJnw0Ly77mAGf5bXpgNE251di6mC5P7J3XZ2HFAkzEvkX049rFWn5T1h8vkoQet
	 /xWGXT31Buaaus6NEB8doG4xwjMQOR9YmrOQwjGaAmk1z4QzehF3qvjveWulDawn5b
	 OYDNp1HhJgxxwpAHbQS2grzr8f6fDvLM6BvsGClZmHTDHdpz9kz4Rwooh4LlI7qECh
	 dcTEtLBHwb4QQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add support for collecting firmware log
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240115023726.2866-1-quic_bqiang@quicinc.com>
References: <20240115023726.2866-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568604129.3232677.2722276055685320027.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:40:42 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently there is no way to collect firmware log because firmware
> does not send it to host. Also host does not handle WMI_DIAG_EVENTID
> which is used by firmware to upload firmware log.
> 
> So add support for it by firstly enabling firmware log upload via a
> QMI message, and secondly processing WMI DIAG event to expose it to
> userspace via trace event.
> 
> This change applies to both WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9f9df1a2535f wifi: ath12k: add support for collecting firmware log

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240115023726.2866-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


