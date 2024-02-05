Return-Path: <linux-wireless+bounces-3124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71425849574
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 09:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA73286D14
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED961170A;
	Mon,  5 Feb 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Hbhpsx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7011709
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122245; cv=none; b=OMUKvQQVzIke2vKvghWxHrNDFjDtzpzKnM1zYRhh9vN7M+8WqBBpYI6Z1ClX7n94sqkxW0/HpotNZG6JlZI5Grj3i9lkBMYkpIrUZcz+nBNfiqIngS/ODmvo6Uk6y/R0GJXFGE3wgsEun2qb8eIXhrk0ayVkkHjoL3sW21Qtb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122245; c=relaxed/simple;
	bh=hK6G4oM70wwT1JwJR2gW0vwH7YkiLydC22reeLWHZuM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JlTexDT8C84P576Gfa3AUnAQ3sfWnMJ3JqGpRjAo01EusM/ajpuf99AnGJ3blNAEa3d8gUFow8swIlvbPCPRouSDUKKN5D+eYYEbYn5KDbJqnfnexsE1JbnRcCXSurJ1sC/HxQridr+qlOxZxk1YbUHqfZ9ry/vWgY2VPdGf2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Hbhpsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFDDC433C7;
	Mon,  5 Feb 2024 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707122244;
	bh=hK6G4oM70wwT1JwJR2gW0vwH7YkiLydC22reeLWHZuM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=m3Hbhpsx6lWAIIskYed3JtA0efoq9FZuf6aWtayWu2B4Pst+3i1sCegxfHx4V9ktX
	 9G2PsUG85ww6CNI4n9dEvNXs8dGdEJshjJecOy4dnZKyuivEEzh2Lg6rIcvO4uOESz
	 qw49aq+5GXbOr+SZVIzsMo5JVBAq6WJcV8Ol2HodtCejHS6IU2lp0ZIugQM4YByC4D
	 bd48Wwy2FSX2K3EQV6lsOUGNiQSlX7AbgYDloNaZxto0VeH4akupSYKjL9rOqo0e8c
	 q8kH3dw/Ce8EYidgsGjHUiQFXG7Azs3s/0AdsdN6oX6YJpnCrwsSv34/c6ns12FrRc
	 DqWWfdVEJNTbQ==
From: Kalle Valo <kvalo@kernel.org>
To: <sean.wang@mediatek.com>
Cc: <nbd@nbd.name>,  <lorenzo.bianconi@redhat.com>,
  <Soul.Huang@mediatek.com>,  <Leon.Yen@mediatek.com>,
  <Eric-SY.Chang@mediatek.com>,  <Deren.Wu@mediatek.com>,
  <km.lin@mediatek.com>,  <robin.chiu@mediatek.com>,
  <Eddie.Chen@mediatek.com>,  <jsiuda@google.com>,  <frankgor@google.com>,
  <kuabhs@google.com>,  <druth@google.com>,  <abhishekpandit@google.com>,
  <shawnku@google.com>,  <linux-wireless@vger.kernel.org>,
  <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] Bluetooth: btusb: medaitek: fix double free of skb in
 coredump
References: <ca2b3447d110874d90e93c6ddf972f4ad2bc70f9.1706917839.git.objelf@gmail.com>
Date: Mon, 05 Feb 2024 10:37:19 +0200
In-Reply-To: <ca2b3447d110874d90e93c6ddf972f4ad2bc70f9.1706917839.git.objelf@gmail.com>
	(sean wang's message of "Sat, 3 Feb 2024 07:55:27 +0800")
Message-ID: <871q9rb934.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<sean.wang@mediatek.com> writes:

> From: Sean Wang <sean.wang@mediatek.com>
>
> hci_devcd_append() would free the skb on error so the caller don't
> have to free it again otherwise it would cause the double free of skb.
>
> Fixes: 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
> Reported-by : Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

This should be sent to the bluetooth list.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

