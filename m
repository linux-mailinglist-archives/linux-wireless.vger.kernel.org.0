Return-Path: <linux-wireless+bounces-34317-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HSeC4ZJzmlRmgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34317-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 12:48:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC3387E7C
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 12:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9FF3308BC14
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 10:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5259F386556;
	Thu,  2 Apr 2026 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ5X6iUb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A8386C1C
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126841; cv=none; b=tzdY9YV88NIfX5TLzUYB4FiT9OPHKIh/yToHzr9KDIFRDduR8eSFNaRzAtw6KGRxaup8TzbRK+deJtPEXFe8xWtBXyrR/jS0ZRsJ9wjmv20mHppbApAFliH4UPxNQn1h8arwsilYHtkFnqQHrFBtN4aKqMepqIW+ArkeyQv7114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126841; c=relaxed/simple;
	bh=RhkLq/f8QfMS0eianUd8AmA9oZvvs0fkEBnq8nleweY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=plcycdGvKJ/6y4Pr7rTHzNtMSBXu/Jf835RkPT/fyW52rBblTydIUoYU+SAAvIjLTYyhlL7tNyGrq/Y8FG+3YVznQluJ1BlpoYjyW2U5ySeXfsRV80pgMkF158skJPbspauwuMdyI5wu/cxCrCCilnx2OUg8GxaE5ln43kG110A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ5X6iUb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48704db565eso7689785e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775126838; x=1775731638; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7weI9og6Q0lyNx60wu/+g5SxUcLYMdf+Jn1DbxQ90k=;
        b=fZ5X6iUbXsG8bsMvcSPgZJHfYSPD7F/9dhlWY9f6Kxf8Q+gBOvAgSwJxBc0CNhcaar
         euTn04gr7CgIu9k09abA4xQ9fg9JSkcAlvFJph1kH8cG5H3gV3cHpRb7Kn67vfY5jC8H
         NL7n19dn4C99NecP1Eo2B7+he0C8vGt8Sw0ruBIwYkGBj6bRK7hgOooLSb7CtYphrEJH
         Hk4RbzVFsIDXNWJ+YSkbYA7bEMmUHpJsFo1JLyWTTqq4armQ6AX/J3YykTuUXIkS/aU7
         xseXFNQMTW2P8ZGZ8CXb7lbswlNmZJ9YOZA0XDnM8eyxJtl0UPnIeyIXzWw/IFC/ILT3
         LR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126838; x=1775731638;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7weI9og6Q0lyNx60wu/+g5SxUcLYMdf+Jn1DbxQ90k=;
        b=lqr2WlkrhkjZvvVKTuqyv5+JntNWAAGupwZKj4HVh3X9f+KvAPXKcsW96XHaWN6kzf
         tVnakVmvYKlTQNsKZPoJOaU3p5WRfiiD2kGs7+zLTjuHyVdSJOoP42BfQ/gPnmxDBkiF
         TeC/nq9SMJBX02FO71xVC2v5hdU3/+neEccfJpcND/UocBJn8WaKcqLZ1Z1znno/7TVG
         MrrqCiRf/f6hMkjyVIY72MK6ETP7KvDoD/MYlEAC6MdzuhmR57rSfrMu4JsvYg4qE324
         FqmTpvkE+6LrPYgHb6a8whn5acK47tnVvoD6ONe7Y6g/ZhtEx6L+dsCSfnBxEUo3AEgJ
         fqKA==
X-Gm-Message-State: AOJu0YyAHIlw7vNXfhVx9Bvzu8Rt1PYL/ogMlMbcW1nEdqnQqUG3h3v+
	KP+LEw4UGk8D6vP417YH+eDS+C7uZ7epwJoXsyC8EUALdznXG6GUODRXb5gpjQ==
X-Gm-Gg: ATEYQzyWRavDdotURWXN2zCz9rjcs1z9RmIC1CPpCkQB1TNqVO1EVSNzbARxPNRh+IJ
	mlX0Shap4+SqKazRN9YRySvOHyMU47qlr2rD1Sicip+17R1ilgFNLsViIFV7HzMtpdH2sLDYuwH
	IiBtpiZieTdwOvw8tOPzUEOJ77qK1lA9Il3wdOxpzz+ajxbHAVldUjuWCzUNl2yDHFw3axsLVty
	GIKdCroaM3kGSaDiWt0KDtZnX61Cx4NoWggIVRthYx7FDJq4cT/56fsN+kXSrwmCpuL+hKrDGEg
	EzU9uqZLc5bq4uAhVEmBEunhuU7Tg7Z/UOkHQ6Yuq6ajj+o5FZuYELDP9NZXZBqt+LZyBE3tt77
	4zhOqJnGGS3y6/a8HxZY1+GE/an/EmJUbzbg4qtmjJctreJLZatQnTJzg2havubp1l4LEahfILa
	684l6uAgSS9QqvHMGMJHTnzgvHKc7rzR1W1+SSqYyy2w==
X-Received: by 2002:a05:600c:83c8:b0:485:2c61:9457 with SMTP id 5b1f17b1804b1-4888b70fbaemr58487125e9.10.1775126838010;
        Thu, 02 Apr 2026 03:47:18 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c751158sm95037345e9.6.2026.04.02.03.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 03:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 12:47:17 +0200
Message-Id: <DHILY3AU5IF4.QIHK6RI52T93@gmail.com>
Subject: Re: [PATCH ath-next v5] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260330102434.13136-1-nico.escande@gmail.com>
 <b066de0a-71bc-4d03-8ce1-c6ff22eddda1@oss.qualcomm.com>
In-Reply-To: <b066de0a-71bc-4d03-8ce1-c6ff22eddda1@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34317-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0EC3387E7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 31, 2026 at 4:44 AM CEST, Baochen Qiang wrote:
[...]
>> @@ -11239,3 +11149,30 @@ int ath12k_wmi_send_mlo_link_set_active_cmd(str=
uct ath12k_base *ab,
>>  	dev_kfree_skb(skb);
>>  	return ret;
>>  }
>> +
>> +int ath12k_wmi_alloc(void)
>> +{
>> +	guard(mutex)(&ath12k_wmi_mutex);
>> +
>> +	if (!ath12k_wmi_tb)
>> +		ath12k_wmi_tb =3D __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
>> +					       __alignof__(void *));
>> +	if (!ath12k_wmi_tb)
>> +		return -ENOMEM;
>
> better move the second testing inside ?
>
> 	if (!ath12k_wmi_tb) {
> 		ath12k_wmi_tb =3D alloc();
> 		if (!ath12k_wmi_tb)
> 			return -ENOMEM;
> 	}

I tend to prefer not over indenting when I can avoid it but ok.

>
>> +
>> +	ath12k_wmi_refcount++;
>> +	return 0;
>> +}
>> +
>> +void ath12k_wmi_free(void)
>> +{
>> +	guard(mutex)(&ath12k_wmi_mutex);
>> +
>> +	if (!WARN_ON(ath12k_wmi_refcount - 1 < 0))
>
> better to use refcount_t and its APIs?

Indeed I'm not familiar with them but I'll look into it

>
>> +		ath12k_wmi_refcount--;
>> +
>> +	if (!ath12k_wmi_refcount) {
>> +		free_percpu(ath12k_wmi_tb);
>> +		ath12k_wmi_tb =3D NULL;
>> +	}
>> +}

