Return-Path: <linux-wireless+bounces-26847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47CB3B23F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78ECB3BDC8D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 04:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD74316E;
	Fri, 29 Aug 2025 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="es3ftbYK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1313B2A4
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756443402; cv=none; b=jqLgb8fyAEOCrfHo0se8/KPlLpv7Hkc6vpUFiKY6c/9uUT6li60rRfMIoGmP8dCiQQTsEapfuM7/EXvvD5c/Zp4QhDOb1pBFsiWnHIv8Y3jvIqn80ZB4hMKblqlwPxCgJHZDUzd+rtG9krFaFdaBDje5PzQRNdlbfhIa9q9YSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756443402; c=relaxed/simple;
	bh=DWdtutVrdVzD20f9lXmFkjgipegoCPsJQVQnzWG3G3o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tEchVF0s5OkT+vF4jPdm7KK9IigW/V6qAwhFoZbd1XUUq2Mdxj6gvD/MhUS8O4j+hy9XxTxa/4UjwHpulS/CM4jWtso7sBXVOIezeyaMUPgvKkJ1pVBKlgCaPo+IKZoq8OyGjxOEwakdudoj8VJXClHlyc85Pc3Bk373x590sUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=es3ftbYK; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=UwlWfGpFRZZw2EVfifb5idYxtAyyxRpYL28gWNnncIM=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1756442491; v=1; x=1756874491;
 b=es3ftbYKi3gslbaVbvFpRBdeuqylBgqeJDDnGIDmektOFSdxbrsBuBp9duj8LJ9xxqUxsP3S
 wQN5hLiYGdmGUTmhhDBuPZfGz3jT4W+iTX7M899XKwZhUGPi2lX08Yf8gTYHMunUqstyFmurAM7
 ieZzUmNWEMrOKjrBaNBJHsw7NMSY0WnE4fzgPcp5m6j82jcafiS/uGiVtCINA0/zMsrQ4n/Y0uF
 xlSyGXj0rlfAKDClIfyOAVEOV1L1YKnoIh8rCEw/zWq82H3GvX3vJZwtkkJ/PKm9vPM0EmC+7L8
 Y1msc+f60dvKL+x68bXAwaM4QlU0S3DhUBH00CUfzyApw==
Received: by wiki.archlinuxcn.org (envelope-sender
 <oldherl@archlinuxcn.org>) with ESMTPS id f79781ac; Fri, 29 Aug 2025
 12:41:31 +0800
From: oldherl <oldherl@archlinuxcn.org>
To: linux-wireless@vger.kernel.org
Subject: Possible Regression of RTL8852BE on linux-firmware-realtek
Date: Fri, 29 Aug 2025 14:41:27 +1000
Message-ID: <2082485.tdWV9SEqCh@alphecca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I am using realtek RTL8852BE on a laptop.
After a recent update of the firmware, the wifi disconnects often.

I am using Arch Linux and confirm that the good version of firmware
before update was linux-firmware-realtek 20250708-1.
rtw89_8852be 0000:01:00.0: Loaded FW: rtw89/rtw8852b_fw-1.bin, sha256: 
81c146406dce47cfdf719f88d0fdb13b75cfb651226650722280ab81f7e331f2

The bad version after update is linux-firmware-realtek 20250808-1
rtw89_8852be 0000:01:00.0: Loaded FW: rtw89/rtw8852b_fw-1.bin, sha256: 
95076d6d128695b29830e8a0e5efbd0af60a5590ad37bbd8591a0281952a61de

The commit of the firmware update is
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/
eb03c8ce595d75f2a2f81cbe87698c2539f64377

I was using the linux 6.16.1.arch1-1 kernel for both attempts.

Possible related log out:
[ 3455.877469] rtw89_8852be 0000:01:00.0: timed out to flush pci txch: 0
[ 3456.081010] rtw89_8852be 0000:01:00.0: timed out to flush queues
[ 3456.147252] rtw89_8852be 0000:01:00.0: timed out to flush pci txch: 0
[ 3456.352106] rtw89_8852be 0000:01:00.0: timed out to flush queues
[ 3456.371340] rtw89_8852be 0000:01:00.0: timed out to flush pci txch: 0
[ 3456.576661] rtw89_8852be 0000:01:00.0: timed out to flush queues
[ 3456.589698] rtw89_8852be 0000:01:00.0: timed out to flush pci txch: 0

I am also posting the bug to Arch Linux bug tracker:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux-firmware/-/
issues/26



