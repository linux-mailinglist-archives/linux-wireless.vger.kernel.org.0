Return-Path: <linux-wireless+bounces-10725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0860F942A63
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 11:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B851C208B2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782E450E2;
	Wed, 31 Jul 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD7WVuiY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E888801
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417973; cv=none; b=m3zGPV2n5NiQKLmm+GNhxhMj/O27m5V6zHKiAwa2wLFPwaeAS0PzjojfxUR8q/uP62Omc1NNx5jsnkj9MOGYQzw3OucWamzi9axP/CFgA9KCn42QFRT+IM1z4YAs0vceHAWgu4loDYEaft19/UIXVaKUkZHLUSILQHR7Gg5AXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417973; c=relaxed/simple;
	bh=h6eXRHjZsqz0eZnrXmoQcFkkUJXwicTIi2HYUrwkARY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=u596tEVBWUY2ZODTsDK1hStXm5ELnG2sZAQTcmXy7bz68QCXxOgQg33Lr/nsF429KCbl/AohiXH5IROYi45wHwQGbX4MX/Qp+mmBLRdKwJ+iAY2LJW5GbQIkseWzIYmDeNesSLiH6oqlI+AHvFcfCfMeoU+gdbd+pg5bn4PYcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD7WVuiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B729CC116B1;
	Wed, 31 Jul 2024 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722417972;
	bh=h6eXRHjZsqz0eZnrXmoQcFkkUJXwicTIi2HYUrwkARY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JD7WVuiYA7JCwfCqR+mw3ra7zATSbP8ElEMlhhcu1xz30wKUWGha4sLzmtTRlGmtH
	 r9KnQdsLLf1AbAlh0qRYeUIUZl5B6eRsIohY5Q83Buhy97N/PKxwwfsSWhj2V6XZEi
	 n+jqolUwvFbS1GcTwBxh9UlgMjVYW4XF2XFmtf5aulaIo0k/uPonJFaeOabD3lgO5d
	 waTOpP/i+3tTxiz9H2p99bnsGv7PB3/1SWID4SPjOub+/Cwwe3suyX52C13sQFZGA/
	 WnqCKR4DR6kZ7vZFhISlYjhbagKP7vEfAVRvrO6qlr2OSk3/HShhNyBn88HV+6tEZs
	 pjvpa83vAOGhQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Dylan E." <dylan.eskew@candelatech.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] iw: scan: add EHT beacon info support
References: <20240729220421.2030748-2-dylan.eskew@candelatech.com>
Date: Wed, 31 Jul 2024 12:26:09 +0300
In-Reply-To: <20240729220421.2030748-2-dylan.eskew@candelatech.com> (Dylan
	E.'s message of "Mon, 29 Jul 2024 15:04:22 -0700")
Message-ID: <87bk2dlxou.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dylan E." <dylan.eskew@candelatech.com> writes:

> Update and add to the old EHT beacon info implementation to print
> EHT PHY and MAC capabilities as well as MCS/NSS information for WiFi-7
> beacons.
>
> Signed-off-by: Dylan E. <dylan.eskew@candelatech.com>

I assume your last name is not "E.". We use full legal names in From and
s-o-b fields, the same name as you would use to sign a legal document.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

