Return-Path: <linux-wireless+bounces-371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59E6802D66
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89122B209E7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDBE560;
	Mon,  4 Dec 2023 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM4YDTuL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB519320E
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 08:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8895C433C9;
	Mon,  4 Dec 2023 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701679345;
	bh=TE3EEYEpxG4JPMq2js26Nz226K897mSnVYCmC8qPc0s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JM4YDTuLHIWdRTIjhw3grwuZsVr5JWhuCF6KFL3xywLNUHCT/t8HpTwIcX/PPFHms
	 zMOb9DY+Mdr75ug7SLXcLQUxon91nXeenglmw1fiKUBdwUsj1I8T7Y7Go6/buvBuW0
	 owGkp5SUQaYB0D7m0e5J+QsOB6ZrJVz5CuhKJKTX4W/PfMb/jX8PrmWBpWKSJFvRg4
	 SQRmGxj5a7iWZVhNF15/rAZ4RHrhCBhSWTpFjtIZWsIi+mzqPxg4S1/4xFsbD+DQpr
	 1oCthyCHMtFeEBFFKF2rllgRYwRkz53wfcWTL8ilTcn6qiOlR3Uvik5pzejeJbvf9k
	 /gYzxfIsIGpLw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v8 00/12] wifi: ath11k: add support for 6 GHz station
 for various modes : LPI, SP and VLP
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
Date: Mon, 04 Dec 2023 10:42:22 +0200
In-Reply-To: <20231204081323.5582-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Mon, 4 Dec 2023 16:13:11 +0800")
Message-ID: <87v89eqryp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> This introduced some new concept:
> power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
> power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
> power spectral density(psd)
>
> This patchset is to implement the new rules for 6 GHz band in
> ath11k.
>

[...]

> v7: address review comments per Kalle, Jeff and Aditya. Also rebased to ToT.

Just a small comment that most important is to list here the changes you
made, not who provided reviewed comments. But no need to resend because
of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

