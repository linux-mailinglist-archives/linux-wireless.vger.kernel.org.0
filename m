Return-Path: <linux-wireless+bounces-4498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40D8768D8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494021F23815
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05921170F;
	Fri,  8 Mar 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtGYliVy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D51C2BC;
	Fri,  8 Mar 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916615; cv=none; b=ZI4n/z+9bA3Rx9d7NVcbiD70TQzjLka+hWAoxBLMT+Bz9Vprg6n0Uwk/9CHd1xqCkIP4EzHxky6EJ8cEjeGPvB4zIfvIFjYh41d8bAnZrQM6vFd94LpAJgA3RTPGB385MHVAuD27fmX/pFNOloOsKLoHuD9nANz6SCsNbfNbhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916615; c=relaxed/simple;
	bh=u1yrWTdW9WYXgeZsRqMM+zytlO4DtegoSUv3EEA3PG8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c+zw3efwzx/By8jLOk2WYmG1NKIPvyQaoA8T+SIkg5ikM4jLzzDcPeTACO9GQ0BZiXIWtxT94aAaV/qbuJYmb2r6AAiey1CYg4UQn/RPUNUE2M5ft5v89xAdUnYS4aMynnUKUvy3/WJjf/XEB7zSrYGodCIARsMdxFEYdy/YIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtGYliVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0139DC433F1;
	Fri,  8 Mar 2024 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709916615;
	bh=u1yrWTdW9WYXgeZsRqMM+zytlO4DtegoSUv3EEA3PG8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PtGYliVyw9t6Vti34iZJqIoKc9x8OBPVmNdbIGl7Aj1SKf2Jz6V/jB1grXv6g+oqZ
	 MJwL5ZQyEC/Z6S9FGVDMutz/oloCfCaHIDL1Hil1F262hrXnXlZgUSlRyIM41tG4M1
	 QvI2JO0AiO/Kl8IfLXNZB/hkpMmjPYjslPRvAF3sa81Tpimom9CqXElBfTQqNzr4Ka
	 rWXsUmGhpPospQxqhGPZgj2prphHf3ZUXJ9CWflZUfZr6/5r7qL5EPemQN8LzCw0Ik
	 NWginxFd4UKUzMi7xEaJHV81XbCRyWyBy9E2D5suBsH8G+AavlvZ4GITMXLS6lqTPZ
	 lSvaa4HXa98fw==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,  Ching-Te Ku
 <ku920601@realtek.com>,  Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: pull-request: wireless-next-2024-03-08
References: <20240308100429.B8EA2C433F1@smtp.kernel.org>
	<20240308074539.04512f66@kernel.org>
Date: Fri, 08 Mar 2024 18:50:11 +0200
In-Reply-To: <20240308074539.04512f66@kernel.org> (Jakub Kicinski's message of
	"Fri, 8 Mar 2024 07:45:39 -0800")
Message-ID: <87wmqc4qik.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri,  8 Mar 2024 10:04:29 +0000 (UTC) Kalle Valo wrote:
>> here's a pull request to net-next tree, more info below. Please let me know if
>> there are any problems.
>
> coccicheck flags:
>
> drivers/net/wireless/realtek/rtw89/rtw8922a.c:2235:2-4: WARNING: possible condition with no effect (if == else)

Thanks, but how did you find this? I'm asking just to understand your process, at
least the pull request shows all green:

https://patchwork.kernel.org/project/netdevbpf/patch/20240308100429.B8EA2C433F1@smtp.kernel.org/

We don't run coccicheck so it's not surprising there are new warnings.

> for a non-urgent follow up. Doesn't look like an obvious false positive.

Ping, could you fix this, please? In the patch please add Closes tag
pointing to Jakub's email and mark it for wireless tree (assuming the
merge window starts on Sunday, otherwise we take it to wireless-next).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

