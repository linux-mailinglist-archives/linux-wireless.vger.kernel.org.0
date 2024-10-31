Return-Path: <linux-wireless+bounces-14780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBC9B7C82
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C1E282E54
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C41993B2;
	Thu, 31 Oct 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px9dcX/s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E279142C0B;
	Thu, 31 Oct 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384028; cv=none; b=Y3MAase/gEZ7WENa91T5t2qXn5mRuItPHnP+6mlneLuZZCwPFleItbJAwPF7YqXVFK4bSMieDK8iZcEz21XJ1ivXW6U29yO7h4WmoEXA8WEVkv8IZ/9MPmsnQx+FjKu/9XZFGzNQUOQViwIRhvBJIvYJnczi/ALfb2GoPHadozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384028; c=relaxed/simple;
	bh=vOTs2pTzShdxZKRX+arGrlTGOzaPkz4eys6+ZOasVzk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=U00ES76QEkZLpdLPI/ZotX/RNedeT0hYBnV/n79Ku8H37VqHhBT/yoZ6HGNBeO9KaVLMI46mOd2VNoqCaD5nsqHAYC/Dh35VVkUT66QaqcZqCk46WgZcC1UU/5lTL8XOMVDFmWCq6Uwg7WsKOpxlgsLO864yTFotA/gJm7Wr3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px9dcX/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EC5C4AF0D;
	Thu, 31 Oct 2024 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384027;
	bh=vOTs2pTzShdxZKRX+arGrlTGOzaPkz4eys6+ZOasVzk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=px9dcX/sVWK0NCt7aRINs6sLzSCKQDpRp7qWy/el9sYKu5AUcj5eWi0oSHKhZPn0o
	 vdo/88qWcshV9HfGgyGD5NOjZlyxw7RMUIhy5mY0FFyYXB4VPhqJ+4onD/Ba1Pcmrk
	 FHUjUOSbwNYVf2ABI6yr3wrPDbGkXLchitsuDfKK48Tuju9z5YDLIjviTZ5+aVyKNL
	 H8hD5+TkzXr61zdCDNbdo/zrvngx9xhu1pNseef/dfFKHtjI4/X9WJfbmcVMDX3r77
	 0pSZGt6Syp3aHP7/d7rtpO3d2RbADjSISDNjBudoFUBBd8i2qh+LTkPuEmDdAUj89R
	 azxzGjhhPJuzg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/21] wifi: rt2x00: Remove redundant hrtimer_init()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <b1279cd5bf0c77a9434a70a025701ec251a30f8e.1729864615.git.namcao@linutronix.de>
References: 
 <b1279cd5bf0c77a9434a70a025701ec251a30f8e.1729864615.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173038402337.539202.14901476578602305040.kvalo@kernel.org>
Date: Thu, 31 Oct 2024 14:13:45 +0000 (UTC)

Nam Cao <namcao@linutronix.de> wrote:

> rt2x00usb_probe() executes a hrtimer_init() for txstatus_timer. Afterwards,
> rt2x00lib_probe_dev() is called which also initializes this txstatus_timer
> with the same settings.
> 
> Remove the redundant hrtimer_init() call in rt2x00usb_probe().
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Feel free to this via another tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b1279cd5bf0c77a9434a70a025701ec251a30f8e.1729864615.git.namcao@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


