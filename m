Return-Path: <linux-wireless+bounces-14968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD89BE201
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2B11F26AB8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C681D6DB4;
	Wed,  6 Nov 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="u4rvF5EE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBE1D0DF7;
	Wed,  6 Nov 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884192; cv=none; b=kh0QlOstz5FVc611XbjUmAxG1QIP1nVNUsKn/MtC5OVTYq6RRofUVLVxIZABKLhoOSjkOlQc2gxHo0xcRD67xHKf3cR91NMfZ/LORxWRcu8VQIde7j5UX/YSrWrjBy/+k7Ajqg45Y5Lwp43rovOZ53lVTxXmCgHwYCui3JuGcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884192; c=relaxed/simple;
	bh=YfzmI+W2YhyOs1zjakBBcjgIUvxri3EGSUhBb+kPLNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMIHbA00srMAUd2Tc4uWopEffcpWnKfUrGlVYhvFvkkyi+itEvIqSIjsI+HTwyQDFR5lIPPsh+JlxnAWdIBGagji8O+EBncn3ldpwmwzt+JDRVA5WVac/HlionBjRInY1w9Rby2Y6tdWIZiOGPBmejQFprGzUzZ1eenTpgMi+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=u4rvF5EE; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1730884181; bh=YfzmI+W2YhyOs1zjakBBcjgIUvxri3EGSUhBb+kPLNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u4rvF5EEY4hLyrJkAiGje9TG948l7FvkMhApSvYyJm3JdZFrxsANcYof8N2H+xnyK
	 ZfQ3MWV3GmueVd29OqjVc5T+v8oIhKR80faBliHgl+cfwCI6bIPYfiHRlZ38hz9LRs
	 Vrntgl/TCIYzxsUEEa7GNxOpJ9u+19cjNk/VB77xWTslow0xBReVu+vsN83GQBedMN
	 HbiNMd7KamWWfdRcpLk5F/kddUJgxtME/XxN0KYe+BVmDXBV7nLTyq5UF6wzdylivv
	 STk7nr2MdZqsYiekzIgtHU3rpb48LlMgzbQ8cFPjVMTZ2HUVKEWeazlZ/2z+hHSDsF
	 JXOWeSGw5h9MQ==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] wifi: ath9k: return by of_get_mac_address
In-Reply-To: <20241105222326.194417-1-rosenp@gmail.com>
References: <20241105222326.194417-1-rosenp@gmail.com>
Date: Wed, 06 Nov 2024 10:09:40 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y11w7mp7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> When using nvmem, ath9k could potentially be loaded before nvmem, which
> loads after mtd. This is an issue if DT contains an nvmem mac address.
>
> If nvmem is not ready in time for ath9k, -EPROBE_DEFER is returned. Pass
> it to _probe so that ath9k can properly grab a potentially present MAC
> address.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

