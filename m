Return-Path: <linux-wireless+bounces-2934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E84845512
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 11:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE5E1F2CC2E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794651586E6;
	Thu,  1 Feb 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN7fy7+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FC4DA06
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782735; cv=none; b=YVO3NUsXObuMdxrYpV+PesAFB0HnnK/Vbmq0d5CAnPiSxevK2H3kXrjeRfW77KsGqL42FWo1uCeCkPxaLAgqYuaB61H8taeK6GE221P/Jb7vzxedGsE+1jyha40JLyqtFwNyz32mMhjwPIDi8XFpZ+nBjZ1hTGSHsHzn8O0IC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782735; c=relaxed/simple;
	bh=cr199KWHHm861R09Jyz9uo9rQjQzSEFNC+fpIX8cjJY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=HvKGzSv5D1nmjpNx1x4lfOGle/xITMjV0fQXJci+ZSQiz+bqjbygk/tv+JGML2jS9Hdh3a3RuFF7ECy+zZu82TLo2br2OfgsBjWx4p1cFHBskgefJOd6GYkq44jtcMFgkNJLkQVQLmZ2/dISl6WhpbBmiuwGrSgfECPAUMLk7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN7fy7+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F31C433C7;
	Thu,  1 Feb 2024 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706782734;
	bh=cr199KWHHm861R09Jyz9uo9rQjQzSEFNC+fpIX8cjJY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jN7fy7+snDD5MD5O6VHTvRyrila5EC+IBGC7NN4GxVCMvmkC4FzCDdcLS+N1+Zjhg
	 ScbNFtOBDddoIlq6SShsGGTJg7h2rj3TchIp6AVaCLC3Rxt7qErbNIXIe/9LRXCa3Y
	 2L53ApPVJSs49OGOLWFLsFJsSGxycWnlSj7RpycjLmvUhGoI4QMNCUZy0RWDY8KO1G
	 DQjWOnVCXrvdBqWAJIcepWly/kWADPsxRHzhgj6+YPwH4wtWbFkshr3BoyO/ZDgSS0
	 K/d1jk+otK62FDMg4a7Yx+is48b9w87VJO9iHke0UeQYm6lOwCA83sbXhW8amXTsgs
	 XWKzVXHRdRUoA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: pci: update SER timer unit and timeout
 time
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240121071826.10159-2-pkshih@realtek.com>
References: <20240121071826.10159-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170678273221.2736043.17660868120645953030.kvalo@kernel.org>
Date: Thu,  1 Feb 2024 10:18:53 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Be higher resolution of SER timer unit from 32ms to 16ms to detect
> abnormal situation more accurately, and set hardware watchdog timer to 4ms.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

57b9426952c4 wifi: rtw89: pci: update SER timer unit and timeout time
26cdaee43dc5 wifi: rtw89: pci: interrupt v2 refine IMR for SER
0bc7d1d4e63c wifi: rtw89: pci: validate RX tag for RXQ and RPQ
c108b4a50dd7 wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240121071826.10159-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


