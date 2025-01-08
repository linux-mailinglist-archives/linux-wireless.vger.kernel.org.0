Return-Path: <linux-wireless+bounces-17195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE2A05F67
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 15:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEFE7A2AB1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE047148FED;
	Wed,  8 Jan 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glxHO3gI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8652139CF2
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348193; cv=none; b=GubD/9V5oITSMyxWu/7LrLtX33DnjVKkIOW8w+un3XUgZjQeRiuib/gTNqVKlji6iw/tW191rxVstpGC3bT6Otycw6MHpyjCoQvAiQW+JdIMKXFp8ljmiZqg5/HWUm94C/QqQzuLjGHSglLjlbxqfszOQJbuVAiyqs7kp9yl/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348193; c=relaxed/simple;
	bh=VuT6xgyRWwGa0QRorg/GjyRyPZzOxjWoF4dNXx+WQCw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b03aGmc93j4u5jW0d8Ie1zllj/4BS+VZzpfzyKLw7efQl33HCTYbPxMvmhIXHMM1oeKXq4ABaSSXm4kdy5WJMQJk4uZ6fY8fxXokxmER1UT4mbsHQjnOeHiOPvMakeso9BKtkRGTQOMX75KSFykbw0Ym4YwI5r5b33krA51RkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glxHO3gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20582C4CED3;
	Wed,  8 Jan 2025 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348193;
	bh=VuT6xgyRWwGa0QRorg/GjyRyPZzOxjWoF4dNXx+WQCw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=glxHO3gIAxf8UtSHSrhYrta/gtBmFEbv//rEN2BUTymHHqMYaDcnpzfCKB1sA9iv/
	 5Ld/SidYnCmAH4D6TNkZkPo5LzDH/tmWXfA/y0b1UR/mYBysdlW4Dei/HGy+UAURKs
	 Q9LdC46yRzwZEJ9bUhslc07WTOHt1kMz1YBPiDPoxkwLYMe3iBWbzUiq/ll9yv1nAi
	 pO4oPlTvUHfUqzWvV05PCII4R1xeeV+g1lfpK5vEhg6tUw85rJJrZ0xBbmKLqbgZOQ
	 2Ol8Hxrnk1fGGHLzx0yPuAfhvov2ZkuCXNzhAw9bGecscdsMSKKi4ndh2dbzWdisT7
	 uPqsYjUaqtwrQ==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Anjaneyulu
 <pagadala.yesu.anjaneyulu@intel.com>,  Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [PATCH 14/15] wifi: iwlwifi: mvm: add UHB canada support in
 TAS_CONFIG cmd
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
	<20241226174257.0b1d92ad59b8.Ib80f8514a64fc2800a2a20131e730c2bd9c4c4af@changeid>
Date: Wed, 08 Jan 2025 16:56:30 +0200
In-Reply-To: <20241226174257.0b1d92ad59b8.Ib80f8514a64fc2800a2a20131e730c2bd9c4c4af@changeid>
	(Miri Korenblit's message of "Thu, 26 Dec 2024 17:44:55 +0200")
Message-ID: <874j29qrq9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>
> extend TAS table support to revision 2 for getting UHB canada
> enablement from BIOS and send to firmware via TAS_CONFIG cmd
> based on firmware capability. While on it fixed kernel-doc for
> struct iwl_tas_config_cmd_v4.
>
> Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Is this name correct?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

