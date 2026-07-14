Return-Path: <linux-wireless+bounces-39004-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kHKvIgOfVWpArAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39004-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 04:29:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBAC7505E5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 04:29:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=X2IenEL6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39004-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39004-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78265303C438
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A15380FF7;
	Tue, 14 Jul 2026 02:29:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5693803C3
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 02:29:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996158; cv=none; b=Ww+TI8ntMB1M+m2hoqeuczetZ6WimzhXew3Krf64Pqu8x3e0DBqeYFLvy7n0XqJVXXUQbfHksre4VhhUCYZ982btlDwbrgTGYJZOacUCibGL6bId2rTxmi4IYunxy98ReQ8ZyBkSS3O2+d+n+2JfzPxtr2KyWmOjRwytHj4nhZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996158; c=relaxed/simple;
	bh=Ogf0c96gmvFtj7+Kg/2HQ2FnTL8f6Vlo1YUm+lu9MPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6FHqxeBu0XvZIwHCbJoiigrC6h8xs/le1QktubPjAu834fk83UQMp6/WymMEAAuSpzm7cqXHTHetsbTmJKbfpw2QPYSebLDi4IF5YAm/1xu9Jv/79J8P+4ynp9AnKMrWnBJhB9wnEVL4U5HBuNj5YV6gzvSrbmkpUyBjDRKtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2IenEL6; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so4142431b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783996156; x=1784600956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5bPrUfoJACi9BYyW8xq/jkNYTvoED+3Sp0FVeU/kPo=;
        b=X2IenEL6rOnBCMe76aNVjAf0lPtXZKyRuO6SqQCI+m1Sf6jY7gYYl+qMgYFSK4NQul
         sENfPtVcQf+9QHlf2LX2yynU1D6FUH5eUoCPJfBQg8D5LTcXfFsomPcqdF/Yu71CAgiZ
         YbFjDI3gavQbAFHO3W+6Tv80URMX67MsRT4vP06rUvauT+mn3UweQUCqbC4PFSd4A5VP
         bxtKulGcnqeiiSlJjap57i2W+vfU5UhnFf05pIm3w36iq578S6ma+gDQsq5azAKYleye
         HB3BwRHhe662RVWkSSnB+6A9oSPBh+8hbAL55FSxisrMXgXJQpLUUHl938uEtjrVYOrP
         tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783996156; x=1784600956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5bPrUfoJACi9BYyW8xq/jkNYTvoED+3Sp0FVeU/kPo=;
        b=abFPJY6QTxppS8W8NGZ9UJK4Qnl/YqHFwwDo3KHpXedhdbXFNP+PUDn8xlGJtfICwq
         UJUppXKhK4tdyQjuS4qzCDZSqvVLKeuGT/t/Hrq7GJvDPANEWKbNlQcor4ZhaAWDc5os
         VDCoeceBCYveRZb+1TopsKFO0KYtYpdMGZ8/CIH0ovjlSDsFMwCTuEYGYno39bpf4Z4N
         LzHNCha5LqazLeN9rctBYlNweEPVM2VvfyYH6gk/z6sz/mKwRoPeLDyNxI0fx4k8VywG
         NEIyOhc4XyV56n28WdoDuuIzxwDRj1nndSoqxHo0se8PyJYWxP6YlIlawaNhX8k+1js2
         bn7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro8FvlTMKkRTb0Rmsdo3VDdJQ9cbP4ex4SpZ43LDww09qAfXqHXnubUeUmfuv0jKtMLxOlAIi8jxh/5B02uhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWXVHub3+kafwMYdJtp6fG7ugWS7PL35A6FBNbaE6YCyBZR+t
	IBKLQ+LpjBULUSVxWDdj2bFqMTBglL8O4n6lUWku/4NSdkUyhA1iUt1i
X-Gm-Gg: AfdE7cnTDdiFpffvwgNjgfqPG8SZbSLNz/ICjtNakAImD3q7Q60bAZEItKg0HLEtVX5
	neh1DmqbMRs8xHOqZaix8hrXLWiaQfTuUsss7gFIptZtBZXEZnNrVfj7guASKfDLCP+TVENWD3e
	yrDriALCuwPEDefguCCCbtOCTsiR8/wugBOgL/mFvbFM6cT0xmxnwovcoCS7GjqZOgM9OKrTwNe
	SicyTdsu59xRPcxm761WryQ5F/AXIUr7sGCRgL26NUZhoWiL0sNTK9Uaug8Cdkltw112nBvWB/h
	ZPF8mPesRVl3bSklV8bPRqrMNb8nK7uLB5L2o6Cm5o1huMOKlERNlypF7YCV64m4sV+bs8SLFDq
	8ZBwoEfC0vuCuFxfEqWWK6cvRjJi2rTlCRSpRDVB/6Xm9VNGpjuoaNIUwh/wpsuw0STnEOXZNVu
	BMxGhru5QIU/epROz4NlgtFeQHd7qtrzVAmRqPnYLr9cAPuZftyp4Up272LSgndsw1GihGtLodZ
	RAhmHMyxTYWep73wk3ooznI
X-Received: by 2002:a05:6a00:4f8c:b0:848:7835:bbac with SMTP id d2e1a72fcca58-84a516307aemr1475965b3a.65.1783996156182;
        Mon, 13 Jul 2026 19:29:16 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238f75sm664039b3a.9.2026.07.13.19.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:29:15 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: LiangCheng Wang <zaq14760@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Angus Ainslie <angus@akkea.ca>,
	Wig Cheng <onlywig@gmail.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	wlan-kernel-dev-list@infineon.com
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Date: Tue, 14 Jul 2026 10:28:59 +0800
Message-Id: <20260714022859.1849447-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com> <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,akkea.ca,vger.kernel.org,lists.linux.dev,broadcom.com,infineon.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39004-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:gokulkumar.sivakumar@infineon.com,m:zaq14760@gmail.com,m:kvalo@kernel.org,m:angus@akkea.ca,m:onlywig@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:wlan-kernel-dev-list@infineon.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[zaq14760@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zaq14760@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFBAC7505E5

Hi Arend,

On 13/07/2026 12:51, Arend van Spriel wrote:
> Looks good to me but the stable instruction looks confusion. What do you
> mean. If there is no 43752 support there is no need for this patch, right?

Thank you for the review, and thanks Gokul for the detailed
explanation - that is exactly what I meant, and sorry the annotation
was not clearer. To summarize: 43752 support has been present since
v5.15 (commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and
initialization")), under the SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 id
name. Commit 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
incorrectly labelled as Cypress (CYW)"), which landed in v6.18,
renamed it to SDIO_DEVICE_ID_BROADCOM_43752.

I also have to correct myself here: the boundary in the annotation
should have been "<= 6.17" rather than "<= 6.16", since the rename
only landed in v6.18. Apologies for the extra confusion.

Gokul's suggestion of cherry-picking the rename patch together with
this one into the stable trees sounds cleaner to me than editing the
id name while backporting, so I would be glad to go with that.

If it helps, I would be happy to send a v2 with the stable annotation
in the prerequisite format from
Documentation/process/stable-kernel-rules.rst:

  Cc: <stable@vger.kernel.org> # 74e2ef72bd4b: wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Please let me know if you would prefer that, or if the patch is fine
to take as is.

Best regards,
LiangCheng

