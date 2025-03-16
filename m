Return-Path: <linux-wireless+bounces-20412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22638A6374B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Mar 2025 20:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A62188D7E7
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Mar 2025 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C41A238D;
	Sun, 16 Mar 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="eCbw8N13";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="GZLY4nR+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C8D53C
	for <linux-wireless@vger.kernel.org>; Sun, 16 Mar 2025 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742154803; cv=none; b=jtBNYsc8NDX2Ak57s9Jw58G1N1nqpW6kwbJec6h/fOY2va3NH0LhsMQ/D3CmJYQi9/aLTkgXvB2wTDdnXBiOmFWl6bInbA9wlN45WY1plgu0WIl6qvoONLCFFMaFOhpw1gpoXjNfcEIFLL03H7O9OjWNZutS+XGCYJnzXi/sLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742154803; c=relaxed/simple;
	bh=H2hnrJCtHReCwTD6Y+SP+QvR8sCc3QUoDc4/K71eQhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skBNpUSm5EiRHcNzuMjCLjcld99WxaI4SVffO1G3NZdjhQtjjs/y4orNcQFdbTvGDPfCehkSY9GkshEuhmY6STX8nEd3Gb7M1IvBvwPngH72+LM+r049yYoSfSqxoev03NMCDVoRTqbzLer2bWMOiAatCl1i0pV0NNyzax4faq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=eCbw8N13; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=GZLY4nR+; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742154792; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=hUeiXtMpG5c+9kwlc+Cu/oS0ES51kI2lihM7zlWqsG8=;
 b=eCbw8N13O4Yaonc5xkvdTXUT6vYIEnUUm5DoXsvYIL4conPpSAf1fL05srlP2He9d0PCY
 mG9s1bWc1Bq8dHurmdzrsW7qkGpc9exiMFEb4BpRY+Pi2P5gbOjXCUtZE4LqJqGQAsE8Wt7
 Et5qlnW6BIit2geFL4oOpCD1BXlM2eF3FcIknR686ii6v7lhWSB125TH8xmlC467/2v9tjk
 Ii5hCxqSU3da7MJEaolY1fkuFxvUqco0XsItX/pRhVql6il4PaonnMWwIXgoAeyvQ68OhVW
 deuLXabnSeH/OMYaPI2oL5wh0sk3R1hU7hvIHq4XhHxrUzUlHn7FfW2nFzVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742154792; h=from : subject
 : to : message-id : date;
 bh=hUeiXtMpG5c+9kwlc+Cu/oS0ES51kI2lihM7zlWqsG8=;
 b=GZLY4nR+WnBFHkfbUINkWRlXSM2U4yVotC2eipQlwNwM/m3h8tIkw+/X4z1SB5JZFQnFH
 C1zvtSiDIoMlrRwAjDN1Ob5iWxTZrXIVzZiK1o8siSEQ1IzJPxBMypdZhWpwnug2Ho5Hn4j
 RJehT2K6QJcVXzgnI+FNmBF7vYyOdAF2UT0GwWSUYxOKH8B6FwL7iSbTMgMbeFcdM6P2oDU
 jFIhWrUF0nbnvbp4kuN52xp0h7b51IS+JkpX+kyNMsUEFNe/FHz2r1krIqYnfb3sX9gJ5pg
 dw4cz4bWtd/tnRQvoBRoZdTfIE3dFGMb8/uxJCMiPLjaN8E5Z4As19YEvqgw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1ttu2o-4o5NDgrjN4H-n2Hk;
	Sun, 16 Mar 2025 19:53:10 +0000
Date: Sun, 16 Mar 2025 20:47:40 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/2] Fixes packet processes after vif is stopped
Message-ID: <Z9cq3A0bqQxmvo42@pilgrim>
References: <cover.1741950009.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741950009.git.repk@triplefau.lt>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616srkUgvcFJi
X-smtpcorp-track: 7t2HuhYsGQlG.Wtck_NZFM4DN.HsXK_QU2vaY

On Fri, Mar 14, 2025 at 12:04:23PM +0100, Remi Pommarel wrote:
> Those are a couple of fixes that prevent crashes due to processing
> packets (especially multicast ones) for TX after vif is stopped (either
> after a mesh interface left the group or interface is put down).
> 
> The first one ensure the key info passed to drivers through ieee80211
> skb control block is up to date, even after key removal.
> 
> The second one ensure no packets get processed after vif driver private
> data is cleared in ieee80211_do_stop().
> 
> As I tried to explain in second patch footnote, I can still see a
> theoretical reason that packets get queued after ieee80211_do_stop()
> call. But I was not able to reproduce it, so I may be missing a
> something here; making that more as an open question.

And I forgot to include the footnote in Patch 2/2. I was worried that
because the rcu_read_lock() in __ieee80211_subif_start_xmit() is taken
only after the sdata running state it could create a small window during
which a packet could still be enqueued passed the synchronize_rcu() of
ieee80211_do_stop(). But after digging a bit more, it seems that
all __ieee80211_subif_start_xmit() callers (e.g. __dev_queue_xmit())
take the rcu_read_lock() already. So please ignore this last remark.

Regards,

-- 
Remi

