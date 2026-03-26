Return-Path: <linux-wireless+bounces-34002-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHrhDklsxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-34002-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:26:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF01B3391FB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FDF63048B3E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC3405ADB;
	Thu, 26 Mar 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhFaZXFj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj7CkIEb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF54344D8D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545877; cv=none; b=fR9589j70y69WprNAkvvpnX9kJfsGQNqF97BajdmZH6KkU/U7fiTsbbkYwC1oSXOF4u53wBMg/NgQCbnEWZFany3ILPuARUVMen1qSi1hdBUEZOPoJbjZ0XrccFuHcBOzce5SRJxHB1HkXkKCymUUbmf6a47HoMiAyW61pHAH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545877; c=relaxed/simple;
	bh=6lh/9+lWOd4MRDZPa3R2rHb2mYK4OVHfg1BwksGxMQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN/T4TAWfhOt9tMhUWCmHco0Vc8MGhl1WBh7CDkQQyXOV+fFtz5fMmBkgxmpTB00kUTfG13hA1fHtZtpHOGvpgSWioXF/O+hqlMIrXPYGPds0F/tiDPBCC69EeVIo/C79zL48OTF8BjgcQDm0H3Gbpegd9XpnwWjiBVF0WmTFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhFaZXFj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nj7CkIEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774545873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/AKPcQGH4Dz/y9/znL7t7+7nhoF5QyraNsyrc/eBwY=;
	b=XhFaZXFjTw3QdP0uSA42oOT856JOJJefoJ06CZXqFb6FakzS36z1uPbCCQKGhyszakcW9U
	d0wkNWD4ZJL0d6UfWVZoWp8HCd0CWnHOmzNGcVcxlLY4WDVWZ4u+lP8DbbyUnabM9tEuHv
	j1heoeuUH8dV2FvX76ExbkNNoCnR8HY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-d48KQlgrOFedoJa_NAVjrA-1; Thu, 26 Mar 2026 13:24:28 -0400
X-MC-Unique: d48KQlgrOFedoJa_NAVjrA-1
X-Mimecast-MFC-AGG-ID: d48KQlgrOFedoJa_NAVjrA_1774545868
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439bab2d095so841830f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774545867; x=1775150667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/AKPcQGH4Dz/y9/znL7t7+7nhoF5QyraNsyrc/eBwY=;
        b=Nj7CkIEb3B3YRZzu5mUwfOwBTAb2pInYqMs7k5iPUvpz0ZUMsI/i6eiScC8EdJeOKk
         m+RQiTbrD6tyA4Ra8NPI6lFKBH9d8mgqKMI7rJ7Cfv+wDYTXjgFEM3w1/WsDgLeFH1Rk
         5JdlMcuTA+nXRSfSjDMoKjiA70SfDgKA3ALoAmpSP+50fC0R3OYjl0DcrHzRFdOmxFQi
         rfl1UsozYVwIGTR8A6XX5Aw1cSqu8UBzA0Zz4dCXgc7ADQJ3jEelooUdlQDyVwP8PI7L
         h/svM0j1D/rn+xb07WBhk8qPPMnTcKpmjxrY2XHHmdHkliLgmgb6m2MD2tpiOfC8d+PH
         +WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545867; x=1775150667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/AKPcQGH4Dz/y9/znL7t7+7nhoF5QyraNsyrc/eBwY=;
        b=GQy80XPD7ahjivQ36uaqg4ujc7N3KJb9uS8ruBfD0+m+eZWwE8B7SRz6VUP8UOLuwG
         +k5/HT2usB0b7HY5bKJrt+iOPsWEWqzO2Ih4tF36RNzHqTyer0RNMBA7a6GQZUUE3X15
         0LZzUK45F/h0Rx/JrpIdNdQOWE0d3ye10hJr6Vfxqcuwjr2lrWUy4tFGZcD8APpDCH63
         GeggSTf69fJ8O3hJe1CgAnHLmI3mgexHYDYxEE7X4lwkUlaUS3GesSrr7qxaiHSUaCx7
         P21ER+sAr9OsvrqZJr63Kx4MW7K8LgQAqC1IzqLlUz5oKz3n9ITsUcf9E4mSzNkgLnZE
         JdKA==
X-Gm-Message-State: AOJu0YzepOF5cy62mikYEggXrOB5lZtoMoLqHdF+n0Q3sWhvpH5tT7RQ
	9nWm/xW/tWuSBhirchIgyb9nrf7SW5cVVn/U2txS0AjEpQWMxNGd9maxvRq8kakEDsBRBEXoP0O
	/8EEaeyJ0QuoBqfdnkxeora7T9rlFevr9RJHk2lNTHw8WxFTMFAMQ3smWfE+nsaXs6lD1
X-Gm-Gg: ATEYQzyD3xKPFCOxrUI5s14dKgrrW5Pzq1koJIAtTdxlIukQeIBWFVRT2xjZiK6RQdR
	83iLazgPzBoqt8XIxsiiINciueSlOEuLZeQkijKhs6mrl1NDOVHew/SaZtjxStIIeqGkX1lUd80
	0tmZ+mfixw3UZ80NqmEj3AE5oAIVKwneWLi6bhmZI3pcWOixeMI1sTkgMZUGN18t9bwKhHRLfPB
	QIM7utG1HWoCR1KcHGLBdt7+B5UI07JKNeEkcMiANPCDzGLWG/eG8Sda5eEzTyPrc+hpWsNQt+A
	yV7wcYaWpmpkujk2O/4iKT/vidHrEYC2UeUEvE0bqr1O/tzxILEc+GYnxuf5gUGXYoWOQa4reu3
	ayvTqC8j0OrGVa7YzfX2cHPWNV1xGUssoMe//uv9xqe19mzixBc5My7p9
X-Received: by 2002:a05:600c:c4ab:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48716039ce7mr128858085e9.21.1774545867515;
        Thu, 26 Mar 2026 10:24:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c4ab:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48716039ce7mr128857695e9.21.1774545867097;
        Thu, 26 Mar 2026 10:24:27 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720937962sm18401415e9.32.2026.03.26.10.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:24:26 -0700 (PDT)
Message-ID: <936e4100-5e3e-4c3a-8598-6724d904deac@redhat.com>
Date: Thu, 26 Mar 2026 18:24:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2026-03-26
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20260326093329.77815-3-johannes@sipsolutions.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326093329.77815-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-34002-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: CF01B3391FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 10:31 AM, Johannes Berg wrote:
> And ... more fixes from drivers came in, notably iwlwifi with
> a bunch of things (their maintainer had been on vacation).
> 
> I'm going to be on vacation next week, but I'm also not aware
> of anything missing from drivers etc. right now, so we'll see.
> I doubt this is the _last_ pull request for 7.0, but I think
> not much more will come in.
> 
> Please pull and let us know if there's any problem.

Blame on me, I left this one out of my bag, and it missed today net PR
for Linus.

/P


