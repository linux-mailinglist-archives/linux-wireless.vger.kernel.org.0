Return-Path: <linux-wireless+bounces-810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62C81388A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 18:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A51282F15
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B665ED4;
	Thu, 14 Dec 2023 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbhVuU1L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213365EBC;
	Thu, 14 Dec 2023 17:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EDBC433C7;
	Thu, 14 Dec 2023 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574990;
	bh=NyNH5F7nKk2e49p+NK9+PhBVsOT+PCB3S2tBWOUDKPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbhVuU1LB9LqeI6GrSu95wNTSz0OJQgbIP5T69yJp61gaz1woEqoGTCYBvb1iuKNO
	 YXAqcznfPt9SIvCwqVrkip/9gaK2Ijrrlfg9q7bKN01S/0/Cggf3zjeUO1Jlo0FfDL
	 wY51WjNZlFnH9qM25vbAHFeanwnSriKj95DdUhn23kuiUbq1hWd22JP7vSjtsTcun8
	 zAjs5iAa/+5usCqSM05YW7N0hapXHCWUO4reMm+SiCtFzL8O75OO8MFlGolyLsF03/
	 LQASIIiQgLYEvvA1D8aXyT3YVo4jE/w/Outtcowkp5G5hvH/Cxi0zxlm5Rm0t4RCpL
	 ZKiJrJ4JtxRfg==
Date: Thu, 14 Dec 2023 17:29:45 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] wifi: cfg80211: fix spelling & punctutation
Message-ID: <20231214172945.GP5817@kernel.org>
References: <20231213043558.10409-1-rdunlap@infradead.org>
 <20231214172700.GO5817@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214172700.GO5817@kernel.org>

On Thu, Dec 14, 2023 at 05:27:05PM +0000, Simon Horman wrote:
> On Tue, Dec 12, 2023 at 08:35:58PM -0800, Randy Dunlap wrote:
> > Correct spelling and run-on sentences.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> 
> Thanks Randy,
> 
> These changes look correct to me.
> 
> FWIIW, codespell does not flag any non-false-positive spelling errors
> both with and without this patch.

Sorry, I misspoke there.

I now see that with this patch applied codespell no
longer flags any non-false-positive spelling errors
in this file. And that relevant is misspelt without this patch.

> Reviewed-by: Simon Horman <horms@kernel.org>

