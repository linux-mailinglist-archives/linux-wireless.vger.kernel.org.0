Return-Path: <linux-wireless+bounces-39083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dWpdBYRdVmp/4AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:02:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC2756C25
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:02:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hubTa0Kl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39083-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39083-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8352C3007A58
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F54A340E;
	Tue, 14 Jul 2026 16:02:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192944A3414
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 16:02:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044925; cv=none; b=ASufB/NSQShJrKoCW+op0bveZuPrmyh4S6tjR+HZAG8/VYID5BUAHlcKSfjLIywvfMgP5LMNJ50lYGpdloFeV5D4WdoEISIYUNYN9aYCK3yUhwH592tQ+B92ZIEvSC2APpfhJ6Grde4qHJexLVLzsZI8oQEQU0hGjXvqX2glFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044925; c=relaxed/simple;
	bh=m361MEpggYpmPipDNdYkkulCU0rfyOSsiktSIXOvzms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2WZr9WxggVhc41xzrnPpyYUM8mGYi69DzUHWkQjyxaF5T+yY0bsZIMQVMKW96afaiRERpu5vMx5K/tZ3CnOfR1i/MIXNf2hFck4O/myGFotH1k7vyRBibPSd3GCFQjnjWn4Vy9EEES7z/1JiYoLs4ZfoSfHb0pdwq0uZABdOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hubTa0Kl; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784044922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUNNWibDn/BZBN0Yj4RGfEkbU3xIBSd6uXOb2mPy2/g=;
	b=hubTa0KlvA9ryT+X25IJu5YJF5zj7XTNcM9EazlQDhofCmwEo1OTfhOmdSJsHMG3NG9HnU
	+VjHuE5hRmQYuWGDaYGoOE2K4wbm6D0SOxBiE8uLopf9efROOPX5b78qSc0p1QZ/Veg5//
	LKZvBXZnygQKJr+cmX/X8UCFAj8nu60=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-diT3p4VAOaiuz_tn0sAkyw-1; Tue,
 14 Jul 2026 12:01:58 -0400
X-MC-Unique: diT3p4VAOaiuz_tn0sAkyw-1
X-Mimecast-MFC-AGG-ID: diT3p4VAOaiuz_tn0sAkyw_1784044917
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 763801956070;
	Tue, 14 Jul 2026 16:01:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98E2918005B3;
	Tue, 14 Jul 2026 16:01:53 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: tamizh.raja@oss.qualcomm.com
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath12k: implement custom wake_tx_queue with flow control
Date: Tue, 14 Jul 2026 18:01:51 +0200
Message-ID: <20260714160151.664019-1-jtornosm@redhat.com>
In-Reply-To: <CABkEBKZABhFkS9MVqbeRFHLUXoNaJC-qocmcPVmZ8ov2j+DMzw@mail.gmail.com>
References: <CABkEBKZABhFkS9MVqbeRFHLUXoNaJC-qocmcPVmZ8ov2j+DMzw@mail.gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-39083-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3FC2756C25

Hi Tamizh,

Thank you for the review.

> This assignment is wrong and all traffic is incorrectly steered to
> radio[0] as ah->radio is a flexible array, not a pointer

You are right, I will fix it in v2.

> tx_ring/tcl_ring selection should be corrected.

Yes, as also pointed out by Zhi-Jun You in the ath11k review, the ring
selection in wake_tx_queue needs to match dp_tx in a general way.
I will address this for both ath11k and ath12k in v2.

> Do we need this spin_lock_bh?

Yes. Without wake_tx_lock, there is a TOCTOU race between checking ring
space and dequeuing:

CPU A: num_free = 1   (sees 1 free slot)
CPU B: num_free = 1   (sees same slot)
CPU A: dequeue -> dp_tx (succeeds, fills last slot)
CPU B: dequeue -> dp_tx (fails -> -ENOMEM, frame dropped)

The tcl_ring->lock inside dp_tx only protects the descriptor write, not the
check-before-dequeue sequence.

> Do we need this check and spin_lock here? already ath12k_wifi7_dp_tx()
> has this lock and fetches the next entry. Can we check those return
> value here and break the loop?

We need to check before dequeuing. Once ieee80211_tx_dequeue removes the skb
from mac80211, a dp_tx failure means a dropped frame. Checking num_free first
avoids dequeuing when the ring is full, which is the whole point of the flow
control.
In addition, tcl_ring->lock is required by ath12k_hal_srng_src_num_free
itself, which asserts the lock is held.
The brief lock also ensures an accurate count synchronized with dp_tx on other
CPUs.

Best regards,
Jose Ignacio


