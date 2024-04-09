Return-Path: <linux-wireless+bounces-6022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8089D9E3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2F5280DDD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8BA129E6B;
	Tue,  9 Apr 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiLRhJhb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821B7F7CF
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668318; cv=none; b=VsIABh9TpIgSX/rNwCbQBwK8oueCzjUgkqkRxHxMRhvLk/cV2uTKLYvNwULIp8HB0CWMlX9/pb9RsOwuiVNqfEvnOIpbqXwhapEf6QFDta6Jmw6bWvuO4I9ipgA+++5ZvjJq+qtlNh+2XrGmlhbJ5Z7FfoC/eKI4WQYbX6BdcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668318; c=relaxed/simple;
	bh=yNWKLlKli6iMQOIcwUEwFPXvgyeGHeWbC8FzjyW/3LU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ZoWmozaAcobFDPUWw+k2qAE3aqv4pGLkwUAgwB4oJQ0kLkZkt16eFH+x87jBWVxtFQUunmM5PPptrOowK46iGCxw7n90JDW3Rcbxw3qWypGyaLKFSoeqeI65k8HMk8ASFBr9gGqEyjYA8MLa7Ct/HBcJCODbDjaSssOh03MSmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiLRhJhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC47C433F1;
	Tue,  9 Apr 2024 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668317;
	bh=yNWKLlKli6iMQOIcwUEwFPXvgyeGHeWbC8FzjyW/3LU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FiLRhJhbFIFEcuDboqD5uLTzyZZvJksybkUP8jsSVs6shIeTbnSGlcVC8arESbl/o
	 gvMbB/yNs6laNrKeovF0szUXq38kuYhkxTY+bSnZ/4fzCpzAzszWKdWozUUtmwgZOO
	 EViqFlBWIB1AaCdSr+2WAkbgpuTSzXpFMvJz3coWoU6JJcA6e9TCt7ZQbEmqYl+c5z
	 qutGF7hLj9jiFTgx/UoLlghOXGJD05QPBWuOUiZWjrhDnd2jaIQDQKEkPa8jqNMVCI
	 EX/kuYGWexsjfbeRYLYosomCZEgryjbPnwXhpveUbguF5HXlcxfkmG+ETtOFd6K6dg
	 JUMpw5O+WkElg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add display tx and rx bitrate for 11be
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240104032202.19472-1-quic_lingbok@quicinc.com>
References: <20240104032202.19472-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171266831537.3271006.6908994091119638561.kvalo@kernel.org>
Date: Tue,  9 Apr 2024 13:11:56 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> When AP is in 11be state, STA's tx/rx bitrate display error value using iw
> dev wlan command.
> 
> In ath12k_dp_tx_update_txcompl() function, not handle the case when
> pkt_type is equal to HAL_TX_RATE_STATS_PKT_TYPE_11BE, so add a else if
> statement to handle this situation.
> 
> In ath12k_dp_rx_h_rate function, not handle the case when pkt_type is equal
> to RX_MSDU_START_PKT_TYPE_11BE, so add a case statement to handle this
> situation.
> 
> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
> tx bitrate: 1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
> rx bitrate: 1441.1 MBit/s 80MHz EHT-MCS 9 EHT-NSS 3 EHT-GI 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Tested-by: Owen Mesh <owen.mesh@gmail.com>

Lingbo asked me to drop this patch.

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240104032202.19472-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


