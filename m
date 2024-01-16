Return-Path: <linux-wireless+bounces-1971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C9B82ED7A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 12:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF029B22402
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122091B7EE;
	Tue, 16 Jan 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1HE9u6V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E851B7ED
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 11:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4022EC433F1;
	Tue, 16 Jan 2024 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705403625;
	bh=VoijYp0lA5zTV9HDl30Wh89EmUL4NjoKm99UcObnURA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=q1HE9u6Vm7giGMxlwJadppdFdqZzWKVB1HTJXv8tbcuczo9c0RwpjlfbRfuMxe02u
	 tc0hh/1Fhl7mf/vHj7E7/5PjGs9MFqa/hfNe5sZ9MBsyf/aFDNPY0v3/9X4lwTEYoQ
	 4YFVKrJ286kNvNzEqVUnBuwCvVthRt9vxG3C2S4/CZWnBcPqlXa+/4kcqRk5R5uryL
	 g2XLShHYElheZzpJ7QZhDDZOnoz2SFd/0WSreMEF85X5MfxQJcGgak/oIufRdIa1Ex
	 3ESOucSSiLsU6jmOO3tzPxcmkrWB8wUvoXXGW4ZNTJ43H9JvgUIx67bK6bxV+Lg4rs
	 uQ9CF89N1Lnxg==
From: Kalle Valo <kvalo@kernel.org>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: linux-wireless@vger.kernel.org,  Jes Sorensen <Jes.Sorensen@gmail.com>,
  Ping-Ke Shih <pkshih@realtek.com>,  Bitterblue Smith
 <rtl8821cerfe2@gmail.com>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH] wifi: rtl8xxxu: add missing number of sec cam entries
 for all variants
References: <20240116095001.399500-1-martin.kaistra@linutronix.de>
Date: Tue, 16 Jan 2024 13:13:42 +0200
In-Reply-To: <20240116095001.399500-1-martin.kaistra@linutronix.de> (Martin
	Kaistra's message of "Tue, 16 Jan 2024 10:50:01 +0100")
Message-ID: <87y1cpfs49.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin Kaistra <martin.kaistra@linutronix.de> writes:

> Commit b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP
> mode") introduced max_sec_cam_num as a member of rtl8xxxu_fileops.
> It was missed to set this number for all variants except 8188f, which
> caused rtl8xxxu_get_free_sec_cam() to always return 0.
>
> Fix it by adding the numbers for all variants. The values are taken from
> the vendor drivers and rtlwifi.

Does this fix a user visible regression? It would be good to add that to
the commit message. I can do it, just let me know what to add.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

