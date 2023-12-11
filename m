Return-Path: <linux-wireless+bounces-660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407EE80CA96
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAA72814FF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6A3D96C;
	Mon, 11 Dec 2023 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmfEW9Ne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFB3D96A
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 13:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3B5C433C8;
	Mon, 11 Dec 2023 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702300423;
	bh=pIf8sTQFJFxaM5nVWsgit4VElj+tGJc5xIdKyuuHP6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tmfEW9Ne+b+WNl+TG6pecbHskdM+si2/LfkeC1bUwFW2vOBTXbYr/36SdgQz66X6V
	 D3GgunjTBiZlzB4ILMWYy2B2Q0JGX2nUk8aGbe2B7ZpY0MiU6+seI8PtB5foa6l9Xl
	 FRDU1pctgbeXWzSGZlcfSt4YF/Zq8TkSrI0+HNVEK0A2hoOF0oVlHDDc8Fsx/SWZpG
	 fGq1VdzIotkwwvdk1VsLMylZdnBhgIP2xO5a3HhKVJ5iwK2irDmhY4rz2v+rjvBakE
	 oo5385YsVgWLXmqLQmIUsrTBOc9lTuCPHm6ws/erkd+7uB8WORHXsdFNv5RYdFpScW
	 ZuZObrqmxdzjg==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: mt76: fix crash with WED rx support enabled
In-Reply-To: <20231208075004.69843-1-nbd@nbd.name> (Felix Fietkau's message of
	"Fri, 8 Dec 2023 08:50:04 +0100")
References: <20231208075004.69843-1-nbd@nbd.name>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 11 Dec 2023 15:13:40 +0200
Message-ID: <87edfsq3uj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Felix Fietkau <nbd@nbd.name> writes:

> If WED rx is enabled, rx buffers are added to a buffer pool that can be
> filled from multiple page pools. Because buffers freed from rx poll are
> not guaranteed to belong to the processed queue's page pool, lockless
> caching must not be used in this case.
>
> Cc: stable@vger.kernel.org
> Fixes: 2f5c3c77fc9b ("wifi: mt76: switch to page_pool allocator")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I assigned this to me on patchwork and will apply to wireless later.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

