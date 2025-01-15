Return-Path: <linux-wireless+bounces-17552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBCA1245A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 14:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F0D1692A9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB432066EB;
	Wed, 15 Jan 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6oaixEv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714D8F6C
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946251; cv=none; b=eIWrTmRvXlp8PVDoSLkdAyfLJpao6gGnweMvfPyriuEJXmr0LcUi7TieskyxyLRmAKcJq0MCvY72jDpHHGScoKfePs4qB2gU79Nokd8WnuGqUQyEnLv44PzCGJKw39DfHeuPPIWEQ9oWRyVCFH33SWhXLv6G5k7/2v15dJmfCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946251; c=relaxed/simple;
	bh=BIPi0LYR4jbUUm2a/97wNZOq6LKVgEAqIZ8/607KDYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrjZ3aI3vv5OuZ+ohWrLPk7XONGU1RENGg9vJz2N6/nzMxQnnWfDuIPNbk4IxLv/TCVoILesA3sXC4jynP+hPo6OGd511Ep9LcQMnYT6UXbxHOpD/JWPSZuxJivki33pT6dR9BgkK96lyH8xooGM99Or/FNA8ultxh6X3kmU2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6oaixEv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736946249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIPi0LYR4jbUUm2a/97wNZOq6LKVgEAqIZ8/607KDYQ=;
	b=I6oaixEvRjahjyBdCwXDgUm16Uq+1oHBCM0XvuKN/T0ui9E0ZYGS8LWQsROzkJA2IZOA7H
	+cRWnM80CjsapPtP0JeS4kj1WvzZr7JKxz1ZAxrTfwMfgIH1m0XXyfdFfWGnum7XkYHqmV
	8FMPA+XiV9FJlTfsLI5HyTJRTQdumfE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-WqJCVVQ5PvuGuwyK2Q3izQ-1; Wed,
 15 Jan 2025 08:04:06 -0500
X-MC-Unique: WqJCVVQ5PvuGuwyK2Q3izQ-1
X-Mimecast-MFC-AGG-ID: WqJCVVQ5PvuGuwyK2Q3izQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EE321978CA2;
	Wed, 15 Jan 2025 13:04:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.171])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C084919560A3;
	Wed, 15 Jan 2025 13:04:00 +0000 (UTC)
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
Date: Wed, 15 Jan 2025 14:03:59 +0100
Message-ID: <20250115130359.138890-1-jtornosm@redhat.com>
In-Reply-To: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
References: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Yuriy,

Thank you for the information.
My platform, as you said, is just wcn6855 hw2.1, but using NetworkManager
with the default configuration.
If this is the only stopper, you can skip and not consider as a wrong case,
because (sorry for repeating) it is just a matter of the number of available
resources that can be adjusted after some research from us.

Thanks

Best regards
Jose Ignacio


