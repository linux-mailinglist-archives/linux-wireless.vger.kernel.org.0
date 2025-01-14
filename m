Return-Path: <linux-wireless+bounces-17504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D02A11025
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F277A108C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459C1FC7FD;
	Tue, 14 Jan 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auyHeoC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100311FC7DC
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879438; cv=none; b=XqAFCFFAPnw+RwBpYOvme7EQ/+90jwBO3J6uiGRt2on0faRLivxL1VHICb4GmpHNquIzAwlkA12blPxbjIvGChShyb/ju999wVfFCr8Rqn6zJo9ITUnxTD640ysb4WmpetYbGVkJ8r3qLgWoh+QV0QWNa6rUBIDF9cnoJSs9KzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879438; c=relaxed/simple;
	bh=EgYhpCyyzF4Lv9/yW8DEJmFz9JnIuytaSfp4aQrOjPo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PxNkks0nHTaGL+97KbH3KFbcZUGsdNChBX2cIhVmVCSR24R7l2bMjWjByZK49faNfRKjt60RXaSfWpKfnMcdoFl7TuSIL8/bUEi2gLhiLITlV5S0m524Trjb4YsJjVKGajD8uOoWSOsqe5chIS+EBjU4kkswD1m69JIj2wioAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auyHeoC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C1EC4CEE0;
	Tue, 14 Jan 2025 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879437;
	bh=EgYhpCyyzF4Lv9/yW8DEJmFz9JnIuytaSfp4aQrOjPo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=auyHeoC+hoDCkhVuBjdXXDkIHZetk+D4qYPuiZdEkfAeGU7QhgeIr+F4CtCG7QvQ4
	 Bj7Zom9IW/C27foyig2Ot7H9dHEV48ewnht4aC89IZe/8ATOykIpMiVLZWiwYVteLt
	 Gog9ALNmso76jDGFyeWyEZ0mRg3Jd7LsOJnj4Ml5qyuiYXaCKpDVAfHAcooJKFjDnq
	 aMvON+8LzuTzM/rH0KpADMDPJsBy0p/01ariN/JFAjQRiVZ8qbVVaglBQUBfKJBG0Y
	 ufOiPjeVtXfHmjetqJWKHpOy39CBPclZ00C0lA7o7whvzjOWV0W5CzNfAkqpTDA6l8
	 DCDonL7QK684A==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/4] wifi: ath12k: Refactor the ath12k_hw get helper
 function argument
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
	<20250112071630.4059410-3-quic_periyasa@quicinc.com>
Date: Tue, 14 Jan 2025 20:30:34 +0200
In-Reply-To: <20250112071630.4059410-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Sun, 12 Jan 2025 12:46:28 +0530")
Message-ID: <87h661p7sl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
> ath12k_hw get helper function takes the device handle and the index as
> parameters. Here, the index parameter is specific to the group handle.
> Therefore, change this helper function argument from the device handle
> to the group handle.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

