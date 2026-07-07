Return-Path: <linux-wireless+bounces-38764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JkJEA14ZTWpbvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 17:21:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D671D322
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 17:21:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iki.fi header.s=meesny header.b=l8F8QZCY;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38764-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38764-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49E5E3044166
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342A3EB0FF;
	Tue,  7 Jul 2026 15:17:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF483EB7FE
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 15:17:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437472; cv=pass; b=MchlsARdfeDHsXW94gxAYaJFl8+Y4dZgaVlvRIPwsuolxCv2weyTbCxVab237TfpptWeCb2kAYI64l7Q0DVODEKyL87zMmfggw3MsOwPQlXXSeM4smPrH3DhqUDWyNhWvl6zkMzN/Vyg3JJF3XrdN15uZLX2psB3vJogRL09ohs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437472; c=relaxed/simple;
	bh=dKWAO3QFtErg5ZVVjKvtV4CveN8ImjdgdFwwbRm5FAc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ne5T/uSa/MtyxTvfJfbZnlLvGu1aL6RFJMpxf5GDuTznwbpZxoM12c86p3wYAslXQDnlkBQ5niV0oisOhf3RcukppEVfZgtThQQCyY8QpmAeMN/8f79+cMIbcyvHlrsfSZFVq9P/RH3bHVs6RxTvBygT0pfdstHKWIwrLh9Nhro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=l8F8QZCY; arc=pass smtp.client-ip=195.140.195.201
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martin-eric.racine)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gvlGF6TLLzySY
	for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 18:17:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783437462; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dKWAO3QFtErg5ZVVjKvtV4CveN8ImjdgdFwwbRm5FAc=;
	b=l8F8QZCYp0ySifyE8zUJoaUcqKB0eIjpdgF66eOe6Z6ZagGev4YcvI3RtlvR4GqZ6qsc3S
	lntfwMHGPoXMLDaRBj8COvF1VJ9ucUhYU3UAMGNR/1cBDof4wsxBRFyc+KAWCExnywLPxE
	tYLI7ejO5HkacvLoDNIk4PmCGdQK0ME=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783437462;
	b=uHA2m/j+8Wfw45jRK9ZDD/PkDeC2vxNHcqKmHb7lQDCDUlYxjZ+gmjU1yfSG3aMYnQOfaR
	47wx/+qp8pxecJ9d42DEjYLXxIGWD9yVa9W0u4TZz0FrQWzHu0D8mfkvK36s4d91mBxXqb
	8nszZq+B/N0KU6tuGWE/1p2fzl1yDlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783437462;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dKWAO3QFtErg5ZVVjKvtV4CveN8ImjdgdFwwbRm5FAc=;
	b=AAr6+4zXkKVJfpembSU4CNtiZhUeFo7h9CWRNehOZbo8JoO8VPQafzZiOPQPSZEf41/wFz
	ITEWD6sqCVf6KFjFrY0p9MumjQncXhzf/NTO9Z0mKoaEUZdsVUQbaMEpHHAk35IIvaoBTF
	cnXlxkf5Si1SnYDBVUpQRRU4ujFSGTE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=martin-eric.racine smtp.mailfrom=martin-eric.racine@iki.fi
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aebf120839so949408e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 08:17:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YzvIYtzU8ZN/6GhSkA4yTTMohZbna00vqSXpdWeRMsvzu7dET4o
	I5QxloVSonW20sY94f4dOnwXgWfgq0UPZzOlUTFGNnAL51wCMbwtsaobDuz5Z1bU1rMJ4JmgbK2
	x7gS3VFjwhY/MX4G7DppgHWR2J7kxJqE=
X-Received: by 2002:a05:6512:3e0d:b0:5ae:d72d:1000 with SMTP id
 2adb3069b0e04-5b00ac66f9cmr709442e87.1.1783437461314; Tue, 07 Jul 2026
 08:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: martin-eric.racine@iki.fi
From: =?UTF-8?Q?Martin=2D=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
Date: Tue, 7 Jul 2026 18:17:25 +0300
X-Gmail-Original-Message-ID: <CAPZXPQcg==8tT8ad7EvPYPJkmpha1_onQEae+opxYVY7HqnnLw@mail.gmail.com>
X-Gm-Features: AVVi8CfgncKsP9T2q1g_rs5PsfZpiK8gVkmriPeKyli97vbZt4MDUGYezYKgXn4
Message-ID: <CAPZXPQcg==8tT8ad7EvPYPJkmpha1_onQEae+opxYVY7HqnnLw@mail.gmail.com>
Subject: [Bug 221733] iwlegacy: iwl4965: kernel oops
To: linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[iki.fi:s=meesny];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:stf_xl@wp.pl,m:stanislaw.gruszka@linux.intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38764-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iki.fi];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,wp.pl,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[martin-eric.racine@iki.fi,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[iki.fi:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin-eric.racine@iki.fi,linux-wireless@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	HAS_REPLYTO(0.00)[martin-eric.racine@iki.fi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 951D671D322

Greetings,

As instructed via the kernel.org Bugzilla, I'm hereby contacting the
mailing list since Intel pointed out that they no longer maintain the
iwl4965 driver themselves and instead inquire on the mailing list.

Martin-=C3=89ric

