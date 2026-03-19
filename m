Return-Path: <linux-wireless+bounces-33482-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPNqG4zru2liqQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33482-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 13:26:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8412CB25D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D31A330074D5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC23D1CA5;
	Thu, 19 Mar 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb48DLmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9043D1CAD
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923205; cv=pass; b=iy7HVvQgwWlHmKKsal7QIKhNVnt/G+2VBCD40Wn+CbDOjZB8FFRAJAQEuTd83RLdVaiUzqSK7W60+9QaSlB/Lt3AYjihExPr2bWkqPkI3DsQJUQUoW6899Ox9SeSFmU2bcMVQzLU6vxxxEPjdxTsg2IGoYCbckds2VNzBGkC8yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923205; c=relaxed/simple;
	bh=en0S3rhRVuk4HdDoGfU9riboUz4vLoI59qsRVpHjXPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bd1aRCKvcPy771vlOuVctmWMYg3lPkrUMiMM1HZ+SSLZHHCYQwXOsRTXn0AUBClOQnUFC2RbRqGVVrdIq+VptO3/QQ8qUc6S8T3qjCfs8FhL9+PfSCBPYr9XrmhYrzM19ORLJ1ngGtlprbBupwVE+GF2jT7q/gLvzQQN942989c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb48DLmI; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b04fc8851cso8269575ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 05:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773923202; cv=none;
        d=google.com; s=arc-20240605;
        b=Xexn3RHfUC0SGjVFvcNI1xz2trjRKVjpJjyS/yl7wx6ryx4l7SivqQ2/AnER08YBTh
         d4n9hCUbVrCSIANtT1zvDSqM9D5cz4bKG4RQdrtztUvt0KpZkBd304iYlCak4Kyrn0m8
         YR6dXpACBXl4ghTi/hzjWAPzzv+lfJ2994ZnjGHoJuHb5yNxlvj+gtg6f4xbCdmABcxd
         J3FnMyGyg/J6rdJfvljhVXsBx9+mrqUfhST8G70Fi76Ut1d0vRC40lTZKB44Gh6dObc4
         9ECmXvyN6EcBGrcjetKnm8jDYOu6cK1/Cn4d/USAoq4eOepBTTWbsGX4zDsjH43M1nvm
         bYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=en0S3rhRVuk4HdDoGfU9riboUz4vLoI59qsRVpHjXPA=;
        fh=fqe1vRZuITZgMhtqIeKNOQxKexCn19lH7OqcQsQj5/w=;
        b=GEBSIr2YmDq13QzgfbArNavcPztj0VDRW5dwk44+thRXjRJLZokveavY8H+7Ad4tcp
         pMWqEMap5t5MjfMWkY/x5BqM+XVo2Oh7CuslKhCSUj3W2SFaQWRF2M7aSTeZ2vz/An2z
         vRiAbbDwSc3iVNHeUH9I1kdA1RCwjw0tO7N8FTCm0s9lJIxhwJy54YFI66r07FwOVNR2
         QVNmASH3ONMUHvT9lXWtwe4KgoIeubrpFJW9wJNg4lh3J85oFYvV7xZMH8BraZaeb0Z+
         tmvm73mzCOPSCqDxdcUIe3txHhnlbGROQG0AeOchNnAYeiWAWQ8xTiQ3eyaWTRTCgDFY
         MUxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773923202; x=1774528002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en0S3rhRVuk4HdDoGfU9riboUz4vLoI59qsRVpHjXPA=;
        b=Cb48DLmIhzc4ky2iSOSr164FuOdAt2EHOSSaE21xQzDqvb4VkFsSpMgElcb7Eagkpw
         tmIaEx1wbZYzk1QMfdMre0tMp9gHjZ+yCAmdwlda0qzPhw80PPq1okwNmuMTEpPUdbJV
         4HNXQV1qOoy8pbIyKhJHgsT9RgntjHXXQ6lFGn9xhFNGhDyNaFvoMiEpF6iqxE+Nwr+K
         66YOsL3MeU+wbEm/5aO3dyXVv/bHO8AYNWh2e3kVnpG8F3JOXyuUtlKW9lkB7Jg8kpKd
         BKTp0OhoEJNQ4YVU9lUMzoBD7O0dubFYesl3IkxrvzY8GdagjbGzPoTsvd8UbuOGjTmy
         g0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923202; x=1774528002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=en0S3rhRVuk4HdDoGfU9riboUz4vLoI59qsRVpHjXPA=;
        b=AVXfiYwjUCz6A6F+Qs1VV26f1c4H9Rw6DBxfCLJegofLIfAUMiSkC/qHVmhPajyUEV
         bvjUr+etuK2XgD2rCtbz3izJBcI5nmv7deZjVnm/S7puzKSEzD0fFKMAlmj4T3KG88sM
         ULUewHu9KO68HkhjcCaKnGZQU5JMrMNbbNQwBmg/XBRGhV5MErm1L4l6oX13Zc1DOXP/
         32ZLau95DD/zoj7NaZtg9ZjmyPDWc0v7yAcO5zbgxYlbUaK0WgiY59ttw25Sy1VeQuya
         BTP3z82JbW+2U7Qckw844YnV83TbKPOVKhrpMw7zhv70HRSD71zCigkdsumZe1tEhosw
         IrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8c9SaLXBhIloDzTf0ICa+OJXxS+aLFIx3jq0FxNy7K6WbswTBR9gcO2QuzepeBz9/C1vzT9d5hwGjKm83Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxohyR6+peByBO19PmeClL0kiZocv9nhbViu8wPn5SSRx4xsZ3X
	uRq4raOyrhy48lY/tOxdLZu+S2UjG7Wx7cH3mcTMxYlWyCA1xlrUrTOgNON3n8jcxdL3w9l+tLa
	VfugEtcIGmKrl1fHnIVcqPF8+PLTx9A==
X-Gm-Gg: ATEYQzyPHSFCCUK4a7j4Mn32qXiY3Ls7bLGxmC/y6ocDWrgAslMUt7Mxdm7tuH4LF9K
	Og5cdXNoxap0uFop1KCWAiHHK7ZB2Of/xyG4D3Tb65qGYuo9+irrqroS8Or8++D1ASQd7YHTGhD
	gwsrpR4l5TLsdQjtNZ5YcsqGK2F+YWAeFgloBJEbwwHJwd0WUWhcOqdb6Sw8P0krv5W2r4sYOus
	QVQ1H5AZB4zP1KF93UQ5HrHwAKBoSe8m5RnBTNXnAWIV+hgTCxeUPVxX2z2RxQPHFnIUm5nDEGv
	B3KqdQ==
X-Received: by 2002:a17:903:1a24:b0:2ae:5a0b:9ce8 with SMTP id
 d9443c01a7336-2b06e428cf4mr71732845ad.45.1773923202129; Thu, 19 Mar 2026
 05:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801202359.794035-1-frut3k7@gmail.com> <20241009065051.51143-1-frut3k7@gmail.com>
 <b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com> <CAKEyCaDUfn4jtCdTt9JJ-Qe+CCudORPwcjj5i5=G28ANc+eCRg@mail.gmail.com>
 <87ed4dr5pj.fsf@kernel.org> <CAKEyCaD-1GO1NL-=1E92BE9=XKa2PymOAY14vMmtwYGLsPjeUg@mail.gmail.com>
 <CAKEyCaAaJGUX56Xp57KWkouCgpOyPNTqysRZyGtfsyoJ+ERMpA@mail.gmail.com>
In-Reply-To: <CAKEyCaAaJGUX56Xp57KWkouCgpOyPNTqysRZyGtfsyoJ+ERMpA@mail.gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Thu, 19 Mar 2026 13:26:31 +0100
X-Gm-Features: AaiRm53LS3YV2vNyYE8NB5R2KfS-Y_ilptPOBdpZbFHdnSuk2kgBOOWrzrVvBX0
Message-ID: <CAKEyCaBi=mpZjpAra+sUJgNPqF85xxpQHE19SG1aVmLyKA7Phg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33482-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frut3k7@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A8412CB25D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Sep 17, 2025 at 6:17=E2=80=AFPM Pawe=C5=82 Owoc <frut3k7@gmail.com>=
 wrote:
>
> The changes are added in the ath10k-ct driver:
> https://github.com/greearb/ath10k-ct/commit/8f2254b8e0554e78efcef5fb752be=
0eb3573d281
> Is there a chance they will be accepted here as well?

Kindly asking if this change can be accepted?

