Return-Path: <linux-wireless+bounces-16025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC39E8CF9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 09:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D8F18824E3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867321506F;
	Mon,  9 Dec 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOS6csRl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE821505F
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731427; cv=none; b=BxOWzzRwajZd7vDRLydI3LUmmCoElUZZHtC22+sV4XH2uA7a85bcMntIn4d03WytPPXU+323moHd6slYsP68AYhvlmG3xO5zJhTVfMd1LCEaQ0ksQry7IhrZkQriYonwXKaoOmmHOGnUO9Jj5ebAo9TWnoNgQyGMsLFkYCe0jtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731427; c=relaxed/simple;
	bh=mV6ov3sFgpt7rgCC6Pvrp/3B/vFOn5GJ/ODx71pgw1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7oBZ2HkTkgIDSJTFWesNmZVoz2pRApW2Bvm/kwD92j6RlIokG8LLt/q4hHmuHByzKWxEnZSnJoFE2/4a+5VcBpTv6OtsmqMQnSP/4WiW6hkR3CgKuEZkR3PD5C3EqrJ37AtJMUI480R7+SpBZPLlmzJhVQ6pQ1mKilNbjIg8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOS6csRl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733731424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mV6ov3sFgpt7rgCC6Pvrp/3B/vFOn5GJ/ODx71pgw1c=;
	b=eOS6csRlhu4yjKUW2ysVzBCxKkvRbmpeuJjM4lHhwZGS+YEznk+1SZklx8XwgdXmtfJmAE
	qbkLv9rUeW5XrJRiK0LW8+KV0WbQyUJ67W6YwjDAuqAPcUvmBBNMmDUBcBNmWImSILaNdD
	+OgvtmCcbfUzY/Av/kUEmsg+IImMSaU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-TTUgGWDePXyyFS5-S_VJzQ-1; Mon,
 09 Dec 2024 03:03:41 -0500
X-MC-Unique: TTUgGWDePXyyFS5-S_VJzQ-1
X-Mimecast-MFC-AGG-ID: TTUgGWDePXyyFS5-S_VJzQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 906811954B39;
	Mon,  9 Dec 2024 08:03:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.253])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFB03195606C;
	Mon,  9 Dec 2024 08:03:35 +0000 (UTC)
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
Date: Mon,  9 Dec 2024 09:03:34 +0100
Message-ID: <20241209080334.5989-1-jtornosm@redhat.com>
In-Reply-To: <1123551c-1a6d-4d0d-b3c7-f65c15509280@quicinc.com>
References: <1123551c-1a6d-4d0d-b3c7-f65c15509280@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

> So you can't up with ap type or can't up with managed interface?
Please, let's go to focus and not repeat the same, due to the reasons
that I commented before, I can't up my scenario with aps using your
proposed inteface configuration.
I am going to remark again, I can do it with the old configuration
previous to the commit f019f4dff2e4 ("wifi: ath11k: support 2 station
interfaces").
Thanks to my patch after 019f4dff2e4 ("wifi: ath11k: support 2 station
interfaces") by means of a parameter I can do it too.
And that's all.

Thanks

Best regards
Jose Ignacio


