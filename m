Return-Path: <linux-wireless+bounces-31328-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNGVEB5qe2lEEgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31328-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 15:09:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852EB0BCB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 15:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAFF6303AB4D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79837F0EB;
	Thu, 29 Jan 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zew9WG4y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqDzCI/T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522B37F0F0
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695734; cv=none; b=uGEZl4d/Hw8ijMtAfmuvyYFMKYlaOk15jo9duB2UBxTc5q34f+8u6XBGGmzAWHcwuCMENd1ZdX1laUKeZ/x+PXySsoVj2YeCWGqODqtMc8oF1KyF+OAh5B0BC7VUvAMAfxIJkQv57li/oqjnyESB5TpHaua/3r4ggtTW4ZnFkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695734; c=relaxed/simple;
	bh=O7hoovYiGhQ14c3Rl6ksEXi28ZIhAz9OKfVontyZ6gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx8E/43J6+SCYoC1Lahl//x2Fi1NgNyj5HYLaLTc3jvpbgwMFykUHuvtTjLSFAxWiWOxRAgiF8vT/+UP+2BnlJVnfOjBeUoVTBH7WXOkZxZ+dswmlxCHYQMisJIOhYJv75hAUsNgW7+Dqy/EDuX+q0kaw4luH5MfP16zPpinZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zew9WG4y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqDzCI/T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769695732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yDdc0aOssQmwPiAEAMbLVrZwNafZDqUbaKFlwp9zUo=;
	b=Zew9WG4y0gopqo1LjywO6h+0mWy1ayX724nFhi3O3uZgggca+zSNbk59S+86qMImOvGrqf
	lONYfOE7+mPDpfd4EZdYU727+N2TjjyG4FiTc00fRDNaN3k9ziFja0FKnwOREY9Dr1UFbH
	EvKLxLEEoA+qt2HqOULWxrPgS1qD0OY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-KbTx3yDdPNmyQe2mgl3KvQ-1; Thu, 29 Jan 2026 09:08:49 -0500
X-MC-Unique: KbTx3yDdPNmyQe2mgl3KvQ-1
X-Mimecast-MFC-AGG-ID: KbTx3yDdPNmyQe2mgl3KvQ_1769695728
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so10525235e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769695728; x=1770300528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yDdc0aOssQmwPiAEAMbLVrZwNafZDqUbaKFlwp9zUo=;
        b=bqDzCI/T8Skdr117gGj4p7MvrP/ZqGfe+bWINSa5o31WX/LG5qwi2shY4zUKgAKzX2
         QDZDSE1r30/uHOMBNVWqXSUBpK5V4/q7GWGZFWyl0o0lZFBnxKDhUUmaX8LBrPUf1sXD
         9WCaLWzPzj75SX/4da+XHt2twrCscvHU6wgJjgqAgct3hCS+Ti0XaHJJyX5cB4fR1iQN
         D8ahaXcLKZs/8wfHx0MBGNMDtfmDdiyjz5kGYeaD48nB3gfGpPbkzkopMNsEp4vLLaRc
         UuvQoUkcmSfbH9WeVOWIhXFZk0WCX67T0VPr64ozMLS4yZUPeb7mh3SfRnZDbvbW/JNm
         lFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769695728; x=1770300528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yDdc0aOssQmwPiAEAMbLVrZwNafZDqUbaKFlwp9zUo=;
        b=vdQ4h83Jy0yCAXAG3UY7w4lFglNnDLPjS4hOgclsnMNMS/OV4+7exSqYqgRwydXakk
         12y/VVFdm2Vvg/IkgWonszokLrd0S0a5lJR6iu0tTUBD5qRnzuMJe7RkFSB2qhCqV+md
         5mg4xSV9FCXDaknuKzx2LCNsZsyqFmjE6btHwk0eFXA1dGR7WnggSBHyUvVdNMowRLfi
         PTzhaoLGhGceLcppvSyBNube0/YNbaMixTflRyD8Z1U3KER12WNFUbM8ZnRvFigiZnmn
         pea0CO/WzBmqeDxSyZt4jDreAGlXg5Z1igSTGKqhu8qbP4/lBLqTy7K6PZp95CPTghtl
         blJQ==
X-Gm-Message-State: AOJu0YwX2jqeu+U2OTSHubIK/PQqGiZnGcwsC8/9aZIpsrzCNNJ6snhb
	i6qhS92kXKdY7rKojWqBQeaYHFwUCmS9aQzaxM2BOQi56QRbn474k/Wn4EYjcOyJv+SR6YNXPc+
	+t9t7BZAXDUxy+og1KxgCEfOxmhGz8obcMub7FIKsEtnij++i1g2rls61vjS9E8kMcHqdFekoA0
	Nr
X-Gm-Gg: AZuq6aIFLCXOiR3UmpcwwUtYiGz0QvtqaBEOqqFKdn3GJJkzTyH1jCIo58w9KQSb8en
	xsvedS5RO6EX1bVTSgPFxJr665cmbfOLZCd96I8b6FyS/YcyGpTHF+UBIgkfnai44wPjO8XP6Zt
	vpdGZVPo94j0rAbhiqPMiJ55YBX4zTB/Da3DQ7LoHeQnbwBaACPWRENSE3hTOZyh8oKeWRGPD7A
	GWETgFo2IUfaod3e0Txb0vl3D+Qz55AuZ+4ZeO2cKw9TwARVJ5frrnER5EkaBmK1/OJve4ZAAQN
	SWq9pWlPKzotqR7Sa0LkEYPm+ll1++msy/XJNkdVRNmIUn+hdLHcxSZ9DrqWhQ2vlj0yRCk/7at
	Hj0lvs5IJTNtX
X-Received: by 2002:a05:600c:b8a:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-48069c7586amr115691805e9.33.1769695728074;
        Thu, 29 Jan 2026 06:08:48 -0800 (PST)
X-Received: by 2002:a05:600c:b8a:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-48069c7586amr115691455e9.33.1769695727626;
        Thu, 29 Jan 2026 06:08:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm213363445e9.4.2026.01.29.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:08:47 -0800 (PST)
Message-ID: <b0d6887f-7946-46b6-986a-bf410b832d66@redhat.com>
Date: Thu, 29 Jan 2026 15:08:46 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-next-2026-01-29
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20260129110136.176980-39-johannes@sipsolutions.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260129110136.176980-39-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31328-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4852EB0BCB
X-Rspamd-Action: no action

On 1/29/26 11:58 AM, Johannes Berg wrote:
> Here's another set of changes for net-next. Two things to note:
> 
>  1) This introduces a couple of new sparse warnings, because it
>     cannot deal with guard(spinlock_bh)() which the drivers are
>     now using. I previously fixed sparse for that for RCU, but
>     given the context tracking work will remove this validation
>     from sparse entirely, I haven't bothered trying to keep up.
> 
>  2) There's a core SDIO patch in here, but that's intentional
>     and we agreed with the maintainer to merge it through this
>     tree since only two wireless changes depend on it.
> 
> Please pull and let us know if there's any problem.
The CI also report a 32bit build failure, but with a dangling link to
the actual build results:

https://patchwork.kernel.org/project/netdevbpf/patch/20260129110136.176980-39-johannes@sipsolutions.net/

so it could be a CI flake, but could you please have a look?

/P


