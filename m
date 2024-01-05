Return-Path: <linux-wireless+bounces-1523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC0B825266
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E701F2378A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A11528DDD;
	Fri,  5 Jan 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fDSkjsAl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A681288B6
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aHrqIVOtlCst+VZclgFwaJyl+OwinVcSYJTDBNm4otE=;
	t=1704451832; x=1705661432; b=fDSkjsAlPR497yU/A1t5sqn4WG+p6NcwoXF4Q8CRSrQ/yi9
	MA8Lc8OpNdO4NYpnQVYtS9jDZZigUwItbZ/NfCzrjSCD8HsDzKvtMVRQX8NkONXwxjcPAj4jSfVch
	dZuhedr5on+Xg0djhxxsKjWdsk8XAvR7nNyp9LA6UTW9dRgGw2D9d1Yp73v7Aw6hNPAPG8Kgq0xUP
	6daB+hTAm9M9scMzdYHfVWnLUUAEAIOpkdtUNU1dHmiVMZSimehBMz4K9dit6U1jZoDRrNzIFoLmf
	UUmNZppiqCbLhvJC0alJurWmhEZ0X06FqsU51q9a/Er+z5YtTkkAhNhjiQzKMHpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rLhmO-000000060RA-015J;
	Fri, 05 Jan 2024 11:50:20 +0100
Message-ID: <d30c85fe901d7073b4349221493176f1b1f03f21.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
From: Johannes Berg <johannes@sipsolutions.net>
To: lilinmao <lilinmao@kylinos.cn>, linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com, kvalo@kernel.org
Date: Fri, 05 Jan 2024 11:50:18 +0100
In-Reply-To: <20240105104542.463834-1-lilinmao@kylinos.cn>
References: <20240105104542.463834-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-05 at 18:45 +0800, lilinmao wrote:
> cppcheck reports

[snip]

Look ... you really should write up an explanation of what the patch is
doing, whether the tool is correct or not, etc.

Please don't blindly paste some checker messages and make random changes
to the code to suppress them. We get too many such patches. Convince us
with a useful commit message that you've actually thought about it.

> Fixes: f2abe804e823 ("wifi: rtw89: 8852b: rfk: add IQK")

Really not much point in that, since it clearly doesn't actually _fix_
anything.


johannes

