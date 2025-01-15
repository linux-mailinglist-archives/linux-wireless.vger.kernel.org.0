Return-Path: <linux-wireless+bounces-17550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B10A12355
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309073ADCD6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C2241A18;
	Wed, 15 Jan 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQsbH4i5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0209241A12
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942113; cv=none; b=PKMRe/rLJnMNd7ys09TqiRU/A/o58gEMWL2XA3palDxlX0YnkKGSOlQ/gjWKvc2IB1MBOCQfBAg7jZ+hS1vUtZWI6B3W5L3sKvz5Q9XdJCXu1hEC0C5Zt3HxVx4Jq4wVoNgj168THhOKD7kiiw3jg63yP8OtC2jKzKknoARj0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942113; c=relaxed/simple;
	bh=5jdBVcuRYAYKm88V5FWgOWQsPFO7ecaB/oY1YierEEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeqPrXLAtpulEHU+E4VsxRxdCbJhlD/WyT1HcNOQhXsWbWXMERKq8ErL3nh+/NPKpSAsQSMhFDwyRsMpbfAVb9U/aCIcj2UeFpuSmyV+staMHWQgcirWB4rOG7jwxAmTYFu4DOSFuXjZGfwTtsTAoT87UK58L2t/sLXyxb19hJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQsbH4i5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736942110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WZ3HqHzhCeXbjJNpUFTds2GJZaGaXWIORjllCaEmy4=;
	b=SQsbH4i5V0hwIxH+0bMI7I0UyrwFIkabZKVeAoNHUwGK9lddXwh7w827Aw/o+KRmxXwBuG
	xgVr40+tct8q2t8jtnMVpuAVzyMItnuG9xaPCY6PO3OqgvQyiUfD7xU869gsV7fmYMJ9vm
	6wglxB/mKuKizwLUTdpHslBMLpJoUU0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-MVFhiMHMP4ecDAVoAD_tyg-1; Wed,
 15 Jan 2025 06:55:07 -0500
X-MC-Unique: MVFhiMHMP4ecDAVoAD_tyg-1
X-Mimecast-MFC-AGG-ID: MVFhiMHMP4ecDAVoAD_tyg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F0871955F67;
	Wed, 15 Jan 2025 11:55:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.171])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B8CC19560A3;
	Wed, 15 Jan 2025 11:55:02 +0000 (UTC)
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
Date: Wed, 15 Jan 2025 12:55:00 +0100
Message-ID: <20250115115500.136864-1-jtornosm@redhat.com>
In-Reply-To: <4ef22e4e-1ef8-4c16-ae01-06adf23415f8@quicinc.com>
References: <4ef22e4e-1ef8-4c16-ae01-06adf23415f8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Yuriy,

It is just a matter of the number of resoruces available.
But before any further investigation/adjustment from us, I would like to
confirm that your interface combination is what it is going to be used
(I haven't seen it in ath/wireless/wireless-next/...).
Are you going to proceed with that? 

Thanks

Best regards
Jose Ignacio


