Return-Path: <linux-wireless+bounces-9146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E55A90C93C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109F2281743
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B015DBD6;
	Tue, 18 Jun 2024 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF1Wh55w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FA13D62E;
	Tue, 18 Jun 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706156; cv=none; b=qo6DenYbR4U8NUJx2Pe/k/AfnSRO3R6gnVTeblS6b4vYYT6vc+RcbW1QneU9ujWpUe7oH9N5BzlvAL3v1UwWL2dsVynsWPF0yHr8V6GRN3JSJ5YiTmVJ6Wo3zqca+1NIHw9/y1FjBp+/xzw3c6Rz5ssPcvuW50giBFp7vJ1ohek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706156; c=relaxed/simple;
	bh=1Y1pwJVbRda7BdQq6TUf8QlWUANn6f1wQ4H0qx18oa0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Yx8bRudEL1rbxwV1kpQ64B85NFePKleaPofqoUpl2beh/BZb3EobpKLxgx8/kN9VeLPUc9ybBNjIWI177besRVwc69N/6QWdnMfsYErqpIP3qNG8zaOjm5fi/pBu60fhQaFVrN+eUt8bm5ZfQQ9y+FVcpZv6I5cbZnwyeM3r9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF1Wh55w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D74C3277B;
	Tue, 18 Jun 2024 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718706156;
	bh=1Y1pwJVbRda7BdQq6TUf8QlWUANn6f1wQ4H0qx18oa0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=hF1Wh55wlUAiMLO30Z93kbPKcuEzkzXOH2bbat3iImmZGKhc8Q7p3bT4xjDUm0c12
	 Uk3Edt13+brNDk7hKSO4XbIYVf0V+7+5a8bPgrEU4edk8oXERFnxAnGTb9sO6eRIQa
	 Pev2dkPhKIRtj9256vmOtel0SpKBvAVj8hW4ckIta78iTFatX9Thw8Ifgti3K4EGZ0
	 4Ab74G4lGen2b4ARrRjQZp/rbSUEOFMDPQ4I290zRqCFPVgrSG7Cf4lD2uyB2f4L3L
	 PnWqx2x2ffmrGWQU4ZGaQhphAHIuLmaCryB4NLvPqSvdOy8Cf+E8FnR7pvwi0KWx6P
	 c87CfGINrel+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next 1/8] wifi: wlcore: correctness fix fwlog
 reading
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <E1sBsxi-00E8vQ-5r@rmk-PC.armlinux.org.uk>
References: <E1sBsxi-00E8vQ-5r@rmk-PC.armlinux.org.uk>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Johannes Berg <johannes.berg@intel.com>,
 Michael Nemanov <michael.nemanov@ti.com>, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171870615366.452784.11571930930740419280.kvalo@kernel.org>
Date: Tue, 18 Jun 2024 10:22:35 +0000 (UTC)

"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Fix the calculation of clear_offset, which may overflow the end of
> the buffer. However, this is harmless if it does because in that case
> it will be recalculated when we copy the chunk of messages at the
> start of the buffer.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

8 patches applied to wireless-next.git, thanks.

64ff013ce098 wifi: wlcore: correctness fix fwlog reading
b734d8830f70 wifi: wl18xx: make wl18xx_tx_immediate_complete() more efficient
97715e29cebc wifi: wlcore: improve code in wlcore_fw_status()
dd265a7415f8 wifi: wlcore: pass "status" to wlcore_hw_convert_fw_status()
81271c2bc59e wifi: wlcore: store AP encryption key type
bb8edd900fd6 wifi: wlcore: add pn16 support
9685262b5e5d wifi: wl18xx: add support for reading 8.9.1 fw status
8c58f972219e wifi: wl18xx: allow firmwares > 8.9.0.x.58

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/E1sBsxi-00E8vQ-5r@rmk-PC.armlinux.org.uk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


