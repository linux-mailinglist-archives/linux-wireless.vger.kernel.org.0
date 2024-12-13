Return-Path: <linux-wireless+bounces-16359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6F9F0667
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DBA188A651
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8FB1A8F89;
	Fri, 13 Dec 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT2prM+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFC1925A4;
	Fri, 13 Dec 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078910; cv=none; b=tkYXKhx8c+uZXmfXNqDAF0OlsIu0cfTF9acaoPAhCFLH4bX4/32Aob4DL2DgtVr+hxYR8iyEqiG0amUAlRlS8qEPiHVYm43ipgRxZxxZAe/NwrlkvXJfZ1LAI9CDURhU6QbCcUSiGXIO2yTxC03oDsUFi9hECCP044iTIuOW5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078910; c=relaxed/simple;
	bh=QP1IcOeCvYcZ0atShD+bUuKM45SXUGPe32/BoheXswE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HLVBknlgNAHXKdBSEnypcfMjIHpNjd+xSNtq8GmV2k2rJedi4xZOs81xXfIC3ohvPuIfcgoA7Qb3Mq56AqT4o1M0boAITnC63QZ1LX1YIB4VGJUD3R52Z4/hu8QMfTQsbrxCYv1F60t0Rkb8m7jaLVqKaPQFwha066MhoiPq/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT2prM+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048BCC4CED0;
	Fri, 13 Dec 2024 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734078909;
	bh=QP1IcOeCvYcZ0atShD+bUuKM45SXUGPe32/BoheXswE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jT2prM+gHqgOY35eQxxtPZwHA84An0lqy+jJ4VjIx/MgK1xmiD1DupxMjf1BS03DE
	 jZKWiIDCMt1Dut/x6m5L9fRJeEudaFG0io8G3ncIqNeuSovHHU6r1ld8RMRlNvYDpa
	 xrevaMDxiqOpjSDNbOBuOR7Vzdc+lUvOs1EjKeGIVmo5CDYD8xMYam7fQYbJQZ4t5y
	 65QYPQFntmM6u8+bZMdZspFgP3N8nup2XcikiW16KkJNw/jEEdh3qWOP86QD6gwI1C
	 TDF9UTrcZ/Kf8aeh/E/rxyUESdoujS5qHrLHpERCndLqc6ZpUushFrg5pfoKhQ2Mp/
	 erc2nOq42tNsg==
From: Kalle Valo <kvalo@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,  torvalds@linux-foundation.org,
  akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
  linux-security-module@vger.kernel.org,  x86@kernel.org,
  linux-snps-arc@lists.infradead.org,  linux-wireless@vger.kernel.org,
  intel-gfx@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,
  nouveau@lists.freedesktop.org,  dri-devel@lists.freedesktop.org,
  ocfs2-devel@lists.linux.dev,  Steven Rostedt <rostedt@goodmis.org>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,  Rasmus Villemoes
 <linux@rasmusvillemoes.dk>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Andy Whitcroft <apw@canonical.com>,  Joe
 Perches <joe@perches.com>,  Dwaipayan Ray <dwaipayanray1@gmail.com>,
  Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/7] vsprintf: Add %pTN to print task name
References: <20241213054610.55843-1-laoar.shao@gmail.com>
	<20241213054610.55843-2-laoar.shao@gmail.com>
	<Z1vq2-V7vB5KhBR9@pathway.suse.cz>
Date: Fri, 13 Dec 2024 10:35:03 +0200
In-Reply-To: <Z1vq2-V7vB5KhBR9@pathway.suse.cz> (Petr Mladek's message of
	"Fri, 13 Dec 2024 09:05:47 +0100")
Message-ID: <87r06crnew.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Petr Mladek <pmladek@suse.com> writes:

> On Fri 2024-12-13 13:46:04, Yafang Shao wrote:
>> Since the task->comm is guaranteed to be NUL-ternimated, we can print it
>> directly. Add a new vsnprintf format specifier "%pTN" to print task comm,
>> where 'p' represents the task Pointer, 'T' stands for Task, and 'N' denots
>> Name. With this abstraction, the user no longer needs to care about
>> retrieving task name.
>
> What is the advantage, please?
>
> Honestly, I believe that the meaning of
>
> 	printk("%s\n", task->comm);
>
> is much more clear than using a cryptic %pXYZ modifier:
>
> 	printk("%pTN\n", task);
>
>
> The %pXYZ modifiers makes sense only when the formatting of the printed
> information needs some processing. But this is a plain string.
> IMHO, it is not worth it. In fact, I believe that it is a
> counter productive.

I agree, it makes the code harder to read for someone who is not
familiar with all the %p magic we have (like me).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

