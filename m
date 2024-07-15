Return-Path: <linux-wireless+bounces-10228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5597931623
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2234D1C21F1F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140F218E756;
	Mon, 15 Jul 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9RH77PG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13211741CF;
	Mon, 15 Jul 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051668; cv=none; b=jh049CGPckjJIOSLYik5+hF38ECFBSIi7q32mCegit7T5ie9u2/Sy920vfxcK6HsOMDJNHPfPRzG6uigleMaeysEPRVz8M5o6Rzl2e2loGJQIB1YWJ+wn8u78LoKjyX2SBxyIbrfQIBQ8sbL4B+hq9CTogo1XyTYLqGHf4p4Gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051668; c=relaxed/simple;
	bh=415wrRTitLWxP9fLYBiNFhpeTuL+LCKkhB/1YonXHQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCbUuqMdv/vXVfR8SxRtchhvFEBXPMUldYgMwKN+pcYPkRV5U6xwJmms/lKEmGePslRP2nZ0Qe7EUWwaC458NAkWIKl4Idgxn92YvQlVitbdg5GsdrHRXZe7D/Hpq4cpcFNps1BPBvmT+cFHXAW/rLtcMCOFqD5YIyhjI7QjOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9RH77PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED29C32782;
	Mon, 15 Jul 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721051667;
	bh=415wrRTitLWxP9fLYBiNFhpeTuL+LCKkhB/1YonXHQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r9RH77PG2p1/wSJaMTEWJhlDxwKmBYSbuDXgbQsLvua3sdDZwD1yHCKFQUaAd7TSh
	 I2ynLR1MFi4+8FgSMFnygtSyfGhGJOSD3r0NV8R5oS8LqTLkDvzkav1ofu7nlDxFhA
	 3h/WFWMQmt0GCKdHOWyPSP+GNt0jByu98u2dhI4Vb5CPjUYMmwUBLoRI3wc5eNUsCJ
	 9iONTOZMsZJJOq1TO2q50xvYPEZdyWmi5qkZWIpSebqjKTLS28NlVxrDe9Yh5b3G43
	 7uCyiF+XNo/eU+ZgVp5i8SuOVxUrZ+zGZEybo2jBd82aY1/74e9X+SLFW3E/IAPs/y
	 KXmNX9Js5v9GA==
Date: Mon, 15 Jul 2024 06:54:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: kvalo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, guanwentao@uniontech.com,
 sergio.it.consultant@gmail.com, nbd@nbd.name, lorenzo@kernel.org,
 shayne.chen@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com, chui-hao.chiu@mediatek.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [RESEND. PATCH] drivers/mediatek: Fix some mt7601u vendor could
 not connect
Message-ID: <20240715065426.73ba0869@kernel.org>
In-Reply-To: <A9442D62405552CE+20240715094714.1553336-1-wangyuli@uniontech.com>
References: <A9442D62405552CE+20240715094714.1553336-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 17:47:14 +0800 WangYuli wrote:
> Some mt7601 devices cannot establish a connection properly.
> This patch fixes the issue.
> We do not know why, but it just works.

Any chance we can gate this on the version of EEPROM or chip or
something else? It'd be good to avoid regressions on older devices.
Or possibly - could we issue the MCU command as a test and disable
the calibration if it fails?

