Return-Path: <linux-wireless+bounces-3886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B610285EBE1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 23:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A1B28474A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9923A29E;
	Wed, 21 Feb 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4Yu5XvC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E5EC5;
	Wed, 21 Feb 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554933; cv=none; b=jz4zDla5gkjYTL2quddo75igWI/q9W1U4vYeJlBzHZ3b9KK9p6hx4heIL9MN0srTeHbtute+DbkOjqhjqywgbix0DzyJPFwnETAV/+fyxoWK1zbE7bLe3zSLreQNH9HfWDtRMiF1hj2ckhTegYmVp15RuVw9q+33TlZiFBmPBJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554933; c=relaxed/simple;
	bh=lwF/zM8vz//K4UDHcQ/Lk5osFHgsMn4c2R9/4qv2Glo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOwxHOrTvkVSgNUM0qeGffNDXzGqnmQ0wcIOq+8pY8Ksfzc8dL2mYHz8DeqI5P4DoWjmRObcoJ9o8nrqqVod1v8ZXuXGNaXi3U98qA0hW26I2VjNlpe6kqa32gM4YjKjbN2kIpIa90SRZ98QhwVml7M/eeY8jmR5NnlC3DXNjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4Yu5XvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71548C433F1;
	Wed, 21 Feb 2024 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708554932;
	bh=lwF/zM8vz//K4UDHcQ/Lk5osFHgsMn4c2R9/4qv2Glo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4Yu5XvCnZ5v4JcuZTh+UGqUlXGbW3/Qyc7Ffn6pkUHADQltC364k34egHHAKtt4h
	 FOQ0SuK4B9zhck9cvxSD981fa33Bd0Vyqq61fDsFnTyrI4Ir4QHV8j4ZZd3wRGH5hk
	 GRZbRAUSdW7ZtTpL3cqsFTUiCcB2JrzlPgmLH3XTOoL80tgwDiV2jM66aFNvi8Ncgt
	 ytvNMzAN5jF5+7Ypsn+KQJEY/u5NZuQBQpSarkZl8c2HEeCh40FibnV+khA4VpBqGT
	 LkUCevNXZxXtuofogIYjf1gWEN8rvvdjD0CNFXRMGPDYoPlZm9CZMEBd+LOKLGc3WL
	 XfD9KJd6dfryw==
Date: Wed, 21 Feb 2024 14:35:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-02-20
Message-ID: <20240221143531.56942c6e@kernel.org>
In-Reply-To: <20240220165842.917CDC433F1@smtp.kernel.org>
References: <20240220165842.917CDC433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 16:58:42 +0000 (UTC) Kalle Valo wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> The following changes since commit b7198383ef2debe748118996f627452281cf27d7:
> 
>   wifi: iwlwifi: mvm: fix a crash when we run out of stations (2024-02-08 14:55:39 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-02-20
> 
> for you to fetch changes up to dd66185c23f71af36397bebfc99ede608dca07b6:
> 
>   wifi: wilc1000: add missing read critical sections around vif list traversal (2024-02-19 18:21:36 +0200)
> 
> ----------------------------------------------------------------
> wireless-next patches for v6.9
> 
> The second "new features" pull request for v6.9.  Lots of iwlwifi and
> stack changes this time. And naturally smaller changes to other drivers.
> 
> We also twice merged wireless into wireless-next to avoid conflicts
> between the trees.
> 
> Major changes:
> 
> stack
> 
> * mac80211: negotiated TTLM request support
> 
> * SPP A-MSDU support
> 
> * mac80211: wider bandwidth OFDMA config support
> 
> iwlwifi
> 
> * kunit tests
> 
> * bump FW API to 89 for AX/BZ/SC devices
> 
> * enable SPP A-MSDUs
> 
> * support for new devices
> 
> ath12k
> 
> * refactoring in preparation for Multi-Link Operation (MLO) support
> 
> * 1024 Block Ack window size support
> 
> * provide firmware wmi logs via a trace event
> 
> ath11k
> 
> * 36 bit DMA mask support
> 
> * support 6 GHz station power modes: Low Power Indoor (LPI), Standard
>   Power) SP and Very Low Power (VLP)
> 
> rtl8xxxu
> 
> * TP-Link TL-WN823N V2 support

I'm getting these on a normal (i.e. non-W=1) clang build today:

../drivers/net/wireless/ath/ath12k/mac.c:8000:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
 8000 |         return ret;
      |                ^~~
../drivers/net/wireless/ath/ath12k/mac.c:7962:9: note: initialize the variable 'ret' to silence this warning
 7962 |         int ret, i, j;
      |                ^
      |                 = 0

