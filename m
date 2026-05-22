Return-Path: <linux-wireless+bounces-36785-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICs2M2j8D2qCSAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36785-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 08:49:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 344F65AFA8F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7563E30177AF
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCE3502B8;
	Fri, 22 May 2026 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqaLTmFH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608327E045
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432548; cv=none; b=T54ayunyif3BV0eDe8HZgDtQLWmrX9PMpZNMcWEaPijMFAY7al63x2A0+7jhta9Zrxsm3CTsHcbbIqRAbQrl+rTkQSel/EfnPwTIN50MzIdyxI/yd/mgSrRgb+o9bgzdzhfzASRWmrfLSPS29/OSEiCYM49uksIxQgkBtmGJfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432548; c=relaxed/simple;
	bh=BCaBxs0ytwR14idu/LE2WlR87+13hVDE/LzvxugRAhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPlqlUoPo4VusEYrw75TBQvYHYugm/FmKj7OQvD7SE3B1fKKtv6kYnF0KkgZHwID+ODnLg4YmG5LgLBH4QweGqmpojzoPVZO6hVg1EALuo1BAOoCBW4ekefgq4bLi4iMXPlbOEMUkKEXANVwblwub+baPJtK9qEQDzC9FA7vOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqaLTmFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779432546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08GD5FnVc7SUxNkQ3OeIOdIy8gx67eouJZS3Q8GyD8c=;
	b=YqaLTmFHLHJ89QN7KfDVklyUQU2XvE8FAIbjn9Lqi6PTKBVx/NMLPGbcm7csMxtKowrrJ7
	/8TUdLfwbiTUfALOIEZiiIGe+fm9T3s8zMzuw6y4Fu/OpvAPRe4y+LMr6ki9cMrfQWSYlm
	zBQhB8ne9Hh5rs7nOQgouJ29zP9f4MY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-AanC6XFBOoWUpB6lctE_Xg-1; Fri,
 22 May 2026 02:49:03 -0400
X-MC-Unique: AanC6XFBOoWUpB6lctE_Xg-1
X-Mimecast-MFC-AGG-ID: AanC6XFBOoWUpB6lctE_Xg_1779432541
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F2C61956094;
	Fri, 22 May 2026 06:49:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.37])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 055C21800352;
	Fri, 22 May 2026 06:48:55 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: helgaas@kernel.org
Cc: Ryder.Lee@mediatek.com,
	alex@shazbot.org,
	bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com
Subject: Re: [PATCH v3] PCI: Disable broken FLR on MediaTek MT7925
Date: Fri, 22 May 2026 08:48:53 +0200
Message-ID: <20260522064854.201976-1-jtornosm@redhat.com>
In-Reply-To: <20260521161932.GA167656@bhelgaas>
References: <20260521161932.GA167656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36785-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 344F65AFA8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Bjorn,

Thank you for the feedback.

> How do we know the device is an "undefined state"?  Does it just not
> respond to config accesses?  Is there something in dmesg that shows
> the problem?
> I suppose it's similar to 81f64e925c29 ("PCI: Avoid FLR for Mediatek
> MT7922 WiFi")?
> I guess I'm just looking for some text more specific than "undefined
> state".
You're right, "undefined state" is too vague.
I can prepare v4 with what I've seen is happening . The
symptoms are similar to MT7922 but not identical:
  **First VM start (works fine):**
    mt7925e 0000:08:00.0: ASIC revision: 79250000
    mt7925e 0000:08:00.0: WM Firmware Version: ____000000, Build Time: 20260106153120
  **After force reset/VM crash (FLR attempted, firmware communication broken):**
    mt7925e 0000:08:00.0: ASIC revision: 79250000
    mt7925e 0000:08:00.0: Message 00000010 (seq 1) timeout
    mt7925e 0000:08:00.0: Failed to get patch semaphore
    (Repeats 10 times with increasing seq numbers)
    mt7925e 0000:08:00.0: hardware init failed
Unlike MT7922 which shows config read failures, MT7925e config reads work
correctly after FLR (lspci shows all capabilities). However, firmware
communication is broken - the driver cannot acquire the patch semaphore
needed for firmware initialization. The device remains broken until
physical power cycle.
Secondary Bus Reset (fallback after quirk_no_flr) successfully resets the
device and allows reinitialization.

> Can we get any of the MediaTek folks to comment on this:
> https://sashiko.dev/#/patchset/20260508145153.717641-1-jtornosm@redhat.com?part=1
>
> Sashiko suggested that Device ID 0x0717 might have the same FLR
> problem.
I don't have that device to confirm the same behavior. I'll wait for
MediaTek maintainers (now CC'd) to confirm whether 0x0717 exhibits the
same FLR issue. If confirmed, I can add it in a follow-up patch or the
next version.

Thanks

Best regards
José Ignacio


