Return-Path: <linux-wireless+bounces-34102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NgT4Lkayx2lhawUAu9opvQ
	(envelope-from <linux-wireless+bounces-34102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 11:49:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3434E1BE
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B02F9300E72A
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D66375AC0;
	Sat, 28 Mar 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X4tsg6zl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B035A3B3
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774694979; cv=none; b=Cam30gnDxbLecSnkvgfURWQ3RuYDKOIBzwoxiIKw5PlxB25D7Sy7GEYtQX8sBSy4n/eMpfFIF85lcsJmmfqegwK6gonM1ABJooCYm4IfKrR5kYen5xPxYXIQFjfqmuSDSW1AwJnlD+C7eXBYEvtyBSFiXmP5TRMYGWO+p9Pckqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774694979; c=relaxed/simple;
	bh=nXo+Z+t9wD8qwriLJvFbxust4+WxxaBdyAGEtQ8SmBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icynaxnzNmVXjV34w1oU2tOtY6HLQvrBQx83G3hXDb/zBb7A4wQ6IOLjMiQjGY0pn8mxl+3Y9wM6a0Ovnw5uNdiYoIVbpyu+dOGR/N6pTkEgmBSOKJQtPhR4Uxz6v0T8vSUZHzCkyyZirlye1jbzylfgMDftsrPlG5igdugi2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X4tsg6zl; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so3264058d50.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 03:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774694978; x=1775299778;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CM66K7bh3C7YvdRkvpH9zwWt4HmV/zowprJjLCrPEpw=;
        b=FrYInRHdXxqFoanpJ/EZy4/ZB06S7H5lQVf0fz6ELNBJBzbcWUvdSgWxl2FYgyE4RU
         xmfni80WelRU+opS+/A6yrnNqtwG1WV+k0LhQFzx5PzRpQDKe5AuwENvuOFngIVVA5JH
         bWCAyQhZKrEKIyk7oF1KSpuh5ozA9JWS8F7GQLzb0B4aHI/2qkqgB+8HStURQtOec4dr
         cg/jhbGBFOy1Rwn0yIIm3uGP0cInKkTe+27R5K89QNcmTqwhuibGYjwwtr/XQwvMss/m
         p/7gdSpHiTxbop45TfG+BFtxQwJ9hOo8dcNTIo1aVK1OGnJBAdmxqc34fKl19xpsU7s4
         QtOQ==
X-Gm-Message-State: AOJu0YzjBpydX0Grga7c+xwLc4TthGm+1DpbrWq9IA2p1RslUOwVEJf1
	ZrafNALjSZrQ2KFCe+mkBu3ztns9sb3DbWdNhzsdFl3xjOtMPaTqIf6BWnBYQgiN3J/kiVZstom
	5cx21v1Rxuavg07CX7BckpwRqDudn10EbOp6cM2e5Jb03IRyts8/TuUt3pu3cEeOXxh6a+GwqVB
	CxlR/fUGXt6UQAaJnUVRP4v7KOTwTt+WBAtrKt/SnLAuTshcetV2jcrLhXzd2rRTWzTyB8zDgw9
	vHq2+s9cIp+W0L3drK91sLTfsXW
X-Gm-Gg: ATEYQzxM6iwK7USXwjkRVLfLSPjiZBoQHUfS3LjzNX3xf48AQyYcmI+IEJ0qYT05TlE
	gnvFQvUS39E3ChtCr5rL15QwKhCXcIbpkOKyKvPKOOV1BgecBVLyP6QIgC4T/hi7ABKne7vDiVc
	Lu5/SNMgcSThYa5Tm8g0TCQ2f89BOerKYGzSNvwe9P6vOVb4ps5C2sHg0ZjZLavxDiScBxSFL4t
	dbNMMZ5UJTxTFdyTVxWz+YDsTp0egQ7bAzOqedKb1B/EcybuM4BZ6UzTLxZTGr0uSgF0aMS85HN
	ZOzgMH8oSunmymMdocGz77ceXW4H4J9tC1tuEE8efNMemH7K8g9owH1bgKT02TYSWqsLtTksp/7
	fIuLULs5fIiDaLYLOxH7LPQWOxTRBfzbyYQtJurBEyZphqOfti/xL3YtKHUCKTH+YZka2pmJl5E
	2wSKuZ4Z8I9wgbdxK1sd6H3p44S2ga8zCkNsRA/fY8qqI2qwm1O99DT9ET9kVd
X-Received: by 2002:a05:690e:4411:b0:64e:9cf7:95a5 with SMTP id 956f58d0204a3-64ff73d9de4mr3944216d50.44.1774694977562;
        Sat, 28 Mar 2026 03:49:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-650093223e1sm214305d50.8.2026.03.28.03.49.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:49:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b97fb810dddso362099466b.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774694975; x=1775299775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CM66K7bh3C7YvdRkvpH9zwWt4HmV/zowprJjLCrPEpw=;
        b=X4tsg6zlHKXIeNxjfKio+IlIh1mAeG0nP2aW5muzVqytIezvGjRmWH/R0jubPYy07C
         1XKiJzXw8+AHJK+idiq9UqZgmqwZrJIRyLw7eVjvLl9NhaHuhLIiRObBzYGzA8Bj4H6V
         7wcPM6E7QbLJ9d0I09h1u2Mh0l80b4UGZz12M=
X-Received: by 2002:a17:907:3f23:b0:b98:d58:f75e with SMTP id a640c23a62f3a-b9b502ff9damr346053966b.2.1774694974808;
        Sat, 28 Mar 2026 03:49:34 -0700 (PDT)
X-Received: by 2002:a17:907:3f23:b0:b98:d58:f75e with SMTP id a640c23a62f3a-b9b502ff9damr346053066b.2.1774694974172;
        Sat, 28 Mar 2026 03:49:34 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1dda44sm62951266b.43.2026.03.28.03.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:49:33 -0700 (PDT)
Message-ID: <c70c306d-a606-42d3-b2f8-7440c34b5f25@broadcom.com>
Date: Sat, 28 Mar 2026 11:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 wireless-next] wifi: brcmsmac: use FAM for debug code
To: Rosen Penev <rosenp@gmail.com>, Julian Calaby <julian.calaby@gmail.com>
Cc: linux-wireless@vger.kernel.org,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211@lists.linux.dev>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211-dev-list.pdl@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260309215907.5789-1-rosenp@gmail.com>
 <CAGRGNgUsVxecZobcXvVwmaHD+QHmzp4qTPGSLOpJb6Uinrpa+w@mail.gmail.com>
 <CAKxU2N_i3d2Bkx-35k7COtQ15UATVJja9wrHb8Pp8x9gDnpnBA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAKxU2N_i3d2Bkx-35k7COtQ15UATVJja9wrHb8Pp8x9gDnpnBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34102-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17E3434E1BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/03/2026 02:47, Rosen Penev wrote:
> On Mon, Mar 9, 2026 at 6:11 PM Julian Calaby <julian.calaby@gmail.com> wrote:
>>
>> Hi Arend,
>>
>> On Tue, Mar 10, 2026 at 8:59 AM Rosen Penev <rosenp@gmail.com> wrote:
>>>
>>> Debug code requires a separate allocation to duplicate a string. A FAM
>>> allows properly sized allocation with a single kfree.
>>
>> Sorry Rosen for hijacking your patch here.
>>
>> With these changes, does allocating and copying the string really need
>> to be behind a DEBUG ifdef?
> I don't know. I didn't write this code.

Thanks, Rosen

I did before the concept of FAM landed in the kernel. Whether or not the 
#ifdef DEBUG is warranted is simply a choice. I prefer to have clean 
separation of functionality and the related data. If the code using the 
data is all conditional under DEBUG define then the data must be as well.

I understand that FAM and compiler support for it has its advantages, 
but this is more churn than gain. The code is functional as is and 
removing #defines for the sake of changing to a FAM seems not justified 
for the advantages which in my opinion are pretty limited in this 
particular case.

Regards,
Arend

