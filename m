Return-Path: <linux-wireless+bounces-18833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9AA32198
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D570B3A5E4C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B157D205E04;
	Wed, 12 Feb 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cucnSEtC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A1205AA6
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350668; cv=none; b=PuU6T7DLxlasLXjwuKj8wIAxTkDi/P1xZpPOMoiwQ3QC03Do1ffhrSdMQPaJR3ZoPm2NjPNkmU4p8B/ZShm85BO6MLzlOLlpbDRz3wRFNjg/p/rJX2IRfY9ol3cHFkBcU97WDzP4LjsErfHiK75OFocGN7TkA3gF3S+d38RCnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350668; c=relaxed/simple;
	bh=AVqaqDgKTBD9UCgA5nDwYKhma1UIFvgSO+jt9SHCNsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=omoFXj7DmM3JJRy0GNhOgl0sqRiOmMEQjABQKGWQiIDc4/tOUGVBE/NeAOoe/hUvj/i8X7e/VJJH7ekOkBwe06930ua9oUy4h8foDwt3dF+Crl7qcsfTTeVARsSMC/xp9zCn9zkSTbYWqgYZA9zWK98NAJvyFfdLnOBxFmwlCpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cucnSEtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF331C4CEDF;
	Wed, 12 Feb 2025 08:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739350668;
	bh=AVqaqDgKTBD9UCgA5nDwYKhma1UIFvgSO+jt9SHCNsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cucnSEtCrn4bQMRCOzy6PRgEl4x1MupJwdAHyG6G6y6u/+mNm3aX0bFbhYQj2QVDp
	 WHGqW80jR5JT0p4cB9eBaxgFZJ0K2mgN7llgZ2c0q0FZkgcal21HK4ae3dvaIpeSqY
	 OCHgBvaqW6Ssf9cS2OxQfu6u+wWS70/+nPv+BZMOaNe2xvF03HXF6TM0Uee18nnAEi
	 vqBtCJHzAjBlPkf8IL9ItDHXfwuHrgkxFl8ECUsBzXTUZMPSorUsEh1V7HxJPzSyRf
	 iyBvGbQ5D8CwuCzF1SIbG70gaRJZlRoRU60d1D84kfiC6grf3Wd0GiNY8mqm5NI0ds
	 Nk+SIEvD231VQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id EFA255FB64;
	Wed, 12 Feb 2025 16:57:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, 
 =?utf-8?q?Robert_J=C3=B6rdens?= <rj@quartiq.de>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20250125011210.56371-1-rj@quartiq.de>
References: <20250125011210.56371-1-rj@quartiq.de>
Subject: Re: [PATCH] wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band
 in ETSI/CEPT
Message-Id: <173935066497.2471378.13516689980592599167.b4-ty@kernel.org>
Date: Wed, 12 Feb 2025 16:57:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Sat, 25 Jan 2025 02:12:10 +0100, Robert Jördens wrote:
> This increases the allowed bandwidth from 160 to 320 MHz for the
> 5945-6425 MHz band to support 802.11be (Wi-Fi 7) EHT-320 for the
> ETSI/CEPT harmonized countries (EU + CH/LI/NO and TR).
> 
> Previously the bandwidth limit was set to 160 MHz to match 802.11ax
> (including the 6 GHz extension called Wi-Fi 6e). This limit is not
> supported by the current regulatory documents and should be relaxed to
> 320 MHz.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band in ETSI/CEPT
      https://git.kernel.org/wens/wireless-regdb/c/6c7cbccaee12

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


