Return-Path: <linux-wireless+bounces-1670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB08829CD7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE412820F5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F94B5D4;
	Wed, 10 Jan 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGFbYQPs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2314B5CA
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610ABC433F1;
	Wed, 10 Jan 2024 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898349;
	bh=XT5B8SfXzKjrzyaxuHyuUfKncWhhVuMTLqYWkTSLkuI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rGFbYQPsMz/MNA+EQP6BrJRZEG+5RUduJ6pjqzcOFllCIM20EyG5smfXfs/jKVjeq
	 p+Z9yylodS4JEKmckYtUM8SChhJyyJPqS1fDU16f4YEgWZU2Ct+Nu0Xas8i8IjUkgM
	 SdqkqubDM4GWHWK2V56q/E22S3ZROdHxSQQW5LEIqok5fBTgiM+GydgfzSm0rlBtPB
	 ru5dbQux+h8WvTbwrwTMj9s2fbvRxlbs07Bg0gaV/GkgftmlTUA7mi+TwmCHEEb7LO
	 ow56wJFneZDsgM37u+znSY3PhbSbqgrxnQsNlFvgC9yo7Ob2JdmVW9PQIZqHh4CsSV
	 916EYxHuF7YPA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: 8822ce: refine power parameters for RFE type
 5
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240103070155.119488-1-pkshih@realtek.com>
References: <20240103070155.119488-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489834765.471554.15331919956246953353.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:52:29 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Refine the power parameters for better step response especially at high
> current ramp case that is caused by power inductor variation.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

8d101b15f86d wifi: rtw88: 8822ce: refine power parameters for RFE type 5

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240103070155.119488-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


