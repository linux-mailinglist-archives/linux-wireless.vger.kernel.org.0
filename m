Return-Path: <linux-wireless+bounces-4956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC36880E43
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C96A1C21606
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661D63BB4D;
	Wed, 20 Mar 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idvHsaEO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4193F3BB20
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925551; cv=none; b=KD4F1/yGuxbATxTokpBwdPsA/dN3Xf0MCsQ/4mNtae6JahYWoCYB/ts8xBj0+nCOg2/BPpT3J/MOV5eJ8/KYmS7QDYwcUnQrz13EBbxA0n2iZVAD/Ua5qzdGAOwBo7tGZ6v38Wqw5Sa3MszuyX2aZZCqzl5lJcKby5yumANPudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925551; c=relaxed/simple;
	bh=wY1gm/C4HiO9kg1BKEmsZwix9S1U23gUj/5m7gkjsXs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=AQ67i+5++NxJRtCrUQqkUwbZOi5UP1/+XOcEWBQ8JLkCZPUd9VjWhVxTJ/+XDbDwVj602ZNm+carVxIXSXpQrR8zCKMp3K4tz66awOfCt/gRNgY0EKlE+RtIbs9HaMHJm/VxMzPe8XhKbZWTRohFKV/litwcw7SgIbYgGXgxxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idvHsaEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3F0C433F1;
	Wed, 20 Mar 2024 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710925550;
	bh=wY1gm/C4HiO9kg1BKEmsZwix9S1U23gUj/5m7gkjsXs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=idvHsaEOzzdy7PtzDOYyrAYrq8DQ8Z1kzRiyc5VSkc+gAQj8jtxU6RwxwjJ4j2hV1
	 WpjmWySD4VPKpm560mBKIzfBBPaeH5GoI5ir3a1L4upHsM8UAcPhhhxs9IEY9kKaNH
	 OqvBupU9edO558NFu3Zx2H5NrcmWj4Mbzkfuo6Znp57bkGiJdogY/LvE0LFGOaMvE8
	 SFd9lzWCqOphkRGZQnhd3kB+WP//00G/alWfmwK2U4BbTG8yHRAkSzprGRLzC+DKah
	 YS0CliIwOXZWcRX0QKInnbHicuJHbK1eMABeYQpUMqmLNizR4ziJtD3gJvZ50sqGeZ
	 VF3jYAZzwrAQg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] MAINTAINERS: wifi: add git tree for Realtek WiFi
 drivers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240319011925.6855-1-pkshih@realtek.com>
References: <20240319011925.6855-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171092554834.2940748.6227258748855357371.kvalo@kernel.org>
Date: Wed, 20 Mar 2024 09:05:50 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Add git tree to manage all Realtek WiFi drivers except RTL8180 which is
> old and orphan.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

10b890ee21a5 MAINTAINERS: wifi: add git tree for Realtek WiFi drivers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240319011925.6855-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


