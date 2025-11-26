Return-Path: <linux-wireless+bounces-29355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED086C88DAF
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 10:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0C03B7803
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C131B136;
	Wed, 26 Nov 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMbX+hq3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BF30BF74
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147980; cv=none; b=ZDekQU+iyAWcadkLHMx3OhMpwbYPsnBs7noDG+CtzDxd/Mj576cjhKWRgK3Cq3f+yHv4WFTYKAPuhb5MV6WXBFCCGxbrwMhC7jRnLpb6KaAEGMxWcT63KEepVBW3A+uenBMR7G9yjLazhALhm75vqzxdKLpVLlUE/i9dLXjdmHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147980; c=relaxed/simple;
	bh=I9Ri1PracdZ1fJe4nS3ujf0EeS77sXRQQAptepOvuD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UV82298k2pdR8WhVxcH3jyzEvK6pSgcrIrjCc8rd56MR3xUwhkvxC61EnsM1nTgPrBUx+hgKQBq2rgNm3+lIVlfIgby/3/sYYbzPR2GHlP4n6TdaL1g1TRW0AAayTTEjapOoxN6F0XgAZdtEY9TnFm8dJXSQneKiXLnaucMSJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMbX+hq3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764147977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTaRG5tUTOuePrORNx7q7PbmJfAbd1diwzqk5Vh/dp0=;
	b=SMbX+hq3Jp7TcAyTRMSO6wDUnPcFuehUcn/ToCYJorlzEFwGYGcsLe6xFSAaGFxOh+CX2J
	UA6zyRZCJOcdHKaBtKx9ymLjgyI8thWGCr7eUC8D2XUy6eV5sdCip5EA1ycT87BB0OqPZ3
	tpzADB7P53k1zlS2y7JIhfiP3Oac9Nk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-p0tQMKk0PlCpTRsoKxfdVg-1; Wed,
 26 Nov 2025 04:06:14 -0500
X-MC-Unique: p0tQMKk0PlCpTRsoKxfdVg-1
X-Mimecast-MFC-AGG-ID: p0tQMKk0PlCpTRsoKxfdVg_1764147973
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFF4E19541AD;
	Wed, 26 Nov 2025 09:06:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.32])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 823931800451;
	Wed, 26 Nov 2025 09:06:10 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: pkshih@realtek.com
Cc: jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw89: 8922a: set random mac if efuse contains zeroes
Date: Wed, 26 Nov 2025 10:06:06 +0100
Message-ID: <20251126090608.7781-1-jtornosm@redhat.com>
In-Reply-To: <25d22682d36444cf8093076bf551a50e@realtek.com>
References: <25d22682d36444cf8093076bf551a50e@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

> I think rtl8952ae is NOT a typo, but it is surprising me that this driver can
> bring it up. Does it really work well? And where did you get the hardware?
Sorry, it is a typo (I was checking other realtek cards too at the same time),
I have some rtl8922ae:
# lspci -nn
...
07:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8922AE 802.11be PCIe Wireless Network Adapter [10ec:8922] (rev 01)

And yes, it really works well (only the mac with zeroes).
The hardware comes from a normal provider.

> I think rtw89_info() is more suitable.
Ok

> Need a '\n' at end of the message, and you missed a space after comma. 
Ok

I will send a second version of the patch with this.
Thank you for reviewing

Best regards
José Ignacio


 


