Return-Path: <linux-wireless+bounces-31424-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCMdGToOf2k7jAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31424-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 09:26:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1419C53E6
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA66F3010D83
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB0279329;
	Sun,  1 Feb 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoI5uIzv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC727F16C
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934359; cv=pass; b=dpSMpenTmWh0I18mR918Yr8Mobdv2ZD9tM1JU0SnLxro+Oq5jI4z+pm/GnTWX5uFq3K8b8VfTmWLBp3IcgrFGF7XKl4t8y10gPaKTJ9Cw37EU4tPqMbLpUK+aeGCbpf/hitPIu5YxZ01PNXUXc6tfIEr90RQnlKwwov3RQti9Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934359; c=relaxed/simple;
	bh=hTZYXxFTDy2N+G1W5B8a7fyBq4jHaZcvy1+pJ7l46hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mrHWytoQhFj5vEimtT7IQnWNWCsZvDfd7Wk2upjQ0KMfxxUAGPyuCJPRJHijDs8QHZNOP5N2dFPVMkegqAsnEBfRMHFy8ZaSK6LvhCCiaogrUMCuNxpwvCoqZcRPoByhGaqZDGsFM25D5woOZ31FWqK+aeeewDjxZoFyH8A3NKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoI5uIzv; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5f52ed75c45so2399802137.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 00:25:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769934357; cv=none;
        d=google.com; s=arc-20240605;
        b=EoQFMf0fcHe5aLSRlJjD3rv4fJTXpRDf7BDXKzAN6T93vJfPM++Hk0bY7QbTWIbb0h
         CWmj7KhbnPbOB6FsHjjyArwpgRv0KSdeaN+oh0ZnJj9htPSwqS8Kb2PzMB9a0WR8SAzU
         ioZVIc1e5rtiQDiPV6U2cIasrQvrU04DUPMfmVf5nvIWMHUlluuVzdKvYb4k2D2NR+5P
         U+rz8ECUr1NzPY1by46IBM3pOvYA3ti9KWL8rljcV5q3/u6iHDmVQiSn3MIRKd0BpFlV
         f75JwG3D8T5+wopJFETDknZpzv/GTh2IUzf2XVjl2vP+UDEf+PKvoTf5vDP3EAgI1O4D
         w1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTZYXxFTDy2N+G1W5B8a7fyBq4jHaZcvy1+pJ7l46hg=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=dy2+E+k5kgXh8W/K2NLUqL7P3HLutS270kvL7cI+96NEI8o0S2tO5k1opO5VHZTtyp
         exovu4/vdQcB8bKUoGEp51Qwn2OhruKdVnNWcqsXVIOINH9sM4MHlegU4KZvIjptzWF3
         ZUkUYhj1fVpPjxhDTCbKd0LJQIPadlRiVLLM0A8DWN+09pxLLw67hlt8Q5itLOrQjfVQ
         SjcoCt4uXAfnO5VbA2Xl9kyPUf1VZ4LPYzZO3ndJ/+DlW4oqIAdNB+oSPRqHfH6f6v/M
         KZnqzn/CwWVaaNJ83xeDBvhLDGD/BXgF57zMzhsmcSz0e9a7p/Dm6VSb9MHU77ZKWsp1
         Slnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769934357; x=1770539157; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTZYXxFTDy2N+G1W5B8a7fyBq4jHaZcvy1+pJ7l46hg=;
        b=EoI5uIzvXyePQaalZm54B61VItWmSQg5v2kRliC7rd/uv2d6SDnBp40T4ft1uNzF4c
         N5FxoPLPPdOpYywue7TJVTTMOsYGZwOTKvQ6hXJRsH2ZpvL+KpqGjNniaPfMaKwuDd8D
         ruIgVJjl/Hz9rBzc6vQUb0QoZRItlRpqOAjP205Ux3xMAIqgJ4GxCWxywCFctSZ30HoA
         B7Vxb/zkMeCawJ5bbhPJZA2s7px7hH1bYwH/CD1TUstzOURam8y30tv2qZEMV9h4WeGI
         luqWjFKPXJDNBZoQ+iu07dkGszKZHVd/4GcEYpdF6JBcp3TEu1x6QCt9jHXFTIpy6M5j
         SjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769934357; x=1770539157;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTZYXxFTDy2N+G1W5B8a7fyBq4jHaZcvy1+pJ7l46hg=;
        b=mohRVxDjgwzxM5cWG89vFNaxLo5irRo4rOLakoODHZXAlQhgs3h2n2z5ybzwPaiM9E
         NId2BQMhMeBRCS4w/TiCCy2xAV/k2A0y80ZiOykMve05Y7JGACvZpTK3+Npoy28iH7EH
         W00bmDlWHWqlT1m4IhEc1T129qGQB9FVHVw85WdS4TrFSRsdNMiES5yX9MAFXZHyAsJ8
         NS7Dxu69urNf2GiVNpWXjcDzniV5kejRd8GULbzEmHejUAYgOsgteQpf5oPsrvoHgMXi
         LxsdJ+YkNgUYPki73Cx13Dj3nu2wM5NIJRSd6KxO+4oHob9UmkWRybBZjtoj8Pq+0lcB
         vnxA==
X-Gm-Message-State: AOJu0YxvIiiXFQwbyLQGSg5DL/iZJ7UFCT05YYB2LFmgzjp4/PF5A7Vo
	xMEctzCWHHD5GmUGJpfR8TfvYM3P+AMCK3YybHMqO924LlSqsphIPRZBVDon/5jMgk4FuMsvUB1
	WSAuXGgW/y5kCIEfYbAzQpn443oZz2ceFUqZT
X-Gm-Gg: AZuq6aJXnBPYn8isAWpUj6Sw0b9hPjpa0nBLVSRM7m0+rEEJVYGImarJQV+nlQEma0o
	Iivn31kon7o/Fj74UV92RqHUSiSpMIG3mfO9QXFW50iJf99HgeVEcsTgrB1DrGjs3A8N+WVFZvw
	ukU4f//cMjqed1yex+ZhS+pZDBxHT02whZWBbX877ErLptUVMPRbnZCJtEYnoL03xQK7RbIWkks
	hVXTLL1kw+CZ3h9xdKvC7vW3d8MRqSv3kLnTjUgp84woGbN0FJqvVPfCzvW3ln7UVfpewlO
X-Received: by 2002:a05:6102:f14:b0:5ee:a04c:7ea8 with SMTP id
 ada2fe7eead31-5f8e2463399mr3247018137.11.1769934357040; Sun, 01 Feb 2026
 00:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1769934236-25833-mlmmj-67d697bb@vger.kernel.org>
In-Reply-To: <1769934236-25833-mlmmj-67d697bb@vger.kernel.org>
From: Alexander Becker <endeavour79@gmail.com>
Date: Sun, 1 Feb 2026 19:25:19 +1100
X-Gm-Features: AZwV_QjHfUZurLjGV19gObw3pgJlI3H2dyPjNA5AeYkKf-F4sdjsfeJoYv_4w3E
Message-ID: <CAL-F8yX_QTU7kDMVVG836E1R4SKVPVXHmLB1P8QhWBya-B68XQ@mail.gmail.com>
Subject: FYI: NM + Wi-Fi 7 MLO AP: boot-time association completes on 5 GHz
 only; MLO appears only after retrigger (reapply/clone)
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31424-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[endeavour79@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1419C53E6
X-Rspamd-Action: no action

Hi linux-wireless,

FYI about a boot-time behavior affecting Wi-Fi 7 MLO (802.11be) on
Ubuntu with NetworkManager.

Observed behavior:
- On boot, NetworkManager associates successfully but ends up in a
single-link, non-MLO connection (observed as 5 GHz only).
- MLO (multi-link with 6 GHz + 5 GHz) forms reliably only after
retriggering the connection (e.g., device reapply) or switching to a
newly created =E2=80=9Cclone=E2=80=9D profile.

Environment (redacted):
- Kernel: 6.18.7-061807-generic
- NetworkManager: 1.46.0
- Driver: iwlwifi
- Interface: wlp87s0f0
- AP: Wi-Fi 7 / 802.11be MLO-capable (SSID: <REDACTED_SSID>)

Evidence (journal, redacted):
- NM auto-activates the base profile and reaches =E2=80=9Cdevice activated=
=E2=80=9D
quickly after DHCP.
- A workaround service forces a delete/re-add/activate of a cloned NM
profile and then logs: =E2=80=9CSUCCESS: 6 GHz link detected=E2=80=9D.

Hypothesis:
This looks like a connection orchestration timing issue (early
completion on first viable link) rather than a hard driver failure,
but I=E2=80=99m sharing here in case others have seen similar behavior in t=
he
Wi-Fi 7 MLO stack or have guidance on the correct =E2=80=9Cready/complete=
=E2=80=9D
conditions for MLO.

I=E2=80=99m also filing with NetworkManager and hostap lists.

Thanks.
Alex

