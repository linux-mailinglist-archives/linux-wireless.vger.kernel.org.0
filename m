Return-Path: <linux-wireless+bounces-699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29480EFB1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137C01F21533
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A50745FB;
	Tue, 12 Dec 2023 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EknqhJ48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075B75401;
	Tue, 12 Dec 2023 15:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0F8C433C7;
	Tue, 12 Dec 2023 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702393770;
	bh=Dd+Z9g8Wy9pE/XbicCpt6HzoSR2qPgHCFARthzdpVJ0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=EknqhJ48zdty/TvXxhQhjINVvNz70LWWe1nCJ0hC3o5SwQu1v3g9NkkLvmYnpntZq
	 kuTTu54aL6cCpME7W5w/OZ4ynNorUF6jL6GACwmTP7vGG3lxzUuSODN88EKpcuMyG6
	 ckCtYRAfESJXYsK/bFIqBYNYxbNTw7jTKFrYNcldjNFSUgvs60t6cvLzWuJpxNKFcF
	 TmOZimDPKkM32RGWMHrGXNg4kxDAIqdrfezpQ+EB3ydFBBOSqKxlnW2C2W+iqWXozO
	 ggAKjG6e/TFBzY/QppVqhjy99DQweo9FJbK8t44OMPq0gdvgBB57AecJ3WyUNR208b
	 OPwuiWsNz1M3w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and
 fix
 -Warray-bounds warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZVaCNAohuieMmdq9@work>
References: <ZVaCNAohuieMmdq9@work>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
        <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239376588.306086.11901816078975577906.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 15:09:27 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
> flexible-array members in anonymous union in `struct
> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
> helper; and fix multiple -Warray-bounds warnings:
> 
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output, helps with the ongoing
> efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Fails to apply, please rebase on top of wireless-next.

Recorded preimage for 'drivers/net/wireless/mediatek/mt76/mt7996/mcu.h'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings
Using index info to reconstruct a base tree...
M	drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
Patch failed at 0001 wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZVaCNAohuieMmdq9@work/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


