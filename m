Return-Path: <linux-wireless+bounces-37552-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id buPTHm+1J2qt0wIAu9opvQ
	(envelope-from <linux-wireless+bounces-37552-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 08:40:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E1C65CDCD
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 08:40:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aIUCrTlM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37552-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37552-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 999853047373
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 06:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464C3C9EF3;
	Tue,  9 Jun 2026 06:40:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF33CF686
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 06:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987232; cv=none; b=UkasV+QcW3ChIhY8obgM6hQyvdsu2Dtose7LMyh1JXwCw1fX5Vxl3klknTNKDnVp+wrp7j+cexI7kWY+UhHvz5Wieso6zGsSOB3AbifQxlCTKaCCKrb8fzEaW+s8iNFgeZnDPcnWBJhqNP7pUy/ExupqD6xHJunM1SIktcOBT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987232; c=relaxed/simple;
	bh=XBKR43MBL4MY4PqSfuY1MJ8CjvTvAn+/3f1jFPC1VeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBNUmX1MjEBqoULufe+zia4LgvwIY4zH1t6+RL3MLREtUEIL2HCWiM0Ob2/Dw41UnhlkAMGxJM1aO8qhcSqaR9iE11i2q7a2PmkRv4xGQx3njuPxE/SP070eSma4Nu+g5YY3Kpn95kUU8+eg8PtgRA8zVdjXAMGwOZW+0Q3SCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIUCrTlM; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780987230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBKR43MBL4MY4PqSfuY1MJ8CjvTvAn+/3f1jFPC1VeY=;
	b=aIUCrTlMGDIJ2WXKQj369qQPIdMi14wGq/R+3badcYYsE6pRz33ZOx19R5Prf9zu7Bc/3T
	Tevtd9t3/w4KzBoYi8/uA7ZIoQYk7rLF3ljqjxrirDnSv5JbmbL+uvuV0XIKfinTFX4oLi
	l8fzavcrxSJwQUhDGrENzbi357R0sds=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-OswMwogQOBSZEAMPF6MvHg-1; Tue,
 09 Jun 2026 02:40:24 -0400
X-MC-Unique: OswMwogQOBSZEAMPF6MvHg-1
X-Mimecast-MFC-AGG-ID: OswMwogQOBSZEAMPF6MvHg_1780987223
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81C7A1800D9C;
	Tue,  9 Jun 2026 06:40:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.77])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20BEA3653A;
	Tue,  9 Jun 2026 06:40:19 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Tue,  9 Jun 2026 08:40:16 +0200
Message-ID: <20260609064018.28434-1-jtornosm@redhat.com>
In-Reply-To: <973da9e9-3851-4e00-85d4-28140c039127@oss.qualcomm.com>
References: <973da9e9-3851-4e00-85d4-28140c039127@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37552-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17E1C65CDCD

Hello Jeff,

Thank you for the feedback.

> My preference would be to fix the logic so that the deinit is symmetric with
> init, and if any stage of init fails, it should unwind whatever init occurred
> up to that point. So this patch seems to be a bandage instead of an engineered
> fix.
>
> But I'll let the Qualcomm engineering team give their opinion.
I understand the concern about symmetry.
The NULL check approach is intentional here. The ath12k driver has complex
multi-stage initialization, with many potential failure points.
The init/deinit paths are symmetric - destroy is called from the same
cleanup paths as init.
The issue is that init can fail partway through, leaving some components
uninitialized.
The rhashtable pointer itself serves as the initialization state indicator -
it's NULL before init and non-NULL after. Checking it directly is simpler
than adding separate state flags that must be kept in sync.
That said, I'm open to alternative approaches if you see a cleaner way to
handle partial initialization states across the driver's initialization
sequence. Happy to revise if there's a better solution I'm missing.

> not a fan of this pattern.
> if we go with a bandaid solution then i'd want to use guard(mutex) so that
> there isn't a need for a cleanup goto -- we could just return like the patch below
Agreed, guard(mutex) is cleaner. I'll incorporate this in v2 once we align
on the overall approach.

Thanks

Best regards
José Ignacio


