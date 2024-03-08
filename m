Return-Path: <linux-wireless+bounces-4497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A584C876788
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 16:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67221C2114C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C391F93E;
	Fri,  8 Mar 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHbOKRdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B61EB5B;
	Fri,  8 Mar 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912741; cv=none; b=dOvhfV4P9jVkrri+wNMFgMirkHveXKpKcF442zkPERzMBIO75MMQ0P6o4pFIoYA2dMLqMPk3vb3CPY1kPV2YsUISLmPyX+MXkDN89Qr2FpqS9nDxObMQbTkL1Ld4xGvqjKw0js35Sw7QL3EAXSyatZO1fHv0cRG+ISv3BuzGI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912741; c=relaxed/simple;
	bh=llIfH+DNNudTFtyaFg2m68BQVSZKPdGxLpVZx4lgRkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOO+3Xr2hBSthvLL9sN5ozuT3ZPfMYM8mwiGQZHTh9sF4N0wr126wT8ipHa3vYO8RFIMKRnNrJ5RazAEUKWBlabQ0ClbatTjGW8OhdgCtTuM75nQBvAixa9Sjd1WdRVMEhIk66uTHxyD+3TVY6XHiVegy3rKGfEIPqr7h73hW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHbOKRdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B99AC433C7;
	Fri,  8 Mar 2024 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709912740;
	bh=llIfH+DNNudTFtyaFg2m68BQVSZKPdGxLpVZx4lgRkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHbOKRdQ5hOAZN9k82EuLgOFFVkT/rDxZgzHD8IreIW9I9ph+0od5aoCD2LgiTsjJ
	 UFx6XscvGssnvDI5n9BIiET+z6sFPaL1HThP71E/vq5oOi9HiizvYI0Tqz2fXaBfP2
	 S9KIzWmKJczICXhVTcXjONA6k70oYKbQZvfvvIqs+tjsxAIhocK51c/W3g+/kA9ykd
	 b3m+gUFcEdXEpGoG/QF/RJEDwc2ao4g8qNn30A3jYe0fNsuMBWJ8dtHub/YN5J5Rov
	 /6yXRsrAOZnO9a8Lx1VgMiMCki8zKbgBqdaXZApQPG9jI52PyYQnbzHx8ZBwY3Zyw4
	 NkYrbfRKqrHEg==
Date: Fri, 8 Mar 2024 07:45:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, Ching-Te Ku
 <ku920601@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: pull-request: wireless-next-2024-03-08
Message-ID: <20240308074539.04512f66@kernel.org>
In-Reply-To: <20240308100429.B8EA2C433F1@smtp.kernel.org>
References: <20240308100429.B8EA2C433F1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 10:04:29 +0000 (UTC) Kalle Valo wrote:
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.

coccicheck flags:

drivers/net/wireless/realtek/rtw89/rtw8922a.c:2235:2-4: WARNING: possible condition with no effect (if == else)

for a non-urgent follow up. Doesn't look like an obvious false positive.

