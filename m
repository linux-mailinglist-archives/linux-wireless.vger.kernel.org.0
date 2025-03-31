Return-Path: <linux-wireless+bounces-20993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B64A75F04
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5892F188911A
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7717B418;
	Mon, 31 Mar 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JxbXTq/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F233FFD;
	Mon, 31 Mar 2025 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403844; cv=none; b=knizF28fJLk4LvMdu2oaqduNQ/9lU91NlIzhSgRWXwDlpN5NepbE9BLqoH+g6ARUN4LQsG2NrxncCNrE/j5G/HdHfq6ag5ZnVmZEWVF8O92/XbHm8NEZbvTk4uI1D7Xwlr/NUPGLZEc9Wbb2esuqj2UJLNf+9RdJqSPSV5+M12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403844; c=relaxed/simple;
	bh=a2bhOw9LufrjpJWPhs6wW6qBWYi7hoW0iouUqYM3Ti4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOXACRU4OMI/Xd1tXQ/jtbIoRzD5O81rK3CIuRBdh2x/n5B+/b0NUzpJ9rQ/4awPc6dqGnnO7iogyNTU+bp0zC2RmkWM8yaWHUuabNsbkRaI1wwnaRtxG97snFn4Z67EctzIDHfbpoTAxFDooy/CVmE8oqjAd6bNAnd0DNxAq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JxbXTq/e; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 50AA91F928;
	Mon, 31 Mar 2025 08:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1743403831;
	bh=syLrdCGImw/DTpeTx6IlSA6vfY4PduBhR9vKCELENX0=; h=From:To:Subject;
	b=JxbXTq/eLXGlUx5tYKuRj23TtJUzu3R3k3DO1vk8c1Ux781PcAkqBmKYgtApD92gN
	 la6cO1+1XGEiw7ONiMMqRslkMeCCHiJbHmMC0VmR4VHMFYgapXAEE0Dq9X7lP0MNtS
	 s7d8DhkyxNlGI1xfNlG4lt7UHceFPUs1P8VaAIHZ1V3yXRJa3HW4vMbIvZP17zjeto
	 yXrdZ0eFZA2Ju0qylCP6M2dJyYeXj+8RkFqf5WEXe+SrQPjIsRSr7jdK4uDOxk0S6Y
	 ZdgOtt9mVAqWjWWylUkJcPcuKmJ//4C7zPXEdthd3f6pYaX82tRC5lbLUJA97cM0/n
	 3oKEioKAWU4Vw==
Date: Mon, 31 Mar 2025 08:50:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>, Jeff Chen <jeff.chen_1@nxp.com>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 0/4] wifi: mwifiex: add iw61x support
Message-ID: <20250331065026.GA12444@francesco-nb>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>

+Pete/Jesse @NXP

On Wed, Mar 26, 2025 at 01:18:30PM +0100, Sascha Hauer wrote:
> This series adds iw61x support to the mwifiex driver. It works for me,
> but is not yet ready to be merged. Some people showed interest in it, so
> I am sending it here.
> 
> All testing and review feedback appreciated.
> 
> During startup I get these messages:
> 
> [   12.078010] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0xff
> [   12.078018] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0xff
> [   12.078024] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0x23e
> [   12.078029] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0x25c
> 
> Not sure what these are about, I can't see these handled in the
> downstream mwifiex driver as well. Could also be there is some parsing
> error. Nevertheless the driver seems to work.
> 
> The series applies to v6.14, but should apply to my mwifiex cleanup
> series as well.
> 
> Sascha
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sharing this, so maybe you can help on having a way forward for iw61x
chip supported with mainline Linux.

Francesco


