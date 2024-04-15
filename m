Return-Path: <linux-wireless+bounces-6338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D38A58F3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20BD1F20D3C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C582C6C;
	Mon, 15 Apr 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6imNyz5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1D82862
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201424; cv=none; b=R809Wz8eduWHMn5d9K5KgWZ8p5+nPC1LSbqsBSfcLp+6AgOeFYYFc38VohRXNxx9jjDLh/zyyYfNU9LfBHOmyid4Fq5APRy3NvYaqXEpZBq4R5k3xT6zmhrx2b1/w5cUCwda7AYJX6B5Lsu7b1O4HKrg+5M5gzDrvtI30qmet7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201424; c=relaxed/simple;
	bh=kn/5VO3WJcwA9ybjyGIpA4RIajnbI3g6G3Ka3UzJcjc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qQf5NK2/DuG5eQKPlAq0xR5HzcW+RGPyvOHYP1yzFhnu7Beqqdd1rOdjKO1gYkT8D1zNDTCzCJtJVSbyeWGSJcyjb2MMiO+RfcxLEKrePt7G5zjb5G3xfUv46Bp8Uh3100aWqiXFJHT5atSQRQ4TbgD2q01eO2nUc7dXXDtTx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6imNyz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C2AC113CC;
	Mon, 15 Apr 2024 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713201424;
	bh=kn/5VO3WJcwA9ybjyGIpA4RIajnbI3g6G3Ka3UzJcjc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=k6imNyz5beEoW6GKd8cohZoAi5T4JM0xB/lrGwXK2E7/5fr/TsiRpoxgm89c5fp7I
	 +1N4sal+bt7XAKzKDCoT1rTsLaIosn2xn5RyXAQpPgNuCkgkq8UfwOrLziK6a5QATY
	 DhGJWza6H4d/T3d7QZHvMmknfjq6LR2zs/tFYlDFuhuJ6zcn+vubVWfBPGG8NUNVy6
	 OMsvyLmZEDw/WTFY7QUIR/4qadvw3GPv8dDHSLYQ0MPcfMNBUcdXpmCwLKnXe7ZluX
	 puY295NsTGU1Y3OIg5DUsG1AoXRlfc5PfuZiwccN/K4PX66nC1A1R0Y3x7MD/tT4eb
	 bI/9mGKP5nXTQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
References: <20240411165645.4071238-1-kvalo@kernel.org>
	<e8618364-e547-41e1-b18f-4cddeafd3371@quicinc.com>
	<87h6g2y4jp.fsf@kernel.org>
	<c5080887-6d94-405d-a57b-dae5e6a57721@quicinc.com>
Date: Mon, 15 Apr 2024 20:17:01 +0300
In-Reply-To: <c5080887-6d94-405d-a57b-dae5e6a57721@quicinc.com> (Jeff
	Johnson's message of "Mon, 15 Apr 2024 09:59:21 -0700")
Message-ID: <87cyqqy29e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/15/2024 9:27 AM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>> Is there a Ubuntu / Network Manager fix fir this?
>> 
>> I would hope that Network Manager doesn't use WEXT or especially run the
>> iwconfig tool. This is why I suspect that you run iwconfig manually.
>
> I am not running iwconfig manually. I'm simply using the Ubuntu wifi settings
> menu to enable Hotspot. So somewhere under the hood Ubuntu/NM is running iwconfig

Oh man, screenscraping iwconfig is horrible. I would be very curious to
know what software exactly does this. This makes even more important to
extend the cfg80211 wext warning per process, otherwise there can be
more of these which are not detected.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

