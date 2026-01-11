Return-Path: <linux-wireless+bounces-30637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0238D0EA29
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 11:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A9CB3003FD1
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689622A4D6;
	Sun, 11 Jan 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="XvYbx5sk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F61A08DB
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768128942; cv=none; b=PvMFiyYKm73AYHmz5Tr/pMhRpKtBgsc5MvPvATCFijujqHTmUHuK+1Xhj/Za3D0S5++ttVObhapaJOHyKmzFHOxxG370xs1mljBQkOcQpwho0mIoxDx/ImwzaxcBaNLT7zm2pMgvXFjAQ4AA37nPZavQ5B3WDK1uF/0+Wx3w4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768128942; c=relaxed/simple;
	bh=P+WhVxuZ7iB5LTebgjeJhW2mbmqDhn5y1OfYKyu+1F4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Fm6JwkDYSVHFRSQxWv1QP74Zzz1hU2gEM3Q7GCDN5ozhkmtatsbrbOaDxKsP0xuNijYNaSMJVyVZhOlIvjeai1/P1tR7ywibdzx5Ont2OWwx6gg3Cmt4VKTSfFPih6mvtZ06psOK+8aUbjGgMVtvIxR+BSz2g+UF//I7aA4O2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=XvYbx5sk; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3cca:0:640:f0e1:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 3137480CAD;
	Sun, 11 Jan 2026 13:47:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id blOeGckGma60-SURPuzOF;
	Sun, 11 Jan 2026 13:47:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1768128460; bh=P+WhVxuZ7iB5LTebgjeJhW2mbmqDhn5y1OfYKyu+1F4=;
	h=From:Subject:In-Reply-To:Cc:Date:References:To:Message-ID;
	b=XvYbx5sk9Q4siksskgtYSMorrtmgYt7ly5q74ZBvZr/eUdS9PV2E9YkHWFDuYJCS7
	 jKNe3Yhuj9RhT23SDD6vRzGEbbeqB9l5JwkapOJu7I3HWTItm2OEx9uNYPzEcimQ13
	 sXmhuq5j3xzxsnn+QuhHJK2els1l/Pt9WdLbie/o=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <b410fa3f-0241-4805-afb0-efb950e04bd2@0upti.me>
Date: Sun, 11 Jan 2026 13:47:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tiwai@suse.de
Cc: ath11k@lists.infradead.org, baochen.qiang@oss.qualcomm.com,
 jeff.johnson@oss.qualcomm.com, linux-wireless@vger.kernel.org,
 mpearson-lenovo@squebb.ca
References: <875xaypnkz.wl-tiwai@suse.de>
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <875xaypnkz.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey folks,

Sorry for bumping an old-ish thread, but I've had the same issue on a T13 Gen3 machine as well (model 21CG), and there seems to be no better solution in sight.

Also, here's another instance of what I'm pretty sure is the same issue: https://lore.kernel.org/ath11k/6268b094-5a40-40d8-8461-9c9b0f9e1ae3@oss.qualcomm.com/T/#t

Can this get landed at least as a temporary workaround? Also, should I submit the 21CG quirk as a separate patch?

