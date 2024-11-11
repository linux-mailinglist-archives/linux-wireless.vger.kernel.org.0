Return-Path: <linux-wireless+bounces-15178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B29C3DD3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 12:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B321C20EB3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD71991A3;
	Mon, 11 Nov 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJen1G85"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E7139578
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326355; cv=none; b=V9WzUJYgykLCv69JfIbBhKTf3snuYVLpHfloZxBqdd3t5urFwlaSa365jiaM7NmtQ2i6VubkmZ9uBzJm0I5uGp9ltMvYiB7CnNXzMtPzf+W5KAT+WnCZvkcSlaPGD9j6MTJACYIRcHDDGxV6/H46EbIA+aYR3B/wXhn0dFV8IKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326355; c=relaxed/simple;
	bh=p/Svc7WA3G2fJQL+0RERQhNWfr7D1xYW1HxSUpkMJh0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jP+UqY8oyJmKGTz1A/x02yX0aUplcfUbhT/IN7e4Qeotze7xEPWLmXjjuzKAEarKPiVsX41nHD3g30lsLr+FAO+RBdHmxmLKR0ZYOWD03TBn63yU4vbEtexvk6nlKhe94yvd6Q5asJ3y3SPjdFvOE84oq3VXX14381nMXOJZFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJen1G85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F00FC4CECF;
	Mon, 11 Nov 2024 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731326353;
	bh=p/Svc7WA3G2fJQL+0RERQhNWfr7D1xYW1HxSUpkMJh0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=dJen1G85/UjXvY2tb1xOLyYpiw4zWoIQrkkWDVKlEf8B8PCVYo67C1e2enQsh4doZ
	 ZB9yodv+SsOQLcdGrm5pxyuiq5tCLqJI5UFPnBM4Qj24lJk6/z+t/SJUc+ekoIk//I
	 3k8FqtQSAOnB3d45GUHoC8Xhl4q00aMlyj4KrZz0MWp+tMfsd3uK5jUj9UJXT2gfaE
	 7TzRxJnvznUtWM24sNL9kPFhHeOXoBEARLNUvyLTe3rYpnAUC2n9LUzbDjjvl3+wDg
	 NvOCld3pQlLM6a6c2G3ZgZyQFDMTpbGZBo81aWmw3+kwywxUm91HdHzqrnVrgJUJK3
	 IiC7WtY5x4Ghw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-11-06
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <32a36217-21db-4234-bd05-b05fae3eaea4@RTEXMBS04.realtek.com.tw>
References: <32a36217-21db-4234-bd05-b05fae3eaea4@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173132635106.852485.3079553751820545715.kvalo@kernel.org>
Date: Mon, 11 Nov 2024 11:59:12 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

5255ee958f58 Merge tag 'rtw-next-2024-11-06' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/32a36217-21db-4234-bd05-b05fae3eaea4@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


