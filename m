Return-Path: <linux-wireless+bounces-28332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB63C12ED6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 06:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA1733518E2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 05:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC12225413;
	Tue, 28 Oct 2025 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY1pT/Fa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B51FA859
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628782; cv=none; b=jutdJxGApR6YO0Mbajzde1aebL+b6Eo3VrQo0KdG6697SmeLJcM+ZxevddyVIbJ3yPrWs3sZy7VgHWV45y572QqeV1Vg0qVr0nZR4dC5CIUPW/Trlt3cYD0m4USFNPkvZwPunCrPuaCjmWyW1HrfPPiqgt2aEQ0bqFHItjhwPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628782; c=relaxed/simple;
	bh=vfJseT8v17GJU1NRM8ZRqBeY5S58QDmc7dUkRsxawhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iK6HDMn5TI3pB7yyj66kGvJBNRcoQL8FdmH7G7Cc+OrgOsflMLnQZdVPcQQQ2Lw32mRCwku5Aqu27ADlME0bZPPa2WUxbr1vpUFngyHJe/AjkAXR5msl6zEkFOqLypAZgt9BjHmpuNfqJ7P4BrJbsyQavzsy8j+xZPFBf1Psqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY1pT/Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A05C4CEE7;
	Tue, 28 Oct 2025 05:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761628781;
	bh=vfJseT8v17GJU1NRM8ZRqBeY5S58QDmc7dUkRsxawhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UY1pT/FadkkuOwgfiisGN/aCqnmCCvhlcrw65qlB0gURzolCFHMSWNFwGWNg9bguG
	 wAEu4lIMt9mUI8bvuPrB47JK6mHCK9Ll6y9WAhPB3m+sOD8TSYvP4rOv90wYn5X8kh
	 Rxy2JkntI8uJ3KhTzhfqxZLfoXmEJ5/z3p+d26vyNhahp35j/ziPV9en4IDRvOTSKh
	 G3QgKU+OKDyTM7B7AqFZS1Cyf6HkgVrt0ntNZoyfclKiTu4cQ4hmyJQxkBEMeZl2vQ
	 YHj74GC3PKK/QOAiXMdo3og4Bx46sSodr5DKadGcb0k9Bi9mg0pek5140LSKfzjmGz
	 euTeQ1/hMEmKQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 059C85FAC6;
	Tue, 28 Oct 2025 13:19:39 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Andrew Yong <me@ndoo.sg>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20251028021729.45098-1-me@ndoo.sg>
References: <20251028021729.45098-1-me@ndoo.sg>
Subject: Re: [PATCH] wireless-regdb: Update broken link in
 regulatory.bin(5) manpage
Message-Id: <176162877899.1002975.16761848894540098216.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 13:19:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 28 Oct 2025 10:17:29 +0800, Andrew Yong wrote:
> 


Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update broken link in regulatory.bin(5) manpage
      https://git.kernel.org/wens/wireless-regdb/c/a6e519535853

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


