Return-Path: <linux-wireless+bounces-9614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B1918A2E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB18287808
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2918FDDA;
	Wed, 26 Jun 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuULq9dl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34213B5BB;
	Wed, 26 Jun 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423300; cv=none; b=YStc9umXAsuQry9B8wpBs//KkriCHtiH6BPcXG/mxkgLsTFWw2QueMSVxzFoUK4JeYGoC3+grC8fqrq8towKYD+5iP3tZ81jUeIxxTfmAfgjBBk5E3TBC5m/5sQHqCg+L0l85ATdlDDhGAKO8pKOXLkxvkiCywXuBk7BykG9ylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423300; c=relaxed/simple;
	bh=WSVXroJS/C1VOwNyQN9l2YLS9eFW1Oj2OWF9CoE/sTw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bf3mVDO9g3bCzdoK4SswHpJK8pOq380KGl2Ini6HJw6/aHJVmldtdN8ozAtv+M90i+xKf38XDv0CFLh9M5Le2edK7W833EBffZy/OyhTTkpUVsdV9s08te1NS4CzuJ4V4JvDxt2C0OotAzcL3xzPfytX7YZyuG4U7t7vJYaZh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuULq9dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284D8C116B1;
	Wed, 26 Jun 2024 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719423300;
	bh=WSVXroJS/C1VOwNyQN9l2YLS9eFW1Oj2OWF9CoE/sTw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DuULq9dldIuGvlhrYsHksEXdYPU45A4X3uPqY/nl6vs522HxWC+s6kotrZ26okC14
	 hc/wnWgZiTYQ2iVXSAk+G0t9YQXWUFPyaEBoJt/3RyRH5alJeuwxqRBb/DCd/y/JVs
	 Ww/ha65Enm0kJeFSDAX9tO53C525P5TZqeR2lF0meLgI3SCTHK9dh8PdqTaKn3Mr/F
	 /ZB5x2Lmlc6Uf3Q0sSvRh3MKyOL2+pSQCW5Z80B9xJeRokO7i7tvIuDWD4h7ZBr7jX
	 XWtgUBNDGZkxzBQV+eo2t1d6JI4khxTPcTIp5R7lVK2BZFm2M02URl4qOE3MlKLhDk
	 o/++02WbsSXXA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] MAINTAINERS: Remembering Larry Finger
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240625103929.1332926-1-kvalo@kernel.org>
References: <20240625103929.1332926-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, florian.c.schilhabel@googlemail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171942329755.1803120.912978834356042656.kvalo@kernel.org>
Date: Wed, 26 Jun 2024 17:34:58 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> We got sad news that Larry is not with us anymore. He was a long time
> Linux developer, his first commit was back in 2005 and he has
> maintained several wireless drivers over the years. He was known for
> patiently supporting Linux users with all sorts of problems they had.
> Larry's work helped so many people around the world and I always
> enjoyed working with him, even though I sadly never met him.
> 
> Rest in Peace, Larry. You will be missed.
> 
> Link: https://lore.kernel.org/all/77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net/
> Link: https://arstechnica.com/gadgets/2024/06/larry-finger-linux-wireless-hero-was-a-persistent-patient-coder-and-mentor/
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch applied to wireless.git, thanks.

c7049843db75 MAINTAINERS: Remembering Larry Finger

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240625103929.1332926-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


