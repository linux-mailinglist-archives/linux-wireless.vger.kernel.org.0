Return-Path: <linux-wireless+bounces-2936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93755845521
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 11:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DA2838E7
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012F4D9F9;
	Thu,  1 Feb 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4hEaYBQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBD15B97E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782849; cv=none; b=sJsKzgJ476JRqfW215DL7HschDXK1BElWK/yTb6+DCDZRlDKriMwrZkSBZt8EfyIPSssQsuaXElvxvSPEFTDhcGH8XP71db7+zLQSaPZtivWqkMLy0Ue6Lt5+USU/7SQQYYyPDgLqlK+vbEW1Dk4nS9z8z7LzZlX6fHsaURfJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782849; c=relaxed/simple;
	bh=xxOF2c/N04i0qAo+M8Ix4mhlJ94c5+Bh23ikYisghgs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rc7MR52IrwUQkzfqGAvyqF0QKO2MhUuBX/12ONY/EnYwETV0P4nyp0b3dXu5UH8W7nbDpfKp3FIM8AIxYPsdgAhBPuWD87LJk7IHO5JMTUC/MtDI3QpI2tmZ930mpW6KNg42VBg76ED8T+h1Fv7GSP3dEuqZrGpLisB0FVoC8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4hEaYBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE0C433A6;
	Thu,  1 Feb 2024 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706782848;
	bh=xxOF2c/N04i0qAo+M8Ix4mhlJ94c5+Bh23ikYisghgs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=P4hEaYBQ1MBBi7CX7UazJfJGaxKpilbsPZwuZMpMbWYZhl6hEvMdsAyNmLh92nEyn
	 RALPwAarEUg00hENo5CYIJ35sLPliqEFJsv89CcqO+95DHCzyOrA48S98Fk/cnfchg
	 hRThjrF1J7H8PjqPwcj+fZCL3zy/xrgQD7r+EvWSJcf3mXMxE8+6YOlk3eVXdCTwqe
	 VQxow1wDJk9e6QQEWtSgXkyEC4aT1oIyhlnhiiwswYSccZPPhbdf/z4vj8icTEz4+a
	 rRaGordR8KGYhSRU/8XG3CLUAUXANfcH17GlrFyOgAx6M7pzDx1gqiHTO/M/IsC0UZ
	 HwINIggmIt6Pg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: update scan C2H messages for wifi 7 IC
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240126063356.17857-2-pkshih@realtek.com>
References: <20240126063356.17857-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <timlee@realtek.com>, <phhuang@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170678284565.2736043.7655177779775075011.kvalo@kernel.org>
Date: Thu,  1 Feb 2024 10:20:47 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Add definition and parsing for wifi 7 extended fields. These fields
> include hardware index which is current reporting, timestamp and self
> defined sequences for debug purposes.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

b5d7020134d9 wifi: rtw89: update scan C2H messages for wifi 7 IC
ac54faf507e5 wifi: rtw89: debug: add FW log component for scan
a412920b7019 wifi: rtw89: prepare scan leaf functions for wifi 7 ICs
4ba24331c973 wifi: rtw89: 8922a: add ieee80211_ops::hw_scan
e58e3117019c wifi: rtw89: add new H2C for PS mode in 802.11be chip
f651300cd884 wifi: rtw89: update ps_state register for chips with different generation
f1abee76dba8 wifi: rtw89: 8922a: add more fields to beacon H2C command to support multi-links

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240126063356.17857-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


