Return-Path: <linux-wireless+bounces-17546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87279A11E69
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBE718849C5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895A1DB14D;
	Wed, 15 Jan 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLDUbx6z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AF248166
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934409; cv=none; b=s3Rwv4RE+NsYqkvUvtT4jzopdSMPQOZRmlXw7Ex0DrBBUuEEjxgWwXsQkXhQ7hwDC/Cbk2+1G4bth+b7DYCUxw6eaajMp4Joj+r42iQ0CkzyXQruPqJoLZI788Qbx6GXDagGk3hi9IhCQdIlkpN2+GYqDMm2yjmTAR5BMHbYpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934409; c=relaxed/simple;
	bh=RxUWxCt7rcX0HrQOs3U5ych9ofEKteYsHZaooyka2pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF0NnikAdyQa0d4xlIZ4xZ1SYtc9+JpHGs4z3Ue6Cn8EUsvKmvKxvhEdYBJx52CrPtCCnwV1JF5Y4SHxftjeyemgpn2XvWAzi/GGXVH43Y64R2zg5+elf5IX6hwYGw2ouftApbV3IyJzyfCMj4/wBIaW3pAQwlj4YMhWiGPsHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLDUbx6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736934407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxUWxCt7rcX0HrQOs3U5ych9ofEKteYsHZaooyka2pc=;
	b=XLDUbx6zVaKnuUWjlLWIXsD0n001Qxn6uKeudL51sIzV6wo4XCoOd5e5eoIkboGX4DijHM
	eKlRaDaeIKEO27ggAxvQ6KfH2lDd76+XudPApSzzg5YwIkr6b6RAAoCP99e43Q7EpWcXy6
	5kP4D3NnvgIMZRWUdu18qEOLWSAGGn8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-A04rJFB3NHqB92hmB2wNAg-1; Wed,
 15 Jan 2025 04:46:43 -0500
X-MC-Unique: A04rJFB3NHqB92hmB2wNAg-1
X-Mimecast-MFC-AGG-ID: A04rJFB3NHqB92hmB2wNAg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08ABC1955D80;
	Wed, 15 Jan 2025 09:46:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.171])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 567BF30001BE;
	Wed, 15 Jan 2025 09:46:38 +0000 (UTC)
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
Date: Wed, 15 Jan 2025 10:46:36 +0100
Message-ID: <20250115094636.132250-1-jtornosm@redhat.com>
In-Reply-To: <52a3efe8-c550-4494-af63-6b8c6894e7b5@quicinc.com>
References: <52a3efe8-c550-4494-af63-6b8c6894e7b5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Yuriy,

We can debug/configure NetworkManager on our own to get what we need.
Now, I am just trying to get a solution because at this moment 2APs can not
be configured as before.
As I commented, if you want to have a common interface combination, please
go ahead with yours, and then we can see.

Thanks

Best regards
Jose Ignacio


