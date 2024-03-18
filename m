Return-Path: <linux-wireless+bounces-4840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B987ECB5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF87B21E1A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F4535A7;
	Mon, 18 Mar 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EayC+uec"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB46535A3
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777112; cv=none; b=qjSgo3yZqXtDYOvlxXBA6tTix5zFldNAwrlQ35010BiNyD+zYmd85vGKqR6jb/UyTCrad0VLjgpV7fnmB3nXu08uQHmOu2SxQUci/EqPsxmsgwMks5bIQ5iHH6WAjhQ9v69aooXlD9YDDnZKMc00p9q5V1ft2solvDBq+9oQnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777112; c=relaxed/simple;
	bh=PHnH0COEHNBZDq8Wm4oxYFn87tNlx1Q+VbmW6kLBc80=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N9xKLtUtRtjjvkj7KWinREmPZwFKnXiXbtenOC9beYk6cb3d64cJcXCnqiHTnf+p4B/xpbC4vqsegEnQsVF8KrPIRqIjiu0B9vuckYqarcGiaBNZB8fFOl1UV+hQeKe9OztY+fASc/jAE8+zPyUSh7cOyIPe+q6N9cahoDD/5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EayC+uec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC480C43390;
	Mon, 18 Mar 2024 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710777111;
	bh=PHnH0COEHNBZDq8Wm4oxYFn87tNlx1Q+VbmW6kLBc80=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EayC+uecMtkOf0ReVhmrWiOONMG47Y1bclCnITcIIeG+VdC5eFMfDOThKVOR04sNO
	 hT/n+cB0gwB7GvO2YQjMAhhgzjl/Q7LiHZEXnsWrNgqEEJ+8HvbycV3+2/t4EbCFrH
	 Ca1sCtoQb4cWM0XLqWvkZNbjNsnUNc490jipkYsa/VQVb9zqO3v/gGLLZpR1f3/CJy
	 NHM0EudCDxmIyrox4rVDcJ0Y3rrvBvS//lY7yGlPdzS0NgEw96UxNSi5wl2Y+kX6Ug
	 /wvVpnNZ6RAGTuwb9oeoy/RhusMnXz/8apg0jXtKEUEZzDcEMLLcf7PJeT8QQ/xHh+
	 Sx4aSqF8BQRGg==
From: Kalle Valo <kvalo@kernel.org>
To: Aloka Dixit <quic_alokad@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: use correct flag field for 320 MHz
References: <20240314204651.11075-1-quic_alokad@quicinc.com>
Date: Mon, 18 Mar 2024 17:51:49 +0200
In-Reply-To: <20240314204651.11075-1-quic_alokad@quicinc.com> (Aloka Dixit's
	message of "Thu, 14 Mar 2024 13:46:51 -0700")
Message-ID: <87sf0nczca.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aloka Dixit <quic_alokad@quicinc.com> writes:

> WMI_PEER_EXT_320MHZ (0x2) is defined as an extended flag, replace
> peer_flags by peer_flags_ext while sending peer data.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Fixes: 6734cf9b4cc7 ("wifi: ath12k: peer assoc for 320 MHz")
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>

What does this fix from user's point of view? Does it mean that 320 MHz
chanels were broken before and this commit fixes that? I can ammend the
commit message.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

