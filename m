Return-Path: <linux-wireless+bounces-3032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C4847074
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81808288582
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA517D2;
	Fri,  2 Feb 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET/V61Rp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FD17CF
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877503; cv=none; b=L7RwH+urzS7Ev+NRTIiLcJ/taJyc2kMCng8zqWMNAJScoEGgPzSasEoUEq7++voISXAQ49y19teSQJd4iEfb7IguEEBpUtCQonprBZOoXNaXJv1FCwKJuKFVHtOhN7pe0JDXoJmmuX/zHcYVDLuSdKk1+AJT7jj1WKYOGSldt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877503; c=relaxed/simple;
	bh=RfsTFe4NgUohvaiNqS8BwZubOvrLemzOg+tSA4xiw+Y=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=mn0tGJSiFfpCVHrLFWpAJ/PGRVrrlyqEv0IRiImTvJORTV+PChrO1KHc6yvwhMo5bESphAYVhvILflE9Ep43Iu9eMcKuJ7Q9l6Qbkd0xad4DCkaTgm0Q95fHmzsoST//LNPE+jQPhd1RHI/fvnm3bXJFgkardYUxQu9vaNYcuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET/V61Rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D52C433C7;
	Fri,  2 Feb 2024 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877502;
	bh=RfsTFe4NgUohvaiNqS8BwZubOvrLemzOg+tSA4xiw+Y=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ET/V61RpCR7OpcbaOeFrZ49qbnC+BV0ITqtWKUk6qxjOCAFhZe68J96QL2OYltfXy
	 9VXcZLyiuM3PNdgUJf+5+a1fTtiuCFYkuTZG3am/koyNlsBtt93PrO+P6ebza5QFNj
	 kj9BLxe/WU4WqIewpARaYME/WbOGjv0hf/3jBCJK9RJAHFFJPLInb0HtSPGXEaCNot
	 XrRg8XM74wMtsHrCdMGMVgyT+75HfCDDT1trk18YCFrEBdgphu/BK8YzDGbKt9GHwX
	 rJEdn7QxSxiMwiW7PX8agIj4aY1+980lLpvboaDdu3j2Boe71ptsJdq17Y/JsISM7K
	 TWXdgdlKbP5bg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath12k: add processing for TWT enable event
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240122085336.3985-2-quic_lingbok@quicinc.com>
References: <20240122085336.3985-2-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170687749992.3221346.6741528529227043525.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 12:38:21 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> When ath12k send TWT enable command to firmware, firmware will return a TWT
> enable event to ath12k. Through the analysis of TWT enable event status, we
> can easily obtain the status of TWT enable command. It can be more
> convenient to debug TWT.
> 
> This patch works with WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

2f92b22beef7 wifi: ath12k: add processing for TWT enable event
ad2b29ad94c3 wifi: ath12k: add processing for TWT disable event

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240122085336.3985-2-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


