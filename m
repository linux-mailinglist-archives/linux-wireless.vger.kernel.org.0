Return-Path: <linux-wireless+bounces-38291-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gutsNtpiQmrl5wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38291-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:19:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE3D6D9F82
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 14:19:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Men4FEOs;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38291-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38291-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ADD8300118B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F2314B6E;
	Mon, 29 Jun 2026 12:12:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26EB3BB4A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 12:12:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735145; cv=none; b=nTeI3uWOsYAaTNU8ca7pdRsP9hugJlpNJaAJnOGks1bGclcGsBCjFAPvkAVC9izYoFGifbsmq6R5Gkh5nfivcEEqGIvXfEwiNyzp8ptZ3mEcWUaPtKdZr8Rr1wvzmThF8EmbsE7GPp9QTGoWNFVORzdbR8dsRvBxb5A8L5/i9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735145; c=relaxed/simple;
	bh=XtGxf+5aDal/WtBKt7lgKKKf3R35RuELt/a3Nj1ryio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLQxwG//1AiiMQoVlS2bcCZTA5zCnivHvwqKcjFKpQSTTlzpxzyQDkwrdHSp2HXAMkrNokKPsE6I6W2OeBgLrccUFyTkwNtMKmVa0H8bAm64jpM1UnOBhL/FdgNcfOk3JqS1NsOYTifr9LS1GlPHgdDG6co9SWZzO+BV7lcXMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Men4FEOs; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782735142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tET1GxODJ+iBQSEPXEqBWD/ZI7nKPc3wxOhFSuZ3QEg=;
	b=Men4FEOsD9ZL3zdXmmO6+/K4y4VJl3Ykua8J2somhhmPowGZcutGmD0QNgGYfIoibC0l7S
	eLxuTUPkA0q7h7fQgJpErZXuP3i0E4EQ+weWinlEQKEq1Y2BG8G+NC7/74JgL9zBM0HF/G
	xMLEGp49ixqEs3n6MAWXzxY1h8RaZt8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-0Gf2hTPNPyCYuOz-Bi24hg-1; Mon,
 29 Jun 2026 08:12:21 -0400
X-MC-Unique: 0Gf2hTPNPyCYuOz-Bi24hg-1
X-Mimecast-MFC-AGG-ID: 0Gf2hTPNPyCYuOz-Bi24hg_1782735140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 121E718007F4;
	Mon, 29 Jun 2026 12:12:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC384195608F;
	Mon, 29 Jun 2026 12:12:17 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH 0/2] wifi: iwlwifi: Fix WiFi operation in FIPS mode
Date: Mon, 29 Jun 2026 14:12:11 +0200
Message-ID: <20260629121213.597038-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38291-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:emmanuel.grumbach@intel.com,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFE3D6D9F82

This series re-enables WiFi connectivity in FIPS mode for iwlwifi by
allowing Management Frame Protection (MFP/802.11w) to work with mac80211
software crypto.

Currently, iwlwifi connections fail in FIPS mode because commit
0636800c8ee1 (("wifi: iwlwifi: disable certain features for fips_enabled")
disabled MFP_CAPABLE when fips_enabled=1. The testing shows that MFP works
correctly in FIPS mode when mac80211 software crypto handles IGTK encryption
/decryption using FIPS-approved AES-CMAC/GMAC algorithms.

I think the original concern that "MFP since some frames need to be handled
in firmware" can be avoided for normal STA operation. The firmware-offload
requirement appears to apply specifically to features like WoWLAN and beacon
protection, which remain correctly disabled. AFAIK, for standard client
connections, management frames are processed only in software and mac80211
provides complete IGTK handling.

Patch 1 re-enables MFP_CAPABLE for iwlwifi to allow basic WiFi client
operation in FIPS mode. Patch 2 reduces a misleading warning message that
appears during normal FIPS operation to debug level - the warning actually
confirms that frames are not processed by firmware and are correctly handled
by software crypto instead.

Testing on Intel WiFi 6E AX210 with fips=1:

Before:
  # cat /proc/sys/crypto/fips_enabled
  1
  # iw phy phy0 info | grep -A 10 "Cipher"
  Supported Ciphers:
      * CCMP-128 (00-0f-ac:4)
      * CCMP-256 (00-0f-ac:10)
      * GCMP-128 (00-0f-ac:8)
      * GCMP-256 (00-0f-ac:9)
  # nmcli connection up SSID
  Error: Connection activation failed

After:
  # cat /proc/sys/crypto/fips_enabled
  1
  # iw phy phy0 info | grep -A 10 "Cipher"
  Supported Ciphers:
      * CCMP-128 (00-0f-ac:4)
      * CCMP-256 (00-0f-ac:10)
      * GCMP-128 (00-0f-ac:8)
      * GCMP-256 (00-0f-ac:9)
      * CMAC (00-0f-ac:6)
      * CMAC-256 (00-0f-ac:13)
      * GMAC-128 (00-0f-ac:11)
      * GMAC-256 (00-0f-ac:12)
  # nmcli connection up SSID
  Connection successfully activated
  # iw dev wlp7s0 station dump | grep MFP
  MFP:        yes

Jose Ignacio Tornos Martinez (2):
  wifi: iwlwifi: enable MFP_CAPABLE in FIPS mode
  wifi: iwlwifi: reduce encryption error message to debug level in FIPS mode

--
2.47.1


