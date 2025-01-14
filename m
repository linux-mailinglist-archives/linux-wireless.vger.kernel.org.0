Return-Path: <linux-wireless+bounces-17507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65C0A11034
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3435164F35
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32C1FBE9F;
	Tue, 14 Jan 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGRkV/MH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D721FBE8F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879657; cv=none; b=mFx7ordwMYs322GAy+CgXlBGDp/B3YlsjO9dYMmvSmHfQSyOWidt900USCCQzwDgOYz0n2rm6s4AiTWBGZBdXk+j9wn8+QdftSaDlGRs4hsOWnUB63JrL6DpA5uJq1ziD8yDXDoKaR+jXOE32ODxPUH2WvkhbyteT5N7CZHn87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879657; c=relaxed/simple;
	bh=mr01IQU3yPNQBizG0iTYQGWw3rNWxN4dV5uwfxSBcJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3QYpSAnKLZ7ML2IYFa+YnHypSnYbZeDUQJqdT/EvDaoezz2yB+wX8qqOTNjZ0A+EO9FUIcsmi5wLwFVoMOUBMPYRfXNcFfN9bZtaJffIqiCzKlO97+x3UNizoe1g5SDDQS8eIqBDwHL8jMVY6mY0UIHp5CJk4+i58NG5PrVerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGRkV/MH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736879655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr01IQU3yPNQBizG0iTYQGWw3rNWxN4dV5uwfxSBcJg=;
	b=WGRkV/MHUh4M4lqIApfed56ck5WzilJ3wp014pAV1mUlwm2kxWxEb5+tcrudE61m/f/ext
	U6HqeKQifFpYrOtl9DuNzHiqewYHaZ6/cCKKrszU+Hno0F0PG0FK3Dt5etjSk40Lr/Rftc
	l9mKDvdNQ/KkCwFQXuMe1stPufVM0Tw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-h3KCTtdpP-eXh0RrI1je-Q-1; Tue,
 14 Jan 2025 13:34:11 -0500
X-MC-Unique: h3KCTtdpP-eXh0RrI1je-Q-1
X-Mimecast-MFC-AGG-ID: h3KCTtdpP-eXh0RrI1je-Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CB521936D17;
	Tue, 14 Jan 2025 18:34:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0F641955BE3;
	Tue, 14 Jan 2025 18:34:06 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_cjhuang@quicinc.com,
	jtornosm@redhat.com,
	vbenes@redhat.com
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Tue, 14 Jan 2025 19:34:05 +0100
Message-ID: <20250114183405.60530-1-jtornosm@redhat.com>
In-Reply-To: <20241211174155.30782-1-jtornosm@redhat.com>
References: <20241211174155.30782-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

How is this going?
Could you tell me if your proposed interface combination (or any different
solution) is going to go ahead?

Thanks

Best regards
Jose Ignacio


