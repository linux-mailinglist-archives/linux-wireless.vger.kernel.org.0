Return-Path: <linux-wireless+bounces-2090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04C7830494
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 12:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7241C20EA9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9B1DFC4;
	Wed, 17 Jan 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKe5wN71"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F31DFC3
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491249; cv=none; b=Ncz6TfOQ9lHnmNbvRx8vG/3B3QjJQK5rPxWZ1nuHiDBd1mmkdL+KOj+MkJlLlrzLapCHt5bGTQmuLpTTu2kOPDMG97JeT2n3IMnTLe2kQzDRGhOk+UewR55yQnoFAKhJTzl7vSrCwlWPyFHuxDXetW0mG9nMaEC+Swcczh6NaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491249; c=relaxed/simple;
	bh=pPKNBBEMNaE9AOSgKnLD5IFuAu+Lw4zwpaYb11q4AVA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=XLif6+rNdeeqPIIfuLae8wgCFRAjHol9hI0U+/0Hq0wlhvQLW/IOsrJFBbumsbpFPGgjrePtdAkCLji3nSwz/Cmz1au9r9tA6PnFsIEacvacuP94d5W+tQgdE0k57NiVPhOQUr3GSkmlIqaLeiDdc1bKqmGCe7Y24JSeXyEdVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKe5wN71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482F1C433F1;
	Wed, 17 Jan 2024 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705491249;
	bh=pPKNBBEMNaE9AOSgKnLD5IFuAu+Lw4zwpaYb11q4AVA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pKe5wN71vM4bB7WDKT0WaRco/mNR34Tqp/fHZmTNulsVlXkC+Tb53d1kEP7xxXMpi
	 BRx8UP6+Mdxp8PlU1b+AIjmwkZaq8L8Sv2Vx4flgabItKJfxA8IxOoCjYCJarPh/UU
	 j0KBFtvPWrO47wVvuCLimvAV5MQL7LEIWaIAAhemyG1iEta/nyKS1UHAJsst3ucIo+
	 4NVPvUkm7RjF5s8Tfc2z90vFgLoKxORMjkbps2IwYkvwnL61im9XqrsZalWy67TluV
	 2c5RdBwjWWCWxrI+2zbjyGyjqAX24GPdVjpb4RaX5lpfzWSSRQdNzeEsU4sTMosJQS
	 qcwygC9ofc9rA==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v7 0/4] wifi: ath12k: implement some functionalities
 through reading ACPI Table
References: <20231013114434.81648-1-quic_lingbok@quicinc.com>
Date: Wed, 17 Jan 2024 13:34:06 +0200
In-Reply-To: <20231013114434.81648-1-quic_lingbok@quicinc.com> (Lingbo Kong's
	message of "Fri, 13 Oct 2023 07:44:30 -0400")
Message-ID: <87ply05h3l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> Through reading ACPI table, implement Time-Average-SAR(TAS), BIOS SAR,
> configuration of CCA threshold and band edge channel power functionalities.

The coding style felt more like for a vendor driver style than upstream
driver so I made quite a lot of changes, too many to list. But for
example I did changes in naming, code compiled only if CONFIG_ACPI is
enabled and whitespace cleanup.

The updated patches are here:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=98dbc0c37b480117959221cafa6326e54667a53a
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c3d84c46ff4029fdfe15036be4f0a0d1839d31c6
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=04ec37eb823d9d9cba01531a938c53e8a142486f
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=fdd99edcb8ce2433fd243b5ae1b57668eab48ef0

I still have at least few things to do which I'll try to do soon:

o find a correct place to call register()&unregister()

o move wmi functions up in wmi.c

o consolidate wmi functions into two functions? (duplicated code)

I'll let you know once I'm done. As I don't have any device with these
ACPI settings I would need help with testing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

