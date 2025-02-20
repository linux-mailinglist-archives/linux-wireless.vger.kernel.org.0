Return-Path: <linux-wireless+bounces-19182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C732EA3D358
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A846B17B8E7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8051EA7D3;
	Thu, 20 Feb 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3rfBvg7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D11E9B05
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040648; cv=none; b=lNvRsbQpT71A6a7Do+nlxPthFKKeJlz/Ye4CwQbrwicsOdCP6Qtu9IHAdcC8YmwXiZfO2gl0mJ2cc0xocudHkQzYLSdywdstG7WZEhivO9dzLJ6j9/RLTf3vJQj3WjuWOtkzXF/E4cqh2oLCbzn4RHyNA7C2ZTHQNeznHO6eN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040648; c=relaxed/simple;
	bh=N46RUkKWucBQla3gfPjBhwW/DIoaO7gi7LHlGpvhowI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rhJaheYCbSIEn+44lLku3AHCzc/8/cUwzBs+8I4H8L7oUHuNY2UOEqYWEtKulVaoJw5eM4SSMJQ5tBgD0aCFSW38esV8GpDqcqUW1frVjTfwbDSo28Pmd0PmFlbG0qm1iucQy+0KeTeiRliKBL0ct0/GzkBnDeA65yufAHLdg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3rfBvg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4FEC4CED1;
	Thu, 20 Feb 2025 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740040647;
	bh=N46RUkKWucBQla3gfPjBhwW/DIoaO7gi7LHlGpvhowI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q3rfBvg7nPDxfY4wThx2M87H2JOTo1Dzz5PknhkpYqQglzPNfEiIlwABVvzsRxMAV
	 7/YjQNuWQ3wS6RpVitbape3GbBCCyrP3VxYxHnnO1a/wKQvffdBp8DTdLvV/s4KDfJ
	 jQ4PU036qHpkxuhdCoiJAKAWOhhy+Q7YiTrjE4JKjvDF3fqyr4eQy0SUxftFr55wXy
	 hHezrl3MId4T1jN5EUH86lCVy9E9XDao2eNIZwysET+5AFDSMw+K6Dx8Oua7T4spWS
	 VXj1ZZx91xDXCeduRgqoKjJAzcg6N6XHJvdK10U4NDvqyk7/yi6hgGgGnB9tAFHGpe
	 8mFPWqRxEyLZQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id A0EF55F74F;
	Thu, 20 Feb 2025 16:37:24 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 johannes@sipsolutions.net, mobin@mobintestserver.ir
In-Reply-To: <20250220003103.4484-1-pkshih@gmail.com>
References: <20250220003103.4484-1-pkshih@gmail.com>
Subject: Re: [PATCH v4 1/3] wireless-regdb: allow NO-INDOOR flag in db.txt
Message-Id: <174004064463.1739122.8861233975147320518.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 16:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 08:31:01 +0800, Ping-Ke Shih wrote:
> For certain regulations, frequency range is outdoor only, which flag should
> be NO-INDOOR, but db2fw.py doesn't allow this flag.
> 
> As suggestion, only fill NO-INDOOR flag in db.txt, but ignore this rule
> in parsing to binary.
> 
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/3] wireless-regdb: allow NO-INDOOR flag in db.txt
      https://git.kernel.org/wens/wireless-regdb/c/9f7101175aec
[2/3] wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and 5Ghz for 2021
      https://git.kernel.org/wens/wireless-regdb/c/719593ae617f
[3/3] wireless-regdb: Update frequency range with NO-INDOOR for Oman (OM)
      https://git.kernel.org/wens/wireless-regdb/c/974ae194f8b1

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


