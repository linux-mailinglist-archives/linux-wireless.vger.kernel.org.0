Return-Path: <linux-wireless+bounces-11343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C3950189
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A9F1F247A5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01315189911;
	Tue, 13 Aug 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5UqDRIY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5117CA12;
	Tue, 13 Aug 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542546; cv=none; b=ef47nxhgN3aihZocSBBURE+bhcLrMTaVScHyv877BXhk22+GPTJlFOc/YlDruDS69zHQa8WyjBsOK/A4F4VxukbuKzzJ9uogLps8HMNHkv3GYb8UrW/n0ERzbdZ5/WGDeB3o8EWv9Tr7rByogv2EXC1ozQkwLFVHyfFcXihrf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542546; c=relaxed/simple;
	bh=8fDU1EJcJbp7TqLl3KPDcjnqpz0sGS18/Q/mFMtTAOI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CCv5ptXQmte3FxVtlq3C6kOFAxKFdNrH22IsAMAdnugVAsl+84lPeDjFVzTj9p2HW2G5ywO0f4jNIOVRXonDxMnAZc0he16sQPck5zJpia1CiFgycVz7P6t7dsf9+HUrpmOK/XMNbDyMvz4tnReUH/anItI+q9XilgfS/YxZDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5UqDRIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BC1C4AF0B;
	Tue, 13 Aug 2024 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542546;
	bh=8fDU1EJcJbp7TqLl3KPDcjnqpz0sGS18/Q/mFMtTAOI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=J5UqDRIYrSqnZnnN51vSOy1K9u/n9mEdhrmO4KIzmIKSQYhBIjDtjkcX06m1AcDGL
	 nsK/1eIBokVtGFJTdDCwsOPRh9pv/OK5zzkvP4BF7sPmkus4QCF9Fyz3tbsR1W3iiF
	 3lejAbrrCvV6Q3VVWjXhMEEqwSzjXnsyYt7jB8ZFIjYwWR3AY0u7paJXMKK/Q7OxEp
	 P5BdBV2rGxgO91IS2bGQnyXY/c2f4RzWGCScSWSbhgD8tPER40g5jiYCWqytnn0tGK
	 vDljK26Qn3GjaS1SVcvhILYPW5Ajy/jzVqzdCb51u0H0SKjVBvFADwiePkc60EYrFT
	 uZrDBTNDQzNSA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: mt7921: fix NULL pointer access in
 mt7921_ipv6_addr_change
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240812104542.80760-1-spasswolf@web.de>
References: <20240812104542.80760-1-spasswolf@web.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-wireless@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>,
 deren.wu@mediatek.com, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi@redhat.com, mingyen.hsieh@mediatek.com,
 sean.wang@mediatek.com, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172354254201.696913.4098326996173451607.kvalo@kernel.org>
Date: Tue, 13 Aug 2024 09:49:03 +0000 (UTC)

Bert Karwatzki <spasswolf@web.de> wrote:

> When disabling wifi mt7921_ipv6_addr_change() is called as a notifier.
> At this point mvif->phy is already NULL so we cannot use it here.
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

479ffee68d59 wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240812104542.80760-1-spasswolf@web.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


