Return-Path: <linux-wireless+bounces-5087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF8C885875
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 12:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0E12855A4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16A58AC0;
	Thu, 21 Mar 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh23NK4t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB258AB2
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021134; cv=none; b=N5SUti8+/UUcw/Buah/wg6iGXEOWf5redBVr69HFpJfJiTvNdMIf906cR2AwG/JRsPcpdIK//gAWpKdjCjhjT9iUuKCTo1Ou2NOaJSXVdOnyG0tfr4nfypzMT3Ld1Rtng4KTfrOHjrXyQLkgQjOaXWOWYG03gZg8I1b2VMkzxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021134; c=relaxed/simple;
	bh=aRyTFXe+p0aY8rJ9JaIV4kItqy1DDFHTHabtKqnrZHE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=VggYN+/FiuDt2L/DaDNK50IO9jDf8TYRDSxaHZJUofdOpG6DLk0mFzRLWG/h4mC3nVApy70hvNnnUcsqkqD/x5X8QYNoTrXHuqizbQeUa9FFN8qho6kfXvLcv1V+e2pD4+Grm1dexEpgltlrmN2BkPZtaTWqvZMyautCRpNLJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh23NK4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C264C433C7;
	Thu, 21 Mar 2024 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711021134;
	bh=aRyTFXe+p0aY8rJ9JaIV4kItqy1DDFHTHabtKqnrZHE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Lh23NK4tBKLy09EOg/2wLQWElS0kcszOVBb50d8DieLwkyy+iH/lqkllpJtY+uXJA
	 hLXsPfQSEToaSleOXpMbD1wyvovRLX0/u5bztrxAPPwyuyemG8oCG21x7dwlvuEpTf
	 FBJNuIhuIMtTpE28fbnyYLtFrZqLfNx7cWP79Uo/+tD7GzH53rt1BWDlhfclkikoJZ
	 IWQkU4wsdSlKz3lTTsIzb4CydUmFVpJP6+5oZn4seUczxujauAKg0x8lsWmJ27Ea9l
	 AMo9ci7ZF0wssCBE29+CEQymvASGDFGxgwmlvuHbfDHOLk0GD0tgQ48bCNxzbgOFz0
	 he/iR5dc46QaQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: ath12k: Refactor Rxdma buffer replinish
 argument
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240320010615.91331-2-quic_periyasa@quicinc.com>
References: <20240320010615.91331-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171102113130.4024062.15409932330092211067.kvalo@kernel.org>
Date: Thu, 21 Mar 2024 11:38:53 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, the Rxdma buffer replenish procedure implicitly retrieves the
> number of free entries when the caller passes req_entries as zero. This is
> helpful to replenishing the Rxdma ring when the caller is unaware of the
> number of entries to replenish. After the Rxdma ring is initialized, we
> can pass req_entries as zero to replenish all the free entry in the Rxdma
> ring. This change helps to align the argument req_entries to the used list
> entries for better code readability.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

9d7bce18e725 wifi: ath12k: Refactor Rxdma buffer replinish argument
597b4dd63afa wifi: ath12k: Optimize the lock contention of used list in Rx data path
f42bfbe7a507 wifi: ath12k: Refactor error handler of Rxdma replenish

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240320010615.91331-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


