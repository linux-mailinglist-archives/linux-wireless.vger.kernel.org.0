Return-Path: <linux-wireless+bounces-5077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84119881C16
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 06:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCCD1C20C90
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 05:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D392BB1E;
	Thu, 21 Mar 2024 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLwePH6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B52BAFC
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710997944; cv=none; b=i0GKP/41ArshbxfrrWJ5wtmlnC5PbZFtdthqZ6yMCU/y/ZlISTp7OI5jg/C1V01KL9QYhvCA0j7+kws1xFD6s6EekWKgPesyBLw5UJo/kcDv+hbk7JDf6UoetARM28+aYiD7kkj7jlSuwQCI/l93YO/5dkEhwYe9gfZYtoWgHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710997944; c=relaxed/simple;
	bh=RFV1FT88PenEmLtj0jYkao4r/JNhbBrS6JfngX2JwWA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ALxCrTE9cDa3qLckGpahNjUm+ue32VSnz2+5duGge8VGmUBDubrgWmpkmPkXsFfogLvrJiUfPybcLlWDPmkP5lzkiIF8JdJKg+jjWTzyf1szzEA9bgaVU1gDRsCGXeaXNGpjPndu6L45JzYoiwPX72f2pRs7Jwcoqc2L07qmV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLwePH6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88018C433F1;
	Thu, 21 Mar 2024 05:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710997943;
	bh=RFV1FT88PenEmLtj0jYkao4r/JNhbBrS6JfngX2JwWA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aLwePH6MZa3m6+2AFlStQ6jmKTkIRcOeLH00ZVepcKJ23TRnofnmFMQW14J6gK2BG
	 PUH8xCyETrHWAwG6bpA4fo54Bb2YCBUr9diovAaYuBfeYGXpfflvtrK4lrJF+KxCoc
	 FUGVxYqjVAJTITq7M8xC+9DABKDVnyqtdwNUHFUBKOoohMViAl453jSvLNNqM5FpbL
	 rnZC4nQaNAtTkWYkWU28dZAW0VJSWj3bxYyJyXVVdWi1giTvgPgkJ6yp1FxTCsYGWG
	 ATeupN5zO+yh9Zp3kf1AKNmRBkEZ2yuFBVwWa0zuiIYdBleKmdByOEHWukFU8QUlf+
	 6uJo6ZEfqzkKA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <leo.li@realtek.com>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
References: <20240321025603.20614-1-pkshih@realtek.com>
Date: Thu, 21 Mar 2024 07:12:20 +0200
In-Reply-To: <20240321025603.20614-1-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Thu, 21 Mar 2024 10:56:03 +0800")
Message-ID: <878r2c2mob.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Chia-Yuan Li <leo.li@realtek.com>
>
> The hardware command parser of txptctrl (TX protocol control) has overly
> stringent timeout conditions, which results in false alarm. So disable it.
>
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I'm in the To field, do you maybe want me to take this to wireless tree?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

