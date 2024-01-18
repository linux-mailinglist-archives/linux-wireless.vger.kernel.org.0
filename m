Return-Path: <linux-wireless+bounces-2139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78A83128F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 06:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1880A281EC1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 05:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F554125A3;
	Thu, 18 Jan 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYY10fv7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AF125A1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705557136; cv=none; b=OMLqu6C7IwdRtQjC80/unhgF9OvzNqQGcs2HbNkZzltDNrrvtUUl81QB8WuruDNZ+tnEVPpZz/1fwF5rOdfi2vJ23SlpYts/iulQ/a4ka6hYh4N5rXucHdpUbRzoPHFCC4DQPRSExAC86Zwpog0WbGrkE8FVgSzTSKGjFiaqxkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705557136; c=relaxed/simple;
	bh=sJTweTXpSZqoIma9Gmm1lJh1URP6mCEDtKMc3NepUeI=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=n60z6HPTwsJclSsRZHLc9nWpWlBW9h9g2PKRPUknNhRpv13tIU1o0OmrEx/yfcyVxp//FVsdBGdi/QZJT8kc9KffMtLvdicXBFFMPmPL/lnyh+//1Hl8emRp8WORyJNCOwUr5LmCvYIraxZb4WknNm9IRiXchfkQeYZsA0SpspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYY10fv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682E1C433F1;
	Thu, 18 Jan 2024 05:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705557136;
	bh=sJTweTXpSZqoIma9Gmm1lJh1URP6mCEDtKMc3NepUeI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FYY10fv7D12UHkoNRPR4XS7VxGYNQjc+STeUFudhUWfqN2GykGsxH3YBOgdU7YfVc
	 6SqxqSTiMFGVKJ3neuRcHFo08dq+k1O99dkS//gm7pHQtPkF1jfhZSEGNnCTE53iYV
	 9OEuLv5Tj9WdFzkksS2Npy8RA4vdRZdgrdqG4pEIRXPuYGblzAohDkF6PI6sg6QLVv
	 zNEwOAJ/sEun2/f4fchk6pJ4MJTV3MDjV1ZFPjdcP07YJeiF/xGBQcSwwy9hEq4FIk
	 5ux0yLyOWvbpJMD3uRPp6atphs1mw4cSMQhcmbTu4FK20fCYRVo8fciNNfFbcHLq8O
	 IxosORpzaYQMg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: ath12k: fix wrong definitions of
 hal_reo_update_rx_queue
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231129020414.56425-2-quic_bqiang@quicinc.com>
References: <20231129020414.56425-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170555713346.2637903.17844854625584075804.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 05:52:15 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Some fields of hal_reo_update_rx_queue structure are wrongly
> defined, so fix it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

60b937658321 wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
b0970f50839e wifi: ath12k: add support for BA1024
955df16f2a4c wifi: ath12k: change MAC buffer ring size to 2048

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231129020414.56425-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


