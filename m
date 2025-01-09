Return-Path: <linux-wireless+bounces-17239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA6A07669
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 14:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD103A5C70
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DB2010FD;
	Thu,  9 Jan 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU2SKfzq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A7BA2E;
	Thu,  9 Jan 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427829; cv=none; b=o+B+VCQF+uhHHyAOGKkEQNhjLSd1Uh4BKvsBbQvC37OpNwS73dK8y7nCY3hrQJgR4cU3i8FEKCOoQLS4pwfdierR4BNqdnalzGGPNKBtp0mfGPcqz2es18NjlAY2w6sgiNbft0U/7QW+a78+D+6bhvuN1Wvc3P8DkuUNAJ5lKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427829; c=relaxed/simple;
	bh=N57htIgxqHB4759bpdKXhT7qhOV3adZnhD4UkokENow=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=B364OOJSyjz3FezYJXREZBWAi5StTq5NId2tq5N1xzObvkcnod3potEgUaz1vhVOGcgttSGuyVz9wBfgZ7sH4nuwg+v/LNy3nBV3QNm21hZVVSJJ3XCso+jRcY9aAQKBuMEd5o9YNOUZzWCen6u41uFchPFSwt21p5W2HqoPLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU2SKfzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C529FC4CED2;
	Thu,  9 Jan 2025 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736427828;
	bh=N57htIgxqHB4759bpdKXhT7qhOV3adZnhD4UkokENow=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZU2SKfzqsNFilqfW9EY+uEmi7QllZLMKhgBRb5qCqBS0XB2vd2oiaQ4USE879ln7K
	 wX0MUdmlO7DQfe6DXWxyAVxrPxNvEMB6FBkF1oNjQu/3/VfdjQ5VQBpsUiC0tuVWoc
	 74V4Cdo6ynkbjDFcJNKldBClP23Q1jrHqlweCQYD+VWtPK1/uRd1WrHJceX1dUGOPZ
	 lrSZUvDs8g8iJHv79xJi2/WZCZQI0t/Qv3xxERkgay5hYnxNLidCVVLhA4ETI683Kn
	 6YEHDZ+HPACTD5+KNovsOoL1lSRUz9CWWSt1VfoqpOzQcCNq4W0PfM1omi+n8qYJi/
	 BETGB2SkzOVfg==
From: Kalle Valo <kvalo@kernel.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Jeff Johnson <jjohnson@kernel.org>,
  Cedric Veilleux <veilleux.cedric@gmail.com>,  Vasanthakumar Thiagarajan
 <quic_vthiagar@quicinc.com>
Subject: Re: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
References: <cover.1732293922.git.repk@triplefau.lt>
Date: Thu, 09 Jan 2025 15:03:44 +0200
In-Reply-To: <cover.1732293922.git.repk@triplefau.lt> (Remi Pommarel's message
	of "Fri, 22 Nov 2024 17:48:00 +0100")
Message-ID: <87ldvkdtqn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remi Pommarel <repk@triplefau.lt> writes:

> It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
> radio silence could be observed followed by the error below on ath10k
> devices:
>
>  ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0
>
> This is due to how the TX queues are flushed in ath10k. When a STA is
> removed, mac80211 need to flush queues [1], but because ath10k does not
> have a lightweight .flush_sta operation, ieee80211_flush_queues() is
> called instead effectively blocking the whole queue during the drain
> causing this radio silence. Also because ath10k_flush() waits for all
> queued to be emptied, not only the flushed ones it could more easily
> take up to 5 seconds to finish making the whole situation worst.
>
> The first patch of this series adds a .flush_sta operation to flush only
> specific STA traffic avoiding the need to stop whole queues and should
> be enough in itself to fix the reported issue.
>
> The second patch of this series is a proposal to improve ath10k_flush so
> that it will be less likely to timeout waiting for non related queues to
> drain.
>
> The abose kernel warning could still be observed (e.g. flushing a dead
> STA) but should be now harmless.
>
> [0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
> [1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")

On what hardware and firmware did you test this? As they can behave very
differently knowing that is really important.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

