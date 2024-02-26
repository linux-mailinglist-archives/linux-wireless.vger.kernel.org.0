Return-Path: <linux-wireless+bounces-3996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D6866A94
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 08:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B0E1F21160
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 07:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53DE1BDCE;
	Mon, 26 Feb 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBomfR7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19ECEEDA
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931930; cv=none; b=ISpv6OmbC1b/UURzJPc0dk7ivbyxxkhgHtTZtJRO3Y9Pj4k05xqxs/vGWgiaWQJQlRxChf+ZPuwYUzik2uSM57XSZpu5scTMr0RcxYEZpIzMIL2091QN4ZdGSv251K0S5afVYtoM3y/FCd5sI70RRxmD7f1EsKqyrzgBYvL8kbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931930; c=relaxed/simple;
	bh=elbuon70cVLTRHv3Iv7ezxzVxH83AMoPaG58xnVpA48=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JfQ+uXnle5g+v8aKieAX1Y7uOp1AFobjQxv7AYt2Gypi6lFX3HGxhHOvzrTRgPmgVNY38Lt1IfHTDPH/xSR3kv6keje5i4HM1W0J128afcWNXJpqQMISSpDrs4r/P/eqDPQ78evGxkjwjdgx66nF2es+QfJakfPs7So/P0hx8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBomfR7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F741C433C7;
	Mon, 26 Feb 2024 07:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708931930;
	bh=elbuon70cVLTRHv3Iv7ezxzVxH83AMoPaG58xnVpA48=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jBomfR7/oZXWbUEmUawwWS1VbSmINYz/lxMByTB3ilUBHLy+ludEi8vXH7UiKLUGR
	 iKxPmM8MDJtBpdVKqsnWd0LNkokaGt5pfI7MxllPVhJl/pMqvpdm8jlUs/mUhiY8wL
	 pgEibuM4XlvnFGDj6965K8jWo2hh3rptX5lbwmESrEpa+nBf8w046nvnU4v9uQ79FE
	 BhcPkPnnSyRS2Ym1gVImUvM68QHh/8dhhT8GXIh2yUES2X6AH46zHTv23bHrsIqfNJ
	 myunGep2XhtzCtmxRlYJ7SI+c7QWoFOqrjep/nNmaJy1P7RALYX8fphkwVryzbYkZs
	 kOnKwpjTTqrOg==
From: Kalle Valo <kvalo@kernel.org>
To: "serge" <vasilugin@yandex.ru>
Cc: linux-wireless@vger.kernel.org,  Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH] wifi:rt2x00: don't overwrite SoC specific bbp init
References: <20240226094016.1JaTRGbB@mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net>
Date: Mon, 26 Feb 2024 09:18:47 +0200
In-Reply-To: <20240226094016.1JaTRGbB@mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net>
	(serge's message of "Mon, 26 Feb 2024 13:40:14 +0700")
Message-ID: <87o7c3ae20.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"serge" <vasilugin@yandex.ru> writes:

> SoCs rt305x have the same MAC version but SoC specific bbp init function
>
> Signed-off-by: Serge Vailugin <vasilugin@yandex.ru>

The commit message should answer to the question 'Why?'. What user
visible issue/symptom does this patch fix?

Also From field need to match with s-o-b, now the names are different.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

