Return-Path: <linux-wireless+bounces-14137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743789A1BBE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 09:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE77289D5D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACA117BB03;
	Thu, 17 Oct 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRraA3w5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B539FE5
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150551; cv=none; b=MENTL852sFQo42pOur6gBYq5FvFgy9t7kdNcB45N3TOq71loSUm3C3GLElRfB2yggzlrzqg1zKGm5mZS8Uz/1ClWYZTu+GjyTy1QXnSderdpK5mZ7/yq6Mk7sYl3ySHHMQNQm97Zm9EoUlJLzUJ6A71ubiWw/w1QZJFP+o+nwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150551; c=relaxed/simple;
	bh=ekjP/+RTxRRpF924txgjW8HefsPRSKOo9PCJDVuif4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e29EVhuGLzmqxdC9V+qpqzCi6UMLVeGHKQU3KMuaoqub+P9rctQwhYeYgOSCBtQN2Ujk/sXTB4FGGPdm2BnwrpwjjZ+8eWSiCEikJ+HpktTn330l0dSq1j149EJWMgNCqWD6RCucbKbrgQYouPUlqmQCWL/jZ1VqgJeVhgVLM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRraA3w5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729150548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekjP/+RTxRRpF924txgjW8HefsPRSKOo9PCJDVuif4w=;
	b=IRraA3w5KJTtrOVjPWmzJ2YqZvJkgUQ0H8ttys5ahpLH33bQXMnj4aVheLHvL4AmND5MS9
	8fZza7VT4VmfZ0Y6jWYuRrcxS2i7EIcs+HEVsN6z+aZJjnYK/tYFBsYHHrddVGvrdVwrYj
	6FEM2J98Tx64a5KZGzpVEFfWITH+nhw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677--NNdpK-0Plq6hfaZ_JTfCw-1; Thu,
 17 Oct 2024 03:35:45 -0400
X-MC-Unique: -NNdpK-0Plq6hfaZ_JTfCw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B241955D91;
	Thu, 17 Oct 2024 07:35:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.60.16.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B46D19560A3;
	Thu, 17 Oct 2024 07:35:39 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 09:35:37 +0200
Message-ID: <20241017073538.176198-1-jtornosm@redhat.com>
In-Reply-To: <452ec614-7883-4e0f-ae0a-25d22d0be41c@quicinc.com>
References: <452ec614-7883-4e0f-ae0a-25d22d0be41c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jeff,

> FYI I didn't comment on this previously but
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages>
> has some guidance on trimming backtraces in commit messages.
Ok, I will trim the backtrace in a next version of the patch.
And I will fix the typos too.

Thanks

Best regards
José Ignacio


