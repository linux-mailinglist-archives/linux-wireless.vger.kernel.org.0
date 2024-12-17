Return-Path: <linux-wireless+bounces-16491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7899F56ED
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958E0169B32
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67281F9419;
	Tue, 17 Dec 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFAOu9QA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02201F9412
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464125; cv=none; b=CYa+CU7S0rDm4bYdXVCli8p28e941VXB4+LNMzK5Bc0QN8vj0fw2RZAAHkvhyj+0ay5at7zuk3OMbWzu32nTpZpVV7tYMAeNTRwuTNDV+KyZp9iv3sXo2qny6rV/wosdX+xB8wBA7koWd8icVZ5u2K+n/R1ZHn/1BTAHJmWsFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464125; c=relaxed/simple;
	bh=ycbw9ZuXw274TIKiy7rOq7Ni2L30dyQsud/JiF7653U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BnxK1mnUaEA+woS5oQrZQ5asOPeUgmBj5BRnozIR3jQZ+IUHUTyyb0lKVcQNAGB764qyDQByp9J94XEYPdGCURCfY5xHEgJeyBIImSQwazeY5gaqT2DND74G8hEE4vO+4HXSYOlPIfbDaqhpw1au8+Xc5oCnYgsSeTKHOtCvf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFAOu9QA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781A2C4CEDD;
	Tue, 17 Dec 2024 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464125;
	bh=ycbw9ZuXw274TIKiy7rOq7Ni2L30dyQsud/JiF7653U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZFAOu9QAo6V10O8NfAEPgEho5N79QyIhmYY+9gIYLI+1ybCodqXG3CLkXjsK/2fLA
	 8i2J+88zYalGaaIIoz75hIrZS0o5KL/4aS9rbl9lqbm1Uo66QF9s3Ys3ZlMeBuoi5M
	 6Dp1AF0+ZHUMN10KwPN7nKcq9Ufqj282ARDPcCvHGNlekYLwpAdKGflXJafZokEOWD
	 QZri4OjB6iiydBFdKsWLiUqjLFZV3O7UIYiSJ+dccnRE6AY2AZOy171ZKCTDHvqUpx
	 /pJiHyW8kEaw8i4VMocO4NZZBF+jz1eA4bKRqVjwVhulbPc4DKrA0VgsVEFfK6vkFr
	 q6W2YJ4Iaqe9g==
From: Kalle Valo <kvalo@kernel.org>
To: Praneesh P <quic_ppranees@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Add support for parsing 64-bit TLVs
References: <20241204071238.948885-1-quic_ppranees@quicinc.com>
	<87o71bmwoe.fsf@kernel.org>
	<fda72aba-f878-426f-b410-a4cecf77d1c3@quicinc.com>
Date: Tue, 17 Dec 2024 21:35:22 +0200
In-Reply-To: <fda72aba-f878-426f-b410-a4cecf77d1c3@quicinc.com> (Praneesh P.'s
	message of "Tue, 17 Dec 2024 15:00:48 +0530")
Message-ID: <87ldweksqt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Praneesh P <quic_ppranees@quicinc.com> writes:

> On 12/16/2024 9:45 PM, Kalle Valo wrote:
>> P Praneesh <quic_ppranees@quicinc.com> writes:
>> 
>>> There is mismatch between the format of monitor destination TLVs received
>>> and the expected format by the current implementation. The received TLVs
>>> are in 64-bit format, while the implementation is designed to handle
>>> 32-bit TLVs. This leads to incorrect parsing. Fix it by adding support
>>> for parsing 64-bit TLVs.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> What about WCN7850? The commit message mentions nothing about it so
>> I
>> can only assume that this breaks WCN7850.
>> Please remember that ath12k is not only a QCN9274 project. If I got
>> 0.01
>> EUR every time I say that...
>> 
> This change is common for WCN7850 and QCN9274. Sure, I will add
> WCN7850 tested on tag in v2.

I am not exactly looking for a Tested-on tag. What I'm asking is that
people take into account WCN7850 when designing and writing patches
ath12k. For example, is the firmware interface same and similar
functional differences between supported hardware families.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

