Return-Path: <linux-wireless+bounces-14815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832FA9B9364
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A211F22C34
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154691A4F19;
	Fri,  1 Nov 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju0iIx6e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE290179A7;
	Fri,  1 Nov 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471802; cv=none; b=Ax3dYIY/J9hlreeqJ1gLTe9AgB+5oRyam6PyyC5g8TSrTAXlnPTwa0hVLObe61HDu6yL11WaRWyokEORBpTt9I5+rWBAx2m8Hm8svx2aEiaAXBtidd5i/CqdUHWgKfThfwjiprWiWB8kbZYZtMXFN7R6Yf/sF3evZva8vXrUqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471802; c=relaxed/simple;
	bh=B6Ps9zB4aV1W72dCiyO9auVDDGd8HQ3S8xycLVYl608=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NKFShiYmQum2oOORaUJU4OlL95yHJJ+6/xTcDKK67UYz0E0ggKbKzH33T2ImqNQc0giLxUC2Tj4SzCVqO6HC96goFpJT2+rYRUNOX/BdsahN3vYYCQooJy5zGf5tTWfF5ZlzL76lwSiQHRzTs35jQ9nAiEdNGPeCqt94qAcpYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju0iIx6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8DDC4CECD;
	Fri,  1 Nov 2024 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730471801;
	bh=B6Ps9zB4aV1W72dCiyO9auVDDGd8HQ3S8xycLVYl608=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ju0iIx6e28tbAb8YNXSOdV9wSUsLWdTXEkiZNLU6TC5b8QcOp8gv2YI/6cQm352bX
	 PBsA2g7qarmW1ovw7KVfuGXMywlnOzOdyNJNE45bjL7aG16v8UAqYlXF8O015F6SV/
	 LfMIOsOtlaXKg3XLUAUi2uYB+Y8zj5Cfv4hUKlHCFfjSGeogjl9VFX4X4KTmp08j7e
	 nZb0R87IeKTsuLP+QC0FGJqGq3h+XPKb5zfuib8no0FbpwmExHLp+AxGPEjIHRusvv
	 PciKpGi+FiHfEhdKy+vdU96c1O2TeytHaB5TnXo3iw5B3rOHt8mOYbF8W9BOyRGDzK
	 TL5C0KlRa/kig==
From: Kalle Valo <kvalo@kernel.org>
To: Gan Jie <ganjie182@gmail.com>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  trivial@kernel.org,  ganjie163@hust.edu.cn
Subject: Re: [PATCH] wifi: iwlwifi: fw: fix typo 'adderss'
References: <20241101143052.1531-1-ganjie182@gmail.com>
Date: Fri, 01 Nov 2024 16:36:38 +0200
In-Reply-To: <20241101143052.1531-1-ganjie182@gmail.com> (Gan Jie's message of
	"Fri, 1 Nov 2024 22:30:51 +0800")
Message-ID: <8734kb6mx5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gan Jie <ganjie182@gmail.com> writes:

> Fix typo 'adderss' to 'address'.
>
> Signed-off-by: Gan Jie <ganjie182@gmail.com>

Please read the documentation again and _very_ carefully this time. If
you submit a new version you need to mark it as v2 and include a list of
changes from v1.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

