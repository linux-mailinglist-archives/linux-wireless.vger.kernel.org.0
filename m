Return-Path: <linux-wireless+bounces-10642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF49400A6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 23:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E90528123C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF518D4A0;
	Mon, 29 Jul 2024 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="y4jePluT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246418C35F;
	Mon, 29 Jul 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290062; cv=none; b=bnMifs+hv85WksMn7rYrOAc6ngU0QmTudHyEJibmFU13HKpxXKhS+TVioCfLF0ApRzVl6g+d+oi3fd7fdB+FEI3dBHLVMraYiBl0t5MMB3NtVFtL0mNGqQC6Qb9Tgs4JiCE5eRp4MLR2B7Mfa6LhFDmkzyjbFwP0D5KzWAVKc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290062; c=relaxed/simple;
	bh=1XAvQzhwcWAUk0GxeXjM8TDUe2TCqqUF1W7OVxFewpw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pCCNTcm0jGDwNAa0eX5lq2cPCLUKXfHrl7M/X1UqvZGciQNCjaGCeQB3/5Os6ihL64yguIYvMfI17iblVBFR56LDwTv8MQJHpRkJ8vcxDdRq3WzOooJUeWPGyorokgXUo5VJILSa0rRdohbcfe5Iu+7PhbhEPTITlzUwHi+7Tss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=y4jePluT; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WXsZb6PTmz9t3T;
	Mon, 29 Jul 2024 23:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1722290056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1XAvQzhwcWAUk0GxeXjM8TDUe2TCqqUF1W7OVxFewpw=;
	b=y4jePluTfGXv7Xf+fjmF1/5H9p0lTYHwZChwQWY1hxmgf/msc3frFWQBGYcdAkPPwlSVZG
	1A1ZmSHmCoBq8NbX5Yo18xw9yY/tsSGrVcbFlYH7ZXJ2Vs2vQk6DZPwHb+oM4Ml1PDWq1S
	ZyJgclozTYd7tQz/fGaAiPqPuIwvdpJ5YRXAAMovL+rcvaJZsreUsnmSKO6CFCr0fQExJq
	9rW98VJnGy1FQw8Cym5iK/gJ2qJQJOQHVnHEyVma+wHPmLBVyqKkmbV/5eSXav3r8ntCCj
	mdhweIT5krK90GbLbbvcK7Gge3qy67mBrGdh6xX2bnNVRxJWJyk6KGHUsLHpNg==
Message-ID: <2596c6e5-a027-4d56-9427-f78656bc3da7@hauke-m.de>
Date: Mon, 29 Jul 2024 23:54:15 +0200
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
Subject: wireless backports 6.1.102-1 released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

backports-6.1.102-1 was released. This is based on Linux 6.1.102.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v6.1.102/backports-6.1.102-1.tar.xz

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke

