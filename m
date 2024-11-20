Return-Path: <linux-wireless+bounces-15529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737759D36D4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232F61F26275
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01E19CC22;
	Wed, 20 Nov 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN5h4Oyq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E919CC06
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094213; cv=none; b=nbKKUJ4GFaDc4oWtwvQWFi+V4bqxetuSNz+KEoZvuXrf4t3GZ491gA0i4vpC81qrmqMTvDxlKMtWQefjZCTHxUDwp+6O/GGgF1Jpa9GSg+j+QFl8Y2gJYaqZAdW9vqIZLC1MPqM4CTrlQajxuYJSkZIIg7CB+FuMBGtjlX25JFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094213; c=relaxed/simple;
	bh=+b+EtdsVyfRyamFdsTUaD3lRNWO/5YL/T7wVZtPHbTQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DCPqEJMiYSNHuJA9BBeXdjUUB1LC9pc9/SXMIkh1akcgbFxIEj0/15e+fURPe06tyLdd29QPFPFhKEAh9DJW+EE4Fo18ERGbisjMHeesmj0QXq+TZ7RudZisUQZBtlZfJMdgpymSBfWz/H9mzAsJnXmaOtWvAEp9x0fzkH3lQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN5h4Oyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4ECC4CECD;
	Wed, 20 Nov 2024 09:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732094213;
	bh=+b+EtdsVyfRyamFdsTUaD3lRNWO/5YL/T7wVZtPHbTQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qN5h4Oyq57UZY2/wFedf8mXHYUttmdSun8mRsjwXEnAi0LIrcdv9RAFLe0FEAnh5F
	 CialJElowp06b+bLbpD/ekKb1Y79Pk7LYvJiSa/2Xh6lqAbtLcPJGG7kWDymGFWqrW
	 SWAky+p3XSTZsCwP7zfB2ETjKPmRLYEOjXxbNFipRSajVMWuhmBPyWx7MMIeGSZgUi
	 skrOOybzKL0q4/Jjjzb9wpTW3bgZN4W9/EteTpsry4GgrOziaPLHck5T9DL2SGHpCE
	 jtXlvBeDBGpvdQlMNqpculFYos1CHnqk+YybLBCwi6A0ZNLz/SFa/HSpSt4P27p4RV
	 +CnuxeYvaN1uA==
From: Kalle Valo <kvalo@kernel.org>
To: P Praneesh <quic_ppranees@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Fix endianness issue in struct
 hal_tlv_64_hdr
References: <20241119164516.756478-1-quic_ppranees@quicinc.com>
Date: Wed, 20 Nov 2024 11:16:50 +0200
In-Reply-To: <20241119164516.756478-1-quic_ppranees@quicinc.com> (P.
	Praneesh's message of "Tue, 19 Nov 2024 22:15:16 +0530")
Message-ID: <87jzcyz2m5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

P Praneesh <quic_ppranees@quicinc.com> writes:

> struct hal_tlv_64_hdr has a 64-bit member that should be in little-endian
> format, but the current definition uses host byte order. Fix this by
> changing the definition and updating the corresponding helper functions
> used for the byte order conversion.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

