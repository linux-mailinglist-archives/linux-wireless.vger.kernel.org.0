Return-Path: <linux-wireless+bounces-986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC09818469
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 10:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B125284E36
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C114265;
	Tue, 19 Dec 2023 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqlizl3/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887721401E
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 09:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C53C433C7;
	Tue, 19 Dec 2023 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702978129;
	bh=UlGVreEYe07dxABhbLM2JZklQIzzpf6y6MGrP8koCAg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Pqlizl3/Sp9F/tLFrXVIZQWTFPy8H48bukzoQ4VBKH5hL8dUjSAgub1RtAZVmyfhX
	 edd/ITe/vElzLum5aI5X3lWFs6sfmKGqCgiL4fCHAaAGwEgklW1OyvINJeXJLsjNOJ
	 tsKJmSb7jrxktM92298NVpq4cd8Yv9JdmFLzMTjk0gUME0hcNP7P8BNk2lov3Mnc26
	 I4d+nrrv4hUqASDN1tF2IdceCCLut0f4t0rI8C58YD4RClr00w04W8bBFN47vNQvZP
	 xxYoOD4s6s1YRXz8SkyuRg3Vv3ql8HyDEiORqy/Ytiu7Vtw1pwDA4X7aaxEpAzf/gm
	 3YAqlAQvkNNfw==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Mukesh
 Sisodiya <mukesh.sisodiya@intel.com>,  Gregory
 <gregory.greenman@intel.com>
Subject: Re: [PATCH 05/15] wifi: cfg80211: handle UHB AP and STA power type
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
	<20231220043149.1cb06b8555f3.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
Date: Tue, 19 Dec 2023 11:28:46 +0200
In-Reply-To: <20231220043149.1cb06b8555f3.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
	(Miri Korenblit's message of "Wed, 20 Dec 2023 04:37:53 +0200")
Message-ID: <87y1dq35ip.fsf@kernel.org>
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
> Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>

The Cc headers in this patchset has again the weird web.codeaurora.org
address:

Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>

I guess it's because there's ',' in Reviewed-by tag? The recommended
style for the name is:

Gregory Greenman <gregory.greenman@intel.com>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

