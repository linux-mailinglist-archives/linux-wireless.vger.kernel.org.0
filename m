Return-Path: <linux-wireless+bounces-729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B381095B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 06:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22ECA1F2154C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 05:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB4EC15B;
	Wed, 13 Dec 2023 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNJd9Q0R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825406126
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 05:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7974AC433C8;
	Wed, 13 Dec 2023 05:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702444486;
	bh=+lc8vsyzbUwvdLGPktXPjaXuRO6GLwfiN6vkEZG1kds=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vNJd9Q0RFLeC0GaBDnIwJjbd24ifrf4aJQksRBnzeRk8Zm2xwHcc5ymknfERoj7Cr
	 4zBerVUWkb0YYQLBzEo/drtpyCfX+x3qFEfvygkdJV27E60UGWg2m3+ok9QrjXyGrA
	 U4+8LuenmUyZ3d0HwcPXtmCxdrFzOcRQNpI/acIgBBU+TrhQ8+pRhZ9KthCejHzTPW
	 squSgRVh8e3dwqdfDxFDOWwOUxIkzsRC2qyJvsulagY0KFqyzH6t1XAU0Ma6bIZ0YE
	 vMQDbuCH8LUhmlhtDePBcPKU6+DpmkK5NfGMBaJWFDcHl6VtccTzy6vzHTkYQtFeZ9
	 Fc3901lcJGCYA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/6] wifi: rtw89: fw: load TX power track tables from
 fw_element
References: <20231206124448.10537-2-pkshih@realtek.com>
	<170239437797.306086.16729667007676555795.kvalo@kernel.org>
	<1fa30c946dfa4e959f3f820388c520f0@realtek.com>
Date: Wed, 13 Dec 2023 07:14:43 +0200
In-Reply-To: <1fa30c946dfa4e959f3f820388c520f0@realtek.com> (Ping-Ke Shih's
	message of "Wed, 13 Dec 2023 01:00:26 +0000")
Message-ID: <87edfqof98.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Tuesday, December 12, 2023 11:20 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH 1/6] wifi: rtw89: fw: load TX power track tables from fw_element
>> 
>> Ping-Ke Shih <pkshih@realtek.com> wrote:
>> 
>> > The TX power track tables are used to define compensation power reflected
>> > to thermal value. Currently, we have 16 (2 * 4 * 2) tables made by
>> > combinations of
>> >   {negative/positive thermal value, 2GHz/2GHz-CCK/5GHz/6GHz, path A/B}
>> >
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> Failed to apply, don't know why.
>> 
>
> That is because another patchset changed drivers/net/wireless/realtek/rtw89/fw.h,
> but I am not aware of this when sending this patchset. I did rebase and
> sent v2 to correct this. Sorry for the inconvenience. 

No worries, conflicts are business as usual :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

