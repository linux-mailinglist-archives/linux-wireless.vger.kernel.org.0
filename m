Return-Path: <linux-wireless+bounces-16291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A852D9EE087
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B84188784C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7899420B7F2;
	Thu, 12 Dec 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB2GbhRS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E820B7EA
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989590; cv=none; b=A6uFOJ1rFZS+YIbIYP38Es5R6hWBz3xLWYvScyVve4c0ebJX0Ed5IZlFfmg+BQWSz9rg3O5Wau1mmU/bD+UkJqixveGYi25Mshux+bYxq3cS/jaN9ZvdElvwbeGyyC9JpWTcYXcq9wj5wkYg9oESZFISIO6PQZBpLT2ZbOdLcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989590; c=relaxed/simple;
	bh=dtg1tQV1yWPm8gDAL7vJ10IRdA03eRnZ4qO5YBayvk4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=i0xY+0EXbyoen4sludELvC5p/3C0M/ejaD7uyFpJlPKZpDisJEra4UeGlvmQQCbVnjHOaA5biaBjawkvKUmKAnNn2a1FdA+nP/9U558lX6mObdh1ag6Dly/GgmrvYYE7a0za3XeSgup8FKNyRcud9ZqiH0COwdbiKWuuTZ7CHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB2GbhRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F10C4CECE;
	Thu, 12 Dec 2024 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733989589;
	bh=dtg1tQV1yWPm8gDAL7vJ10IRdA03eRnZ4qO5YBayvk4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JB2GbhRSa+4wk7WXKLwtxq4qcoNPGeA0Y67ks33o5KYH66EYCa0nLnBZLpKrUKOJI
	 GI77CcQZKXo5FgPKtwVOiTBGi3HrdQ3awjL2il2d2maZ46zunfCOkaWVikyRvBD9EJ
	 qLC8jnhJcUpvHoaG6MwfT/Vcqn+EbVyuhaOShjjQAKZgzsKNpcO79OUtIh3ALLGbSq
	 xf+fpAs+w8Axp2g/PbT/9Tijf+CulUA5kqRTpaoIAvNx8h7PesqHgKMznhxyY5hsz/
	 zcMTuHQh11glVdMWzyUwi/5/ADzW/5AYAJ89FzuMhtJjaqAQmRHiWHSatUdRmtmCTo
	 TXk373uWtKWQw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/4] wifi: ath12k: Refactor ath12k_hw set helper
 function argument
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
	<20241212004906.3087425-2-quic_periyasa@quicinc.com>
Date: Thu, 12 Dec 2024 09:46:27 +0200
In-Reply-To: <20241212004906.3087425-2-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 12 Dec 2024 06:19:03 +0530")
Message-ID: <878qslqr70.fsf@kernel.org>
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
> ath12k_hw set helper function takes the device handle and the index as
> parameters. Here, the index parameter is specific to the group handle.
> Therefore, change this helper function argument from the device handle to
> the group handle.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

What's the user visible impact here?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

