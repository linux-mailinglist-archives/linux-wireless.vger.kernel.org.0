Return-Path: <linux-wireless+bounces-14171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B15D9A2BA3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 20:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E51C23145
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450E1DFE06;
	Thu, 17 Oct 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx3nQy3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2E1DFD8B
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188308; cv=none; b=o/0eaxtwUQUWcW2990pHRwSqyk7TUSTdH1u7WP9ubB7SZtjJyg4Bw2pI3Ip50aSFnaq6ub9j0tkhu7goRGvjY35H56nfmyexmBwH6A5OeWKSMZvUSQ41JZzCDnuHWqK7P4kxS124hLkPrVyUISVBujaQ5ecTJt+DjHdUSj3eCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188308; c=relaxed/simple;
	bh=UEMwPbPjhOeCuGpW7CvJjh71+cV/9jSkHyqh/UfS9SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfEKE3iNLm3hEeJQ9e01zD+SRAGpL6ZQb0LxD2yKrMTETPyw9Pw0S6OHxU1vo/hg+hFOCKGSqemxREL9QOuBtKYVZh+3NmC2hRS0AYmfsWO6ML2ToersNnq1XXHgemGS86kffduATxPW9Gv8AocsemmoYedFxH/719uLMJyMSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx3nQy3m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729188306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEMwPbPjhOeCuGpW7CvJjh71+cV/9jSkHyqh/UfS9SM=;
	b=hx3nQy3mxjlBMPNJv6yz8gdJlEGtmsXlJK5S0nF9OYFj0ozYKFFxHkyddZrSWNxbD5CWPs
	LO7Gohk2oH7dndzOCXmsZymwb25Z1xVHg7bCEg/okU3DsOLgZD7Gx4w1oL3vVLZ8psF0rX
	qiZG+lcViKJFHEr1B8F0z1Lsk6OURN0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-nLPF2UYVOHu9s-shOmjP-g-1; Thu,
 17 Oct 2024 14:05:02 -0400
X-MC-Unique: nLPF2UYVOHu9s-shOmjP-g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8332319560A2;
	Thu, 17 Oct 2024 18:05:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.106])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7385F300018D;
	Thu, 17 Oct 2024 18:04:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 1/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 20:04:52 +0200
Message-ID: <20241017180456.199393-1-jtornosm@redhat.com>
In-Reply-To: <f9013f01-a61b-4697-a85a-60d70b6596db@quicinc.com>
References: <f9013f01-a61b-4697-a85a-60d70b6596db@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jeff,

> Your v3 patches look ok to me, however they are not showing up in Patchwork so
> I cannot act upon them. I suspect the issue is that you did not link them
> together (the 2/2 patch should References: the 1/2 patch). Better would have
> been to maintain a cover letter and have both the 1/1 and 1/2 patch reference
> that, just like you did in the "v1":
> https://msgid.link/20241010175102.207324-1-jtornosm@redhat.com
>
> Can you submit a v4 that follows that original pattern?
Sure, I will do as you say.

Thanks

Best regards
José Ignacio


