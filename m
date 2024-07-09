Return-Path: <linux-wireless+bounces-10137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0892C636
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 00:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DD81F23124
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9F18005D;
	Tue,  9 Jul 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="XdLJBm2G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6981B86D6;
	Tue,  9 Jul 2024 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563659; cv=none; b=KyhVapbJtWn/9Y+H7ug0dl6jP6pOtVBIgB9mGGFO9FfI4npmXEby7qTqZyVSULx39rjfCXEj2OLmufqIlyWKQyu7j2ZuCElhiqaKH8MPkDMx+d7Bc+iEuizigTPEcANID5jdz/R2Z206ICFd5AAnXgffzsxB0SOkn29nC+NHSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563659; c=relaxed/simple;
	bh=lTHsqg9IUHA2azTOczsXT8kWTiSuK4++zcJICVY5vdg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GjFE2fZvGoY5/4YLAPnQhPJ53Vbcqp7140O75FpkWzMF9cZy6QR8qYVRf2yMy902CSsbxr4BPGMtfhMlS1bk6207+YISeXFMjcgv1VZWgVOAkCf1JtztS+q/5Slb2CFd8wq3r+dkkD51HU/1oUAhlqNb0D27QZ4ktJ91Ny5odU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=XdLJBm2G; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WJb6X1qC7z9smP;
	Wed, 10 Jul 2024 00:20:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720563652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lTHsqg9IUHA2azTOczsXT8kWTiSuK4++zcJICVY5vdg=;
	b=XdLJBm2GZFM/s4u9AQxycetfG81TS0eZ3m6WURqqf6ngh4chaqCH9Yg6QtGuZsCJx1vkvt
	fEMfx2cnmufoOwtijHPV8mjq3HOWudUTVTE+GtFRKJ4HhXR4yT1LdSpX0JdYDvEezUhjT9
	YzC1sWEtvxnX6fDrGebSIaK6JFjiIo0jnLys5qygNu5Pnp1K20P65KgN7tmx0ExLlesMKV
	kiEDQqDesOld/c+u8OZBvGdT8PZ0fKhVIF/ZBMLROOPObTlhYAKt4k2uYos5oRdK9E1Blw
	8X5A2r19JJHSeMAb6LfatVGhRfIfbsqWqNzS6f/EHDLW3aTSjyRVBTcoXK/eEA==
Message-ID: <7dacc734-72f2-43a8-beb6-b7a8de1f6b93@hauke-m.de>
Date: Wed, 10 Jul 2024 00:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: backports@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 5.15.162-1 released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4WJb6X1qC7z9smP

Hi

backports-5.15.162-1 was released. This is based on Linux 5.15.162.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.15.162/backports-5.15.162-1.tar.xz

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke

