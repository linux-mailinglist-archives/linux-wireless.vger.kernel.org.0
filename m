Return-Path: <linux-wireless+bounces-38485-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 98zvHWcARmrTHgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38485-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 08:08:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB16B6F3B02
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 08:08:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fPkUlfjj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38485-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38485-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D8623046EC2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 06:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138B9374E79;
	Thu,  2 Jul 2026 06:08:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E0375ABD
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 06:07:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972479; cv=none; b=sCjkJ8rjMuHvpDw21ZSudovcTirVmsRGzNSyl/D+QcHihRBu6AG3MMWHcEBjYfFrTsLNWMK9p+NbldQyLszJZGs4w6Lsiu+HEdX7R32TVztGBGuqbCERtlwmBzBbLzgAMW6prGjGYirzlocIotJ/gDHH5qgq7bnO4jxsPPRn8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972479; c=relaxed/simple;
	bh=fzGMVpwottawy8SBQS2Dx2K5HqtSwxxWch8ZeUwm1xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2OQK8J9DfU1Pov43K2ctE3uh/ArX0GajLxdAVS3zIP0+Vm/BmuYXhdVUpZZDmi54+LROH3HEBpPrLeLSJ1leVmG1PgazNuatJO8L2swgw54+tvG0EJjEC0+hXv8+HnZ9tgSflAI6eoG/DgxspnsIlAJOrjaBLqscDwSBoMyNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPkUlfjj; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782972474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4UvuXefX8yd84GaG25xUb95oI2RF2HujmNeaEeoIYs=;
	b=fPkUlfjjI/yLicYbuHfasBxutAM4iMuTnkzWE/ljIilKGjxeszaJ5EZE3aOZvHLLFHFeq4
	hTEo0jpQElSo3xRpUK4If3jjO26KOj63iOwnFZWLleyz8pssNdInkmitPX3F/tCr73Yr1U
	RwGeps7gLMwa6OZ1wODyfvCQP5FO964=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-M9B-jmFmO5ib1ycgkmwL0w-1; Thu,
 02 Jul 2026 02:07:51 -0400
X-MC-Unique: M9B-jmFmO5ib1ycgkmwL0w-1
X-Mimecast-MFC-AGG-ID: M9B-jmFmO5ib1ycgkmwL0w_1782972470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9801418C1054;
	Thu,  2 Jul 2026 06:07:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8963E3000C2F;
	Thu,  2 Jul 2026 06:07:46 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jtornosm@redhat.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Thu,  2 Jul 2026 08:07:44 +0200
Message-ID: <20260702060744.478850-1-jtornosm@redhat.com>
In-Reply-To: <20260615112103.601982-1-jtornosm@redhat.com>
References: <20260615112103.601982-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38485-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB16B6F3B02

Gentle ping on this patch.

This fixes a NULL pointer dereference during driver unbind that
crashes the kernel when initialization failed partially. The crash
is 100% reproducible when unbinding after an initialization failure.

This is particularly critical for VM environments with VFIO passthrough.

Regarding the concern from v1 about preferring symmetric init/deinit:
I understand the preference for unwinding init failures at each stage.
However, implementing full symmetric cleanup would require extensive
refactoring of multiple error paths across ath12k_core_start(),
ath12k_dp_alloc(), and related initialization functions.

The NULL check approach provides a safe, minimal fix that:
1. Prevents the crash without changing complex init logic
2. Follows the same pattern used elsewhere in the kernel for
   conditional cleanup (e.g., other rhashtable users)
3. Has been tested and validated in the failing scenario

I've addressed the guard(mutex) feedback from v1 in this v2.

If Qualcomm engineering prefers a different approach, I'm happy to
revise, but no alternative has been suggested since the v1 discussion.

Please let me know if there are any other concerns.

Thanks

Best regards
Jose Ignacio


