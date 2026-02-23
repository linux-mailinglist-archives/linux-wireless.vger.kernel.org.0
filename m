Return-Path: <linux-wireless+bounces-32115-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCnyGn1WnGkAEQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32115-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 14:30:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A881C176F08
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 14:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A411C30A92C9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3445619E968;
	Mon, 23 Feb 2026 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="oaqGLV+a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E902EB0F
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853118; cv=none; b=eNMRPydkQ5hqEcJI07j7egtwdwnZj9LIhzgLt7ovHdSjM6ZiMIVjSeOdRqOTScvzEpRQ4RXSKmw616Kit2AkbN4j0SDzx6HFo80R42oDrfUtgY40QDBe0C25338MVyR+Eca8YhbzfQ2VwZTqz4ttre+Q6rhDlAZ/hcXH9dO0ZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853118; c=relaxed/simple;
	bh=x5b5GdlBz7ZP4j6XgbcyuwjB9y+K/l+7YbkxuGH5zT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCqKDE46u6IKLEFmZ0ZmSnpQ4nt6P1RnRJqTy/DSVxjEcnPI0elIQOICtfNKnUwj1RAXq/gQUKaqLfQe+a4X9LHkkTh65HmLw0tAGNj19Ke24QT7nHQm3oXw+uctHsbQwskC3wLadSR2dddDUYUwUZzWTLkN3yywXU32PPhn3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=oaqGLV+a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso37992745e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 05:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1771853114; x=1772457914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhgPtSKvvH0BtOgniDJJQiwa1GUS9k1x0tODyAyTIRs=;
        b=oaqGLV+aybnD78LmiR9pNkNypiy/slvyJwJK3z7fh/c7a9C/e5+/So/Yr5sc/fhiCK
         2Xj4s46v68rNdONI9F+aMOD1n+0csxnbVMYB+PoyR53zt/V60kn18Rzkjdsp+UDffDp/
         ve4ZQ5pqomROtE3JGef5el9Fmp1B3GPVtmp6UDRRQBcVl6fqWJ5xOmtj7goX3UgHg6cN
         isIl+BxWooQfAysH+PlgtfXYrmCnOXuLVl4LVGR17Ht/dR+ZEdhwPYGGXbXc8LUJ01wl
         uAVRhILHNhOM87ORs7SnX6e5A73vOX4nAvkdtL0BcHsUnVxkVAZ+6QQl1ate96a0j/LM
         A/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771853114; x=1772457914;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhgPtSKvvH0BtOgniDJJQiwa1GUS9k1x0tODyAyTIRs=;
        b=Kxu6PuZdriuk3YV8g2MP6XEd7L2+rO1N5rZK0rSVYzEPKxyfKlWQDYxq52SBXkJ/18
         CbbYq4VsekzrY/kHXCopnNCN+pv4Z6iXrsHRtgI9QDWNCvymn8t/z7DnMI2Tf+mUFgoB
         b3P1KKJuZcvBwpUduy7agjFkiZ/RX/CQil4OYnrDuOfww08SqHAVplA9LIPynngEKJ8s
         aZI+FjjX3h5KhW9FsTi0VxdreimSN78dpbCRWMfPY4QMXEO4scje3NukrcSu/WKnf9OE
         Eda83rP2Z2W2PcnnFcSCLeuoCJfamfwOj8lCiJbUPKYfy2DGtIbJTC9hHYEUozIzGgH+
         r2bA==
X-Gm-Message-State: AOJu0Yw+hBLLoEHbTjB7ahfH1Ak8H+yXkuaMvLERd/20nvrBQT6qJkts
	vknWZ/AsZ/a04ZhswHr3bgfvhI0bdddutfcQ5x1GShtqmbj224bh8mc/KWjyENQJQbU=
X-Gm-Gg: AZuq6aKUMqsbDBSVVflXxmj6ajJyPkgGRh31M9F6XXwjWA4RykQOVrzuZ2DWvzGF0JL
	5pABm4rGBQ0SBWiGgfwCzo8qoxDy5+Nxy1KXjNuOWEGwi6EQaqR/NPTGetgQueKTpimDu7FkGJ5
	5qmxASz0CyuyrIDqy7zB8EyYxl+Mn6li1W4yyJ+3X0mPTy3wccZ0xYCo3aLeJz9nNAOrTIzJwhV
	NgXWeebQyuyAla6mNTcn16kniWbzHRqdKXTyFggB+I+Nrb5HSQmOEiRzAE/BIdfDNRkEQrrbm8G
	jfiAaYfiORifM0UipusaGMQPq7wL9ydQz4QRwMXEEqwtG/XHJPH2fGECCikNtSGRNLZO3RdTqri
	wOwJYbrNnoDZ+B6ujO2VXQ4jniTv16C+5HOIT8VwJSvmzoi3iApZfSlFVad23A+e8lvl+gqK0vR
	jy26c+j5km9HUFSKUr0T3OGlm0ChfYVyE5+Lva2vdWT2MuWf6YmMaMOw==
X-Received: by 2002:a05:600c:1e0f:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-483afea0266mr66276395e9.19.1771853113882;
        Mon, 23 Feb 2026 05:25:13 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31efe02sm287963955e9.10.2026.02.23.05.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 05:25:13 -0800 (PST)
Message-ID: <19061b55-a211-4448-8c49-ca8daa6d9d61@freebox.fr>
Date: Mon, 23 Feb 2026 14:25:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
To: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
 <aZRnlPA_uY9uWuKr@pilgrim>
 <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
 <aZR9eQlhy55iD6IN@pilgrim>
 <6ed3a0ee5e15c73f304050d303e74441cdf61659.camel@sipsolutions.net>
 <aZsmk0lUpL0UBd6Q@pilgrim>
 <0f0703e2749185f9a334b3435ffe247b42e6923b.camel@sipsolutions.net>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <0f0703e2749185f9a334b3435ffe247b42e6923b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-32115-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A881C176F08
X-Rspamd-Action: no action

Hello,

On 23/02/2026 12:50, Johannes Berg wrote:
> On Sun, 2026-02-22 at 17:06 +0100, Remi Pommarel wrote:
>>>> That does make sense. However, if I understand correctly, it means that
>>>> even if we end up storing the timeout for drivers that support
>>>> reordering, a new IEEE80211_AMPDU_RX_UPDATE should still be introduced,
>>>> right?
>>>
>>> I guess in order to do a no-op update that doesn't change the timeout,
>>> we could? But not sure it's all worth it?
>>
>> I was going to say it would not be a no-op for a buf_size update but,
>> if I understand correctly, even when SUPPORTS_REORDERING_BUFFER is not
>> set the buf_size update is ignored completely and the reorder_buf is
>> not resized yet a successful addba response is sent. Don't we need to
>> check for buf_size change as well as timeout also?
> 
> I was going to say that I thought buf_size is not allowed to change, but
> (re)reading the spec doesn't seem to bear that out.
For once, the standard (802.11-2024) is really clear on this (10.25.2):

A block ack agreement may be modified by the originator by sending an
ADDBA Request frame (see 11.5.2, except that MLME-ADDBA primitives are
not used by the originator). All parameters of the agreement may be
modified except for the TID. If the request is not successful, the
existing agreement is not modified. If the request is successful, the
behavior is as if a DELBA frame for the block ack agreement had been
transmitted by the originator and received by the recipient immediately
prior to the ADDBA Request frame.
> 
> I guess we could just unconditionally reject any updates. I'm not sure
> now why we ever added the update in the first place. Perhaps some
> implementation was doing no-op updates and failing on negative
> responses?
> 
If the originator is compliant and trying to update, unconditionally
rejecing any update shouldn't have any side-effects. But if the
originator doesn't receive the ADDBA response, it is going to resend an
ADDBA request; for the originator, it is just a retry, but for the
recipient it's an update, so the originator is going to receive a non
success. And unless the originator sends a DELBA "by default" at some
point, it won't be able to create a new BA (for a given TID) with the
recipient.
[...]
> johannes
Pablo MG

