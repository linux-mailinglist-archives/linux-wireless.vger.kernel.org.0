Return-Path: <linux-wireless+bounces-8257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49EA8D2E3E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 09:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FAA1F2982C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5131667DA;
	Wed, 29 May 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njLvxNvD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894415B133
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967805; cv=none; b=bqnum/3q/QKcY6xUVgYy0NCa5dqYdDND7MqVKiAqs9aoFmJXJ+ujGlU12fOtuDIvBs49EZupJXH173RcqIGj7+hPkeveauTsVJf3vFL6juPWE7IqJTpXidFeFtYTa0sRZhSFalEOYuGLqrvTWG9rfHwZ6tx9TQvvFAs4phw7nlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967805; c=relaxed/simple;
	bh=IAjaLFz8NZ8Kow4Y8YMATUCCZxo2UnIPpmwwKLpj4Sc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=twu4sn/SkCG0xfG0i7pZ93Vx9cx4SADRs1iOQKQlFDbZuZ6SsPXz+QTpXsIsCEZxBZou93aDtwZ/arhuVxG1pJKU7VuLOeQ8Zff9FD7ojRFUbgv5Z7guBjFGtYP9xVSOcgSDNAZT0KMsTn9q1vKxWN3Ej/oNxWKp+Y49V8Hd3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njLvxNvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF81C2BD10;
	Wed, 29 May 2024 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716967805;
	bh=IAjaLFz8NZ8Kow4Y8YMATUCCZxo2UnIPpmwwKLpj4Sc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=njLvxNvDOueuIlGlum91BQuDoMlaet9pVLIUa2Zu13jHGrQsVKQUaIm4jZndi88Qv
	 PRKNs+48oyvpepIveXMlVzZpIeGyfsNQGIp1EO+78X2Q7WNinvedyiRGoSU/03dKPf
	 kU6nkK5VSi6aEvQHK3WhL5ur2CcU3IRW/JSxWBoDMQ35BGBiuhN5WyG/ff1lms7pOa
	 MGUys50wdaDqiO79mIsWf99bZFX3YrSwUoEdDBa5zHx1RVvdbwpLCsgOIq6M5mcXT8
	 q93JNo/DQh9S7rxEkc0Ley2P2qYq7+lHtiEEAKVWoKKM3/FOv2ajt1Jdz8PqxQK5AY
	 OWGbtTr9ZgxnQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id B1D4D5F882;
	Wed, 29 May 2024 15:30:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240529034418.4608-1-pkshih@realtek.com>
References: <20240529034418.4608-1-pkshih@realtek.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory info for Thailand
 (TH) on 6GHz
Message-Id: <171696780270.689395.587585181052217471.b4-ty@kernel.org>
Date: Wed, 29 May 2024 15:30:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 29 May 2024 11:44:18 +0800, Ping-Ke Shih wrote:
> The Broadcasting Commission Television business and the National
> Telecommunications Commission announced Technical standards for
> telecommunications equipment and equipment for radiocommunication equipment
> that uses the frequency 5.925 - 6.425 GHz [2], which section 2.1 describes
> e.i.r.p. (Equivalent Isotropically Radiated Power) is 250mW and 25mW for
> indoor and indoor/outdoor respectively.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Thailand (TH) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/7bc861544044

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


