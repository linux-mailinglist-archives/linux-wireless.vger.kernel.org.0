Return-Path: <linux-wireless+bounces-6830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A08B1F0E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 12:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC212818D0
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065486274;
	Thu, 25 Apr 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpGd1qFi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F886151;
	Thu, 25 Apr 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040529; cv=none; b=SyFXYRPlreXw+ZD+rzK0rV9j5Hupo/velbH21Gq2oFROtgndqwAHgiMQnbwGGC83eYS8B8YRnHxVPAQgxiWdZraVbnOfHhS//cemCDqaeDGjmn6uoK3nk6Fb6e13mzkdnJUOzR7cUCgy0l3Aqd2ibmKqX3bVtBmJfuX41QLPRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040529; c=relaxed/simple;
	bh=9yh3q4Qez3ty/OthiP7tKVHvYd10TMNRzON0T29mCrw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jP7RK55ICrexPdMenWQrQVjwu4G+q/kL1VwxKCXlffXWZsabtXvoXAIplRpEevr1K5MS4PfZMZnjnoUaDQ4AH7N+vXGyDvFUxvZ3HwF3wtnAjdBbbxv9jIqZeC/i217IkPU51G5kE8EWiGzib07wcf/mvvPQkmfbIKxIaHz7y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpGd1qFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE42AC113CC;
	Thu, 25 Apr 2024 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714040529;
	bh=9yh3q4Qez3ty/OthiP7tKVHvYd10TMNRzON0T29mCrw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lpGd1qFid9sGnxfnbafmT3LpOEXAu2O25RsaM55QPErqrJYOLGRtgYhCD0OfGBKdK
	 ZdEck5FmC+1tKnYkdKA62cIbbrhEyHGh9dMFyvtZbMK7/4BoYCpp8tZPtZd03/m8SA
	 7Wy42ewVDDGGxOcj07gd68AUAd5SL3U7yf3qVECtWG8PZ1pRtlmk9hPrLXd4jSO/ow
	 5On0I7Mvja2EonhkJ0LhfZ7lDc0uexrkuONhQwZhNid3TBAypMrP3JeTE9gMVxI3XP
	 65cQ67ZcVcDxFnbOLrW0aKkSKZtyI88lkkkogMNjRj4sJ82wcO+yZpmtupn02kPYrF
	 59NQtQFmg9tuQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath10k: populate board data for WCN3990
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240130-wcn3990-board-fw-v1-1-738f7c19a8c8@linaro.org>
References: <20240130-wcn3990-board-fw-v1-1-738f7c19a8c8@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Yongqin Liu <yongqin.liu@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171404052589.2914755.17375571502543986755.kvalo@kernel.org>
Date: Thu, 25 Apr 2024 10:22:07 +0000 (UTC)

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> Specify board data size (and board.bin filename) for the WCN3990
> platform.
> 
> Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
> Fixes: 03a72288c546 ("ath10k: wmi: add hw params entry for wcn3990")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

f1f1b5b055c9 wifi: ath10k: populate board data for WCN3990
de0ff4613363 wifi: ath10k: drop chip-specific board data file name
3ebae49bbc12 wifi: ath10k: drop fw.eboard file name

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240130-wcn3990-board-fw-v1-1-738f7c19a8c8@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


