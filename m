Return-Path: <linux-wireless+bounces-15842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333689E1540
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 09:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E684028235B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32518A921;
	Tue,  3 Dec 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZTq1jZi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C51A4F2F
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213060; cv=none; b=PWPj6RNCk3JxIdQf6gbeItRcDTWKaDKReDFOfUa/u1mU7QZKVUiag7TM5t4Td3yNzxiWD/UpwtPN9xntaTOTq4AIm3T4ahSdcl6JoreyhXTz3JTlxRrhqUskVpH1TCsYrTHrCohraPyiPtCSZt2n3xjm19Ht2oQUxnd/nhfqtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213060; c=relaxed/simple;
	bh=EUnucm2fTy2CjmZdyCADxmI4mKYutrlWNpBYbKjw3IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ0hCJtbpO1yLrYyXqcm3MLVmK8FTKzfKd/DID1wBn8OkzgyyzWY5xPfA++WAwTeqs2rPZa+b/zMSPG0belqaqs2vw7A6Tg4wz7E7dE7YgjZ223AfZ+IDQFICRSn6X5aLOJyjvUatHDqT73zAJfjU14ZX7hkxEJnv/dPvUgWwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZTq1jZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733213058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUnucm2fTy2CjmZdyCADxmI4mKYutrlWNpBYbKjw3IA=;
	b=BZTq1jZiMM8cRIFbog0Qakho8005qk4UoB/9RCFL5QAF8TnEu9Jrsih3a/YEibEp5Aruy0
	A7yCfqTTpG6QMbWVLMb6xvHz3MRFUTO3fWkxcVaSWHc8MZOmervZIqSzYQqO/4B1vOlKuQ
	JcFywekr8Rd+T/ZEfv2rL5xK8TNdRm8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-AYhAh3tjOcC4wCg3CCkrFg-1; Tue,
 03 Dec 2024 03:04:14 -0500
X-MC-Unique: AYhAh3tjOcC4wCg3CCkrFg-1
X-Mimecast-MFC-AGG-ID: AYhAh3tjOcC4wCg3CCkrFg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E6FD19560BC;
	Tue,  3 Dec 2024 08:04:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.136])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C10E1956054;
	Tue,  3 Dec 2024 08:04:08 +0000 (UTC)
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
Date: Tue,  3 Dec 2024 09:04:07 +0100
Message-ID: <20241203080407.100913-1-jtornosm@redhat.com>
In-Reply-To: <7ccd4b98-9557-4a8b-b493-e01b157c71e2@quicinc.com>
References: <7ccd4b98-9557-4a8b-b493-e01b157c71e2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Sorry, but your solution is not working for me.
We need to be able to setup 2 APs, as it was possible before, and with your
interface combinations it is not possible either.
I was trying to create a second interface combination to recover the old
scenario as well, but I couldn't, that is the reason why I have implemented
this parameter.

Thanks

Best regards
Jose Ignacio


