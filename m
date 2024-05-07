Return-Path: <linux-wireless+bounces-7287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20228BE28F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 14:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30101C20A54
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8C156F24;
	Tue,  7 May 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fls.name header.i=@fls.name header.b="Z5nJ/lbc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613B156885
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086386; cv=none; b=s5i9JaZj4O4rW65QBZzmBpi35joxxZVG0uU4NewDroJ/LcrqWvHoCxfuPYtyHKSaoono7786JJtg1bpeaKTxpjD7Zn4/fQ9L89nMbyaC1D3zKoCjpNhQq9aJfrqTMtmjTOUYyZeBBdop+cJ9Rhah+kiZUUt03bTGYovRlQ0Ztao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086386; c=relaxed/simple;
	bh=ysBX59eRfW7ZXj/YSCqqK9o3B9fGxHG/fcS70tCmHns=;
	h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type; b=heUYO+E2c4/f2P6FGKLqWc+kWyUeM2S5R9Avee0uZfnFVd1L2wnWfAf6LKvSuVRPOGWCIwwJ/wqhhyegtHZIge7irnC+neooSy42OAWvSIOPvYpCOQTVVC3GV6yOSJYb9AGYooh69AjDzY7dsYZuWJG4VzoeVItTp/yyh8SUSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fls.name; spf=pass smtp.mailfrom=fls.name; dkim=pass (1024-bit key) header.d=fls.name header.i=@fls.name header.b=Z5nJ/lbc; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fls.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fls.name
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VYdVJ5vZwzm87
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 14:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
	t=1715086376; bh=ysBX59eRfW7ZXj/YSCqqK9o3B9fGxHG/fcS70tCmHns=;
	h=Date:Subject:From:Reply-To:To:From;
	b=Z5nJ/lbczsWXl6js+ur1IknMOoUutFB0yzoFn4PlOequnxNPVGf+InJ+IkvlaavN0
	 TPtNhEjRNG6umxoUqx/GvSu1eddqQGUCkHMx9bYMZT2SWTdLCVOqXTlHuK/EnDqf3e
	 Ok399MZNj1ufPeVAxHGYR/1mMRofoQyjXjTAnsUM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VYdVJ2fnzz5GK
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 14:52:56 +0200 (CEST)
Message-ID: <a873e2a60e5774a7073d217573169f48@mail.infomaniak.com>
Date: Tue, 07 May 2024 14:52:56 +0200
Subject: Mediatek MT7927 support
From: Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6ImJIWTlhMmVwNEdqL08vN3BGckVkalE9PSIsInZhbHVlIjoiaUFYZ0lUT2FZUmVxM2p4ZWhqMmxSZz09IiwibWFjIjoiNGZlNGViMmRkMzUyMWQ3N2EyZWE4ZGYxNGJjOTViZDUyMjRjZDAwMmRjMDk5NTk5MWRhMzYwMTQxOGMyODg3YSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IkFsOGwzOGhOYThUM0xtVzZGWHJsL3c9PSIsInZhbHVlIjoiMUZUY1F3V2VqVXVMTlh4aHJKY3orUT09IiwibWFjIjoiNWMzOWJiMDIyMjFkMWJhNWU3YjA3MjAzNTIyMzdmMGI0NWE1ZDY3YTU4MGVhMTZmOGRmMTEwODE5NDViYTRmZCIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.680)
X-Infomaniak-Routing: alpha

Hi,

I have a Mediatek MT7927 WiFi7 chip and can't seem to find a Linux driver f=
or it. Does one exist? If not, is there a timeline for when we might expect=
 support?

Thanks,
Florian

