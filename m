Return-Path: <linux-wireless+bounces-37883-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wITKAjqRM2q6DQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37883-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:33:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F869DDBD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:33:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NpWxmvY3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37883-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37883-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D1A301906A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 06:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699152E7362;
	Thu, 18 Jun 2026 06:33:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC703290A5
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 06:33:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764407; cv=none; b=kXYzaDwJLFi7LrYG8LU4V8khrwYMI5k9JaUA83U626Js+M1vdcZ1vt07vsLMHLpJMZejqhofq+B/XIPFXuJT/vkVkuE35YOWPNiK1C6siyQgFrDe9XLz12+9wxLhSRVABE45DlYgbtfkwielj64mBfioGUS09z7e4ir5rk/ASv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764407; c=relaxed/simple;
	bh=cl0Kc/B05k+HbszsSbmzQUNh8ZJ5DFzrvMKvTt36hOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ageZ9uVE8NxuaPMF2dtuYmkuOT06WejkzGxEByiwJzD6yu8glTxbxdjPglA017+RBDubYgIUBZe7mfclGlRgiPuknQsZ+c67vYiXTD1+jAFPvQGQifZz/+iwXPBypFeEPOUCIMPL+XaVSl/sDXq+xhJHi0feLqWVy8WFy/CTb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpWxmvY3; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781764404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxEPUDJEb/E2TNBGBdy1DqfUWhcoKOjLbBcYOBP7BPY=;
	b=NpWxmvY38xDrb5s73/nxxYyTbh4iLxNill4ykUtVV65D2+Xa+dG5EGtMi3qvZsD9nFUrEl
	oMleBaXcrhublmnzZ4zkqrH5Ne2ePnU4fiDu4/sy7ctSOia9OydXF2MA14khcp9s0+TEOm
	LiXPl+uTqtg0BsqOdIJM2wtj1lYs2X4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-sZX7nJgjPVaSpqNJyJkT1w-1; Thu,
 18 Jun 2026 02:33:20 -0400
X-MC-Unique: sZX7nJgjPVaSpqNJyJkT1w-1
X-Mimecast-MFC-AGG-ID: sZX7nJgjPVaSpqNJyJkT1w_1781764399
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54C011955F0A;
	Thu, 18 Jun 2026 06:33:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 589073000238;
	Thu, 18 Jun 2026 06:33:13 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: mani@kernel.org
Cc: alex@shazbot.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Date: Thu, 18 Jun 2026 08:33:08 +0200
Message-ID: <20260618063309.9536-1-jtornosm@redhat.com>
In-Reply-To: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
References: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37883-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:alex@shazbot.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A5F869DDBD

Hi Mani,

Let me clarify the exact scenario and where the reset is necessary:

* For the commented WiFi devices (WCN6855/WCN7850):

Standard VFIO passthrough flow (this works fine):
  1. Unbind native driver (ath11k/ath12k/MHI)
  2. Bind vfio-pci driver
  3. Assign device to VM
  4. VM boots, loads its own driver → device works perfectly
  5. VM shuts down cleanly → device can be reassigned → works fine

The problem occurs with unclean VM termination:
  1. VM crashes or is force-terminated
  2. VFIO tries to reset the device before reassignment
  3. Without a working PCI reset method, reset fails
  4. Device stuck in undefined state → cannot be reassigned to another VM
  
     Unbinding the driver again doesn't help because the device hardware
     itself is in a bad state. From hypervisor:
     $ lspci -vvv -s 0000:03:00.0
        03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff) (prog-if ff)
            !!! Unknown header type 7f
     And a full host power-cycle is necessary to recover.
     
* For the commented modem devices (SDX62/SDX65): 

Even worse because it fails during the first VM boot without proper reset
capability, standard VFIO passthrough flow:
  1. Unbind native driver (MHI)
  2. Bind vfio-pci driver
  3. Assign device to VM
  4. VM boots, loads its own driver and crashes:
     [   24.024165] mhi mhi0: Device failed to enter MHI Ready
     [   24.024168] mhi mhi0: MHI did not enter READY state
     
     Unbind/rebind attempts fail:
     [  352.643601] mhi mhi0: Requested to power ON
     [  352.643611] mhi mhi0: Power on setup success
     [  373.442954] mhi mhi0: Device failed to clear MHI Reset
     [  373.442970] mhi mhi0: MHI did not enter READY state
     And requires a full host power cycle to recover,
     even outside of VFIO scenarios.

* MHI Host driver's remove callback may handle clean software state
teardown, but it doesn't provide a PCI reset capability that VFIO can
invoke. VFIO needs a reset method registered in the PCI reset hierarchy
(device_specific, pm, flr, bus, etc.). VFIO invokes this reset both during
initial device binding (before the VM starts) and when reassigning the
device between VMs - without a working reset method, the device cannot
reach a clean state for initialization.



I hope this clarifies the scenario better. Please let me know if I can
provide more information or run any specific tests to help investigate this
further.

Thanks

Best regards
José Ignacio


