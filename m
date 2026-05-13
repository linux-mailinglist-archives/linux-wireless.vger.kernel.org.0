Return-Path: <linux-wireless+bounces-36373-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BxrD0gTBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36373-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:59:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9187A52DE52
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E01A304AA16
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619373B9930;
	Wed, 13 May 2026 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5c0OePv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D923B961A
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651906; cv=pass; b=QuBKTH8Ba+OAG4gNpL0UJhT5cSpyPrxth58wv07MdTvAmI3TN2Aei4HeZHXu02CO+maT/yv0vcE4wTrnohBFoe2ftGYaWppuN0qv1mG4S18c31LqrddkHI9CBXZbOOVWtYz6oYqVx0j/H8lTT3xrSKy249G0lOE1AsbWC03R82w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651906; c=relaxed/simple;
	bh=jVsKeCJ94k5DPAEZUWR4MSEunsnQi+oQvSGHsYz8bk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVbEchvzcoOENfLK+ocCgxmNh2L7hO37IJL5Gr9NC3KPJs2X4eifyR6QgStFfGayyo9CwBBNlPjny6XaGcWFIpYAmereqFOh6JshKy3t4A8thdzDz77pCUlQDjdiT6Y3RpkjKj94z5SK58xgx1YgaXcOE8kO/bBF3L9j8IF3Qfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5c0OePv; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-682714e8f9eso842869a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 22:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778651903; cv=none;
        d=google.com; s=arc-20240605;
        b=eh+tLXpXxrn5j5th3i7hm7IRMy/GmrDJsNciFVGkU79DASzupyuQfITJhwnBbjYTzM
         ledG3f4o3OCInXbkN7+nccQ77YhkVbH/K3xeLMKtFFHHdQtuQvPqF9LJ/sZDjUvZQUOZ
         mkMyBGxzqUvNQVBkb9gJObUXlNNk2yjPw5q+hZdMrBwkveVR93L+zQk241n1ZM4qWSZF
         A+YshW1j1I5WpE34eKxFvw7PXvsnpS02iYHx1Y6hlQMRns3xMw0JKyx64ZHw5lmbwCSg
         0rIVOEDMg+4YxSknLx1vk3c0BV7Cvl728qMfrU8mH/SwlVNdkXWcmqJN/k2ZjHIsC6UA
         V9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xPYfQTaQpsO8YGeU0DeTS1sOK2i6ZmZ51fA1r6cE+5I=;
        fh=ecY3AWkosI496fCOyvqOhMbTWue0THHhofPeVGmnugU=;
        b=M/EXRUGtFBsGFrmLDor7Ra4/Vj3EZMjsSNkmUxqbl7xz/iw6HrXTBmIOp7csrA0/n+
         Q7TSm89ZQ5ApNm3XrEuTdAsfzDSbSfUMKdOS3MPxVHgmlp7MUduq4Wke4lzfgej90FLy
         rbkHuQKlADrPo/JayXOZPL76MsVW3BZU6QYClyvgikJcODjCpVlS4P0A8iGn4PbRfoIT
         ULa+4ZvXjYBljvKItGeSHdf5zYh1/RR2Ol3rNW3pXcn6vyGyQ0qygrngUDkHOdTwtidG
         qf92n5/Xerm49V6zLPnM0egQKNmRgSgLjCrYIU2Nl3OmcXDzY/pEKMmjkHEgO9fA7q4R
         GRHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778651903; x=1779256703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xPYfQTaQpsO8YGeU0DeTS1sOK2i6ZmZ51fA1r6cE+5I=;
        b=l5c0OePvMa5RPfN8o6Bo/TARbUx1NoJ7PxgWjNV9BfiXgbwnaxVFfs3W5mXQGj8aHt
         2+HUW0fZrgZ2Jf1Lz97N5csM7WUSWcvMkOJlyL3bpi9aoucDjXZL2dVr7X1WaXM5FDQX
         GcvuyoAuKuLiVnnQE/2qah9y2qOYVfU1lNPd9NN5MNUeVh6yB0jhJz61eigXoZBXOU8Z
         25mY4RG862QHMwHuwlLa4nT50xjzuNybkbpS4h2W0pvCvzs08BdgeBcu+dWY8AUnHRsg
         pMvAfafi1+ZphClr1oxZRsu980PtUxdPlOtsMXnLwYHjIZDk2IiMACS09xcA0p6QnRj3
         BEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778651903; x=1779256703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPYfQTaQpsO8YGeU0DeTS1sOK2i6ZmZ51fA1r6cE+5I=;
        b=BNYBCMCMCy/asb2hqFhPNzd/J1YzTx1Dl6xe/gL8FF9y0XEbjjon7uvZ1Gui/5YgFy
         T2SQbNJYesMlkp+WaSEaCsKTSa/GOsB/sSY3s3ypEkUEgbfynbXh3imrbL1Js4mCrZFI
         MtrhxYKjTnnROSLYs6CGmkXDWwwjWLQs8dWU8D+lqzmG81WqkDJ1qwY8MXCia9Yth/rU
         qRA4WZamWWG+8ttU+jpsD2ykswsS9gm5GFCTxAnwEmdAQ+I2o8YfcIqT9tR2EZRd7bfT
         SgDa3B+8Kohx+y5/e7ykptBoPz2TgeWiETABiGDYwHN3zCahXz5TIU8YEaOUCG6lcifs
         8WQQ==
X-Gm-Message-State: AOJu0YzA0rTrbkSPDtV0G7wAWqWIycO9IkT6ZNTWixUwwtyIe8rs8gu2
	sDq6zmMy6G2sYi8ajej4PGHp2abIF5JAmcj59qFTZOZeQdvoC3ZelWwaoWiIExttEepTyzR/DA6
	wGWWZqMQff5EAm5pbCf0XUTCyXo4jO3lS0Vf/
X-Gm-Gg: Acq92OHiur7ZyDfQVcf2oHqsfOk0ZY0dk9AZrUX7WrgD5+9EB4tdB8unQGnUS3r2ocf
	qsmL3eaptHbhTHxCjIfMwzpABAuVEuBxm0AdHaAJ34kniiW3BmS9xXZJ5auGE8uoOPtmn/td/Be
	8PMgHXzp/z3wha909jmujzrDCdc7G/axCmC68z4rX4j2Pu2QQfqLi+lARBpigwK9N9bPzk3ZgqL
	22f0oBVf9pCFuo7szh0FqykWOuO5JeKlav8r+vgM6cP4tCV7wr92ErwOhTi9uAy0pZmur5SsnN0
	TQODheA=
X-Received: by 2002:aa7:d1d2:0:b0:67b:7e67:7f5f with SMTP id
 4fb4d7f45d1cf-6823178d120mr617278a12.9.1778651902949; Tue, 12 May 2026
 22:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506154129.64112-1-maashif011@gmail.com>
In-Reply-To: <20260506154129.64112-1-maashif011@gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Wed, 13 May 2026 13:58:11 +0800
X-Gm-Features: AVHnY4KILArNhlrjf5gI3ll7WyjNVRgluRg1OFx4rYpYI1uxvVwfCYKfxDtejqY
Message-ID: <CAHrRpu=Ku=cK2Hd8xzJr82iPkj4Jzp57ch9wEE1KsoCiExbhbA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Sri Lanka (LK)
To: Mohamed Aashif <maashif011@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9187A52DE52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36373-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trc.gov.lk:url]
X-Rspamd-Action: no action

Mohamed Aashif <maashif011@gmail.com> wrote:
>
> Update Sri Lanka regulatory domain based on the RTTE Type Approval
> Rules 2020 from the Telecommunications Regulatory Commission of
> Sri Lanka (TRC).
>
> Source: https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-English.pdf
>
> Key changes:
> - Change DFS region from FCC to ETSI (document references ETSI
>   standards EN 300 328 and EN 301 893 as the applicable radio
>   interface standards)
> - 2.4 GHz: expand to 2400-2483.5 MHz at 200 mW (was 2402-2482 at 20 dBm)
> - 5150-5350 MHz: 200 mW with DFS

TPC is not supported, so 5250-5350 should be 20dBm (100mW) as description of
ESTI EN 301 893. Since we can extend adjacent channels, add AUTO-BW attribute
to them.

> - 5470-5725 MHz: 1000 mW with DFS

By source, 1000mW is only for outdoor application. Should be 500mW.
Then, it also satisfies the limit 27 dBm defined by ESTI EN 301 893 without TPC.

> - 5725-5875 MHz: 1000 mW with DFS

I think the range should be reference to ETSI EN 302 502, which EIRP level to a
level not exceeding 24 dBm for ChS = 20 MHz and 21 dBm for ChS = 10 MHz.
Then, this rule should be 24 dBm.

However the source points to standard EN 301 893 (wrongly?).

>
> Signed-off-by: Mohamed Aashif <maashif011@gmail.com>
> ---
>  db.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index fdc2c13..d265176 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1058,12 +1058,14 @@ country LI: DFS-ETSI
>         # 60 GHz band channels 1-4 (ETSI EN 302 567)
>         (57000 - 66000 @ 2160), (40)
>
> -country LK: DFS-FCC
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 20), (17)
> -       (5250 - 5330 @ 20), (24), DFS
> -       (5490 - 5730 @ 20), (24), DFS
> -       (5735 - 5835 @ 20), (30)
> +# Source:
> +# https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-English.pdf
> +# Sri Lanka RTTE Type Approval Rules 2020, Table 6 - Wideband Data Transmission
> +country LK: DFS-ETSI
> +       (2400 - 2483.5 @ 40), (200 mW)
> +       (5150 - 5350 @ 160), (200 mW), DFS
> +       (5470 - 5725 @ 160), (1000 mW), DFS
> +       (5725 - 5875 @ 80), (1000 mW), DFS
>
>  # Source:
>  # http://lca.org.ls/images/documents/lesotho_national_frequency_allocation_plan.pdf
> --
> 2.54.0
>
>

