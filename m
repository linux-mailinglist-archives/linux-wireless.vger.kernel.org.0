Return-Path: <linux-wireless+bounces-11831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58395C8BE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC695289948
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B34149C4C;
	Fri, 23 Aug 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDnzrrpc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17B4F88C
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403742; cv=none; b=YG1vZer78/7j+BwBxn+7BGTIgrpjLaO/+GkQH0RnaQm5TLjesb5BBn+2ePmVhaXKTJjjr+lKowXMJwdUV32zhYG3UUuzW+yoKMTiK72/xbdUCYeE6+uowxjCdJo+wGlUDQEnM47HlVaIN5RznEng3N2fmjsz8E2vLthFMJpbCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403742; c=relaxed/simple;
	bh=H/7614+nJTBcupqCVsUEWF1bexjd/vjXqjK3qhHZF6Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l1Bgm6A6qtL6UD0tmENfu0bQcHDr/Tmrx3z8IfyxsFgR2HOhiWZhY0NNJsQoX8M1ccPW+Qm2Xn1muTyHNo44yH+KuX8QKV2VrIv1L+2RW6htWlxvAw+wFqiNnWbMhewDp3K29Ymr1GDOysRGkmhttzvsB9l2VnN4ax2DjyhwPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDnzrrpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA442C32786;
	Fri, 23 Aug 2024 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724403741;
	bh=H/7614+nJTBcupqCVsUEWF1bexjd/vjXqjK3qhHZF6Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XDnzrrpcBP3ME/xMUcQFFtlkdI0EVCJMvflhgaHQDwUHlIJhdTzLd3CfkTXXaKCta
	 +8OAZwyCiNq3B/GqvmrPN8PWRgwJh+5Q6tmjoFbVI6sis1LEhSxIjrmARMkkHl5lLG
	 XjC/xkCCbJfgj4vPkmO/IMy7Ff8jdY+5urwLtcn5D7r+oVxzyyOvZIT+Arh/FncqMS
	 jUYFCNMiDrl0pJ0Jw8B+Z8oIyJKZsL4QfcI42BdXVlNq4/7VzhUtisgwr3Cglry1BD
	 SI2ybrA1mWepv1fUnZkXunL+3esbYdbeQd8mswVORheH63b+Bl/n4tAzZWQlgyHjb9
	 qZZaCWKAVRlug==
From: Kalle Valo <kvalo@kernel.org>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: <linux-wireless@vger.kernel.org>,  Johannes Berg
 <johannes@sipsolutions.net>
Subject: Re: [PATCH -next] mac80211: remove redundant unlikely() around
 IS_ERR()
References: <1724380658-25139-1-git-send-email-zhangchangzhong@huawei.com>
Date: Fri, 23 Aug 2024 12:02:18 +0300
In-Reply-To: <1724380658-25139-1-git-send-email-zhangchangzhong@huawei.com>
	(Zhang Changzhong's message of "Fri, 23 Aug 2024 10:37:38 +0800")
Message-ID: <87wmk7fw85.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhang Changzhong <zhangchangzhong@huawei.com> writes:

> IS_ERR() already calls unlikely(), so unlikely() is redundant here.
>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

"wifi:" missing in the title.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

