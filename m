Return-Path: <linux-wireless+bounces-31791-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALzSOVkfjmk+/wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31791-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:43:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E0130624
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52689300E62C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8527B34C;
	Thu, 12 Feb 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="S8uqfGPj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C689200C2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770921812; cv=none; b=o4kZRhFWd6e32erv+gfdEFEUuy+yr2RFMIJ7My2G03fvTWXnzf+0uSsnloB2JsBZ5MrrJWB9zLFK0t8Psty9XmwjMnh5Yl3IIHmGqShz8J81YdHQfJYlQwtJlHEqb85fX37DAZwaY/W0Ub6MUS/jqGyoq53pDyfbqZFBivmdOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770921812; c=relaxed/simple;
	bh=pppZEjwrR1D38Gxf4c8Co8fqwijRbFU9X0qOJeIToXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rVrajGU8OUQys8Onrb95AosAOo7G+lPxwHgQ71nwnzL5dHhCjMWMS35MWIN1kL+1YSsbICU6zi+jW1MBvu1jEB3crYGMvsU0fqBTnV5+dI2hjj/LRc7C6vgYQyEI+EMJeg+oG8r26zhBp+yagNLf30eL9rxDNDZW3KvuoRzohA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=S8uqfGPj; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12A50AB8DA;
	Thu, 12 Feb 2026 13:36:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1770921386; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EPfqeMV2nd0ppVMg/dOI3P2KvgX5mKIRWuiHCpgGJ6s=;
	b=S8uqfGPj4bU3tdJLXp/wQp78HiYiyZLCFiNqqcWb/DTjqeerKL59ylNgMvZJiH3HtcmhEx
	TDl77KZjI/Jf7rHyoYTXYHXAVzFUXmJ7cErNUCwB1/3ZOfyRS521ceRGapd9C3/N8EbwdL
	O0FrbFifu4vgQMOk8Mzg+Br4KcJT3js=
Message-ID: <ba5f35a4-d80b-4174-b583-e8cd2d125517@kaechele.ca>
Date: Thu, 12 Feb 2026 13:36:22 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
To: James Prestwood <prestwoj@gmail.com>,
 Richard Acayan <mailingradian@gmail.com>, Jeff Johnson
 <jjohnson@kernel.org>, Michal Kazior <michal.kazior@tieto.com>,
 Kalle Valo <kvalo@qca.qualcomm.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-3-mailingradian@gmail.com>
 <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
Content-Language: en-US
From: Felix Kaechele <felix@kaechele.ca>
In-Reply-To: <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kaechele.ca,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kaechele.ca:s=201907];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31791-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,tieto.com,qca.qualcomm.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix@kaechele.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kaechele.ca:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kaechele.ca:mid,kaechele.ca:dkim]
X-Rspamd-Queue-Id: C33E0130624
X-Rspamd-Action: no action

I also had some hopes that this patch would fix the issue for me on 
QCA9739 SDIO, but even with this patch I am still getting the warnings 
in dmesg.

Regards,
Felix


