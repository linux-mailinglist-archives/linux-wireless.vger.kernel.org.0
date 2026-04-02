Return-Path: <linux-wireless+bounces-34316-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOihOXpIzmknmgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34316-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 12:44:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D8387D2E
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 12:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE048303012A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447243D47BA;
	Thu,  2 Apr 2026 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POfxDAr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47738759C
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126647; cv=none; b=RN/TlNLg2bkt7ZWEkulbRbJTe0CGrr5LfnpDBDd79mSXQ8juVfqr0sMzESoyj8BNZXSjWVXYo1jZKtH6HLWQKEkqt9QwSM+E06hC0IqN6EnKn63A/Q/M4T4C3DhjSjRHtcL9GZQ8bC7yZrHWnOq23mG4vYn5T/5/UADIsVKw53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126647; c=relaxed/simple;
	bh=Pn/DDMXtbbiEw0Gw3Wk+Xtj/U5oOPGlaly4VhK6n7/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CePefVpMahkjYosDhZOHHIbb1ZWw3fWuKwxrSrAmMOYPsx2n3G6mOzAIELZA5chPRcYKYElGZK6umMaEgvFPBpk+8+K+ynPScbCGIICyW+Z9tR9+5iiIJEi2kUJRdMjxzUzFp6MPataxQz1jn9Vb67m/NAPuiJh2K6sr+WyS57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POfxDAr2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so7389705e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775126644; x=1775731444; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WTteIQaztLkVZaaTIy+MnZsjCmlbwYzSyNcOxN/wuc=;
        b=POfxDAr2Rn7xbJIEVJRhEiObhaXISU9OjD5JSsHY3nrxKeKswqFn7K2cAXLXIia2Cy
         LjuZKa9mW8jXWakeVe/Yq7ZCWmSlE6oLkCwHGdU4aRZqh3XdQRMicuX4bUOUCUNHWfsO
         SFNgjm9vUuzGJnRafChiX60cg1ipqFWDuKmwxfVicfcKefRE9/nrS0vdBAYw1JNMaW0b
         eF8CNTGbMYRsgodczCm0jnKe7wkvs55vvXHSKyDWLokbcoknHVcA4ab/hsUlrIH5ir3X
         WBcJRg1Mojm+cO99HK8NFpFrIvf1HfKuc0IRpw8pogG52KIbvCZooqLGsPpNuKnzNz3g
         eXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126644; x=1775731444;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WTteIQaztLkVZaaTIy+MnZsjCmlbwYzSyNcOxN/wuc=;
        b=PC6jeUxpTvOuILUhgnz4EcEdY8yY7zWZ1dtvfawK71stXarbtxPAZAKbdUYqlzBR1M
         JXWzDtdFP+afRh0KCCbt1lR+zeuYcwvHO8DQnZNca4XUwBdbrpuMI6g2aSffxGpFjrUC
         Lf76WFYyN/ismHh4hgt8Ddg7KeGSCwNoVFdWsbRbS+7FfFAyzOA9P5x9sqn+Qsy0pECV
         dy9KHnzbR3lVNcvrzxtLOB6ztF57YyD4WAodJ2fVZPxW2HeJNvotkRo0Uy0ICQpb6ap8
         3wBSEb9vDPijCZYVWp4MBAmsetvecWQG1ML6DFZc6eoO4T5puefJCgjxT41Y7Dld5kiZ
         cmSw==
X-Gm-Message-State: AOJu0Yyr5yxsB1oLldw75su6YcQqFvDL6wbhF5uzRyRfZu9HtLh2Cf/d
	yXHvm4TIyOwDO6LxioxtK3LZtgnBzn2/Roa7nvstNHWMOL7LDK5aeOoO
X-Gm-Gg: ATEYQzwzorz+Rf3p5uY+9nDS95KhFSsgbD5AsQp9M03QJsksIlCpiVCtHxbMOAO1CQl
	AubrvvkFt59d5zBvxdnO172sBPZhRQ47QQ9/apeU/RDSXvfIM9yr58EgeWSFkBu/Rz1NTGpu/zL
	Bf57NITLeUXhYgmtfzO4xroFmVWE/Xz9xo0gnQxh5bbIowwSwDjeqIsxHHydAH1hWoaiAl4ekQ5
	nSD9BsIhUqiYI2wS8KO/wK9gZCqKip0K5dbD8Xp7+Ke4H9r1d9xZrDP12BNqJPQyPKtiHCNRuJN
	kT3uZzHLZt9ltlJ9N3ABI0RB3ZqPbZ4vRuVwxFMRGAhu0h+PZUTGQxVA5pqRj14GQeTp75fyz+B
	64/lfLSPipXm75hgp7fEhz2PioQqFYB2GgdccLyEEhH6gimJTUGvZXYV9TIq1e9z5sfrdMxG6X6
	8GVqUhEm1BTbzm27vS+zd/biMMleJB630mSl6hZ6Es0Q==
X-Received: by 2002:a05:600c:4f12:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-4888e0bfe43mr30484065e9.12.1775126643813;
        Thu, 02 Apr 2026 03:44:03 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc5690sm110565405e9.2.2026.04.02.03.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 03:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 12:44:02 +0200
Message-Id: <DHILVLV9Y722.2Q7ITX8PL4211@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next v5] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260330102434.13136-1-nico.escande@gmail.com>
 <a124d5d0-ef46-448b-b226-8642da61e0cd@oss.qualcomm.com>
In-Reply-To: <a124d5d0-ef46-448b-b226-8642da61e0cd@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34316-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873D8387D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 30, 2026 at 9:38 PM CEST, Jeff Johnson wrote:
> On 3/30/2026 3:24 AM, Nicolas Escande wrote:
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wirele=
ss/ath/ath12k/core.c
>> index c31c47fb5a73..76060d448920 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -2258,6 +2258,7 @@ void ath12k_core_free(struct ath12k_base *ab)
>>  	timer_delete_sync(&ab->rx_replenish_retry);
>>  	destroy_workqueue(ab->workqueue_aux);
>>  	destroy_workqueue(ab->workqueue);
>> +	ath12k_wmi_free();
>
> nit:
> the order of init is ab, wq, wq_aux, wmi
> the order of free should be reversed: wmi, wq_aux, wq, ab
> which matches the init error path
Sure, I kept it as revers xmas tree because it looks nicer and doesn't chan=
ge a
thing but lets keep it consistent no problem
>
>>  	kfree(ab);
>>  }
>> =20
>
> other than that, this looks good to me


