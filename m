Return-Path: <linux-wireless+bounces-17548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CEA1221A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 12:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C413A32E8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF971E98EE;
	Wed, 15 Jan 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIqTv9I0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC9248BDF
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939193; cv=none; b=Y3tmzhdXuFQkBrYndrrgVA57J1d1iQvm+ccnzZw1JY+h52F5d191wWD4l0W6xALY9JhUyxSTNNt0hACxRGv+2JUowBV/Fv76JPGSLxElj74IGVq3EmoZ9KiJHBUUT0B4fSM00X2m6s8Ug8uOz/6YUjd6+uuddscLChO74jRg/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939193; c=relaxed/simple;
	bh=hSuBcyrIiocPptm8Y5otPG1ERSmPfpYHXzYVlnWzqY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2T5FVkH2TzXxg8omq2OfKrbgq+FvpNi+oGDHfJ3fVOHDDIXaoth6+Vm5OHFp8AXHfDbTkB/2utCtfBJu1kdMfAHWYc80lI6lLpuxidJA6HyW6spL/cKHnWhw2jenQe2Sm3hO68lrIG8Rqk/CidQl8Urpa4QTC3WwwQjBKP3Tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIqTv9I0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736939190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSuBcyrIiocPptm8Y5otPG1ERSmPfpYHXzYVlnWzqY8=;
	b=VIqTv9I0sVfcXzhE+UQPPbWKILniFnlNKZxfL1aV1csEA7RfZvB+Zf/q925cbcO8WSbrSQ
	5OlZ0C2dp/+gABMokQnAy8SLS/M7pvs6B5rbBdA3HAo07Ny1RnDCOOeZUaH6KVfLs2foDM
	rThLeJyIeEdHf78Rg+XlpdFWhehMQmA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-ODsRmIcUPXi4Zg68X6wMkg-1; Wed,
 15 Jan 2025 06:06:29 -0500
X-MC-Unique: ODsRmIcUPXi4Zg68X6wMkg-1
X-Mimecast-MFC-AGG-ID: ODsRmIcUPXi4Zg68X6wMkg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ACB01956055;
	Wed, 15 Jan 2025 11:06:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.171])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8769E19560AE;
	Wed, 15 Jan 2025 11:06:24 +0000 (UTC)
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
Date: Wed, 15 Jan 2025 12:06:21 +0100
Message-ID: <20250115110621.134716-1-jtornosm@redhat.com>
In-Reply-To: <1090a0e4-6a19-422f-83ad-4566e5c86015@quicinc.com>
References: <1090a0e4-6a19-422f-83ad-4566e5c86015@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Yuriy,

Buff ... again the same that was already in the thread ...
As I commented, if you want to have a common interface combination, please
go ahead with yours, and then we can see on our own.

Thanks

Best regards
Jose Ignacio


