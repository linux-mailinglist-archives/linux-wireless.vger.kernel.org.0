Return-Path: <linux-wireless+bounces-29369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41992C8D181
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 08:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E844E0690
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A4254AE1;
	Thu, 27 Nov 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DERltSDE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB13C1F
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228546; cv=none; b=a8XMZu1z9nRV+vUYs/tLXk2O7SfOQPCGJSh3LYvxubBSdAMa9KKhfdit4ucZCamJlrtGm4QW4wFaSj+MFVgKEx/xg3jDN5cvSKotDM2eR1R+lBGnDJE0oLupTyXHIzP2uFapmQ6V1BMCOMJ/de2TylpYuHBK5C/96seCoV5YgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228546; c=relaxed/simple;
	bh=lsY8PDgyHb3F00ijEIIECofRrZXpztHpBb0OSsSBZvM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sckg/zL1ULwdfo143nNtnVL/PAgTZJsKpmarNVUMeNCwZdfHQatHJJ6QeDX9rutRvsmCXnDO4fdpaET+aMskztT5DMsToQKwWYRLaz4Pt8b58AzQ8/Te+dfR0mDIr95/akrktrMg1zbhgkkEVvcSkhtq1+HkTqWr9O3ltLAxxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DERltSDE; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yvil2cohqnbwzcrfi6r2b6lzq4.protonmail; t=1764228532; x=1764487732;
	bh=lsY8PDgyHb3F00ijEIIECofRrZXpztHpBb0OSsSBZvM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DERltSDELxTptScI/GUnDi0SintKR26pnAQblHDzIPJKHX8tBWEbQQf3cYI8Fz39r
	 D1ShmdzSC5GPQF4Bbj3ZpewewgRBayH7JbdxTSa6FcuD23yKpRblFjd98ObimM5V7/
	 hL/jAGAu16MZAPz8kLWWAfFUbIsj8injPq2aoIdZ8IJtl8DOtgWpMrXrKGUlxzZL2b
	 QRupaYLPDlqJDDR/x64HFjyqNUkFn9kWMWzcHKXdadL8I97eIt4dqX27UGLysC2Q7L
	 IWJQM6atB3sExmO0TzIYTzJ3EFCpzzeGO83/3CYlrG0dXUUiWKmUTXE872bAErIrtf
	 z0zCFRy2rDCKA==
Date: Thu, 27 Nov 2025 07:28:49 +0000
To: ath12k@lists.infradead.org
From: Alexander Minchev <adminchev@proton.me>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath12k: remove redundant pci_set_drvdata() call
Message-ID: <20251127072839.14167-1-adminchev@proton.me>
In-Reply-To: <20251126170213.27959-1-adminchev@proton.me>
References: <20251126170213.27959-1-adminchev@proton.me>
Feedback-ID: 99141252:user:proton
X-Pm-Message-ID: ad921ed66738655e0456f7097476e8ac5c3cfd24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

thank you for the prompt review, I appreciate it. The issues are
addressed in this v2. Please let me know if anything else needs to be
changed.

Thanks,
Alex


