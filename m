Return-Path: <linux-wireless+bounces-31059-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCpTDJ/ocWkONAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31059-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:06:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9387A6435B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9037E3EA8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F234A76D;
	Thu, 22 Jan 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FO8L6P/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B062BE02C
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072376; cv=pass; b=ccULlkm51quq1xEiHEgzVyj1S93UNss5xRSbye7Yq9eFtE7/ppEOw42NbWB2cK7jWApApOfO/489/N36He7SlHc21Cp3tC5XCZef+9eyW0t1VI8Cino68Bv8h9YJ3RPJMbxhdLrsWvV+Nq35qWU3PAXuVuVlvbfnHKTgFRZkKYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072376; c=relaxed/simple;
	bh=UVbmrWCr+n3t89Q5aCY7Q+w2FaOLaHxgLsZ/g8jDqnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2kUb//xcv37uAZZ6mmfQOSTQdfPY7ey7An+UCpksLxQzufgvDIHyLUcbk8BV1YlPXNYoGZRz4MsA0wMMi4LdixADq308QACyeLrj6qzv4iD3i6fOj0VQ9IHqfVMk0KfT8HxCcpyBvLebwY4eqPVvr+SSLRUn+fCnqmFLvOXZG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FO8L6P/A; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b7be7496dso677027e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 00:59:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769072372; cv=none;
        d=google.com; s=arc-20240605;
        b=cRRmGfvlAGVjbikGctZqk0jJPNuQ9h3UjbdM8oLl7Kz6HPEkQRAtoyxFgDzNU5VS8Q
         0DO4D056t+0h2ZcwVqPi0y4203EY+KJwBZu2R5ed1sD/yx0iEbRUGe8mNs+YIPMur8OR
         st6ytcsCXyDLxIJLfC8fwwgRl+Z7O/xEcEd5/jS7l+V3j+rmDSeO0tOoBE4WBKPxIhfI
         ipIJgQo2GqzZ2NsCes/qAsNo5pZnkXxrTtsalTlVNJSv3I/doSS1Fbmzf9cSK45MCGef
         L7am6mz3cx0XasuMR9MPf3ENQqhDrk5TYCPV6ZHrfuA0SZ2m7lpDF35wcbp/Tb9Xc3K4
         L1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UVbmrWCr+n3t89Q5aCY7Q+w2FaOLaHxgLsZ/g8jDqnc=;
        fh=3N9a5cZQDTI0xQd+b3Ry8XWUhHIe5YHz7u7zI5X/xIk=;
        b=Qb7NJOi2Jjm1KC+6pVtAnM9D49Hjm5YmH8P6wuuZfBhulJRP+Pqm9m8lYzIg7PMoyc
         P4Qkr8SKyJIuMZ/kM35swuMqoh8HC5m5TWiO6w0IRjw+Dl0vgtwwBgoiaUu3kSCnsTqV
         XajqOa1OIn8LfE6Lci4uSJyXuCVHF3fnvlR9Hm7TmjDuP7jbA7xygCLIx7VrAUiZ59t9
         z/jRnsTOmXFvhQlOCU6q0r/5t1mXTw5mdMv2pcuYGnp2ZGiUQ2gelZBeMJ99KP8RVCyS
         gGgf6kwDZtEeGG8v59LdsIKePF2w7qePso6QSSna6sORM88YeDsRZ6uNM7JeHZAyijAU
         VGfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769072372; x=1769677172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVbmrWCr+n3t89Q5aCY7Q+w2FaOLaHxgLsZ/g8jDqnc=;
        b=FO8L6P/AJwVGmhAsshwY2b3fVEdoCPOjZyxsyaIav/TaGRuM1NHM5Wv12+ySqgKbRx
         KqJE4t59WbUlaaVJSML/B87JPKgcNfyClELxovot1MBLBg8S6DBOJOCUY3zHZ+jKtaZq
         Bpt1n3xLKyQBqI3x7H2g3owQ2+ecJda3MUijh2i0ojPfhz2SJZCadVDkgmU7FjXbYQG1
         QdBL/qm8CNiVFt7rM39MX9qWUUlKMkxHJWLuA73Oc2n5sA+8PPfGelNUnmE6MRG2Jfj9
         raDqEuSnPg7kTNTsvkKFmGnGpDHVMmqWFvaxxIOL3IX8MMqQrbSi8vX7Wo65N7cSJLEv
         lJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769072372; x=1769677172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVbmrWCr+n3t89Q5aCY7Q+w2FaOLaHxgLsZ/g8jDqnc=;
        b=LkO2iVyyn1B1PxK53aLEmxkTByZpsq1PDH+s3XAH3GiWgb2RoD8OaSsaQzi9DbcNO1
         L7pwSjXosXJg4wElGYO3iXnvJSkRFHPaOhIYoFg8IQKv+5Q23ADo4eSVz/vMsJSKgD6U
         gcdtO4zRTcIv7Bg+8gyoixeoIWwrode2vZejOD4wbfNiukeKmfxI7tu/qslnjocAblmF
         weOnNS20MKmGYYibs5F5SDp4g2o4N5eprcxlcjGYfhmVr9LTWp5KS9GGz0lKO7i/80Xc
         ikKCwFLYqvnRfHdeiITEs8/HlOntBaymcUDJwBlTepN5g7lhuP+dJuat+qlVTpgosHNL
         fi1A==
X-Forwarded-Encrypted: i=1; AJvYcCURsMSXYtDauftykP0M7a8XsrBbo69Gmy6BVRLb54shduKlALn6WWBj5LEEpHwa9gsYWBJD2nyJtGaLiiD90Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcH3Fj/rTCTQSjDQnB1Q6ZbPKTUT58Cz/gSLk60vWvMg6XNE4Z
	Om4siu1pkD37YkUaSi6g27AK9UEN48Rvpn8pPNdLg8QpiUk2FTaNuzywzkqOhsSJq2ZDZt+ZBTE
	TuXgC2hz83fXltD47zjzw0IvFoOApuj4IeoY6KsB0yg==
X-Gm-Gg: AZuq6aKVD1vJzXAwjolfWbZpcW3H4IPNn0U0pQdSwa1C6SCrWDYEfFJfvYfwq2l9bFv
	7NETwxvZ9NrlnWsmpfYON+3n0UaXOlNEdTk5ro7KQMP+Kj50I7WLJfd6EN0OjHXLNTHmilJEqlx
	5QnWt+jFqVuNu+zm/l6GwvkX25AMwzNMc8Tx5EAK98pVsuKVFMlbiMZYr34Q8aBQNTZLP1bCMBk
	2VsAAqIBGjUT+FYipzlHhBmenGcdV/hz8+c3yVUkf3Joim5L6RJJXFZDUZvakZlndn/LXQrNweZ
	RBEPi4XnKQrK+uemeQrkxQkg6cxn
X-Received: by 2002:a05:6512:32cc:b0:59d:cdf7:c4d3 with SMTP id
 2adb3069b0e04-59dcdf7c75emr2324410e87.0.1769072371906; Thu, 22 Jan 2026
 00:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113160605.381777-1-marco.crivellari@suse.com>
 <20251113160605.381777-3-marco.crivellari@suse.com> <03d9df21-039c-4aa2-b227-9da4f8076388@RTKEXHMBS03.realtek.com.tw>
In-Reply-To: <03d9df21-039c-4aa2-b227-9da4f8076388@RTKEXHMBS03.realtek.com.tw>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 22 Jan 2026 09:59:20 +0100
X-Gm-Features: AZwV_Qil3VTisPWjh2pg_SMhr9Nk2pZ2_D2xRB4Px-TwQeue5-BMvTyoh2p5bd4
Message-ID: <CAAofZF5P3FuUJ6efRn6Y=5kzDS6ziMT-5=XyZ8sSWFfOiacfKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: rtw88: add WQ_PERCPU to alloc_workqueue users
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31059-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 9387A6435B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 2:29=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
> [...]
> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>
> f65ca6c51179 wifi: rtw88: add WQ_PERCPU to alloc_workqueue users
>

Many thanks!


--=20

Marco Crivellari

L3 Support Engineer

