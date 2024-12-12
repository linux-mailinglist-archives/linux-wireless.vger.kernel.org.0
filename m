Return-Path: <linux-wireless+bounces-16292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2EA9EE08A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAAF1624FB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC91FECD6;
	Thu, 12 Dec 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr8i8xIL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE86165EE8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989647; cv=none; b=ZyjxfrP02yVDkklGjahehJ3TeFuvNW0zhSxqmxA5M+hL4OK56pLpwxwam29flUXkYrC8TM2OrIi8eFwcQGye0SNMeUapdw2PFNB7H8mCossCnTyczb9PyJaNkSGxox7JxBv9lrx3TohkNrrtylDDonZtVhqCSdQ4zc0WaguGX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989647; c=relaxed/simple;
	bh=EdnkbNF2Mlev9vCi8Q3xsS92gcktwZrJwJ/KyMHrPe0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ujiIRmUXbx9Q9xsy2xVZcZ3bchwyLGir4Jw8auBXkac1EAFTIedKrpyXnNDI7B0tCwa6ITAKvNc9Oqm/bS6DCQ9msxMrU5lUSzIvW/wtoZDNQr6p3/s22UxV45GlXHE8aDzGnCrf8mc51Y/wPORkCv7KJrppY4RshwgvMQNd+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr8i8xIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3841C4CED3;
	Thu, 12 Dec 2024 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733989645;
	bh=EdnkbNF2Mlev9vCi8Q3xsS92gcktwZrJwJ/KyMHrPe0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Kr8i8xILaCgvuvofBGCdMGyNh0iC5n0z0uTF+i7O/VU4ojfzLAfbZopWeQhtBc6cE
	 7lwuI2XQBL5lyV0KfZzv7vSyUbjjye0Gu3DQi5AGFHd9xO9cFvtAD1luzZRVZ2PxGi
	 LcHIMzjcehgg3F3cXqYrsELiQqkQPRJ/3YDwxK2YLZ9zn8vmZEhsf7jmbRKkvNojta
	 +o79PgoM1noOFHpBwrh8UrMzWFFigGR4QhCZuL5LJwO7PMI410Zqy+RXZUC3vC33FB
	 xMWSJgtbPKk6RjKd4BCZeXTC8F04bpAqFDbd6vmVY7PifWrOA+XEm0Mf0/41AVdOFq
	 HFxbO1Lr9Mg+Q==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/4] wifi: ath12k: Refactor the ath12k_hw get helper
 function argument
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
	<20241212004906.3087425-3-quic_periyasa@quicinc.com>
Date: Thu, 12 Dec 2024 09:47:22 +0200
In-Reply-To: <20241212004906.3087425-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 12 Dec 2024 06:19:04 +0530")
Message-ID: <874j39qr5h.fsf@kernel.org>
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

Why?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

