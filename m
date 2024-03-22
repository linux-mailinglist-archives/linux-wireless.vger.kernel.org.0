Return-Path: <linux-wireless+bounces-5147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9210E886A7D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 11:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45BF1C20E87
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC33B2A8;
	Fri, 22 Mar 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwwPnSDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71762282FE
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103888; cv=none; b=mtcJ7uagGMuJ42KX5fJT1/pq/tKLZZWHoYnE4C2tU8AulvRHVQh11htiuZBYMPrqvGap2h7/WY27FFDu/l2iPgInJIZSVFI1DOGs15Q9+GIAUsUBYvvLsGgoHujYcRZ1Ut/ruLid5NvB2CBwwK82afMmz5ZkfPX3jFhY1XkjQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103888; c=relaxed/simple;
	bh=l4BqPVM87gJjFNn3Odmy/BJLvrQJMrIynptnhPUZvsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHFQtTxjwTbp+VShiVdOoz/JjWkFh9i04MLwFRIcpFPC4q6Tv+f40W/V773LEWFktjfGOt7Id6tP2pM1LMayhngQ+Gby23y5gVKLDJOhQ8xtZZ/tUwJDjm+VVer9GhWmQbHypXGqOPuYmlnlNL1ygFglyOb7JVR7tnLIeXFrxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwwPnSDz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711103886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4BqPVM87gJjFNn3Odmy/BJLvrQJMrIynptnhPUZvsk=;
	b=hwwPnSDzQSTwVMpCXnTW2aCUhVxAHH6i8usm5gCCQVnPTivYXDaNwkCo4JcmHiX6UKjSdC
	DFO7jodFhiDKEWZXeZWxwodmT2JI9qv7A0is7WMexId7cSgHhNBQooJA7izB9T2UodJ0dn
	V9EzMozxipWz4AEL/7laWFHhq7P5yyo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-WDxoLs2MOnOpqy38yxNsMA-1; Fri,
 22 Mar 2024 06:38:04 -0400
X-MC-Unique: WDxoLs2MOnOpqy38yxNsMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FDC53C025D9;
	Fri, 22 Mar 2024 10:38:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2D9C041EF;
	Fri, 22 Mar 2024 10:38:01 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_bqiang@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: workaround to use VMs
Date: Fri, 22 Mar 2024 11:37:53 +0100
Message-ID: <20240322103756.94296-1-jtornosm@redhat.com>
In-Reply-To: <87f0c6c9-43e5-4ea3-8f4c-9425e6a74b10@quicinc.com>
References: <87f0c6c9-43e5-4ea3-8f4c-9425e6a74b10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Thank you for your comments.
I don't have seen any change in MSI vector data but if it can be different from zero I will complete it.

Best regards
José Ignacio


