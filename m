Return-Path: <linux-wireless+bounces-24520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A328CAE9758
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDB117C830
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25623816E;
	Thu, 26 Jun 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWYD1uo1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5A126C05
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924831; cv=none; b=r2DQOv4Q3JgbGzMIVkVPotaLpoEqezPzD8uLYKRuv9s1yba4lmktYf7F61YMx+TxV1wL9s2VvdZ+szHpQlxbxei3OrQ56ZFq49o24WhR9HIQ4zs8fK48ToKLbzXnX4NCDCKqXodN0cyls25bJrERf7HivslMQg2Ie7t9imhuaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924831; c=relaxed/simple;
	bh=eZYiZwV+ULC6PNy6CYgpJ0lzYwCKUKRBLvdUw1p9h0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b/CvDeekdh81KN9lDs+2Ogmzl70xyhr/cf4w1MpBeGSpHRijMvVWPdcAdSXV0AvqaFe0vlBQI6tgiDq+qxpu/rEYDKpWxlhRmrv4KHQDnJULs/bM42NG7fBo10zUeSv7CaIU4lnOPfUVzuw/KnUuyRvzfphNOMOTojV7KWksY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWYD1uo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1E0C4CEEB;
	Thu, 26 Jun 2025 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750924830;
	bh=eZYiZwV+ULC6PNy6CYgpJ0lzYwCKUKRBLvdUw1p9h0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VWYD1uo16zSKqcClNf7AiKtynFxMrECb4IOd4Hr1nJQw1JcExJPzQ9NmsOYJExE1X
	 1teLKZwTSZC3+jnmAJlO5XsCII+EE+HbOSfgmMdXMLjyarJj7tVlr93kwefYDs8p0c
	 m4iKYYkWJT120CAnM+19L2heSVhzPPvZPtSU/F86SqUXEH9a5IUyFYS/IMs6F4zsTM
	 /o1Ekwiuzc0hYCBN5TPdkVhyXNQ2y97t/PcG65z0/o6d3FMxjIpkurlNILtTfxN5r7
	 h2NCbEy4dZ46CtubismrcR5fSLe5KygQ90vSiS3F8+6Je5GbvDmX2yjH78ifryakZJ
	 1AOHcMO/6wlAA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 043595F752;
	Thu, 26 Jun 2025 16:00:27 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Emily <linux@emily.moe>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20250529144854.31931-1-linux@emily.moe>
References: <20250529135706.31269-1-linux@emily.moe>
 <20250529144854.31931-1-linux@emily.moe>
Subject: Re: [PATCH v2] wireless-regdb: Permit 320 MHz bandwidth in 6 GHz
 band for GB
Message-Id: <175092482797.2040065.7311768674091795449.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 16:00:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Thu, 29 May 2025 15:47:56 +0100, Emily wrote:
> Similarly to the changes in 6c7cbccaee121772a23fa0efdfefcdd8a2369985
> (“wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band in
> ETSI/CEPT”), the Ofcom regulations for the 5925–6425 MHz band [1]
> have no explicit limits on bandwidth:
> 
> > Maximum mean EIRP of 250mW for Low Power indoor and 25mW for Very
> > Low Power indoor and mobile outdoor.
> >
> > Maximum mean EIRP density of 12.6mW/MHz in any 1 MHz band.
> >
> > Techniques to access spectrum and mitigate interference that provide
> > at least equivalent performance to the techniques described in
> > designated standards specified in the Notices of publication (See
> > Section 6) for the 5150 – 5250 MHz band must be used.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band for GB
      https://git.kernel.org/wens/wireless-regdb/c/2e8214e2cac3

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


