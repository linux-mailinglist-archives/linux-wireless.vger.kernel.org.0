Return-Path: <linux-wireless+bounces-736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F42811146
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72572281D40
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D928E32;
	Wed, 13 Dec 2023 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeA3xxHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ABB28E30
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F10FC433C7;
	Wed, 13 Dec 2023 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702471561;
	bh=UqFTwJlv/HHhsk51P3RSZ4bmpRtBPRMXihdAMtpeCNY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SeA3xxHO7yrmmfB2KFZrqVJEWt2vt4NxSiFoXQXR6fpT/rmmTxIodcu3eA/bmmYkR
	 upieDGK4Hq5XJ+BtmAbg2viqMRak5Ec9zsXAsryytWiR+p+srQKVfTcPlsbBQ++en/
	 lQUenyeRjbmAWIrgpFp6a03gLgdeKCOg2Cifx9wtrdwX9VQBaDgXNmJcAObY5f5Ipw
	 h/qJvDB97QydJfmyE7AeLgmTJNaeHmIbnhiixQaNANwe/1i5O0uFkb1ypomLhKaBgy
	 BVOCu0lU8Ls+r1/fzpUJue9muW8t1xhhzZKbWOTXpgLFqf9JH3bkSySN9eTKTrSCL2
	 fons/DqBkx3zA==
From: Kalle Valo <kvalo@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Felix Fietkau <nbd@nbd.name>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  "Ryder Lee" <ryder.lee@mediatek.com>,  Shayne Chen
 <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>,  Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Deren Wu
 <deren.wu@mediatek.com>,  Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
  Ben Greear <greearb@candelatech.com>,  "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>,  "open list:ARM/Mediatek SoC
 support" <linux-kernel@vger.kernel.org>,  "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>,  Sultan Alsawaf
 <sultan@kerneltoast.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
References: <20231212090852.162787-1-mario.limonciello@amd.com>
Date: Wed, 13 Dec 2023 14:45:55 +0200
In-Reply-To: <20231212090852.162787-1-mario.limonciello@amd.com> (Mario
	Limonciello's message of "Tue, 12 Dec 2023 03:08:51 -0600")
Message-ID: <874jgmnud8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <mario.limonciello@amd.com> writes:

> Several users have reported awful latency when powersaving is enabled
> with certain access point combinations.

What APs are these exactly? In the past 802.11 Power Save Mode was
challenging due to badly behaving APs. But nowadays with so many mobile
devices in the market I would assume that APs work a lot better. It
would be best to investigate the issues in detail and try to fix them in
mt76, assuming the bugs are in mt76 driver or firmware.

> It's also reported that the powersaving feature doesn't provide an
> ample enough savings to justify being enabled by default with these
> issues.

Any numbers or how was this concluded?

> Introduce a module parameter that would control the power saving
> behavior.  Set it to default as disabled. This mirrors what some other
> WLAN drivers like iwlwifi do.

We have already several ways to control 802.11 power save mode:

* NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')

* CONFIG_CFG80211_DEFAULT_PS (for kernel level default)

* WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the default setting)

Adding module parameters as a fourth method sounds confusing so not
really a fan of this. And the bar is quite high for adding new module
parameters anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

