Return-Path: <linux-wireless+bounces-32570-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEulAWLLqWkgFQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32570-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 19:28:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72906216F6B
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 19:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66E7304C054
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9EF347FDE;
	Thu,  5 Mar 2026 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpdj3gRb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2128F935
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735327; cv=pass; b=NDkJeVFaMLZvGoeqlolK4hFCOEl+zkyslKwX0OP/SQKYX7kThuYURiBm3SDUjzQUUkI00BZrdUjDKEK8XDyOXqINLl2Wdgdv8rhixdnOMmY4rwIrN7lNUaiqqESG/4NWhzr+GdI3/F4aLgQ31oTu7GO2bbKSN0991PZeEeOCIrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735327; c=relaxed/simple;
	bh=UKa7OBuXlhiYppViPcYm6FxX5GPA+bRGTzYFcrhx1po=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FwdvPUPA2Bl6YWrkMMQo2cyOzs4p9J0FBDbcs0+HisO/sPUjGHDQYBEegqV1XmsbduWO6CKE1t5MVEQ00r4ITuJiCmMgRYFc38+2ujy3ATB5zu3Cvt4AyTTqa1Jz11+A4m/0PnYxg7IJZtKlqw5RQNOw8xzIY+9tSX1Ixv3bTH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpdj3gRb; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899e85736e2so54200076d6.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 10:28:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772735325; cv=none;
        d=google.com; s=arc-20240605;
        b=TlNUYMt6cjegyBvTc0RP3vIDTOWOREGYu+zm59lFPwyHkEhkGfV5O0JlwYphfjYWQ6
         cvDVzSJoav1mgV2xO98R1Iva6KLjj877Bch0MK7w+jjG4dKDT3YOGSgLAMHd2GOP0Jh/
         Ea5LIzo60wnEkL6ssop5NLhVTy6zVpoNOcE1jQ8T2X0hHBgLWQY2CsWgFroEtj0Zw0Fq
         BUAcwf+O6NuZvkJjl42tfSTJCSf+4zjmg7zDeHV58OToOI9AEl286+pV36EP6LTWo7ym
         Nn9Daqx8duEsNjkNowP1CburC3XeocnKu8aQqjH0TrgvyEW+dxRF7uUtBSZbf9Pp174w
         O8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UKa7OBuXlhiYppViPcYm6FxX5GPA+bRGTzYFcrhx1po=;
        fh=//PYnKy/9Jo8hZhsxALj/rZhLjj2uDQgdX8D5IYfQhM=;
        b=kstCXCC2f123+cUO45dkiIwxlu8lQiSrvJOv/cDelLPRuhtx2GZuHk5mrSPAZ2eALP
         pALumyrbaHlxvvkA1Y1RSFRukwmsGUC2pEUFIEMxiRaQuiwrBXdjnXxNN2qllBWPlTPm
         UT7eYdvnbHRO6c6o2pwwuggTQggq78451dd6zumGrsleqEKT7BZA9v1vcRtTxT4fI3HF
         JkRMjz2vcHa4lIA3BSnNOXRHige3nKK3RirPndTqkEyJIhLldgC1VpTFPOr8r4m32H1v
         SObDIQdymlmrNyORbrWsk1ICIXH6KRXUBgQI2rL+Va9pS7wNGaB0MkLkEvLEkK0xhIgw
         W2JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772735325; x=1773340125; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UKa7OBuXlhiYppViPcYm6FxX5GPA+bRGTzYFcrhx1po=;
        b=lpdj3gRbLmGv0ONL7MIuwKl3rKgwoo1c3U/MHt11B/cWXR64gA7EGBJhFAlcfQ7mfe
         vhXZ9eYVoyuz2qmD1uqlpg6ByzfTsBgKinKOtCrKo025bnJHRTl81ne8WhNd1iYsWATR
         VlD/R7Cmfam/gmQjEPBu/w89eAF7ngHGIPsNrs78sj+Uu3CpFGKwaOcjTLFjXKlO4YPQ
         4ej6S+lSmvuP5nM8tL7xwY/jiQdqGGO3uDwdCeq0ay2Itu0JczL85AvSZR+W3885HLiC
         GibS8rULxG0S/31z96DprlxQia0h7ma83OhTAoL5ouIss1VdrN5p5krAKPWmYp7T9LX2
         R/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735325; x=1773340125;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKa7OBuXlhiYppViPcYm6FxX5GPA+bRGTzYFcrhx1po=;
        b=ki/2KVN+73F6DPFIZAoigvyXmXIm3x3qX7fYdpgqGDoJqeWi/ntoWOwMWMQwF+VYEQ
         sgMYZdWGT99HgmC1ZC7hwjuxvA153t6l4t+n+T0z0MUmiyvilC764h5BMP9C232BmcNV
         IQil7zk/QevHGV1xTvnmRZZQhIsdITNDBfYQFsj7Tl5McxMMfATzygKbd/IRQ8N3XEZ3
         wkAoe0/P+c6bpzsBMrLpEVpryGORMh1C1sOoozVJacJjcSkj9r57FEq7XkDD/rear/+m
         oNZu5np1DQ89uXeAjQbfcKy4GeQrNQugR2W5pRU1R9Qfl37nAce5TbibFvzrkKbeg3qG
         BXFg==
X-Gm-Message-State: AOJu0YzDlHcipeqcNXTY/rlg4iB+LZqpAF9b+pwYBiq3zIgOjWPg8HsX
	Es6lEbBKAZJgrRZjl8zpK5nW6egKNS6OyQt6BqqKMBOdAB8BWFIBxcGLvdg5XtnzJLlKUMo4CTr
	MuMzRUHcDGw3PoFP/iYqk3oJFikFiQMtpjME=
X-Gm-Gg: ATEYQzyIg738MAmsknk5oQLB/QNUO5WJAvbXDFAIhsrkJCR29CpaQXlLOAGODORg+U1
	q+M0qkMF+N0eRFJ4uVEA7OlLVS95UvHvg3mpGTPd5fLhRz4S1lNi0LZeKa31kqFbfXG1KCDRwK+
	NewLQBKpSQ46UiMD2nE1Ks9pfEWfxS/TzJoD9Iy0VZ3LeydxnlHDLI8pnjkr/Ef5sAnsNifsyp6
	LnPAezIIsmg94xwk0F7cJR0oi22y0+QrqFagCHcqPLiSPF7oFXVXPBKKaoAOBEb64v+8gELwTuk
	guBvtbTx/yb+gVWEyw==
X-Received: by 2002:a05:6214:27e8:b0:894:61c9:9793 with SMTP id
 6a1803df08f44-89a2459cfd3mr47521786d6.5.1772735324778; Thu, 05 Mar 2026
 10:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick <morrownr@gmail.com>
Date: Thu, 5 Mar 2026 12:28:18 -0600
X-Gm-Features: AaiRm53YdoeApTjb7fRQO8VIER6oJvT9SZByNtKWHk9PwbYpEuJm5SxjTEv_7f8
Message-ID: <CAFktD2eaVpRAJRkaGOj4y-m0woK-sNeCM+h_7A=9GELSce6TcQ@mail.gmail.com>
Subject: [BUG] wifi: mt76: mt7925u: probe with driver mt7925u failed with
 error -110
To: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 72906216F6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32570-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Reference: https://github.com/morrownr/USB-WiFi/issues/688#issuecomment-3999038526

The above thread is rather lengthy as we have been working on this
issue since Dec. 25.

Testing with a Netgear A9000 USB WiFi adapter (mt7925u driver). Kernel
7.0 rc2 and a x86_64 system. Additional testing with older kernels was
also performed with the same results.

Problem description:

Cold boot shows the adapter coming up and operating normally.

Removing the adapter from the USB port and replacing it shows the
adapter coming up and operating normally.

A warm reboot does not provide a WiFi interface and shows the
following in the system log:

mt7925u 2-3.2:1.0: probe with driver mt7925u failed with error -110

Using the commands rmmod and modeprobe do not provide a WiFi interface.

Thoughts: The problem likely is not the module teardown. The problem
seems to be that the firmware (or the mt7925u driver) leaves the
adapter in a strange state such that a power cycle of the adapter
hardware is needed before the mt7925u driver can properly initialize
it a second time.

Also: Testing with an adapter that uses the mt7921u driver does not
show this problem.

