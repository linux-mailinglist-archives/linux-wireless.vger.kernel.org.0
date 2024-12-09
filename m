Return-Path: <linux-wireless+bounces-16038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C29E9471
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46334283E4F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87C224898;
	Mon,  9 Dec 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyqIyZCm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF921B1A7;
	Mon,  9 Dec 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747944; cv=none; b=syovHZPBrsd9KaIg4VAUU3J7QKF0WylMEDQ6ZzcFqE0y0ZUROjjbLWxuYIvUvAzCcltlDj0Vbj7avKdDVCsAQ/sr8gR+VQPQbsFdSgRIq33koCEoub5hSFp3WZyWn284JyL1MNCRJJRJRmRnGO/TgPhHeySyPRtxm/wSZHIIAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747944; c=relaxed/simple;
	bh=ngU9mgDLiPW+Jj5JFXStLmp9bwIcUT+Lp2fVYZwvnaE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l6GGJgRsImMGdTjcSEaCHbEs8dLrM3GzHvSawPoYNrg0XpdJ+hfedt9lt3axXxU4IwDWJyrJoRuqgovbi+XRnNu0a1r+Fj0MFLTnAxHe2ft4OpxPDZm6r0hUk/+CcbJZJ4c7PZBg/ytvR2Sl0oIg7lYny4jMCN8aoZ8MRqvnH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyqIyZCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7AAC4CEE0;
	Mon,  9 Dec 2024 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747943;
	bh=ngU9mgDLiPW+Jj5JFXStLmp9bwIcUT+Lp2fVYZwvnaE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QyqIyZCmuZb9Qxx5I66VshErpU7xl/PRW4CyjuqoL+eiEgwTzfR/4eqUtMy8PLoL4
	 53MKH5EtC8ymyhhCisLgTWXOVR2id9VJqx9SJKn6i94cdDXbQazx6NC4GYKpkLw5nM
	 /qETwoTZFO84D4QoUEozz/jBUmJXfAv9NsQxjRInCkwySFBSubt7pS8dAV1MrU7m/D
	 SYSLHhTlNRMYn0XZIsMOGQlfqH6YUv42gBhZk4/GVNYa0Z9LTp61ioMTbLvPQO0frS
	 rTXxa0TtcAcVxAF6q7IjYrBuKV2vN6FRlI/b8Ogewo21spA6+gx7UKz2yhva2boTCe
	 7SxQuS3O74zXg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
  ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: ath12k: Fix out-of-bounds read
References: <20241206073542.315095-1-dheeraj.linuxdev@gmail.com>
	<8c019176-6bb5-467c-bcea-10517675de7d@oss.qualcomm.com>
Date: Mon, 09 Dec 2024 14:39:00 +0200
In-Reply-To: <8c019176-6bb5-467c-bcea-10517675de7d@oss.qualcomm.com> (Jeff
	Johnson's message of "Fri, 6 Dec 2024 12:06:51 -0800")
Message-ID: <87v7vtrpy3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> On 12/5/2024 11:35 PM, Dheeraj Reddy Jonnalagadda wrote:
>
> The subject should be as specific as possible while still fitting on one line.
> Ideally the subject should be unique. So at a minimum I'd add "in
> ath12k_mac_vdev_create()"

Nitpicking but sometimes I add the function name in front ('wifi:
ath12k: ath12k_mac_foo(): fix bar'), that way no need to add the 'in'
word. But this is just cosmetics, either way is fine.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

