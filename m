Return-Path: <linux-wireless+bounces-3147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875584A1E9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603011C2329D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E247F59;
	Mon,  5 Feb 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/aHJBd2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364547F47
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156961; cv=none; b=gEY/fIoLrvE57Qw/rlhpbqmh765bQwb6304UzqQ05rktMuKbb1xqFXPrHmLWsTCh7K47woA+mbrF5/09TXU9Eshl4ONsNwF4zvWYserSMPlaOMjB/mFIVkAYsLMSwWAPP/R6pPTyiNhyXdeG06AbUaD8HKstP3A+vitMHY/igU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156961; c=relaxed/simple;
	bh=ZstH/pc0UVWv23nvloyYQcF4JlaLBDOuCYR49Fu933E=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=SlxiP5PdWC/IifLMvMNnZDMP/Bn/Y5AsDyl8NSbs8DvEutqbuFCcfk5OExKAgvbHWjXp6Ngg/wRHR9OJqyQP6PxpTwxoAdVlPuXVsDuwJ5KdbKw/Pj6DUX/Sa0eYSnlHYdWas9EFwx2J2f7bk4JICs6zxsXWhqxOPdO//bj30Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/aHJBd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01229C433C7;
	Mon,  5 Feb 2024 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707156960;
	bh=ZstH/pc0UVWv23nvloyYQcF4JlaLBDOuCYR49Fu933E=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=E/aHJBd2ZyBcgpFi/p/efsfL2Rm3mwswtPM2a8YW/g2yuPsmwNEpdV+VOcwRLVq5I
	 SMujxluc9pXYmtk04dI3L4LYRSrUKOdyqnZaYaCSbONzx2w5ccSp9cl3QZvx2V1HBF
	 Kwa1yeJeWQjjR7mnsvA7rIhtKrZOCd10CoymMqMT5dJq3zIQr4+lV+c63wH9TSYffH
	 arLJ/eN7WZur4X6MFJ59i6S5lJbbik1qW0C28FK41UhAIwhoE/I/kmO15m7wYV0jq5
	 K5UA1+9FRbpVQ0hgL+Iw7TTDbGH2pUX+J5M6c4JODyOKg5eicqZRC3ZWE4wtB9np4F
	 iBsxngH0xOzTg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtl8xxxu: Add TP-Link TL-WN823N V2
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240129053030.16369-1-cqca@cock.lu>
References: <20240129053030.16369-1-cqca@cock.lu>
To: Chun Qiu <cqca@cock.lu>
Cc: linux-wireless@vger.kernel.org, Jes Sorensen <Jes.Sorensen@redhat.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715695815.1586694.14794177610864215366.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 18:15:59 +0000 (UTC)

Chun Qiu <cqca@cock.lu> wrote:

> TP-Link TL-WN823N V2 (2357:0135) is based on rtl8192fu and has been
> tested to work with the rtl8xxxu driver.
> 
> Signed-off-by: Chun Qiu <cqca@cock.lu>

Patch applied to wireless-next.git, thanks.

1209f487d452 wifi: rtl8xxxu: Add TP-Link TL-WN823N V2

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240129053030.16369-1-cqca@cock.lu/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


