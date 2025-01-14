Return-Path: <linux-wireless+bounces-17505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC4A11027
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A708C161112
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6F1C3BFC;
	Tue, 14 Jan 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRKZx+py"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE931A4AA1
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879497; cv=none; b=FEv1DedRcA+EEjQ18r4A6W+kB9TBiQqaXosxqg2zQCeRyA7eIuq//0eI0ij2RE826pm4i1/uG6IcuK9T2VE7Xowxz+PloE4G7RJ3LGMKLfQzlWfOPxldNXtBXSKYx/v4UaCcC+4zdjwza0XGZut0nvLoUCIlgmLKhdSefCcxcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879497; c=relaxed/simple;
	bh=M61rmG5pLoh4YRzdgGK9gOuB+F0dOBxNCUQ7D6Mkduc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gny2xwL+BP9KCNgx93+TWxW3ONzHHvfd3iFSCWgAwUE8AdA3VNxeLrEsk274fEU7i2I6tkvoe/VSMeQg3sdGuYVBmCcKzT0KmfZI+oTfEymbGwjizQKTggtGGy5no3QGSQAJP9BEIttmnRPhq7r1L8ZZejIbvkTSpQsJkSdE51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRKZx+py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BD5C4CEDD;
	Tue, 14 Jan 2025 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879496;
	bh=M61rmG5pLoh4YRzdgGK9gOuB+F0dOBxNCUQ7D6Mkduc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MRKZx+pygsPKgaUABQiqkHkUNdPLpjrfLT397gMzFDpVwptEzGDYQFSEjMcOSw/d9
	 PqR+7G3v6olRpL3w5Ri/DcBtmE5kijdAbNrPlUu0irskcj465I3etNGCrYgiWOA2yD
	 VsLmir/Y8vX4mUuRTJhmrS+PKqB62CioW2+t/4SjIVTJ+ihduKgHdh70nIU2tlZGcV
	 O5A308YjIDS4OdYWNyH2MJRRHHhbjjPChOKoIENo3RNBxlH6r+PylXasmiG+wC/GDk
	 bLfGOFCfIJuHDYCsQWPtoR0yeFoJZ9DzldseK4r/ClXok4ZUnk0NLv6dchKpgBcFzQ
	 8hOU78sWihMAw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v4 3/4] wifi: ath12k: Remove ath12k_get_num_hw() helper
 function
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
	<20250112071630.4059410-4-quic_periyasa@quicinc.com>
Date: Tue, 14 Jan 2025 20:31:33 +0200
In-Reply-To: <20250112071630.4059410-4-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Sun, 12 Jan 2025 12:46:29 +0530")
Message-ID: <87cygpp7qy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the ath12k_get_num_hw() helper function takes the device handle
> as an argument. Here, the number of hardware is retrieved from the group
> handle. Demanding the device handle from the caller is unnecessary since
> in some cases the group handle is already available. Additionally, there
> is no longer a need for multiple indirections to get the number of
> hardware. Therefore, remove this helper function and directly use
> ag->num_hw. This change also fixes the below Smatch static checker
> warning.
>
> Smatch warning:
> ath12k_mac_destroy() error: we previously assumed 'ab' could be null
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
> Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

