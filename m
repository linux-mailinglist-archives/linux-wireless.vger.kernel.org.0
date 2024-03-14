Return-Path: <linux-wireless+bounces-4759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4FD87C170
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE08C2838EC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6626F524;
	Thu, 14 Mar 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO7deHE8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997F1A38D3
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434502; cv=none; b=J87+pDHbf28XIXF7Dmfcwtq/1NeNZYTZydBOaUuwmZ+EpS6Oe3fIS7/9IZaDXDuEVpBfcOZIqprqmMc+JLXYu/MGHpy/rAFsNuHGk4WCBxxcFe83UqDvpLDBy/v8hPIe4WJPSwqRJfD9j6jYJsR+I6I0IcDeYiBxA0HAuXf4v60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434502; c=relaxed/simple;
	bh=sPw89LfyZm0F1ziV09IYWXQhMlHw2bEAtttpScIXKys=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=LkJmcrOd+Th/xyX/Rk3Db5OejWW0lQawyP2ljkWTYkuBQEhbCOSLP8IC5uuH/TfPqpaUoRCJ1/+BG5lFPqiy5K3BdJoVSDDtsE86fa19NsVD4dfzKcLMNT5lp84Tr9TW4fCzMuCrWAaw1DF8fz0d6iL+jryFxfAjWE1VQJQbpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO7deHE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E545FC433F1;
	Thu, 14 Mar 2024 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710434501;
	bh=sPw89LfyZm0F1ziV09IYWXQhMlHw2bEAtttpScIXKys=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GO7deHE8/iMLIDY/izre5RNQCgsb+908yEXH2YBz9mfFejmVhZM+NRLJJDS0MYt/m
	 9m5CFNwWB5k3FRtI0aiJpnD5imAEQj7vkNIwQ3O8fENZln0bCgSg7lkda/fwwmzPJv
	 53EGyxtR7zrcvUe9X9tE+Qjp7OrJonrLJwnBgbLOq09H1mothudIxH5Cioo33xFjl7
	 alocdUwV96HiVISXqo5SXz6l5YQmVe7AveIXOccs31QHEiLV3YG2jgCYDRK33vJoIW
	 pfg/PFC11pWkeSHVskrQc0AN6E6CRJTuxFETeg4230iMPibmEqnqnn7CBE+IFgQhhy
	 IP+b+1wstViyA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: ath11k: change interface combination for P2P
 mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240228093537.25052-2-quic_kangyang@quicinc.com>
References: <20240228093537.25052-2-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171043449897.2496983.14481800262284990010.kvalo@kernel.org>
Date: Thu, 14 Mar 2024 16:41:40 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> Current interface combination doesn't support P2P mode.
> 
> So change it for P2P mode.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

6 patches applied to ath-next branch of ath.git, thanks.

faedd6e0e139 wifi: ath11k: change interface combination for P2P mode
3a415daa3e8b wifi: ath11k: add P2P IE in beacon template
2408379f15a1 wifi: ath11k: implement handling of P2P NoA event
75b5f1e71abc wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
6c7c30adf79e wifi: ath11k: change scan flag scan_f_filter_prb_req for QCA6390/WCN6855/QCA2066
f8c0799b2428 wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240228093537.25052-2-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


