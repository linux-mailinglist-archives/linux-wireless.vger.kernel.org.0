Return-Path: <linux-wireless+bounces-2096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72583074B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8EB1F253E3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE219200CB;
	Wed, 17 Jan 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRM0Mq1z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFF200A4
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499146; cv=none; b=b5DLGA4Wddr6J0kt7r8qYaMgsoH0+O2oB2FHZFcaqR7fE+gL8rSlFnKwFfbG3ELhE3hjdRdaYzdmMpuaDWtAtqk98rPiJvq+pLcGNQiEFashDvPWY18lWY5kjr4QfKEXhLmNW3JAqrJHDcOcZ1PL0GO55ZplFXJxtnBy/EAh3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499146; c=relaxed/simple;
	bh=Wea10r8QPdbUDSZNfU+aEEm35fedoPB+u5pgJIvgJFo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=jTupZCsuW70XvHXxCZiIR+ddf6XRS/5NP/WX2psHKY5e72Lk1GiiT4eP/zTdi1rIAYLZ66wUxcDF9Ls09tctX236TwPM0tFdo3oTDbsojWpdTzfPJMxpRDT+KrevFmqtFzbz7Zz0MQmptHeF7j4DfQSNQaoWjyGVIQLbMFy2j+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRM0Mq1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5109BC433C7;
	Wed, 17 Jan 2024 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705499146;
	bh=Wea10r8QPdbUDSZNfU+aEEm35fedoPB+u5pgJIvgJFo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XRM0Mq1zS2Z3HvmPAFJ2mi986a0gw5m1AcdSZ0bovGwc5LCR6d+EP5rTkAmu+HXcF
	 IbRmbF+relAX6NYNdh+SAelDfgDxQ+2RDnMFyCB83Z9+lrsnmxGommliuVpUn+zz9g
	 w7dZzf17AqjAx/G4Db4kKpw6E1pSI5qUE3QUQ+8ANoQhVRpVdJmbo7Fj/C18o6LHu6
	 AsvnC6vpsh35bQcRm0mo9mEU4m73dQKuEGlDc0p/sfJOv86M44wr5kwaHY6zooxA1f
	 tTqvkKnsXq3yuQO+ZALIiJzGOUwjIU/topOJzPAUMuWXXE6EVcrBkzBywVpttp6i/z
	 qBhI8BILGe/UQ==
From: Kalle Valo <kvalo@kernel.org>
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/3] wifi: ath12k: Remove unsupported and unused ring
 configurations
References: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
Date: Wed, 17 Jan 2024 15:45:43 +0200
In-Reply-To: <20231122063932.10321-1-quic_tamizhr@quicinc.com> (Tamizh Chelvam
	Raja's message of "Wed, 22 Nov 2023 12:09:29 +0530")
Message-ID: <878r4o5b08.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> writes:

> Currently in driver doing memory allocation for tx_monitor, tcl_cmd_ring
> and tcl_status ring. Here driver support for tx_monitor mode is not
> there and memory for tcl_cmd and tcl_status rings are allocated by
> firmware and it uses that memory instead of host allocated. So avoid
> these unused ring setup configuration.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Tamizh Chelvam Raja (3):
>   wifi: ath12k: fix calling correct function for rx monitor mode
>   wifi: ath12k: Remove unsupported tx monitor handling
>   wifi: ath12k: Remove unused tcl_*_ring configuration

I had several conflict, please double check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cfb7ae2dc5d32206d6978625bac055e1f431f450
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=d9e193e606e87fc4da445c1aed12113d2ae72151
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=23c88b95ce6a67eb422ab858e22c90312028b69d

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

