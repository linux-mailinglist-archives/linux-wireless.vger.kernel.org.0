Return-Path: <linux-wireless+bounces-37593-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TlY1AKEpKGpV/QIAu9opvQ
	(envelope-from <linux-wireless+bounces-37593-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:56:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 631A566166F
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:56:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RJTBrHAD;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37593-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37593-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B674C30534EB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908393546EC;
	Tue,  9 Jun 2026 14:48:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D28356751
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 14:48:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016523; cv=none; b=N9jU+QF4T4wttX3tPqTjAZh/p672UBxtsmD1e7BEhnNGzdDeK2qzGIp0janN2j+kpbhU4VczQjOtmAGDZ24XZCw9TzUX1iVUxfIfcqdKbhVJpmlRxTtONgRBHX3Pp9xqIZ/jt4HknIdE50Gxl4Bb0yckfJB5CcHnKQ2lSYxB8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016523; c=relaxed/simple;
	bh=91M7+RHOfJutGnS6ezebTu/LMAPUCMXCn4h7r5lGAtg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=r/P7zAVXvnC7Yq9tFvfqsI8AItA4Qh5I5Oe9PcyrAGYzq7eApR+lQRyipv5Dy9jVVcEsKkl/P0qLWYOJIrBxsm97bLedUGM0BGjtLcxtBbQBOw7GGiHvV4zl0GT3JjXo9H7uwmGPQAFg/AN2B/11ELe3a9+LdwTjVlaKOCkX78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RJTBrHAD; arc=none smtp.client-ip=74.125.224.100
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-660e9ea26b9so5781109d50.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016520; x=1781621320;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdgCBltfiFlh10Nms4T7wj3+rz/0jCZ0BoMlOBU5Q10=;
        b=gYFS4pm5hCGFU9VLzjDSHU802VkHqe/M+otDI0J7bd7oIuIJkVsmwYZ6dqQuD5rZkE
         q97NXaQuF/KjQZI4xqB0qb6V2QHoXUQjJUhs93ckeCMTX2cYeRjc1Me7LwmDSdYxtS6U
         iJepyBpxTMMz4rihOc2mklSl3oxkFE1yngdYYNjkRqSMxnsftb2XRW/MDg8G484qtE7/
         ePXJcTqTjjrETdpUSgX+G+gJJsGr+XfLJiv438TbvnDjBgJnX+s/nO4FwVqWukOxkCKG
         ipELKsSKbUqYMH0VxXQylgSwIq88X/2heJlz7a95x0jJrv3ao92M8c6vbN4UwJWuSLAO
         3OKw==
X-Forwarded-Encrypted: i=1; AFNElJ8dbbXAz0MrV0UotlDxXw9FdyGOO0v43an7wB0OUwULgwlPca+wiH6MdQ5qsWxc6lo320myvfkHzzZFUeGvCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MeZJ09TE0XL2wZfPUlqDesl/k5DshDBXWmB43sC8HbYGTC7a
	Opjz6DxW0f8oiZIWMX4jjO2LDr5PREFuqcX+R/vGU7Xep9+cM/WkjW/qrvX75ffFTmajKSmaPwR
	pD164/DX453Y2vWgRpZhYdbvb2AJtVFeSPJmuaC6K8xEhBm8CFQEGms7SwhRijtCWl4xZ/N6lPK
	+8m43OZtlpTnMkth7YsPfpGP4YD0QEscYBFJQ6hVrNVZ4a+h1OhxpTk8l9joRBcIKz/xAGqTOeL
	Q6QNMkWDI0owHbRJpF2fh9+J9mW
X-Gm-Gg: Acq92OGkdUpEjciE5X8x0Zw/oa5v454q6wmzaatMwiqUfIM2l+46ToGbgoUxuSueDqL
	CeIq0SrDa/rXTSK2zGXtlobkd0xeFQey/8jaHMBHAL699+ccNQbt7vxqXBD7wGJfpDuxWG0iZlp
	QDj0jJvUT8EomUz8IuTGmLRpvZ55+y1ytFc1jDC2VJBR8FWk3ZMfHeHOCoNA/U3vdWt56KYX5fN
	3q2EZYhT+sJP30XoQ+fz9G/JJ6t+YX3DwR72HzAIIzbcAhklGz4DwbFFdX3k0+g4pNCZ4drCK6r
	fWd646Veh12i4CBHnoEP3ztzPwjYuXqh3d9XSYFMAVzUIeWnBP1AfQqQtVSxDXczTPaoPI+1MWE
	qN3wsS9jlQyvhcJG/50lZn55DF8i2X0yHwT0rIhy9IGS/FasUHPLNY+G0tnGBTZe5EKEXhtMfX+
	DlH3HynbMv93CNbN1tqjUVOA01PdzF8aeZBF/cVaviIdfi5il+8gXOZLD6Nk/cmzZBuAKGKjZ96
	w==
X-Received: by 2002:a05:690e:440c:b0:660:57ad:a541 with SMTP id 956f58d0204a3-66106e382bdmr13130456d50.18.1781016519964;
        Tue, 09 Jun 2026 07:48:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-660d61ea17fsm1583141d50.15.2026.06.09.07.48.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:48:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-68b5941a81bso6292036a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781016518; x=1781621318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdgCBltfiFlh10Nms4T7wj3+rz/0jCZ0BoMlOBU5Q10=;
        b=RJTBrHAD27D5IXWZupJdngWivGlV0BWHMNKa+AntE4bzvoVvFjnCnyt7/C0Lw+lPg4
         cF9jdwAEfoFgRhV+Zf9I00zJb7vpAqP0MlE1qJo4mmRqMOnLnRBIqUBiMPEkGBUV2MZ4
         myEDGUgfSKxnMFsQtIgSXTCmU03gzAKNc6lrM=
X-Forwarded-Encrypted: i=1; AFNElJ+I/lBgfJOFBATjQ3ghYVe7d7VmX49OL1Z1hZ5QJ+lg6/J/ce9CyGhcmpxGqcGIH0/v2USp0ojTqhp9hqYTJQ==@vger.kernel.org
X-Received: by 2002:aa7:c041:0:b0:691:957a:bd61 with SMTP id 4fb4d7f45d1cf-691957abe39mr3347465a12.7.1781016518328;
        Tue, 09 Jun 2026 07:48:38 -0700 (PDT)
X-Received: by 2002:aa7:c041:0:b0:691:957a:bd61 with SMTP id 4fb4d7f45d1cf-691957abe39mr3347450a12.7.1781016517755;
        Tue, 09 Jun 2026 07:48:37 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65027662sm8944678a12.11.2026.06.09.07.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:48:37 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Rosen Penev <rosenp@gmail.com>, <linux-wireless@vger.kernel.org>
CC: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Date: Tue, 09 Jun 2026 16:48:36 +0200
Message-ID: <19eacdb55a0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20260608051102.6698-1-rosenp@gmail.com>
References: <20260608051102.6698-1-rosenp@gmail.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: flowring: simplify flow allocation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37593-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 631A566166F

Op 8 juni 2026 07:11:22 schreef Rosen Penev <rosenp@gmail.com>:

> Use a flexible array member and kzalloc_flex to combine allocations.
> Simplifies code slightly.
>
> Add __counted_by for extra runtime analysis.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
> .../wireless/broadcom/brcm80211/brcmfmac/flowring.c    | 10 ++--------
> .../wireless/broadcom/brcm80211/brcmfmac/flowring.h    |  2 +-
> 2 files changed, 3 insertions(+), 9 deletions(-)




