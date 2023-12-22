Return-Path: <linux-wireless+bounces-1245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5B81C8AC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 12:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEAB1F22612
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE737156D3;
	Fri, 22 Dec 2023 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns+gf9Oz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECA156C6
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 11:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B7BC433C7;
	Fri, 22 Dec 2023 11:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703242910;
	bh=9/FdFWOB5iCNAUVyOtjoyl/7WTC3JR6KTO5cgeI4TcA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ns+gf9OzXkbhakTtvVtmrqoFGHY1/80RgzS+IjheF44MOAaKtCS7vmGAIB7T5x72O
	 C8mAkSuTrWBidUB5NStAxF8cs8awWb81DXA7uKPfSEfzotqyjClDnZawax/GiX3Kfw
	 +rNXnGG2LFFRV2tNEndXAXejGmKUewZWJpgrDfhN9jVYXZDtxpXY6X9JBdg6qwigi8
	 N0RJwkWhfQEFOdHCMvw0fwRmkZJZwh3zA2rHMeyN51ocovtK1Qwx4m+H5mO+yCg0Ue
	 eI6XBLHBbl+mjGenhL9seDNQT6bDlNORamAbzHN2OKHfk6BQWbub794c+lMeym2VNy
	 eJjHmixMxLTMA==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Mukesh
 Sisodiya <mukesh.sisodiya@intel.com>,  Gregory Greenman
 <gregory.greenman@intel.com>
Subject: Re: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power type
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	<20231220133549.cbfbef9170a9.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
Date: Fri, 22 Dec 2023 13:01:47 +0200
In-Reply-To: <20231220133549.cbfbef9170a9.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
	(Miri Korenblit's message of "Wed, 20 Dec 2023 13:41:38 +0200")
Message-ID: <87jzp61ox0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>
> UHB AP send supported power type(LPI, SP, VLP)
> in beacon and probe response IE and STA should
> connect to these AP only if their regulatory support
> the AP power type.
>
> Beacon/Probe response are reported to userspace
> with reason "STA regulatory not supporting to connect to AP
> based on transmitted power type" and it should
> not connect to AP.
>
> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

What's an UHB AP? Never heard of that before.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

