Return-Path: <linux-wireless+bounces-38295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NgjfL/NqQmrs6gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:54:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F386DA957
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:54:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Fc9vdqP5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38295-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38295-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8E4330F16EB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C440D583;
	Mon, 29 Jun 2026 12:45:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68075403EBA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 12:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737146; cv=none; b=GF0swUf45jGKbQPTxZEFRtHXAZwpsIRKYMAEtXNZRyGn2WjDQhdjWsVbbUtEbJvEMJfIqyiRE9fHwi3yOsMFBnPTH6egU7ysXWMX/bBxnysZlXI7AtjtCxtbVJuvrUo38rI6tsovW0z/kPne0izE+JFdVmIJI6ssB28EyhEeo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737146; c=relaxed/simple;
	bh=p3kTMu4fBa9i6AMos0fyfESAy0PV9t/FVcjgMXqBgZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKob0XeVkp5uyhu0YBX/l1/NDKYB70iEB+MtsU2+usLRInef7jdt8qsV4Xg3/inaqrKoAse8ohFMxAR5jzFiFxKXZ4XP9PL0DmIZNVdLQRMrVNcPeZXDyu06ot88cHsEgUwaFR2R8oRinSoEXsj6zHX5RWi+75xdQdsE6MuKJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fc9vdqP5; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782737144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuhEen8gsHAm7bxutf0NyUoHt1ddjf2dOLHJF2NAGH4=;
	b=Fc9vdqP5kHehd+Xwm4cEuunMs9rFV6bQ8aGkEND1GBHKL8/VYpoRijuqduNsdlMowYeBsD
	JGm2XMdioWCO7fg47crkOjLsys9VQv4I/Z88cPCY3Xi9JWYSqYmSUkK4n6O6k1IhiPzorj
	wFfQjDzCYw3MXCViUGUy2YnkQaA/D4c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-7OedSLp5P--fSWaWt67E3w-1; Mon,
 29 Jun 2026 08:45:41 -0400
X-MC-Unique: 7OedSLp5P--fSWaWt67E3w-1
X-Mimecast-MFC-AGG-ID: 7OedSLp5P--fSWaWt67E3w_1782737140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3DFE1955F73;
	Mon, 29 Jun 2026 12:45:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.56])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9706518005B3;
	Mon, 29 Jun 2026 12:45:37 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: johannes@sipsolutions.net
Cc: emmanuel.grumbach@intel.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com
Subject: Re: [PATCH 1/2] wifi: iwlwifi: enable MFP_CAPABLE in FIPS mode
Date: Mon, 29 Jun 2026 14:45:35 +0200
Message-ID: <20260629124535.599631-1-jtornosm@redhat.com>
In-Reply-To: <297578c2a1293523a28896f30031db16ccd26bd0.camel@sipsolutions.net>
References: <297578c2a1293523a28896f30031db16ccd26bd0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:emmanuel.grumbach@intel.com,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38295-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 35F386DA957

Hi Johannes,

Thank you for the quick response. 

Since we have some customers requesting this, I'd appreciate some
clarification on what specifically cannot be done so I can better
understand the firmware requirements.

Our testing shows MFP working with software crypto in FIPS mode
(connection succeeds, "MFP: yes" confirmed, firmware reports SEC_ENC_ERR
0x707 indicating it's not handling the frames). Indeed it was working like
this before your commit.
But clearly I'm missing  something important about the architecture.

Could you help me to understand:
- What breaks when MFP_CAPABLE is enabled in FIPS mode?
- Is there a specific scenario (beyond WoWLAN/beacon protection) where
  firmware must handle MFP frames?
- Is the issue that it appears to work but fails in certain conditions?

If possible, I would like to get information at least to justify the
reasons why FIPS cannot be used with WiFi Intel cards (or if there is
some way/approach to make it work).

Thanks

Best regards
Jose Ignacio


