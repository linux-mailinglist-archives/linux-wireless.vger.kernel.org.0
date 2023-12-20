Return-Path: <linux-wireless+bounces-1091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71E581A0E0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3E71C20905
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DE3A26F;
	Wed, 20 Dec 2023 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyzdpx7x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3213A265
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 14:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1E9C433C8;
	Wed, 20 Dec 2023 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703081590;
	bh=kgv+BowmD17Qqr/b8e0XQU/b9FGHYXxzeySPON5PFZQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Nyzdpx7xah0c1YwsB+GKCPjyVysvqDVDKOgaHYfMQw1Aje3ESV6CXcKCU+i6j2S2w
	 48YVJM9KRHCF83lZVfEia6SLnj3SmWJbCQSh36af+qxwOwFLV6jnORYSnjdgoOALcZ
	 OhYrYbJ13DCbAF6H+fsj6xDHexf7wjxtiLOaUabZQ77ushxDitfTqXfzShZH0bTPOU
	 EtJXN56pj7vnG28EHdTpvmp6QKMLfXq+h125sgsCSANfmNHchf0fFIVnX6/17gavWZ
	 rfzTXzuDXfOAyvFlCk/hwxX477Vi7DaVbWd8kzY3h5A0i1AGa4jZGDXzaOs7SglYwg
	 fQHF3iyKiiPnQ==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Andrei
 Otcheretianski <andrei.otcheretianski@intel.com>,  Gregory Greenman
 <gregory.greenman@intel.com>
Subject: Re: [PATCH v2 01/13] wifi: cfg80211: reg: Support P2P operation on
 DFS channels
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
Date: Wed, 20 Dec 2023 16:13:07 +0200
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	(Miri Korenblit's message of "Wed, 20 Dec 2023 13:41:34 +0200")
Message-ID: <878r5p2c98.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
>
> FCC-594280 D01 Section B.3 allows peer-to-peer and ad hoc devices to
> operate on DFS channels while they operate under the control of a
> concurrent DFS master. For example, it is possible to have a P2P GO on a
> DFS channel as long as BSS connection is active on the same channel.
> Allow such operation by adding additional regulatory flags to indicate
> DFS concurrent channels and capable devices. Add the required
> relaxations in DFS regulatory checks.
>
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
> v2: fix the wrong email addresses

Thanks, looks good.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

