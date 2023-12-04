Return-Path: <linux-wireless+bounces-370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93763802D55
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD211F21110
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249C17F4;
	Mon,  4 Dec 2023 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg/7WLEZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8ED298;
	Mon,  4 Dec 2023 08:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5BEC433C7;
	Mon,  4 Dec 2023 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701679075;
	bh=ftmmbjUPFPYaMVVTsCh1SAKi4plLZBTdcQEkERtxlG4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Tg/7WLEZoOcMn2nDBFBn/UG3NI6uXNyiSPClpRfA1cBfPtSx2pDbdWD/H4k56mwoE
	 +QNupT1g1geF2oa+jqBmH44890zbr8wjRors3E3pX4A+bGdtIUR4qmCh0y81LPaSBy
	 +BIWDBqCTOHTsNmlUSXqYIFOOAwZJ6mVZwrWVTVNNtKb9/dg+eXmln9zoPb4txG4aW
	 o9JR6NOaTn2PWaU6xhPjs8Wx+XIXN3nAtWN4jHRUxOygjlDjfLyuQQbmjmQUOgbZJw
	 AnPgrYkuxx6xeeym9KAEhHXELSvGAUhEYG8zeLPUJu1RIZMTmh/20qaUmeHT+ggNBC
	 E3sI7GQMAL8eQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,  Felix Fietkau
 <nbd@nbd.name>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Ryder Lee
 <ryder.lee@mediatek.com>,  Shayne Chen <shayne.chen@mediatek.com>,  Sean
 Wang <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and
 fix -Warray-bounds warnings
References: <ZVaCNAohuieMmdq9@work> <202312021326.D3504C1@keescook>
Date: Mon, 04 Dec 2023 10:37:50 +0200
In-Reply-To: <202312021326.D3504C1@keescook> (Kees Cook's message of "Sat, 2
	Dec 2023 13:27:54 -0800")
Message-ID: <87zfyqqs69.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Thu, Nov 16, 2023 at 02:57:24PM -0600, Gustavo A. R. Silva wrote:
>
>> Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
>> flexible-array members in anonymous union in `struct
>> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
>> helper; and fix multiple -Warray-bounds warnings:
>> 
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning:
>> array subscript <unknown> is outside array bounds of 'struct
>> <anonymous>[0]' [-Warray-bounds=]
>> 
>> This results in no differences in binary output, helps with the ongoing
>> efforts to globally enable -Warray-bounds.
>> 
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> *thread ping*
>
> Can wireless folks please pick this patch up?

Ok, I assigned this to me on patchwork now. Felix, please let me know if
you prefer to take this to your tree instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

