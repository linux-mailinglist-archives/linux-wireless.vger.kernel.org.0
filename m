Return-Path: <linux-wireless+bounces-32049-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEQ6OdgomGlqBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-32049-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:26:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D8166347
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 419153011060
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10558320A0C;
	Fri, 20 Feb 2026 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnsXXN6b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B70320A0B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579606; cv=none; b=SS8A06KR7O6JNh4E1NTrkUamH++a1U6CzzXZAUiOiFC9djdVslCPe7JsYjz5isPOBB9Zb9pzHTNMgpyhkSYOi72P37u+Ou1ar0eyPwuK1SDQpvB/hEVAjpz7OjmBmufAKOv8W/1oB5iF7bmHENTZ5dG8btBSEE4kRg0a2mHIimA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579606; c=relaxed/simple;
	bh=H2c9cut++S0ooLuRidjLDVhKVzcUPe5weI5mpOub1A8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ryFRnYS58x/u9I5xLuWQTXi88eqmClsS61imW6eFwMyy0KLb3ZYOJP4fxjziSbW2TJowkJBQhbhyA7bYKRm93pBfW1YA089yNyVpGQDXJDf+ZiBNs+3AjkbqWcngrEyxPes7QXPolmecYkZ7EZMuiIShsYaDiD0E0TGuMhhLXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnsXXN6b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837634de51so9148545e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771579603; x=1772184403; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2c9cut++S0ooLuRidjLDVhKVzcUPe5weI5mpOub1A8=;
        b=hnsXXN6bxIB3T1tQ8svokOww714nr1osqenQ7mOc62uaXxoPmXjsxmZ2unlxAHV1Pc
         TKZC98VeExzB6lGL+2p+tq+91rPYB6MJ6GwvQXZ/c4ZU7l35DfaakGMPbkiE6Pv7VwVH
         FgC1pjkjmpEjPaSC6z+hKK4B4wQ9EEfyUbLBngnBZ5qoeibYezjNw4Cdqyy2kPuQLj2c
         Hcwtnvxxa8PCoQV6dXt3G/HPMhvdKO54fu+HY5bkbrXBTD2ILHavdko5NV/nqrw8KFSi
         sMAs8wz+SYSMK73H07b+TF4dbLzUwxVGcNLJixxWwKfv6Uc4AXsLeOVLXh2taXsjEK55
         6pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579603; x=1772184403;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2c9cut++S0ooLuRidjLDVhKVzcUPe5weI5mpOub1A8=;
        b=LmoK2BdS+axNsJMZoD7BDg1+FLGtim6qtO+enKYYGjSaElKbYCBxrFQjE5APeAVUgS
         Ar7T4xlHQpoaOdbkgdCIBAkx0Xs5/anzxN2rgvDwShuq9d8xzbf13e9JjE0wqFCcMbwN
         waghzzLhBSpIVjYHrtTM+JsapXd9xa80CPTiFuGn6izuhOM0tFyn/slD0i0M2CuH0fpe
         qMpQ7FFVLE2Kho+c8c97xQHyyd71XAmiJRIw2Sw/27sH/IPMVkPb2IM6jTh5an6ST3Q3
         Vq4u+PD6PvkHrsgqxKn51XLk5gmYALslM0r1Lmq6m8iiEoOYEn4gvN996uwFtsdBWC8T
         97Zw==
X-Gm-Message-State: AOJu0YyXlowUt8iAzWb2EhC34YhlJZmKmd0lF7Ak9wGkIpKdWgS/q9ub
	6/bSjmrC7rJJvqtjuRJAy5ZZ7RiO3yvwGuRSb0wWhZ0g0zP2MDZBwOsD
X-Gm-Gg: AZuq6aLquG7obN6u/0FGMSQfnet/RctpZ5gbEisglSNO5M3RuGp6Cj+AMEEpjuKrX9p
	RTogI0zfnb0yn1Udyeu7juGqB4JA0i0cgZDyRrIwO7cyJB+V7944QfnVXoFz8KWQAUS6PFh7I9V
	oeZ85PSBHFVjPJSwIGpyeskea/045DBQQHlNHZGMuBsXPKi5dN117erGCEIKxWU87uAM+gfZtWP
	cJ3G86qmvRas3VLpdE/j+dUS7s0qelH98iGi7wKw6EseumckZwR5lYdbgf4SyS9vUUC3zSEMQIL
	0ra4iL8ZsihfoQTuRGd9VDs2D4j99LgtgPEarO7DTBA5uag5e8bobA3dRgA/aSCehOqafDrPAur
	WfsAdpq6P1GRSrAeEXw3GJUMOEA9JZ6KrzapeUa/frwUeKBOri+jXlZxULODSB4s5L2mB4UzY2b
	tiE5ExzXTuWv+ztVyUEkUfIYwRGbNYEb4zBlVmxgS5ug==
X-Received: by 2002:a05:600c:548e:b0:483:456a:5146 with SMTP id 5b1f17b1804b1-483a553babfmr18583515e9.25.1771579602631;
        Fri, 20 Feb 2026 01:26:42 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad015bsm56052805f8f.38.2026.02.20.01.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 01:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 10:26:41 +0100
Message-Id: <DGJOK1Q0O01C.9OQ68I9IBU41@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Aishwarya R"
 <aishwarya.r@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, "Maharaja Kennadyrajan"
 <maharaja.kennadyrajan@oss.qualcomm.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <DGITONL8L200.PJE38TDXYRQC@gmail.com>
 <017ec99b-693f-47e5-ac38-6c207a32eb62@oss.qualcomm.com>
In-Reply-To: <017ec99b-693f-47e5-ac38-6c207a32eb62@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32049-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 657D8166347
X-Rspamd-Action: no action

On Thu Feb 19, 2026 at 10:37 PM CET, Jeff Johnson wrote:
> On 2/19/2026 1:15 AM, Nicolas Escande wrote:
>> On Thu Feb 19, 2026 at 8:34 AM CET, Maharaja Kennadyrajan wrote:
>>> +ath12k-$(CONFIG_THERMAL) +=3D thermal.o
>>>
>>=20
>> I may be wrong but I do not see Kconfig changes that allows to actually =
build
>> the new files. Is this intended ?
>
> There is no configuration specifically for the driver -- it just follows
> whatever has been configured globally. So CONFIG_THERMAL would need to be
> enabled to have the file compiled, and CONFIG_HWMON would need to be enab=
led
> to have the sysfs file exposed. ath10k and ath11k have the same logic.
>
> /jeff

Silly me, thanks.

