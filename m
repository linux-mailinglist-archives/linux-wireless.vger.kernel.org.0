Return-Path: <linux-wireless+bounces-16266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AA19ED3DB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C4C2861B5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 17:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005924632C;
	Wed, 11 Dec 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmX054zX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64CC1DE2BA
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938929; cv=none; b=aErtptgbkmzb32WZFzVbT7VArDL+Dlnrj/FMNcxOPujpaMqoE+P32TnB/FN97OdZ3WrPHWzVRYSayplgkoxA0b3Vfyf+loXn6c5Rj8szbLhiT91KRyWaOOTnDXQo7jB14ungo4IX+1WeXPvQxoJUWlXH15ewi+siErJJVYRK5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938929; c=relaxed/simple;
	bh=qXu8dTjdB54vg2eNS9OB9yQqJWpu/QszOFjUbU7yuXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNZlBWKR6OwNEo8YOs6feCcP+EIhZzTU+3r4Sp7KIsGxJ8F6KDThMc3peJDeXKR3Ve3TMZs/RSkfPi3lR8nkc6lgf7sms84yAV877XK7u4JCZ2O/p5y+hbhYV2DY2pGIC2n7EC7QUQNDch4reT5r2zuX++arXOjShZy86y/B0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmX054zX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733938926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXu8dTjdB54vg2eNS9OB9yQqJWpu/QszOFjUbU7yuXI=;
	b=bmX054zXFU9f+vJgJfE/h9WS30fZs9LPw/T9R8eXUKSyBJhlng/YQc3Awfo/xyKc/2KLZ2
	mDbqzGtTHT7mpE8Mvi5JoAgiV29LGdS0F3KbPheQ4gUhOPCmYmfsL8v44FTPxcbCJo6e8t
	IkTHIl19EWNmy13xnJeSKEmI7L5wTfc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-uJzm67B0MeOQ3jz9N9ZhFA-1; Wed,
 11 Dec 2024 12:42:03 -0500
X-MC-Unique: uJzm67B0MeOQ3jz9N9ZhFA-1
X-Mimecast-MFC-AGG-ID: uJzm67B0MeOQ3jz9N9ZhFA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1BD71955F28;
	Wed, 11 Dec 2024 17:42:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 202C719560AA;
	Wed, 11 Dec 2024 17:41:56 +0000 (UTC)
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
Date: Wed, 11 Dec 2024 18:41:55 +0100
Message-ID: <20241211174155.30782-1-jtornosm@redhat.com>
In-Reply-To: <d8705140-e335-47e0-ac70-47d8592fb18c@quicinc.com>
References: <d8705140-e335-47e0-ac70-47d8592fb18c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

> Got it, you use Networkmanager, so that the add interface type will
> always be managed. But it's still work fine in my device that I use
> "hostapd hostapd2.conf" to up the second ap.
Yes, it works for you because you don't have a manager and/or your initial
situation was clean and/or without other needs/services.

For us it was enough to be able to come back to the initial interface
combination, but it seems that you prefer to have a common configuration
for everything.
So, since I think it is your final intention, please, go ahead with your
proposed interface combination and then I will debug myself to try complete
and/or reuse in some way.

Thanks

Best regards
Jose Ignacio


