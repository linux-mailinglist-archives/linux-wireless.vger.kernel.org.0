Return-Path: <linux-wireless+bounces-11544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CB954689
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C70282EB1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B3172BA6;
	Fri, 16 Aug 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwz66oou"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E8172BA5
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803057; cv=none; b=BZwtbyDXHLr0xdkJO6YVCM7/vLrjlFfwS1goZpdmvKUdAdGHRg2vAVPpXAhiSlWNii8VYIIQkPqqIDpnUPtD93xmF0/ix7a4ilEBx/R6U8DbEXM7G7BUw8PRJ/2LU1fwhdYPsxsulDc9gxQep7agBHAFRlBuZp+d144g7B0p6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803057; c=relaxed/simple;
	bh=G+iU11CVRI2zWAm3R2E+H22mLEJHMxn/QLIf6CXR+HY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RNdVR7iZpXTbYNJEVjoULWGEsjWE2vud8q7DN2AD9+tCOdy4xb+dTpOQJeKtXDDqja+L8Bz5wgYYCO43T2/Se3T8b5wliT1uUqZxaKOwfDWgylz+q+EceBeEmB/u+RkPYEBUoqHVO4JEa4vcUAaaUO7wKUCeD/w8VzmC3tKrbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwz66oou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E02C4AF0C;
	Fri, 16 Aug 2024 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723803056;
	bh=G+iU11CVRI2zWAm3R2E+H22mLEJHMxn/QLIf6CXR+HY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Rwz66oou/88UhVN8Pgpzw31z2pO/6WRB7iE4/1Qbxy1lSGxaGMc1LJtkcq1cFC80S
	 Wa23PrhzQCeBVaKjyZOVfXsS5VrL1rnPJOZXYlxwVOxgDCvSgC1OSdhvtj/WEzal7q
	 iMIjMnxKCfm6rUlFmsbhkq49BQ/swCR0C2uQypDlUc86CxI+bTGb71oN4WAQ2Nlogs
	 V8NKLYsJruh0ONW1GeXyB+4CXlKwimlA5TxEVK0S6cFm9VFupJFpw1eR0Wk1SAodDK
	 jo+RR5nDJqFL+iY/NagYi/gEHjB8yju3pT43/loG/msARUX/0QKYMib1zE5hwAIOxq
	 R5o9g+xrMLQ/w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k_htc: Use __skb_set_length() for resetting urb
 before resubmit
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240812142447.12328-1-toke@toke.dk>
References: <20240812142447.12328-1-toke@toke.dk>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 linux-wireless@vger.kernel.org, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgens?=
	=?utf-8?q?en?= <toke@redhat.com>,
 syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172380305416.1520121.9907750833895211924.kvalo@kernel.org>
Date: Fri, 16 Aug 2024 10:10:55 +0000 (UTC)

Toke Høiland-Jørgensen <toke@toke.dk> wrote:

> Syzbot points out that skb_trim() has a sanity check on the existing length of
> the skb, which can be uninitialised in some error paths. The intent here is
> clearly just to reset the length to zero before resubmitting, so switch to
> calling __skb_set_length(skb, 0) directly. In addition, __skb_set_length()
> already contains a call to skb_reset_tail_pointer(), so remove the redundant
> call.
> 
> The syzbot report came from ath9k_hif_usb_reg_in_cb(), but there's a similar
> usage of skb_trim() in ath9k_hif_usb_rx_cb(), change both while we're at it.
> 
> Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

94745807f3eb wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240812142447.12328-1-toke@toke.dk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


