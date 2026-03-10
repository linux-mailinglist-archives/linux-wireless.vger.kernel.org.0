Return-Path: <linux-wireless+bounces-32826-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AqIOevyr2nkdAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32826-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:31:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE14249672
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE8F309B096
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2BA34B197;
	Tue, 10 Mar 2026 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaV6MoF8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561E36F41B
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138665; cv=none; b=J7PvXCDtknVpTRH0IJ19N/Vze5TcvUyN8J7ChpG423RTd/bTuCnJZMLV55qqZYy7iN9+7Gdp+d0QNPesgIVIyoIFxMYRUwngZGCz5UdN1xcis5S9ibWuJu/zI7PFEdoU41WwebUMkkZVLuSeNCaYZFUoZvCzGXErGM6z11Nl8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138665; c=relaxed/simple;
	bh=c8+5bTHAmDCDNbzeY6kIh785Qx68vKvA2Xic7R0bUpM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RFtESTcqpe6Xb9biP8MyBt2J+ag4zrv8XXlQTxz4ARWmCN4GJG9r0VJNDUGURauJhF6WbicFxxacc0K2VrzivPGhDtl2wCmcRMe65efxkSGkwIp1xQjp866MDESSPWe7u66NWv1n2TgmdMuPbqYdqqqo+BRS3YRVW8VmH6b6j3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaV6MoF8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso4701137f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 03:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138661; x=1773743461; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yw5OkrKLTUYeiy5PocG1boVDdzf1yG7eS/+lqIiXJdA=;
        b=RaV6MoF8dhjYvtSk3xJHrA5kmdnAmKTfnpMq7rIfcrZgU9T4W9/SHtOS6H7cUFZHWR
         jBHpZbwNyxcm869tKCb/oO9vO4Lw4kmlMOo6op7+EgX4nwWafn8FknK2zK4qMTeuS8sW
         CA+kjd8OFOG8GnaJNdbzNr/WyQhLvPa9h7aaBn8AQf+aCph/RPWD5Gu38MLxsf9ISr8V
         b6NuENH8GHH++Tz2fgOe2rQHZ1JlXeopT7OA//xIrbA8Wi8P7TXa1PEzLiFikjqHOE/K
         qTznLNF5+kYT5q6tKhtVd+8bLNbTAXhFQVCRGm19SXOCTIW5w5cA1BmGciAsFzk/RP0D
         W3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138661; x=1773743461;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yw5OkrKLTUYeiy5PocG1boVDdzf1yG7eS/+lqIiXJdA=;
        b=LV4gLrhvmFwup4FtnSmq+wbEm4/v2PQIqykCLuTmDLYHhoeIFK8NQfYnX0xrni6U2n
         VSPgSYMpuomP/6S1CUJ1qPwWmSY2hT2VU4NMORctkD0Wy8uuolEC3fuFhWYEUe7vQzbO
         e99vTsK7zgC50tgQCQBQFO6DkYV9nuiobr949t1csSlcS4g93pWDzX43JMAwgtimdCM5
         8+TZqYYdsvlb08g8F7lWz0Nwzvn++x8j8Q/FjtwgKdYfQuQuYj4KUzcPNe+MUeL03gOY
         3+XpZ3vLigQr0rL0B4mTNvOSNJb4eOWCfBtfvaM9DfanLX1xITQKpbd1PVpNqtL2MAwx
         fKiQ==
X-Gm-Message-State: AOJu0YxIL1A41DqRLRrNkpdkuR+smdf7k1VgR5Jw5vQhJEseL7f0cXF+
	Vs03IzPusA+yP6eW6HOA2o9vKSiippPkPWLQ6Z4LafpDjzKL4PGH2ltm
X-Gm-Gg: ATEYQzwjmNXw0Hm0L13ew7shM9oTEx6Nur5zg3B99KI0bOawnCpH0khl4CUYC58LOKL
	+bqFPyJdQexoVMFZy6t1m2z+eHP4Ie/89+Lz1R90HZOQ8L3YELd0NHm+33aQRLo8LC2JrNUlYRC
	jfViHPPxbyAFrzCDGCJ/E45pY2eNiJ01AENB3orZzWESAGmEDqsdYij3GSFbW7qRgz4PxFg3u6m
	iVX8nB9whMlpkseXiopn+hiFpiE+wpzgXe8rQPzOtbA9F1pmbWqdFbMoIoDEhN8e3HCYf0BSTg3
	35s9tZKDt37Ech3Jj+x+10PWz/ZIiHSw7aDkKiJOkhlKfM7K380z62NZVahMtWvNmoUjvB81v0s
	QNIuki+0e4gZNxsy9j5dPR9w2V6p0Z1WN4/rkFnEtHakecZIkzFZ+E9f/f/KzVFzIM0e2eILHno
	ofHhw44nytSwc0p4E6BOfaU1+o2ZUEQ27CD5tCPSDqbT9LEoqprbwV
X-Received: by 2002:a05:6000:420b:b0:439:b6f7:7ed9 with SMTP id ffacd0b85a97d-439da64f7edmr23080562f8f.10.1773138660855;
        Tue, 10 Mar 2026 03:31:00 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae46353sm40544538f8f.33.2026.03.10.03.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 11:31:00 +0100
Message-Id: <DGZ17385SNYX.3149KUG92UUU1@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260309152050.191820-1-nico.escande@gmail.com>
 <04d268a7-8f6e-4aa4-b366-0dc38c355de7@oss.qualcomm.com>
In-Reply-To: <04d268a7-8f6e-4aa4-b366-0dc38c355de7@oss.qualcomm.com>
X-Rspamd-Queue-Id: 4EE14249672
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32826-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,213.36.7.13:received];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue Mar 10, 2026 at 3:05 AM CET, Baochen Qiang wrote:
[...]
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wirele=
ss/ath/ath12k/core.h
>> index 59c193b24764..ebe7b94fd712 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -19,6 +19,7 @@
>>  #include <linux/average.h>
>>  #include <linux/of.h>
>>  #include <linux/rhashtable.h>
>> +#include <linux/percpu.h>
>>  #include "qmi.h"
>>  #include "htc.h"
>>  #include "wmi.h"
>> @@ -937,6 +938,7 @@ struct ath12k_base {
>>  	struct device *dev;
>>  	struct ath12k_qmi qmi;
>>  	struct ath12k_wmi_base wmi_ab;
>> +	void __percpu *wmi_tb;
>
> any reason why my v1 suggestion is not considered?
>

I considered it but I for sure did not write enough about it in the changel=
og.
Sorry about that, see my thoughts bellow.

> instead of allocating it per device, how about making it global and defin=
e/allocate once
> when loading driver. This way we may save some memory in case where more =
than one devices
> get probed?

So what I did try first is to use DEFINE_PER_CPU() directly in wmi.c to hav=
e
this as a static array, directly in the compilation unit where it is used.
But this failled at runtime as the allocated size it too big and it would h=
ave
needed modifying the max alloc size that the module loader would allow.=20

My second option was to add something in the module_init so ath12k_wifi7_in=
it().
But as there is no ath12k 'global' struct, it meant adding a global variabl=
e to
hold the per cpu array, that would be alloced in wifi7/core.c and used in w=
mi.c.
And that felt weird too, the wifi version specific part of it at least.

So I stayed with the per ath12k_base, which as relatively low overhead for =
a
clean consistant interface.

But if you guys don't want it that way, I can rework it. Just tell me in mo=
re
details what you think is the right way and I can modify it.

Thanks

