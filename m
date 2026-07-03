Return-Path: <linux-wireless+bounces-38605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D4q9LBgBSGptjAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 20:36:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A313704F81
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 20:36:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mD62q6zY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38605-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38605-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68BC5300F5ED
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3CB31618B;
	Fri,  3 Jul 2026 18:33:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16D2F745D
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 18:33:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103588; cv=none; b=BWa0Fbfi+lLSw13PopF4zoubdVh10IBCbxguS2nQTJuazO/yddth9ePzoxsRo9/OT2+opk5pDsHtVHAlaHj8YkdEz9kj/MnbaNnINHVvbRxxWDMzUl3ebF9/mmmLqF8T16rUZGE/1oADv2JQbpkNFZeDNxRVZP84xPUNNHhSxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103588; c=relaxed/simple;
	bh=x4hZaC3qSBTQ+0r7SnWMnbQD6b27HqnpjIIjcYi9yVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4/K9nbchFVJP+NypY9kA7BhyjJoSCWoLA2cSXl+WqDEV2krO1yfFcfEcrsCjU1Q7LYJeVBBUPRVXFaa2Bg30+0uHeF1LOLPL0CtD8JtNWaopeyvWJmbmH8WBL33df7tN4MR46xY8kQBXJKZiz739cdXw3YpJkY/XEmtxvKXf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD62q6zY; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-471eeac43bfso910336f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783103584; x=1783708384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x4hZaC3qSBTQ+0r7SnWMnbQD6b27HqnpjIIjcYi9yVs=;
        b=mD62q6zYryduvOUtwnrT6iiKJqZCzT93L1XK6GW9jOHkPBeL8AJskDxDr4y5zK2N3l
         9mj5YkjrAX7wbgSWNb4+FvNS6RH6jcEl4RWST0BJXC5TLk8/ahBgERYBv5bdMOvlwFNV
         L5Zf0KFkPdM2XCrZI6AA6jFns9TwcxIlJ2LdOqQeX6wB2Q/URoONreSRAOinjewm42LA
         FmReWcyisqw51SawIpJOp7AjoDyo1ZsbTRoW0QfjQib/ptjZObKKuXeIize3Q9S7DTzJ
         3aWaXMPUEuo/L6EfnZZn0Z+6XqxULoX2M17cDaUKWxY0ricle2KaMO+h6dFeqE8wbKs7
         AF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783103584; x=1783708384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4hZaC3qSBTQ+0r7SnWMnbQD6b27HqnpjIIjcYi9yVs=;
        b=nwMaNLpYBiAAyjJ8+395VHcLyKSh3XEcu5oXxNrZ8QyZ4SDHm4MELzly/Wv9ZPqeZk
         bCQOt0bo+X60ilDdFVMQ1nmNPgxi3K/S4c9FY7lhHy8KkOuL9bnWSVTSLrbr4ge2UqFG
         axAnwDvxkUvczS8horMSRpwoWDegFEZwQqdHtc80vNB0GSUAOH8drdg7A/1IB76iea2T
         BoRvZITfwA2Iujbqp3pMgrZgXN/0Ggtxtt6zYlBJiQHVWDq6OaCTxWe4g7XllytUdhUg
         i2NVW56Ij7Ly9oi3wUtPa5uYVNAThIAtHqv+NHhf9WeNK9n0U9oVZUZOHChuiGNbJzye
         uCmw==
X-Forwarded-Encrypted: i=1; AHgh+RrcGRL00QUeIVqfDL0RBneUtR8JZtQE8nPIbGzP0W0VlPmTrjQeTgENJpaWjD/Mo+9Vxuf+z7acsn7OauTBig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdXcVG5miBXjf26nAiS9V5kSJjZ21XgS8uvnZJS7IRhHSYoVc
	PExPOO6O5G0fyp5hjkFeH+ZcLcu2EztOJy9mMXcI9ZNdxldx/uCY4+3T
X-Gm-Gg: AfdE7cnqdmi5E4FKJO8tf8qF8tCRSxUOaLore2rlxvUnS3vk4JLM81HxYVQxeJIJsuQ
	aVa6hmxoQ6MTv6CSoVfz7PU+niyhG9KSjZwi0YNYAeMlDTbBKdIJePBgCRTqfYgSHH/CcznUSlk
	ARhxXLaI6mkakKIvzJdkIkD+/C2PAtCGpAyHGy6U3mrT6jk4FCif7FIjr4R9Np2ieprlNdFihIY
	1yvtZGcMQ8EsXEzkY8BbZkqE6TvN1I+cIaIPD9nvqPh3PTc1TXBL8X2OdEj+3U/OShxVVuBow5W
	caHTkFz8S3yIpAxZ8yr7HDoigtxwaZk7upo6bsOuSxU2Q5MPSsL37E4sq4tABDuKvoI/PTAUPeC
	9pEyk7K73SV3cTdQnriWHu9KiGinN0oHCAtSOWEm2ZSUoF3/Rm6vKzEcTjQ+kcO8hVjZhlCsRtH
	CS3Wk7gZNdpxO1mRsps6MmgY4wHoE2O+iTSWryphYEqL6IB2d1qwQfulMJ3OQnyTNTa66gj4KDt
	1UOW7wh
X-Received: by 2002:a5d:6f0c:0:b0:46f:f12b:e456 with SMTP id ffacd0b85a97d-47aaaade280mr570803f8f.25.1783103584106;
        Fri, 03 Jul 2026 11:33:04 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm1270043f8f.11.2026.07.03.11.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 11:33:03 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <0e19531c-2b24-4e9a-b4a8-c7991b28d6ee@gmail.com>
Date: Fri, 3 Jul 2026 19:33:02 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: p54: update stale wireless wiki URLs
To: Anas Khan <anxkhn28@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260702102325.63955-1-anxkhn28@gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260702102325.63955-1-anxkhn28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38605-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anxkhn28@gmail.com,m:chunkeey@googlemail.com,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chunkeey@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A313704F81

On 7/2/26 11:23, Anas Khan wrote:
> The p54 wireless wiki links (wireless.wiki.kernel.org) return 404; the
> content moved to the Sphinx documentation site. Point them at the
> current wireless.docs.kernel.org pages.

Nice!

If you're interested in doing some more work like this, here's a list of
known dead links:
https://lore.kernel.org/lkml/6732bf08-41ee-40c4-83b2-4ae8bc0da7cf@gmail.com/

that I detected some time ago using kconfirm:
https://lore.kernel.org/all/6ec4df6d-1445-48ca-8f54-1d1a83c4716d@gmail.com/

- Julian Braha

