Return-Path: <linux-wireless+bounces-33657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xYcPLo8bv2kZuwMAu9opvQ
	(envelope-from <linux-wireless+bounces-33657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:28:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A826A2E76B9
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFAE63008326
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75B2DEA7B;
	Sat, 21 Mar 2026 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUEESDco"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9698136672
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132105; cv=none; b=gi6EdxL5gmAOQZPXkuWusMFZJLtqo0xIlrzkzDUe4zhrEZq62SPHYS34tm5Ke/dFcyAEEV8s18BZ9saESGdukwb76U/9JKn/u9Q1q0o2SWGRpvjWa9bPSyLrMrcT1Zt0PZwZXreiNRN8ltgOfkkb9Dw7wG/LywT16+/n8OYsGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132105; c=relaxed/simple;
	bh=ZB8AMEepItOTLBvlzO0Y8gDHjfPYD/n/ODMqPQ1+8Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcYNn4MmpyfuFyjTN2o0ycJ4WG9DjHPlb7vwVQ54AspjIR+6qjY2yCB560UPFIUqvjK1F7Xwc0gN8fxyq+VsdmFoOulcpKViZUM/GjJRxOuULEwNQqpoh8oRrJU5wKW3cwLDyi7gJYlDUTa+udP7dsYNbKf4DeR9x3VSReILo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUEESDco; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c56e822eso3036443f8f.2
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774132102; x=1774736902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB8AMEepItOTLBvlzO0Y8gDHjfPYD/n/ODMqPQ1+8Yk=;
        b=VUEESDco5C0lN2pROiiov/X2QWBcE1kc6z+cOCN06S7lYte2H7vtxf2N0POsy+qkWl
         Gx5ctZoAw6AjlkAdtKt+o2elVGdpEsn6oyxDvSNL0u65fhfsXGX8fLfLQ8sGH+Fr/NgA
         l972zmTJu+mIh44tMR1U7n4fHll4kQlS92+aBW7ToKn0DBqCv8QBZD+eEk37xUqg231d
         4BFd/wM1MqQrGleN81ygUyGOFDytKbE7ur181jAzf/4SirGq8xT/fkBiQZ3d4Df4RQVk
         bfw9nDLX+vFiC9c6M1Dwan4Y+lPkL6sPQKmNe0ReJnYwWRYWa5geBHjuSaGjim+3BVY+
         mGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774132102; x=1774736902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB8AMEepItOTLBvlzO0Y8gDHjfPYD/n/ODMqPQ1+8Yk=;
        b=du8orr4eXk/NXia4YIVaIyGquXa80qRZMtnjdZrhGYx/sOFvDhl4nL9T85MCQBIR+1
         2M1FzXee3aNqC1aBL2m4yEecDh3DbNScGdowqxEB8ohEWIYIwkmu1u4A4+yjiCEkry1z
         nDV2sdjwKv9lbmF+bhAWd961RWjRIqyuzlgqeNeT7QkE6ppKE6A/xEcudlEm1w0pknpn
         7Nn0UwP8dtKElxYxvmCf9IT4suzRtZEMSkGVPSMQ9OyubHADpsJRnsAvmHiGhkLGm88x
         xz8sSZuV+pZ08CXIBOcjlmwu3ASXzEgcwHv+hYHxZST/DHqO0Ys2oA7R1f7kZnZs/hYv
         VRfw==
X-Gm-Message-State: AOJu0YzBNnOY3lzpx6ZuERkLyoWgwjMUwWxi3AtWwDGXaSN+yVYYyKpf
	aR8GOL/FZf5YW2UZXpQP0iUihPIkLo1gmHDcBAgGPaQRJB7aav92Xlur
X-Gm-Gg: ATEYQzywzcA/IT5yuZEGAi+Mi3TMOg1cuddl15+YUgkpp9DvlWjkSD8JKUy8Sa0471D
	Hnf+DzdoxkUbbLibsBdVjol3zB/iMDWw5PGL8SGeqZinLYy6QFJP0zgn/0y8xFJ6ILt8xRRWo8C
	ajlpQXfq/PokXzdw9EZoMRY1W53W5gM5mYhaVhzFZkOXmWrhs1uO0mJdE7vBL/+Tlcoq4rzV/TS
	CX8nU/jQ+WmXi1qGaq6VpkO4uGMQ4+4SWY6JuwqzpNR+giOfSX/Zgsn8OfB/oK9lxWqy1Zn2Sri
	d9xTfYZYljFWkV98VCh1DXZnfYkds/rBeXVS9ECf7GJZoubry+O/G9V0mWXhGFaodt6DbsJCo9e
	RY5I8yylGo6ElyMu37xd/B+lGIIlp6AfNtvwIunHmx++ZF+KvEhEeNa8Jp5P7x8ycvQkE8tTihZ
	90rMs88JdqF3kWGv4/zIH5tjwUqvASDO9UGYgsTT1Ek3JE8NypgfzSQUq1crdc6V6cUIs4gJ++x
	KiH4VU3yXaGDCpAVT7llrkQbXs+3dEs
X-Received: by 2002:a5d:5f87:0:b0:439:b057:cb05 with SMTP id ffacd0b85a97d-43b64282876mr11724066f8f.49.1774132102060;
        Sat, 21 Mar 2026 15:28:22 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm18616724f8f.8.2026.03.21.15.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 15:28:21 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w44lH-00000001QRp-0mmB;
	Sat, 21 Mar 2026 23:28:21 +0100
Message-ID: <4558729b-1248-476d-8262-56ddb228812a@gmail.com>
Date: Sat, 21 Mar 2026 23:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] carl9170: main: guard op_config and
 bss_info_changed against non-STARTED state
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
References: <20260317110634.70347-1-mas-i@hotmail.de>
 <AM7PPF5613FA0B6FDA6759CDCBE2421A8039441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6FDA6759CDCBE2421A8039441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[hotmail.de];
	TAGGED_FROM(0.00)[bounces-33657-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A826A2E76B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 12:06 PM, Masi Osmani wrote:
> When wavemon or NetworkManager trigger rapid USB unbind/rebind
> recovery cycles, each deregistration produces these -EIO errors.
> Over 30+ cycles this exhausts mac80211 resources and causes a
> kernel panic.

Resources exhaustion? Kernel Panic? This does sound like an embedded device!

Have you checked for leaks? ( https://docs.kernel.org/dev-tools/kmemleak.html )
Can you please post such a panic? You could be looking at as of yet undiscovered,
bonafide bug.... that needs squashing.

Regards,
Christian

