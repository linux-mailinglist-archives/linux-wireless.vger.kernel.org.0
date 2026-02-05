Return-Path: <linux-wireless+bounces-31605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGOnHO7YhGlo5gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:52:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF2F635E
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DAAB3054660
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D93002DD;
	Thu,  5 Feb 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3lUgFNc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C919E968;
	Thu,  5 Feb 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313828; cv=none; b=Ua+xsBc1siq3b50cYBKFHpnQ0JKj+LVNKp6KBnECjGsDeCrzKRjqoy53fb4j9VADZAAkbARR1souOsFyoU7mvzz6Jz1X3Te/nHdhbafXNKGfOSWm2VMWQngoThMdhyXqYNOstsJj0Gj3CvnVZMJ24um+7hVE/11+sjbENlYwUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313828; c=relaxed/simple;
	bh=CN4nUBI6L41rFyhFE3qsxFCGoucEV46Fb1kXtNIH+3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVDYQFIKQ9kHFnsSDpN7Z/kRTng6/CXjJ0+gxI+E2Z9ToOcSlLoiQ1cR9pweAytNCokeD/P98ASEixWUzrNIOGI5JKURCQDEbo1paKOAIp0ib+8IV7dP8qk6Oj/p3OtN7QnxGlKhvlIdTuwzPKAp6YPi83hRJEA05tIJGmqIz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3lUgFNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85E0C4CEF7;
	Thu,  5 Feb 2026 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770313828;
	bh=CN4nUBI6L41rFyhFE3qsxFCGoucEV46Fb1kXtNIH+3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3lUgFNcQyXEPmEaOG8h5Fuxu8eUSokgIC3Nt+3N1Ts3k+uvxCk60podCzMwkqbpN
	 fZu9HanuIBaSJkuBydJxQkDvgCRzmlUDmhAxdJRfRdpRV9tb+kr9nVgmRx2pTM56tq
	 Xo+DkLkn6YGu7QUgfS90QfdXQtroZDo64d60xKLg=
Date: Thu, 5 Feb 2026 18:50:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dhyan K Prajapati <dhyan19022009@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: Re: [PATCH v5 wireless] mac80211: fix NULL pointer dereference in
 monitor mode
Message-ID: <2026020512-egging-appetizer-fe38@gregkh>
References: <20260205174650.4575-1-dhyaan19022009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205174650.4575-1-dhyaan19022009@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31605-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 06FF2F635E
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:16:50PM +0530, Dhyan K Prajapati wrote:
> From: dhyaan19022009-hue <dhyaan19022009@gmail.com>

Doesn't match your signed-off-by line :(


