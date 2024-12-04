Return-Path: <linux-wireless+bounces-15880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E49E34C4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 09:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB160286628
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 08:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C516A395;
	Wed,  4 Dec 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejoa8v2p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325AF18C03B
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298700; cv=none; b=qgEwFod0Q+Q4Yn8o6IoQ7sbUO8g2GUTQLpRahoekpc+JkDhZNjPVFmA53sNw43uomb0L4YzFVYxi0xjlhlCHVkkhdHk4WErK8HN6KRC6b9o0rXpVt/agEW9UO23XThRL346rgcXzg8jgDIejS6Uh2axRQiHG0IFW4vFEmL58UZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298700; c=relaxed/simple;
	bh=bMPlDcMTvklLGUqdB23Lhw7hkot3vAYqtdh06AJIu/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq5Sohc+Wrk0ZO0jfDFzBQDvDpulCUYrVXk1f69lOYX3VaUmXJ+cxZZa01ToID+bTfytVReNyRaYwKyODX9mMeGESz63WrKknSL+7bTapGGHoeRBnKufyixQiI08q4yPYqHbOoAxTfM0tsiAmV9ADKvhZgGiGjHSoChtPwjL+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejoa8v2p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqZFUty/mjDCNR25W6enLMiHQiV9Cyufu+nDyyZ+4M4=;
	b=ejoa8v2p+BLIrR4l2bpVF3SHoIPl7/2rQLgAY6P3tkKpG2bakVWMEcamq2uiMZk0wjW1bF
	XmOnSoxejKzwCVnppkWSISVgnXbMm0SzBPl08roTz8t8MaNRS/U3VM0SXY4DxGfLwayJED
	PT1FJ5Nw2vBkHe6v+o+ccvlK5973GNE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-JLJmxmK_NBqgyCGoqfB5ZQ-1; Wed,
 04 Dec 2024 02:51:35 -0500
X-MC-Unique: JLJmxmK_NBqgyCGoqfB5ZQ-1
X-Mimecast-MFC-AGG-ID: JLJmxmK_NBqgyCGoqfB5ZQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C09D91956054;
	Wed,  4 Dec 2024 07:51:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.181])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 147CD3000199;
	Wed,  4 Dec 2024 07:51:29 +0000 (UTC)
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
Date: Wed,  4 Dec 2024 08:51:28 +0100
Message-ID: <20241204075128.5547-1-jtornosm@redhat.com>
In-Reply-To: <1b09c2c9-53bd-4960-b09c-7468f506b0a3@quicinc.com>
References: <1b09c2c9-53bd-4960-b09c-7468f506b0a3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

> Pls try add interface with type __ap or directly use hostapd up the ap 
> interfaces that will re-type managed to ap.
This is what I am doing.

> f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces") update about 
> interface combination limits.
My patch by means of a parameter allows to come back to the original
interface combination (before f019f4dff2e4 and not the current one that
you comment), so as I commented, this is the interface combination that 
I am finally using to setup the two APs:
# iw list | grep -A4 "valid interface combinations:"
 	valid interface combinations:
 		 * #{ managed } <= 1, #{ AP, P2P-client, P2P-GO } <= 16, #{ P2P-device } <= 1,
 		   total <= 16, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz }
 
 	HT Capability overrides:
And I repeat that with that, my setup is working (no error log).

> If chip support DBS, station interfaces max is 2 that why you can't up 
> the 3rd managed type interface. You better add interface with ap type.
Ok, but as I commented this is what I am doing.
Just to clarify, only with your proposed interface combination I am getting
problems with a 3rd managed type interface.

> 2.4GHz works fine also.
That is great.

Ok, at this point, as I need my setup, in order to allow me to debug and
get the differences, could you share how you are configuring the two APs to
test and debug here?

Thanks

Best regards
Jose Ignacio


