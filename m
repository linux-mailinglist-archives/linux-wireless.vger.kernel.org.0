Return-Path: <linux-wireless+bounces-12021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17219602FE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E4F1C2223E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588FD15350B;
	Tue, 27 Aug 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp29kis8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109514F125
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743557; cv=none; b=UKQvMCYXtNvU6hoTKxrFWFuccO3thmtP1974WyffU2iGmn/R0ucnUd2cgLCnx9d15XFWPIbmAzCjTuvWe+zSP9fmNwoTWnU9W8gb6qYwQrUkaC+fTzWqmICGi+cIrb++QsCU0bYFZycSbHWPuFe/7nYB0WO8MMNivSV0LiOOOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743557; c=relaxed/simple;
	bh=UxIqPjbE7yc2BSiMKNN58LGK55SZ+G7dzpy1yF5nK6Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JjbMHUrbzPGdKjclJYv3ma1sNWeydhvQRawKH9vQ41Gy5cHCunAnosAdz2UjQoPSLMZbG1xLx2QDFo7RitwKSMM/QcH797Fo1tsvYQKQf1Lq2q8MFHurBMAZj+w6iF9VXZMkshim9aCS7UmMmt7i23K8cVbDfC56RglupBD+WNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp29kis8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B09C8B7A0;
	Tue, 27 Aug 2024 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724743556;
	bh=UxIqPjbE7yc2BSiMKNN58LGK55SZ+G7dzpy1yF5nK6Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pp29kis8SwjoE4Rz3yn4HB7huYcr9vqqp9T+mr/VobH5QLCCgLZ3+OiZm7KWO7q1Z
	 lxsKOOzQKMEng9/GVjHj0C5+J1MRLhL9jsRi+7cdGnR7sIAeqyz67Dj8bEKWOdnc9k
	 saXRXR9ygB+ULqVKF8P3+xbb3BiguJWFJWAyTYSDCi9YMg+zgYdqwbqavc+ODNSk7t
	 v8tdKoGydOeLNHGL+7e/3E0kR2eFZN4cqby7Z50NY006hscbjfO986CarBGqmLCTYo
	 TU+0dgsU5Pistq/lxmPi4Fm/M+991yG6zCTPrYtUvTeVdSGAPZKz/hrIphvtz8nKDl
	 fsAtpyhh8Ss0A==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] wifi: ath12k: Introduce iface combination cleanup
 helper
References: <20240814103423.3980958-2-quic_periyasa@quicinc.com>
	<172434561175.2469785.10367608474646125650.kvalo@kernel.org>
	<68bf6f43-d851-f2a5-54db-61538cfb46ce@quicinc.com>
Date: Tue, 27 Aug 2024 10:25:53 +0300
In-Reply-To: <68bf6f43-d851-f2a5-54db-61538cfb46ce@quicinc.com> (Karthikeyan
	Periyasamy's message of "Mon, 26 Aug 2024 11:34:16 +0530")
Message-ID: <87frqqv33y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> On 8/22/2024 10:23 PM, Kalle Valo wrote:
>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:
>> 
>>> Introduce a cleanup helper function to avoid redundant code for iface
>>> combination cleanup. Remove the cleanup code from
>>> ath12k_mac_hw_unregister() and ath12k_mac_hw_register() and replace it
>>> with new cleanup helper function.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
>>>
>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> I'll drop this patchset because of MLO cleanup.
>
> This change not related to MLO dependency. Its a basic to group
> multiple radio under a wiphy.

Ok, but it's still good to look at this together with rest of the MLO patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

