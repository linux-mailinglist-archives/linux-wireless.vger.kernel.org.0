Return-Path: <linux-wireless+bounces-703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA680F121
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0821C2087D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25575424;
	Tue, 12 Dec 2023 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDV+WqqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E1745E7
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 15:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6170EC433C7;
	Tue, 12 Dec 2023 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702395296;
	bh=Ti5TJsZx7dm3iX20ybxRIThKjHbWp8O0xyOh1hZro7w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=aDV+WqqN0zbJkd1YtJQWITVzTd7tpcw4zeSxSk7KAMuu+cjWyxpaLb/hsdK3S2a8E
	 Qt9Olz7o4KsaF/nz6Nl3+yiT66AUhjZsrCzfgjuj2VgY/bkcIe6ApPB9yqiLC3F6mJ
	 52xOaWBqoVYohk0BJ8pya/gn15V1FfUuC3v6IWK/JmHVISAjQcT0lp0yDTUO0Z+X5a
	 Me0QNPPhm6fpoq4ROhzkWl7sRHy2Wjr2Zxr4fH6f1pJh/MYTa7qAgR3R1EgTETRL/t
	 FpQlcV2JMmz7+vjOgRVZOMU61Vbb/tfc0UsnhuE4tLZsJSCXnV9uiIWSNVS7OLuRS7
	 kXil5ZIc+JPcw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: Use random MAC when efuse MAC invalid
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231208150739.129753-1-macroalpha82@gmail.com>
References: <20231208150739.129753-1-macroalpha82@gmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-wireless@vger.kernel.org, pkshih@realtek.com,
 Chris Morgan <macromorgan@hotmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239529317.306086.14094133972122975560.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 15:34:55 +0000 (UTC)

Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> When the MAC address read from the efuse data is invalid, warn the
> user and use a random MAC address instead.
> 
> On a device I am currently using (Anbernic RG-ARC) with a rtw8821cs
> the efuse appears to be incompletely/improperly programmed. The MAC
> address reads as ff:ff:ff:ff:ff:ff. When networkmanager attempts to
> initiate a connection (and I haven't hard-coded a MAC address or
> set it to random) it fails to establish a connection.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

0a999d82b782 wifi: rtw88: Use random MAC when efuse MAC invalid

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231208150739.129753-1-macroalpha82@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


