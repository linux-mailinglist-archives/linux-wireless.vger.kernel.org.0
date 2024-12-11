Return-Path: <linux-wireless+bounces-16264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A6C9ED340
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 18:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000CA28113B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D41DE4EB;
	Wed, 11 Dec 2024 17:20:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCB1DE4E7
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937647; cv=none; b=BiyAiOoLoY7KMmLjBN2ydfJcv7zOs0TRG4MMP+U5aNGgGpNzGEPqlXk/uN7Fj/JsNcLVLHYph9PPL3T4/eH/zfdLyImX0qmxDyIBav7nV/vTrnJhcWJfYVox2BW5OXz1YxShlBFsN7T0Pblwn1OzkRgwRRU75TXLCcGGWyS6hYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937647; c=relaxed/simple;
	bh=GPZn4/EA4/cMeSLl+iPlAS/m9ys2paG/P0VZCGLYUFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtUwDqernpLgJWZOnzFhr98BCAxBOV7C4eBDF5npR6d5961yF4C1fSAOT268+icPdYBYbotaLgaGGd8srevd1Cd7zNXrd1qWaO9Yi4CrLv0vaMimJMJP65luuiSkMGLySZZWGWj4JLj2FZjUJKa7EMeri3Ovz93AJbQY+4zRQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE0CC4CED2;
	Wed, 11 Dec 2024 17:20:46 +0000 (UTC)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241206054552.177424-1-quic_bqiang@quicinc.com>
References: <20241206054552.177424-1-quic_bqiang@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix leaking michael_mic for non-primary
 links
Message-Id: <173393764697.2156603.1195377255874275806.b4-ty@oss.qualcomm.com>
Date: Wed, 11 Dec 2024 09:20:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 06 Dec 2024 13:45:52 +0800, Baochen Qiang wrote:
> In ath12k_dp_rx_peer_frag_setup(), commit ea4192553850 ("wifi: ath12k: add primary
> link for data path operations") checks whether a link is the primary link, and
> returns directly if it isn't. In ML scenario where we have non-primary links created,
> this results in leaking the michael_mic info since it is allocated by default but
> could never be freed for a non-primary link.
> 
> Note that we can not move the might-sleep allocation after primary link check since
> there we are in atomic context (due to spin lock). So keep the default allocation,
> and then free it before return to fix this issue.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix leaking michael_mic for non-primary links
      commit: 02f41c8aa643b0d329ee9fa3f3341919bf86b759

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


