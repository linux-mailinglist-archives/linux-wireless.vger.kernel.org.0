Return-Path: <linux-wireless+bounces-36829-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9hucBfo8EmppwwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36829-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 01:49:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D755C0E5E
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 01:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E88EC3005ABD
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 23:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF52836E;
	Sat, 23 May 2026 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkQ8IG0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5D1DFFD
	for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779580149; cv=pass; b=aTiNCaowZH7L3fM/GruYFNqsvi8e6k4icSN/pjVvhcLQqR/c1U6TJM+hh2vqP+lv6WDMZNv9wsoU8eU5WlVlGLiMxCjyQNYIrFxWX5OxynHuBDUXsyS9bbi+t+V0jRyRPsLlrncMAiZonBVn4Z27g7bnoNp/5ZUyBWHnOKvrqj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779580149; c=relaxed/simple;
	bh=Nk0zktzwG3H8S8Xo56ERxmjVLDm/h2HFsywUDofOgvo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kJ9NCQIFKdoumBdu+66qubgqbgwRUT3BaXEk2w9ygLE/eKTq26ObgF4YT6QJvbo49ABjQ3mUjcpWSEVNRttrmaYT7O9Q+j47u3gz37zJnxKbmiiSWd0x5Z+f6SmsQ5cGUUjfB48owXz2qpzX+eL/y+jWpbl7nobjRy8nvWU9YYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkQ8IG0U; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5757b02e660so441241e0c.3
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 16:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779580147; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1I12Yh4TwiV+5YG+IZoIjGhLBSl4j0Mtw4EoVZ2uk2VY+GHXn3SoQjF5UaGomRIXc
         Lz6sbbHXtassc7JvfvKqQTM8io3Dm/AQGphCAcL5FQ2mbMsBSPjK/6ytNFvbou4CE+IY
         tiEFY8mfQYofJofFQlO7Le5tN7KrjtHh1jifN3nV51mlWUGhkzA3E+MCf/5Xr6hYU203
         042AK3gbpfwZ1MJWfcjaFpv5JDUsLHpMEKWO/xMAQNY9K/HIRpoEzTiFdUrH4eyyJd0D
         JhXPq9h1lDubek8G9EcphJAWFHscNXywszt9phesmd9mI6ATszClBSofNpBQ15+wMQPL
         4tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Nk0zktzwG3H8S8Xo56ERxmjVLDm/h2HFsywUDofOgvo=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=iGuAMohAwOkevTJYUvDwpxRYAJARJpX7rIj+Z9ufNGjiZESEJySWWEFhgyw0RwDSsk
         D4CUCVkCcQdW7cmxlxzb5h1ijxr/ApJt5UOKsUqXcQFZQXeHGQWnX1Tw83p9KzmYybFi
         HfkSIT4Jcl7Q9UaWAmtxLNsiexoU0VIoPB2QudL9p39P7H2Fard93E2gD22IOUCWm43P
         y1aInkJukx5lGLf2p5BPtHsTyJt2hFbdT9tVTJUPfBuRMWcnmt5r0Heq/nhn39dXewJo
         F3hwG/ctpDndV0OReJuQ4pvRICDPl9eaN1qBMz1OGpm08tegjbXwhNNnpwy/1Qlu6Ohh
         IyxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779580147; x=1780184947; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nk0zktzwG3H8S8Xo56ERxmjVLDm/h2HFsywUDofOgvo=;
        b=qkQ8IG0UC9sf7vVmz8PWijWE391cmmX4SzZVobndL5rcBZrgwdBkleLxvHqhPtp8SE
         plEBrycPE5pIuqmYH6O98QSzM76L0+0CPi85KjHMaLvr2EXjCqNmmB/t6UQUZBZ2qUcs
         KergTu3lws3Nj3uvTS0R/g4bjh/2J3tPacYjLo5GEVuTi3r+lUWogs2oB83N9eR83Usw
         CTE3RTLtg1dxPpv9PvmVN5zpJ501p5I3p0YnSDwoChI875p62xL0dVtjnFEbZ27xMb1x
         LM7MAq8M25rxSv9TDqzuudWllUQtiReQq4Zn0AU+TFylCN9w7la7Kf3TyS7EsIdKXeAb
         EteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779580147; x=1780184947;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk0zktzwG3H8S8Xo56ERxmjVLDm/h2HFsywUDofOgvo=;
        b=sVRc0HT5R84tg01asf69xNJXvJegr0h/v3t6oftr4WxKARv8L0M2ikoglpdxiQGs+B
         6zDHyT3NNG5AzH3/UfD4KikogsvhASLZxKVheJuT/Zbwbg6O7rKHv14cPavncFmdgd52
         YymepyFy9qMw9k+Q4O9HgTUtZAA4Divv2N2nJ03YcMuob/iFW5E1uiSjxTn9vA50F+sr
         1sMx+PZ1lYdueSNfsW1JFO2Gvqb0KJEZ9fJI9wLAG6MV+lwzCikwuqmcAD9JtS857U7O
         dDJ3PY28/Cs17xYGofNsJm1Mh6vKq5mBp2PlGAR0ZwyowrkMFh3LHauGysi6UyLQB9C4
         dzlw==
X-Gm-Message-State: AOJu0YwRGjrYzCBGbhs465oYfBGZqlcuGMVfRmHwssugXfnJ04oxvlnD
	KvxVE/qH49oo75qSdg0Tq999yG/IQRx6X+WTUDSloX3RaShfmbmrKU9iidPfRTbFOaYTSbkFKhE
	p+7lQpynNwBUq04wA7g3e4S1uIOWdnsFofKngTG2mEw==
X-Gm-Gg: Acq92OF2wFwL3xDLwQO9gssr5lSYSsDd4sAC6RpyoSN9WIXYHNeLbHEjsYgR1Iu50Uv
	zXoj4PKtj+0Uy4OMaNCpOB0j7yNPVFpv6s3EsM56BnN23SK28hmOVKXzB3VXXod7+iOd8SMv/Pg
	vgbV/Oe+xI+RRf7NLYphGupr+nDYJvlEn9DcwQsp4zKbyrgCKNUubRDsXkdk/awkJwE3FPc4pEc
	YCtsAPKvQwvDq2hOc+chl/AIKFlrCyIDIUMwd4POM2lUME2lfb95p6rB0cDqvk0yr/GieQ060kv
	7s71tVBU6jHn+t6IzF5mid4nAQHQ1YxerERpVFR62g8FN0GAVyK4zwLj2iaAzmBfb2IxBK5XetY
	tJOoaX8qDTIITqOf6nIeXGRnzmQ==
X-Received: by 2002:a05:6122:c2d6:20b0:575:99d9:cd15 with SMTP id
 71dfb90a1353d-5865e98ed72mr1774513e0c.1.1779580147399; Sat, 23 May 2026
 16:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mikairyuu <mikairyuu@gmail.com>
Date: Sun, 24 May 2026 08:48:52 +0900
X-Gm-Features: AVHnY4LRWNldh_WiC4Xj7RgqKMn1RpMeZIbI8ceysLe5un7cNeqd8ZnT4N1EBXk
Message-ID: <CAB3XHij-mG7nAOWT0ORt+WxpgORAEkghsD5QN67i+3vieNc2MA@mail.gmail.com>
Subject: iwlwifi AX210 JP 6 GHz VLP client restriction hides Pixel 8 hotspot BSS
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36829-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikairyuu@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A3D755C0E5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I filed the following iwlwifi bug with full logs and a local diagnostic patch:

https://bugzilla.kernel.org/show_bug.cgi?id=221568

Short summary: AX210 in JP marks lower 6 GHz channels as
NO_6GHZ_VLP_CLIENT. A Pixel 8 hotspot advertises a VLP AP on 5975 MHz;
cfg80211 receives the BSS but sets use_for=0 and
cannot_use_reasons=6GHZ_PWR_MISMATCH, so nl80211 hides it. Clearing
NL80211_RRF_NO_6GHZ_VLP_CLIENT in iwl_nvm_get_regdom_bw_flags() makes
the BSS visible and the station associates.

Could someone please verify whether JP lower 6 GHz should allow VLP
client operation on AX210, or whether Intel LAR/NVM data intentionally
forbids it?

Thanks.

