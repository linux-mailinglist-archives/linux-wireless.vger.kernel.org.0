Return-Path: <linux-wireless+bounces-15180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8D9C3E04
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018351C217DF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9CF19C542;
	Mon, 11 Nov 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neuE27/g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3A19B3C5;
	Mon, 11 Nov 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327028; cv=none; b=C+2OUfjtkYIGd9/MAoh/10rQnsxsPFp1gw1ahTdHkL004Kyt9p1nSMUW5LDZP26oNzsYOTWvskahcNPppuQ2NZUIvXMP/yrw/h/TCsxqciu3/erPd77gYtjGiQTlAwHvt+ENuaVqUIUEQ3a0O10r3uwQo9JUvWs89UVTeHXmUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327028; c=relaxed/simple;
	bh=NxUonbf/yZQ6lSFnqBgP34+RJ/MfGerPnNwWR7z0QyM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=O1tKG9T3R/ERz5lzxnDFZzp59In3DlfxeeJRab6vAIK65OzwnYIyYJNZVwXPOewfxO8WhMj0qbQPM0ZuRZilsLjw4LpSn3t2bjZC7RcXq3Ca0QVDcDwWip0tp9fx8yhZJQtjAyocvPqhtcLU8p0LEiHorpjqth3P9IGKhTuBkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neuE27/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C0FC4CECF;
	Mon, 11 Nov 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327027;
	bh=NxUonbf/yZQ6lSFnqBgP34+RJ/MfGerPnNwWR7z0QyM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=neuE27/geh2fprRnC8qfyd+94VuHMS653hNgijMIWNKMhYMyJrTAvpQFqj2ifAwqX
	 2fIAN1CMQX7r+L99MIYWc/S820uJOeHXZQfnwg2JdpqGZTqE7tBpWL9TxntVKxSzAp
	 B353PS0zgcsleFmRWo2IB08ljYm4FnSQHspFYlxbBNM0M0xrmOMkF0xkl9h+B+zvvf
	 YS7+wZrVRKF/5faOssub5puML/xyYyXGgzwhI7qTLtkoLZ/bW0hRY+8h/NyPZkIvyA
	 JABwqMr695iT3dWW18BSWjIhNHs2dj16RMjwVWby5gWm1vxFx/t6q1BpK8W7Y7G3FW
	 uvkwCETxfiMeg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3,-next] wifi: ipw2x00: libipw_rx_any(): fix bad alignment
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241101060725.54640-1-jiapeng.chong@linux.alibaba.com>
References: <20241101060725.54640-1-jiapeng.chong@linux.alibaba.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: stas.yakovlev@gmail.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173132702482.852485.17581404028883241473.kvalo@kernel.org>
Date: Mon, 11 Nov 2024 12:10:26 +0000 (UTC)

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> This patch fixes incorrect code alignment.
> 
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned with following code on line 882.
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned with following code on line 900.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Patch applied to wireless-next.git, thanks.

4fa4f049dc0d wifi: ipw2x00: libipw_rx_any(): fix bad alignment

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241101060725.54640-1-jiapeng.chong@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


