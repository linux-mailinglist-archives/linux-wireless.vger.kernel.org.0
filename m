Return-Path: <linux-wireless+bounces-15864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED44D9E2791
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 17:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B165D287DB6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930041F4707;
	Tue,  3 Dec 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzBZYFBJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EA2B9B9
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243652; cv=none; b=Db3GmnfgVX9Kaa35B1GJqhLkVbRXMHe/EoglmexDs87oHNY2yPWzeIC53+NvhlaicmHhzDKt5o4Hs52685nPWwWeRnADQwXZJbK2w63RMOYpSZhHRK1OSRCtizQZE4lwdiLYAxRnMxLj6kazwdl/qoOxHvMJ3ayERKVZrVhgAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243652; c=relaxed/simple;
	bh=myVDv30I2SCONJYjABsPOWsgsgA2VSl9rzh6uno/CuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbk+dggJEkqiCsq8NpAeB+LrVt4liZNn71Run1IUmTWsIGGW+s0cjz209yNjkWGPWNsxipGcaWAvpRMXXRnNhuLNz99maA1nRWp8+XDY69Vbhnr/KG4B6QnSmz4eo2SLgtHuCHxmmJVUSQN2Wvd+OP8NcFwTipdDxKBgZHeOSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzBZYFBJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733243649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mYdcOoxeqZZGRp6kvkCtVM0EbJxxztYUGd4BIrXpSc=;
	b=AzBZYFBJ4flhlj76u2h2Rhw5wffsfSCxSLz9V+Csgra1GL444hbLE6+2hQ/2kh9smfRzr+
	rAkkVDli84zCsxNIGLgbfSKql4IFHdByZTiggbAps1xJ+L9QC1c6Nr0ixZW/Gc/x8CWGqy
	tWVEueXbe24y5tPU881r92h3ldsA2Sg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-Jk__6YEwMoOD-Q4DlTyP-Q-1; Tue,
 03 Dec 2024 11:34:05 -0500
X-MC-Unique: Jk__6YEwMoOD-Q4DlTyP-Q-1
X-Mimecast-MFC-AGG-ID: Jk__6YEwMoOD-Q4DlTyP-Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35A7A1958B0D;
	Tue,  3 Dec 2024 16:34:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.136])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4F161956054;
	Tue,  3 Dec 2024 16:34:00 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_cjhuang@quicinc.com,
	vbenes@redhat.com
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Tue,  3 Dec 2024 17:33:59 +0100
Message-ID: <20241203163359.129185-1-jtornosm@redhat.com>
In-Reply-To: <99359cc4-2279-4a8a-80a1-d5475fd5208d@quicinc.com>
References: <99359cc4-2279-4a8a-80a1-d5475fd5208d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

> And you want setup sta + sap + sap, right?
Your proposed interface combination fails as well for me if I am just
setting 2APs.
> When up the second sap will meet error? Could you pls share the error
> logs?
This is the log that is appearing:
[   61.909165] 8021q: 802.1Q VLAN Support v1.8
[   62.227530] ath11k_pci 0000:01:00.0: failed to create vdev 3, reached max vdev limit 3
It is appearing after configuring both APs when only one AP is up and when
both are down (see my previous 'iw dev' outputs).

> I'm not very sure if you add all interface with managed type, and do
> "ifconfig xxx up" before running hostapd.
Yes, I am setting the link up before running hostapd.
>You can try add second and third interface with
> "iw dev xx interface add xx type __ap".
And yes, I am doing like that for both APs.
Please, take into account that everything is working with the old interface
configuration and when it is set with the parameter (no error log), but it
is not working for me with your interface combination.
Have you tried with 2.4GHz band?

Thanks

Best regards
Jose Ignacio


