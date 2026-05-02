Return-Path: <linux-wireless+bounces-35766-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iuSCJeyk9WnINgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35766-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 09:17:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A74B1425
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 09:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E7EF300463F
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D41F5437;
	Sat,  2 May 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkQNOe/p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63754652
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777706217; cv=none; b=cBAWy5zAPfngId/0KXIBUEzu74ZCZ578Pq8BbEogfdlnrGoM5LDS+wpNbVtkJ+k8f4KnEjUuwxtDSvmzqb97RvoQAqrnLs9kpbobcvkhkPSDlHpipXZciYwq9HYmovtmsS8mBhuaZu2Hc5V/jryMG23yibwhHywCgSerDb3Upus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777706217; c=relaxed/simple;
	bh=aDajypdu9PyLO1370JhuPukE/6s/2WYTfzhB2f5BvNA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bxiT/draTwooLJ07nqnrlHiwT3QjK3QddezZsQHne7K1jJc8Bv41RAvbGdTMR+EWmEHOYoN6v5HTCV2B5809RqsjxuGkICV+iZJc4Bl8NRiXIGw0ixww9+CWVGSb8PUzK7JryYUlNq4WuoRVcS+Bjk5ZtuTI1bACHwJJlBwU9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkQNOe/p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so40376625e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 00:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777706214; x=1778311014; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBDcfPK1AgZLUELHYdbZHtr673QegAZdp61XoieXnLk=;
        b=ZkQNOe/pYya5YiLW2xe32F3kTlv1WocTxURkif+IH7WzXcafuWnCerLMvNEdVWZIvW
         MzopiUWz308f+6cL9pT/cAI2U6qD4voLxc9NYjzzowpmI6Gz8gAykdmj5TggIWF8qYnw
         AVan8bou12mSL4UT+tOscGMc+mLnsOGSfbZofHfpQH4t7FZH3uNAItmU2bZmjp/JcNiW
         0jWS/h5WO6KBUWDCBtgKMJMyxVC5H7P++0ddw/jTdD0XFoe0BqPr5t94Ghr3nlNIewI5
         o7BcRHyZ7UA35DEZKrQ20HqPXrRi9rRF5MR1QjE0PApPgeazrmZgiB4KsAbQDbSnmKxK
         rr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777706214; x=1778311014;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBDcfPK1AgZLUELHYdbZHtr673QegAZdp61XoieXnLk=;
        b=KqmYwnkdxRshsiQ4YL0qttxJ4ZfIbl7VHV12eFsPB8WrLthiFsd0bv/qfcBndqboFW
         6pktpp3Ken5P/ZQymATmZl7BfCXcdzEjkD+O+LUXv+EFXPMvab5fu/qQN4uAhC9di44l
         nTZKyDw+EK24yRkY5uDKmB+p/GLf2x4HLzyvKiRzXJGghC0sjccWxm6zFWZScrlgVNxC
         mfe+4Rl8gANGCUcDW95B2IngLTZ0+Mk1wYaacVB5XJaurUmptA4SK4KmIKVlUlc3HQCC
         +P5KcydMFmk7NWlY4RNt/bxQyXi9Iyeg37a3sMIKDf1Y0InyT1slUpXtVWeUa8MZ4Cap
         6b0A==
X-Gm-Message-State: AOJu0YwWDKWH9j3IIXCyV19vgu2WbOODzXzdoLS7XPL4KnzvEdM7FnTI
	UZSeOtIa0UuzWuEiW55nzc8SkEHvfOINGIvhA7V0lQKa/5AqEIdZITf8V+xjkg==
X-Gm-Gg: AeBDievuP+n/voHi5pcxRerdWxENcuNjX9SUBGQViG5Jx1XDdGQpXHbLGUiGdQgXZGd
	X6IDNZ9uRlSVcUZ8tW8KYdvGENBVqJVHjJbNn0y0b/gfCxElt05QzfOFQ7TEz8TQLUlctSMKuNn
	EMDZ0XiUQ+LZVpQxkMwMWZzxcdI0nU02mWBT1bEE4IpavhrCkHqsmAUZMgjovzPPFN5lWBKf3fx
	FV/D0HpiMok5DUHvxZAuV8Oxtzv4RGhzXXAp/LH/PXFiFR+aX/nmlmKXG24k3pwCE8ISML20WZd
	xzgQB2S4XKE9n9sos7sif5XjK/qk9pkmDx8QaX/yBQh8nPm+P/NsIHD119YxyjbYe77qswTsGpH
	iFSqiCMZ4BAR44CI/JqM0addgmh+qMXul95aXktq9crxIVf3aBan1Ur5+6xbnZJFkpwpDWEI3To
	VCrkU0RdHx1DQS48dmPy+D7TIFtGodaSEYidg/fkLTIdHdj+ZX4WAi
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48a9852f471mr30262875e9.2.1777706214230;
        Sat, 02 May 2026 00:16:54 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b76eddsm9164249f8f.34.2026.05.02.00.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 00:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 May 2026 09:16:53 +0200
Message-Id: <DI809CEB7FV7.1M00IPJ3VSQIL@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath 0/2] fix leaks in some WMI error path
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260424144813.1708214-1-nico.escande@gmail.com>
 <67aba8de-9a4e-46bd-936a-688abdb5d01e@oss.qualcomm.com>
In-Reply-To: <67aba8de-9a4e-46bd-936a-688abdb5d01e@oss.qualcomm.com>
X-Rspamd-Queue-Id: E67A74B1425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35766-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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

On Thu Apr 30, 2026 at 11:54 PM CEST, Jeff Johnson wrote:
> On 4/24/2026 7:48 AM, Nicolas Escande wrote:
>> So this is similar work to what has been posted here [0] for ath12k.
>>=20
>> When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
>> explicitly checking the return value we fail to free the allocated skb.
>>=20
>> This has been split into 2 patches per Jeff's guidance to hopefully
>> ease the backporting process.
>>=20
>> [0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico=
.escande@gmail.com/
>>=20
>> Nicolas Escande (2):
>>   wifi: ath11k: fix leak in error path of some WOW related WMI commands
>>   wifi: ath11k: fix error path leaks in some WMI calls
>>=20
>>  drivers/net/wireless/ath/ath11k/wmi.c | 131 ++++++++++++++++++++++----
>>  1 file changed, 112 insertions(+), 19 deletions(-)
>>=20
>
> Please repost and include the ath11k list

Ha yes sorry about that. Got betrayed by my shell history.

