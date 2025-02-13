Return-Path: <linux-wireless+bounces-18911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E23A33B49
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 10:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ADE162E12
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556B20C469;
	Thu, 13 Feb 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKKxVzeM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57992063E1
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439213; cv=none; b=KLDJAagUGVNCj6nlWMUiqDUn5LqyxJqG6zo4e4F6I7fQsH4LJ5T6/8NacgvHFf0dkgGh1+Eh9a3DrIMMjzaB6QNq0+2IWlNjYQl9BA3VIoW9qaeSk3lt1IsAgMPEMdvhsUCdqd4XTRpiWZMcv8fbFkh35x8ZXkSPcKLO52hpKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439213; c=relaxed/simple;
	bh=lTlb+V8ErFDBNECiQ8dYQrHNPQVFcjjaKQK3OXzWBJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dBmrEuDvH8xRFr1L5qNeKbbO+ZOtCHs63tW7Uevu1lIJ8qxK7RhdZr+2Z0hUpFAH5VDDRVamciG2tG+3hSqdDxK2i0M0GE2E8Mus0mp3a4mMcuE3nSBLgf2NVd7MNi14xI2AO+nvDcUgrfwpJrF8Kp6ybpD7QLCp6L8mIIT2VBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKKxVzeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F912C4CEE2;
	Thu, 13 Feb 2025 09:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739439213;
	bh=lTlb+V8ErFDBNECiQ8dYQrHNPQVFcjjaKQK3OXzWBJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aKKxVzeMqCnJYPPDiL5fVGUs2VRQ0q/98Wmzx4WEu/hiFvDF2oqLANIv2xUlO3KJJ
	 /G2i/BkmPJ21TZoKaUKvTWihPul3b/knxVD7oX267jR4R+l8wbWtpFbZe4ZdT4N1kK
	 iNTgb4z6q6RoXm6m4OB8Lh4Wm1gx5X4exev0bzrd1+X+U7zYzt/pWvLBRvqu0ufN+O
	 nVhOLGL+N6bDYzx/tdD+sX/zJfhpkX3fF7vPlfQcZ29v8cTPzf7lrbbY9vuo+V1olD
	 Bug8E296+Dyw0UyuGw8KIEqlNYK4ndyPHEZ66Ztj52zlamXtxYm7Xw1FAFmTCMq+Wf
	 sHRnGvwKuluNg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 112105F9B4;
	Thu, 13 Feb 2025 17:33:30 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20250213011827.4528-1-pkshih@gmail.com>
References: <20250213011827.4528-1-pkshih@gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Cayman
 Islands (KY) for 2024
Message-Id: <173943921003.2910806.8495759400350357844.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 17:33:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 13 Feb 2025 09:18:27 +0800, Ping-Ke Shih wrote:
> Utility Regulation and Competition Office, Cayman Islands, released
> Operating Parameters for Wireless Data Transmission (including WiFi)
> Services On 18th November 2024 [1].
> 
> Both FCC and EU reference are permitted. Adopt FCC reference.
> 
> * 2400 - 2483.5 MHz
>   - Part 15.247
>     * 1 Watt
>       For systems using digital modulation in the 902 - 928 MHz,
>       2400-2483.5 MHz, and 5725 - 5850 MHz bands: 1 Watt.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Cayman Islands (KY) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/39b47ea61848

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


