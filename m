Return-Path: <linux-wireless+bounces-15996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C361A9E84F6
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2024 13:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68060281692
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F7142624;
	Sun,  8 Dec 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6ZXlYea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381105A4D5
	for <linux-wireless@vger.kernel.org>; Sun,  8 Dec 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733660014; cv=none; b=oMGu/B2PjadZr3zIJRb5BROD5ATydLAuqTIiKIt9u0CxoY8G9xwWggoHWxy+xDWwImISZLvCYQ9OjqE9XN52B3kRFYT6exIbHZSdHq4j8v+qCwruvnRULRk0gZutcyEH9QWIMdz4larOvKM6OPJiJxe/AdMninQq93fsREMYu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733660014; c=relaxed/simple;
	bh=9k55SSvilJwIU2K6+1S00Q1l/GJx19QY0LEzQMQV8wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIEzdjphXPgWLnKv/CUVWQrJTz4gAuAEV0uujLg0siH98YagU/2zHbXGouU18BNBxrzKUvSTQ+jz8bnQSZqVOmsgBCf2IXQ+P7zcv6XpMcEsjkIfPC3n7uCXj8TrdGSY51yjbQkgTxoqi9ABizdlVWDiNfp71adNkFobyUSV1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6ZXlYea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733660012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9k55SSvilJwIU2K6+1S00Q1l/GJx19QY0LEzQMQV8wY=;
	b=T6ZXlYea99CTNHNNgEoS/hy2INr0RaXx+XIKcKeRVL/M1F/oK89MbFrqUdnSmTPQm0zAUG
	aRCamIukMt3PHD2txdnjl6o1oLZWqgc/U1iDOUQoVcR+gvYyheqbcGE/xYERRlvLGTIcqk
	09c0qNCPtY63W3hM1iQqMkaw8Qqfm70=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-KL5y-vUDPw6ByRwbPHd4WA-1; Sun,
 08 Dec 2024 07:13:28 -0500
X-MC-Unique: KL5y-vUDPw6ByRwbPHd4WA-1
X-Mimecast-MFC-AGG-ID: KL5y-vUDPw6ByRwbPHd4WA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EBA919560AB;
	Sun,  8 Dec 2024 12:13:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED13E1956095;
	Sun,  8 Dec 2024 12:13:22 +0000 (UTC)
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
Date: Sun,  8 Dec 2024 13:13:21 +0100
Message-ID: <20241208121321.9760-1-jtornosm@redhat.com>
In-Reply-To: <0f24e115-e76d-4c8a-8a1b-591a157ee78e@quicinc.com>
References: <0f24e115-e76d-4c8a-8a1b-591a157ee78e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

>My point is that you can try setup with ap type interface,
This is what I am doing!
> now combination limits not allow up 3 inferfaces with managed interface.
Why? The limits were bigger previously.
Why cannot allow the old configuration (previous to the commit f019f4dff2e4
("wifi: ath11k: support 2 station interfaces"a))?
In another way, your proposed configuration is limited for me.

Thanks

Best regards
Jose Ignacio


